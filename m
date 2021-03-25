Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213B8349CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhCYXiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhCYXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:38:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:38:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h3so3615538pfr.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SsGNl6TxEdcsmrF4tAO/a5SQ7vMBXF6HcqOFeBkJZaA=;
        b=YBLkudSekC9YH98hJgA55FU7IVE5MZyUpALZY2o1J7Ngkh3ltuqb6Q6nznhniFA6Ao
         XPcnjxjr7qgTEb6B5BKrm4bKQBczRRcN03o9gKVyoQiDHB2dK2CxZclZSUtr6BefjxYd
         kN+yz4Nb7d/P1Bdsh9TjfgLHmzOKg+FMCyvXIrMTsRFDl5t/1hbtq8B8RhuG1Tn2KM5V
         /Olo8HuVLcgcDQ7z7Vu/yivH3aLbfP/Ig0Dk4TIy0Cm34zZKS44XPCT8lLWr3WSOlbcR
         cxyjrcJz88D9/rK3grLohcxlIP/moznFZRwalZT5q7LXlWrBKJgrhcoGGw6E8mgc2oeo
         vtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SsGNl6TxEdcsmrF4tAO/a5SQ7vMBXF6HcqOFeBkJZaA=;
        b=KnkIpZpIgUK4Vmb1t798/3DgzMwiRypI7eWgQ7qxM5SEUu2UwjogTthbmGGjjfBopb
         cRDhstsJzp5lwZ1UWiim56TQfBI5LAaG8C0cxPyTOakCgpTgQ2jtUwb5bSdx3w+zFc9J
         vXewk1ewYTeLWm2KAaMqBx3vJ2Z6v+IamKnkIA11VLgQ+xIZlF/lcWEKBSUHHYnfog+I
         wjlKBxYx4ER4d/7TrM2gmgOs+3AnUC8cigORFelsTYcTUxJEhMXuV76lI55avBnMUVw1
         Ev8j1g9yeKYsqXXQHczPEviT6JymLk/ItC238FnifZLYda5+dV7bV6v0Y53YsqzBA8AQ
         ndKw==
X-Gm-Message-State: AOAM5317JxzijEh3Js2IOL54K5Ti+kN4A7Xcon1yWrb4TlhJmrIrJxiE
        Jd6Q9zBJfvBrtXyqM2Jy+fzEEw==
X-Google-Smtp-Source: ABdhPJxyTNoi8awCicMlBT95i1RKLe5xI0PRp4lZMCjKGQIf+tw1BENbvhG4yY4os4qQO6hZgb7uTQ==
X-Received: by 2002:a62:2a07:0:b029:214:fd95:7f7 with SMTP id q7-20020a622a070000b0290214fd9507f7mr10221639pfq.60.1616715520895;
        Thu, 25 Mar 2021 16:38:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1532:a374:78cc:c35c])
        by smtp.gmail.com with ESMTPSA id l25sm7030314pgu.72.2021.03.25.16.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:38:40 -0700 (PDT)
Date:   Thu, 25 Mar 2021 16:38:35 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] riscv: Select HAVE_DYNAMIC_FTRACE when
 -fpatchable-function-entry is available
Message-ID: <20210325233835.ytcstqdcwtorzkhw@google.com>
References: <20210325223807.2423265-1-nathan@kernel.org>
 <20210325223807.2423265-4-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210325223807.2423265-4-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-25, Nathan Chancellor wrote:
>clang prior to 13.0.0 does not support -fpatchable-function-entry for
>RISC-V.
>
>clang: error: unsupported option '-fpatchable-function-entry=8' for target 'riscv64-unknown-linux-gnu'
>
>To avoid this error, only select HAVE_DYNAMIC_FTRACE when this option is
>not available.

If clang -fpatchable-function-entry=8 does not error "unsupported
option" for one target, it means the backend feature is supported on
this target.

Reviewed-by: Fangrui Song <maskray@google.com>

>Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
>Link: https://github.com/ClangBuiltLinux/linux/issues/1268
>Reported-by: kernel test robot <lkp@intel.com>
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>---
> arch/riscv/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>index 87d7b52f278f..ba1d07640b66 100644
>--- a/arch/riscv/Kconfig
>+++ b/arch/riscv/Kconfig
>@@ -227,7 +227,7 @@ config ARCH_RV64I
> 	bool "RV64I"
> 	select 64BIT
> 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
>-	select HAVE_DYNAMIC_FTRACE if MMU
>+	select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
> 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> 	select HAVE_FTRACE_MCOUNT_RECORD
> 	select HAVE_FUNCTION_GRAPH_TRACER
>-- 
>2.31.0
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210325223807.2423265-4-nathan%40kernel.org.
