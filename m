Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FEB36CAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhD0SRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235647AbhD0SRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 140D6610A5;
        Tue, 27 Apr 2021 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619547422;
        bh=LumwNqHLJauMnAldWDWcGSi2oYMHXUaUXCIN5hjti64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/wSnG0xJn1BzLKxXYxy7mB4j6BsRFPM+BU0Iz48tD/EayfBVX3zfAY2p0+aEwAMr
         VMQxTj/0B/cr60KFc/cAHLiexBUfYj0pckTx4glIKwCvixzJKIieQsNHeTW2Dm7Mxk
         TiuiHbB848zC9w/px/cLMA0TFrkZ4Six56HNWPkk=
Date:   Tue, 27 Apr 2021 20:17:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 144/190] Revert "misc/ics932s401: Add a missing check to
 i2c_smbus_read_word_data"
Message-ID: <YIhVHBSIaxHFqniM@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-145-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-145-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:19PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit b05ae01fdb8966afff5b153e7a7ee24684745e2d.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/misc/ics932s401.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
> index 2bdf560ee681..733e5c2b57ce 100644
> --- a/drivers/misc/ics932s401.c
> +++ b/drivers/misc/ics932s401.c
> @@ -133,8 +133,6 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
>  	 */
>  	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
>  		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
> -		if (temp < 0)
> -			data->regs[regs_to_copy[i]] = 0;
>  		data->regs[regs_to_copy[i]] = temp >> 8;
>  	}
>  
> -- 
> 2.31.1
> 

While ackward, the original looks good enough for now, so I'll drop this
revert.

greg k-h
