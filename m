Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9330A468
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBAJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:32:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55919 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232681AbhBAJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:32:30 -0500
X-UUID: a51b790571e247b398cbd7511727f889-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ZnxN1pLV+rvX9LVEaJLLgeSX4bC8JWZBZLANyFfuHzk=;
        b=SKsiD2//CU/rGytsU5i0AcICFbv1DBp1mzm42/qoE8Ll4QJVXn/3NkzJKq9vYNDKITfV9HZIMhyhNvsId0m4hyqtM6myxDsjvUD0IrkJxd1T+03QQB1IcCRlaA29ufa5RCp5kt6beFrD378IcAMA/qiL9l+YghA08uQeqEeIpoc=;
X-UUID: a51b790571e247b398cbd7511727f889-20210201
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1460415211; Mon, 01 Feb 2021 17:31:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 17:31:43 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 17:31:43 +0800
Message-ID: <1612171903.18201.6.camel@mtksdaap41>
Subject: Re: [PATCH 0/2] Add MediaTek MT8192 clock provider device nodes
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 1 Feb 2021 17:31:43 +0800
In-Reply-To: <4536e0a3-8e64-d2b0-df83-33705d10359a@gmail.com>
References: <1608644414-17793-1-git-send-email-weiyi.lu@mediatek.com>
         <4536e0a3-8e64-d2b0-df83-33705d10359a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTMxIGF0IDE0OjI3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjIvMTIvMjAyMCAxNDo0MCwgV2VpeWkgTHUgd3JvdGU6DQo+ID4gVGhpcyBz
ZXJpZXMgaXMgYmFzZWQgb24gdjUuMTAtcmMxLCBNVDgxOTIgZHRzIHY2WzFdIGFuZA0KPiA+IE1U
ODE5MiBjbG9jayB2NiBzZXJpZXNbMl0uDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9MzczODk5DQo+
ID4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRl
ay9saXN0Lz9zZXJpZXM9NDA1Mjk1DQo+ID4gDQo+IA0KPiBbMV0gaXMgYWxyZWFkeSBtYWlubGlu
ZS4gWW91IGNvdWxkIGFkZCB0aGlzIHBhdGNoIGFzIGEgbmV3IG9uZSB0byBbMl0uIEJ1dA0KPiBw
bGVhc2UgdHJ5IHRvIGltcHJvdmUgdGhlIHNlcmllcywgYmVmb3JlIHNlbmRpbmcganVzdCBhIG5l
dyB2ZXJzaW9uIHdpdGggdGhpcw0KPiBwYXRjaCBhZGRlZC4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1h
dHRoaWFzDQo+IA0KSGkgTWF0dGhpYXMsDQoNCkFjdHVhbGx5IEknbSBhIGxpdHRsZSBjb25mdXNl
ZCBub3cuIFN0ZXBoZW4gc3VnZ2VzdGVkIG1lIHRvIHNlbmQgY2xvY2sNCmR0cyBzZXBhcmF0ZWx5
IGJlY2F1c2UgZHRzIG1heSBub3QgZ28gdGhyb3VnaCBoaXMgdHJlZS4NClNvIEkgc2VwYXJhdGVk
IGl0IGZyb20gdGhlIE1UODE5MiBjbG9jayBzZXJpZXMgc2luY2UgY2xvY2sgdjYuDQpXaGF0IGRv
IHlvdSBzdWdnZXN0IG1lIHRvIGRvIG5leHQgdGltZT8NCg0KPiA+IFdlaXlpIEx1ICgyKToNCj4g
PiAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBBZGQgbXQ4MTkyIGNsb2NrIGNvbnRyb2xsZXJzDQo+
ID4gICBhcm02NDogZHRzOiBtZWRpYXRlazogQ29ycmVjdCBVQVJUMCBidXMgY2xvY2sgb2YgTVQ4
MTkyDQo+ID4gDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kg
fCAxNjUgKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2NCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQoNCg==

