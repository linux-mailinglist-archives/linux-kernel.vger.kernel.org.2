Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CA31C216
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBOS7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBOS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:59:52 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:59:12 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id f18so3587758qvm.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Iqm2gbDgR/HD7rWum600CwDEXe1PkXkY0wQYvUq3oKo=;
        b=bzIJEztrXYZ7DqFu2PUZlkducXLcIWEbKZ9rSfQPQovL6YHROiem0g+H4MeFbJwt+A
         viFLcISeUvqw8tRAoRYQCKtFgfG82lfwfS2FHIDVUKXZKEXm7Ticv7COFGY3BkcMaIZV
         QpQkC8SdWGxABhtzqLcxowY0rF/y67LTp2REjgZHigFVju0YstPQdxx474giKl5+eWSA
         htocPPzL/tv1bisAzEzBpCYghTwgAq1J4S7jjCkS6yFNcFl+u35huyigYVuTLEDrnZKW
         9dHO1jXNzMi/D95tM2AAZ+VfqcUx1DqqRj8sql4keewZPJ5Mk+zkyKu5LJuCd42aHGZ2
         feqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iqm2gbDgR/HD7rWum600CwDEXe1PkXkY0wQYvUq3oKo=;
        b=iSAMiT1Xc9+PqydgMc8c2tc2Lm5H2orXLqyN2hroHtSQPWxOSuOTlf2V3CUguzsLqh
         Jhg5LU/lONnWfaAi56rLF0B3uP10QU9qE7T2DNso+6LjNTw7JtwilUaQioX4pSETBOKo
         7qXhq6o178VW/bzufKomJJJuV+8NBYviJkRCHcAF+OJMDbwZPyjINb+LItW3OWUWT6dQ
         jozm315q5mrGBTOq8fENMb/wH8asPHxRS39xUdkua+neP2kSxvFohDhTpfe/C5CUnE0g
         m23HEQXRmx1AhOh/zFnAVi757FhKrfGw26UJMkhgIoeO5nXqbQh+Uj5hOcws61nfrkiI
         XIQA==
X-Gm-Message-State: AOAM533cxGL3aYzEGE84kN/wpcgVorCMD2iNIdmkxTZZDqM7Twfqdv/6
        y2ss1KiRWduOt2S8+wKbGfClJA==
X-Google-Smtp-Source: ABdhPJyT1K1oLcmQz7mhL/LtX4Jbyjcg7RX6uenkZcC3BlQqGtCObyWefBXxXOel7FfnrApbtu8lOA==
X-Received: by 2002:a0c:f547:: with SMTP id p7mr16512438qvm.60.1613415551438;
        Mon, 15 Feb 2021 10:59:11 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z28sm8173017qkj.72.2021.02.15.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:59:11 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        tyhicks@linux.microsoft.com, will@kernel.org, james.morse@arm.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Subject: [PATCH 1/1] kexec: move machine_kexec_post_load() to public interface
Date:   Mon, 15 Feb 2021 13:59:08 -0500
Message-Id: <20210215185908.257724-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215185908.257724-1-pasha.tatashin@soleen.com>
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_kexec_post_load() is called after kexec load is finished. It must
be declared in public header not in kexec_internal.h

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec.h   | 2 ++
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..3671b845cf28 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -309,6 +309,8 @@ extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
+int machine_kexec_post_load(struct kimage *image);
+
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 39d30ccf8d87..48aaf2ac0d0d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,8 +13,6 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
-int machine_kexec_post_load(struct kimage *image);
-
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.25.1

