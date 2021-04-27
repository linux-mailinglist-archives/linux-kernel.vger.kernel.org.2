Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8336C961
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhD0QZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238039AbhD0QWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BE7261164;
        Tue, 27 Apr 2021 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619539939;
        bh=rw5bt2WGIYOK4tOkpbS0fGPf8sq1EDlW2gLyssfB1fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpAOGtkoAGlYY6zCcvB8yxCqSlFGG9Zfu7BqGhRvUhwd8mHD0rLiOZ0eQcY5J3uyp
         /Ee3+lfrpwqdResUeqO2vMKgt/FGnnJxwPrJ7+vpuuTLOjA6ISGTJEJPAA+C/BRu++
         dH1XZXR1iiG85L5Ye1qv5CSHr/sP7BLIzsFBG79w=
Date:   Tue, 27 Apr 2021 18:12:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
Message-ID: <YIg34SBa78u3KMNH@kroah.com>
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
 <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk>
 <YIgLIscB1I8MxkWP@kroah.com>
 <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
 <e2ee4904-b13b-fd75-7066-d28e5a7ca711@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ee4904-b13b-fd75-7066-d28e5a7ca711@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:39:15AM -0600, Jens Axboe wrote:
> On 4/27/21 8:03 AM, Peter Rosin wrote:
> > On 2021-04-27 15:01, Greg KH wrote:
> >> On Fri, Apr 23, 2021 at 08:20:30AM -0600, Jens Axboe wrote:
> >>> On 4/22/21 3:29 PM, Peter Rosin wrote:
> >>>>> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
> >>>>
> >>>> The reverted patch looks fishy.
> >>>>
> >>>> gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
> >>>> memory is kfree:d but the variable is NOT zeroed out.
> >>>>
> >>>> AFAICT, the above leads to a double-free on exit by the added line.
> >>>>
> >>>> I believe gd.cd_info should be kfree:d on remove instead.
> >>>>
> >>>> However, might not gc.toc also be kfree:d twice for similar reasons?
> >>>>
> >>>> I could easily be mistaken.
> >>>
> >>> >From taking a quick look the other day, that's my conclusion too. I
> >>> don't think the patch is correct, but I don't think the surrounding code
> >>> is correct right now either.
> >>
> >> Thanks for the review from both of you, I'll keep this commit in the
> >> tree.
> > Err, which commit is "this" and what tree are you keeping it in? I
> > think you mean that you are keeping the revert in your tree with
> > reverts, and not that you mean that we should keep the original
> > commit in Linus' tree.
> > 
> > In any case, I'd think that the original memory leak is somewhat
> > better than the introduced double-free and therefore the revert
> > should be done.
> 
> It should probably look like the below, though I doubt it matters
> since only one device is supported anyway. As long as the free
> happens post unregister, it likely won't make a difference. But
> it is cleaner and easier to verify, and should double device support
> ever be introduced, the existing code is buggy.
> 
> But given that, I don't think we should keep the revert patch.
> 
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 9874fc1c815b..02d369881165 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -831,6 +831,8 @@ static int remove_gdrom(struct platform_device *devptr)
>  	if (gdrom_major)
>  		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
>  	unregister_cdrom(gd.cd_info);
> +	kfree(gd.toc);
> +	kfree(gd.cd_info);
>  
>  	return 0;
>  }
> @@ -862,8 +864,6 @@ static void __exit exit_gdrom(void)
>  {
>  	platform_device_unregister(pd);
>  	platform_driver_unregister(&gdrom_driver);
> -	kfree(gd.toc);
> -	kfree(gd.cd_info);
>  }
>  
>  module_init(init_gdrom);
> 
> -- 
> Jens Axboe
> 

I'll add this fix to the tree after the revert, and give you the credit
for the fix :)

thanks,

greg k-h
