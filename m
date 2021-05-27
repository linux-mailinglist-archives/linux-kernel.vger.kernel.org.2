Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA23924B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhE0CK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:10:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59533 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233315AbhE0CKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:10:25 -0400
X-UUID: 0f10ba085faa4a94b2f2a481eb313bd5-20210527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=y1NwRKA/u3VyZk5yDpibM8d4jcADHSOdUWDHaiYEFYk=;
        b=irhwIYjPuRg56l69G4TTPm0KQngtkI4HKyewE63x9Rdo1FRr5ix/Zdt7KD2mDIFn1ys75PqWNpQUEWEFs1xng5nWcC4CBN1VmgKjDCYxW6woOki4hInldDpPBsjDAF0T/koUw9fP9Zfojq/P4OWfFxXxtVc9wen5zWptLGqaiKk=;
X-UUID: 0f10ba085faa4a94b2f2a481eb313bd5-20210527
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 277139762; Thu, 27 May 2021 10:08:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 May 2021 10:08:49 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 May 2021 10:08:49 +0800
Message-ID: <1622081330.22138.0.camel@mtksdaap41>
Subject: Re: [PATCH v8 4/4] arm64: dts: mt8192: add spmi node
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     kernel test robot <lkp@intel.com>
CC:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 27 May 2021 10:08:50 +0800
In-Reply-To: <202105270021.c336cIqx-lkp@intel.com>
References: <1622025344-31888-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <202105270021.c336cIqx-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNpcnMNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NClRoaXMgc2VyaWVzIGlzIGJhc2VkIG9u
IENodW4tSmllJ3MgcGF0Y2hlc1sxXS4NCg0KWzFdDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTQ4ODIzOQ0KDQpPbiBUaHUs
IDIwMjEtMDUtMjcgYXQgMDA6NDYgKzA4MDAsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPiBI
aSBIc2luLUhzaXVuZywNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoISBZZXQgc29tZXRo
aW5nIHRvIGltcHJvdmU6DQo+IA0KPiBbYXV0byBidWlsZCB0ZXN0IEVSUk9SIG9uIHJvYmgvZm9y
LW5leHRdDQo+IFthbHNvIGJ1aWxkIHRlc3QgRVJST1Igb24gbWVkaWF0ZWsvZm9yLW5leHQgbGlu
dXMvbWFzdGVyIHY1LjEzLXJjMyBuZXh0LTIwMjEwNTI2XQ0KPiBbSWYgeW91ciBwYXRjaCBpcyBh
cHBsaWVkIHRvIHRoZSB3cm9uZyBnaXQgdHJlZSwga2luZGx5IGRyb3AgdXMgYSBub3RlLg0KPiBB
bmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBhcyBk
b2N1bWVudGVkIGluDQo+IGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNo
XQ0KPiANCj4gdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21taXRz
L0hzaW4tSHNpdW5nLVdhbmcvQWRkLVNQTUktc3VwcG9ydC1mb3ItTWVkaWF0ZWstTVQ2ODczLTgx
OTItU29DLUlDLzIwMjEwNTI2LTE4MzgwMw0KPiBiYXNlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JvYmgvbGludXguZ2l0IGZvci1uZXh0DQo+IGNv
bmZpZzogYXJtNjQtcmFuZGNvbmZpZy1yMDE2LTIwMjEwNTI2IChhdHRhY2hlZCBhcyAuY29uZmln
KQ0KPiBjb21waWxlcjogY2xhbmcgdmVyc2lvbiAxMy4wLjAgKGh0dHBzOi8vZ2l0aHViLmNvbS9s
bHZtL2xsdm0tcHJvamVjdCA5OTE1NWU5MTNlOWJhZDVmN2Y4YTI0N2Y4YmIzYTNmZjNkYTc0YWYx
KQ0KPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOg0KPiAgICAgICAgIHdnZXQgaHR0
cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2ludGVsL2xrcC10ZXN0cy9tYXN0ZXIvc2Jp
bi9tYWtlLmNyb3NzIC1PIH4vYmluL21ha2UuY3Jvc3MNCj4gICAgICAgICBjaG1vZCAreCB+L2Jp
bi9tYWtlLmNyb3NzDQo+ICAgICAgICAgIyBpbnN0YWxsIGFybTY0IGNyb3NzIGNvbXBpbGluZyB0
b29sIGZvciBjbGFuZyBidWlsZA0KPiAgICAgICAgICMgYXB0LWdldCBpbnN0YWxsIGJpbnV0aWxz
LWFhcmNoNjQtbGludXgtZ251DQo+ICAgICAgICAgIyBodHRwczovL2dpdGh1Yi5jb20vMGRheS1j
aS9saW51eC9jb21taXQvNDIzYjRhMTY2MGY1MTU3ZGJhYzU2NmY5YzQ5OGM2MTkyN2YwOTAyMg0K
PiAgICAgICAgIGdpdCByZW1vdGUgYWRkIGxpbnV4LXJldmlldyBodHRwczovL2dpdGh1Yi5jb20v
MGRheS1jaS9saW51eA0KPiAgICAgICAgIGdpdCBmZXRjaCAtLW5vLXRhZ3MgbGludXgtcmV2aWV3
IEhzaW4tSHNpdW5nLVdhbmcvQWRkLVNQTUktc3VwcG9ydC1mb3ItTWVkaWF0ZWstTVQ2ODczLTgx
OTItU29DLUlDLzIwMjEwNTI2LTE4MzgwMw0KPiAgICAgICAgIGdpdCBjaGVja291dCA0MjNiNGEx
NjYwZjUxNTdkYmFjNTY2ZjljNDk4YzYxOTI3ZjA5MDIyDQo+ICAgICAgICAgIyBzYXZlIHRoZSBh
dHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4IGJ1aWxkIHRyZWUNCj4gICAgICAgICBDT01QSUxFUl9J
TlNUQUxMX1BBVEg9JEhPTUUvMGRheSBDT01QSUxFUj1jbGFuZyBtYWtlLmNyb3NzIEFSQ0g9YXJt
NjQgDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFn
IGFzIGFwcHJvcHJpYXRlDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCj4gDQo+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4g
DQo+ID4+IEVycm9yOiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpOjI5
OS4yNC0yNSBzeW50YXggZXJyb3INCj4gICAgRkFUQUwgRVJST1I6IFVuYWJsZSB0byBwYXJzZSBp
bnB1dCB0cmVlDQo+IA0KPiAtLS0NCj4gMC1EQVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZSwgSW50
ZWwgQ29ycG9yYXRpb24NCj4gaHR0cHM6Ly9saXN0cy4wMS5vcmcvaHlwZXJraXR0eS9saXN0L2ti
dWlsZC1hbGxAbGlzdHMuMDEub3JnDQoNCg==

