Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD8412B03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbhIUCFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbhIUBsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:48:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A9C065F01
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:29:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id m11so24129599ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vs5Sa4Qkum2hykw4ZyahHqvL6vQpnvGsWXcltm8dEl8=;
        b=AlZLXTBjCAdlj42aHO5FGqsg3ZPxEeZm718Xti98solHQMUU4S78VjkfVgaFqv3h+A
         Rupy1sx5wrK87J3EENc9C9kr0N/P+SzqttjfrYNpbYVMuQOJZcVnjv/JAaV7Yr0Y4yOt
         ZvGFxG9t9ymTnfW1FB/g43VmSoO6YV0w+cXabr8Qn/Achp2IWBYozL7+yDA1WYYyEA7c
         0+COCe4fuoaZufpYP6xOy9ii6Zr45uEDI4uvJE9YuMq4bNsz7fh3sw55D6Rp7rgV9kJj
         iQa4vCw+ZB/oPXelGobE+gR7wdwDm9iQLg4G7jKX2aexQMGWAsqwIHMDXZ09Tezqh1JJ
         NpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vs5Sa4Qkum2hykw4ZyahHqvL6vQpnvGsWXcltm8dEl8=;
        b=v9fJgY0qhhOMYhWXUm18tDPQlMDYc9YXR7Fb7as1mv9j6axFTU8nlg2WqXMDw0r29J
         azajDpgGTcZ27aThfW3BTYtZt79xkvnMaE77pqdnnp2PYl1FLABVIGKwQTGwCeoxll9F
         0BanjPpwUrcvca3P7RPUCLzOcI0mxs0Z8IJ9F0GppKgO3BxoE7OfdSbA7DadkPirvRxd
         BOwI/h4ed2bcIBqD8zdQXIHpGXb56iXZFKABxicYDby4EGDpSaZqwSFBch4du1lNpErF
         8jN8XI2mRP4oC7r33dzbKkEsuSropE17zPOeQYwvHJEihtcmvU24pyic+EBkX0GIq2Xl
         wSjg==
X-Gm-Message-State: AOAM533SuYzAeIsxhxs3wYdghyZ0ClZiHTCk8TXFbUqKfU66q19NalKJ
        RPlZRx4mDFsfr+oLQPMJZ8/WiEJJJ8LIVgSne8B6Wzr+SBc=
X-Google-Smtp-Source: ABdhPJxATtCsf1ixsXOcZz5DejVi9Y6CKr1aISL0Un9ka4UpQYTF+S71mBRCSjAhy/WR5tHFkiYHFIufXLMc+Nr9CNg=
X-Received: by 2002:a6b:6918:: with SMTP id e24mr20177518ioc.71.1632173397612;
 Mon, 20 Sep 2021 14:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
In-Reply-To: <20210913081424.48613-1-vincenzo.frascino@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 20 Sep 2021 14:29:46 -0700
Message-ID: <CAMn1gO5sUhDkx4w-Kk8hw0xLbXmr129xeJa6YhxOeJ-v83hp6w@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: ARMv8.7-A: MTE: Add asymm mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:21 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This series implements the asymmetric mode support for ARMv8.7-A Memory
> Tagging Extension (MTE), which is a debugging feature that allows to
> detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.

Unless I'm missing something, it looks like this only includes KASAN
support and not userspace support. Is userspace support coming in a
separate patch?

The fact that this only includes KASAN support should probably be in
the commit messages as well.

Peter
