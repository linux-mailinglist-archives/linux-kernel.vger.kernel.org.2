Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE63992EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFBSzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhFBSzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:55:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0DC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:53:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so2332310pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/u01NxBR4WIaIJs671ZPTlfTpvEAMlzOczPwymjQHEg=;
        b=VgFYDG/rqu7GAK2nOyTtQDH4Bmh/j0nPd2fyHKGmbrBffrkUJkAZ0+NeZN75W8Lvpm
         F2wPBO4XzWxjxVgnghBSkhe+e2BbKjSXtD3zINRBiuieOx2U0lk3jHWFCyGhEgWc+1fc
         N5hDGeW0/88AM8Dzrsgdcnq/wNehVCvdr5glM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u01NxBR4WIaIJs671ZPTlfTpvEAMlzOczPwymjQHEg=;
        b=jLNrtbeH6khFaFz1GEVVrNiWC/gPVzyNlQ9U2i832KVVw49Qv1aqXRzeqtXuLoKdH0
         cizohm96sr83PfIVyxgNC0YXRfJ7FHaIpN1YCp7bRzl/Ckr8zuMBKtEd5SxTAz6T5sEd
         UN/mUj5Knrnvwj/FYk86zqEg0SlQoPv5ECdQ4pmcfBLJw/fsbZILWiiVIWTeKCstAvgx
         4hU2SCnBbJj2sXp4Fm1/kwSthfa2Y8v+UbRlq1jW1evlrooADdrkoxomcL8FUeRVbYR/
         NnJsjdy1hMk7BqodxtwUojqsH7mKLTItvM/L1tWDJ/W3wxAn9VtwloRzd2pBbULkLW6U
         YZTQ==
X-Gm-Message-State: AOAM532z/gwWyV3v/q+iJmufu/XfVyFyER8iRo/cchh/Lbgfns3pnnh8
        FCuMQfM6powzRgGO9ve3aUGB1A==
X-Google-Smtp-Source: ABdhPJxy6qaxGw5oj6Jjyxm5+8QqoB1gqrX5a2gJzXsdvPLWd0S8l8XPo+JEJTAORX1pE9WkRqAYnQ==
X-Received: by 2002:a17:90b:4b04:: with SMTP id lx4mr7001525pjb.54.1622660013889;
        Wed, 02 Jun 2021 11:53:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s12sm244590pji.5.2021.06.02.11.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:53:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] CFI: Move function_nocfi() into compiler.h
Date:   Wed,  2 Jun 2021 11:53:28 -0700
Message-Id: <162266000535.3595232.17293899929853400709.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602153701.35957-1-mark.rutland@arm.com>
References: <20210602153701.35957-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 16:37:01 +0100, Mark Rutland wrote:
> Currently the common definition of function_nocfi() is provided by
> <linux/mm.h>, and architectures are expected to provide a definition in
> <asm/memory.h>. Due to header dependencies, this can make it hard to use
> function_nocfi() in low-level headers.
> 
> As function_nocfi() has no dependency on any mm code, nor on any memory
> definitions, it doesn't need to live in <linux/mm.h> or <asm/memory.h>.
> Generally, it would make more sense for it to live in
> <linux/compiler.h>, where an architecture can override it in
> <asm/compiler.h>.
> 
> [...]

Applied to for-next/clang/features, thanks!

[1/1] CFI: Move function_nocfi() into compiler.h
      https://git.kernel.org/kees/c/2d35ea27e0df

-- 
Kees Cook

