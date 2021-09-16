Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5040D496
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhIPIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhIPIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:34:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:32:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so8102378wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dme-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkRPZ+VoJSi1c4vsO7PDtPst60HFkVEdoBfrAZpPA+U=;
        b=OmownnwxO6qXGAWRHKXnr2momFl7urRPOI1MxTgwlioC4OKhcp1r/YAHSl7/17PGBT
         Akhj2qokQbVkZC6rDl7YqQ9zZo0ttV1463OeN/2dbW8jT7/dpiwE3ZuL/06U+ex2BzFz
         A2/dCJo/l7NX5bAv0fwnfXWcO337boFd8vR4FAi23REkSTNpUHnGC6bYUQAUIWd7aV6N
         IHxklLpHz1lBLBVsc7TobG8aptHLZ+W2kcdN5/6tYNj6J9ZQhcQVrgt1vhoIwl0xinJM
         boXvlhUoEqwuH25BU3oSAq8W1iD0LzggbsQM2GbejrAZnuE9elgBogmr79/NSW8weRmU
         F9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkRPZ+VoJSi1c4vsO7PDtPst60HFkVEdoBfrAZpPA+U=;
        b=0btQnj3qwtMU7g5/CbXapSEEdOP2w5JtQvkIV/IA7bQTd2ZsWjNCJuWXnsMytdtf9A
         DnDoBArw5rV8WdhRKfNwYbcvLfjXttQKgXid4DHKOiWRJd8s3OrOO5fLDHkWvtjwKY8u
         Gd+ipPVm6jYe30wbTxmX7S7A2efgUFAvnw8RfJlv3BAfT4PIJCiaZK2DaX8GJtfIGzKt
         +LOk4o7uJOqhaBTX4iGnGHgwURdpaRyJkqrbCYH2UyVvtuj6N4KdvGJpziUixlOn6CJv
         LWU1hO7f/kwa5KNcjmd4ytVnHzgOZZwExy2SOCvyUgy/BQwXB4eYIWXUsHE1XyVP/o3U
         tmYg==
X-Gm-Message-State: AOAM5330/02yPS/zTKLbkHZT+HjalaEfyaFL7m5FjqJelQyE/Q5SZiqA
        3WMuA94G25dBJrt+Wva28xNimg==
X-Google-Smtp-Source: ABdhPJzbqo9kku8xpT2kbo5mvvN0Xf3S6dZbE4kjD+XAajPvezZoS6shIkZO1MuPlYwpVT7Pufdfeg==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr4559119wrr.227.1631781161789;
        Thu, 16 Sep 2021 01:32:41 -0700 (PDT)
Received: from disaster-area.hh.sledj.net ([2001:8b0:bb71:7140:64::1])
        by smtp.gmail.com with ESMTPSA id c135sm6760024wme.6.2021.09.16.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:32:41 -0700 (PDT)
From:   David Edmondson <dme@dme.org>
X-Google-Original-From: David Edmondson <david.edmondson@oracle.com>
Received: from localhost (disaster-area.hh.sledj.net [local])
        by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 9ce9abab;
        Thu, 16 Sep 2021 08:32:39 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>, Joerg Roedel <joro@8bytes.org>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        David Edmondson <david.edmondson@oracle.com>
Subject: [PATCH v5 1/4] KVM: x86: Clarify the kvm_run.emulation_failure structure layout
Date:   Thu, 16 Sep 2021 09:32:36 +0100
Message-Id: <20210916083239.2168281-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916083239.2168281-1-david.edmondson@oracle.com>
References: <20210916083239.2168281-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until more flags for kvm_run.emulation_failure flags are defined, it
is undetermined whether new payload elements corresponding to those
flags will be additive or alternative. As a hint to userspace that an
alternative is possible, wrap the current payload elements in a union.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 include/uapi/linux/kvm.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a067410ebea5..8618fe973215 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -402,8 +402,12 @@ struct kvm_run {
 			__u32 suberror;
 			__u32 ndata;
 			__u64 flags;
-			__u8  insn_size;
-			__u8  insn_bytes[15];
+			union {
+				struct {
+					__u8  insn_size;
+					__u8  insn_bytes[15];
+				};
+			};
 		} emulation_failure;
 		/* KVM_EXIT_OSI */
 		struct {
-- 
2.33.0

