Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C93A415C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhFKLk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhFKLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:40:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458EBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:38:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c18so15466801qkc.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhYV4dmRiRSpgYWOGzvvHoyogPprGMAPvN/EL3Ivaw4=;
        b=Jo3ruZFqwjcjNLkGQCyayLv+4DS3xQ3R9Pxg8NQ30pVYxW23D+HA6kVT+LHbVqzMVm
         09KmjGNtlMrK2X3G9+i3urPLGOy4eVJxQsQMlkgHXCDXz6U9CIHwo0wPBf4u60EbdVTx
         r/vppEDFgiGl1n736YSaoy/tdFFPRAoWOgPaLe1VK2eDmNYPlOJ+HkN95I4I0X7Of0lo
         ksq88jWGAQqbQHRJDxe/QnCrth3VSmrbYJdtAAX0ufYgruNtTJH4uQK0MwD93tvzeeth
         ReeXRhcDk9VKMYNXe5cGn+R3RGBbVqsDWiSwMkrIkZdgVFJzvovQ1q6pUEC+8Jht25nX
         4rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhYV4dmRiRSpgYWOGzvvHoyogPprGMAPvN/EL3Ivaw4=;
        b=gIyUt0dkJ8D01CfaLrLVU8uzqcoPSrkSfcST+lRoOT+GbJWrb2FbR7QaY+xvhkawgs
         b3+XNCEhEgOZuQXGHSG/gqzepOI6SNmdEWIOdFYSXzwgcqphIIKM4sDhdRE7Bgj2ipj9
         ISFys1RKh4Zt3jPeq+hL/sEX1YIPbECupiwAQUjUIY1IFfOnjmnC1v1wU3ix+1ESoCpV
         0JQ2wUpHnbqnD+4UhnBjnokA+aI+MWm6s9rkZ/OeBsPmiBDQIlDqyL/dCFOE/+Pd3qEq
         AOgS+X53FKorjWsjJsn3pxLo479Mze9raklxhgxOk3A0eQ7Xvjnfx37+lkgR7Tb+xkdM
         nCAw==
X-Gm-Message-State: AOAM5326VmuHxrxMWXscH1yoP7+h6mJVn44b3y44vPAmLwULqHY6ZkDj
        kGn0vp/fHzcVb3ZB8vkHhtZlTmax7zga07zhXOItyw==
X-Google-Smtp-Source: ABdhPJztwHpLwTUGjxnjUd85Yk8W2utgZi5ro/yuiZhde0n6F6iX5b7WnVyIR+4sIuZ8yRZ/6zLYzy1ejNz0kAAG6EE=
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr3313686qke.326.1623411509230;
 Fri, 11 Jun 2021 04:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210529080340.2987212-1-liushixin2@huawei.com>
In-Reply-To: <20210529080340.2987212-1-liushixin2@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 11 Jun 2021 13:37:52 +0200
Message-ID: <CAG_fn=XjoZAn+h3b9Yh0PgSNCWn6V2dgHoT-PHG_Z2Js6wUkgQ@mail.gmail.com>
Subject: Re: [PATCH -next] riscv: Enable KFENCE for riscv64
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Sat, May 29, 2021 at 9:31 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
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

Looks like you're missing the Acked-by: that Marco gave here:
https://lkml.org/lkml/2021/5/14/588
