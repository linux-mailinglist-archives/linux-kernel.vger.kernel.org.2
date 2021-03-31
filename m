Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAA134F8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhCaG11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCaG1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:27:23 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 23:27:22 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so17958323oto.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sF5WozdBJmyPKvj2P6gw4/RQCSw6hh0JnZDsTcYbyNA=;
        b=KPtTWwux5CuUXLu+fExIiRkoL9tV4ca+NKURBr8lgYE8B+wppYGWt/s4YKowSqTZYu
         1uqfv82mfK+FYrX+LbJRxrM6IBiSrxlfTfTNWaEUfcnQhfmv7OB7o1uRUZadaihLG863
         dBJM3w3pZcv/TOpTrBKx42UUBfKRtVJnmDqcMlVkkgVYe3FhGKJ9LPOxtR9+Z5VcBGiv
         vcYFTP0Kq2ixqMt6qMTC33D0Sj/ewqSRoobN4wbl3t7QGdAXtZgx5prccDlMfRhetDL7
         qxSuKSs51rF76YIMPB1RucoSniaPrqiRMjhHuOxqFEUYsm3CpQX6aoeVB1Vnbl+Y+grz
         S3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sF5WozdBJmyPKvj2P6gw4/RQCSw6hh0JnZDsTcYbyNA=;
        b=nlphDB0hsFC8zdD2gLsS5QKHRsivGXyLnzlDvywR56xWrKu1eYY2qYEzSDoSvxSuHi
         WS7wHkmz6hnjNvE55A/jormYRDEDKIQ8MOsJL5Jmlvv0t882kZ/WlowfdXYHhcHJfZR5
         65buv8z0jdmeVdCs7y7hTyzDJVko+M66brc2HduGZdVQwHTpaxCdNyXjHCLbzScrNzNU
         XQvwnixhT5cxZOwioeNu2ur6Gp3zVes1VYpPyqvrYgH5+IQoKsYxsI180J7JiQA7K7lc
         zKRg+1nacDigCBoS42ZmO5Jnqw33L04ryQC5D/7eladJor1CD/tKQzzQYP1T4hBmEU18
         Oy8g==
X-Gm-Message-State: AOAM532MNOZhCM6549Shd1htKe1we3c2IaBjJtquh42l0iwC9AoFF0bo
        01Brmg7O2/HAE6rWJGzS+2T3DdhRaKCsKQHz/u3hDA==
X-Google-Smtp-Source: ABdhPJyAo2IPTy/IqlNciRu6mqCd/25ObkTlTaFKL5Tf8ItFwwaj3JGTrqtFjpWgez1okCdEpLwMS3wRUBDs9Acl6lw=
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr1492294ote.324.1617172042227;
 Tue, 30 Mar 2021 23:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210331020207.l56wft5mjucieg2k@yadavpratyush.com>
In-Reply-To: <20210331020207.l56wft5mjucieg2k@yadavpratyush.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 31 Mar 2021 08:27:11 +0200
Message-ID: <CAHUa44Hk24NGw_b46-F2xpHNj9Rj5hw-=ERKGg99N-1SjjeUOA@mail.gmail.com>
Subject: Re: Build breakage in next-20210330 due to optee_trace.h
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On Wed, Mar 31, 2021 at 4:03 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi,
>
> I recently rebased a dev branch on top of next-20210330 (4143e05b7b17)
> and I notice a build error from the optee driver:
>
>   In file included from drivers/tee/optee/call.c:18:
>   In file included from drivers/tee/optee/optee_trace.h:67:
>   ./include/trace/define_trace.h:95:10: fatal error: './optee_trace.h' file not found
>   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/trace/define_trace.h:90:32: note: expanded from macro 'TRACE_INCLUDE'
>   # define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
>                                  ^~~~~~~~~~~~~~~~~~~~~~~
>   ./include/trace/define_trace.h:87:34: note: expanded from macro '__TRACE_INCLUDE'
>   # define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/stringify.h:10:27: note: expanded from macro '__stringify'
>   #define __stringify(x...)       __stringify_1(x)
>                                   ^~~~~~~~~~~~~~~~
>   ./include/linux/stringify.h:9:29: note: expanded from macro '__stringify_1'
>   #define __stringify_1(x...)     #x
>                                   ^~
>   <scratch space>:135:1: note: expanded from here
>   "./optee_trace.h"
>   ^~~~~~~~~~~~~~~~~
>   1 error generated.
>
> The config is attached. I am building using clang.
>
>   $ clang --version
>   clang version 11.1.0
>   Target: x86_64-pc-linux-gnu
>   Thread model: posix
>   InstalledDir: /usr/bin

Thanks for reporting, this should hopefully be taken care of by
https://lkml.org/lkml/2021/3/25/2

Cheers,
Jens
