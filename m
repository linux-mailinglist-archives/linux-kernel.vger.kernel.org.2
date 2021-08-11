Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1543E965B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhHKQyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHKQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:54:21 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20485C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:53:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r14-20020a0c8d0e0000b02902e82df307f0so1137639qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=+7PTziNUQw8QnmnSk90P4VSM2A5i6Tcff9zPZ1CL4bU=;
        b=knAO3vIMe14xGLyciXRTAePVEqAIggQhZJa/Mxf9POoGClcax2PssW5NcPUVk1d5Rp
         kBpW4U4VgbC3OPq4yyDn8WIJ0eJSFsMDljBcUjYiGQ60UdIre5VE2bPfuiW69S07Sfoz
         hlEIu/kz7ZO7DVdBJxsWyQrQ4C397Fm4h90H5PnG8ESK6w3p+sHAdWdgTKivwIbJ7haX
         Aj7cTmGzuKP6DqMMzLczOMFz73+BbPyhTlk1xw1zpkTJUnKbAoGCfjtYRIw7ebL3NiJ5
         4qIbB74ojg8KhWkDqE8P7Stn9hAeIvZWCe9L0hfmk1+FZoAqGrZMUt0hoaJWC/oXnR6C
         Ckrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=+7PTziNUQw8QnmnSk90P4VSM2A5i6Tcff9zPZ1CL4bU=;
        b=oE9NlVTyF4kAqCGuS6Z8Ldl4dl2a64b0JPxq1E3FyZrB/nWkeU41uqOvIyqJv3MJoX
         M5NCw4HePdnEGRZkQYNTjAM2pd5whm8yfkffAGcOOCG4zHBggmDE+k2MApipbmVp5+1I
         lWG7P4iEGvGKIpM0UtE1J+AxXFx6pfNSnyqbXApgue9eO7aZJX6pa5lOmIjnxc1nagYt
         kopqyGMQHHEy6sNI0935Mdfza/qtE9eDXa7FSts0gcuPAMzB3a8XH/M62HrXz0+TsYHb
         3hHy3odG0rUuEL4VnH1GBgdDfLX11U/3w2+Qnb2xW6fiRvP3KMgSQ2TTsivfPcwfjBrk
         74xg==
X-Gm-Message-State: AOAM531f0jW+qcfGG8QZ9mQfTdohwkqiakYfMFYy5ttI5+FNpbgic6Gh
        cdhdIHbg5SEE0INEfekV9i13eV/73MM=
X-Google-Smtp-Source: ABdhPJx6DjY1i/ChOSMpNESkR+GXh5zDgkEvs6kPupD8zvgfKQVAH4cqsZ8awl1f7R/h5lMVMxTpSYE4Eig=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:1c47:622e:7a2a:372d])
 (user=seanjc job=sendgmr) by 2002:a05:6214:4006:: with SMTP id
 kd6mr24094817qvb.61.1628700830033; Wed, 11 Aug 2021 09:53:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 Aug 2021 09:53:46 -0700
Message-Id: <20210811165346.3110715-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] KVM: Move binary stats helpers to header to effectively
 export them
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Zhang <jingzhangos@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move kvm_stats_linear_hist_update() and kvm_stats_log_hist_update() to
kvm_host.h as static inline helpers to resolve a linker error on PPC,
which references the latter from module code.  This also fixes a goof
where the functions are tagged as "inline", despite being externs and
thus not inline-friendy.

  ERROR: modpost: ".kvm_stats_log_hist_update" [arch/powerpc/kvm/kvm-hv.ko] undefined!

Fixes: c8ba95948182 ("KVM: stats: Support linear and logarithmic histogram statistics")
Cc: Jing Zhang <jingzhangos@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 38 +++++++++++++++++++++++++++++++++++---
 virt/kvm/binary_stats.c  | 34 ----------------------------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d447b21cdd73..e4d712e9f760 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1467,9 +1467,41 @@ ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 		       const struct _kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
 		       char __user *user_buffer, size_t size, loff_t *offset);
-inline void kvm_stats_linear_hist_update(u64 *data, size_t size,
-				  u64 value, size_t bucket_size);
-inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value);
+
+/**
+ * kvm_stats_linear_hist_update() - Update bucket value for linear histogram
+ * statistics data.
+ *
+ * @data: start address of the stats data
+ * @size: the number of bucket of the stats data
+ * @value: the new value used to update the linear histogram's bucket
+ * @bucket_size: the size (width) of a bucket
+ */
+static inline void kvm_stats_linear_hist_update(u64 *data, size_t size,
+						u64 value, size_t bucket_size)
+{
+	size_t index = div64_u64(value, bucket_size);
+
+	index = min(index, size - 1);
+	++data[index];
+}
+
+/**
+ * kvm_stats_log_hist_update() - Update bucket value for logarithmic histogram
+ * statistics data.
+ *
+ * @data: start address of the stats data
+ * @size: the number of bucket of the stats data
+ * @value: the new value used to update the logarithmic histogram's bucket
+ */
+static inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value)
+{
+	size_t index = fls64(value);
+
+	index = min(index, size - 1);
+	++data[index];
+}
+
 #define KVM_STATS_LINEAR_HIST_UPDATE(array, value, bsize)		       \
 	kvm_stats_linear_hist_update(array, ARRAY_SIZE(array), value, bsize)
 #define KVM_STATS_LOG_HIST_UPDATE(array, value)				       \
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
index 9bd595c92d3a..eefca6c69f51 100644
--- a/virt/kvm/binary_stats.c
+++ b/virt/kvm/binary_stats.c
@@ -142,37 +142,3 @@ ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 	*offset = pos;
 	return len;
 }
-
-/**
- * kvm_stats_linear_hist_update() - Update bucket value for linear histogram
- * statistics data.
- *
- * @data: start address of the stats data
- * @size: the number of bucket of the stats data
- * @value: the new value used to update the linear histogram's bucket
- * @bucket_size: the size (width) of a bucket
- */
-inline void kvm_stats_linear_hist_update(u64 *data, size_t size,
-				  u64 value, size_t bucket_size)
-{
-	size_t index = div64_u64(value, bucket_size);
-
-	index = min(index, size - 1);
-	++data[index];
-}
-
-/**
- * kvm_stats_log_hist_update() - Update bucket value for logarithmic histogram
- * statistics data.
- *
- * @data: start address of the stats data
- * @size: the number of bucket of the stats data
- * @value: the new value used to update the logarithmic histogram's bucket
- */
-inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value)
-{
-	size_t index = fls64(value);
-
-	index = min(index, size - 1);
-	++data[index];
-}
-- 
2.32.0.605.g8dce9f2422-goog

