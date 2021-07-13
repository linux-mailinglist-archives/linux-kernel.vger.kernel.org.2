Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7B3C7183
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhGMN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53166 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhGMN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:13 -0400
Message-Id: <20210713133945.063650594@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eRec4IXQ1l7hl/6EWxxYBvmpLkCD5mwK/pUmaB1yvI0=;
        b=AH8NUMNjMjYwELxCo4J+1AO9wbOcnKggsAgejqdbjn1ity+xbCI0IIIJSvPoeBSYyvcZN8
        /xzDJjL9zDgn25sGr/5/YCCDY0EzvJoNX+B2SrpaUd3dFuUXb9T5tp9G4CzkmCmKxXa+Ru
        8TScka6uGaIMapH8iBNBsMWdbi1/dbadJvz0gqWF58B8N61Z9bzFoho/ml6AtBA1a4UjmF
        puDJxHsvDpP+wBNejqs9F+7O2PP7Kw7V/1Gt0z7cgyov/D6PLkrnVNPR7caxNeZBT7cFut
        3+NcC78ZyxU67tiMahvRlKEG/8oJ/YJYQoOoSSkrIxlyamFR3SgDcEA9aBkoww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eRec4IXQ1l7hl/6EWxxYBvmpLkCD5mwK/pUmaB1yvI0=;
        b=KqIoTOUotamcQqKI0rq7nfN0cAnAuxwB6y4QMRvpUSLefzFGfOPfahARnk5lSULczJINo9
        L9dOr3KK3XkV4LDw==
Date:   Tue, 13 Jul 2021 15:39:45 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 00/10] hrtimer: Reprogramming and clock_was_set() overhaul
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9sa3MhCgpUaGlzIGlzIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiB0aGUgY2xvY2tfd2FzX3NldCgp
IG92ZXJoYXVsIHRvZ2V0aGVyIHdpdGgKdGhlIGF2b2lkYW5jZSBvZiBkb3VibGUgcmVwcm9ncmFt
bWluZyB3aGVuIHJlYXJtaW5nIGFuIGVucXVldWVkIHRpbWVyLgoKVmVyc2lvbiAxIG9mIHRob3Nl
IHBhdGNoZXMgY2FuIGJlIGZvdW5kIGhlcmU6CgogICBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjEwNDI3MDgyNTM3LjYxMTk3ODcyMEBsaW51dHJvbml4LmRlCmFuZAogICBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzg3djk4OXRvcHUuZmZzQG5hbm9zLnRlYy5saW51dHJvbml4LmRlCgpC
b3RoIHRoZSByZXByb2dyYW1taW5nIGxvZ2ljIGFuZCB0aGUgY2xvY2tfd2FzX3NldCgpIGxvZ2lj
IGFyZSBub3QgcmVhbGx5Cm9wdGltaXplZC4gVGhlIHNlcmllcyBhZGRyZXNzZXMgdGhpcy4KCiAg
LSBBdm9pZCBkb3VibGUgcmVwcm9ncmFtbWluZyB3aGVuIGFuIGVucXVldWVkIHRpbWVyIGlzIHJl
YXJtZWQKCiAgLSBDb25zb2xpZGF0ZSB0aGUgcmVwcm9ncmFtbWluZyB2YXJpYW50cyAoUGV0ZXIg
WmlqbHN0cmEpCgogIC0gRml4IHRoZSBjYXNlcyB3aGVyZSB0aGUgY2xvY2tfd2FzX3NldCgpIGhh
bmRsaW5nIGlzIGluY29ycmVjdCBkZXBlbmRpbmcKICAgIG9uIGNvbmZpZ3VyYXRpb24gb3IgcnVu
dGltZSBjb25kaXRpb25zLgoKICAtIERpc3RhbmdsZSB0aGUgcmVzdW1lIG5vdGlmaWNhdGlvbiBh
bmQgdGhlIGNsb2NrLXdhcy1zZXQgbWVjaGFuaXNtIHRvCiAgICBwcmVwYXJlIGZvciBJUEkgYXZv
aWRhbmNlCgogIC0gQWRvcHQgTWFyY2VsbydzIHBhdGNoIHRvIHRoZSBtb2RpZmllZCBjb2RlIGFu
ZCBhZGQgc29tZSBtb3JlIHNtYXJ0cyBvbgogICAgdG9wLgoKVGhlIHNlcmllcyBpcyBhbHNvIGF2
YWlsYWJsZSBmcm9tIGdpdDoKCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IGhydGltZXIKCkNoYW5nZXMgdnMgVjE6CgogIC0gUGlj
ayB1cCBQZXRlcidzIGNvbnNvbGlkYXRpb24gcGF0Y2gKICAtIFBvbGlzaCBhIGZldyB0aGluZ3MK
ClRoYW5rcywKCgl0Z2x4Ci0tLQogZnMvdGltZXJmZC5jICAgICAgICAgICAgICAgIHwgICAxNiAr
KwogaW5jbHVkZS9saW51eC9ocnRpbWVyLmggICAgIHwgICAgOCAtCiBrZXJuZWwvdGltZS9ocnRp
bWVyLmMgICAgICAgfCAgMzM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tCiBrZXJuZWwvdGltZS90aWNrLWNvbW1vbi5jICAgfCAgICA3IAoga2VybmVsL3RpbWUv
dGljay1pbnRlcm5hbC5oIHwgICAxMiArCiBrZXJuZWwvdGltZS90aW1la2VlcGluZy5jICAgfCAg
IDM2ICsrLS0KIDYgZmlsZXMgY2hhbmdlZCwgMjk5IGluc2VydGlvbnMoKyksIDExNyBkZWxldGlv
bnMoLSkK
