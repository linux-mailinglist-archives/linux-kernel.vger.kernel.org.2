Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACA3901B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEYNJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:09:45 -0400
Received: from mail-eopbgr1400041.outbound.protection.outlook.com ([40.107.140.41]:47104
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232862AbhEYNJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:09:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/qdeHko67PdjZMaHj9fxNSdRWZwilDLK66oPVA1x7zr6IqaEwpYLfXU3Xy9JeQLV80ubeiYy/QHErOidLYk7eRdB/CY6E62MSnkDVHLBw6PjehSATKKRGlS6Y0XYnQSfO1HpmX2UbjTfc/FGb163yhhgETaKKfA8mhqJLgmDXcB8UNpEPwRI8OlgKZ3qhQtkPHyklz6c7H/LLPHSAMwH+VZ/QupZifX++64vAqBetB0RWtfUTUX1Xz1yeBAyTEA9o10nZK8eJ5gGjbpS6Pur3f4yWO8rlRHRaNxzj+vSLsuIw2W61gEJHlcC7G3eC3rddx715L4buTo6nwXyh8EfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czhF1RzQjELy57GtFB/K6hUV6E0AEmuruz27MW92W44=;
 b=JWcgXSWN+Xejm44snNbcp4HWqiF5inxIsEz+RgGQt0dH6tD4HDrcYWJ5BPyNcvZob3pe4lPG31mcPOjmzwd0/CAo9oLbeLrzjAeKVBzBfHOu6k7cmSJb7Gf+dGipKUI23EpuI9964PcrVrypp3lHlMxwhXqCgh6ycj/mxxc/ZE8YQ3SVLT4Lu1uA0N8z/uLcUXn78tTi+P2VbL59vpgDRckG7wSITWerDKk8UPfWZZvPKpejR7qOLxHWZ+8purWwHgcrRMqr4nX9gNwllvQI20Lzpzi1J2BQdPGKn8MRUEUBpm4pKeC2wme7NRUyjDQAyvstIN7JSvHlHIjBEXFR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czhF1RzQjELy57GtFB/K6hUV6E0AEmuruz27MW92W44=;
 b=HIeU+7MH9w86KOQnf5eUCPO0QvpcEr1kp7PwV87rPFdj2+1FDhvdzGL0f87gVQZVu+JocRtG0kkgg541VK5lkBpDnRF3ZpzRV1SuEsQI/icrnJzRWQgEf496Ue6wUPYejqHldwwTvoCvYq24syEDUYNwag/NqQCJbIiJslZoHSs=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5342.jpnprd01.prod.outlook.com (2603:1096:404:802e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 13:08:11 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 13:08:11 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page allocation
Thread-Topic: [PATCH v5 1/2] mm,hwpoison: fix race with hugetlb page
 allocation
Thread-Index: AQHXTDtjI+1UlcXho0eIycDZj0ORBKrrZS6AgACSr4CAB+DpgIAACKuAgAARYACAAEK9AA==
Date:   Tue, 25 May 2021 13:08:11 +0000
Message-ID: <20210525130810.GA3330567@hori.linux.bs1.fc.nec.co.jp>
References: <20210518231259.2553203-1-nao.horiguchi@gmail.com>
 <20210518231259.2553203-2-nao.horiguchi@gmail.com>
 <d78f430c-2390-2a5f-564a-e20e0ba6b26a@oracle.com>
 <20210520071717.GA2641190@hori.linux.bs1.fc.nec.co.jp>
 <20210525073559.GA844@linux>
 <20210525080707.GA3325050@hori.linux.bs1.fc.nec.co.jp>
 <20210525090918.GE3300@linux>
In-Reply-To: <20210525090918.GE3300@linux>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e5d7384-b638-417f-b501-08d91f7e25f2
x-ms-traffictypediagnostic: TYBPR01MB5342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB534212F0E716E1EC8CBFD522E7259@TYBPR01MB5342.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ef14RemBKWOrn4pvwaMA2joAxWmrEYtl8fpf98JXr06L3t0/KL//yCe7qJO1DIyXGjSmOUGtwynzOu5rtiBYlLjbRJY7iHFJqNqSK35zbV/1jypQr9i7oxxy6L+AItR654bp6NOS5oh0P8fQAMcZ4+5tslXeUFtYICnirFW+vDGxKVKHSX7MtlVdZ5Vx8Z8eAUvfRSpO87QOXC3Cz4TsCtCWNNyVgB0g66UVyv7aEGCB93ej4bZiKuqma5CtGoM94PGpEghvhzFCBnFHwP76TA3/xtmHYCPtkeZhpNRdnctQiZiBdCeVIhBENgJ9G3bsEbCDRln0NmqULVoNQoyhq+36Y7Rp1SuSgZztkD/x2UCs8fL/CoLSXITM6ADGdAxACgZ+0PQHwVetQYwBGV4l7WaTWcG6/NcOW9lZN2W/cDy7KrTJku3hAIi541qOuC4JXxZU4JT+aBmofhjs+jqK6gSQnDZkTLJIAYZQQh61QaSxFa1P7EJ86htMMytUGYvdDdPgKMnaX/x3oOeSNLPQnlItqWoWMufedwyxomLyWOvXOwg/Q903krsVEIZaXeKYQbJjgTjydtA8jYv7G4heigkmVLe2GPASVzjdcnzsGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(6506007)(64756008)(85182001)(2906002)(186003)(53546011)(26005)(76116006)(38100700002)(478600001)(66556008)(83380400001)(54906003)(55236004)(8936002)(122000001)(316002)(6486002)(66476007)(9686003)(66946007)(33656002)(6916009)(6512007)(4326008)(66446008)(5660300002)(1076003)(8676002)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U2JjTE1QYmZjR3ZoS3hxdEFyVDBhOENHZS9tV21yS1g3L2FPY1Z0YnJZTnp2?=
 =?utf-8?B?YWdTWVZQb0RoMExJSEsyTWxKTG5aQlk5d2NqZk1XQzIxNmpja3lRK1h3WWJ1?=
 =?utf-8?B?eWNweXJRT0g1Zmk0elAwRlZQTzVSZm9JTXo0ZHRFQ3ZZN2RSZzIwRE51aysw?=
 =?utf-8?B?bTcwbk16dU5tbG1FNmFjQXUzdzJYOEw3MHh0T2tvWEV0cDFJSzVRWGJld1di?=
 =?utf-8?B?NFBRQTI4djNCVVQxak1YQTBGaFBuTXFQSVBQVkt6ZUJ4Yk0zbzN0Q21yRjli?=
 =?utf-8?B?K1BrYnhxazA3aEJoUkJnbFRHdmVlRHlUWXQyVXI4TVRxT2cwUUhjSDhLSE5U?=
 =?utf-8?B?TXRZM2xPaHR3N1NCTFh1aEtRRG5NRTdhY05aVnVGQThTeXBieVFoWDl0eXls?=
 =?utf-8?B?UTAya1V4WUF6UWJyelhFenZDaHZVa0kzKytxc1o4UTI5MEJwSm5GOU5CVG5X?=
 =?utf-8?B?L2crTG5jR01RQ1J2aHdZOEtvSHlnbWRQWW40bEdzNjBTejJ1dVJrUHZxYWhw?=
 =?utf-8?B?QngzNDJKc1d6K0VFSXZjdktlOUdUTHpPRWJJUXhKTW5GUG1FdHVodlZsY0hB?=
 =?utf-8?B?Rjd3UGhvaFZaTHVBemdRd0g2cjdvSWhhV0JmMlRXVkg5QzNMNjQyK1I2V2d3?=
 =?utf-8?B?TVc0bFRESVNrYndFekRJSnhpMjg1NDZyY1MyRlJYc0xHL0dBWUUwRXowTWlM?=
 =?utf-8?B?djRmSW5YcDJOSDhJWmpReXJIT0RKSEJzSVFsRGRUbGF3QXFhRGxFY29XSTY3?=
 =?utf-8?B?TXA1WkFVRmtITE9pNWpFK2JHblJqcEUyMmcrTjNaV3dnRml3NVRLd1hjWDFF?=
 =?utf-8?B?TVlrMUd0WmdRYmVseVJpR1E5dURsTzEvYzdleTgwWGFScjQ1Y0NlTU9XVG9X?=
 =?utf-8?B?MHZoK3h2b2wwRzJ1YytvVHNVaEQ4S21wU2JNYU5XTTJ2aExKR2JaeXphSjBW?=
 =?utf-8?B?b1lHZVRkNVpYK0xtaERldkR6YjZKS1BtSWUyMXRiTDFsOVFrNitXMzV0QnFp?=
 =?utf-8?B?WlJnMzU3THpVaGVZWVhkVDZmb25nNGJ4N1ZTcEZsZXFPWlF3U1hpM2VrRWx1?=
 =?utf-8?B?ODE0Nk9xdWprRERsYW5wcjBCODBmNVE3RXAzSTMyZ2c5YU5XUFRlaWZGVUdt?=
 =?utf-8?B?bXQrMFh1cXVSMUZQaGgwL0JrRTNCY3RsNzRqbTFPblplY1NvVGhhRkRGUmlx?=
 =?utf-8?B?ZElvc3JZREF4YjVqVkVHRXE1amlZcXV3NTY2dGFIbkhkK25kQ2oxVG1mZVBz?=
 =?utf-8?B?ZGFmRmFyVEZreElOa28rT2o5YVRibThvcjRUNk00aDhPMEY4MVJxMExNSFZQ?=
 =?utf-8?B?bFdicmpWNVBqdmdsYTZkVUw5a21SbXU0eGFKL2NVZlZXV3EzZlU5RDl2VnZW?=
 =?utf-8?B?aWlMYk9kaFJOclhHd0FDRnBncjFvWDREYUd2NXA1QjE3QVRkWElibzk2TzRw?=
 =?utf-8?B?SWhUV1dIZ0NuRUZsQTdZbHBCMitQOGFGdWM3K2xQYURvTGlndEY2bjBGdjdx?=
 =?utf-8?B?RTdwa0R3dTdlTGhhZUJVbkZtOGRpS2dTbSs5ZWFzWVdhanZwakVCT1FLT2hn?=
 =?utf-8?B?Q2I5bGsvdjBYRXFtUHdXYnRoM0x2aGxNQ24rc3ZXRXQ4OGZraWVNYWRJY3k0?=
 =?utf-8?B?cWNqTVFiRmFxWEdxc3ZubUh4VFhtMVZ3SHFPTjJ4UldwZEYyYUM3WExMKzRY?=
 =?utf-8?B?eHFzckptZzBtRWJEOURzYkNDTjNreS8rWU9CdjVpNGEvYnZaMVlHSm13eTJU?=
 =?utf-8?Q?ZOFLcRSe/2kzPZX/pLIEXM16QTVKc5HcBECvNUD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85F79879621BA5428BF62CF9EFDCBF37@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d7384-b638-417f-b501-08d91f7e25f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 13:08:11.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yv6yNN682VVteecqMTuGnoCz++qvkDYewQca9a+OuQmEUHmVRNo/cjtppgrlxcNRGtRq9dCMh/dzojy2mwIOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgMTE6MDk6MThBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDA4OjA3OjA3QU0gKzAwMDAsIEhPUklH
VUNISSBOQU9ZQSjloIDlj6Mg55u05LmfKSB3cm90ZToNCj4gPiBPSywgaGVyZSdzIHRoZSBjdXJy
ZW50IGRyYWZ0Lg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBOYW95YSBIb3JpZ3VjaGkNCj4gPiAN
Cj4gPiAtLS0NCj4gPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMu
Y29tPg0KPiA+IERhdGU6IFR1ZSwgMTggTWF5IDIwMjEgMjM6NDk6MTggKzA5MDANCj4gPiBTdWJq
ZWN0OiBbUEFUQ0hdIG1tLGh3cG9pc29uOiBmaXggcmFjZSB3aXRoIGh1Z2V0bGIgcGFnZSBhbGxv
Y2F0aW9uDQo+ID4gDQo+ID4gV2hlbiBodWdldGxiIHBhZ2UgZmF1bHQgKHVuZGVyIG92ZXJjb21t
aXR0aW5nIHNpdHVhdGlvbikgYW5kDQo+ID4gbWVtb3J5X2ZhaWx1cmUoKSByYWNlLCBWTV9CVUdf
T05fUEFHRSgpIGlzIHRyaWdnZXJlZCBieSB0aGUgZm9sbG93aW5nIHJhY2U6DQo+ID4gDQo+ID4g
ICAgIENQVTA6ICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMToNCj4gPiANCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnYXRoZXJfc3VycGx1c19wYWdlcygpDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0gYWxsb2Nfc3Vy
cGx1c19odWdlX3BhZ2UoKQ0KPiA+ICAgICBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkNCj4gPiAg
ICAgICBnZXRfaHdwb2lzb25fcGFnZShwYWdlKQ0KPiA+ICAgICAgICAgX19nZXRfaHdwb2lzb25f
cGFnZShwYWdlKQ0KPiA+ICAgICAgICAgICBnZXRfcGFnZV91bmxlc3NfemVybyhwYWdlKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgemVybyA9IHB1dF9wYWdlX3Rl
c3R6ZXJvKHBhZ2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBW
TV9CVUdfT05fUEFHRSghemVybywgcGFnZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVucXVldWVfaHVnZV9wYWdlKGgsIHBhZ2UpDQo+ID4gICAgICAgcHV0X3Bh
Z2UocGFnZSkNCj4gPiANCj4gPiBfX2dldF9od3BvaXNvbl9wYWdlKCkgb25seSBjaGVja3MgdGhl
IHBhZ2UgcmVmY291bnQgYmVmb3JlIHRha2luZyBhbg0KPiA+IGFkZGl0aW9uYWwgb25lIGZvciBt
ZW1vcnkgZXJyb3IgaGFuZGxpbmcsIHdoaWNoIGlzIHdyb25nIGJlY2F1c2UgdGhlcmUncw0KPiA+
IGEgdGltZSB3aW5kb3cgd2hlcmUgY29tcG91bmQgcGFnZXMgaGF2ZSBub24temVybyByZWZjb3Vu
dCBkdXJpbmcNCj4gPiBpbml0aWFsaXphdGlvbi4gIFNvIG1ha2UgX19nZXRfaHdwb2lzb25fcGFn
ZSgpIGNoZWNrIHBhZ2Ugc3RhdHVzIGEgYml0DQo+ID4gbW9yZSBmb3IgaHVnZXRsYiBwYWdlcy4N
Cj4gDQo+IEkgdGhpbmsgdGhhdCB0aGlzIGNoYW5nZWxvZyB3b3VsZCBiZW5lZml0IGZyb20gc29t
ZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgbmV3DQo+ICFQYWdlTFJVICYmICFfX1BhZ2VNb3ZhYmxl
IGNoZWNrLg0KDQpPSywgSSdsbCB1cGRhdGUgYWJvdXQgdGhpcyBjaGVjay4NCg0KPiA+ICBzdGF0
aWMgaW50IF9fZ2V0X2h3cG9pc29uX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gIHsNCj4g
PiAgCXN0cnVjdCBwYWdlICpoZWFkID0gY29tcG91bmRfaGVhZChwYWdlKTsNCj4gPiArCWludCBy
ZXQgPSAwOw0KPiA+ICsJYm9vbCBodWdldGxiID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsJcmV0ID0g
Z2V0X2h3cG9pc29uX2h1Z2VfcGFnZShoZWFkLCAmaHVnZXRsYik7DQo+ID4gKwlpZiAoaHVnZXRs
YikNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghUGFnZUxSVShoZWFkKSAm
JiAhX19QYWdlTW92YWJsZShoZWFkKSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gDQo+IFRoaXMgZGVm
aW5pdGVseSBuZWVkcyBhIGNvbW1lbnQgaGludGluZyB0aGUgcmVhZGVyIHdoeSB3ZSBuZWVkIHRv
IGNoZWNrIGZvciB0aGlzLg0KPiBBRkFJQ1MsIHRoaXMgaXMgdG8gY2xvc2UgdGhlIHJhY2Ugd2hl
cmUgYSBwYWdlIGlzIGFib3V0IHRvIGJlIGEgaHVnZXRsYiBwYWdlIHNvb24sDQo+IHNvIHdlIGRv
IG5vdCBnbyBmb3IgZ2V0X3BhZ2VfdW5sZXNzX3plcm8oKSwgcmlnaHQ/DQoNClJpZ2h0LCBJIGNh
bid0IGZpbmQgYW55IG90aGVyIHJlbGlhYmxlIGNoZWNrIHRvIHNob3cgdGhhdCBhIHBhZ2UgaXMg
bm90DQp1bmRlciBpbml0aWFsaXphdGlvbiBvZiBodWdldGxiIHBhZ2VzLiBJJ2xsIHN0YXRlIHdo
eSB0aGlzIGNoZWNrIGlzIG5lZWRlZC4NCg0KPiANCj4gRnJvbSBzb2Z0X29mZmxpbmVfcGFnZSdz
IFBPViBJIF9fZ3Vlc3NfXyB0aGF0J3MgZmluZSBiZWNhdXNlIHdlIG9ubHkgZGVhbCB3aXRoDQo+
IHBhZ2VzIHdlIGtub3cgYWJvdXQuDQo+IEJ1dCB3aGF0IGFib3V0IG1lbW9yeV9mYWlsdXJlKCk/
IEkgdGhpbmsgbWVtb3J5X2ZhaWx1cmUoKSBpcyBsZXNzIHBpY2t5IGFib3V0IHRoYXQsDQo+IHNv
IGl0IGlzIG9rYXkgdG8gbm90IHRha2UgYSByZWZjb3VudCBvbiB0aGF0IGNhc2U/DQoNCkFjdHVh
bGx5IHRoZSBjb3ZlcmFnZSBvZiBwYWdlIHR5cGVzIGZvciB3aGljaCBtZW1vcnkgZXJyb3IgY2Fu
IGJlIGhhbmRsZWQNCmFyZSB0aGUgc2FtZSBiZXR3ZWVuIG1lbW9yeV9mYWlsdXJlKCkgYW5kIHNv
ZnRfb2ZmbGluZV9wYWdlKCkuICBPbmUNCm1lbW9yeV9mYWlsdXJlLXNwZWNpZmljIHJvbGUgaXMg
dG8gcHJpbnQgb3V0IGxvZ3MgYWJvdXQgZXJyb3IgZXZlbnRzIGV2ZW4gaWYNCnRoZXkgY2FuJ3Qg
YmUgc3VjY2Vzc2Z1bGx5IGhhbmRsZWQsIHdoaWNoIGNvdWxkIGJlIGFmZmVjdGVkIGJ5IHRoaXMg
Y2hhbmdlLA0Kc28gd2UgbWlnaHQgbmVlZCB0byBhZGp1c3QgaG93IG1lbW9yeV9mYWlsdXJlKCkg
dXNlcyB0aGUgcmV0dXJuIHZhbHVlIG9mDQpnZXRfaHdwb2lzb25fcGFnZSgpLg0KDQpUaGFua3Ms
DQpOYW95YSBIb3JpZ3VjaGk=
