Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4155325887
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhBYVUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBYVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:20:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB0C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:19:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u12so4102789pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m3wIYWlCfki6DaxQY5E7WbIL2IFlrLVwD0m764eiz8=;
        b=HwMOFaKhYITLSRNrjMJTpMd9zwZHDrRs0CYQh86pcetkMwIDH5XYBHRb2o/pPA/dUq
         ua4+cUVAU66Qbh18jI0uMXVL2Ezu/wj9wWDQz5gdmeQqQpCo6o3+A57Nt5RbiTUGPY9y
         gwYceJcMLBQFLcevVVnMNh3wme6Xxm4ZrWreQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m3wIYWlCfki6DaxQY5E7WbIL2IFlrLVwD0m764eiz8=;
        b=qXY9R/dQy8ibTQfDv86PaGBYuYPdsS3xANJwbf9F0IPBgosTLa6SQfZHtIautFoshn
         5FpprTj0UDYXaT2IVlPmJxCe15fMGboTDWsx0+MPm33LSO4eOuQnzTDBjStgaRd2APiu
         KV0qYAcfQNZ0xNJ+6YQwc1Pas1lQ02wJwKAwHfmPzO8SBISzmV4UyIyFPjjWxicAG7vp
         YYNT+365W7h7ZWVTnfOxrm0BkWoLgGeoyShKkNplQEl1M3sd8K/n2XNjcyRrxjFRtOr4
         mDOg8aGSxXLOUzHA6fwV5Q6e99LK6s3Y371QzGDRM5bxUgEru5fX/XmUOGZ6spxfEZam
         rMPg==
X-Gm-Message-State: AOAM532NNavpsib5KvTTNTZzwH1QEa6jSOqky6aj/rDwRWytmoA3/vyu
        jMwXzD3MGlwh9k04BkdXQlSUbQ==
X-Google-Smtp-Source: ABdhPJzsDoMFcuoiwgghqzXNBURZTVTpZcwjRT3vwxlgZbecAsjjHLOg6GJMZ+/OHCufIcu24EcLRw==
X-Received: by 2002:a17:902:860a:b029:e3:5d18:29af with SMTP id f10-20020a170902860ab02900e35d1829afmr27682plo.64.1614287961962;
        Thu, 25 Feb 2021 13:19:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm6985606pjj.23.2021.02.25.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:19:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v3] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
Date:   Thu, 25 Feb 2021 13:19:12 -0800
Message-Id: <161428794590.2304993.7596527135975566693.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130004650.2682422-1-nathan@kernel.org>
References: <20210130002557.2681512-1-nathan@kernel.org> <20210130004650.2682422-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 17:46:51 -0700, Nathan Chancellor wrote:
> clang produces .eh_frame sections when CONFIG_GCOV_KERNEL is enabled,
> even when -fno-asynchronous-unwind-tables is in KBUILD_CFLAGS:
> 
> $ make CC=clang vmlinux
> ...
> ld: warning: orphan section `.eh_frame' from `init/main.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/version.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/do_mounts.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/do_mounts_initrd.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/initramfs.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/calibrate.o' being placed in section `.eh_frame'
> ld: warning: orphan section `.eh_frame' from `init/init_task.o' being placed in section `.eh_frame'
> ...
> 
> [...]

Applied to kspp/linker/orphans, thanks!

[1/1] vmlinux.lds.h: Define SANTIZER_DISCARDS with CONFIG_GCOV_KERNEL=y
      https://git.kernel.org/kees/c/f5b6a74d9c08

-- 
Kees Cook

