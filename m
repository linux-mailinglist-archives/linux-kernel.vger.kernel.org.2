Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9759C39E9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFGXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:06:33 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:33734 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFGXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:06:31 -0400
Received: by mail-pf1-f170.google.com with SMTP id p13so4680528pfw.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AC7ETe/Kt1WLEutUgZPZdc1iSopXvmHhdI0/unFkmvs=;
        b=MMHel72NC1D0A7WaTADJmda+jzPEBlM3bb266TB8/JSzH8olHfja9709kcRlw3HDvc
         d1xPk9YIdjN6YWLBydAR+LuuOwxsbE5JZC7hYiGReT9WSIW7AjO/QgZ5sIT+URVzBPGu
         oLQpbN09TkPNgR39bpbPAGD6IUDWXosGmrBaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AC7ETe/Kt1WLEutUgZPZdc1iSopXvmHhdI0/unFkmvs=;
        b=q9QhDwKFv8EWylg6X8UOdZVZL1q9SX3Edwc2Vb+ebEf89PsDT3SEwMyldrfXGhl77H
         01mfDP8I7LrRnj0mjC2XgWMo/bdU3NqGDPOpybkSsj4YOcvs8vzEif9aI7DZx3qIsdVa
         AO3jHC/h461Uj1qtwrivSRiveDLWPnG+UqU2HAISZ+Erjp1qLN6CFdxuZvY+IH65c4z9
         5DSPeXE2JRy1gVSuOj/Idiw5b2/kxZcZ7/odpoD++rHdFJqne2zsp6fLou1il4Fo8Qg2
         0JglBwNR/g8sRkFKZ5q03wXjV5JWSvQeFvxVtR8vl92wBATqdAroaoNmhYMdK+tTav9/
         M2Sg==
X-Gm-Message-State: AOAM5312FWvTHzrV3JIxHT5bEFMeklsQ/su5en9yOfsTYHghh+D9sD2l
        emym+74V6pR76cPUZWdB723kOw==
X-Google-Smtp-Source: ABdhPJyMDbHyZ9CI2wm+wN5OplDQsY5BDNAhKyDoiiiNzgKSwU8MI0gwXC3bwfiYlcEy3P8PgbDtkg==
X-Received: by 2002:a65:4289:: with SMTP id j9mr19957133pgp.165.1623107005679;
        Mon, 07 Jun 2021 16:03:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gn4sm13179703pjb.16.2021.06.07.16.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 16:03:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, morbo@google.com
Subject: Re: [PATCH v3 1/1] pgo: Fix sleep in atomic section in prf_open() v3
Date:   Mon,  7 Jun 2021 16:02:51 -0700
Message-Id: <162310696843.3797458.16031727600580374864.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605183128.129614-1-jarmo.tiitto@gmail.com>
References: <20210605183128.129614-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 21:31:29 +0300, Jarmo Tiitto wrote:
> In prf_open() the required buffer size can be so large that
> vzalloc() may sleep thus triggering bug:
> 
> ======
>  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:201
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 337, name: cat
>  CPU: 1 PID: 337 Comm: cat Not tainted 5.13.0-rc2-24-hack+ #154
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Call Trace:
>   dump_stack+0xc7/0x134
>   ___might_sleep+0x177/0x190
>   __might_sleep+0x5a/0x90
>   kmem_cache_alloc_node_trace+0x6b/0x3a0
>   ? __get_vm_area_node+0xcd/0x1b0
>   ? dput+0x283/0x300
>   __get_vm_area_node+0xcd/0x1b0
>   __vmalloc_node_range+0x7b/0x420
>   ? prf_open+0x1da/0x580
>   ? prf_open+0x32/0x580
>   ? __llvm_profile_instrument_memop+0x36/0x50
>   vzalloc+0x54/0x60
>   ? prf_open+0x1da/0x580
>   prf_open+0x1da/0x580
>   full_proxy_open+0x211/0x370
>   ....
> ======
> 
> [...]

Applied to for-next/clang/features, thanks! I made some additional tweaks
on top of this, in a separate patch I just sent out.

[1/1] pgo: Fix sleep in atomic section in prf_open() v3
      https://git.kernel.org/kees/c/d13b0485a7bb

-- 
Kees Cook

