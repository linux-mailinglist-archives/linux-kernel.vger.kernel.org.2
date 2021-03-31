Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AD3507B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhCaT4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhCaT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:56:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:56:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so1833336pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yVMQM63PjcObiBb0oRU4zW/nYZYAUpEebncM6/pp2o=;
        b=JBuP+/jfJ+NrzwEQ20bIwN0qlX6QRN6AmPz70dknhyQ2INu0qfYigIqNcW0xFedBlV
         xQf5RkQDJ/skE4+rekPcOkrhCWe4SeSqAXkMuakn2S2+vjrVnv2XBQ+cs1UhuMy+2Gna
         iH7QejzLyAgWxgvH2UNo92+kxrKsiWiaW2bMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yVMQM63PjcObiBb0oRU4zW/nYZYAUpEebncM6/pp2o=;
        b=BGLk39YhalzLjuDQeJXY0EJMcaGeWLLxevofDUp2RQ8J6DF6XhMq6oEGoD/OqVrQge
         ls3AwR8nuuoRrwdJbiJ6c04j5US+wzV5NLf867Hmg7KVgcpoLh7OYaWnaeF5lsfX1v23
         i6K2FZpdkcXxROfFdkZZBWkVCqy85PGjcTw5LyzIq+bD7aepoLL6TVlRB3X8va1SPKl8
         //KTXdhlwFcVQfjxD3aQULV/gN8gxCu22g8VJ68j3Glu0RYzHJE/10b/CPd1OXonWpXr
         D9WktmqAwJ1e5ZiTzxZbNzhNSye1JUt81xDdRmSFRKDlrPv+T4pUZCYIKbTIsUfjjyGE
         Sgww==
X-Gm-Message-State: AOAM530nWvUnlX2Stp4hXY00a7yBoQjkoGEEv9idtuFEVJe2uWAR6+Yv
        nG5+lYenx6YwJr/u8jMgWa+8wQ==
X-Google-Smtp-Source: ABdhPJyURfcz9EDNELOeDtoZrmz4xlbjZmZib1mS3eADG+82k71SN8I1SidrNhk1Yq7veEiZDAX/Ig==
X-Received: by 2002:a17:90a:f02:: with SMTP id 2mr4975428pjy.209.1617220576022;
        Wed, 31 Mar 2021 12:56:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm3109303pfi.175.2021.03.31.12.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:56:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Merge module sections if and only if CONFIG_LTO_CLANG is enabled
Date:   Wed, 31 Mar 2021 12:56:02 -0700
Message-Id: <161722055925.1870138.4983509937620008210.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322234438.502582-1-seanjc@google.com>
References: <20210322234438.502582-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 16:44:38 -0700, Sean Christopherson wrote:
> Merge module sections only when using Clang LTO.  With gcc-10, merging
> sections does not appear to update the symbol tables for the module,
> e.g. 'readelf -s' shows the value that a symbol would have had, if
> sections were not merged.
> 
> The stale symbol table breaks gdb's function disassambler, and presumably
> other things, e.g.
> 
> [...]

Applied to for-linus/lto, thanks!

[1/1] kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG is enabled
      https://git.kernel.org/kees/c/8b382ebc86a8

-- 
Kees Cook

