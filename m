Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270EA457619
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhKSR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhKSR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:56:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:53:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np3so8470531pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbDTRLuM6B/i4N4fLddPtlTt3fPn3atqp8keACoNBMI=;
        b=h3dU2JP1JNh2mb3NOfVHeFY13lYibRgwDzkNIRtt8sHoEBNK8QEyA5q1JtBlYA61Dn
         lOOI82qyaBHg6UgzQN8VxEqx8GceyPMSTEJe5KUwdlpyUK+f3yQNcMZdtfDaYMy2+NSs
         Qpl+Z5H0yf7Kol2cN7iiTLVKF/GerOUqR2UzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbDTRLuM6B/i4N4fLddPtlTt3fPn3atqp8keACoNBMI=;
        b=emwZUItN7eOgNp2rcyfoT33Nsmghlhf/GuIQPRFo6GTKb3nZiBGBeRHcYv1HvaJcbj
         145S9gpRUDql0taWgHLkiQh/efuGtNquMbk/lLftrO1Ly/ijuZfRcqeXMB7CRmNFYWoP
         HWdhbqI9E6zs7WRXjCmeL7eXz0+M+XefDuVi2Z0DUD4Jr9YIN3QETqYYTh2PDrOdGCMm
         upfuMIbPEsc/ZMuyBCbYB6vzveHknMp+hR8vxfTk4I80dw98r5s4kGZBXINcTjuKHxy3
         Vw5a03Ac6a03uzYnw5ffrbMZcjT0GF8E/apW2P9e10XGXQDswWCWbJertVYOJakpmKlO
         1JaA==
X-Gm-Message-State: AOAM533DmH196k266tHU4xrEIFOxA+n6XDntE3mc5Ox+IDnkcnwfzgfN
        5CASPXj56KPS3gX1jaOEz0Cy8A==
X-Google-Smtp-Source: ABdhPJyJBPj4VRC/jY8Fe7nvF5PdNlnj5RFQf4A0+2py5iUREf0sg9kiz/khp65/bpHuTPmNAnm08A==
X-Received: by 2002:a17:90b:105:: with SMTP id p5mr1764517pjz.60.1637344407330;
        Fri, 19 Nov 2021 09:53:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u22sm281417pfi.187.2021.11.19.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:53:27 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/boot/string: Add missing function declarations
Date:   Fri, 19 Nov 2021 09:53:25 -0800
Message-Id: <20211119175325.3668419-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; h=from:subject; bh=U7Ni1JpduMeuesGUuMzbPqvfcNzvY+ZcVCYe3F3B0wA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhl+SUVsqFFvXCn4HMMPCunL6eH7noZ+4hLfX23MgA pHWIjSWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZfklAAKCRCJcvTf3G3AJntLEA CkhzuVGtMnh24Q/mpbP4K5J7fy6X8oDhFoYqY9YNGlZ2QM+T5o52F7l0yIdlTH/dJrRqup8nNq5vqh +Ya5jrwouSccXI+6ZaG7+RZYcN5O/hyuD9W+Lnaw1KSnfkMp983bki+i1Zo3EEc7YjIvnyTQTUhLie 9mIRnmP2d+W8YlaGDPaxcA8Lq1MI13I1XDQeIrHNem5A/NwNg8OkH2m6ayO5Z87c5I0A5TRpUYt9V+ QviDYUiDKCC6X6Zhan5/mU5CUWxn24PLXPl4OqctUDAiq+xO/8U8CPvxHQG7C/jF9AnsZtvsyToRsK LaJHtDVNGKAY9cU+Ly3kZir2UxzVCb6/kdyR4zwVniYEKHiQQ4pWwSN2tjfdXxOtRBkKvjThK2MgLs dshpDFFqTpLxXjSR2E4bAHtyDBSUkqNu3vJQm4P78pGxPrmThGBsLqrZBb6032Rv2cD3yW4bWIy9Fh yy4jHTqijKnehmGDd5H3XsYJAS5xc/lh6a4UR/UsnnCHMCd+MP19B+U868pw4tnCCKsiT9wmIEDtsD kRlyebxxD/lF2n604+1B3zykBUnht0ZMgDzrZGDJni2DJZAF6AoZe+SjhzKp3KvoMNUxJO2W5xZpSm /cBZADUu2C3+of9dkPi48xCqqJOOQOSGyxmCYRjy8VSAfJy7c9A9SSkdQifQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence "missing function declaration" warnings from string.h when
building under W=1.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/string.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index a232da487cd2..e5d2c6b8c2f1 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -8,8 +8,10 @@
 #undef memcmp
 
 void *memcpy(void *dst, const void *src, size_t len);
+void *memmove(void *dst, const void *src, size_t len);
 void *memset(void *dst, int c, size_t len);
 int memcmp(const void *s1, const void *s2, size_t len);
+int bcmp(const void *s1, const void *s2, size_t len);
 
 /* Access builtin version by default. */
 #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
@@ -25,6 +27,7 @@ extern size_t strnlen(const char *s, size_t maxlen);
 extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
+long simple_strtol(const char *cp, char **endp, unsigned int base);
 
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 int boot_kstrtoul(const char *s, unsigned int base, unsigned long *res);
-- 
2.30.2

