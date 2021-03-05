Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B132F6DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCEXvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhCEXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:51:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC846C061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 15:51:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so4267091ybk.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 15:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pPq2GBjtEGTbACHirO3sey8ygX15UCpeGvoYm9Um0sk=;
        b=PtRIbdn8JBaqxVShA+CtjFu88vBYubaAm1tFH89mUeHx65u8jfjdUEWOyhi3FioeLY
         Kjfoceud2r4uoyWG+ZU767KGl2gnY0SwMl3d8l407sWSPHPlyUOiIfVEK/KRgzkpJU5P
         Zqxd1J+3RUGiYAwPcIFKzvehnJQPgZlac+N37njsgBiDV+eA03pvIjcaDWMMs0iIbcOH
         xJkF/quIBA8a8p/GxdVysovpFlPGiLGa4Eeul/sg+OIzEW3MG3BzStIPJyRo2IOTEwG+
         oFgtdDX6SbKs+5x1YnoaBANAHJpAlHP+ayxmQ84vKMNGP8KqID2KCyRpoI1lt4C9R2E8
         K3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pPq2GBjtEGTbACHirO3sey8ygX15UCpeGvoYm9Um0sk=;
        b=NALrQR9T5R7zJ8Pb1h6l5md18e/3hFQYhXYcK/t6TMZenyiv4q34rMYZ4+uOwGwCAz
         bdtJOLStD7ilEM4vbs/oxTPR9keNfW3/p9qbVEq21Lq/xNUXa1Oh4CLH4z1a2LqPxMqo
         TY6tBZ4JmUgNAMWSL9aDvj3OH64Z3/BzQoFkHWy0Jc03F2SoRFr62lz6+BA7GFCV11Nq
         kyP3keJwmUybZY4pTtCimEmuWD/VGlAU4+vHvcuTTBCBqlw/xExwxdbm5d7syOZv8RLI
         BL1Q9XEzR5HjNaMbe3w0R9Qz7cCk0pdI7YdrvQQLAQsk1c0F30yHRpPIATy1p9ECaYCL
         eNXA==
X-Gm-Message-State: AOAM531kmoTTgKWXfcucI2Mpj5NE82J1eDj/T0OT1hDLGq+vCIz/Ig1b
        SmoEhHAB89dUnc0NoEzpA5/RXzUTyulFeEiFmrk=
X-Google-Smtp-Source: ABdhPJwcjcq2tS5DwOh+XNcqIbmdizHq1xlXoBKH5EIsFXWJYua8EhHBmi8EMhdFw1jp9L3SdHKITvL51kGbc87kavk=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:b008:4ea5:7b83:9aff])
 (user=ndesaulniers job=sendgmr) by 2002:a25:b46:: with SMTP id
 67mr17897674ybl.50.1614988277967; Fri, 05 Mar 2021 15:51:17 -0800 (PST)
Date:   Fri,  5 Mar 2021 15:51:02 -0800
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
Message-Id: <20210305235102.384950-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210303170932.1838634-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [RFC PATCH v2 00/13] objtool: add base support for arm64
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jthierry@redhat.com
Cc:     ardb@kernel.org, catalin.marinas@arm.com, jpoimboe@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, masahiroy@kernel.org, peterz@infradead.org,
        will@kernel.org, ycote@redhat.com, maskray@google.com,
        morbo@google.com, swine@google.com, yonghyun@google.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(in response to
https://lore.kernel.org/linux-arm-kernel/20210303170932.1838634-1-jthierry@redhat.com/
from the command line)

> Changes since v1[2]:
> - Drop gcc plugin in favor of -fno-jump-tables

Thank you for this!  I built+booted(under emulation) arm64 defconfig and built
arm64 allmodconfig with LLVM=1 with this series applied.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

One thing I noticed was a spew of warnings for allmodconfig, like:
init/main.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
init/main.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup

I assume those are from the KASAN constructors. See also:
https://github.com/ClangBuiltLinux/linux/issues/1238

Can we disable HAVE_STACK_PROTECTOR if CC_IS_CLANG and CONFIG_KASAN is set,
until we can resolve the above issue?
