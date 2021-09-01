Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01B63FE5F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhIAXGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhIAXGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630537511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XOXIYLGU0WlQoaofc/0VprBGpvSpPcWESQT+iRicL88=;
        b=B+WQGp16CBl03/dOXd5QF4ro8moPENWI0c5qZtFYDoMMewF4RW6n6mlSjyYYt4NGLhCzA2
        kN6+mpeo4Iev2ZFELhwFrv0D8Fa9w7N5yCIJb/hEolZ9JMsXJUSINU2CImiNkWlaFmV0ao
        V9kHyO36Nnkrkt5GfhM04ifNQ28Rg3c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-kthNY_oKMC6UTkntm-hKuQ-1; Wed, 01 Sep 2021 19:05:10 -0400
X-MC-Unique: kthNY_oKMC6UTkntm-hKuQ-1
Received: by mail-qv1-f70.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so100304qvt.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOXIYLGU0WlQoaofc/0VprBGpvSpPcWESQT+iRicL88=;
        b=covTozhC5gPgOm4wDJhN4X19tjKPYec9czcWCYeUZsGFcUOBQtCKh7j4PEVnLpXYBe
         s78pdSJuimlbD1jWeFFr9+NGjFg5y40ZeB7LG9n/DXKlOCW64iZmUX9bfPDfzqRs6Vgz
         6JbaVVs6OKFc3IIScz2x1FmJKKzabak+F5LeSDO9xcBf9KBhOeL7Z/Ts36d3dvJZzIxK
         v0Afuk45VeIgo3i7fZPHgLw86hYvLeFzxTlfCQmB0RPxd/jL44zgwfSUPnEe2uCDoqWr
         AxevYl+btDjpLfZlP3iNNfsnEySRMzPQFN34IsNqL8bVRviXX/4OJWeFjUWI3RLocMnO
         +FCA==
X-Gm-Message-State: AOAM533ZPOLBzmfTZo9sCZOo+XnEjd32b0YY15LH0lX4S2Tu1OZLn8Lf
        rGYOMWNKfOkk36D8h+TeGeLZlDiTKDaNnBHbLHR4D1igdNhX5evPDjPmoqbAQRfhSwcPtoPz5Ky
        Hp1egk4w/PPCDljXGQwZgw6zM41kqkkcgItGdsMrbX3pP2FYp5ud+R9tAM9t0tUYjGQ+dl/LOHg
        ==
X-Received: by 2002:a0c:8d0f:: with SMTP id r15mr116372qvb.1.1630537509207;
        Wed, 01 Sep 2021 16:05:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylN5m0HPJZRHFIQx1XHVbgFelGJ//FdrwxyGEDZLNod5L6H2TPSEbxaeduwAlMMPwDfF8YaQ==
X-Received: by 2002:a0c:8d0f:: with SMTP id r15mr116342qvb.1.1630537508927;
        Wed, 01 Sep 2021 16:05:08 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id l13sm69749qkp.97.2021.09.01.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:05:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] KVM: Drop unused kvm_dirty_gfn_harvested()
Date:   Wed,  1 Sep 2021 19:05:06 -0400
Message-Id: <20210901230506.13362-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unused function as reported by test bot.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/dirty_ring.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 7aafefc50aa7..88f4683198ea 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -91,11 +91,6 @@ static inline void kvm_dirty_gfn_set_dirtied(struct kvm_dirty_gfn *gfn)
 	gfn->flags = KVM_DIRTY_GFN_F_DIRTY;
 }
 
-static inline bool kvm_dirty_gfn_invalid(struct kvm_dirty_gfn *gfn)
-{
-	return gfn->flags == 0;
-}
-
 static inline bool kvm_dirty_gfn_harvested(struct kvm_dirty_gfn *gfn)
 {
 	return gfn->flags & KVM_DIRTY_GFN_F_RESET;
-- 
2.31.1

