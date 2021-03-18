Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9F340020
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCRHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhCRHRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:17:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67451C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:17:18 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f12so3379242qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agahROSdNuYhnd8y/3W/h5Jobfh9gncs4vepyfROKvE=;
        b=N57/fquyusnFq2i1WukCANUsn/VWGd/JcxBmJwiYv1dqXyfK5jTmFE1cX56n9bHkje
         4nVZzUHfVfSdTojCwkbBdz6JbEK1qf4KREVfvoxLedEXoR3Rtjf/8kqdZtP1m2wtO1Dz
         uNwiR/vK7dyFKMveR+M35ECjcM4/V2+XtybNBn27axyt66kFGg9QMMWW+YTVmD+nUEBE
         MVO/QrGozDKHpLtsdMqm1rVMe0xV+pjPBmHI+vlFFqfaGCZr5cIQ0ZWbo+4V91/pjQ4a
         GqKtpDY7X6N0KaYEUgBvNIEU4rYODSa0X05b42YXI8icBc7o/xYcHvlJ0myDwDJ6vL+b
         LjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agahROSdNuYhnd8y/3W/h5Jobfh9gncs4vepyfROKvE=;
        b=jElMFUzwgj2s9KcNp5wKc/sa7M9OaKsZo+eEuQEhfXIvS6JDdfEDUzzqjQ2ZlZOLvH
         hdcoFRttgLAe9gHy89IS9smCL9HbZKPn8Igz00qV33CyNs6AQuJtENjtmx/xy8n76H6g
         VTp4Qpzg8zJdbPEwUli6OoH0k0TJqXe/t2BJr7CoWXSwJUTYuU2TMQFAgrt2sfJhlf4f
         m3WeRiToBjCw31Q6OBqSUF3ylLPtHc+7Tl7P5MY9p0wY4Xjbvvcu1og9nBjD4GOIGqVr
         7W1XP9hKxsuH92OqLS7CgavVAYCUNZdEnfIM/VS1yW6tDXb3PXhGOzHfwXXAylJBYW03
         3d2g==
X-Gm-Message-State: AOAM530pVf/GBHXVQcJc8LP/CH+IoHkHYFvpFle0sB3edI+PvoBDdpKZ
        vviBIZK1FjRTJ0h0AIpXEc4SPDT55jbz2JRze7b6oA==
X-Google-Smtp-Source: ABdhPJztJebNgbyxGUiKce5xs+p0MV41pcvBqJTiW66+5/EOzNYCxyIlHRjF0408epy3JDA4b4uEzAocO7Y7usNWGXE=
X-Received: by 2002:aed:2c61:: with SMTP id f88mr2438071qtd.337.1616051837341;
 Thu, 18 Mar 2021 00:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210211080716.80982-1-info@alexander-lochmann.de>
 <CACT4Y+YwRE=YNQYmQ=7RWde33830YOYr5pEAoYbrofY2JG43MA@mail.gmail.com>
 <01a9177f-bfd5-251a-758f-d3c68bafd0cf@alexander-lochmann.de>
 <CACT4Y+ZPX43ihuL0TCiCY-ZNa4RmfwuieLb1XUDJEa4tELsUsQ@mail.gmail.com> <46db8e40-b3b6-370c-98fe-37610b789596@alexander-lochmann.de>
In-Reply-To: <46db8e40-b3b6-370c-98fe-37610b789596@alexander-lochmann.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 08:17:06 +0100
Message-ID: <CACT4Y+bdXrFoL1Z_h5s+5YzPZiazkyr2koNvfw9xNYEM69TSvg@mail.gmail.com>
Subject: Re: [PATCH] KCOV: Introduced tracing unique covered PCs
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:10 PM Alexander Lochmann
<info@alexander-lochmann.de> wrote:
> On 15.03.21 09:02, Dmitry Vyukov wrote:
> >>> Does this introduce an additional real of t->kcov_mode?
> >>> If yes, please reuse the value read in check_kcov_mode.
> >> Okay. How do I get that value from check_kcov_mode() to the caller?
> >> Shall I add an additional parameter to check_kcov_mode()?
> >
> > Yes, I would try to add an additional pointer parameter for mode. I
> > think after inlining the compiler should be able to regestrize it.
> First, I'll go for the extra argument. However, the compiler doesn't
> seem to inline check_kcov_mode(). Can I enforce inlining?
> I'm using GCC 9.3 on Debian Testing.

