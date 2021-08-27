Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2433F92E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbhH0DYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:24:09 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41158 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244171AbhH0DYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:24:08 -0400
X-UUID: 3a7489e1de1a4579bbbb23095d356844-20210827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TjMYclzLBVDiV5yAWoJeSAWDgVpqRzqWA0X1kGK/fGs=;
        b=aq91Sqm1d8b+NHWOjWeIzIHy11x9eFEo0vTu+qdTnb7v6wbB3OTxVKVNUM0ZyhnfGWNVVzxeqkvSSGG40OOK83KBmMWf8faTs1DR/PbNVXV9bJ9Y0VzXZE3txUS7SJuO/B10XaVHh/WaflF+T9v8de7DUfyvZR7IfqmQeNNwSw4=;
X-UUID: 3a7489e1de1a4579bbbb23095d356844-20210827
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 26285264; Fri, 27 Aug 2021 11:23:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 11:23:15 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 27 Aug 2021 11:23:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sco2SEedYlFzsj0mciARcGBQpqBx3y56lHhOGb8F4igP9Bel7mzQ6yyW4n6kBpZEwas+BatlOSHKiSQodwKffIrHs1A3sRz2d9TZ44w0aw2AOUKzrGyh4nlMTvbW1hicBvvJl65qgGzp6vPZxqqMtIQY3UuKnUijSUJiaoz38/npRIQG1sQZcBn8fmBiZqiT3+DcO0y6paO2voAikvsPbPJHD809jQcdo5aFTqv1dA3Xn4HstyKzheH407YTcxQYMhJEeF3Wvzk8aJmLBHjstPSFDuzxn0eptQEKDf4vpy3C+/l4UyvgMmtrDuoB9np9YOpaXMhvbgSWx/7tpsC2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TjMYclzLBVDiV5yAWoJeSAWDgVpqRzqWA0X1kGK/fGs=;
 b=fatQAB3K7WafASvzr3XEPW+ssxtQU//LO/3qfhDlw4tvTs13CsGPZNITYnJ5o5OnbBpOHUkMjzq7A7f/My3JJFGZ6izfxMEl+E+BiTCygvmLxytm+uTGe6wpd7TVMpHLT84zJEPlRm5LBQ3ZliBWCAJ7Xy+QNehqtHPOkdDyg6AM1YU/Y9Da7JB3CGXGrio2SSzADuOnnAa8H/SJ5ZtF+YQ/3gon0UZYF1O9MaE6e75sfLHlMZVYwF6jnBaBcrpArNTL97cxsxShIavywj6zyPRbGBE6wasnfdGbCCU3rChWX9eeNA+qeJB+vazY451yerQc9IoSSM6pjmr/ivWb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjMYclzLBVDiV5yAWoJeSAWDgVpqRzqWA0X1kGK/fGs=;
 b=QRpA8VNSAGGvBcDl1PYMO8wUJ+y5TwtPve2EP1ZRxcPh8h7f25JnyZDG+CkHDwLzobIAZYDI6oD/4CQhWK2I57sm8/eHFKlUS4dU0F6C9s8as4si4D8YCqY3zNBNTx54EYXLdDtA1wOzf0gIWLf2QE0l/zBM/yZxqm3K4lj5ldU=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB5298.apcprd03.prod.outlook.com (2603:1096:820:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.9; Fri, 27 Aug
 2021 03:23:04 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c%7]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 03:23:03 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?WWFxaWkgV3UgKOatpuS6muWlhyk=?= <Yaqii.Wu@mediatek.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ikjn@chromium.org" <ikjn@chromium.org>
Subject: Re: [PATCH next v2 1/6] Revert "usb: xhci-mtk: relax TT periodic
 bandwidth allocation"
Thread-Topic: [PATCH next v2 1/6] Revert "usb: xhci-mtk: relax TT periodic
 bandwidth allocation"
Thread-Index: AQHXmiVazC+quBfOAkq2QLX4yDaH/quFqkeAgAEHGwA=
Date:   Fri, 27 Aug 2021 03:23:03 +0000
Message-ID: <a806a06ae1eea932240ff98291cca2a9c7739b16.camel@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
         <YSd93+3D/PbacgsP@kroah.com>
