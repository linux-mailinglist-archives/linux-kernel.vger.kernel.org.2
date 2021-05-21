Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955F938C115
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhEUH4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhEUH4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:56:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA5636135B;
        Fri, 21 May 2021 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621583685;
        bh=q/Uy9Bki/OPO7BqB5Ad/aj1S8JOWQCXav+mJLUNTH3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bt/+atbMIe3qCOQt6SaZvqsnHyJB20KtXdG/eJH8hzxaIC2F+nZmGBFmr2uBQUGF5
         Gr6PlXp5UdgEWirc06ibXZNfoDCTYnnJQWQxr2ZhLfM3KirlMwqY0F1Dy8GW+HIOb7
         WqSDJsrPFUlYwLgV4gTIUzjzQrNOQErxoDokPUEFLhPRc201Hhn97CoukeiYz3p/qT
         BNdiVZAvDyEUUiUCMu0QGAs1sDuQpuhgcStW0cRejJ+xywIMjrsRRBWWo7Y32fA8fl
         AYCX3c8fTqSzlmPrN1bjoKJEYwp1Zt+eQ5fFs96x3evGUgaGWNcA1pxRvUYrgAFWkB
         llvTxQOzl4q5A==
Date:   Fri, 21 May 2021 09:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sphinx-pre-install: Reword warning on installing
 cjk font
Message-ID: <20210521095442.33957ff3@coco.lan>
In-Reply-To: <c5652bb4-0bb0-9efa-2b80-a79793a8efa8@gmail.com>
References: <c5652bb4-0bb0-9efa-2b80-a79793a8efa8@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Akira,

Em Fri, 21 May 2021 16:14:19 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Installing a ckj font as recommended by the warning message causes
> generated latex code to have:
> 
> 	% This is needed for translations
> 	\usepackage{xeCJK}
> 	\setCJKmainfont{Noto Sans CJK SC}
> 
> in its preamble even for an English document.

Yes. The same LaTeX configuration is applied to all documents.

While the standard Sphinx logic allows just one conf.py, there's
a logic on Linux that allows a per-directory configuration.
Perhaps it would be possible to set the font just for translations.

Yet, this can't be easily done per-translation - Italian
translation for instance doesn't need CJK fonts.

> The package "xeCJK" changes wide characters' appearance including
> apostrophe (single quote) and double quotes, and it changes line-break
> behavior with regard to the boundary of narrow and wide characters.
> 
> This greatly degrades readability of English PDFs typeset by xelatex.

Hmm... could you give an example where it looks ugly?

At least on the documents I use to check the PDF output, I was unable
to see any big issue.

Regards,
Mauro

> 
> As a band-aid help, reword the message and let the user at least be
> aware of the degradation.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> Hello,
> 
> I'm a newcomer to kernel-doc who started trying sphinx this week.
> I have both sphinx 2.4.4 and 1.7.9 installed.
> For pdfdocs, I use 2.4.4.
> 
> "make htmldocs" was fairly easy, but I struggled a while to get
> PDFs as I expected.
> 
> The culprit turned out to be the "xeCJK" package mentioned above
> in the change log.  It appears in all the generated latex files
> due to the "Noto Sans CJK" font I have installed seeing the warning
> message from sphinx-pre-install.
> 
> By uninstalling the font, I can now build the PDF as I expect.
> 
> The reworded message is just a band-aid help.
> 
> In the long term, I see that rst2pdf tool is your hope to avoid
> LaTeX altogether.  But it would be nice if you can enable xeCJK only
> for the translations document.  Can sphinx permit such language
> choice per subdirectory (or hopefully per .rst file)?
> 
>         Thanks, Akira
> --
>  scripts/sphinx-pre-install | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index fe92020d67e3..b3c7da2b8ad2 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -101,7 +101,12 @@ sub check_missing(%)
>  		}
>  
>  		if ($is_optional) {
> -			print "Warning: better to also install \"$prog\".\n";
> +			if ($prog =~ /cjk/ ) {
> +				print "Warning: For translations PDF, better to install \"$prog\".\n";
> +				print "However, doing so will *degrade* English PDF typesetting.\n";
> +			} else {
> +				print "Warning: better to also install \"$prog\".\n";
> +			}
>  		} else {
>  			print "ERROR: please install \"$prog\", otherwise, build won't work.\n";
>  		}



Thanks,
Mauro
