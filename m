Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF815421652
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhJDSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbhJDSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:25:25 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24534C061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:23:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g6so22704460ybb.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFKM7U3UDEJ55Ej869376prtCofZCVdDub7v4Xo/Buo=;
        b=jPaiEO68fCD9c6m0PyHUFtUdWd2HM024YbBjs8TME+hIf+piF7+5VAIiq+zs8Vzl45
         J4j4CYBHEt/FR6TmTuiy1T7z58//v7+afg0bY2a4sut/NvU3ophdU1Rlrw0e+7vdqWIQ
         Sz+ZA6lMkIBKN4xxiLRBDlw/FkWvgLMy6P1THW1kal1aqrq1bStbTzwQ5gacHB5rqjch
         pGTnW1djIrAQIcMyEi6AMSCn72+6D9QYFNxPp5NtltoAkWdb+muid/3/Q678/vvn59rC
         wk02LQwP5PBzi2WwLdmdHvaR2WE59PqJza8JQfjZt04WBFyLfLeF1wAZNuHe6iy1sVX0
         vl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFKM7U3UDEJ55Ej869376prtCofZCVdDub7v4Xo/Buo=;
        b=tbd886NxO313bZ6ssF8mFbDkmjXEU16Z9a7Bn4QUvtw/rHh7Ohi98BSHZqWEZjO+AI
         t4RXHm81HdBJ+Xf1a1Z99p+vWhvXgCdd+2TgrLvUtILMkKsZVuKFnVj0q1Wo5WAf9Qvs
         HSNGPqL31MzRI4QDBojbCPwTCml+DUAKVi/SZ66zqEt6J4wvdFLw4R1nQCKG9Yfet/Hn
         +X7kutoWvzb8C0nGYyaSBjmb41MSWT14lcO/kRyaiPMYkazyo8IZKL2yquOy4reIqvvW
         5w5Qh0ShWbGA42UhHuZshqHul7yRlWCq0OSwvcoDucbhwlOD+stVGb13JRywkz0tkB56
         FKww==
X-Gm-Message-State: AOAM533ayu3gEzpd4PCsqtndWQOMbo2SJeKCoMngmH311liP7WBWqEz0
        n1yLnLTo+jHV03/24HTmunY65QC0DYMr3MSYvaNz/Q==
X-Google-Smtp-Source: ABdhPJxY3TE/jiifKSp9sVvDhnfPt509VcHgkIJv6dDJItL4Wj6IeZVwTsaqflKieQJelqqbgwTG9z9Tb8IjBjfJQzI=
X-Received: by 2002:a25:6557:: with SMTP id z84mr17297165ybb.243.1633371815123;
 Mon, 04 Oct 2021 11:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com> <20210914223114.435273-16-rananta@google.com>
 <61419b8f-4da9-955e-b8e3-1d401d91ab1a@huawei.com>
In-Reply-To: <61419b8f-4da9-955e-b8e3-1d401d91ab1a@huawei.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 4 Oct 2021 11:23:24 -0700
Message-ID: <CAJHc60yXia60BL6_NddvqsjhXJ19bHrnyQKiPNMqEjjQuHXedw@mail.gmail.com>
Subject: Re: [PATCH v7 15/15] KVM: arm64: selftests: arch_timer: Support vCPU migration
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 2:41 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
>
> On 2021/9/15 6:31, Raghavendra Rao Ananta wrote:
> >  static void test_run(struct kvm_vm *vm)
> >  {
> >       int i, ret;
> > +     pthread_t pt_vcpu_migration;
> > +
> > +     pthread_mutex_init(&vcpu_done_map_lock, NULL);
> > +     vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);
>
> This one fails to build.
>
> aarch64/arch_timer.c: In function 'test_run':
> aarch64/arch_timer.c:321:18: warning: implicit declaration of function
> 'bitmap_alloc'; did you mean 'bitmap_zalloc'?
> [-Wimplicit-function-declaration]
>    vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);
>                    ^~~~~~~~~~~~
>                    bitmap_zalloc
> aarch64/arch_timer.c:321:16: warning: assignment makes pointer from
> integer without a cast [-Wint-conversion]
>    vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);
>                  ^

bitmap_alloc() is defined as an inline function in
tools/include/linux/bitmap.h (since 4.8), which is included as a part
of this patch. Do you mind double-checking if you have it in the
header file?
Also, the function is referenced by other tests such as
dirty_log_[perf_]]test.c. Do you see the same warnings when you
compile them too?

Regards,
Raghavendra
