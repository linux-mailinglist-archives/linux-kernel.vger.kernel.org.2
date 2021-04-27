Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267D36C7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhD0Ojg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0Ojf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:39:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C1D961159;
        Tue, 27 Apr 2021 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534331;
        bh=XZLmlODuqxc+kF3P1e5ZRsnmBLARkp4iqXMtgysBUY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQi2uAmtBQBPVqZX8KQmzeN0FL2FKZDusPK0wyrFaPMGhKAvHIiKfW+qHsi1u/rIU
         K3UyS3jy1aBOLEdgKgn5HvjgPsgvsxnncLQwKlFf+ukwPBRcDShcdwveaRCDetc/6M
         rPQz9MuoJ/x844Frg2iR/CI9p9OWaupaWY32Jp5c=
Date:   Tue, 27 Apr 2021 16:38:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 109/190] Revert "usb: sierra: fix a missing check of
 device_create_file"
Message-ID: <YIgh+dlg3sqaeeRY@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-110-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-110-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:44PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 1a137b47ce6bd4f4b14662d2f5ace913ea7ffbf8.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/storage/sierra_ms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
> index b9f78ef3edc3..0f5c9cd8535f 100644
> --- a/drivers/usb/storage/sierra_ms.c
> +++ b/drivers/usb/storage/sierra_ms.c
> @@ -190,6 +190,8 @@ int sierra_ms_init(struct us_data *us)
>  		kfree(swocInfo);
>  	}
>  complete:
> -	return device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
> +	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
> +
> +	return 0;
>  }
>  
> -- 
> 2.31.1

The original change here was correct, now dropping this patch.

greg k-h
> 
