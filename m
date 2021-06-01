Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7191A397A93
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhFATTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhFATTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:19:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F8C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:17:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so287229pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXSpBBbp8umZDX2eRcS2QwQNb4xIATBt0dQ003Ln9Ig=;
        b=dbBQtsyL8TYI6C8oHFyO/gxmru5zdSVPID98stKWsan84a3hrTx94pddMuc/EtJFbf
         7g7qjEv/I3Rgmqo+peWspvcYBOsNeJgmc7YQUSji77T77/2IQYedZmF96ZtTokyw0Lah
         BtBSmnIcrE/ZD9Nx4C9+joeQIZbsxXvYyvhKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXSpBBbp8umZDX2eRcS2QwQNb4xIATBt0dQ003Ln9Ig=;
        b=AH+cJTvUmbQJTSzju4oN1uxmXPF7zk+RDhcs/3zVMgHhH1NkgW34vMvnx6zv0fdDjc
         BRtNup/M7jXecn+WiDVel8221Dz7UM0fJ/0SoRfjNZ9+WP5gSrmj+5nUIA3gOPhwoBya
         uikgapakJOPDcT4NYEn7mfrmtOcpywJi/NAJiA3ST3xqeWsg/yh3lVbcR4F04ZzR3cBP
         M/fnQiYWCRBrDvsi2DIbKRkvdYOUjAdWH0/TrbLiPEP+7Mp+WpRSmz3O/NBq6mc1038+
         QrjxDcbd5JVnTIof2lI5VHuxJG5anrlbzDz7HGxLaneP/CFG20ksGKLw0vQ1LHpISB3B
         F8Rg==
X-Gm-Message-State: AOAM531FxPJDvkmPzEr1uxcz83te5CfEl3f7I1SucGjSNZvSRydUqupk
        mNejQEvErKF5ZS+k61PsoJ1juA==
X-Google-Smtp-Source: ABdhPJwS5JdAcmf2q9gCv0Uxt6ES8dGbGW4xYVvGe4pYTtCgcIGIcwbajtWQSQ8dXhv955GtgjCQ0g==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr26520768pjn.143.1622575055757;
        Tue, 01 Jun 2021 12:17:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15sm10891489pjr.18.2021.06.01.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:17:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        clang-built-linux@googlegroups.com,
        Bill Wendling <morbo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@google.com>, linux-doc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pgo: rename the raw profile file to vmlinux.profraw
Date:   Tue,  1 Jun 2021 12:17:24 -0700
Message-Id: <162257504238.1460767.9253353990996275101.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531202044.426578-1-morbo@google.com>
References: <20210531202044.426578-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 13:20:44 -0700, Bill Wendling wrote:
> Future PGO features may create other files in /sys/kernel/debug/pgo. So
> rename the kernel's raw profile data file to "vmlinux.profraw" to make
> which part of the kernel the file is for more explicit.
> 
> Note that future files in /sys/kernel/debug/pgo should follow a similar
> naming convention.

Applied to for-next/clang/features, thanks!

[1/1] pgo: rename the raw profile file to vmlinux.profraw
      https://git.kernel.org/kees/c/001eaf3fd0e3

-- 
Kees Cook

