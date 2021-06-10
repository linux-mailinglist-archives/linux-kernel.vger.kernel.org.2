Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB13A3768
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFJWxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:53:15 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36595 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJWxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:53:14 -0400
Received: by mail-pg1-f175.google.com with SMTP id 27so923341pgy.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTOaAxPx+KNeyOTb/ftn1c9HznM9ERRdfrs59iyNihw=;
        b=YhdFmwb4puv4MA8YLF36AWg/CQbI+88jk4/IY3wIJTDe2H/+qI1glbQs0v0KJyPWVA
         QVZZjEy/1bBwVObIPGNGpfTUu1A+5Dq/xP2S2qcXjzsW9ONXSS7Y3xZOQJZw6sbyl9EY
         yL8/cgMqaIyIQqPSCCYmbZlAzSDui4w+sBW04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTOaAxPx+KNeyOTb/ftn1c9HznM9ERRdfrs59iyNihw=;
        b=ZRvrH/CT2zPHzQ+AKHi9waFJVphXW6RhdfSPGvESDxzPuvgbVmnY+kdf5TO5NEOcUu
         BZtW0Ig51tsjjMgr4Ajq3i7KrHtTCZBkt4AE1Jcqrd3hnEti0XhSqjSwhBkz3qw607ub
         1XrtsDWYtIM+5MYVasnNMRqhnqvjfm9+ciJ6IWSc6smE+kedvGVmyfhs4CiOIyMZeio9
         S1I6fq6Djny5rqilkEogDI8xPBe2fjkgW7HZOOEmTLY7cNq3EnPj9bARa7seEdiyUVQ3
         KChVOcGlXwwEvtUIBmpu9UJJUqC77i4vqboABEDBDjaQm5AvZ7QgPPxvVFGvcr2Os3Xe
         ESHw==
X-Gm-Message-State: AOAM530UNRt0DWJPqH5GTP27sUuIXyb6cPqz8tt8trYjkudoc9KYr3Av
        pE8MmJk9jyWVgvwYGEJffvghFQ==
X-Google-Smtp-Source: ABdhPJxGnt5LHMq7m9otuuHCbbDGZ47CJ9psUhMl9iWLMdPfSTNk2qL+NV59PAIyff7ciMHhigGCHQ==
X-Received: by 2002:a63:801:: with SMTP id 1mr641823pgi.146.1623365401428;
        Thu, 10 Jun 2021 15:50:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i16sm3270017pji.30.2021.06.10.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 15:50:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Tor Vic <torvic9@mailbox.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
Date:   Thu, 10 Jun 2021 15:49:47 -0700
Message-Id: <162336538453.1311648.12615336165738957417.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
References: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 20:58:06 +0000, Tor Vic wrote:
> Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
> [1], leading to the following error message when building a LTO kernel
> with Clang-13 and LLD-13:
> 
>     ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
>     '-stack-alignment=8'.  Try 'ld.lld --help'
>     ld.lld: Did you mean '--stackrealign=8'?
> 
> [...]

Applied to for-next/clang/features, thanks!

[1/1] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
      https://git.kernel.org/kees/c/e6c00f0b33ad

-- 
Kees Cook

