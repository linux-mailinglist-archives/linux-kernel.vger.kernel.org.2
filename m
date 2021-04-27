Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55136C6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhD0N0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236078AbhD0N02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DEB360FD8;
        Tue, 27 Apr 2021 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529943;
        bh=s6ZW+NO3VBOj88mkft8uAM3px0yWjQ1xGuMM5Dw1NJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVwbwpu1OmTcRvezMTVieBQKvUEpbDD+9Y16r1e7c61e12EdM3afvJg/OkBvbwMxk
         yNkHPyZUXGEItQH9mDGqDEi7sfSuGwqO9xj1yKHwPH/JIOTry9Fm836gdQCfunJGPF
         EhktXC3U2HuDdCaD8hd6tfWVHXT2tFmvruxjHwlI=
Date:   Tue, 27 Apr 2021 15:25:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Matthias Schwarzott <zzam@gentoo.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 148/190] Revert "media: mt312: fix a missing check of
 mt312 reset"
Message-ID: <YIgQ1Y6uEuIUK27d@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-149-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-149-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:23PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 9502cdf0807058a10029488052b064cecceb7fc9.
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
> Cc: Matthias Schwarzott <zzam@gentoo.org>
> Cc: Sean Young <sean@mess.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/dvb-frontends/mt312.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
> index d43a67045dbe..1dc6adefb8fe 100644
> --- a/drivers/media/dvb-frontends/mt312.c
> +++ b/drivers/media/dvb-frontends/mt312.c
> @@ -627,9 +627,7 @@ static int mt312_set_frontend(struct dvb_frontend *fe)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = mt312_reset(state, 0);
> -	if (ret < 0)
> -		return ret;
> +	mt312_reset(state, 0);
>  
>  	return 0;
>  }
> -- 
> 2.31.1
> 

This could have been made much simpler:
	return mt312_reset(state, 0);
but as-is, is fine, I'll drop this revert.

greg k-h
