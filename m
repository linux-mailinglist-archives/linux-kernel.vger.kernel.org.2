Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF173FE7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 05:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhIBDMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 23:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhIBDMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 23:12:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2FBC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 20:11:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fz10so443572pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 20:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHLsnGWpsJqK50+Ukbnar66EU9IVhNFBrNvVwTmtI4Q=;
        b=eBYcMoaeSAJ3sd3D/zptk6KVZGP+qEv0fP/9016YOGs+FhV3+q0ywaFIXTSOlVJ+F7
         4ssYGeAzoDLFnwX22eTDaGO1TPIJuGBe6pdBf3HwVHY+v2mBrTyR+KP91Qt+r5w9mOlM
         //E2XGGgLwgOCxnJ2351XzM9rCXVD6xBJ2GwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHLsnGWpsJqK50+Ukbnar66EU9IVhNFBrNvVwTmtI4Q=;
        b=VCRWST/kXXSn37lt+D8tWHyabT9oLWsVaYF++Fx5E/4hHqICh4ZrDAYlr8SzbwMZcp
         WNw63JXPpvV2WSWqg06wSx9SSLiyuX88HJBo71LxxnWgNgIZ13JN6KbYML3dm4/xjVpW
         nc4+LZt9yTm5LYqa+/3AVfk5TWp0OXe+ZZ9DNV85jTNDKM5ugmm4lghC0PGLxrucx5Rq
         0i5yBhhZQjn2ruDWlOiSX46VixgDWKQbmp5PhC0OWaGMldTeITsWqG/7ErQG1bAijNdk
         Z90IXxSMuvKLpBS1X2oNBdlEZFaBTEluDd/dXXRaELq1VyvMGRuS4jrUtyCzzAWQJDGI
         ba2g==
X-Gm-Message-State: AOAM533Uj7Tco8U9SVht4uFzx6J/8+gTWdlSis1SjZpHX8iDKcNfM7yq
        046EETMf+cnAh4CiiKWSwmyGeg==
X-Google-Smtp-Source: ABdhPJyAz5/uobWomjOh9Le2VVAiELvit+aqlMq5rd41EW7TeoaUyLmGL0aZsZOR1cjSF1HqXr0S1g==
X-Received: by 2002:a17:902:ff02:b0:138:b944:e0f0 with SMTP id f2-20020a170902ff0200b00138b944e0f0mr893276plj.34.1630552265751;
        Wed, 01 Sep 2021 20:11:05 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:156c:d5ce:54ea:e2cb])
        by smtp.gmail.com with ESMTPSA id g37sm339621pgl.94.2021.09.01.20.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 20:11:05 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Suleiman Souhlal <suleiman@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] KVM: do not shrink halt_poll_ns below grow_start
Date:   Thu,  2 Sep 2021 12:11:00 +0900
Message-Id: <20210902031100.252080-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

grow_halt_poll_ns() ignores values between 0 and
halt_poll_ns_grow_start (10000 by default). However,
when we shrink halt_poll_ns we may fall way below
halt_poll_ns_grow_start and endup with halt_poll_ns
values that don't make a lot of sense: like 1 or 9,
or 19.

VCPU1 trace (halt_poll_ns_shrink equals 2):

VCPU1 grow 10000
VCPU1 shrink 5000
VCPU1 shrink 2500
VCPU1 shrink 1250
VCPU1 shrink 625
VCPU1 shrink 312
VCPU1 shrink 156
VCPU1 shrink 78
VCPU1 shrink 39
VCPU1 shrink 19
VCPU1 shrink 9
VCPU1 shrink 4

Mirror what grow_halt_poll_ns() does and set halt_poll_ns
to 0 as soon as new shrink-ed halt_poll_ns value falls
below halt_poll_ns_grow_start.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 virt/kvm/kvm_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b25cc69ab90f..c84b1447ca62 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3136,15 +3136,19 @@ static void grow_halt_poll_ns(struct kvm_vcpu *vcpu)
 
 static void shrink_halt_poll_ns(struct kvm_vcpu *vcpu)
 {
-	unsigned int old, val, shrink;
+	unsigned int old, val, shrink, grow_start;
 
 	old = val = vcpu->halt_poll_ns;
 	shrink = READ_ONCE(halt_poll_ns_shrink);
+	grow_start = READ_ONCE(halt_poll_ns_grow_start);
 	if (shrink == 0)
 		val = 0;
 	else
 		val /= shrink;
 
+	if (val < grow_start)
+		val = 0;
+
 	vcpu->halt_poll_ns = val;
 	trace_kvm_halt_poll_ns_shrink(vcpu->vcpu_id, val, old);
 }
-- 
2.33.0.259.gc128427fd7-goog

