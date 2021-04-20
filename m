Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE5366013
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhDTTLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhDTTLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:11:17 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:10:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q10so27305186pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=a5n3wGy7DgfFWhHeggplxhAWu+1dp4NYqrnny8w9BKQ=;
        b=XkMEI+OjTSg5iTaX6sY4VYoIWR9CRe9aSpLkUoXqRVNXCQf29/EMOGfsKR0iFiYCQh
         JZE1/e9VSnux5u1qX2DI/w5CM/p2VmX031bYG/DmJA4diVqApRtKcrWcHDphwyzrHyFo
         deunhK3ls4wK2xRH7vt7wdAwlMyV1BDxEQ3kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=a5n3wGy7DgfFWhHeggplxhAWu+1dp4NYqrnny8w9BKQ=;
        b=XUDVb1shqt8dzERHPYcnCwzkgUL/RhFWeSmwHzGMwi+c0JPil2lZeBuiLA9VIwq+/5
         Ldebsy0yrsFaD/Bw1P/FGILibsMMgfWqBM3wE/oXOC7Y7f72Q/eBTwQMXvb87NerpKvE
         tvB+uyDvyMrubQa9eTYY2g0uL8JdgDyg/ykJZ10lt3zrwra/95prQyodVnfo1wTetvt3
         LzbEVpoXmpyreUPnuavDakMIa9tR5kRQjH85+OEGRQVRQt+QqgpPYGkXCdN0Ec2AK2bR
         5FXqA0SQGlAxYIfEPqFhBlIQdMcAy3apycMvULXoamSHOPgANE8Cm051fRuEp9cxAVw3
         sNbQ==
X-Gm-Message-State: AOAM532mJfFuHTHGjyEj5azY1udJZxr3jsphuI43a1cAZtkosFuSji5d
        urX33KfBXk7KC0m9vMFCpxCsyw==
X-Google-Smtp-Source: ABdhPJyMYlZ5dSRgEX0LT2mEoW3cJ7AIUGF+KXPoFqlADnn89SvbQNe4DAdQzQTmaP+hu/FRVgaosQ==
X-Received: by 2002:a17:90b:1190:: with SMTP id gk16mr6398246pjb.57.1618945845057;
        Tue, 20 Apr 2021 12:10:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id w123sm12213408pfb.109.2021.04.20.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:10:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210420174427.230228-1-ndesaulniers@google.com>
References: <20210420174427.230228-1-ndesaulniers@google.com>
Subject: Re: [PATCH v3] arm64: vdso32: drop -no-integrated-as flag
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     vincenzo.frascino@arm.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Date:   Tue, 20 Apr 2021 12:10:42 -0700
Message-ID: <161894584244.46595.3366888884991252865@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Desaulniers (2021-04-20 10:44:25)
> Clang can assemble these files just fine; this is a relic from the top
> level Makefile conditionally adding this. We no longer need --prefix,
> --gcc-toolchain, or -Qunused-arguments flags either with this change, so
> remove those too.
>=20
> To test building:
> $ ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- \
>   CROSS_COMPILE_COMPAT=3Darm-linux-gnueabi- make LLVM=3D1 LLVM_IAS=3D1 \
>   defconfig arch/arm64/kernel/vdso32/
>=20
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---

It boots for me and compat vDSO seems to work properly per
tools/testing/selftests/vDSO/, userspace programs aren't crashing right
and left, must be good:

Tested-by: Stephen Boyd <swboyd@chromium.org>
