Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4543D34C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbhJ0U5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:57:02 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:40560 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbhJ0U5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:57:00 -0400
Date:   Wed, 27 Oct 2021 16:54:32 -0400
From:   Rich Felker <dalias@libc.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
Message-ID: <20211027205431.GX7074@brightrain.aerifal.cx>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-3-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005001914.28574-3-rdunlap@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 05:19:11PM -0700, Randy Dunlap wrote:
> Add the git tree location for linux-sh.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3: new patch in this series
> 
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20211001.orig/MAINTAINERS
> +++ linux-next-20211001/MAINTAINERS
> @@ -18047,6 +18047,7 @@ M:	Yoshinori Sato <ysato@users.sourcefor
>  M:	Rich Felker <dalias@libc.org>
>  L:	linux-sh@vger.kernel.org
>  S:	Maintained
> +T:	git git://git.libc.org/linux-sh
>  Q:	http://patchwork.kernel.org/project/linux-sh/list/
>  F:	Documentation/sh/
>  F:	arch/sh/

I'm omitting this for now since (as noted on the cgit description)
this server is not provisioned adequately for cloning from scratch,
and should only be used for fetch into an already-populated mainline
repo clone. If that's a problem I can see about getting it moved
somewhere more appropriate.

The rest of this series should appear in next shortly.

Rich
