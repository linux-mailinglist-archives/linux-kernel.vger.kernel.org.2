Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9449338F28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCLNwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhCLNwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:52:07 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C500CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:52:07 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t26so15913377pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaH9KU2KwFKsLqRjuU6mMbuIQ6s+6udeN62Nf4zmSB4=;
        b=RwVBkPff80a0Q9ymIWoePZiPGj7DLUgECdmKwzLZZb/JudZ3Th95j36L+s52CsFS+2
         lYtyXsSb7pfsVS9Y5knt7mSiVixsO9jn7sYQi6jxnsZKW8g4q0+fd7zLfkf0Wa0S/YyV
         VeYnQh/n9mqXmJvOmdxCxVYP5GfbJikDnKKVZorzXUaRRtklVz5nHbBK0GyVdwLekKSG
         wFEbLqyixFeYGaJJyeJRDcgq4aaiPnIlRofIqmsWBUA71Xl3fQ0gaJeFDp0yHb1AYtjz
         Zo5Y8kaSXB5/x4SffUtQObskoKdS3d8ZCyoPpFn+HSw7Ybv00jXl/Q0H1IOtym8OVnEn
         p7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaH9KU2KwFKsLqRjuU6mMbuIQ6s+6udeN62Nf4zmSB4=;
        b=Lw3DjesIosULBRvGPjq41g+So5I2vkG6vISb+6KzfUfmxDzQ1weZVPXFVvbTK2YQcm
         TPY7S1plhT8TrrXQD1uqggSErVPiSVuLBpM+J0eBnpZgQV0VQ1gMCxIX/cKMUEKSksEO
         Rz6Tg+ccUSSF2VaLqd+846BRU/NJuVWvHPojYljMYJ36Yl2hXGMzXRWufFyqxuBm5ad4
         If39is7Wx9nuQj/ZahJ06bJUhCocmlh/u/m/KQ2Bg8wV/GqzURbq+/Bg4fVTB8tKa6+R
         9cxlveeAGfb3SE8/JGSVweme03MR4RFz0anzSXZ1PpvNsV9xGc89mW2/LRjfrhzLRLIj
         XHpA==
X-Gm-Message-State: AOAM533LDMtAStfiGTZk6Uwdl819+M7fdMi+6GMe8rg5hc0HQIPU+0KH
        zCR08x9Ewca3+TCsTMVb02/0QgKHPytZ+t9OjakYhQ==
X-Google-Smtp-Source: ABdhPJwuGwn60b/Z2P54zo3q5S/j0WWVSWP3eyQhdDtz0g0Oa9EoE9A1lceC0V6zJLLkjf/x1NvKO0yR7ig4QMt8g/k=
X-Received: by 2002:a62:cd49:0:b029:1f3:3697:90d4 with SMTP id
 o70-20020a62cd490000b02901f3369790d4mr12569341pfg.24.1615557127049; Fri, 12
 Mar 2021 05:52:07 -0800 (PST)
MIME-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <da296c4fe645f724922b691019e9e578e1834557.1615498565.git.andreyknvl@google.com>
 <CANpmjNP3bHe2h1=-W7r-64Vg9vr9vREzY0M97uh_QRDr3tVEYQ@mail.gmail.com>
In-Reply-To: <CANpmjNP3bHe2h1=-W7r-64Vg9vr9vREzY0M97uh_QRDr3tVEYQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 14:51:56 +0100
Message-ID: <CAAeHK+xHeGQ8FSddfFpLrq+5YHoRZ+5KZr2zB+fzCssSbE_=bg@mail.gmail.com>
Subject: Re: [PATCH 02/11] kasan: docs: update overview section
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:18 AM Marco Elver <elver@google.com> wrote:
>
> > -Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390
> > +The hardware KASAN mode (#3) relies on hardware to perform the checks but
> > +still requires a compiler version that supports memory tagging instructions.
> > +This mode is supported in Clang 11+.
>
> Doesn't HW_TAGS mode work with GCC as well? While the sentence doesn't
> say "exclusively", the mention of Clang 11+ makes me think it's only
> Clang.

I never tried it with GCC until just now. But looks like it works.
Will add GCC here, thanks!
