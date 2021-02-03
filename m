Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9881E30D369
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 07:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhBCGdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 01:33:37 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51442 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230072AbhBCGdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:33:36 -0500
X-UUID: ea045c50623a494f93a4516e2cc661e0-20210203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kvt11SlkOZybA/MDMjfWqmErggnnd9YVI0O6nOjXt5U=;
        b=a5HQTqRNf3Da2x943rGjd3uhtnG7erUqHDdhYkyVHYCKriNjgu8qpkAhCMmJi9QOsQZxMCSTtcqwoZVt1oPsHrTMl1exOPS2Yj0fvMxyXLAE/nmrTIq5x+deu05vFxVhOH6qa/1GMZsXeyAqwEJ2PNW7cwm3SslkNRWbvw4XGYc=;
X-UUID: ea045c50623a494f93a4516e2cc661e0-20210203
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1385229869; Wed, 03 Feb 2021 14:32:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 14:32:45 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 14:32:45 +0800
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
Subject: [RFC PATCH 1/3] dt-bindings: usb: mtk-xhci: add compatible for mt8195
Date:   Wed, 3 Feb 2021 14:31:57 +0800
Message-ID: <20210203063159.11021-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB33ADAD09D7543E95313A04B7A5561973C6E8CA455E17167FA0A7B3AE61E4762000:8
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
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0IHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0DQppbmRleCA0MmQ4ODE0Zjkw
M2EuLjAyY2JhNDIxMmY3ZCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnR4dA0KQEAgLTE2LDYgKzE2
LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAJIm1lZGlhdGVrLG10ay14aGNpIiBjb21wYXRp
YmxlIHN0cmluZywgeW91IG5lZWQgU29DIHNwZWNpZmljIG9uZXMgaW4NCiAJYWRkaXRpb24sIG9u
ZSBvZjoNCiAJLSAibWVkaWF0ZWssbXQ4MTczLXhoY2kiDQorCS0gIm1lZGlhdGVrLG10ODE5NS14
aGNpIg0KICAtIHJlZyA6IHNwZWNpZmllcyBwaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNpemUg
b2YgdGhlIHJlZ2lzdGVycw0KICAtIHJlZy1uYW1lczogc2hvdWxkIGJlICJtYWMiIGZvciB4SENJ
IE1BQyBhbmQgImlwcGMiIGZvciBJUCBwb3J0IGNvbnRyb2wNCiAgLSBpbnRlcnJ1cHRzIDogaW50
ZXJydXB0IHVzZWQgYnkgdGhlIGNvbnRyb2xsZXINCi0tIA0KMi4xOC4wDQo=

