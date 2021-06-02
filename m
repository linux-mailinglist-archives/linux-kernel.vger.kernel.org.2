Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E839928B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFBSb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhFBSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:31:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C469C061574;
        Wed,  2 Jun 2021 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GLfgljhipoJ6gJykOC32O3aRArhVvkVH2qKU3Mkf3mc=; b=GkKu1TUv9L1sHyof7/i47Q4dBN
        WEh1/9uyLyrpcHVpHVb5RImYryXLTt0iWUEqsb6yMZHz/EXRR3QuJDtRulExZDY6v3A9BL7VKN/V8
        Oll5UluN4TEsTz88uqaIx64LaBNUeiP8q3Gq9dH3nod/J/fftED9KjJZanMNWx54z/7R8unZ4xnx1
        mMH39Pxc6OJi7lb16Sh53B+4dKItVEofsPqeJCQ1npXnh7HGkiUC17hAG7FbhWYPbTKL4fORNBSSK
        qjDV1P6jMw9H+QEQurdWnPIx3Ji4BYZU1PBkQrrZ1WHCEN3auvwl8D0vTGCF6XD6K8ZLY23gGRMjw
        F2ub2r3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loVcE-002x3V-Gh; Wed, 02 Jun 2021 18:29:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 158D7981228; Wed,  2 Jun 2021 20:29:24 +0200 (CEST)
Date:   Wed, 2 Jun 2021 20:29:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20210602182923.GC2458@worktop.programming.kicks-ass.net>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
 <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
 <20210602200121.64a828a1@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602200121.64a828a1@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 08:01:21PM +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 2 Jun 2021 18:38:29 +0200
> Peter Zijlstra <peterz@infradead.org> escreveu:
> 
> > On Wed, Jun 02, 2021 at 05:43:13PM +0200, Mauro Carvalho Chehab wrote:

> > >  Enables/disables task delay accounting (see
> > > -:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
> > > +:doc:`/accounting/delay-accounting`). Enabling this feature incurs  
> > 
> > This breaks any chance of using 'goto file' like features in text
> > editors :/ 
> 
> This is a feature of your favorite text editor. Not all have it.

Afaict both vim (gf) and emacs (M-x ffap) can do this. That covers about
99% of all sane editors no? :-)

> That's said, automarkup.py has a rule to convert Documentation/<foo>.rst
> into :doc:`<foo>`. So, an alternative approach would be to convert
> treewide all :doc:`<foo>` into Documentation/<foo>.rst and add something 
> at checkpatch.pl to recommend to avoid :doc: notation.

That sounds good, thanks!
