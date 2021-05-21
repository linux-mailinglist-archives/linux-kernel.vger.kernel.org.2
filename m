Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1B38CCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhEUSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhEUSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:01:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D4C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:59:45 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so7758984pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvnbS4IVZhECF51z6O+EfBBe87ZTqf6cbpg5WnJxJSc=;
        b=dRa+q4djh2zWgsZsG80B8J00y/BYlEh4KnODAALlDl6ALDWnGO2ZWZvDRGfrs948mW
         IdQF3TyoEgErcIHsHN/PQIcBxYgYdxfvYktPTaZJ6arZDaRW7Wxqid4ZxuyunuxU39Kk
         rsYiltUpO/o400ktq/z/L2SyyiawsfLpXN4xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvnbS4IVZhECF51z6O+EfBBe87ZTqf6cbpg5WnJxJSc=;
        b=EhNmbdTTY8XsyyJhu6SYEGghIqKcUJ8Tm5bPeZWZcfHiHEecEHRz5IkhkfFwIuVApF
         irw93uwCJUQqZGoQl4vPwxgBAB3S7XE9gly/rGuaWu0K9J+Uypw3KBl/rUQjflR56x/W
         AETYRGfhdlK5gZK1LSWX20u+2lOdTbOWpqtsCmTiMwMJ2rPYRKGvOVM9vBdvCip4RryQ
         SCtIl8Em7dFX1bPru6Djy4U8+d1lCrjRatjo6NUD50TfOZsDKBlTJG1+UHDzoAmpous2
         nkZZK8MPPoB68bp+rsYf9L2Jfwwy0WwVXqsAc/rdNunUgY7cUvIC7AAI4ZJO7c+wNLhK
         YgVA==
X-Gm-Message-State: AOAM530tg12ZlZny0BHjJX7a05HKedL/jjT9o0rIlY6KvMR1iQbzpiiD
        O6Hhk3Khg5elaptAaZmG7zYaDg==
X-Google-Smtp-Source: ABdhPJzBxhmutnAM94ho9VxOqH7WslOekEyezmP+aJAEVSUnTsp8WNLP0bzekNRAJeF64PcP78udBg==
X-Received: by 2002:a17:90a:9d88:: with SMTP id k8mr12209792pjp.64.1621619984833;
        Fri, 21 May 2021 10:59:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5sm206280pjo.10.2021.05.21.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:59:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Anthony Ruhier <aruhier@mailbox.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: Fix location of '-plugin-opt=' flags
Date:   Fri, 21 May 2021 10:59:10 -0700
Message-Id: <162161994470.2028902.331062863146834934.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518190106.60935-1-nathan@kernel.org>
References: <20210518190106.60935-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 12:01:06 -0700, Nathan Chancellor wrote:
> Commit b33fff07e3e3 ("x86, build: allow LTO to be selected") added a
> couple of '-plugin-opt=' flags to KBUILD_LDFLAGS because the code model
> and stack alignment are not stored in LLVM bitcode. However, these flags
> were added to KBUILD_LDFLAGS prior to the emulation flag assignment,
> which uses ':=', so they were overwritten and never added to $(LD)
> invocations. The absence of these flags caused misalignment issues in
> the AMDGPU driver when compiling with CONFIG_LTO_CLANG, resulting in
> general protection faults.
> 
> [...]

(I've slightly adjusted the title.)

Applied to for-next/clang/features, thanks!

[1/1] x86: lto: Fix location of '-plugin-opt=' flags
      https://git.kernel.org/kees/c/5d6c8592ee5f

-- 
Kees Cook

