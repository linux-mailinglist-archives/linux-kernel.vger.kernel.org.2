Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB5936C709
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhD0NcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhD0NcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 790EE613D0;
        Tue, 27 Apr 2021 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530277;
        bh=x+00Plx6W6j0IA1acBr6uFRCu9IXD7Pjj4h7HJsIohg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQvhgvlqC57ChI4A4w8gBs4tpF48H2tr3sL3jkMT9mQJ6cW3YzibXarKfsD2AOOOa
         yHrH2+ILxtCtRVh+9jIZt4irF5jgp7wf0vwE3wRmjvMCjyFggh5StoOKhA+Ey+3mgF
         I6uLaECHrX5+vQrtrAanvWMEvJCy0oxlSmvsU4WI=
Date:   Tue, 27 Apr 2021 15:31:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 146/190] Revert "media: dvb: Add check on sp8870_readreg"
Message-ID: <YIgSIoBZ7pW78u2d@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-147-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-147-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:21PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 467a37fba93f2b4fe3ab597ff6a517b22b566882.
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
> Cc: Sean Young <sean@mess.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/dvb-frontends/sp8870.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/sp8870.c b/drivers/media/dvb-frontends/sp8870.c
> index 655db8272268..ee893a2f2261 100644
> --- a/drivers/media/dvb-frontends/sp8870.c
> +++ b/drivers/media/dvb-frontends/sp8870.c
> @@ -280,9 +280,7 @@ static int sp8870_set_frontend_parameters(struct dvb_frontend *fe)
>  	sp8870_writereg(state, 0xc05, reg0xc05);
>  
>  	// read status reg in order to clear pending irqs
> -	err = sp8870_readreg(state, 0x200);
> -	if (err)
> -		return err;
> +	sp8870_readreg(state, 0x200);
>  
>  	// system controller start
>  	sp8870_microcontroller_start(state);
> -- 
> 2.31.1
> 

This change looks to break the driver entirely, I guess no one uses it
anymore.  It should have checked for < 0 if it actually cared about the
result.

I'll keep this as it is not correct.

thanks,

greg k-h
