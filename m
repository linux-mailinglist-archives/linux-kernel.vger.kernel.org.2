Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9339BF35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFDSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFDSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:01:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED91C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:59:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 69so5051928plc.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pfMgGstv1iK+qTrHiOBb+KFwv6lJ4pEJizPyxTuhpd8=;
        b=ZVv2D1Opt4rD8W5TQXM6xKheRBRfaWSruA6TejzNbcL1N7POp8z7bUD9U3U9y18Sht
         VGtOsT2gBDsB//tdzBuHWBfKEhtcDU07bBrSPdLUiD/aoaeyW2dFJJdSOrtcYKUvzUmW
         cYotmoQ0gUBpWZaUCBjh58Yetu9C5Qk01IppI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfMgGstv1iK+qTrHiOBb+KFwv6lJ4pEJizPyxTuhpd8=;
        b=eEGjRonNM7swGZN+WEvKIoR0ouqanxUGs3NA5PRcHtTXo32VINh3dUiM0u4bAnuzBM
         ziYa4/yTmvnb3iP5aCPTK/0hA1L/deDgur2Uuemyh1vw2fEbQ27CB/bGUWHyASVcYBpx
         MFGh0F+OvMdPG+V7xUS5FrLkr+bJhUAbWePNd6ux+S1Y768mHMIvNUr3u4cXpUT51sY0
         +JTDIjAcB8PAHiqAsTDBn51hZE8pZ0JZYWKLN1/+vUAv1/hdhWvFZZxAPq/ipnudCz1q
         GYAPXWYlYVN2LhCMo6mT2BO9sOKrxDLlNtp0YRqKOnuQxQZlD0sjjANmISRENEuRIV23
         UeFg==
X-Gm-Message-State: AOAM533LoUdlKM6E6fcv6PgMpPlKBf0el6jIqYKtjkGQUwtByZlavnQC
        UglNURqOLYHfpsFoxPDMXBqhQg==
X-Google-Smtp-Source: ABdhPJxELCdVZyhpWlBE3CbIkT8Dv/IxRLhOFnxugy4/6FDRRXuX+YqrMlrTflk2lRdQywjTsPNm7Q==
X-Received: by 2002:a17:903:1243:b029:107:eca4:d5bf with SMTP id u3-20020a1709031243b0290107eca4d5bfmr5410080plh.15.1622829593519;
        Fri, 04 Jun 2021 10:59:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o10sm2274012pfh.67.2021.06.04.10.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 10:59:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>, morbo@google.com
Subject: Re: [PATCH v3 1/1] pgo: Fix allocate_node() v2
Date:   Fri,  4 Jun 2021 10:58:38 -0700
Message-Id: <162282951519.3080953.11346638083845350363.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
References: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 19:58:20 +0300, Jarmo Tiitto wrote:
> When clang instrumentation eventually calls allocate_node()
> the struct llvm_prf_data *p argument tells us from what section
> we should reserve the vnode: It either points into vmlinux's
> core __llvm_prf_data section or some loaded module's
> __llvm_prf_data section.
> 
> But since we don't have access to corresponding
> __llvm_prf_vnds section(s) for any module, the function
> should return just NULL and ignore any profiling attempts
> from modules for now.

Thanks for working on this! I tweaked the commit title, reflowed the
commit log to 80 columns, and adjusted asm-generic to asm.

Applied to for-next/clang/features, thanks!

[1/1] pgo: Limit allocate_node() to vmlinux sections
      https://git.kernel.org/kees/c/46773f32ddf1

-- 
Kees Cook

