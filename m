Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219842789E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbhJIJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 05:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244477AbhJIJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633773324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pixb7rhSe9gW9mPovHeBhJ7x5GxJTOJKpjxWylVhVA=;
        b=W0kVDxEXDsfbxmnRCvQbmcWWd9ueINAFy4udwkl96NaKqte8irSB5KYGWjg97NT9yEmK0l
        2R7dY5FOr+X7SVEvf/VMURTk7MDbNplI9pSKfO4lX/NV8DkvDxEjuwNqOHx3hATe9rD+ol
        QGLTbBTPPneZDt2L0K3a6eSgE7dXjUs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-99Fvg6qEOeyV2WWvlh0LJA-1; Sat, 09 Oct 2021 05:55:23 -0400
X-MC-Unique: 99Fvg6qEOeyV2WWvlh0LJA-1
Received: by mail-pg1-f200.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso3257416pgv.22
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pixb7rhSe9gW9mPovHeBhJ7x5GxJTOJKpjxWylVhVA=;
        b=w8GPpBBlmUgI1d0KtWIYn7CeVTYcf9h0rXrUYVQHjeu48zneCl9jQ6ykTTkf2xHWZ0
         X7Y9NpqBCdZX+KHVOvbbFlyKnRIgmgldIjmZKsjwKFUFHpCEB+GkIp69K0rtgRqWge6h
         Knn2McWan9TmEe6ye9ldvINIRZQ5wTT+yLZbYLXMGRsDa7IOt5Zv5NohV085WFFgC0sB
         aSocUlGadVz5Cmknu39ESmz9/DrqKFK48SR+kAhq6rQhHhfeeBaJZz0h1K2JfwilL1v2
         q5MWQgbj46sQO5H5yr9HnNem3ej4+7mDQTWgC8BsESEkWCBk43TL6hqjsTot/96Njzt4
         +S9g==
X-Gm-Message-State: AOAM5309IaAafkonpmEooDurMNvdYofsCAx4SyPLzKQa6XKoV5dmZJgD
        sbRiKNLwnJZQ8eE/ie/fN6ROTJTPtepEHXkp6n4FP5Yc04VfJuPnmEbPQ5xex3pYBkwl8IprLaO
        kuT60reoIKEYUSr6LYtZat4dg
X-Received: by 2002:a17:90a:5515:: with SMTP id b21mr17273642pji.239.1633773322268;
        Sat, 09 Oct 2021 02:55:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1rCjIedQornvFaznhwr+Y/s6YTuLq2BT1YqbQI1e6qIeVqUoNK1CiLqatpJukq936/FQJzQ==
X-Received: by 2002:a17:90a:5515:: with SMTP id b21mr17273625pji.239.1633773322100;
        Sat, 09 Oct 2021 02:55:22 -0700 (PDT)
Received: from localhost ([240e:473:3c30:93d:5429:b8e4:3097:6ec8])
        by smtp.gmail.com with ESMTPSA id r8sm2023753pgp.30.2021.10.09.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 02:55:21 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Sat,  9 Oct 2021 17:54:58 +0800
Message-Id: <20211009095458.297191-3-coxu@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009095458.297191-1-coxu@redhat.com>
References: <20211009095458.297191-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..2357ee2f229a 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
 static int image_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
-- 
2.31.1

