Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B13A95A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhFPJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:14:12 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5FDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:12:06 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so501486oor.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwXeE/T9A/OrTylBMfS7m9SAT845lCEQygKVQTKDO1g=;
        b=RElzJ2hc7LrZCUP88cqmIT5SmDkbzIOCj/FtUDQinBJda4kLAvYUFxtOc+bR7clliV
         WlIsUs4vcuoeAie5wl4aqs1VbotnGDvk9niC8fflUf7H0yyqbQ4FoGFYl+eQaYf/Jm5N
         GHcbH10qGL5iabgOzIJ0o2h9Cuk4+h0Lh3oeHoFxJuv8oSUIbBmljuMxXvYveUmhwFFS
         fq8stEa4IlssAoQmWl7xNloVppaAYhFGZBiKAbNPL8yD+rQ8XcH3ZKJYJDO5FOBJ0Pa0
         JE11w1jFJQU9bnJ9cvleB79kkB5wexOBGyTGOIk4XLihR690/YFYPnJn9n9CK1OSItGz
         KOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwXeE/T9A/OrTylBMfS7m9SAT845lCEQygKVQTKDO1g=;
        b=QXvhG2zG328jFU9+LIRXNqTP+kITTFeZ52xxLiL30SO7vHGjXUZPL/U1GbxgshCGht
         +q2mGzVpubDxLVqvyRaM/ST0jGtExPxAmY4zoXhN4buHfuS6OFgx7OVVD80ctaLCCLvd
         D73zjOYKPp8N7DMoJegjx2u4UjuPEEef1qnQXfGKhWPZhXaOMv49DOs2o+K/GZJiwFeD
         1uN1EVxsbqRStk/frqi1E+dHB5gTUo2LPXxfjt3Ozvata/2+t7kRLLz5g7OtDqpOaazZ
         COuim1mrt4FGioBsWArQJS6UKYvphq1bhDeC3klD2aD8l39FeszO+5FBUTsvdhx5y0cW
         opRg==
X-Gm-Message-State: AOAM532lhEQjVfal3IJNSaSY7+veDYajwKYBQaDrI24S21K6kwMYvKjD
        01xPo14G5OYeEMyfdUxoqb4oHhpAxnpUcbbzKMPIxg==
X-Google-Smtp-Source: ABdhPJwqsOZips+plZIgDSkdTPzgqj+93in/a1mqiJLmW6JftBHWGo3F8b2WvrzrNofwz/qjWGg4WsBG0IpZtFr3ICQ=
X-Received: by 2002:a4a:6049:: with SMTP id t9mr3118549oof.14.1623834725852;
 Wed, 16 Jun 2021 02:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210615030734.2465923-1-liushixin2@huawei.com>
In-Reply-To: <20210615030734.2465923-1-liushixin2@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Jun 2021 11:11:53 +0200
Message-ID: <CANpmjNMh9ef30N6LfTrKaAVFR5iKPt_pkKr9p4Ly=-BD7GbTQQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] riscv: Enable KFENCE for riscv64
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 04:35, Liu Shixin <liushixin2@huawei.com> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the riscv64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
>
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the kfence pool to be mapped at
> page granularity.
>
> Testing this patch using the testcases in kfence_test.c and all passed.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Acked-by: Marco Elver <elver@google.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I can't see this in -next yet. It would be nice if riscv64 could get
KFENCE support.

Thanks,
-- Marco
