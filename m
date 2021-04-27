Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70D836C117
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhD0Iil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhD0Iij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 01:37:56 -0700 (PDT)
Message-Id: <20210427082537.611978720@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aXdWCEcQvvSrnJB84jIhU9qLz/MW/rYJ6ms9LSSpAWs=;
        b=CHpYTT4/cEBqcOm2u2DOAS5kxzEtXJd7dtZl5vCS10HZ33qQHNJxuCA3cd4aUzEEfpOIKV
        toMx7xES7SwYwR0hJheEHd4QC3PB99IIfDTMvsKjFKXT3gc63fDgZnqwNxfIaehQqv74Br
        eQ20uGtdvxFnGG0DMWVRAPILudmeeKtpRXkxC2IHSCehRyYyfIomc7oHKjpKfiBcnF36Ax
        9l37HEiFdR9YrMZ/0Oovh0OA0q+XVuGOX19MwJBGymPxlNA3jkFnpScqwlxMkDexJVqzSk
        zGkkEOCvzFv+U0YTw/FRoZqfuRV+snniNyw7Tmlyu4NFOF4yZKDz9OFZX3phvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aXdWCEcQvvSrnJB84jIhU9qLz/MW/rYJ6ms9LSSpAWs=;
        b=vEhu4ivPipBoE86F3WJyVtE+wuFrw5YojQ3B984Azz2zGJ9JFZ3DJx1gOdfRSKUuQqSNR9
        yV3yJ+8ypGhIE4Dw==
Date:   Tue, 27 Apr 2021 10:25:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [patch 0/8] hrtimers: Overhaul the clock_was_set() logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSByZWNlbnQgcGF0Y2ggZnJvbSBNYXJjZWxvIHRvIGF2b2lkIElQSXMgd2hlbiB0aGUgY2xvY2sg
d2FzIHNldAoKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwNDA3MTM1MzAxLkdBMTY5
ODVAZnVsbGVyLmNuZXQKCm1hZGUgbWUgbG9vayBkZWVwZXIgaW50byB0aGlzLgoKVGhhdCBtZWNo
YW5pc20gaGFzIGNhdWdodCBzb21lIGR1c3QgYW5kIGJpdHJvdCBvdmVyIHRpbWUgYW5kIGp1c3Qg
bWFraW5nCmNsb2NrX3dhc19zZXQoKSBhIGxpdHRsZSBiaXQgc21hcnRlciBkb2VzIG5vdCBtYWtl
IHRoZSBjb2RlIGFueSBiZXR0ZXIuCgpUaGUgZm9sbG93aW5nIHNlcmllcyBhZGRyZXNzZXMgdGhp
cyBieToKCiAtIEZpeGluZyB0aGUgY2FzZXMgd2hlcmUgdGhlIGNsb2NrX3dhc19zZXQoKSBoYW5k
bGluZyBpcyBpbmNvcnJlY3QKICAgZGVwZW5kaW5nIG9uIGNvbmZpZ3VyYXRpb24gb3IgcnVudGlt
ZSBjb25kaXRpb25zLgoKIC0gRGlzdGFuZ2xlIHRoZSByZXN1bWUgbm90aWZpY2F0aW9uIGFuZCB0
aGUgY2xvY2std2FzLXNldCBtZWNoYW5pc20KICAgdG8gcHJlcGFyZSBmb3IgSVBJIGF2b2lkYW5j
ZQoKIC0gQWRvcHQgTWFyY2VsbydzIHBhdGNoIHRvIHRoZSBtb2RpZmllZCBjb2RlIGFuZCBhZGQg
c29tZSBtb3JlIHNtYXJ0cyBvbgogICB0b3AuCgpUaGUgc2VyaWVzIGlzIGFsc28gYXZhaWxhYmxl
IGZyb20gZ2l0OgoKICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGdseC9kZXZlbC5naXQgaHJ0aW1lcgoKVGhhbmtzLAoKCXRnbHgKLS0tCiBmcy90aW1lcmZk
LmMgICAgICAgICAgICAgICAgfCAgIDE2ICsrKwogaW5jbHVkZS9saW51eC9ocnRpbWVyLmggICAg
IHwgICAgOCAtCiBrZXJuZWwvdGltZS9ocnRpbWVyLmMgICAgICAgfCAgMjE3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBrZXJuZWwvdGltZS90aWNrLWNvbW1v
bi5jICAgfCAgICA3ICsKIGtlcm5lbC90aW1lL3RpY2staW50ZXJuYWwuaCB8ICAgMTIgKysKIGtl
cm5lbC90aW1lL3RpbWVrZWVwaW5nLmMgICB8ICAgMzYgKysrKy0tLQogNiBmaWxlcyBjaGFuZ2Vk
LCAyMTkgaW5zZXJ0aW9ucygrKSwgNzcgZGVsZXRpb25zKC0pCg==
