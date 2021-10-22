Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFD437EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhJVTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhJVTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:36:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77339C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:34:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w23so3271756lje.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vBd1duKKeiwwgrbJ6Sx7Bi57HhQ5rfNP7Q41l3kvVU=;
        b=GmA0uidbgF4bNbkN4ZjQ/dxxiLgUrTbvSAFJ/k7eUb/VzsL0DBQZYOT4K6mZ8R+OZQ
         We+jQ9aeC6/7nQuDVKO6wVc48enmhrvINQIgqy6KUVQPv+LIT+8Lyj45v94l6N/St171
         N4ozbEyt1R7fn0yaLKOCyAO/c9pXn4ao7vn+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vBd1duKKeiwwgrbJ6Sx7Bi57HhQ5rfNP7Q41l3kvVU=;
        b=Rw8lWhy/NQSq65FDLDA4K9n7LH4/DraJqd/9UuV+Ih8ujZVVxhpmO+tqKZWx/RbwQy
         vgfRQefUPzStRgfl/gQZvmlc/81+19Re4Vimw1IZy0eqw7Fmci6cMe6ioula2oWOVV95
         GbvkWmBy6ypqQRw0vyRNiiaToYpEwGGjBUBrKrYEkWdzhlDp8MF3f+rub+2354IOnFM3
         DilhvVIOa2vDBbf5sPZpG+21lHmoAFl5KB5Bxz0a71nkjlEa8Uabomr8GaP1e87CKkFP
         n4QF3cU6m04Aw8c7W4A/vTPBYbeQqi304aclUQpWsmgWxW4cvpBQbiBfktJmcWHBEcg4
         sFcA==
X-Gm-Message-State: AOAM533AmP1mMNQFXoF9r+4Xrf2raabyJ1yeZ02cZaOZ3CXmzlLZJRHd
        PLdXWNYtSljTUpQpXVPPxCgCen+ypowU//5yn5A=
X-Google-Smtp-Source: ABdhPJw3GIChCQmmmeySmcB27rnuMnS0CQDpsDQMRhLvfWNeHWGZ3mxMrj2gI2BG590VOjaKkHzvVw==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr1965042ljp.239.1634931273195;
        Fri, 22 Oct 2021 12:34:33 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z5sm815855lfr.96.2021.10.22.12.34.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:34:32 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p16so26513lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:34:31 -0700 (PDT)
X-Received: by 2002:a05:6512:2245:: with SMTP id i5mr1436398lfu.655.1634931271702;
 Fri, 22 Oct 2021 12:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211012141131.3c9a2eb1@gandalf.local.home> <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
 <20211012145540.343541e9@gandalf.local.home> <CAHk-=wg6fw130AkO72GPFow9PHvP9odnC5LZ0UaY9bJQuF-C5A@mail.gmail.com>
 <20211022083845.08fe5754@gandalf.local.home>
In-Reply-To: <20211022083845.08fe5754@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:34:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
Message-ID: <CAHk-=wird-sCbSG3KxNavdD-mFWO1YkT2Qjoeb0Z1Ag4QDNwuA@mail.gmail.com>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 2:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It finally triggered again. And this time with this patch applied. But I
> don't see the added printks anywhere in the dmesg.

That's strange. Those printk's were added in the only places that do a
"return 0".

Ok, there's also the dummy pud_set_huge() inline function that
unconditionally returns zero, but that's only if you don't have
CONFIG_HAVE_ARCH_HUGE_VMAP enabled. And then the testing code is
disabled too.

> [  178.714431] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [  178.723726] ------------[ cut here ]------------
> [  178.728389] WARNING: CPU: 2 PID: 1 at mm/debug_vm_pgtable.c:492 pud_huge_tests+0x42/0x68

That's literally that

    WARN_ON(!pud_set_huge(..));

and pud_set_huge() has two 'return 0' (and one 'return 1') and that
patch added debug-printing to both of them.

Oh, it shouldn't have been a pr_debug() that gets suppressed. It
should have been a pr_warn() or something.

My bad.

                   Linus
