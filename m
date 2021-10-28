Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC743E412
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhJ1OrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhJ1OrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:47:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737AC061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:44:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b71so5286658wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGRSjqZFqCVIRMkJoFMwFzKr/cM8vKjaY/rjiNOhaeM=;
        b=Dy4MVoKg34KIbPatORSLBJoHhI8SuezGe6kL1Gy92iYBMceane2IJU+yxENY0Ufgzo
         HnMeUs9/INV0b03aLMmznNDZbO0/CzqIKqer+dlDQETpwa3b3zGJ32b68rIxV+EnAxc/
         EnThmRLV/v0EizqG7IrQim9ZI/DAFS4CoIBi9zRd2FX2gNNfRHUh1pkUFLsRHPTzmkS5
         Q5MmTOC4heFJ/+FoaFCFLrmd7nO/rjQDCzFA0JkEVfb7sdkgHXmxSpEYeZdMATN6pWsa
         VCievgyPUEJ3nsLYhTD3IUWxmVsAG06rKDIXewBqEy/YSQQ44gdRVyXtITWyHCaEEeL/
         Fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGRSjqZFqCVIRMkJoFMwFzKr/cM8vKjaY/rjiNOhaeM=;
        b=gtsQQhf5VaAUfrwci8boSSkpMf3PtW7XGjnXbJ5cARzBOrW0gLGCiGnArBPm5HRg4W
         Y0yzpq+53/vZAbp6QuF9YJmb7EgXUOV/hTNIGlCrs/K6OqG2E0/25SkeSBDFJCbD6OPJ
         knZmxG4zB5snntJq44nWDR9S0FG2BSyHu9EkPwO74fSNGKTuIV3Wxa//b7hfNK8eyJOa
         G9suar/IofuAm5agE3Xmbe5xVvJ8AkeD+j4kKF4uqxkwr39Utf9abPzL0u7m8gnbp+Rs
         UrEVeyMXXccS3iM6CPACBMFNF+dKpNIr0SoDqLjhOGRTamHc5oDWM5A8MMfpaA7p9+kv
         4G9Q==
X-Gm-Message-State: AOAM532Mhw0KTBrOfIOTyCcKssZ8l/6mQxLyvMnTgZlg0UZhtAHikYI6
        vKFc5nRH8IKp8EzWd8xTyrs=
X-Google-Smtp-Source: ABdhPJzHeenf5adxqxHZv7P0EFnKIFUhhrrL7R1rvGxsv5vz38c5adHYZ6or2DzVfGoqnEWmPeh4qg==
X-Received: by 2002:a05:600c:3b82:: with SMTP id n2mr5110906wms.50.1635432275854;
        Thu, 28 Oct 2021 07:44:35 -0700 (PDT)
Received: from gmail.com (dhcp-138-246-3-118.dynamic.eduroam.mwn.de. [138.246.3.118])
        by smtp.gmail.com with ESMTPSA id k8sm6916619wms.41.2021.10.28.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:44:35 -0700 (PDT)
Date:   Thu, 28 Oct 2021 16:44:32 +0200
From:   Mete Polat <metepolat2000@gmail.com>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rbtree: Test against a verified oracle
Message-ID: <YXq3UB4n6bB5oekE@gmail.com>
References: <20211019091349.39788-1-metepolat2000@gmail.com>
 <20211022093206.GB12893@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022093206.GB12893@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michel,

On Fri, Oct 22, 2021 at 02:32:06AM -0700, Michel Lespinasse wrote:
> Hi Mete,
> 
> I have two questions regarding the approach:
> 
> - Has it been considered to compare the tools/lib/rbtree.c library
>   against the oracle, instead of the lib/rbtree.c one, so that the
>   test can run fully in userspace ? The two versions closely follow
>   each other, is there a worry that results would vary between them ?

No I have not considered that, mainly because I wanted to explore what
steps are necessary to test real in-kernel functionality against a
verified oracle and present an example testing pipeline here.

> 
> - lib/rbtree_test.c has code that validates the rbtree invariants
>   (i.e. that all leaf paths have the same black_path_count, etc);
>   is that significantly weaker than comparing the rbtree shape
>   against the oracle ? My worry here is that, if one were to update
>   the rbtree code in ways that preserve the design invariants, but
>   result in a different tree shape, they would now have to reflect those
>   changes into the oracle, which may be difficult if they are not too
>   familiar with haskel ?

