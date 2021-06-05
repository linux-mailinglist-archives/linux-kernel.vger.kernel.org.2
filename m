Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504439CBE0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhFFAeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFFAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379FC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:32:23 -0700 (PDT)
Message-Id: <20210605234742.712464974@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PDU/VEaGgHypBXGdUOwgOZcP0B2DI/IP4sSBIdbvmk4=;
        b=IMgjGqphWtBaOG2CjznmVT+RbIsx4BlyQfbtlFfJgYUG4Or+LBxstJ8ITmzlc++7uerhyM
        vv41C/O77I6wUNDsdGHPsHPql36Vwr6q7hNK8W9QzCfQbc+Jm7BMqx2uJpXYmI4dBj2JcP
        o1v6LpB+Etj9HWEVJh08TgYXjOUhY/rrFRfUjyHdhHOE+z5VtwwL9c37MYqeZVcoVvYlW+
        XAukJHv+/nAEADYxS2fXYn8TBBotH1EVQaxnU8JgzbmI8b6Z73WJNOTjEC4fvyHFRZxioQ
        3RQWV7gfQjT6myL9wZlBHvmSr6pqtwgSezbDex1FQpyY5SP4GzGf8HaIL2w5nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PDU/VEaGgHypBXGdUOwgOZcP0B2DI/IP4sSBIdbvmk4=;
        b=LaxZANayh804WmwA1zaS6rax+6K37UcJOa5cS6HwLqVWKdfBx92eLM+qEHvxGmwlFmIvNN
        t9jn99gg6vVtdxAA==
