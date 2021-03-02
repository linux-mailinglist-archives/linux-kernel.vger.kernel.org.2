Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483B832AE2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360684AbhCBWX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbhCBVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:44:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60352C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:44:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z7so12801615plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yBWlyOTxkLscrR3m1Z6J6l3UwydAT2XmPo8P60eOyX0=;
        b=g9Ff7jDymn73MxgXyc7f9m21euaT/GK2ezot9t/yKfbr/p99hl8xwCQQWdMautPQh6
         thFItBZYQPg0egj7rxmqsxsIU0xyPfZxpZ7t4WX0yS7QA2WvfMD0Hed0SKFZs3alM+Yi
         x0mi3marhN7HeuxEqL0rZW0Rli+ioIOkY9QI7UFSRb18ZvsLnR6P2nNLuHCbVpMqDn1g
         uiITAF40YreF5UgK3mfFi3wt9utsFYGuP78nqXKoTmzjpXrjoAec/6ud3NhPrnQr6H8j
         yFVhOFhI+c6Tot9J6z6ebztmzuIGIvkJlUjLTwJkSQAYZlEhrG1KY0snhfEgujV5LYpS
         rgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBWlyOTxkLscrR3m1Z6J6l3UwydAT2XmPo8P60eOyX0=;
        b=U0c6HeDFZ6tlF0vqq3InY7swIOpqdlbjspjDLt+SGz720SrUYE36DQL8cDBchor7Ir
         PfzBRekncZnt+CKRBuFCTMRX0QUSCZQ3uQkTAVIPRwjeBa1ck9oXAF4KO0wtEl5iJPlD
         PQCFxrWZPknIrK868EIsPNKLQkp9w6jOVl08WS7ETo/trXKL2zG1i9PxDe5iw2QXfS2b
         AdFpNZNbaSpS7futG/N2bDKxnC1FjvUnDCEss8MtTGR69gBjsWmWJSiiS36QzUOjLCrH
         S3WBtCUeNMa6pDwM2IJj29uSx89qnheplnW38jOqi6nrvqE00XD74kc1qhLmpXvGqQpF
         K2WQ==
X-Gm-Message-State: AOAM533XelivMH5Gd2RSZuDjVnmZD0gJv9B/uxCANtrWHQH8tXHVQ7F8
        SpwqgvVYoxuhXbEM4BNO6RD/wg==
X-Google-Smtp-Source: ABdhPJySvWQ2Qohkvgl1EygAvCk/3fVfs+gUEXtn20HqdIloVdIbnRrXYoZliWkAydii2+Rwbfai9g==
X-Received: by 2002:a17:902:70c7:b029:e3:71cf:33d2 with SMTP id l7-20020a17090270c7b02900e371cf33d2mr22366413plt.21.1614721442771;
        Tue, 02 Mar 2021 13:44:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:fce5:88bc:1857:36b4])
        by smtp.gmail.com with ESMTPSA id q23sm9712431pgj.66.2021.03.02.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:44:02 -0800 (PST)
Date:   Tue, 2 Mar 2021 13:43:58 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] Makefile: Remove '--gcc-toolchain' flag
Message-ID: <20210302214358.qr6enl6majzplhij@google.com>
References: <20210302210646.3044738-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210302210646.3044738-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Fangrui Song <maskray@google.com>

Thanks for the clean-up!
--gcc-toolchain= is an obsscure way searching for GCC installation prefixes (--prefix).
The logic is complex and different for different distributions/architectures.

If we specify --prefix= (-B) explicitly, --gcc-toolchain is not needed.

On 2021-03-02, Nathan Chancellor wrote:
>This is not necessary anymore now that we specify '--prefix=', which
>tells clang exactly where to find the GNU cross tools. This has been
>verified with self compiled LLVM 10.0.1 and LLVM 13.0.0 as well as a
>distribution version of LLVM 11.1.0 without binutils in the LLVM
>toolchain locations.
>
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>---
> Makefile | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/Makefile b/Makefile
>index f9b54da2fca0..c20f0ad8be73 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -568,10 +568,6 @@ ifneq ($(CROSS_COMPILE),)
> CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
> GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
> CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
>-GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>-endif
>-ifneq ($(GCC_TOOLCHAIN),)
>-CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
> endif
> ifneq ($(LLVM_IAS),1)
> CLANG_FLAGS	+= -no-integrated-as
>
>base-commit: 7a7fd0de4a9804299793e564a555a49c1fc924cb
>-- 
>2.31.0.rc0.75.gec125d1bc1
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210302210646.3044738-1-nathan%40kernel.org.
