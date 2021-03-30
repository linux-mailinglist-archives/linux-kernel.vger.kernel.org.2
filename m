Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7762134EE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhC3QiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhC3Qhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:37:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEF9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:37:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so7466536pgj.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bFDTkH9JcEDOzccCJHbuAcdTPMMRb2IauyOAtWvukU=;
        b=JEpuv7ismqJvD/rh8eWo74+I+9DswG7+fHhCk3dWIbSm7WnlLdoMzTdm33iRP257A0
         6mMdjfq8bwfVyL/qn90cHYglSei3T8gFlM0raIz0A+0VakfixPyBXaszWr4dTzOwswfa
         3AF8oHyVBsoil1DPatHFmrRnZrhPS8XR4sQjg5+u7DS6HbY+VQQmNMN9Ax454EdsNQo9
         FlM3l+86P+8rtXmUzjU1hilPFPcIhJeq37i5r8RkG0vPOb7RWW2UiMpiABw/wBsb+glV
         wy7x9nZUmc+tzVih98hcUwVeB7OkIwp85Y//hQ7iRtxeV9c/vIVPVv6Bfh1eYSAXE3HZ
         IIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bFDTkH9JcEDOzccCJHbuAcdTPMMRb2IauyOAtWvukU=;
        b=GCSdNJFuNDaHWaArlH2DGSsH+Pl38fHi9hmZl1Hz2OemtpDuskSpFoYnFCx8lmlQCB
         S3DefUOGB+4aedn7ioqXa1LW7+lu57qrX9IMiEwJljyuFBuMv3T31emU8qGS9ct87WDX
         S6L6qq2R5W+TsAg4kWe/KgltU2daIkFmEKIWCWvOAZ15r5d3OHc3yOplRDbh4r+ggV2i
         9ZKYZqwlqJLj4t69eHw92kct8JZ07uNNykCECO/HERgk8nvVuujuN2TZH+9ASZmcf4nN
         LXLCX9bUVXYUsw7OjXi97HoleYRXzIeBLMb/rUzHvs4Yzw2sS+sLJWH4CdSLQqylZyi7
         s+1g==
X-Gm-Message-State: AOAM530tMALsqXD5ForpmZbyePveA0DoLf77Dlr80MP7gVHO9ZwLl8cj
        zB0roVeBSvjQDGgXvNUjUQxY8Y79lNgYCcdtWzW9tA==
X-Google-Smtp-Source: ABdhPJzp1mKDt8IjzqvzSGbh779NL4bDjXtzkqtFX8MSrNVuNJgjQjwFomzCkV5LcMY39sBcJptl+PfTzg+NaVHeIww=
X-Received: by 2002:a63:4e47:: with SMTP id o7mr16220027pgl.286.1617122271157;
 Tue, 30 Mar 2021 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <2e5e80481533e73876d5d187d1f278f9656df73a.1617118134.git.andreyknvl@google.com>
 <115c3cd4-a5ec-ea4c-fdc8-a17a0990bd30@suse.cz>
In-Reply-To: <115c3cd4-a5ec-ea4c-fdc8-a17a0990bd30@suse.cz>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 30 Mar 2021 18:37:39 +0200
Message-ID: <CAAeHK+yHcPQFP83p7-gPS4zC0NmhSWasxtoQU+Lz+py=QvKV-g@mail.gmail.com>
Subject: Re: [PATCH mm] mm, kasan: fix for "integrate page_alloc init with HW_TAGS"
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 5:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/30/21 5:31 PM, Andrey Konovalov wrote:
> > My commit "integrate page_alloc init with HW_TAGS" changed the order of
> > kernel_unpoison_pages() and kernel_init_free_pages() calls. This leads
> > to __GFP_ZERO allocations being incorrectly poisoned when page poisoning
> > is enabled.
>
> Correction: This leads to check_poison_mem() complain about memory corruption
> because the poison pattern has already been overwritten by zeroes.

Ah, indeed. Will send v2. Thanks!