Date:   Sun, 06 Jun 2021 01:47:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3lzemJvdCByZXBvcnRlZCBhIHdhcm5vbiBmb3IgWFJTVE9SIHJhaXNpbmcgI0dQOgoKICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzAwMDAwMDAwMDAwMDRjNDUzOTA1YzMwZjgzMzRAZ29vZ2xl
LmNvbQoKd2l0aCBhIHN5emNhbGxlciByZXByb2R1Y2VyIGFuZCBhIGNvbmNsdXNpdmUgYmlzZWN0
IHJlc3VsdC4gIEl0IHRvb2sgYQp3aGlsZSB0byBkZXN0aWxsIGEgc2ltcGxlIEMgcmVwcm9kdWNl
ciBvdXQgb2YgaXQgd2hpY2ggYWxsb3dlZCB0byBwaW4gcG9pbnQKdGhlIHJvb3QgY2F1c2U6IFRo
ZSByZWNlbnQgYWRkaXRpb24gb2Ygc3VwZXJ2aXNvciBYU1RBVEVzIGJyb2tlIHRoZSBzaWduYWwK
cmVzdG9yZSBwYXRoIGZvciB0aGUgY2FzZSB3aGVyZSB0aGUgc2lnbmFsIGhhbmRsZXIgd3JlY2th
Z2VkIHRoZSBYU1RBVEUgb24Kc3RhY2sgYmVjYXVzZSBpdCBkb2VzIG5vdCBzYW5pdGl6ZSB0aGUg
WFNUQVRFIGhlYWRlciB3aGljaCBjYXVzZXMgYQpzdWJzZXF1ZW50IFhSU1RPUiB0byBmYWlsIGFu
ZCAjR1AuCgpUaGUgZm9sbG93aW5nIHNlcmllcyBhZGRyZXNzZXMgdGhlIHByb2JsZW0gYW5kIGZp
eGVzIHJlbGF0ZWQgaXNzdWVzIHdoaWNoCndlcmUgZm91bmQgd2hpbGUgaW5zcGVjdGluZyB0aGUg
cmVsYXRlZCBjaGFuZ2VzLgoKVjEgb2YgdGhpcyBjYW4gYmUgZm91bmQgaGVyZToKCiAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDYwMjA5NTU0My4xNDk4MTQwNjRAbGludXRyb25peC5k
ZQoKQ2hhbmdlcyB2cy4gVjE6CgogIC0gQWRkcmVzcyByZXZpZXcgY29tbWVudHMKCiAgLSBGaXgg
dGhlIHJlcG9ydGVkIGZhbGxvdXQgKG1vc3RseSBQS1JVIGFuZCBQVFJBQ0UpLiBUaGUgdGVzdCBj
YXNlcyBwYXNzCiAgICBub3cuCgogIC0gQWRkcmVzcyB0aGUgYnJva2VuIGluaXRfZnBzdGF0ZSBm
aWRkbGluZyB3aGljaCB3YXMgZm91bmQgYnkgZGVlcGVyCiAgICBpbnNwZWN0aW9uIG9mIHRoZSBQ
S1JVL1hTVEFURSByZWxhdGVkIGNvZGUuCgpUaGFua3MsCgoJdGdseAotLS0KClAuUzogSSBwaWNr
ZWQgdXAgRGF2ZSdzIFBLUlUgc2VyaWVzIGZyb20KCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIxMDYwMzIzMDgwMy4zMTY2MEFGRUB2aWdnby5qZi5pbnRlbC5jb20KCmFuZCBhZG9wdGVk
IGl0IHRvIHRoaXMgcGlsZS4gVGhlIHJlc3VsdCBpcyBoZXJlOgoKICAgIGh0dHBzOi8vdGdseC5k
ZS9+dGdseC9wYXRjaGVzLWZwdS1wa3J1LnRhcgoKVGhlcmUgYXJlIHNvbWUgZml4ZXMgYXQgdGhl
IGVuZCB3aGljaCBJIGRpZCBubyBmb2xkIGJhY2sgeWV0IGFuZCB0aGUgZ2xpYmMKUEtSVSB0ZXN0
IGNhc2Ugd2l0aCBhbGwgdGhhdCBhcHBsaWVkIHN0aWxsIGZhaWxzIHdpdGg6CgogLi4vc3lzZGVw
cy91bml4L3N5c3YvbGludXgvdHN0LXBrZXkuYzozNzc6IG51bWVyaWMgY29tcGFyaXNvbiBmYWls
dXJlCiAgICBsZWZ0OiAxICgweDEpOyBmcm9tOiByZXN1bHQtPmFjY2Vzc19yaWdodHNbaV0KICAg
cmlnaHQ6IDAgKDB4MCk7IGZyb206IDAKIC4uL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3RzdC1w
a2V5LmM6MzgyOiBudW1lcmljIGNvbXBhcmlzb24gZmFpbHVyZQogICAgbGVmdDogMSAoMHgxKTsg
ZnJvbTogcmVzdWx0Mi0+YWNjZXNzX3JpZ2h0c1tpXQogICByaWdodDogMCAoMHgwKTsgZnJvbTog
MAogZXJyb3I6IDIgdGVzdCBmYWlsdXJlcwoKVG9vIHRpcmVkIHRvIGFuYWx5emUgdGhhdCByaWdo
dCBub3csIGJ1dCBJIHdhbnRlZCB0byBzaGFyZSB0aGUgd29yay4KICAgICAKLS0tCiBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9mcHUvaW50ZXJuYWwuaCAgICAgICAgICAgICAgICAgICB8ICAgMTcgLS0K
IGFyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS94c3RhdGUuaCAgICAgICAgICAgICAgICAgICAgIHwg
ICAxMCAtCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDYgCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wa2V5cy5oICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMTEgLQogYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAzIAogYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDI3ICstLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUv
Y29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDExOSArKysrKysrKysrKystLS0t
LS0KIGFyY2gveDg2L2tlcm5lbC9mcHUvcmVnc2V0LmMgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICA0NSArKy0tLS0KIGFyY2gveDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAzMCArKystCiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxMDAgKysrKystLS0tLS0tLS0tCiBhcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTQgKy0KIGFy
Y2gveDg2L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
MiAKIGFyY2gveDg2L21tL3BrZXlzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAzMSArKy0tCiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9jb3JydXB0X3hzdGF0
ZV9oZWFkZXIuYyB8ICAxMTQgKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvcGtleXMu
aCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiAKIHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3g4Ni9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAgMyAKIDE2IGZpbGVz
IGNoYW5nZWQsIDMzNCBpbnNlcnRpb25zKCspLCAyMDAgZGVsZXRpb25zKC0pCgo=
