Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02922387533
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbhERJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347938AbhERJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E60C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:33:13 -0700 (PDT)
Message-Id: <20210518091725.046774792@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F013rQx8kVLjRBvwLGIM4eJIUfTukYcnmJFI+pPxhiU=;
        b=KKS33fP51PiCM0ZWRaBthTlweJYoNIK74Ag8UBpwnasKoXcxPdjBcc3icHdx9n6KVuedcT
        Cwf14Jz2/pg7LrnEj52fCw7IaDzh0D6o5koDHSCevZ2gp6+yA48t0+SVHlZim97mezoePm
        gATXhu7dUYr+ZHJPmPjm7w1cwVSrUr2qZ5Ru7TmLtV0gL7NgITcltiQQDdqMwY4YpcOLBM
        Du4CFb59I8GLOulRAWLmb2ZL1IHBmnc3cbEVsMcQY5I2808dRL6E0/GGELZ/VlMj7uOfJi
        1N+m8259GSVS+JNs3ZfDi65poz8cdsdVPBcv7p1SrOJjU7/xPnwVH2yl3Qtbqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F013rQx8kVLjRBvwLGIM4eJIUfTukYcnmJFI+pPxhiU=;
        b=h3XWcxkcbxu9AOw2VMn4X0OLpSWaX3z1eSGqXmLdGFNiO0wmMabVeT7m18LMT3TyoNMv+s
        XiZvhg863JY/oLCg==
Date:   Tue, 18 May 2021 11:17:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [patch 0/8] genirq, perf: Cleanup the abuse of irq_set_affinity_hint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1vZHVsYXIgUE1VIGRyaXZlcnMgdXNlIGlycV9zZXRfYWZmaW5pdHlfaGludCgpIHRvIHNl
dCB0aGUgYWZmaW5pdHkKZm9yIHRoZSBQTVUgaW50ZXJydXB0cywgd2hpY2ggcmVsaWVzIG9uIHRo
ZSB1bmRvY3VtZW50ZWQgc2lkZSBlZmZlY3QgdGhhdAp0aGlzIGZ1bmN0aW9uIGFjdHVhbGx5IHNl
dHMgdGhlIGFmZmluaXR5IHVuZGVyIHRoZSBob29kLgoKU2V0dGluZyBhbiBoaW50IGlzIGNsZWFy
bHkgbm90IGEgZ3VhcmFudGVlIGFuZCBmb3IgdGhlc2UgUE1VIGludGVycnVwdHMgYW4KYWZmaW5p
dHkgaGludCwgd2hpY2ggaXMgc3VwcG9zZWQgdG8gZ3VpZGUgdXNlcnNwYWNlIGZvciBzZXR0aW5n
IGFmZmluaXR5LAppcyBiZXlvbmQgcG9pbnRsZXNzLCBiZWNhdXNlIHRoZSBhZmZpbml0eSBvZiB0
aGVzZSBpbnRlcnJ1cHRzIGNhbm5vdCBiZQptb2RpZmllZCBmcm9tIHVzZXIgc3BhY2UuCgpBc2lk
ZSBvZiB0aGF0IHRoZSBlcnJvciBjaGVja3MgYXJlIGJvZ3VzIGJlY2F1c2UgdGhlIG9ubHkgZXJy
b3Igd2hpY2ggaXMKcmV0dXJuZWQgZnJvbSBpcnFfc2V0X2FmZmluaXR5X2hpbnQoKSBpcyB3aGVu
IHRoZXJlIGlzIG5vIGlycSBkZXNjcmlwdG9yCmZvciB0aGUgaW50ZXJydXB0IG51bWJlciwgYnV0
IG5vdCB3aGVuIHRoZSBhZmZpbml0eSBzZXQgZmFpbHMuIFRoYXQncyBvbgpwdXJwb3NlIGJlY2F1
c2UgdGhlIGhpbnQgY2FuIHBvaW50IHRvIGFuIG9mZmxpbmUgQ1BVLgoKU2lnaCwgaWYgcGVvcGxl
IHdvdWxkIGF0IGxlYXN0IHRhbGsgaWYgc29tZXRoaW5nIGlzIG1pc3NpbmcuLi4KCkNsZWFuIHVw
IHRoZSBtZXNzIGJ5IGV4cG9zaW5nIGlycV9zZXRfYWZmaW5pdHkoKSBhbmQgY29udmVydGluZyB0
aGUgZHJpdmVycwpvdmVyIHRvIHRoYXQuCgpUaGFua3MsCgoJdGdseAotLS0KIGRyaXZlcnMvcGVy
Zi9hcm0tY2NuLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDYgKy0tLQogZHJpdmVycy9w
ZXJmL2FybS1jbW4uYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgOSArLS0tLS0KIGRyaXZl
cnMvcGVyZi9hcm1fZG1jNjIwX3BtdS5jICAgICAgICAgICAgICAgICB8ICAgIDUgKy0tCiBkcml2
ZXJzL3BlcmYvYXJtX2RzdV9wbXUuYyAgICAgICAgICAgICAgICAgICAgfCAgICA4ICstLS0tCiBk
cml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYyAgICAgICAgICAgICAgICAgfCAgIDEwICsrLS0t
LS0KIGRyaXZlcnMvcGVyZi9mc2xfaW14OF9kZHJfcGVyZi5jICAgICAgICAgICAgICB8ICAgIDUg
Ky0tCiBkcml2ZXJzL3BlcmYvaGlzaWxpY29uL2hpc2lfdW5jb3JlX2RkcmNfcG11LmMgfCAgICAz
IC0tCiBkcml2ZXJzL3BlcmYvaGlzaWxpY29uL2hpc2lfdW5jb3JlX2hoYV9wbXUuYyAgfCAgICAz
IC0tCiBkcml2ZXJzL3BlcmYvaGlzaWxpY29uL2hpc2lfdW5jb3JlX2wzY19wbXUuYyAgfCAgICAz
IC0tCiBkcml2ZXJzL3BlcmYvaGlzaWxpY29uL2hpc2lfdW5jb3JlX3BhX3BtdS5jICAgfCAgICAz
IC0tCiBkcml2ZXJzL3BlcmYvaGlzaWxpY29uL2hpc2lfdW5jb3JlX3BtdS5jICAgICAgfCAgICA0
ICstCiBkcml2ZXJzL3BlcmYvaGlzaWxpY29uL2hpc2lfdW5jb3JlX3NsbGNfcG11LmMgfCAgICAz
IC0tCiBpbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oICAgICAgICAgICAgICAgICAgICAgfCAgIDM1
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBrZXJuZWwvaXJxL21hbmFnZS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDMzICsrKysrKysrKysrKysrKysrKysrKysrLQogMTQgZmls
ZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgODEgZGVsZXRpb25zKC0pCgoK
