Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A973B6916
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhF1Tbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhF1Tbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:31:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9436C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:29:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ce18-20020a17090aff12b0290170a3e3eb07so769845pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJ6u2k6/dJhmtJ+a/0MHT0Ak2qWLb/bcwrC6FvorPSQ=;
        b=n8uh5BL5JUgY4xOLSY/QFzLUx4h8+eiR4ud8YSIx+mmGU6c63SdHzwx80jLkxQ9F0X
         cXGjXnat+9O9uXio1+z/Ddfrr4DgcSmFCVAscxsdku5pADBHOYwd0tRP0Hko3vanwFOZ
         wGTHwxwKuKFVFh3JknoR1UpDe9WJ3gcTeZd/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJ6u2k6/dJhmtJ+a/0MHT0Ak2qWLb/bcwrC6FvorPSQ=;
        b=Gm9ibBBqefd+ZWE4fHWIjuqQQyoWs2W5BiQ0t0eMv3wiB11RXiRwFK6eB7mjtR4t9w
         r8srurNNo/8K3cUWJDoYsy4o7qD+PEH1b20W+ekg2japR2b11ulttofWxH7spuh6n6kW
         SUxDQXp1t1PKiqA8VbfBkxdQ3LCKRnbUujx0ZqczGJoRltynGD2U9RQTgzEhhYPZV8Le
         SnRmYx3dwVOJgSU3DUhGYIVnCigZ+PdzBjfTZB2y1YNF0TSMpRF90DLJsBAYDKHIof4O
         1sfnDJdpRue0a5ZiP3aGB8RvW2gwV9qJ3OeUPPWyzQmGAxj1DrTzjIHxIn0/m2re1Oy1
         yvTw==
X-Gm-Message-State: AOAM533b2OFa2o4gLJlGx6qrvCZ3PqtoA1BClDa96or5bIdjWPAdXzpO
        BEv1U5Lixo9saRFaabD2xSOQKQ==
X-Google-Smtp-Source: ABdhPJz1uj/MMaj6X3iG0Y158vKYXBq1/oub7G1h8/NnL5WdpAzImby8uj7C6j+B72ZmmUCSgoaJQw==
X-Received: by 2002:a17:902:720b:b029:113:19d7:2da7 with SMTP id ba11-20020a170902720bb029011319d72da7mr23791449plb.55.1624908566889;
        Mon, 28 Jun 2021 12:29:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n12sm14973518pfu.5.2021.06.28.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:29:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Bill Wendling <wcw@google.com>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pgo: rectify comment to proper kernel-doc syntax
Date:   Mon, 28 Jun 2021 12:29:19 -0700
Message-Id: <162490855630.2191955.7188154193447975503.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628055947.6948-1-lukas.bulwahn@gmail.com>
References: <20210628055947.6948-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 07:59:47 +0200, Lukas Bulwahn wrote:
> The command ./scripts/kernel-doc -none kernel/pgo/pgo.h warns:
> 
>   kernel/pgo/pgo.h:112: warning: cannot understand function prototype: 'struct llvm_prf_value_node_data '
> 
> This is due to a slightly invalid use of kernel-doc syntax for the comment
> of this struct, that must have probably just slipped through refactoring
> and review before.
> 
> [...]

Applied to for-next/clang/features, thanks!

[1/1] pgo: rectify comment to proper kernel-doc syntax
      https://git.kernel.org/kees/c/6a0544606ec7

-- 
Kees Cook

