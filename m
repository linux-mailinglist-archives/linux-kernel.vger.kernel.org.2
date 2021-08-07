Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051E13E32DA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhHGDFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:05:24 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129]:45460 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhHGDFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:05:22 -0400
X-QQ-GoodBg: 1
X-QQ-SSF: 0040000000000010
X-QQ-FEAT: UXxRjkAwy+gwVJOAPjIy1knZ6BHCIfF/CdFgbbt/cBkpKikAE3SjX7VjyQnMG
        kS2oMu03FEWrvYDHMUdgeUG440N1M7ui3mDgjp8fqSLLeotFmlc7aUSU7cxxjMnx63qtSrP
        5p7KM73Juqa5aqw/oJLCfrq7HT3FnVmltcBpIoC5InnvQV144vp2qDUANiW9dK9CV9qWTAl
        NGPO39vSUc68hAgs88Hm5FhqYsMPYSTJqnID+tl8zmjCW4TLvV6SFQyfiKJlnWaZymNrXds
        4ONM6R9hp8MZG8DGz5SxKW5SXvfpJ//2aqoEus6pFhVkpLUPdnYt7f/idTy3du6UAuLI7iu
        YCLGFYV
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 139.226.39.251
X-QQ-STYLE: 
X-QQ-mid: logic626t1628305491t481666
From:   "=?ISO-8859-1?B?Q2hlbiBMaQ==?=" <chenli@uniontech.com>
To:     "=?ISO-8859-1?B?aGVyYmVydA==?=" <herbert@gondor.apana.org.au>,
        "=?ISO-8859-1?B?ZGF2ZW0=?=" <davem@davemloft.net>,
        "=?ISO-8859-1?B?bGludXgtY3J5cHRv?=" <linux-crypto@vger.kernel.org>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: lib/sha256 - add sha256_value function
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Sat, 7 Aug 2021 11:04:51 +0800
X-Priority: 1
Message-ID: <tencent_68FC194846DCFC8653D8D915@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Sat, 07 Aug 2021 11:04:53 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgZnVuY3Rpb24gc2hhMjU2X3ZhbHVlKCkgd2hpY2ggYWNjZXB0cyBhIHN0cmluZyBh
bmQgc3RvcmUgU0hBMjU2IGhhc2gNCm9mIHRoaXMgc3RyaW5nIGludG8gZGVzdC4NCg0KU2ln
bmVkLW9mZi1ieTogQ2hlbiBMaSA8Y2hlbmxpQHVuaW9udGVjaC5jb20+DQotLS0NCiBpbmNs
dWRlL2NyeXB0by9zaGEyLmggfCAgMSArDQogbGliL2NyeXB0by9zaGEyNTYuYyAgIHwgMjMg
KysrKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvY3J5cHRvL3NoYTIuaCBiL2luY2x1ZGUv
Y3J5cHRvL3NoYTIuaA0KaW5kZXggMjgzOGY1MjlmMzFlLi5jZTE3OTU0Y2FiMzggMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL2NyeXB0by9zaGEyLmgNCisrKyBiL2luY2x1ZGUvY3J5cHRvL3No
YTIuaA0KQEAgLTExNSw2ICsxMTUsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2hhMjU2X2lu
aXQoc3RydWN0IHNoYTI1Nl9zdGF0ZSAqc2N0eCkNCiB2b2lkIHNoYTI1Nl91cGRhdGUoc3Ry
dWN0IHNoYTI1Nl9zdGF0ZSAqc2N0eCwgY29uc3QgdTggKmRhdGEsIHVuc2lnbmVkIGludCBs
ZW4pOw0KIHZvaWQgc2hhMjU2X2ZpbmFsKHN0cnVjdCBzaGEyNTZfc3RhdGUgKnNjdHgsIHU4
ICpvdXQpOw0KIHZvaWQgc2hhMjU2KGNvbnN0IHU4ICpkYXRhLCB1bnNpZ25lZCBpbnQgbGVu
LCB1OCAqb3V0KTsNCitpbnQgIHNoYTI1Nl92YWx1ZSh1OCAqKmRlc3QsIGNvbnN0IHU4ICpz
cmMpOw0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBzaGEyMjRfaW5pdChzdHJ1Y3Qgc2hhMjU2
X3N0YXRlICpzY3R4KQ0KIHsNCmRpZmYgLS1naXQgYS9saWIvY3J5cHRvL3NoYTI1Ni5jIGIv
bGliL2NyeXB0by9zaGEyNTYuYw0KaW5kZXggNzJhNGIwYjFkZjI4Li5jZTFkZTdhM2UzMmUg
MTAwNjQ0DQotLS0gYS9saWIvY3J5cHRvL3NoYTI1Ni5jDQorKysgYi9saWIvY3J5cHRvL3No
YTI1Ni5jDQpAQCAtMTMsNiArMTMsOCBAQA0KIA0KICNpbmNsdWRlIDxsaW51eC9iaXRvcHMu
aD4NCiAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L21tLmg+
DQorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
DQogI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KICNpbmNsdWRlIDxjcnlwdG8vc2hhMi5o
Pg0KQEAgLTIwNiw0ICsyMDgsMjUgQEAgdm9pZCBzaGEyNTYoY29uc3QgdTggKmRhdGEsIHVu
c2lnbmVkIGludCBsZW4sIHU4ICpvdXQpDQogfQ0KIEVYUE9SVF9TWU1CT0woc2hhMjU2KTsN
CiANCitpbnQgc2hhMjU2X3ZhbHVlKHU4ICoqZGVzdCwgY29uc3QgdTggKnNyYykNCit7DQor
CXU4IG91dFtTSEEyNTZfRElHRVNUX1NJWkVdOw0KKwlpbnQgaSwgazsNCisJdW5zaWduZWQg
Y2hhciBoZXhbMl07DQorDQorCSpkZXN0ID0ga3ZtYWxsb2Moc2l6ZW9mKHU4KSAqIChTSEEy
NTZfQkxPQ0tfU0laRSArIDEpLCBHRlBfS0VSTkVMKTsNCisJaWYgKFpFUk9fT1JfTlVMTF9Q
VFIoKmRlc3QpKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorCXNoYTI1NihzcmMsIHN0cmxlbihz
cmMpLCBvdXQpOw0KKw0KKwlmb3IgKGkgPSAwLCBrID0gMDsgaSA8IFNIQTI1Nl9ESUdFU1Rf
U0laRTsgaSsrKSB7DQorCQlzcHJpbnRmKGhleCwgIiUwMngiLCBvdXRbaV0pOw0KKwkJKCpk
ZXN0KVtrKytdID0gaGV4WzBdOw0KKwkJKCpkZXN0KVtrKytdID0gaGV4WzFdOw0KKwl9DQor
CSgqZGVzdClba10gPSAnXDAnOw0KKwlyZXR1cm4gMDsNCit9DQorRVhQT1JUX1NZTUJPTChz
aGEyNTZfdmFsdWUpOw0KKw0KIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCi0tIA0KMi4zMi4w
LjkzLmc2NzBiODFhODkw



