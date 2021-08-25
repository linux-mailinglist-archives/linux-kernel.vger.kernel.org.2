Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC43F73D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhHYK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhHYK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:58:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A322C061796
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:57:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o39-20020a05600c512700b002e74638b567so4278049wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QtpP3tcoZvxE8r2Ab9yioe6Y4u6iLyGn82K3C5J43jA=;
        b=CPnzfp/h86yWtxXjXiARoCfboSHpnNns3MBtX2+WLiCh15sHR9FVS60aDreNw7trqM
         jAjVTq1lHZRfI5zL97BUq9RiWGF9vY6wq1ASTwB8icgWyTAeo4/U3L0W9YWSDO/0tnIC
         SfnOKdAetryslQfcfdjO9D75yoKrGQJ+JoE1sXl+a/O1N1wlhKP1bYtwDjOeRpOUXnO7
         ywuGY37MTEmpCJ1Xtoc/c4mm+9LldgHEAR+oh6PttRrlPwKtE4y0LaMv3QJiZNbMs88n
         YHkwGZhysNLjTwHPNZ9Iqjt4jIEaBgPc0UjvFqqadTJYTt5cIbrlNbiwQVEWt1wfv3tJ
         yV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtpP3tcoZvxE8r2Ab9yioe6Y4u6iLyGn82K3C5J43jA=;
        b=R20Y63qtaw/mlgvW7YZZzyDrzXeiqhRJ0vDQGtZMZtxZECMIPiqgDq0NCIAB39oiYy
         qJFMJDkPYtOv8h753ZbfFqfEMkdaoTqEpxGxXd+NlyDY7mUY3/sCN0pFCAbS4MKR3mlM
         Qpk6G7hJZIzexU8S5F10d+3p/yS2L2icxdi2N+EVKcde+tZFJBybsvgg8B/OvDI+PgyL
         sfWxodZH2zZOlpRgcyU38kHZGcc7JWZQdPxIXdZ9M+64INyqVcwrXelK198hd9rT4NkI
         r54e1ft10miau6TesxXkrmKG8EDwtpn1uNAlXRTkDigt7iNj8NdvMMIAjRy5HKmXr5JV
         EA4A==
X-Gm-Message-State: AOAM530ZKnz05uFB7a0pOoVqRRNkzbRki45VG/e1qZeV1hLhOOvVLtPD
        nwC48NgbfkrqYsOA9enwm9QdWA==
X-Google-Smtp-Source: ABdhPJzrj4+3MI11jLaGBq0hL07XTV+UItEI1ZTgzm6xno7sNLnnF9Le1KkUIoPefOoMqAoC/DTFQQ==
X-Received: by 2002:a05:600c:4fc6:: with SMTP id o6mr8926193wmq.122.1629889048587;
        Wed, 25 Aug 2021 03:57:28 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:2fcd:1452:4b71:155d])
        by smtp.gmail.com with ESMTPSA id d7sm21305866wrs.39.2021.08.25.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:57:27 -0700 (PDT)
Date:   Wed, 25 Aug 2021 12:57:22 +0200
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] ARM: Support KFENCE feature
Message-ID: <YSYiEgEcW1Ln3+9P@elver.google.com>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <CANpmjNMnU5P9xsDhgeBKQR7Tg-3cHPkMNx7906yYwEAj85sNWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMnU5P9xsDhgeBKQR7Tg-3cHPkMNx7906yYwEAj85sNWg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:14PM +0200, Marco Elver wrote:
> On Wed, 25 Aug 2021 at 11:17, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > The patch 1~3 is to support KFENCE feature on ARM.
> >
> > NOTE:
> > The context of patch2/3 changes in arch/arm/mm/fault.c is based on link[1],
> > which make some refactor and cleanup about page fault.
> >
> > kfence_test is not useful when kfence is not enabled, skip kfence test
> > when kfence not enabled in patch4.
> >
> > I tested the kfence_test on ARM QEMU with or without ARM_LPAE and all passed.
> 
> Thank you for enabling KFENCE on ARM -- I'll leave arch-code review to
> an ARM maintainer.
> 
> However, as said on the patch, please drop the change to the
> kfence_test and associated changes. This is working as intended; while
> you claim that it takes a long time to run when disabled, when running
> manually you just should not run it when disabled. There are CI
> systems that rely on the KUnit test output and the fact that the
> various test cases say "not ok" etc. Changing that would mean such CI
> systems would no longer fail if KFENCE was accidentally disabled (once
> KFENCE is enabled on various CI, which we'd like to do at some point).
> There are ways to fail the test faster, but they all complicate the
> test for no good reason. (And the addition of a new exported function
> that is essentially useless.)

I spoke too soon -- we export __kfence_pool, and that's good enough to
fail the test fast if KFENCE was disabled at boot:

	https://lkml.kernel.org/r/20210825105533.1247922-1-elver@google.com

will do the trick. So please drop your patch 4/4 here.

Thanks,
-- Marco
