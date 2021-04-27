Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9436C6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhD0N2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236120AbhD0N2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 917EB613D0;
        Tue, 27 Apr 2021 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530068;
        bh=GAjOrTcfxsNTbOF3j74qz/ghB9R16LiuThqeU3FROAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXYOF++8tbY4Ekh921zHVlAa0AbVfigjsBynH+g9Kx/+Gk74+2g+/XNnEmmi7tnWK
         zg4StMEnZl4YTanA+t998DOZRf5nc/kmiL10d7wMnPnACMzQ8zhVciBVL9diQsJIsn
         4WT61QTK6LHO+MjerliXXCA7Lgd+n4JbRM2bQtXk=
Date:   Tue, 27 Apr 2021 15:27:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 149/190] Revert "media: lgdt3306a: fix a missing check of
 return value"
Message-ID: <YIgRUVy51ppj32FT@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-150-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-150-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:24PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit c9b7d8f252a5a6f8ca6e948151367cbc7bc4b776.
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
> Cc: Sean Young <sean@mess.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/dvb-frontends/lgdt3306a.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
> index 722576f1732a..f34263a33ede 100644
> --- a/drivers/media/dvb-frontends/lgdt3306a.c
> +++ b/drivers/media/dvb-frontends/lgdt3306a.c
> @@ -1690,10 +1690,7 @@ static int lgdt3306a_read_signal_strength(struct dvb_frontend *fe,
>  	case QAM_256:
>  	case QAM_AUTO:
>  		/* need to know actual modulation to set proper SNR baseline */
> -		ret = lgdt3306a_read_reg(state, 0x00a6, &val);
> -		if (lg_chkerr(ret))
> -			goto fail;
> -
> +		lgdt3306a_read_reg(state, 0x00a6, &val);
>  		if(val & 0x04)
>  			ref_snr = 2800; /* QAM-256 28dB */
>  		else
> -- 
> 2.31.1
> 

Odd that this was the only fixup for this file, for this specific issue,
there are other places in this driver that this same change is needed.
That shows someone is not actually using a sane tool to create these :(

But it's ok as-is, I'll drop the revert.

greg k-h
