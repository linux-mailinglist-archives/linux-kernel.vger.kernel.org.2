Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569063B48A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFYSNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 14:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYSNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:13:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ECC761945;
        Fri, 25 Jun 2021 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624644677;
        bh=ljavae+JwaMWTTQ9gygPEjViWVs4hBz7ZeLQPoxemTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtBGEBiLA4QWxTwWKGcURCb6ZGAEdJW1tceujDj4yTvRZC971UrZvBafL3Xm8Qz6B
         FXDcDKImQrAIUPFeYjohdpyBqHJbGp0O0AotAWtvMOLxCwrXEVg7kQ/kHLQLAMeXuC
         AhEzn+dvPGwY/9nvm+n+hMrEa7E2Q3EAGkmVWv2lx18PYhT077sVjNXD4GU2olCxgK
         QV27lBaIb2QIyqHtLg3KAalFJCc5jhHoZkD+IXvC8MVC/0B2XOoN0ucGkPndJmjmlx
         5ob63RczVcAtATiPVtPHbVQLgTNxn83tx4whIgOEPt36xCYwIM+8grzWAVtSg9qeI+
         9a3PYOvU45rPA==
Date:   Fri, 25 Jun 2021 20:11:13 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Wu X.C." <bobwxc@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK
 ascii-art
Message-ID: <20210625201113.337b3ecd@coco.lan>
In-Reply-To: <b6ea891e-b6f3-318a-1b40-268f436c6860@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
        <20210625065524.GA11219@bobwxc.top>
        <20210625095059.7f97fd62@coco.lan>
        <ae0a7623-7ec4-937b-4b93-8435f2e94eb9@gmail.com>
        <20210625122423.4435c5e9@coco.lan>
        <b6ea891e-b6f3-318a-1b40-268f436c6860@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Jun 2021 20:32:47 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Fri, 25 Jun 2021 12:24:23 +0200, Mauro Carvalho Chehab wrote:
> > Em Fri, 25 Jun 2021 18:22:26 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> On Fri, 25 Jun 2021 09:50:59 +0200, Mauro Carvalho Chehab wrote:  
> [...]
> >>
> >> One minor problem might be that the Sarasa font needs manual
> >> download (and install).
> >>
> >>         Thanks, Akira  
> > 
> > If this is not yet packaged as part of texlive packages
> > on distros, this won't be a minor issue, as we'll need
> > to find procedures and test it for all distros supported
> > by the script.  
> 
> Existence of "Sarasa Mono SC" can be checked by the command:
> 
>     fc-list | grep "Sarasa Mono SC," | grep "style=Regular" | wc -l
> 
> If the result is *not* "0", you have the font somewhere in your
> fontconfig path.
> 
> I think this is portable across distros.
> Wouldn't this suffice for sphinx-pre-install?

No. The sphinx-pre-install tool generate a list of commands
needed to install the pre-reqs on a given distro.

For instance, if you run on opensuse without texlive, it would
print:


	# ./scripts/sphinx-pre-install 
	Detected OS: openSUSE Tumbleweed 20210515.
	Sphinx version: 3.5.4

	Warning: better to also install "latexmk".
...
	Warning: better to also install "xelatex".
	You should run:

	sudo zypper install --no-recommends texlive-latexmk-bin texlive-amscls texlive-amsfonts texlive-amsmath texlive-anyfontsize texlive-babel-english texlive-capt-of texlive-caption texlive-cmap texlive-colortbl texlive-courier texlive-dvips texlive-ec texlive-eqparbox texlive-euenc texlive-fancybox texlive-fancyvrb texlive-float texlive-fncychap texlive-framed texlive-helvetic texlive-luatex85 texlive-makeindex texlive-mdwtools texlive-metafont texlive-metapost texlive-multirow texlive-needspace texlive-oberdiek texlive-palatino texlive-parskip texlive-polyglossia texlive-preview texlive-psnfss texlive-tabulary texlive-threeparttable texlive-times texlive-titlesec texlive-tools texlive-ucs texlive-upquote texlive-wrapfig texlive-zapfchan texlive-zapfding texlive-xetex-bin

The same command, when executed on a different distro will
print a different set of packages and commands.

Thanks,
Mauro
