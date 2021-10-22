Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB314374C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhJVJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:34:26 -0400
Received: from server.lespinasse.org ([63.205.204.226]:60723 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJVJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:34:23 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-38-ed;
 t=1634895126; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=v7pI3qawdWzPGMg4BooM8Aef7F5nS3SFMl+ncAjnXdo=;
 b=svDpyBdeQbyWxQf0+jf41i005Spq5awAZHZnsuNPxa7amBd3K7Otpr2P0mUaNmQzuSZgs
 yUuROh5qsq8Qfd4AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-38-rsa; t=1634895126; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=v7pI3qawdWzPGMg4BooM8Aef7F5nS3SFMl+ncAjnXdo=;
 b=DjqeD6z54ab8+NdXujo37X+0Qma9tgviiIE/aMeifXu5c91iJA4shuEth6s5dFVzhsNnT
 5tzHM+aiqxPLtGm6UXvib72mLcum5Hni8zRBL5x9hN3yovUZwIOwQmURoiRqRgyWc5XGkYc
 +sc6nBbe+RjsQMoXPlW3XPlA7IoZzX4axrkL0mW8DoiMCx9jrs8CToPDl873adQRhzQYSOK
 TzCRAypNlJzpeFG3fY/n66v6x4IVGeng8Wm0/lQKstDspdDXfQ1B0J9tJQ/6uRATadYTTWM
 Z2vYxgjTxnT+3dfeuEZVJ+CFaxBQKa8cUY/X26EYBMYXTSPWpb6wQFDBqR5w==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 3D2FD16042D; Fri, 22 Oct 2021 02:32:06 -0700 (PDT)
Date:   Fri, 22 Oct 2021 02:32:06 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Mete Polat <metepolat2000@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rbtree: Test against a verified oracle
Message-ID: <20211022093206.GB12893@lespinasse.org>
References: <20211019091349.39788-1-metepolat2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019091349.39788-1-metepolat2000@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mete,

I have two questions regarding the approach:

- Has it been considered to compare the tools/lib/rbtree.c library
  against the oracle, instead of the lib/rbtree.c one, so that the
  test can run fully in userspace ? The two versions closely follow
  each other, is there a worry that results would vary between them ?

- lib/rbtree_test.c has code that validates the rbtree invariants
  (i.e. that all leaf paths have the same black_path_count, etc);
  is that significantly weaker than comparing the rbtree shape
  against the oracle ? My worry here is that, if one were to update
  the rbtree code in ways that preserve the design invariants, but
  result in a different tree shape, they would now have to reflect those
  changes into the oracle, which may be difficult if they are not too
  familiar with haskel ?

  (if validating rbtree invariants makes sense, it might still be
  useful to extend the lib/rbtree_test.c test case generator to cover
  more than random test cases, as you have done in your proposal...)

Thanks,

On Tue, Oct 19, 2021 at 11:13:47AM +0200, Mete Polat wrote:
> Hi,
> 
> This patch series provides a pipeline for testing the kernel Red-Black
> tree implementation against a verified oracle and is based on the work
> which we presented on the LPC [1]. A verified oracle is an equivalent
> algorithm that is proven to be mathematically correct. The testing
> pipeline consists of a kernel module that exposes the core rbtree
> functions to userspace using debugfs, and a testing harness that
> implements two strategies to generate test cases which are then applied
> on the kernel rbtree and the verified rbtree (the oracle). After
> executing an operation on both versions, the harness checks if the
> kernel rbtree is valid by partially comparing it to the verified oracle.
> 
> See the second patch for a description of how to use the harness.
> 
> Some notes:
> 
> The verified rbtree was verified in the proof assistant Isabelle [2] and
> is written in a functional programming language. That's why I also wrote
> the testing harness in the functional programming Haskell.
> 
> I decided to not try to integrate this work into kselftests because
> (1) Haskell (obviously) has another build system
> (2) The tests can run several minutes and would just slow down the
>     execution of all kselftests
> 
> There already is a decent rbtree testing module in the kernel. This work
> tries to address the issue of functional correctness using a more formal
> method and can be seen as an baseline for future (more complex) testing
> against verified oracles.
> 
> Regards,
> 
> Mete
> 
> [1] https://linuxplumbersconf.org/event/11/contributions/1036/
> [2] https://isabelle.in.tum.de/
> 
> Mete Polat (2):
>   rbtree: Expose a test tree to userspace
>   rbtree: add verified oracle with testing harness
> 
>  lib/Kconfig.debug                             |  19 ++
>  lib/Makefile                                  |   1 +
>  lib/test_rbtree_interface.c                   | 161 +++++++++++
>  tools/testing/rbtree_oracle/.gitignore        |   1 +
>  tools/testing/rbtree_oracle/Main.hs           | 128 +++++++++
>  tools/testing/rbtree_oracle/RBT/Kernel.hs     |  64 +++++
>  tools/testing/rbtree_oracle/RBT/Verified.hs   | 253 ++++++++++++++++++
>  tools/testing/rbtree_oracle/RBT_export.thy    |  41 +++
>  tools/testing/rbtree_oracle/Setup.hs          |   2 +
>  tools/testing/rbtree_oracle/Strategy.hs       |  72 +++++
>  .../rbtree_oracle/rbtTestHarness.cabal        |  15 ++
>  11 files changed, 757 insertions(+)
>  create mode 100644 lib/test_rbtree_interface.c
>  create mode 100644 tools/testing/rbtree_oracle/.gitignore
>  create mode 100644 tools/testing/rbtree_oracle/Main.hs
>  create mode 100644 tools/testing/rbtree_oracle/RBT/Kernel.hs
>  create mode 100644 tools/testing/rbtree_oracle/RBT/Verified.hs
>  create mode 100644 tools/testing/rbtree_oracle/RBT_export.thy
>  create mode 100644 tools/testing/rbtree_oracle/Setup.hs
>  create mode 100644 tools/testing/rbtree_oracle/Strategy.hs
>  create mode 100644 tools/testing/rbtree_oracle/rbtTestHarness.cabal
> 
> -- 
> 2.33.1
> 
