Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511473FE5FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbhIAXKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhIAXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630537748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O15h3cnMt3r90lGmwHlcMNuy4JQHK1FoGivTCAbP3QU=;
        b=WI23YuJpoCYjnQuvMp/Fjx/+hbsnzhyI/hroXacgVrZG8CpsWezHIld/gKe9fvIWMLswwx
        fktf5cG7UwU8FYqYHCoh6WAXuqkcL0v30tq/HHikp6kH/Kq9XDk94ulvD8it46Ti2cuB/I
        EXNKECZiOBn5Mt05JSXNVLsCbSVzbSc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-xOMobvCcOLKlvU8pcFBFsA-1; Wed, 01 Sep 2021 19:09:07 -0400
X-MC-Unique: xOMobvCcOLKlvU8pcFBFsA-1
Received: by mail-qk1-f198.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so29273qkh.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O15h3cnMt3r90lGmwHlcMNuy4JQHK1FoGivTCAbP3QU=;
        b=PbkQTLRaaV9RNa7sg1HWivEUMKS4oCcaHAGlezVLHq+4Dg0R3/2wt8SRHBISl8bSlH
         440uzvMkW/NrUidYzesAXcNXPreYWhBXSuJwiNijl9Y//9yJE9qfWYQu3QRq1GC9nx5j
         yJugTunBHT9/2K/xJKUPkjio2sQyOHxuZx2VkSfamTbSovw8TzmEVq861VZXPwkK51w2
         +1C/eBkeFj0kNjMLtKcfkSBEodgPJ0wTQFa87BlJh31s62EZ8Vw5p4VUXLmKeXfE4y9u
         pvqmRArKgMtn4uKjhDHjW+/Qn1AxeAsB+xOytTBFZHegL94iX/SBJYoAK+dk97h/a+IE
         0qoQ==
X-Gm-Message-State: AOAM531zuje28vS8ZfeVcMk54ygiyqXK5EOidP9+hojBp4OJmsihkDWI
        DRVGqQkejUkVy1HK4fquxZIpqk3p1PsGyw9fGw7e+cUSVyNzIn8JXnIfD11R98XnqbzkQDwlJsx
        yQcmqWG5DqC3nA7b6f6xXfaU58TJauP282kxAAtF18ZpGl9zaqWUKcyXllAcHXEhJ8FtBIHNG7A
        ==
X-Received: by 2002:a37:9606:: with SMTP id y6mr365141qkd.13.1630537746888;
        Wed, 01 Sep 2021 16:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9XwSNTYstZ57acJcE/IHaVbtArR01acSqrUKGp0QC9HqkkUTWtg/HBX5PlhcO88Dujmz14A==
X-Received: by 2002:a37:9606:: with SMTP id y6mr365114qkd.13.1630537746633;
        Wed, 01 Sep 2021 16:09:06 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id j23sm87559qkl.65.2021.09.01.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:09:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] KVM: Drop unused kvm_dirty_gfn_invalid()
Date:   Wed,  1 Sep 2021 19:09:04 -0400
Message-Id: <20210901230904.15164-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unused function as reported by test bot.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
--
v2:
- Fix the subject that points to the right function; the copy-paste failed.
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

