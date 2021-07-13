Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B092E3C75FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhGMRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:54:50 -0400
Received: from foss.arm.com ([217.140.110.172]:48302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhGMRys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:54:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C7B1FB;
        Tue, 13 Jul 2021 10:51:57 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94EA03F7D8;
        Tue, 13 Jul 2021 10:51:56 -0700 (PDT)
Date:   Tue, 13 Jul 2021 18:50:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     James Morse <james.morse@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
Message-ID: <20210713175058.ckpxk7jtqdcr5mh2@bogus>
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
 <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
 <20210713132612.gvx7xpdp3tjcmxxu@bogus>
 <ee4db21a-e1cc-5847-d1fb-1d7735cf2164@arm.com>
 <20210713174818.oipjwqldkf3jlzih@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713174818.oipjwqldkf3jlzih@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I managed to accidentally delete 'o' in .com from James
email id earlier with my fat fingers I guess.

On Tue, Jul 13, 2021 at 06:48:18PM +0100, Sudeep Holla wrote:
> On Tue, Jul 13, 2021 at 06:38:15PM +0100, James Morse wrote:
> > Hello,
> >
> 
> [...]
> 
> > If you like. If there is nothing broken its hard to care.
> > I guess this helps people doing backports.
> >
> 
> Thanks James, indeed I was trying to avoid unnecessary backport.
> 
> Xiongfeng,
> 
> Please don't add any fixes and post the patch with my Reviewed-by, we can
> then ask Greg to pick. I am fine with the patch as is, it is nice to have
> as it ensures teardown is more complete but it doesn't fix anything
> in upstream or stable trees.
> 
> --
> Regards,
> Sudeep

-- 
Regards,
Sudeep
