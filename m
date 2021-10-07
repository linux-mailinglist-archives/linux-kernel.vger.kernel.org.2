Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071942604E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhJGXSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJGXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:18:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E8C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:16:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 124-20020a251182000000b005a027223ed9so9982979ybr.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=ywF2/rgM1bhy2sAaNDgCO3TYtTem4+JSfSFNkboo73g=;
        b=Nl2uaV7VRRjEOm/tpJ9KZVG7uSLYTfk8nEgePBQYBAjZk1f3EiWye9NDSWsSw7PtOE
         y91pUjSmvUwIhExZXsJnE2C3nHeRgeyoMJmuOxe8hK81N5hP+os1RkjJP704V7nSMlDV
         KYSJQNXlZrmU4J3O4GXkEcmdApLX640FSxzOSpNBfucZUFQn645ex3fSQSF0y6jZg9YU
         v0/K4HlgzySOEYa7YUtzKPeoV0EqUuuEY6R9QO8I13kD9lsVeXHiRCSeHZ0xzT1F0uzB
         yzqzb1lMFJqmVu3knJes7mA5BxrrZblOg4zDOqNOkVGvROtrc2G76S8j0nX6S2Cv9HEK
         fi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=ywF2/rgM1bhy2sAaNDgCO3TYtTem4+JSfSFNkboo73g=;
        b=GLZe9262xNbu1pyb8uKx8CznKWwdkZ5SRgRGCKQyzOFeB6Nn4015Dw1puKDr/F+SNG
         lTRcLaiB0qQdu5V8tB0brj/jZD+HGjFFX6p3FG7JsC8G9lFqaad1pz0w0DZOso/A+sPV
         pfD0yFpQ3xKtZRXHJ5rd5nDschT0dyqJREqSUuyS9z9NdxkA3IJlnqfA+jxodorfwL8p
         BQHgyZ/k6j8wfrMIU2TcyXwdHued6u5Ul9glA9KVtG98bt2kp0Z1NV1gXa0IyN0Yajc6
         XuJVo10lMlHA5TYjQ7zFpISJxkAmY/JgRYqrknUsOGaVGm1EqpDu2IcArD8NgJQXIPoO
         pZcw==
X-Gm-Message-State: AOAM530ymC+Ao1yJhIdedBooOBf+vWfK/9PkW3ju6RtafkW3MDFmg+CS
        0v1NePON61z7Kv5s9lQdn+9IIvXnYiY=
X-Google-Smtp-Source: ABdhPJwFiYLQxeDfIfgpJxmittGB2vzEHNxXIQU0imnuo3OfNnGuEIqL7ToIQUEBA1Eq40kG7OqhCwhiSN4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:2783:a5c0:45f5:b0ed])
 (user=seanjc job=sendgmr) by 2002:a25:6150:: with SMTP id v77mr7923658ybb.530.1633648609838;
 Thu, 07 Oct 2021 16:16:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  7 Oct 2021 16:16:47 -0700
Message-Id: <20211007231647.3553604-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] KVM: x86: Account for 32-bit kernels when handling address in
 TSC attrs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling TSC attributes, cast the userspace provided virtual address
to an unsigned long before casting it to a pointer to fix warnings on
32-bit kernels due to casting a 64-bit integer to a 32-bit pointer.

Add a check that the truncated address matches the original address, e.g.
to prevent userspace specifying garbage in bits 63:32.

  arch/x86/kvm/x86.c: In function =E2=80=98kvm_arch_tsc_get_attr=E2=80=99:
  arch/x86/kvm/x86.c:4947:22: error: cast to pointer from integer of differ=
ent size
   4947 |  u64 __user *uaddr =3D (u64 __user *)attr->addr;
        |                      ^
  arch/x86/kvm/x86.c: In function =E2=80=98kvm_arch_tsc_set_attr=E2=80=99:
  arch/x86/kvm/x86.c:4967:22: error: cast to pointer from integer of differ=
ent size
   4967 |  u64 __user *uaddr =3D (u64 __user *)attr->addr;
        |                      ^

Cc: Oliver Upton <oupton@google.com>
Fixes: 469fde25e680 ("KVM: x86: Expose TSC offset controls to userspace")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 196ac33ef958..4a52a08707de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4944,9 +4944,12 @@ static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vc=
pu,
 static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
 				 struct kvm_device_attr *attr)
 {
-	u64 __user *uaddr =3D (u64 __user *)attr->addr;
+	u64 __user *uaddr =3D (u64 __user *)(unsigned long)attr->addr;
 	int r;
=20
+	if ((u64)(unsigned long)uaddr !=3D attr->addr)
+		return -EFAULT;
+
 	switch (attr->attr) {
 	case KVM_VCPU_TSC_OFFSET:
 		r =3D -EFAULT;
@@ -4964,10 +4967,13 @@ static int kvm_arch_tsc_get_attr(struct kvm_vcpu *v=
cpu,
 static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 				 struct kvm_device_attr *attr)
 {
-	u64 __user *uaddr =3D (u64 __user *)attr->addr;
+	u64 __user *uaddr =3D (u64 __user *)(unsigned long)attr->addr;
 	struct kvm *kvm =3D vcpu->kvm;
 	int r;
=20
+	if ((u64)(unsigned long)uaddr !=3D attr->addr)
+		return -EFAULT;
+
 	switch (attr->attr) {
 	case KVM_VCPU_TSC_OFFSET: {
 		u64 offset, tsc, ns;
--=20
2.33.0.882.g93a45727a2-goog

