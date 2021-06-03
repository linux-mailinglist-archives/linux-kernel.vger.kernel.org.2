Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E616E399B68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFCHXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:23:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62718C06174A;
        Thu,  3 Jun 2021 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=66I4NRnZhUJDgS+W1gca0B6bCJmiMwU7hRNChS+Sijg=; b=RRv8S3jXWvFroS7pAyNa/XbDx8
        DbwTu67YKnKJLbqq7KTFUcyDUOQH7S5s2x2ZoEtjPwXKjGnhw5Gv9icIEPDYJtUXIrTSVV0Z++tcq
        UF0i9UhCY3FwUgwuUgrzj+MhVKMbr84BYA8E8q/eI73uMXiOgWpJR0CJWK1duOFUHAi+Z6q133cC4
        rQRd+QCWYtuWOBf/6QR1CgC3i00PkbP8LJsuV1rnAj7rm76sioxKQafhARCkCv3GL5Z/XVSlXiIz0
        o7F3xTPh1NEvT7kYkcuxDaE5tgToLa77yY4IdU5ovvmnsZTd6nE8pYR6ZfjOM0/PyuvcVyj6vz0Dv
        HJCj6F+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loheq-0035OQ-FJ; Thu, 03 Jun 2021 07:20:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4AAC300223;
        Thu,  3 Jun 2021 09:20:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83BAE20223DB5; Thu,  3 Jun 2021 09:20:53 +0200 (CEST)
Date:   Thu, 3 Jun 2021 09:20:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
Message-ID: <YLiC1bFKAf9RtwuB@hirez.programming.kicks-ass.net>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
 <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
 <20210602200121.64a828a1@coco.lan>
 <871r9k6rmy.fsf@meer.lwn.net>
 <20210602221940.7e0a6135@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602221940.7e0a6135@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:19:40PM +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 2 Jun 2021 20:29:23 +0200
> Peter Zijlstra <peterz@infradead.org> escreveu:

> > Afaict both vim (gf) and emacs (M-x ffap) can do this. That covers about
> > 99% of all sane editors no? :-)
> 
> Heh, not quite ;-) Here, I use nano(/pico), from the old times where 
> (al)pine was my emailer. I can live with vim, but I prefer an editor
> that starts in editing mode.

echo "startinsert" >> ~/.vimrc

> I tried to use emacs a few times, but my fingers are too much into
> pico/nano control keys, so it was ending by making me typing a lot
> slower. Besides that, nano works well on 99% of my daily needs. 
> 
> When I need more fancy, like regex substitutions, changing/moving
> big code blocks, editing multiple files at the same time, etc, 

nano can in fact do the multi-file thing, see nano -F, or add "set
multibuffer" to nanorc.

> then I just use a GUI editor (currently kate, but seeking for
> a good replacement, as some changes during F33 times - still 
> present on F34 - caused some regressions).

The fact that you need a second editor; and are looking for a
replacement disqualifies nano (and Kate for that matter) as a sane
editor IMO.

You can ofcourse start extending nano :-)
