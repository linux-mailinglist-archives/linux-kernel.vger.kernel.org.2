Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF903A31D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFJRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:15:02 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40492 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJRPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:15:01 -0400
Received: by mail-pl1-f182.google.com with SMTP id e7so1374000plj.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ea935A73j1hJeytBYHJPVhPk9COUigRxCnmA0Y3k2rg=;
        b=VHQ7nUeAzy07BAYvlr5k8nBagN4vsG3hVhbUvT9IVe7hE52y0/XAvXAD65IXDLcRcB
         JFZILCJC+2CUO3vbBd7rc6ub4cgwF9GVHA6PLo5igLGeuIDVeAX0oq4LOJKxEl9prws/
         R7fMe+95piuC7Whq2rP+4o7uPKFTFSShur/k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ea935A73j1hJeytBYHJPVhPk9COUigRxCnmA0Y3k2rg=;
        b=TTVbfNrF64dRp1ZbYnxYaoJaWbecBbJtfdTVTRrheBY2N1gQ4NbLkRf87fv3e6wo0i
         ZvNInppZhVGmocth5qZeUIvEZjhH2DbamZcj3dqdbY9DdQqUl82x3LmxQif6VRy29B9h
         STFRzjKGVJIUI9MgJEM1bYO4gH03aeQL85/7qcLfOmIseFAsJmxwuPQYsES+LptOChxz
         Y72/J27CywO5YSCDqPmACZxOsqXZtHiFCar5i2LoTAOuOXuVHuGr4Ca8UwB+DJIxVZL/
         jCA4NlSQm5UTEIuY4juo5ZuKwUhr/B7PCVKszosdW/Mu8FLUT/BRX7AEh+rff447+vyQ
         WNsA==
X-Gm-Message-State: AOAM532rGajjMdqcUlFg0PAoUsZYhUqyo5YU7Drbtxzzd2Uc5CEc/KB0
        6Bz5wMDkXdTAn6rE9FSpNJLzDg==
X-Google-Smtp-Source: ABdhPJxkDuKqu3ecUgQW9NPEuuKsjhXFiJ9qZcsRNnYFVMBhC+vjUbf6+ke8hc9Egt7xX51BEGtlRg==
X-Received: by 2002:a17:90a:640c:: with SMTP id g12mr4510182pjj.52.1623345108306;
        Thu, 10 Jun 2021 10:11:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs24sm2976112pjb.6.2021.06.10.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:11:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: Enable clang LTO for 32-bit as well
Date:   Thu, 10 Jun 2021 10:11:42 -0700
Message-Id: <162334510028.1236130.14295655998961530983.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429232611.3966964-1-nathan@kernel.org>
References: <20210429232611.3966964-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 16:26:12 -0700, Nathan Chancellor wrote:
> Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") enabled
> support for LTO for x86_64 but 32-bit works fine as well.
> 
> I tested the following config combinations:
> 
> * i386_defconfig + CONFIG_LTO_CLANG_FULL=y
> 
> [...]

Applied to for-next/clang/features, thanks!

[1/1] x86: Enable clang LTO for 32-bit as well
      https://git.kernel.org/kees/c/5083971eb1a8

-- 
Kees Cook

