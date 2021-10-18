Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33DF431230
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhJRIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231205AbhJRIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634545912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djld/FSBTbW/xQR7Mlw+77fX/lsdjY/5RfzNvFeCoKE=;
        b=H4xPeRM+plNonF0mEFboTysKwiyLuU3hczmQTwmn2mtmN8fihEMknSmty5TyR45jQJmVl4
        S9CT6pvNcDWqWXyGop9sP9pNLValrpo3VgsInIhTsOU/d4a7sgWDTtx6cq84dMjhd0wgh+
        hSDBht2tpZJUWlnvtj58XXXrvR98KP4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-XhZ58LdSMSuQPixDzFE5dA-1; Mon, 18 Oct 2021 04:31:51 -0400
X-MC-Unique: XhZ58LdSMSuQPixDzFE5dA-1
Received: by mail-pg1-f198.google.com with SMTP id j18-20020a633c12000000b0029956680edaso8872935pga.15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djld/FSBTbW/xQR7Mlw+77fX/lsdjY/5RfzNvFeCoKE=;
        b=HYS75QtDezsAD1BFAxsNEseimCIHgtXxHdsd7oZi9EWA4iLWvfbyFvEwdHkwWJgjd3
         5Vm+NyJy3VDQZ/nO4RHRrXIkKMNaT4Kfy9wvBYCafxvOzIrUmR7qKmIID757avDRNM3Q
         ML0ePdVA+TQs8HqEGNPinnFD8SI6sdLIh+DauKQHEHp/ONy6xpYQ7GZd4eaQbHJQUKoF
         +sWk8URDga2O0EELMjpqKCQRINLXMufDw6KOOsSpJmObdH8XysX7GtWu6GDgewTtG1Ij
         61auDqM/2zToaWUzPsNVHbSvn5aZR4kXyH1tXh6vMiKpDw2BQRVBYohU+9sp1vXg3J55
         EwjQ==
X-Gm-Message-State: AOAM5323Vvz+YzCvgVmQ1PsbQMdfIrZ9zXiWHBsNt1SO1ohSacnI6y1A
        FkWPTEOEiy+N7iz96AJVQncy6B+QtSBDwlftLtu08HA0gUnuQUebKBHQoXjKXGVjVzYZdnaRXgx
        9vMQq8GF/pDc6ymIeG4vzEHoD
X-Received: by 2002:a62:1704:0:b0:44c:5066:47 with SMTP id 4-20020a621704000000b0044c50660047mr27059472pfx.18.1634545910347;
        Mon, 18 Oct 2021 01:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMf8DG8GvSBkxVyhTb1qF9UJMDMa2PGW3nJqhklvB2KS7dp9Cb5aa9VJ3JVwo/hkLRnH+7hQ==
X-Received: by 2002:a62:1704:0:b0:44c:5066:47 with SMTP id 4-20020a621704000000b0044c50660047mr27059461pfx.18.1634545910146;
        Mon, 18 Oct 2021 01:31:50 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p25sm5643345pfh.86.2021.10.18.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:31:49 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Mon, 18 Oct 2021 16:31:37 +0800
Message-Id: <20211018083137.338757-4-coxu@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018083137.338757-1-coxu@redhat.com>
References: <20211018083137.338757-1-coxu@redhat.com>
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
index 9ec34690e255..51af1c22d6da 100644
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
+	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
-- 
2.31.1

