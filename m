Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B881409A54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhIMRHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbhIMRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:07:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93560C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:05:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a4so22527613lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wm2HR4L0vBNqB3mM87MK6dpQpg/k1YQQXiC/25umcss=;
        b=J7kfc2b6uIuG4RH/pAjQnpKhD2WCcEh0oILsdxS3STsS0fcE6lHeL8emJW/30ltYn7
         pjigPwUJjZgUDowzRlQ5mz4Ccbz7rjeXiJw/+oaGIFg0PtnZOtyzJ08jLmPj+k0EAKNS
         kVs/hUGgOPvhGjkmWr5LBt2WB8X9CXIrY0M2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wm2HR4L0vBNqB3mM87MK6dpQpg/k1YQQXiC/25umcss=;
        b=Uv1n2rWy7+VpVUo3E0LEIhIHtPe4TjGqAu5Rn/4N9lkzqR07PpvhTHqm8xtxho9Zeh
         rN7KCsdSkjyhwc7csWrUrbmm0/DxMYYEaNFjgkPR1JAuxoZSTM9XNSqbk8+ndHrGTIt3
         +XqtO9dMBiiO2LM9HmtqodOG/TBHDDHi+qkDxl2xJb++J2Q9kb/rDmQ376xeZUJcHMXs
         cThgHcVMJh3RscdrjiAJxzIEGcfrK8t1WRexXHFzOAnbC7GZQews9RGes4GJSEmugIIk
         7+G8iFksY/DeI6PwmltoxqiEwivEO3pWAMKAH4IHAZf+pWtRwDZ3peCe4y59KvtdZp9X
         VPsA==
X-Gm-Message-State: AOAM532BWcZlKX/H3GFO3MeLYoe3KthLus0hxcUI+nn+DB39oHRVISBa
        Oj3FHR2vEoTn1pDv9XLNBDZxZPaFkGmbBwbXFFk=
X-Google-Smtp-Source: ABdhPJzHYKUNpCNATyXfxRidRoADBhc7MNrn5K6gA0Rt3uDq8nC7dffm2oeSKLTS0jRgkpoqDNyaFA==
X-Received: by 2002:a05:6512:22d5:: with SMTP id g21mr684425lfu.544.1631552749045;
        Mon, 13 Sep 2021 10:05:49 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b2sm878281lfi.283.2021.09.13.10.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:05:48 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g1so11059256lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:05:48 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr9855278lfv.655.1631552748031;
 Mon, 13 Sep 2021 10:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210913163547.5156-1-will@kernel.org>
In-Reply-To: <20210913163547.5156-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 10:05:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whF01ZS30vQAEjY9K4RM_QNjZ0mTCTt8SY4KuER-2d14w@mail.gmail.com>
Message-ID: <CAHk-=whF01ZS30vQAEjY9K4RM_QNjZ0mTCTt8SY4KuER-2d14w@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Fix 32-bit __get_user_asm_u64() when CC_HAS_ASM_GOTO_OUTPUT=y
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:36 AM Will Deacon <will@kernel.org> wrote:
>
> Use the existing '__gu_ptr' source pointer to unsigned int for 32-bit
> __get_user_asm_u64() instead of the original pointer.

Heh. And by "existing" you mean "the one that exists _purely_ for this
exact reason and that wasn't used" ;)

What a silly bug. And it's existed for a year, which I think shows
just how little 32-bit x86 is used these days (*).

            Linus

(*) but also probably how few 64-bit user accesses we do - the fact
that the bug was actually found by the "copy_from_kernel_nofault" code
that just shares the infrastructure on x86 rather than any user access
code is kind of interesting.