In-Reply-To: <YSd93+3D/PbacgsP@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8760201e-a817-4d5f-7375-08d96909fb14
x-ms-traffictypediagnostic: KL1PR0302MB5298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR0302MB5298E0A8AD656B3B079F32BEFDC89@KL1PR0302MB5298.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nna+xVejXCirll7CYXbz9dM84YRLggm8sjJOoTytPdDGb3Z5U5g4WNDHk8GkFYs++4ztmPDihxHBcXwDVFN9HYgP64RmsGd7iGgaxL1oKUZqgHpc5f2tCTqzVCEQc39yZd2KjwEAYqYe0BEGNt9aIMaXU1k21WcWMr8QHBOqy8q2d54IEPNSQZqZHODrDbGDqHeTxGrbqFt9YZShSWGTs0zeGFiVfW+3ZUHbIEhKZjoXjmeM4vdoObLcORU+Y6z6uECfd06ExikC1QWXxVqfNTG8OMiqUnllfNKpPWp6f6ZY3jm1/gA/3UoC40KD3KiihHvRnvKm9IwIformqUNHyKvGkOYCp8K7rdLG8NgfoPLZEVv3HrybpbEvRrQHg46bkMcdkKo7G40P0GSN+9YF8Wy2f0eCQh6CykMjlihG+/Yg8wa1LJ5jCRClmerNxE6DmQOCVJzbfZEXJfxqRzkNr/izpNilG4rydwiIkb2X0aB6pWIz4lnRvKOW5YTF+XjxPlw7NCqHSvoOfwh4tZ++BBIbGku7HR0Z5o9wRpyAFFkJ41RMnxINsoa+m7NGDNVhsLOHKpAZNmL1E1Htd5J8b6oS65TTaEb4EWunq8tjPe+BTMjd9Q8QTqCyKPuVDMqNQS1fttgUFqAMtFYuHSd+Ku/YuS9GyHye9IeQNqj73RdmLdqXBqXPvGE6snrNAXNDY563hI6dv9a6SXXkoryyre4Lxxh59R9v+yHM5xH43gO6NEFT+/qnr+bKN3MFEBtu23kpssNy57p+/QFRtXj6wSMYumL3QWWQhwYJME5HwkQL4htiXSjqRpjHUNtYFawyGyuQ8dXPiNUZHR+05vDiRvrLSc3spmbKm3TLjB9oSTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(83380400001)(6506007)(5660300002)(6512007)(8936002)(36756003)(4326008)(38100700002)(122000001)(71200400001)(26005)(38070700005)(478600001)(316002)(86362001)(966005)(186003)(8676002)(2906002)(6486002)(85182001)(54906003)(2616005)(66556008)(66446008)(66476007)(64756008)(66946007)(6916009)(91956017)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGVLSVFKZ0YwKy9uMThaOW4yZ2E4M0pXa3laZlBudno3MEZuRGw4V04yTldE?=
 =?utf-8?B?b1hhWW4xRGo2LzhWSUludkJ3cFhYR3BZSzVrT0pqMWxvRko0Nm1TRlFvMm8z?=
 =?utf-8?B?YW9lRURpaWdKOEMvNFdYS3FXdlRKS09vc3c1ZW9FeE1naFNKckx5OTRsdDJk?=
 =?utf-8?B?SXovaXMvQUJUZk0zblMwSTdKcFhPSFZCdkZIT2EvSkJEMWJ0LzBTSnU2cjlQ?=
 =?utf-8?B?Y0JrN1lqRmhoUEZaYVJycEVYVi9wc2pkd0pBUzZHTWxDaXdzNUQ4Q05weWJm?=
 =?utf-8?B?aDlEbWxuTWs4Sm5GRlBLdDNjQ2J4MkN2Wk9sSWhMRFQwN1cyWWt1MFpIeURa?=
 =?utf-8?B?elJsMEFubTd5NGZWZHZteFdNTDdoSXYvcld4anB6VDZuY29HMEcwVnV0U0ZG?=
 =?utf-8?B?bUxmbmkrTnpKUmJpSWdwRko5SWhhTVF0OWF0L29GZVA0bzNHNjNRcUVWNDdY?=
 =?utf-8?B?QXFJVG5Sd1pMRUtSRzMvOTdzTVQ5N1FoQkRQUW5oc0NQcWM5WmErOE5NbjY2?=
 =?utf-8?B?Z2ZqVUdFMlRGeVJzaVJ4djh3Qnh2ZXN4c1M2a2ZnOGFMVHJocllQaUpmTk9H?=
 =?utf-8?B?MHN0TzhKYXhwbzQ1VytNYml2QXBReUV5cjVVbTc5MXRmZ3BNNW1XdHJzVHBI?=
 =?utf-8?B?MjFEZktoVE1rNmIvY1ZxMjB3bUQvN1NucUhrb0RpWG5JLzlvSmRJblZqejFJ?=
 =?utf-8?B?V2pFMkxGcFVKL3NzR2YrMlVFclFNTlorbW1TeWNQTWsySFpGNUVmTDV6Q0N6?=
 =?utf-8?B?dlVqL0c0cHhXNWZSTkVJeVBhZU5WU24yKzYwMitBK05qekJEM0dHWGZobjd0?=
 =?utf-8?B?dnB3elJSMWRiRENVWXd1TFZ2cldHNTIrdFpYVGRObGlSMmVaMFJWM3Y5YlZK?=
 =?utf-8?B?MEVIZmkwaHZIT2dsdWVTS0wxN1R1RUowWmZWUlphVWI4TGhPTGZWbnEyVmNl?=
 =?utf-8?B?cWZ5cmdTc1hnY2JObE1CUGUzT0JLUC96RnNqODlpVG4vd3A4WjM2YWhqSEc5?=
 =?utf-8?B?dUFJQk45QWZieVh0MzluRzl0MkV1bTFsQW1qSkI3SFdSN3hXMXVQeVFvcHVE?=
 =?utf-8?B?S3R0TWNIRVVIRkplUG5JaDlNRG1YK3ZmUW5Wakl4a2Q5d21Mb2g5TTBUck1B?=
 =?utf-8?B?aVNKeVRCMEUyc1dHbGpDa0pjNENFZTJSeGZMU1pRVklGb2xJWUJ2S1dCZ0FB?=
 =?utf-8?B?WTI0dzM3OUZyU1Aralh4Y3JTVnI2Y1dPR2UrcmRzZ25OMVZ6V1lxdG1NT2lQ?=
 =?utf-8?B?dWI4WUtYMy9mU1hxL0tGTlJ6dTE5NGFCcnNvb0hTWUFOeVNtbVphTTlheUpB?=
 =?utf-8?B?QUpMcFgwVHYxOUJmdGxUblRFeUVrczFuUU93N3M5ZmVVdU9jQndZaVdxWEY4?=
 =?utf-8?B?alNKY1BkdFBVVzRuOU01RS9XK2lvRHFvOWFnT3IxVERBNnA5NkZMbk4yREJX?=
 =?utf-8?B?R01QWnRUa1ZQVlJCQ2NHaFIwS3pCWjlkeWZEdzl1MkhxZFY3QW5jbVBpL2h2?=
 =?utf-8?B?eVQwanJ4ckdLL3JzcTB1MU53TWJxaGZ0TWk2bXF6a2s5VFZ3UnY1N2RKbkt1?=
 =?utf-8?B?RjREQTFnaEkzeUc0aU5xOFBoNGJTNXNQWU40WTRLcjE3VWdGQ1BWNStwM3FT?=
 =?utf-8?B?blFJWWwwSW9aSWc3eDF2Wmo1OGFSWWZ3L282UE15bXAzektNT0E0TkpyUFNN?=
 =?utf-8?B?OGlkSHpiOFhMODdNQWsyV2dGSFNxaGgzaHlPaHhrR1JWbWVtNm1paWRSTjdm?=
 =?utf-8?Q?E3V0SM8M8mSuTNNlsVXGihRxVFNev9Px4DzIlPk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B00E55F60AC5F4FA02517A6E89DA39A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8760201e-a817-4d5f-7375-08d96909fb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 03:23:03.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oSkB7aqyzhqJebNuzwCFA9pmYiP/OPqkjE9FYGAgVhYgsss+BBHk/mIOLzkEpS4GwhVo0b1D85/G7T8Wy4W+wJbf/BJ42QGHKgXZrFXIHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5298
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCk9uIFRodSwgMjAyMS0wOC0yNiBhdCAxMzo0MSArMDIwMCwgR3JlZyBLcm9haC1I
YXJ0bWFuIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAyNiwgMjAyMSBhdCAxMDo1MTozOUFNICswODAw
LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gQXMgZGlzY3Vzc2VkIGluIGZvbGxvd2luZyBwYXRj
aDoNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEyNDIwMzM5DQo+ID4g
DQo+ID4gTm8gbmVlZCBjYWxjdWxhdGUgbnVtYmVyIG9mIHVmcmFtZXMgYWdhaW4sIGJ1dCBzaG91
bGQgdXNlIHZhbHVlDQo+ID4gZm9ybSBjaGVja19zY2hfdHQoKSwgaWYgd2UgcGxhbiB0byByZW1v
dmUgZXh0cmEgQ1MsIGFsc28gY2FuIGRvDQo+ID4gaXQgaW4gY2hlY2tfc2NoX3R0KCkuIFNvIHJl
dmVydCB0aGlzIHBhdGNoLCBhbmQgcHJlcGFyZSB0byBzZW5kDQo+ID4gbmV3IHBhdGNoIGZvciBp
dC4NCj4gPiANCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDU0ODAxMTk1N2QxZDcyZTBiNjYyMzAw
YzhiMzJiODFkNTkzYjc5NmUuDQo+ID4gDQo+ID4gQ2M6IElram9vbiBKYW5nIDxpa2puQGNocm9t
aXVtLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6IG5vIGNoYW5nZXMNCj4gDQo+IFRoaXMgc2Vy
aWVzIGRvZXMgbm90IGFwcGx5IHRvIG15IHRyZWUgYXQgYWxsIG5vdywgY2FuIHlvdSBwbGVhc2UN
Cj4gcmViYXNlDQo+IGFuZCByZXNlbmQ/DQpWZXJ5IHNvcnJ5LCBJIHNlbmQgb3V0IHR3byBzZXJp
ZXMgWzFdWzJdIGZvciB4aGNpLW10aywgYnV0IGRvbid0IHRha2UNCmNhcmUgb2YgY29uZmxpY3Rz
LCBzdXBwb3NlIHRoYXQgc2VyaWVzIFsxXSB3aWxsIGJlIGFwcGxpZWQgZmlyc3RseSwgZHVlDQp0
byBvbmUgYmluZGluZyBwYXRjaCBbM10gb2Ygc2VyaWVzIFsyXSBpcyBub3QgYWNrZWQvcmV2aWV3
ZWQgYnkgUm9iIChJDQp0aGluayBvbmx5IG5lZWQgbW9kaWZ5IHNvbWUgbWlzbGVhZGluZyBjb21t
aXQgbWVzc2FnZSkuDQoNCmFueXdheSwgSSBmaW5kIHRoYXQgb25seSBvbmUgcGF0Y2ggWzRdIG9m
IHNlcmllcyBbMV0gaXMgbm90IGFwcGxpZWQsIHNvDQpJJ2xsIGZpeCBjb25maWN0cyBhbmQgcmVz
ZW5kIGl0IGJhc2VkIG9uIHVzYi10ZXN0aW5nIGJyYW5jaC4NCg0KU29ycnkgYWdhaW4uDQoNCg0K
WzFdOiBTZXJpZXMgPSBbbmV4dCx2MiwxLzZdIFJldmVydCAidXNiOiB4aGNpLW10azogcmVsYXgg
VFQgcGVyaW9kaWMNCmJhbmR3aWR0aCBhbGxvY2F0aW9uIg0KaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz01Mzc0NzENCg0KWzJd
OiBTZXJpZXMgPSBbUkVTRU5ELDEvOV0gZHQtYmluZGluZ3M6IHVzYjogbXRrLXhoY2k6IGFkZCBv
cHRpb25hbA0KcHJvcGVydHkgdG8gZGlzYWJsZSB1c2IyIHBvcnRzDQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTUzMjU5NQ0K
DQpbM106DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRp
YXRlay9wYXRjaC8xNjI5MTg5Mzg5LTE4Nzc5LTItZ2l0LXNlbmQtZW1haWwtY2h1bmZlbmcueXVu
QG1lZGlhdGVrLmNvbS8NCltSRVNFTkQsMi85XSBkdC1iaW5kaW5nczogdXNiOiBtdGsteGhjaTog
YWRkIGNvbXBhdGlibGUgZm9yIG10ODE5NQ0KDQpbNF06DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIxMDgyNjAyNTE0NC41MTk5
Mi02LWNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20vDQpbbmV4dCx2Miw2LzZdIHVzYjogeGhjaS1t
dGs6IGFsbG93IGJhbmR3aWR0aCB0YWJsZSByb2xsb3Zlcg0KDQo+IA0KPiB0aGFua3MsDQo+IA0K
PiBncmVnIGstaA0K