That's very strange and wrong. Maybe you use something like
CONFIG_CC_OPTIMIZE_FOR_SIZE=y?

With gcc-10 I am getting:

ffffffff81529ba0 <__sanitizer_cov_trace_pc>:
ffffffff81529ba0:       65 8b 05 59 53 af 7e    mov
%gs:0x7eaf5359(%rip),%eax        # 1ef00 <__preempt_count>
ffffffff81529ba7:       89 c1                   mov    %eax,%ecx
ffffffff81529ba9:       48 8b 34 24             mov    (%rsp),%rsi
ffffffff81529bad:       81 e1 00 01 00 00       and    $0x100,%ecx
ffffffff81529bb3:       65 48 8b 14 25 40 ef    mov    %gs:0x1ef40,%rdx
ffffffff81529bba:       01 00
ffffffff81529bbc:       a9 00 01 ff 00          test   $0xff0100,%eax
ffffffff81529bc1:       74 0e                   je
ffffffff81529bd1 <__sanitizer_cov_trace_pc+0x31>
ffffffff81529bc3:       85 c9                   test   %ecx,%ecx
ffffffff81529bc5:       74 35                   je
ffffffff81529bfc <__sanitizer_cov_trace_pc+0x5c>
ffffffff81529bc7:       8b 82 d4 14 00 00       mov    0x14d4(%rdx),%eax
ffffffff81529bcd:       85 c0                   test   %eax,%eax
ffffffff81529bcf:       74 2b                   je
ffffffff81529bfc <__sanitizer_cov_trace_pc+0x5c>
ffffffff81529bd1:       8b 82 b0 14 00 00       mov    0x14b0(%rdx),%eax
ffffffff81529bd7:       83 f8 02                cmp    $0x2,%eax
ffffffff81529bda:       75 20                   jne
ffffffff81529bfc <__sanitizer_cov_trace_pc+0x5c>
ffffffff81529bdc:       48 8b 8a b8 14 00 00    mov    0x14b8(%rdx),%rcx
ffffffff81529be3:       8b 92 b4 14 00 00       mov    0x14b4(%rdx),%edx
ffffffff81529be9:       48 8b 01                mov    (%rcx),%rax
ffffffff81529bec:       48 83 c0 01             add    $0x1,%rax
ffffffff81529bf0:       48 39 c2                cmp    %rax,%rdx
ffffffff81529bf3:       76 07                   jbe
ffffffff81529bfc <__sanitizer_cov_trace_pc+0x5c>
ffffffff81529bf5:       48 89 34 c1             mov    %rsi,(%rcx,%rax,8)
ffffffff81529bf9:       48 89 01                mov    %rax,(%rcx)
ffffffff81529bfc:       c3                      retq

Oh, wait gcc-9 indeed does not inline:

0000000000000070 <__sanitizer_cov_trace_pc>:
      70:       65 48 8b 0c 25 00 00    mov    %gs:0x0,%rcx
      77:       00 00
      79:       bf 02 00 00 00          mov    $0x2,%edi
      7e:       48 89 ce                mov    %rcx,%rsi
      81:       4c 8b 04 24             mov    (%rsp),%r8
      85:       e8 76 ff ff ff          callq  0 <check_kcov_mode>
      8a:       84 c0                   test   %al,%al
      8c:       74 20                   je     ae
<__sanitizer_cov_trace_pc+0x3e>
      8e:       48 8b 91 b8 14 00 00    mov    0x14b8(%rcx),%rdx
      95:       8b 89 b4 14 00 00       mov    0x14b4(%rcx),%ecx
      9b:       48 8b 02                mov    (%rdx),%rax
      9e:       48 83 c0 01             add    $0x1,%rax
      a2:       48 39 c1                cmp    %rax,%rcx
      a5:       76 07                   jbe    ae
<__sanitizer_cov_trace_pc+0x3e>
      a7:       4c 89 04 c2             mov    %r8,(%rdx,%rax,8)
      ab:       48 89 02                mov    %rax,(%rdx)
      ae:       c3                      retq

This looks like a bug in gcc-8/9. gcc-6 inlines again as well as
clang-11/12 inline.

Please add __always_inline for check_kcov_mode.
