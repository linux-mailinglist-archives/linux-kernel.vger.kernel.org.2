Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4A320A74
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBUNMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:12:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:5610 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhBUNMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:12:17 -0500
IronPort-SDR: umgGLGP0XIg6+LlOTZKFwZpvqQMzY3rM7q2DmPUx4VkGaaMxL8aAOX1EcNr+bxC9zB9uE0pUX+
 HSzRY9tUHZXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="171892657"
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="171892657"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 05:11:36 -0800
IronPort-SDR: H4Fp9jDvq/8fcsQZdO+yXsDaNhI25W0/KzUnIxCNd5TexHo6bPOfdvrD4dONiJMOpFLPAFpyGf
 SXp5Q4RoGkqg==
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="401994269"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 05:11:35 -0800
Date:   Sun, 21 Feb 2021 21:11:33 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yejune Deng <yejune.deng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
Message-ID: <20210221131133.GC30008@shuo-intel.sh.intel.com>
References: <20210220145351.14464-1-yejune.deng@gmail.com>
 <714d4648-46d7-bc44-a9a2-5ce3c919897c@intel.com>
 <YDIRnrVYAGkYXcxp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YDIRnrVYAGkYXcxp@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 21.Feb'21 at  8:54:06 +0100, Greg Kroah-Hartman wrote:
>On Sun, Feb 21, 2021 at 09:50:42AM +0800, Liu, Shuo A wrote:
>>
>>
>> On 2/20/2021 22:53, Yejune Deng wrote:
>> > Use vfs_poll() is a more advanced function in acrn_irqfd_assign().
>> > as the same time, modify the definition of events.
>> >
>> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
>>
>> Thanks for the update.
>> Reviewed-by: Shuo Liu <shuo.a.liu@intel.com>
>>
>> Hi Greg,
>> Need i do more work on this patch?
>> Or you will review and apply on your tree directly?
>
>Please resend it to me with your signed-off-by on it.

OK.
