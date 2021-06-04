Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9739B7B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFDLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:14:50 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:53879 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFDLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:14:49 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 07:14:48 EDT
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 082DD3C00B5;
        Fri,  4 Jun 2021 13:05:09 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.94.223) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 4 Jun
 2021 13:05:08 +0200
Date:   Fri, 4 Jun 2021 13:05:03 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: Fix setting of device and driver data
 cross-references
Message-ID: <20210604110503.GA23002@vmlxhi-102.adit-jv.com>
References: <20210603171507.22514-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210603171507.22514-1-andrew_gabbasov@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.223]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 03, 2021 at 12:15:07PM -0500, Andrew Gabbasov wrote:
> FunctionFS device structure 'struct ffs_dev' and driver data structure
> 'struct ffs_data' are bound to each other with cross-reference pointers
> 'ffs_data->private_data' and 'ffs_dev->ffs_data'. While the first one
> is supposed to be valid through the whole life of 'struct ffs_data'
> (and while 'struct ffs_dev' exists non-freed), the second one is cleared
> in 'ffs_closed()' (called from 'ffs_data_reset()' or the last
> 'ffs_data_put()'). This can be called several times, alternating in
> different order with 'ffs_free_inst()', that, if possible, clears
> the other cross-reference.
> 
> As a result, different cases of these calls order may leave stale
> cross-reference pointers, used when the pointed structure is already
> freed. Even if it occasionally doesn't cause kernel crash, this error
> is reported by KASAN-enabled kernel configuration.
> 
> For example, the case [last 'ffs_data_put()' - 'ffs_free_inst()'] was
> fixed by commit cdafb6d8b8da ("usb: gadget: f_fs: Fix use-after-free in
> ffs_free_inst").
> 
> The other case ['ffs_data_reset()' - 'ffs_free_inst()' - 'ffs_data_put()']
> now causes KASAN reported error [1], when 'ffs_data_reset()' clears
> 'ffs_dev->ffs_data', then 'ffs_free_inst()' frees the 'struct ffs_dev',
> but can't clear 'ffs_data->private_data', which is then accessed
> in 'ffs_closed()' called from 'ffs_data_put()'. This happens since
> 'ffs_dev->ffs_data' reference is cleared too early.
> 
> Moreover, one more use case, when 'ffs_free_inst()' is called immediately
> after mounting FunctionFS device (that is before the descriptors are
> written and 'ffs_ready()' is called), and then 'ffs_data_reset()'
> or 'ffs_data_put()' is called from accessing "ep0" file or unmounting
> the device. This causes KASAN error report like [2], since
> 'ffs_dev->ffs_data' is not yet set when 'ffs_free_inst()' can't properly
> clear 'ffs_data->private_data', that is later accessed to freed structure.

I confirm there are at least two KASAN use-after-free issues
consistently/100% reproducible on v5.13-rc4-88-gf88cd3fb9df2:

https://gist.github.com/erosca/b5976a96789e574b319cb9e076938b5c
https://gist.github.com/erosca/4ded55ed32f0133bc2f4ccfe821c7776

These two can no longer be seen after the patch is applied.

In addition, below static analysis tools did not spot any regressions:
cppcheck 2.4, smatch v0.5.0-7445-g58776ae33ae8, make W=1, coccicheck

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

-- 
Best regards,
Eugeniu Rosca
