Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170E830D781
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhBCK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:28:19 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:15410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233840AbhBCK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:27:38 -0500
X-UUID: 4f3509ed5a864599ae31313abd2c1798-20210203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oRQwwEBqC4tKIu7cXvamzV8CPVw7VRwU+JGP2zYTRyU=;
        b=VNzHi5FwcNFawbvb3kelq0+m02Q+mqSnGRZozUL+EB6RQ8tOSMoszXr89xzvmXC5EuBmGjCmsMMnf3PMbUvFVRO90qNJC/sT3KPNijEPQsb04Y3LI4ykrBeyK7mwXYJotMBao7c2AQFnyqg7HutZmU9nzENKb/HmO1zEKgNbqLo=;
X-UUID: 4f3509ed5a864599ae31313abd2c1798-20210203
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1460794024; Wed, 03 Feb 2021 18:26:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 18:26:46 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 18:26:46 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add compatible for mt8195
Date:   Wed, 3 Feb 2021 18:26:40 +0800
Message-ID: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B45C9A23E638F617A8804501C1C14A4441E4A31D6616F8B7CF5DFAD9D9CF1FB82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgYXJlIDQgVVNCIGNvbnRyb2xsZXJzIG9uIE1UODE5NSwgdGhlIGNvbnRyb2xsZXJzIChJ
UDF+SVAzLA0KZXhjbHVkZSBJUDApIGhhdmUgYSB3cm9uZyBkZWZhdWx0IFNPRi9JVFAgaW50ZXJ2
YWwgd2hpY2ggaXMNCmNhbGN1bGF0ZWQgZnJvbSB0aGUgZnJhbWUgY291bnRlciBjbG9jayAyNE1o
eiBieSBkZWZhdWx0LCBidXQNCmluIGZhY3QsIHRoZSBmcmFtZSBjb3VudGVyIGNsb2NrIGlzIDQ4
TWh6LCBzbyB3ZSBzaG91bGQgc2V0DQp0aGUgYWNjdXJhdGUgaW50ZXJ2YWwgYWNjb3JkaW5nIHRv
IDQ4TWh6LiBIZXJlIGFkZCBhIG5ldyBjb21wYXRpYmxlDQpmb3IgTVQ4MTk1LCBpdCdzIGFsc28g
c3VwcG9ydGVkIGluIGRyaXZlci4gQnV0IHRoZSBmaXJzdCBjb250cm9sbGVyDQooSVAwKSBoYXMg
bm8gc3VjaCBpc3N1ZSwgd2UgcHJlZmVyIHRvIHVzZSBnZW5lcmljIGNvbXBhdGlibGUsDQplLmcu
IG10ODE5MidzIGNvbXBhdGlibGUuDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0IHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2ku
dHh0DQppbmRleCA0MmQ4ODE0ZjkwM2EuLjAyY2JhNDIxMmY3ZCAxMDA2NDQNCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14
aGNpLnR4dA0KQEAgLTE2LDYgKzE2LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAJIm1lZGlh
dGVrLG10ay14aGNpIiBjb21wYXRpYmxlIHN0cmluZywgeW91IG5lZWQgU29DIHNwZWNpZmljIG9u
ZXMgaW4NCiAJYWRkaXRpb24sIG9uZSBvZjoNCiAJLSAibWVkaWF0ZWssbXQ4MTczLXhoY2kiDQor
CS0gIm1lZGlhdGVrLG10ODE5NS14aGNpIg0KICAtIHJlZyA6IHNwZWNpZmllcyBwaHlzaWNhbCBi
YXNlIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIHJlZ2lzdGVycw0KICAtIHJlZy1uYW1lczogc2hv
dWxkIGJlICJtYWMiIGZvciB4SENJIE1BQyBhbmQgImlwcGMiIGZvciBJUCBwb3J0IGNvbnRyb2wN
CiAgLSBpbnRlcnJ1cHRzIDogaW50ZXJydXB0IHVzZWQgYnkgdGhlIGNvbnRyb2xsZXINCi0tIA0K
Mi4xOC4wDQo=

