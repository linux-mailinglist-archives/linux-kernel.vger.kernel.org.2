Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6641059B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhIRJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhIRJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:46:51 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0781C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:45:27 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x10-20020a056830408a00b004f26cead745so16314286ott.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjDTvBteAJt6rqaanENmzaxCVEDC1Q1i6Nv/9nSbEWE=;
        b=R0gWqYQHIYpji/L/rNhbW713jHzhe5H7XxZVXBR5re/RmbR/BUGWB72/Xc9DfXDg8d
         arnExngwsKixdJb12WJAzD/paHbR1qYC0RXJwymSpIIbqPzXWzQ5dAkHiZoX7MWLGs8A
         LriPkoWanQIdHQiXl+yufYz74CvuLsNX3PkDqDAom8eLWPy0whZTX1xH1md9qWQ4ocOA
         VhtSe4jkfruOy8nbPohcaPAPgP3i0ydBEBRc9D3gkH5bTvkkSrY4d+mRhQkL3Jbhbmji
         uUnniBn6ALsGuC84j+uiJ71IZXyCTazqiajBQJrorIXUnb5mmFAQlCBBrrH1hxTTUDoD
         ifwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjDTvBteAJt6rqaanENmzaxCVEDC1Q1i6Nv/9nSbEWE=;
        b=XsCjEClgfqAS/7xoWmTf5uBCNQkA8+0SoAPhj7pJvM9vbOn8C4pLcui/M67G5facvw
         aKVOAaRg+4zGTRQ80n+m18VcgB/VthuwfHvruvzbkNFmPKrxY6WYrVeqq6yWUImT203P
         JJE4kAwHb/WB38TQt9fS6UwrX2Nyvd5couCAxv+gh+G4UZpSnrIsKOBC56RECrvGlv3g
         B6P5lw086pIJaYCGFOB27SbvshPT9ssLwzpTAi0RaCSCFEUQsz+sPucDGMHMty0ciydf
         7/Y5h8BkxyOUjvBmGuWgRDVdh/QJrZ06dt7t5N0TBtoIydWF8j5ZC6fqrz04AZYV0ZsK
         sxMQ==
X-Gm-Message-State: AOAM532VovquFwgyUuwnhGJLGwhk/7UOBW0skmKz7dsaNAYSfXE9j7QL
        0gYKdyunpQiKkeFw9fTEiuy8gbVv5TOEpHBIr2x64Q==
X-Google-Smtp-Source: ABdhPJx4RfdEpXr7dCTUwuu72uM0DE2Wtycx2Q7nzWsgK/MJHZqUtVw/zJqQSELX1LbAfQtn4/FgtHXoLC5q7BBRvSM=
X-Received: by 2002:a9d:71db:: with SMTP id z27mr13094532otj.292.1631958326940;
 Sat, 18 Sep 2021 02:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com> <20210421105132.3965998-3-elver@google.com>
 <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com> <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
 <CANpmjNNXiuQbjMBP=5+uZRNAiduV7v067pPmAgsYzSPpR8Y2yg@mail.gmail.com>
 <da6629d3-2530-46b0-651b-904159a7a189@huawei.com> <CANpmjNPj5aMPu_7D=cwrDyAwz9i-rVcXYgGapYdB+vdHcR3RZg@mail.gmail.com>
In-Reply-To: <CANpmjNPj5aMPu_7D=cwrDyAwz9i-rVcXYgGapYdB+vdHcR3RZg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 18 Sep 2021 11:45:15 +0200
Message-ID: <CANpmjNOUt5is7iHCAz9aOdD2nBb_7tqAKXmuWtitY_VNOkmv5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        jannh@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sept 2021 at 11:37, Marco Elver <elver@google.com> wrote:
>
> On Sat, 18 Sept 2021 at 10:07, Liu Shixin <liushixin2@huawei.com> wrote:
> >
> > On 2021/9/16 16:49, Marco Elver wrote:
> > > On Thu, 16 Sept 2021 at 03:20, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > >> Hi Marco,
> > >>
> > >> We found kfence_test will fails  on ARM64 with this patch with/without
> > >> CONFIG_DETECT_HUNG_TASK,
> > >>
> > >> Any thought ?
> > > Please share log and instructions to reproduce if possible. Also, if
> > > possible, please share bisection log that led you to this patch.
> > >
> > > I currently do not see how this patch would cause that, it only
> > > increases the timeout duration.
> > >
> > > I know that under QEMU TCG mode, there are occasionally timeouts in
> > > the test simply due to QEMU being extremely slow or other weirdness.
> > >
> > >
> > Hi Marco,
> >
> > There are some of the results of the current test:
> > 1. Using qemu-kvm on arm64 machine, all testcase can pass.
> > 2. Using qemu-system-aarch64 on x86_64 machine, randomly some testcases fail.
> > 3. Using qemu-system-aarch64 on x86_64, but removing the judgment of kfence_allocation_key in kfence_alloc(), all testcase can pass.
> >
> > I add some printing to the kernel and get very strange results.
> > I add a new variable kfence_allocation_key_gate to track the
> > state of kfence_allocation_key. As shown in the following code, theoretically,
> > if kfence_allocation_key_gate is zero, then kfence_allocation_key must be
> > enabled, so the value of variable error in kfence_alloc() should always be
> > zero. In fact, all the passed testcases fit this point. But as shown in the
> > following failed log, although kfence_allocation_key has been enabled, it's
> > still check failed here.
> >
> > So I think static_key might be problematic in my qemu environment.
> > The change of timeout is not a problem but caused us to observe this problem.
> > I tried changing the wait_event to a loop. I set timeout to HZ and re-enable/disabled
> > in each loop, then the failed testcase disappears.
>
> Nice analysis, thanks! What I gather is that static_keys/jump_labels
> are somehow broken in QEMU.
>
> This does remind me that I found a bug in QEMU that might be relevant:
> https://bugs.launchpad.net/qemu/+bug/1920934
> Looks like it was never fixed. :-/
>
> The failures I encountered caused the kernel to crash, but never saw
> the kfence test to fail due to that (never managed to get that far).
> Though the bug I saw was on x86 TCG mode, and I never tried arm64. If

[ ... that is, I didn't try running QEMU-ASan in arm64 TCG mode ... of
course I use QEMU arm64 to test. ;-) ]

> you can, try to build a QEMU with ASan and see if you also get the
> same use-after-free bug.
>
> Unless we observe the problem on a real machine, I think for now we
> can conclude with fairly high confidence that QEMU TCG still has
> issues and cannot be fully trusted here (see bug above).
>
> Thanks,
> -- Marco
