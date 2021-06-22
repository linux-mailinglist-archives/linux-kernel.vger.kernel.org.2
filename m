Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA4A3B05E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFVNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:36:17 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37562 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:36:16 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C50E71C0B76; Tue, 22 Jun 2021 15:33:59 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:33:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Robin Hsu <robinh3123@gmail.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org, linux-kernel@vger.kernel.org,
        Robin Hsu <robinhsu@google.com>
Subject: Re: [PATCH] sload.f2fs: Reword "IMMUTABLE" in strings/comments
Message-ID: <20210622133357.GA1003@bug>
References: <20210611073111.947552-1-robinh3123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611073111.947552-1-robinh3123@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since the IMMUTABLE flag for compression is now changed
> to F2FS_COMPRESS_RELEASED, some 'IMMUTABLE' words should be changed too:
> 	1. sload help page
> 	2. inline comments
> 
> Signed-off-by: Robin Hsu <robinhsu@google.com>

> @@ -650,7 +651,7 @@ void f2fs_parse_options(int argc, char *argv[])
>  				}
>  				c.compress.min_blocks = val;
>  				break;
> -			case 'r': /* compress file to set IMMUTABLE */
> +			case 'r': /* for setting F2FS_COMOPRESS_RELEASE */

Typo.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
