Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190E03576CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhDGV2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhDGV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:28:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A5C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:28:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b4so411447lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWjUyKOaiYaHrSNGRAQMkzTl2/6YP/Jxn5feXfPwJPw=;
        b=tGiprS0/uJqpTbO30TJ0/ozd1LkH6KmtujjdAQUy46IQqWHCA+K9jJ49/vtQK9xk6u
         vGCaxYm3MoIn+oDobegiMeH5CB/hqskfLAp8nQ7C17k4KWv7LpeRAOC5oOf175SEecYC
         77SzaNqu9ig81iYfZUrSiEY6vFIrTY3t7zrXpxcG8k8SwyWfyYAk3KTvV9rcmYXI6raW
         majb+BZW0GXU0zq1dtMd4gHpPKNtEWEyMmtNJGwXkbMPMhDzl6u2jioESWOJOobEsgXU
         JijAIUg2KBFyJvUKpb0rd9ZHBeZIkT4Efk4Q57bGyByyH+3pz6Glh2pyJzopeV0XqfPJ
         rDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWjUyKOaiYaHrSNGRAQMkzTl2/6YP/Jxn5feXfPwJPw=;
        b=t0G9yGi2nP/nhabAo5zcjii9cG92oO9F1nWYh+Nrr6MATN/bh+Km/hgz8ZwtjfZDHt
         3cyiLeHR8tV5K0iN+Nf6PRyAbK4vWRRQfbqEwDe3HC7d7QnKDsJSABmUw0kS2Z3oohUc
         XkeW231N+lQ/eFL197GLXFOkWt6MyKEpWqlGZb1h1D5tPL9t65dkzpTDwZ5NNHRg8H7l
         ks+i5YuQDeFsEPJifCPvc81pHfhGeQJ7YK76FaNYRrp1nKRAV9pNVyTvBZ7tZLGKhs3x
         kv9M0a2VVJY7jkN848HlE/FrbJdA5wEIX10kgQC5/MefdWfVFqSQUIItEjtcK4TeM+Uh
         8Nqw==
X-Gm-Message-State: AOAM530DhyID2QgBWb/Ha1EI5J0SO7WAo8zAcsqyiTG70+Fzu7KZK3ag
        zJiajWuzUDPcSC8jj+mv8ywq+soYaPizKkiIeU7oDg==
X-Google-Smtp-Source: ABdhPJzCUyjDCWCmMBQXNZk2FyD0UTwuI5OnSxCg2fPf4EgssQww/AdlL/SgELOZfVFRjhKLhGGkjQnH92LgDVMQCoM=
X-Received: by 2002:a19:430e:: with SMTP id q14mr3981418lfa.374.1617830912545;
 Wed, 07 Apr 2021 14:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210407185456.41943-1-ndesaulniers@google.com>
 <20210407185456.41943-2-ndesaulniers@google.com> <20210407142121.677e971e9e5dc85643441811@linux-foundation.org>
In-Reply-To: <20210407142121.677e971e9e5dc85643441811@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Apr 2021 14:28:21 -0700
Message-ID: <CAKwvOdnSRsUj9dvKP_1Dd9+WwLJwaK0mC-T9mL+jsQvRfwLZmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcov: re-fix clang-11+ support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 2:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  7 Apr 2021 11:54:55 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > LLVM changed the expected function signature for
> > llvm_gcda_emit_function() in the clang-11 release.  Users of clang-11 or
> > newer may have noticed their kernels producing invalid coverage
> > information:
> >
> > $ llvm-cov gcov -a -c -u -f -b <input>.gcda -- gcno=<input>.gcno
> > 1 <func>: checksum mismatch, \
> >   (<lineno chksum A>, <cfg chksum B>) != (<lineno chksum A>, <cfg chksum C>)
> > 2 Invalid .gcda File!
> > ...
> >
> > Fix up the function signatures so calling this function interprets its
> > parameters correctly and computes the correct cfg checksum. In
> > particular, in clang-11, the additional checksum is no longer optional.
>
> Which tree is this against?  I'm seeing quite a lot of rejects against
> Linus's current.

Today's linux-next; the only recent changes to this single source file
since my last patches were:

commit b3c4e66c908b ("gcov: combine common code")
commit 17d0508a080d ("gcov: use kvmalloc()")

both have your sign off, so I assume those are in your tree?

-- 
Thanks,
~Nick Desaulniers
