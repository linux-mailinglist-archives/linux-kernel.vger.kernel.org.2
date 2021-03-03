Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4932D641
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhCDPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:15:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhCDPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:45 -0500
Message-Id: <20210303132023.077167457@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614870844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CdClLt4+fuyCD6ZyqthkXbcv3Ic59BWpZ3AO1GEhCVA=;
        b=xMnck+A//N+JJ/RpCJYdExXhoUvZ2fcDik9DVsp1+5j7nuopQjCucFhmvkqVup9fM19Grj
        BXnfokOAQ6iuFq44L7pJ4+c4eVzu+k+76u9fdHc+X7OnXi0aAftiBRG89BlNAzJpRFBBJD
        0M4yCujiJH2tIhkhYO+VhD3K8VhrGHcp+ALOlmOexUgS1vIovXUubnt2oT6Nx6A6SmS/l3
        vzPAPkoceU7qZmr7PyHWloesBXaP6TBOlyFg+fytBEZRG2FbHaO8xuMcvI/nmYapv0qIO8
        m8+eGV23YjiKIi9mf8XHp90jzjRch6yjA6YXHjJhKuuZt3XMjXT6+iEyiqVurw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614870844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CdClLt4+fuyCD6ZyqthkXbcv3Ic59BWpZ3AO1GEhCVA=;
        b=puGQh+pRRhN/TY3HF9OfSaRiQL69Lg4hw447EvqmiySd+QW3AXl1HHcjurw7yenjNobZem
        +chTQ0TX3LANkTDQ==
Date:   Wed, 03 Mar 2021 14:20:23 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [patch 0/7] drm, highmem: Cleanup io/kmap_atomic*() usage
cc:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm9uZSBvZiB0aGUgRFJNIHVzYWdlIHNpdGVzIG9mIHRlbXBvcmFyeSBtYXBwaW5ncyByZXF1aXJl
cyB0aGUgc2lkZQplZmZlY3RzIG9mIGlvL2ttYXBfYXRvbWljKCksIGkuZS4gcHJlZW1wdGlvbiBh
bmQgcGFnZWZhdWx0IGRpc2FibGUuCgpSZXBsYWNlIHRoZW0gd2l0aCB0aGUgaW8va21hcF9sb2Nh
bCgpIHZhcmlhbnRzLCBzaW1wbGlmeSB0aGUKY29weV90by9mcm9tX3VzZXIoKSBlcnJvciBoYW5k
bGluZyBhbmQgcmVtb3ZlIHRoZSBhdG9taWMgdmFyaWFudHMuCgpUaGFua3MsCgoJdGdseAotLS0K
IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9pby1tYXBwaW5nLnJzdCAgICAgICAgICAgICB8ICAg
MjIgKysrLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2V4ZWNidWZm
ZXIuYyAgICAgIHwgICAgNyArLS0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZ2VtLmMgICAg
ICAgICAgICAgICAgICAgICB8ICAgNDAgKysrKysrLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUv
ZHJtL2k5MTUvc2VsZnRlc3RzL2k5MTVfZ2VtLmMgICAgICAgICAgIHwgICAgNCAtCiBkcml2ZXJz
L2dwdS9kcm0vaTkxNS9zZWxmdGVzdHMvaTkxNV9nZW1fZ3R0LmMgICAgICAgfCAgICA4ICstLQog
ZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9zdWJkZXYvZGV2aW5pdC9mYm1lbS5oIHwgICAg
OCArLS0KIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2ltYWdlLmMgICAgICAgICAgICAgICAgICAg
ICB8ICAgMTggKysrKy0tLS0KIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2lvY3RsLmMgICAgICAg
ICAgICAgICAgICAgICB8ICAgMjcgKysrKysrLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4
bF9vYmplY3QuYyAgICAgICAgICAgICAgICAgICAgfCAgIDEyICsrLS0tCiBkcml2ZXJzL2dwdS9k
cm0vcXhsL3F4bF9vYmplY3QuaCAgICAgICAgICAgICAgICAgICAgfCAgICA0IC0KIGRyaXZlcnMv
Z3B1L2RybS9xeGwvcXhsX3JlbGVhc2UuYyAgICAgICAgICAgICAgICAgICB8ICAgIDQgLQogZHJp
dmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jICAgICAgICAgICAgICAgICAgIHwgICAyMCAr
KysrKy0tLS0KIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JsaXQuYyAgICAgICAgICAg
ICAgICB8ICAgMzAgKysrKystLS0tLS0tLS0KIGluY2x1ZGUvbGludXgvaGlnaG1lbS1pbnRlcm5h
bC5oICAgICAgICAgICAgICAgICAgICB8ICAgMTQgLS0tLS0tCiBpbmNsdWRlL2xpbnV4L2lvLW1h
cHBpbmcuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQyIC0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAxNSBmaWxlcyBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCAxNjcgZGVsZXRpb25zKC0p
Cg==
