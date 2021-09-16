Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE040D581
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhIPJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:05:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59897 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236186AbhIPJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:04:52 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CBDB55C0213;
        Thu, 16 Sep 2021 05:03:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Sep 2021 05:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GZkDga
        6ssumhZQoFHGM4sdNqFoaPvBwApjIOon26ucg=; b=n0yZM/AuhRj4N4gfKHS277
        m7MmBUKdaLG9mTTqPr5Sg8ZFTOudNnok9diINmwxEmpCiLv+Pj4yXWcz7vVSEeRF
        +MmxddbSIeYVAtDbf3aVo8gukiOKKPQfW8te9RZ+FRbYRGGDu7C7pkbScGLR6ua/
        MNDlgwRx/R0UOytYssml/0iEqGN3mew3BUxKcn88hZra1JqoJQvS6HLopyIrHrsA
        GA7WK0zrdKjGY3ANcgGexqo6ARTFXtQmDY7PtkB6fc3uZLu7Pik8Nqz+RWVo8gUf
        MSt8S06BW+Q5h/wTcQyZbHAqsCs5PHMXdN7gypEZV9EnklBshh7d+KFXusbLIzBw
        ==
X-ME-Sender: <xms:YwhDYeEzimVZiUvFIDK9E5S9gy_SCBU-Vq9E2lBGtCxb9OKDBvAXZQ>
    <xme:YwhDYfVY1p-44RXqHAK6fQcurC5X2uF0afcjOZ0ilHy7I6k3-ULd4oQ3n6S1zixfE
    -gE9l8Ay90dD7I04GM>
X-ME-Received: <xmr:YwhDYYJWbBF9liW3vo0-HX5QfwSOzjE4W8GhKz6b-lsxlXtka1BdHqF97LSuRqxZRoMIGHYxBNGgFzAnJOjKUNMsWnfH5tSy0CFkOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehgedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepveefvddvhfeuvdeigfffteehvdeiheegjeeuheekudegjeefffeludekffei
    gedvnecuffhomhgrihhnpehngihprdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhr
    gh
X-ME-Proxy: <xmx:YwhDYYENlYGMOGt38szYt3YFpFjsUakOzpdVJuEK-t1DrcRTxFoHew>
    <xmx:YwhDYUVqyKPd7HEbMrpyGY_PMDNL91jbMJeocH3t2mvqmaNdfZRwNw>
    <xmx:YwhDYbPZURpdWG6aWm0vp-U6qlSJR2Wv3NWKuoDghDRQEpzK44Vb4A>
    <xmx:YwhDYRibmooYf897Fz1Czz5bYS7HisqnXPuU9Fyg43aSfZyAGS90cw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Sep 2021 05:03:28 -0400 (EDT)
Date:   Thu, 16 Sep 2021 19:03:15 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFT] signal handling fixes
In-Reply-To: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
Message-ID: <89b7f0e5-21a5-5828-1eb8-5119fb8e2d58@linux-m68k.org>
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021, Al Viro wrote:

> ...
> 
> PS:  FWIW, ifdefs in arch/m68k/kernel/signal.c are wrong - it's not !MMU 
> vs. coldfire/MMU vs. classic/MMU.  It's actually 68000 vs. coldfire vs. 
> everything else.  These days it's nearly correct, but only because on 
> MMU variants of coldfire we never see exception stack frames with type 
> other than 4 - it's controlled by alignment of kernel stack pointer on 
> those, and it's under the kernel control, so it's always 32bit-aligned.  
> It used to be more serious back when we had 68360 support - that's !MMU 
> and exception stack frames are like those on 68020, unless I'm 
> misreading their manual...
> 

I don't claim to understand this code but CPU32 cores appear to be 
unsupported on either #ifdef branch: the MMU branch due to CACR and CAAR 
used in push_cache(), and the !MMU branch due to frame format $4 used in 
adjust_format().

The CPU32 Reference Manual appendix says these chips only supports control 
registers SFC, DFC, VBR and stack frame formats $0, $2, $C. 
https://www.nxp.com/files-static/microcontrollers/doc/ref_manual/CPU32RM.pdf
