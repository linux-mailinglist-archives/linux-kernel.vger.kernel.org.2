Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E634F85E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhCaFqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 01:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhCaFqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 01:46:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2495C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 22:46:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i6so6224050pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyKECvcFNbdEwZR2rPvSXeCLcNXbCTZojkm3qqGdInU=;
        b=HPtORN9Zda26LMEDXEShqQsuFJNh7+i1RrYiYF+frmrC+hbVsL8wkqq/jVvTKJEpwN
         jkozze9ft7h5eR8mYRppHGJrHtV0O1Ibx2AzkcPEpBj5nt84hJhLektnA4uKeT5s/Q0t
         Ns8JDop/P+paS5lsO4Zh/Ple0GnzQdyQ2Qfw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyKECvcFNbdEwZR2rPvSXeCLcNXbCTZojkm3qqGdInU=;
        b=SPAjInqSY1XPpr0bzx8hCFsjTCclpQL24NLO4Hw5zLycpqXvcstlISzdjKIl6/Gkf3
         Hm5zPFSUMf1ZOKgrQxraJI6KYpUbKiDkc3++NMz7PnSjLA1VbbRRIX03M8YO2jVQ/vLq
         LqUPcxWe6nyWrOm2r4I7vgw7WKAybxezyBeG90WDOTAYeKlOmfPmlwiap329TCOAVV4O
         7iHQs1LSxSYwkFK/q0dF4qWJaD25NWZKituFloJB+UcBd/XdPA7Bw6B1fU2HK75CDqPn
         CUFPCs3cb+pp2wLFp9VoLJlBAVCW3ucYteEVaGWsoo2pjTYE+wgAxMEyShqDu4uy758b
         B21g==
X-Gm-Message-State: AOAM531SQ57mCZ5mQNmFPUkcYlHCXuXxzIo9TIWFaEleFb0cDHCw6Cdg
        ukl7cISbwvgzvO2wK3kISvP+EA==
X-Google-Smtp-Source: ABdhPJzeTRecWFl0sJrD0t/dn+1rBjDWQw3GEU/YxXaizv/ogwLdKDAyQYC8gFVRoGOMNDe/cTQNoQ==
X-Received: by 2002:a63:5517:: with SMTP id j23mr1605345pgb.209.1617169562378;
        Tue, 30 Mar 2021 22:46:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144sm827866pfy.75.2021.03.30.22.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 22:46:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     luto@amacapital.net, wad@chromium.org, yifeifz2@illinois.edu,
        Cui GaoSheng <cuigaosheng1@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next] seccomp: Fix a typo in seccomp.c
Date:   Tue, 30 Mar 2021 22:45:54 -0700
Message-Id: <161716955301.433254.8403624702001818656.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331030724.84419-1-cuigaosheng1@huawei.com>
References: <20210331030724.84419-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 23:07:24 -0400, Cui GaoSheng wrote:
> Do a trivial typo fix.
> s/cachable/cacheable

Applied to for-next/seccomp, thanks!

[1/1] seccomp: Fix "cacheable" typo in comments
      https://git.kernel.org/kees/c/a3fc712c5b37

-- 
Kees Cook