The Haskell code also just checks if the kernel rbtrees satisfy the
invariants. While I originally also implemented the option to compare
the shape of the trees, I removed it again because there does not exist
a formal proof for the kernel rbtree delete algorithm yet and the
Haskell variant indeed differs from the kernel one. Currently the
verified oracle is then just used to check if the inorder of kernel and
verified trees equal but one could also check if the shapes equal when
just inserting nodes.

In general, one advantage of comparing shapes instead of checking
invariants is that the former one is faster for bigger inputs. However,
(in my opinion) checking invariants as lib/rbtree_test is doing is at
least as strong as comparing shapes from the correctness point of view.

> 
>   (if validating rbtree invariants makes sense, it might still be
>   useful to extend the lib/rbtree_test.c test case generator to cover
>   more than random test cases, as you have done in your proposal...)

This could be a good compromise. An exhaustive (but scoped) test case
generator like in the Haskell code would be a nice extension.

Regards,

Mete
> 
> Thanks,
> 
> On Tue, Oct 19, 2021 at 11:13:47AM +0200, Mete Polat wrote:
> > Hi,
> > 
> > This patch series provides a pipeline for testing the kernel Red-Black
> > tree implementation against a verified oracle and is based on the work
> > which we presented on the LPC [1]. A verified oracle is an equivalent
> > algorithm that is proven to be mathematically correct. The testing
> > pipeline consists of a kernel module that exposes the core rbtree
> > functions to userspace using debugfs, and a testing harness that
> > implements two strategies to generate test cases which are then applied
> > on the kernel rbtree and the verified rbtree (the oracle). After
> > executing an operation on both versions, the harness checks if the
> > kernel rbtree is valid by partially comparing it to the verified oracle.
> > 
> > See the second patch for a description of how to use the harness.
> > 
> > Some notes:
> > 
> > The verified rbtree was verified in the proof assistant Isabelle [2] and
> > is written in a functional programming language. That's why I also wrote
> > the testing harness in the functional programming Haskell.
> > 
> > I decided to not try to integrate this work into kselftests because
> > (1) Haskell (obviously) has another build system
> > (2) The tests can run several minutes and would just slow down the
> >     execution of all kselftests
> > 
> > There already is a decent rbtree testing module in the kernel. This work
> > tries to address the issue of functional correctness using a more formal
> > method and can be seen as an baseline for future (more complex) testing
> > against verified oracles.
> > 
> > Regards,
> > 
> > Mete
> > 
> > [1] https://linuxplumbersconf.org/event/11/contributions/1036/
> > [2] https://isabelle.in.tum.de/
> > 
> > Mete Polat (2):
> >   rbtree: Expose a test tree to userspace
> >   rbtree: add verified oracle with testing harness
> > 
> >  lib/Kconfig.debug                             |  19 ++
> >  lib/Makefile                                  |   1 +
> >  lib/test_rbtree_interface.c                   | 161 +++++++++++
> >  tools/testing/rbtree_oracle/.gitignore        |   1 +
> >  tools/testing/rbtree_oracle/Main.hs           | 128 +++++++++
> >  tools/testing/rbtree_oracle/RBT/Kernel.hs     |  64 +++++
> >  tools/testing/rbtree_oracle/RBT/Verified.hs   | 253 ++++++++++++++++++
> >  tools/testing/rbtree_oracle/RBT_export.thy    |  41 +++
> >  tools/testing/rbtree_oracle/Setup.hs          |   2 +
> >  tools/testing/rbtree_oracle/Strategy.hs       |  72 +++++
> >  .../rbtree_oracle/rbtTestHarness.cabal        |  15 ++
> >  11 files changed, 757 insertions(+)
> >  create mode 100644 lib/test_rbtree_interface.c
> >  create mode 100644 tools/testing/rbtree_oracle/.gitignore
> >  create mode 100644 tools/testing/rbtree_oracle/Main.hs
> >  create mode 100644 tools/testing/rbtree_oracle/RBT/Kernel.hs
> >  create mode 100644 tools/testing/rbtree_oracle/RBT/Verified.hs
> >  create mode 100644 tools/testing/rbtree_oracle/RBT_export.thy
> >  create mode 100644 tools/testing/rbtree_oracle/Setup.hs
> >  create mode 100644 tools/testing/rbtree_oracle/Strategy.hs
> >  create mode 100644 tools/testing/rbtree_oracle/rbtTestHarness.cabal
> > 
> > -- 
> > 2.33.1
> > 
