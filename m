Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCB403AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348970AbhIHNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhIHNuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C9B86108D;
        Wed,  8 Sep 2021 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631108949;
        bh=i95Q+Hu6kRLFQSUX18gJUCooiTYuHehfg9wwXqlSv6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZB58KX2TquCZCoeKebqqKF3FyArD17ZSbkX02Fn53HR0dpq53GhY0Ohj5/BKxmzwf
         rOUxk88dfWWrBMloZZ23ZpAzdZl/NId+O/eLQZmjUAUs4eTPskYkI8P+zt/60lD73u
         MNfNYgUALEPaQG9/01pMz0ss7AtyPd1vUCR2jxEA=
Date:   Wed, 8 Sep 2021 15:49:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Yu, Lang" <Lang.Yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTi/UxFCYKqdT34L@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi0xkTVYqUpKXSt@kroah.com>
 <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 01:21:16PM +0000, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
> >-----Original Message-----
> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Sent: Wednesday, September 8, 2021 9:04 PM
> >To: Yu, Lang <Lang.Yu@amd.com>
> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
> >linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs_emit
> >and sysfs_emit_at
> >
> >A:
> >https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fen.wikipe
> >dia.org%2Fwiki%2FTop_post&amp;data=04%7C01%7CLang.Yu%40amd.com%7C
> >fed047de547541548fcc08d972c92627%7C3dd8961fe4884e608e11a82d994e183d
> >%7C0%7C0%7C637667030534349355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> >MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&
> >amp;sdata=LHujj041jxZjvoYxVYUKtNr7us%2FX4pl%2FdOkFSOP1W8U%3D&amp;r
> >eserved=0
> >Q: Were do I find info about this thing called top-posting?
> >A: Because it messes up the order in which people normally read text.
> >Q: Why is top-posting such a bad thing?
> >A: Top-posting.
> >Q: What is the most annoying thing in e-mail?
> >
> >A: No.
> >Q: Should I include quotations after my reply?
> >
> >https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdaringfire
> >ball.net%2F2007%2F07%2Fon_top&amp;data=04%7C01%7CLang.Yu%40amd.co
> >m%7Cfed047de547541548fcc08d972c92627%7C3dd8961fe4884e608e11a82d99
> >4e183d%7C0%7C0%7C637667030534349355%7CUnknown%7CTWFpbGZsb3d8ey
> >JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> >1000&amp;sdata=AOLGBdj01XiEjhmsBSGTNuqejgU%2B6jg416Paz5XdM1A%3D&a
> >mp;reserved=0
> >
> >
> >On Wed, Sep 08, 2021 at 12:52:43PM +0000, Yu, Lang wrote:
> >> [AMD Official Use Only]
> >>
> >> Thanks for your reply.
> >> Just curious if we don't put such a limitation, what are the consequences?
> >> If we remove the limitation, sys_emit/sys_emit_at api will be more flexible.
> >> Since the comments of  sysfs_emit/ sys_emit_at api are " sysfs_emit -
> >> scnprintf equivalent, aware of PAGE_SIZE buffer. ", Why not make them
> >> more equivalent with scnprintf?
> >
> >Because this is not a general replacement for scnprintf(), it is only to be used with
> >sysfs files.
> >
> >Where else are you wanting to use these functions that this patch woulud be
> >required that does not haver to deal with sysfs?
> >
> >thanks,
> >
> >greg k-h
> 
> But some guys think it is a general replacement for scnprintf(),

Who thinks that?  Where?  The name should give them a clue that this is
not true.

> and  recommend that use sysfs_emit() instead of scnprintf(),

Please no.

> and send many patches that replace  scnprintf() with sysfs_emit(),
> and finally cause some invalid sysfs_emit_at: buf:00000000f19bdfde warnings.

Where were those patches sent?  I will be glad to review those.

> I think we better not put " scnprintf equivalent, aware of PAGE_SIZE buffer " words in comments.
> It is obviously not. Some  guys are misled by that. Thanks! 

Please feel free to add better documentation for the functions if you
feel people are getting confused, do not change the existing behavior of
the code as it rightly caught it being misused.

thanks,

greg k-h
