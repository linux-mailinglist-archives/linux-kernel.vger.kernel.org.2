Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F424270EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhJHSs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:48:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978B7C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:46:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s16so8989935pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=quuSqZ0dONVuv9mo4TeP3YIzWz+O416I07kQnnw7STA=;
        b=VP3FxMvbz5TL9ETbQUQchYZN5L4JzqpHPf5RtFeE3ZfDwplk+2AwbE5NYJyD1Dwm64
         OURJONO70AuDhhUUMsC6mqZ0G6vpAdpP88r9Vat/ksn3WojuY1MZE2iby4R/hU8ULX1g
         D5tF5tPYrB+h8S+lezt7+hxCysnobBIbL9yDUtqZ6s/E4NZYhAJIyuqj/yk3upT3mVoC
         D2B84lQfOuy11lNLZbdj5WLptstGzspyTbtIPgniNYtZfX4pE78j+I5Yb8Sb09PlYEF1
         QGrIKY+xG+/pJIw5Oxli7c2qFSNLq7bwRSQYjwaNYbsqfW4hfmsh66cpOKPD89L8UKOW
         HgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=quuSqZ0dONVuv9mo4TeP3YIzWz+O416I07kQnnw7STA=;
        b=hXHBp/3XEea5CVpfvHJYpk6jy3lLx6MQRC73o4HQgNnFY0D5NbC4s2w/7zfKX+wpDH
         +VIzyvWNyGTCYW8O5+yhXdm0+scNh+06r0sBlFl0n0jLCO1X0DKtzkIceDGO++OlU18A
         y5/v9bsz6BtVvQJAZrSI2tT8BruM+t/SRpVxbfkqOLjN6USYUCdcVfhL2mz8qtifyWK2
         5Zougo14hNr306Qhc19eukRujGEO271KmrWvwnAVPg0TenbfYl/VUBal7GxswPsOJy+v
         aWW8ZAzV4MueeYtFgx0+dJwakYiFS4fjM1isCLgNccz564kOzkZMBbMyIarPZc7agMba
         DWZQ==
X-Gm-Message-State: AOAM532wLMu9cR6PLX30U3yOC+HXMeXLZrWCNG8q7Rgza66ep2YPOtyG
        FMNRChapgkn7/WQD6/aS4cftwQ==
X-Google-Smtp-Source: ABdhPJxAT5BQrmJ3JUtPZaaQj9/pOPmAgQLcheO9hTXDYLo9/eegEa4BrfVFO430mNlT7+7pI3Tbjw==
X-Received: by 2002:a63:b214:: with SMTP id x20mr6037587pge.460.1633718816009;
        Fri, 08 Oct 2021 11:46:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k17sm73056pff.214.2021.10.08.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 11:46:55 -0700 (PDT)
Date:   Fri, 08 Oct 2021 11:46:55 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Oct 2021 10:00:34 PDT (-0700)
Subject:     Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
In-Reply-To: <YUyWYpDl2Dmegz0a@archlinux-ax161>
CC:     elver@google.com, akpm@linux-foundation.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ndesaulniers@google.com,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-b5f8a6a0-c3e8-4d25-9daa-346fdc8a2e5e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 07:59:46 PDT (-0700), nathan@kernel.org wrote:
> On Thu, Sep 23, 2021 at 12:07:17PM +0200, Marco Elver wrote:
>> On Wed, 22 Sept 2021 at 22:55, Nathan Chancellor <nathan@kernel.org> wrote:
>> > Currently, the asan-stack parameter is only passed along if
>> > CFLAGS_KASAN_SHADOW is not empty, which requires KASAN_SHADOW_OFFSET to
>> > be defined in Kconfig so that the value can be checked. In RISC-V's
>> > case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which means that
>> > asan-stack does not get disabled with clang even when CONFIG_KASAN_STACK
>> > is disabled, resulting in large stack warnings with allmodconfig:
>> >
>> > drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:117:12:
>> > error: stack frame size (14400) exceeds limit (2048) in function
>> > 'lb035q02_connect' [-Werror,-Wframe-larger-than]
>> > static int lb035q02_connect(struct omap_dss_device *dssdev)
>> >            ^
>> > 1 error generated.
>> >
>> > Ensure that the value of CONFIG_KASAN_STACK is always passed along to
>> > the compiler so that these warnings do not happen when
>> > CONFIG_KASAN_STACK is disabled.
>> >
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/1453
>> > References: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
>> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>
>> Reviewed-by: Marco Elver <elver@google.com>
>
> Thanks!
>
>> [ Which tree are you planning to take it through? ]
>
> Gah, I was intending for it to go through -mm, then I cc'd neither
> Andrew nor linux-mm... :/ Andrew, do you want me to resend or can you
> grab it from LKML?

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

(assuming you still want it through somewhere else)

>> Note, arch/riscv/include/asm/kasan.h mentions KASAN_SHADOW_OFFSET in
>> comment (copied from arm64). Did RISC-V just forget to copy over the
>> Kconfig option?
>
> I do see it defined in that file as well but you are right that they did
> not copy the Kconfig logic, even though it was present in the tree when
> RISC-V KASAN was implemented. Perhaps they should so that they get
> access to the other flags in the "else" branch?

Ya, looks like we just screwed this up.  I'm seeing some warnings like

    cc1: warning: ‘-fsanitize=kernel-address’ with stack protection is not supported without ‘-fasan-shadow-offset=’ for this target

which is how I ended up here, I'm assuming that's what you're talking 
about here?  LMK if you were planning on sending along a fix or if you 
want me to go figure it out.

>
>> > ---
>> >  scripts/Makefile.kasan | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
>> > index 801c415bac59..b9e94c5e7097 100644
>> > --- a/scripts/Makefile.kasan
>> > +++ b/scripts/Makefile.kasan
>> > @@ -33,10 +33,11 @@ else
>> >         CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
>> >          $(call cc-param,asan-globals=1) \
>> >          $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
>> > -        $(call cc-param,asan-stack=$(stack_enable)) \
>> >          $(call cc-param,asan-instrument-allocas=1)
>> >  endif
>> >
>> > +CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
>> > +
>> >  endif # CONFIG_KASAN_GENERIC
>> >
>> >  ifdef CONFIG_KASAN_SW_TAGS
>> >
>> > base-commit: 4057525736b159bd456732d11270af2cc49ec21f
>> > --
>> > 2.33.0.514.g99c99ed825
>> >
>> >
