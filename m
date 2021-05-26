Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1E390E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhEZBxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:53:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:38803 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229978AbhEZBxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:53:00 -0400
X-UUID: 43d5b5118ddf4f4b8e288d0ccdbb5852-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=80CTOwchKT3ybAOjvFyMtlA2Ol/KbxvnM85zEMOaPiA=;
        b=XqYalZCrojkzfGvIDHyFOTu41pLEvBIjfGPAhAfcLDhrbPXCmNyMokMhUl3deX6h0DbhR+SPv0gJItYwzjuSqx4p5etqaNH5rbZCp3C7sG3CH4WInXPR0iaKKYo0UnMhIUlS0UHioeLpJcRslbFCuTSySxGg+txY7d5GwsLAMH8=;
X-UUID: 43d5b5118ddf4f4b8e288d0ccdbb5852-20210526
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 282154775; Wed, 26 May 2021 09:51:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS33N2.mediatek.inc (172.27.4.76) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 May 2021 09:51:20 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 09:51:20 +0800
Message-ID: <c90629c915bc1c0d2e6b1070939a443ce5f8644c.camel@mediatek.com>
Subject: Re: [v4,PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Date:   Wed, 26 May 2021 09:51:19 +0800
In-Reply-To: <CAAOTY__aasihVxC72f7b_R-=UcR85Z1G9M8TxUS9dBrad-aRxQ@mail.gmail.com>
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com>
         <20210525121448.30075-2-rex-bc.chen@mediatek.com>
         <CAAOTY__aasihVxC72f7b_R-=UcR85Z1G9M8TxUS9dBrad-aRxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 42D93AED34D03117334ABA24E227DA569F06D743CF4AF9909680C31FFE21AE7A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQ0ssDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCk9uIFdlZCwgMjAyMS0wNS0y
NiBhdCAwODowMSArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gSGksIFJleDoNCj4gDQo+
IFJleC1CQyBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+IOaWvCAyMDIx5bm0NeaciDI1
5pelIOmAseS6jCDkuIvljYg4OjE15a+r6YGT77yaDQo+ID4gDQo+ID4gRFBJIGNhbiBzYW1wbGUg
b24gZmFsbGluZywgcmlzaW5nIG9yIGJvdGggZWRnZS4NCj4gPiBXaGVuIERQSSBzYW1wbGUgdGhl
IGRhdGEgYm90aCByaXNpbmcgYW5kIGZhbGxpbmcgZWRnZS4NCj4gPiBJdCBjYW4gcmVkdWNlIGhh
bGYgZGF0YSBpbyBwaW5zLg0KPiA+IFVzZSBudW1fb3V0cHV0X2ZtdHMgdG8gZGV0ZXJtaW5lIHdo
ZXRoZXIgaXQgaXMgZHVhbCBlZGdlIG1vZGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSml0
YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJleC1C
QyBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCAxNyArKysrKysrKysrKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ID4gaW5kZXggYmVhOTFjODE2MjZl
Li5kM2I4ODNjOTdhYWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcGkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMN
Cj4gPiBAQCAtODMsNiArODMsNyBAQCBzdHJ1Y3QgbXRrX2RwaSB7DQo+ID4gICAgICAgICBzdHJ1
Y3QgcGluY3RybCAqcGluY3RybDsNCj4gPiAgICAgICAgIHN0cnVjdCBwaW5jdHJsX3N0YXRlICpw
aW5zX2dwaW87DQo+ID4gICAgICAgICBzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19kcGk7DQo+
ID4gKyAgICAgICBib29sIGRkcl9lZGdlX3NlbDsNCj4gDQo+IEkgd291bGQgbGlrZSB0byBrZWVw
IG91dHB1dF9mbXQgaW5zdGVhZCBvZiBkZHJfZWRnZV9zZWwuDQo+IEluaXRpYWxpemUgb3V0cHV0
X2ZtdCB0byBNRURJQV9CVVNfRk1UX1JHQjg4OF8xWDI0IGluIHRoaXMgcGF0Y2guDQo+IA0KSXQg
bWVhbnMgdGhhdCBJIG1heSBpbml0aWFsaXplIG91dHB1dF9mbXQgaW4gcHJvYmUgYW5kIHNldCB2
YWx1ZSBpbg0KbXRrX2RwaV9icmlkZ2VfYXRvbWljX2NoZWNrKCkgb2YgcGF0Y2hbMy8zXT8NCj4g
PiAgICAgICAgIGludCByZWZjb3VudDsNCj4gPiAgfTsNCj4gPiANCj4gPiBAQCAtMTIyLDYgKzEy
Myw4IEBAIHN0cnVjdCBtdGtfZHBpX2NvbmYgew0KPiA+ICAgICAgICAgdTMyIHJlZ19oX2ZyZV9j
b247DQo+ID4gICAgICAgICB1MzIgbWF4X2Nsb2NrX2toejsNCj4gPiAgICAgICAgIGJvb2wgZWRn
ZV9zZWxfZW47DQo+ID4gKyAgICAgICBjb25zdCB1MzIgKm91dHB1dF9mbXRzOw0KPiA+ICsgICAg
ICAgdTMyIG51bV9vdXRwdXRfZm10czsNCj4gDQo+IE1vdmUgdGhlc2UgdG8gbmV4dCBwYXRjaC4N
Cj4gDQpJIHdpbGwgZG8gdGhpcyBpbiBuZXh0IHZlcnNpb24uDQo+ID4gIH07DQo+ID4gDQo+ID4g
IHN0YXRpYyB2b2lkIG10a19kcGlfbWFzayhzdHJ1Y3QgbXRrX2RwaSAqZHBpLCB1MzIgb2Zmc2V0
LCB1MzIgdmFsLA0KPiA+IHUzMiBtYXNrKQ0KPiA+IEBAIC0zODEsNiArMzg0LDE2IEBAIHN0YXRp
YyB2b2lkIG10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChzdHJ1Y3QNCj4gPiBtdGtfZHBpICpk
cGksDQo+ID4gICAgICAgICB9DQo+ID4gIH0NCj4gPiANCj4gPiArc3RhdGljIHZvaWQgbXRrX2Rw
aV9kdWFsX2VkZ2Uoc3RydWN0IG10a19kcGkgKmRwaSkNCj4gPiArew0KPiA+ICsgICAgICAgaWYg
KGRwaS0+Y29uZi0+bnVtX291dHB1dF9mbXRzID4gMSkgew0KPiA+ICsgICAgICAgICAgICAgICBt
dGtfZHBpX21hc2soZHBpLCBEUElfRERSX1NFVFRJTkcsIEREUl9FTiB8DQo+ID4gRERSXzRQSEFT
RSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEREUl9FTiB8IEREUl80UEhBU0Up
Ow0KPiA+ICsgICAgICAgICAgICAgICBtdGtfZHBpX21hc2soZHBpLCBEUElfT1VUUFVUX1NFVFRJ
TkcsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcGktPmRkcl9lZGdlX3NlbCA/
IEVER0VfU0VMIDogMCwNCj4gPiBFREdFX1NFTCk7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBpZiAo
ZHBpLT5vdXRwdXRfZm10ID09IE1FRElBX0JVU19GTVRfUkdCODg4XzJYMTJfTEUpIHx8DQo+ICAg
IChkcGktPm91dHB1dF9mbXQgPT0gTUVESUFfQlVTX0ZNVF9SR0I4ODhfMlgxMl9CRSkgew0KPiAg
ICAgbXRrX2RwaV9tYXNrKGRwaSwgRFBJX0REUl9TRVRUSU5HLCBERFJfRU4gfCBERFJfNFBIQVNF
LCBERFJfRU4gfA0KPiBERFJfNFBIQVNFKTsNCj4gICAgIG10a19kcGlfbWFzayhkcGksIERQSV9P
VVRQVVRfU0VUVElORywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcGktPm91dHB1
dF9mbXQgPT0NCj4gTUVESUFfQlVTX0ZNVF9SR0I4ODhfMlgxMl9MRSA/IEVER0VfU0VMIDogMCwg
RURHRV9TRUwpOw0KPiB9IGVsc2Ugew0KPiAgICAgbXRrX2RwaV9tYXNrKGRwaSwgRFBJX0REUl9T
RVRUSU5HLCBERFJfRU4gfCBERFJfNFBIQVNFLCAwKTsNCj4gfQ0KPiANCkkgd2lsbCBtb2RpZnkg
dGhpcyBjb2RlIGluIG5leHQgdmVyc2lvbi4NCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZv
aWQgbXRrX2RwaV9wb3dlcl9vZmYoc3RydWN0IG10a19kcGkgKmRwaSkNCj4gPiAgew0KPiA+ICAg
ICAgICAgaWYgKFdBUk5fT04oZHBpLT5yZWZjb3VudCA9PSAwKSkNCj4gPiBAQCAtNDU1LDcgKzQ2
OCw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVjdA0KPiA+IG10
a19kcGkgKmRwaSwNCj4gPiAgICAgICAgIHBsbF9yYXRlID0gY2xrX2dldF9yYXRlKGRwaS0+dHZk
X2Nsayk7DQo+ID4gDQo+ID4gICAgICAgICB2bS5waXhlbGNsb2NrID0gcGxsX3JhdGUgLyBmYWN0
b3I7DQo+ID4gLSAgICAgICBjbGtfc2V0X3JhdGUoZHBpLT5waXhlbF9jbGssIHZtLnBpeGVsY2xv
Y2spOw0KPiA+ICsgICAgICAgY2xrX3NldF9yYXRlKGRwaS0+cGl4ZWxfY2xrLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgIHZtLnBpeGVsY2xvY2sgKiAoKGRwaS0+Y29uZi0+bnVtX291dHB1dF9m
bXRzID4NCj4gPiAxKSA/IDIgOiAxKSk7DQo+IA0KPiBpZiAoZHBpLT5vdXRwdXRfZm10ID09IE1F
RElBX0JVU19GTVRfUkdCODg4XzJYMTJfTEUpIHx8DQo+ICAgIChkcGktPm91dHB1dF9mbXQgPT0g
TUVESUFfQlVTX0ZNVF9SR0I4ODhfMlgxMl9CRSkNCj4gICAgIGNsa19zZXRfcmF0ZShkcGktPnBp
eGVsX2Nsaywgdm0ucGl4ZWxjbG9jayAqIDIpOw0KPiBlbHNlDQo+ICAgICBjbGtfc2V0X3JhdGUo
ZHBpLT5waXhlbF9jbGssIHZtLnBpeGVsY2xvY2spOw0KPiANCkkgd2lsbCBtb2RpZnkgdGhpcyBj
b2RlIGluIG5leHQgdmVyc2lvbi4NCj4gPiAgICAgICAgIHZtLnBpeGVsY2xvY2sgPSBjbGtfZ2V0
X3JhdGUoZHBpLT5waXhlbF9jbGspOw0KPiA+IA0KPiA+ICAgICAgICAgZGV2X2RiZyhkcGktPmRl
diwgIkdvdCAgUExMICVsdSBIeiwgcGl4ZWwgY2xvY2sgJWx1IEh6XG4iLA0KPiA+IEBAIC01MTks
NiArNTMzLDcgQEAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNwbGF5X21vZGUoc3RydWN0DQo+
ID4gbXRrX2RwaSAqZHBpLA0KPiA+ICAgICAgICAgbXRrX2RwaV9jb25maWdfeWNfbWFwKGRwaSwg
ZHBpLT55Y19tYXApOw0KPiA+ICAgICAgICAgbXRrX2RwaV9jb25maWdfY29sb3JfZm9ybWF0KGRw
aSwgZHBpLT5jb2xvcl9mb3JtYXQpOw0KPiA+ICAgICAgICAgbXRrX2RwaV9jb25maWdfMm5faF9m
cmUoZHBpKTsNCj4gPiArICAgICAgIG10a19kcGlfZHVhbF9lZGdlKGRwaSk7DQo+ID4gICAgICAg
ICBtdGtfZHBpX2NvbmZpZ19kaXNhYmxlX2VkZ2UoZHBpKTsNCj4gPiAgICAgICAgIG10a19kcGlf
c3dfcmVzZXQoZHBpLCBmYWxzZSk7DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjE4LjANCg0KQlJzLA0K
UmV4LUJDIENoZW4NCj4gPiANCg==

