Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0D3D920E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhG1Pcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbhG1Pcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:32:46 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0876C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:32:43 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c41-20020a05600c4a29b0290253935d0f82so1516488wmp.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wsuCFl3zJw45VJsq2CCpitdGwDgZYGVgJGVdlnAA78Y=;
        b=H8AiMx+L6JXn5Q+T+lMqgWRxobIRqr1+MD1xsZdr4m6FSo/4YE+a379Kuo8gyFA44C
         VJH3lsBWEIBwuqw4RWtBjV/tN0ISN2k68TGgN8BSEKrL0hD+GIIpEmg7bAQ3PxjKkBUS
         lmm/xrYOZ1ljLtSJwWL/yt3uv5QLcvQPySXsZGT/ev7ua1Z27AkwLUbkQNm6RG4rnl5+
         TkDkcFzqPQz/VFhensW0nxv8xcGF5dBu/mwQdIA+v/wiqyydrUvaAxKqNGg0FX6QRFOZ
         FEghjQ51cpIQVaISj8htiqpUP7Fpkh/kpbqUVbJJgN+xGUBdgVaH7cUvOkKQoqG4Xps1
         +P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wsuCFl3zJw45VJsq2CCpitdGwDgZYGVgJGVdlnAA78Y=;
        b=ovcsqtj41VeUlP7Av+bD0Qe/oQMyIEGlWbGOjMqKmHaFaZNQ8cclLMWI3BbHzCEIna
         gxv13F5eelAb/BE/nFHeoAgjWjDmOWQ7gv7UUmGtVyBTg1RpRm+tEpGaoRl2ceBDZJfX
         AJ5dWr1kz5gsX6cjgYaHqx4/eA+uoh8Zr9dDq1XVVwv/Y5dLiTKInHBAQdX7cjfprxQk
         w1rUm1SGv1WC/BN3gEqARVA04b0Ndrv1aJSXJ78n2KvIH2dy51njdBhxB7FOFPud/GLA
         179MV/jfA0LQkM/lVpvanMrVnHvgABMCz8jhkobmzYh4qFjOHhw6W+YoZKSGs8nM/fsp
         CaJQ==
X-Gm-Message-State: AOAM532NjTtnVbgpUCHHK6scK16i/PXE7EAZxWmz98gWSSWbwpLf9GEi
        2TmvnAgpADE8vl62Vkc8vd7JQ19JKsmBAQ==
X-Google-Smtp-Source: ABdhPJxuEfipJsCbHRn1LIm1ICWET52ttWIgJnQxaUq0o234lBR+T/9ot6YarV6e8XqcOQE6CGdknEA+TvYf8A==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:a7b:cb4d:: with SMTP id
 v13mr10176875wmj.68.1627486362229; Wed, 28 Jul 2021 08:32:42 -0700 (PDT)
Date:   Wed, 28 Jul 2021 15:32:31 +0000
In-Reply-To: <20210728153232.1018911-1-dbrazdil@google.com>
Message-Id: <20210728153232.1018911-2-dbrazdil@google.com>
Mime-Version: 1.0
References: <20210728153232.1018911-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 1/2] KVM: arm64: Fix off-by-one in range_is_memory
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyp checks whether an address range only covers RAM by checking the
start/endpoints against a list of memblock_region structs. However,
the endpoint here is exclusive but internally is treated as inclusive.
Fix the off-by-one error that caused valid address ranges to be
rejected.

Cc: Quentin Perret <qperret@google.com>
Fixes: 90134ac9cabb6 ("KVM: arm64: Protect the .hyp sections from the host")
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d938ce95d3bd..a6ce991b1467 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -193,7 +193,7 @@ static bool range_is_memory(u64 start, u64 end)
 {
 	struct kvm_mem_range r1, r2;
 
-	if (!find_mem_range(start, &r1) || !find_mem_range(end, &r2))
+	if (!find_mem_range(start, &r1) || !find_mem_range(end - 1, &r2))
 		return false;
 	if (r1.start != r2.start)
 		return false;
-- 
2.32.0.432.gabb21c7263-goog

