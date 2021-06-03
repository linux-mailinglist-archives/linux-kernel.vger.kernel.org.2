Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10237399FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFCLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhFCLhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26B5C613E9;
        Thu,  3 Jun 2021 11:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622720120;
        bh=Y8bFIkLifsKJfKnmVZNGcWbsdgZzBCGpasopTV0wxY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MAyr80K+yANWljCa8bkRcqqEyEi2ii+Vf+HrV+uw6luMwGp55ZOckMfMpjAgU61cQ
         LNYOjG9yxGYpWmO7G4+Zk3qH1ZsdewyaeveRSh/++Vht9drfCB4FJKOCyRlOP/C+IN
         kxtXddcwt2aYOYfHm/DcpRPtnRTEUo420tn3Xi/IJz3Cx7ihc4npLunVJfznOS/GIR
         DsRL8I41euKtXdprF4f6ahxz4IA036sMcMXEek7JhpGEu/gbgNfVP4CGxaY0bRZQTD
         4ewzfbYytVtgrnoJkjAa6bYwpcFn6YhU8OtA5qh+7gyPUH9ATnmuo7TigfSlksSaJO
         MRFVbZvXjmuTg==
Date:   Thu, 3 Jun 2021 13:35:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20210603133514.3688071f@coco.lan>
In-Reply-To: <871r9k6rmy.fsf@meer.lwn.net>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
        <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
        <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
        <20210602200121.64a828a1@coco.lan>
        <871r9k6rmy.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 02 Jun 2021 12:36:05 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > That's said, automarkup.py has a rule to convert Documentation/<foo>.rst
> > into :doc:`<foo>`. So, an alternative approach would be to convert
> > treewide all :doc:`<foo>` into Documentation/<foo>.rst and add something 
> > at checkpatch.pl to recommend to avoid :doc: notation.  
> 
> That seems like the right approach to me.  We have the automarkup
> capability, we might as well make use of it...

Hmm...

This patch caused a regression:

<patch>
PATCH] media: admin-guide: avoid using ReSt :doc:`foo` markup

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/admin-guide/media/index.rst b/Documentation/admin-guide/media/index.rst
index 6e0d2bae7154..5dbf6d02096a 100644
--- a/Documentation/admin-guide/media/index.rst
+++ b/Documentation/admin-guide/media/index.rst
@@ -11,10 +11,10 @@ its supported drivers.
 
 Please see:
 
-- :doc:`/userspace-api/media/index`
+- Documentation/userspace-api/media/index.rst
      for the userspace APIs used on media devices.
 
-- :doc:`/driver-api/media/index`
+- Documentation/driver-api/media/index.rst
      for driver development information and Kernel APIs used by
      media devices;
</patch>

This is the diff for the HTML output:

<diff>
diff --git a/admin-guide/media/index.html b/admin-guide/media/index.html
index 94c0cdf51579..28c083b75896 100644
--- a/admin-guide/media/index.html
+++ b/admin-guide/media/index.html
@@ -339,12 +339,12 @@ its supported drivers.</p>
 <p>Please see:</p>
 <ul class="simple">
 <li><dl class="simple">
-<dt><a class="reference internal" href="../../userspace-api/media/index.html"><span class="doc">Linux Media Infrastructure userspace API</span></a></dt><dd><p>for the userspace APIs used on media devices.</p>
+<dt>Documentation/userspace-api/media/index.rst</dt><dd><p>for the userspace APIs used on media devices.</p>
 </dd>
 </dl>
 </li>
 <li><dl class="simple">
-<dt><a class="reference internal" href="../../driver-api/media/index.html"><span class="doc">Media subsystem kernel internal API</span></a></dt><dd><p>for driver development information and Kernel APIs used by
+<dt>Documentation/driver-api/media/index.rst</dt><dd><p>for driver development information and Kernel APIs used by
 media devices;</p>
 </dd>
 </dl>
</diff>

It sounds that automarkup.py ignored it. Maybe because it is inside
a list?

Thanks,
Mauro
