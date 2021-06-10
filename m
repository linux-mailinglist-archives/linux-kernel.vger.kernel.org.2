Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175253A3786
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFJXCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:02:24 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:43613 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:02:20 -0400
Received: by mail-lj1-f174.google.com with SMTP id r14so7066298ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yw9883lOQsTBsg7LahgHA67J+KddRcIMo0xgHJmKbbQ=;
        b=FVQt1+qEc21VCuHV2iIq+JgAJa6a0iqGm0fReArOGax6cfQwk6Zuv9SNpU/8RTa4Ph
         8DOm8xVSZAZjhrN+NVMPN9z1ENomMpsp9a3ePARPSqVYDweYT/Zv9n5DOZDw4PA5nL72
         SrGIpSAPMfadzA0+R98OVL5tIy+bc70kLsVNDfot1G62YbLNDyY3JbxlBLNvFfB1W5UC
         eloqFcjiZIhf5+4YlRF+xIf8o4Xk+DvUxw4w0vrFHrF88j3j+Ce+/CoHOviOcgjbs5WP
         B0Ncecy8xTwAy+xpfyMT0zMwGRobgt0kFe1WKnpAhkc+g/i9ybbVWkkLvoBqBBx7dxrr
         Og5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yw9883lOQsTBsg7LahgHA67J+KddRcIMo0xgHJmKbbQ=;
        b=uGgw3bX/xQZqGstGKHoy11mbIwxeNWlVayW/+kc6sBVHJnvdUb1cYNTJT6KTxrwc4I
         Ruf8An5jCLSxpoeUSVNmqMQqd/W+jCxHgbu4xtZ7hT79HTk7cKhSII3jSEgW1kgFGGm1
         vZqLosxkUolFcK2PjdyzDEPcRFBeXSlD6B2iQcEWCp1yu7HOEy8NmcbZljNV9T0roQzB
         qgGce72jaelSxLrSZVyUuCQh3txSu7/I/QauAps3wLCYA1W42Nxn/DJjeaWAICFliXKf
         RLeTeTkZR/i5/zTQOCUOhaAtWK8gKkpVp0x7XnHZo3Y4iOddNBPN0GOyH2Q2nndipsBP
         J/6g==
X-Gm-Message-State: AOAM531dVTI9HFbFeN9bb82UgkCkmvQHMzgGeunw+Oxw1HwJQC8psDJI
        e2phpU9uy1lFRsFF08/wZAe756Zdft0hcEGtxADkDA==
X-Google-Smtp-Source: ABdhPJzaZLInL/KPTr80V7gDwPi/U+TLSzDotbTKrBHkdXyNTCdWC4enXRsYu0wTGc3Q1IHuPoUIyAg+uIx21ZN7H78=
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr666072ljo.116.1623365949235;
 Thu, 10 Jun 2021 15:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org> <162336538453.1311648.12615336165738957417.b4-ty@chromium.org>
In-Reply-To: <162336538453.1311648.12615336165738957417.b4-ty@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Jun 2021 15:58:57 -0700
Message-ID: <CAKwvOdmYVH-YpEVqdoBfvgNfcbzx71jU_27cuhuzTJ6_Emzi-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional on
 LLD < 13.0.0
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Tor Vic <torvic9@mailbox.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, 10 Jun 2021 20:58:06 +0000, Tor Vic wrote:
> > Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
> > [1], leading to the following error message when building a LTO kernel
> > with Clang-13 and LLD-13:
> >
> >     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
> >     '-stack-alignment=8'.  Try 'ld.lld --help'
> >     ld.lld: Did you mean '--stackrealign=8'?
> >
> > [...]
>
> Applied to for-next/clang/features, thanks!
>
> [1/1] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
>       https://git.kernel.org/kees/c/e6c00f0b33ad

Can we get this into 5.13?
-- 
Thanks,
~Nick Desaulniers
