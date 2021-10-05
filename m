Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853CF42276C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhJENMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhJENML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:12:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA26C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:10:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x8so2285048plv.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCCUX5JZdookotxRzV8PUR+bQjhgRjRq9vklW0tEBT0=;
        b=nmikV1ECAtydJ1lKYgzGDF7FTET/W2FbmV7Prh1Si40ZkbYXfrQ7dwlozZl1gxx8m7
         JN2+RSOwv+GTGLE429tDraJ6BZTOPng4+Z2C8b0kv3ej6S+iBCOibNF+pY+pIkLM/sbU
         lsfSj8BeOA/T15/+RZWuPTCVXKBg1Vf/KdWKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCCUX5JZdookotxRzV8PUR+bQjhgRjRq9vklW0tEBT0=;
        b=0o/dupOlm5QUGD7Iw9aIl5W7lrg02o6wxmNX7VJlPdYs8evSHlI8NuAiYt3TtwJtrM
         Kx5JkOvz996vqLWc4AnhGJJYF9CKx3pPC5zsFz5Lxze4HUvpXyZTntkfLRqDQasB7OvY
         3FaxtdF/9CPtvOh1jJug/EPd0lDVOTx6QIH0qA71VmkPn9ZDAAbBpHo4LnmR6cmZhefY
         qLbk9Y6u2WLm8eoMIHPfdWDj4vuI9r2sll01WYj+J11W44UFkZK0+0s/Urtak0fTKRO6
         tFVjsY7NoQpnNSrrMTeSIal1pHcgsNNgyG0WUpHt9TmBGPW76NZYjWr0H1TzIhXpfOqo
         +xwg==
X-Gm-Message-State: AOAM531Ue1iZtKOR/rw9Hi0SSNuFLw6kashQIXVIVARjv6e3Cux6fSJD
        8AGWhAcSru7WIVGpf3OZn2H7Mw==
X-Google-Smtp-Source: ABdhPJyP7CaleS0t162VLPCzMCvJ8FF6IG/NaYURYV+b1CqX38UJA9fzbXk7kDUV5gSbfZ3zHWdgIQ==
X-Received: by 2002:a17:903:2403:b0:13d:cef7:61f1 with SMTP id e3-20020a170903240300b0013dcef761f1mr5203670plo.48.1633439420727;
        Tue, 05 Oct 2021 06:10:20 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:ce15:427:ed6f:99de])
        by smtp.gmail.com with ESMTPSA id n207sm8291473pfd.143.2021.10.05.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:10:20 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     keescook@chromium.org
Cc:     catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        hca@linux.ibm.com, jarmo.tiitto@gmail.com,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        mark.rutland@arm.com, masahiroy@kernel.org, maskray@google.com,
        morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
        oberpar@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        samitolvanen@google.com, torvalds@linux-foundation.org,
        wcw@google.com, will@kernel.org, dja@axtens.net
Subject: ARCH_WANTS_NO_INSTR (Re: [GIT PULL] Clang feature updates for v5.14-rc1)
Date:   Wed,  6 Oct 2021 00:10:15 +1100
Message-Id: <20211005131015.3153458-1-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202106281231.E99B92BB13@keescook>
References: <202106281231.E99B92BB13@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies, I can't find the original email for this:

>      Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR

which is now commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
CC_HAS_NO_PROFILE_FN_ATTR"). It doesn't seem to show up on Google, this was the
best I could find.

Anyway, the commit message reads:

    Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
    
    We don't want compiler instrumentation to touch noinstr functions,
    which are annotated with the no_profile_instrument_function function
    attribute. Add a Kconfig test for this and make GCOV depend on it, and
    in the future, PGO.
    
    If an architecture is using noinstr, it should denote that via this
    Kconfig value. That makes Kconfigs that depend on noinstr able to express
    dependencies in an architecturally agnostic way.

However, things in generic code (such as rcu_nmi_enter) are tagged with
`noinstr`, so I'm worried that this commit subtly breaks things like KASAN on
platforms that haven't opted in yet. (I stumbled across this while developing
KASAN on ppc64, but at least riscv and ppc32 have KASAN but not
ARCH_WANTS_NO_INSTR already.)

As I said, I haven't been able to find the original thread - is there any reason
this shouldn't be always on? Why would an arch not opt in? What's the motivation
for ignoring the noinstr markings?

Should generic KASAN/KCSAN/anything else marked in noinstr also have markings
requring ARCH_WANTS_NO_INSTR? AFAICT they should, right?

Kind regards,
Daniel
