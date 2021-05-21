Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAED38CCD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhEUSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhEUSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:01:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D728C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:00:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q6so11373729pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpyrD8xtWegQ70CKj1TMQvQr17fFrcAg/CYc9kAmlmM=;
        b=bjnZBcBdYL4RJJbMHruNAiEwiPPKYkJQlmZJsUcwkZM0AvUVcpMzp/Npe5+oal3zEA
         FvyCLBxG9fSeJlxo4TmGhqsiW53+oqd+wifJrfzsf0w/tthlQdcKU2ii8iQ/NrKpgH5H
         yjfSiU9U1eyyvIui0bs7o9syKo8+2jCwLMVf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpyrD8xtWegQ70CKj1TMQvQr17fFrcAg/CYc9kAmlmM=;
        b=WPN5Jlbntl2+RCc+cf19YXvhHB9X791YK3mqwZvhTO9ZVErOYpOaVInivKQMnlABUp
         sXfI8cemOboIA9CpN3mbzh55H84Y4bbn/IHsxijONKlesTejWSr0xGXJJq1R+1A7uFsc
         yQUFKZ2NSkUXRC+IqmDwB3iBXpvsZXyqj7L5Z0F1MFOLA7snmxmJC+YLomrq5wlYFsar
         iCiM/cxWJLZ+M9b1aDkUSlF0XL9CmUD5apKU+CrAhy2ZRR/X7v86ANjIyKEVxcNk2XVZ
         H5OYwGnmbsD2f++BNP4ljpb2dWM0OUl3oUlI7/mvHW1r6YnoZ3M8M8JfOnfJbNqG1dbw
         5l8A==
X-Gm-Message-State: AOAM53241j2Vzc38ciUN9GHIhHLBbtyUSfKSDJ56zGEWVUIDH+Z52aCz
        LNhn9lzxxJfeWMN1cDr7Ou0AiQ==
X-Google-Smtp-Source: ABdhPJySrSZW1V4jNIje8xED8Y5/t3xBJ2xEluqb2lgox45/sQLsIibL5asP1sSgeZz+827FgdTeLw==
X-Received: by 2002:a17:902:d204:b029:f0:b65d:a14d with SMTP id t4-20020a170902d204b02900f0b65da14dmr13206217ply.25.1621620031178;
        Fri, 21 May 2021 11:00:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hk15sm8570881pjb.53.2021.05.21.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:00:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        akpm@linux-foundation.org, joe@perches.com, johan@kernel.org,
        masahiroy@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, samitolvanen@google.com
Subject: Re: [PATCH] init: verify that function is initcall_t at compile-time
Date:   Fri, 21 May 2021 10:59:51 -0700
Message-Id: <162161998941.2029023.3745497110832316703.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521072610.2880286-1-elver@google.com>
References: <20210521072610.2880286-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 09:26:10 +0200, Marco Elver wrote:
> In the spirit of making it hard to misuse an interface, add a
> compile-time assertion in the CONFIG_HAVE_ARCH_PREL32_RELOCATIONS case
> to verify the initcall function matches initcall_t, because the inline
> asm bypasses any type-checking the compiler would otherwise do. This
> will help developers catch incorrect API use in all configurations.
> 
> A recent example of this is:
> https://lkml.kernel.org/r/20210514140015.2944744-1-arnd@kernel.org

Since this touches on CFI, I've taken this patch.

Applied to for-next/clang/features, thanks!

[1/1] init: verify that function is initcall_t at compile-time
      https://git.kernel.org/kees/c/72a12a91a634

-- 
Kees Cook

