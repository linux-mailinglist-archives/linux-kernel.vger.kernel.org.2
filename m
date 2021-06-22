Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1787C3B084E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhFVPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhFVPMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:12:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2038B600D3;
        Tue, 22 Jun 2021 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374617;
        bh=0HDMdoBlUeZK0tFRZdne+++P8caT6G7FmLWZO2pSOwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2m9s7EgcYEWDpWVS1ouYfTMmjU6DGDg0hZYaCO2RVgcVTtwHTVA6qlOrB7xELQus
         UFIjmvZv2WusXaO5M8UWkUzzCe4M1YQQM/CxXXzr6NYDNj9+zMwuR7uLR7VIPRSyi5
         X66RUvg+WlZ+NXyL2yNroZWhfUdUxhs9vQuVUWUO39uSUnx2f3iyFyD5/LqYV+pSnF
         IkSvHUyJxSKw4HV4TI2Mp0+qKdaQ9uvtd7clCBBBOFM7ebrkGgEBKwmE1QcyQCUi74
         gcDg136qUEnhdhhMf4gVLGZ7k+E6xwq8WDioWg6rtKcc7ssAuKYxTooi6QNvkTAvuK
         LnNz8GzuLGv4A==
Date:   Tue, 22 Jun 2021 08:10:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Robin Hsu <robinh3123@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
        linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: Re: [PATCH] sload.f2fs: Reword "IMMUTABLE" in strings/comments
Message-ID: <YNH9V+gHPHkji1ah@google.com>
References: <20210611073111.947552-1-robinh3123@gmail.com>
 <20210622133357.GA1003@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622133357.GA1003@bug>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22, Pavel Machek wrote:
> Hi!
> 
> > Since the IMMUTABLE flag for compression is now changed
> > to F2FS_COMPRESS_RELEASED, some 'IMMUTABLE' words should be changed too:
> > 	1. sload help page
> > 	2. inline comments
> > 
> > Signed-off-by: Robin Hsu <robinhsu@google.com>
> 
> > @@ -650,7 +651,7 @@ void f2fs_parse_options(int argc, char *argv[])
> >  				}
> >  				c.compress.min_blocks = val;
> >  				break;
> > -			case 'r': /* compress file to set IMMUTABLE */
> > +			case 'r': /* for setting F2FS_COMOPRESS_RELEASE */
> 
> Typo.

Ah, fixed. Thank you~

> 
> Best regards,
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
