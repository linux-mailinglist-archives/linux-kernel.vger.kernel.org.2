Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2739BF4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFDSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:05:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9DC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:03:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so8038205pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ox4Du5dlbD3YcIJp0009ChDA928P5AWLh0cTutjLWf4=;
        b=j1tCUqkVDDF421H0jLJZMh/A+zj9fpNfjrQVqwkY4gNQAHavcpvCjDSWpFHcr7Ip4D
         UYWxQqEbQs4ygZNThTIuYp59HddH4ZwWezBYvqvFUszCmW9+VY1Hq9zJyo/w+WbdpwfR
         oJETTK9AamY1AK0BVNYWw5dOOreGIYLdNOfFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ox4Du5dlbD3YcIJp0009ChDA928P5AWLh0cTutjLWf4=;
        b=TdUdLCRTQtxn2pKi6Hm9Fw5TmhkBHoG8q0EZxmN06JAyLF86JkTjC8neOyLnx1OCvi
         KRM8Fc/9CvacWYKc7SUt0PXfck8HUPcLIQBkaBeatjc39VTTzyZrGQxwV5znl4mMu90E
         qgqWf8yBYEMucQeLMI5LWLKIazwvKD8PzCaa3EvbqFOZCsm0JZiSP5fPl4I7jlyo6e68
         S8XLhiwAMlBP48JQ2MoP8smXJ4ZuboYGR8vSKw2lzOs8ltZ++1xmS6QxvafYF/l+DOVa
         l/wAAF4JuTQ4KL6DddPpuDZjX+5wK0VwAHrk0WeH4mLU4cmWb9DOBGrXcn995p5qzVUf
         SwTQ==
X-Gm-Message-State: AOAM533a/I5s8eLPPeI/eGRdkX42CbEJZHapSM/SHq3EFHU0hs7W9JQd
        R/DRdU2WecpPwJo1/OMOnRFS3A==
X-Google-Smtp-Source: ABdhPJzcDnp6TW4Wid5eVMPImOj5bGMyAbJjQXeLAiAwe8h55weaATE98J/BgBdydzB1pl/E6kjamA==
X-Received: by 2002:a62:1856:0:b029:2e9:c6ef:3b34 with SMTP id 83-20020a6218560000b02902e9c6ef3b34mr5562322pfy.65.1622829807322;
        Fri, 04 Jun 2021 11:03:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13sm5396085pjj.18.2021.06.04.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:03:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds.h: Handle decrypted data section with !SMP
Date:   Fri,  4 Jun 2021 11:03:23 -0700
Message-Id: <162282980179.3081583.15776293089632738791.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506001410.1026691-1-nathan@kernel.org>
References: <20210506001410.1026691-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 17:14:11 -0700, Nathan Chancellor wrote:
> With x86_64_defconfig and the following configs, there is an orphan
> section warning:
> 
> CONFIG_SMP=n
> CONFIG_AMD_MEM_ENCRYPT=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_KVM=y
> CONFIG_PARAVIRT=y
> 
> [...]

Applied to for-next/orphans, thanks!

[1/1] vmlinux.lds.h: Avoid orphan section with !SMP
      https://git.kernel.org/kees/c/d4c639990036

-- 
Kees Cook

