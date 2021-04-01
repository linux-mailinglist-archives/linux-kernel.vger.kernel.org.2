Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A193E351144
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhDAIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233553AbhDAIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617267183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qv1++mqtRS1JMFi8iLLc3Nq2jTvkRmOVcXl/eUz02RE=;
        b=C/IEu74pw3m31imNXq5tpZ5XM2h+NZAAObVFY8oMOQGiLtWDMs1Htem9a05ofDW0OhBd8B
        m6+y0Qyj0QeIb3QL9URpVOmti2QSygWF7ZB9AosG6EfF7OhXi/tt03io/LLnMQub9TnhwJ
        z1QyRG+iMhvDYZH+0dlqEnkdJDmQMN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-tq8GkQeaMISTZAfqN2afSg-1; Thu, 01 Apr 2021 04:53:00 -0400
X-MC-Unique: tq8GkQeaMISTZAfqN2afSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 547DE18C89C4;
        Thu,  1 Apr 2021 08:52:58 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-13.ams2.redhat.com [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B21655D9CC;
        Thu,  1 Apr 2021 08:52:55 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com,
        alexandru.elisei@arm.com
Cc:     james.morse@arm.com, suzuki.poulose@arm.com, shuah@kernel.org,
        pbonzini@redhat.com
Subject: [PATCH v4 5/8] docs: kvm: devices/arm-vgic-v3: enhance KVM_DEV_ARM_VGIC_CTRL_INIT doc
Date:   Thu,  1 Apr 2021 10:52:35 +0200
Message-Id: <20210401085238.477270-6-eric.auger@redhat.com>
In-Reply-To: <20210401085238.477270-1-eric.auger@redhat.com>
References: <20210401085238.477270-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_arch_vcpu_precreate() returns -EBUSY if the vgic is
already initialized. So let's document that KVM_DEV_ARM_VGIC_CTRL_INIT
must be called after all vcpu creations.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- Must be called after all vcpu creations ->
  Must be called after all VCPUs have been created as per
  Alexandru's suggestion
---
 Documentation/virt/kvm/devices/arm-vgic-v3.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/devices/arm-vgic-v3.rst b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
index 5dd3bff519783..51e5e57625716 100644
--- a/Documentation/virt/kvm/devices/arm-vgic-v3.rst
+++ b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
@@ -228,7 +228,7 @@ Groups:
 
     KVM_DEV_ARM_VGIC_CTRL_INIT
       request the initialization of the VGIC, no additional parameter in
-      kvm_device_attr.addr.
+      kvm_device_attr.addr. Must be called after all VCPUs have been created.
     KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES
       save all LPI pending bits into guest RAM pending tables.
 
-- 
2.26.3

