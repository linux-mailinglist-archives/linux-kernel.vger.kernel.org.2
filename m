Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE40B404423
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 06:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350361AbhIID7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:59:15 -0400
Received: from mail-eopbgr1410057.outbound.protection.outlook.com ([40.107.141.57]:51628
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350303AbhIID7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqkzmlN8P6kVckY5cDoWERhNfjFxP6RvuVrn+3b6ek4QDDEx1E7kC8PYOA/zhKzAukFeKCzzaUSmUmLtRrEs8VSOMzAJ2e0kj4ngsvtbOav51C8fDRPr4UUnH02v/90lHPpzfWrYdC5ytgWUUkIfUwhFMZXgldlxWrag/oeHQVBjK4nv6+ej6wL2m2xCaA99vp9LTVnJlSiPVwW1gTzzdOwfwyxD0gCl+Q6CiX1hXevsicTj9FpiRnYeiceijzulAe2e8WLOH8DsYUNvLY6DU+pBwre2Bt+OsI7ijQcJz4pRMDlxMPOpI3rbtSov+yAtvWoNEp4FnmGQlDtozt0ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5KylrSlKb2N1aF8tUdTplNmbcLxpuXT1iQ3ULB/tU6I=;
 b=QwXXbsfSy1tU415iG41bKnCLBTqdwHgtgTckswpICQaJ5CjfiIDuKpoAB5It78tdheZoQ4hGrh5wj/Q0SkqZ5UbitxkyIJiG5dhYotZzq+2qNbirpkjamVi6V6F4IcV62AxTjR7bHuDAUo0B9H1OS3bh2/sWPzx7Mdy+kzhFuOXhSOGSScguUrtGi+DFpxGv++Lq52UjSrr4km86Tyn0ug7jIhbDr6gcm2jJKITKAWFNRpTnq7NEbel9gUPIwUDKPLxhBk26zRw5OPtlzbbbPQW/a/1GgQ3PIueytBeORZ9E8VDPCAH6AeRCE3gsXiDVIJ3GtAEmU+l8+PkF1AYIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KylrSlKb2N1aF8tUdTplNmbcLxpuXT1iQ3ULB/tU6I=;
 b=g8sPVGPf0CsV1c+UbVbI47p9eYkvSlg10r7ftasTLhfDthExNDEdytOXtoFKIH5yZ1GzmTGMucsYAdSHkL9ls+S3nI5B8bluF/4TvV6WUMgb1C/UPbQB5YguarX20Dwq2HeNe7I6j7+1gG7O2CxbWy9ey86JgE8+yWGOhuKlbds=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYXPR01MB1694.jpnprd01.prod.outlook.com (2603:1096:403:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 03:58:04 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::5c68:d56a:79f7:56c1]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::5c68:d56a:79f7:56c1%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 03:58:04 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm, hwpoison: add is_free_buddy_page() in
 HWPoisonHandlable()
Thread-Topic: [PATCH v1] mm, hwpoison: add is_free_buddy_page() in
 HWPoisonHandlable()
Thread-Index: AQHXpROAuSegSDBG7k6oFJrHG456BaubCZ0AgAAKAoA=
Date:   Thu, 9 Sep 2021 03:58:03 +0000
Message-ID: <20210909035803.GA379160@hori.linux.bs1.fc.nec.co.jp>
References: <20210909004131.163221-1-naoya.horiguchi@linux.dev>
 <CAHbLzkq_S+90vjRsoEST0Dqidnjy6M1=iQ00h95CaWE1S=WwfQ@mail.gmail.com>
In-Reply-To: <CAHbLzkq_S+90vjRsoEST0Dqidnjy6M1=iQ00h95CaWE1S=WwfQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcfc668f-030b-4c7c-596b-08d973460657
x-ms-traffictypediagnostic: TYXPR01MB1694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYXPR01MB1694552EB2EEB204D8472CF7E7D59@TYXPR01MB1694.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Enp2yfTzzQ2/r8qQ3FdvAeUR05HJt5urbSxCo2ZtQTs9aNDwvSVk1dBqCY6/M667Af+rU7L1/UujQ+Hdgwb80Xm2zNUzCoDFYfogqzQVOTuPQRTOT1N7wdZP3hXmiPzwpTPXONCXgUGdyxRE4lhVFUxveeROIhRvKaITMt01FZaGyzlSVLEjLP0xnqgzYykENd7jqTT0QX8zb1wMwBnh8Ta35iHXBnutAj9PcRyLIRL3TerZuyl1Z0gRMS6AOpwOBd0ERKfxsnEIJIouIVAr2hti3nWJIZbE7toeA9e9lVliQjjpaijnGnHjYgNSpCaMn2HPJJMi03G8qOPdFAfb4x80MoYwoM+BqBxjfbYPbzIp/Kk083EcYi+JF6V5JbNpKnLm9wYFoITszorwXaAmtwqBqK3tqf1g2ylk0DXEooTqIMQW3VihfNu94N8Pxpx7oYllHvpH7eiOCK7DWGH91NujOWsuyIJCTsgzkqSHYl7gNIYh3cVlnPCNOQSEMWpsROVHwvMqLTMZpkmrDyFTavVERkndl4rv1NPN2vCV80Lu/1CfXBMa8/WlTrbXbYKlsaRhuFG+iS6MImMxyNIJ+ZuRs+wdB9acFq6nef4a7G4PSk1WO6koZ0eV3eInRsuRLFlv0YQQoMgJwvPrUiipr/nR/UFNyNygbHq1L+bwG47R9BPFSsLWZQ+fyHNjyhVE54ZuZZoijGkVwLOyog8aYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(4326008)(7416002)(64756008)(85182001)(2906002)(76116006)(1076003)(66446008)(8936002)(26005)(186003)(54906003)(6486002)(55236004)(38100700002)(33656002)(71200400001)(316002)(8676002)(38070700005)(86362001)(66476007)(66946007)(9686003)(66556008)(6512007)(122000001)(6506007)(53546011)(478600001)(6916009)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3BQVGJNS3dmWFgwQzl4UkxpSVk1emFiUktDWW44elI0NWhlTDYvMjY5SElK?=
 =?utf-8?B?UjhGeG5CUFBmS1N2M1FpaFhDd04yTjJHQldJZGNXRDZFY0tITXdva3hXYUxw?=
 =?utf-8?B?YjcrRG1SNk0yQ3RlcVJ4N1NSbjh2eTdRcEZWS1p2amF6K2dNdUpjZDFnb3lz?=
 =?utf-8?B?WnB2OWdHdFcxd0VObmFpQmthY2FtUDlrSTFtY2xsYjVCYWxaZzROT2xvR0Zj?=
 =?utf-8?B?N3drSmtKMlRSeTBJT3djaWFBdWFRL0hWdG54YUNjUkdKRmdEb1VLOUhKV3ZR?=
 =?utf-8?B?UEJtSktGRTN4Zy9lY2V1TGZCZVdnbFgyN1lEMytGNkF6aU9mQVpsVjg0dW9K?=
 =?utf-8?B?dTArZ1lPekRnZEx2cEQwM21Kc0Z4akxVWERlc3RkNWh5U0hFYm5IU2hMbzZv?=
 =?utf-8?B?WExQanM0eHphK2w4dHZQZWF3cEJGN1FXMVdpQk45bmx6anZaelRZaWtCMjVR?=
 =?utf-8?B?ZThJNitkd0hCcjBINUEwRkFxejlKYjI0Q1h4YmdzQWhlS29tY0FYZlVEMVVZ?=
 =?utf-8?B?Y3c3SjFFMEZlRDY4TW1BK25aWG1mQUlpaTN4UmRFd1BtaWVDN0szUWV3dnlj?=
 =?utf-8?B?YTZxSzFkSHNoNVlodDljNDdvdllrbjJ2eEJVVXQ1ZUNnNkZ2WWd5RUhvSE1q?=
 =?utf-8?B?NkZ6MkFuZWFSYkU0djhzd3pnc2NFVHFTTjlLdEVVRk1pRndWN3lsWE1DdHNB?=
 =?utf-8?B?NHM2azJxVmhJVEdieGVlUGFaOEMvek92USttRllONU4rUVVFRUxXc3duOEM1?=
 =?utf-8?B?R2tBN2xVeHFXdEJUWG9ueDVvL0dpYm9pUFBYMU5SOWJhMk42bkNUb212NVBI?=
 =?utf-8?B?aU5YUERFWEtuc2Yyb1paREpQa1lxWWhBLzBoT1EzSnBVK3Roa3J2VHAzY1dN?=
 =?utf-8?B?UVZJVFd4MWRqbStubWdraUNEVHhNcTY5MHZ3MnRCb0FSTW5Ka2pVTGFTVDY4?=
 =?utf-8?B?NjRnZVFITTlSQnBrdFppNWtJemsvMkZqU05yNWpCRGV4VUMwMktaT0tlUVVk?=
 =?utf-8?B?a01pTldVUEJzcGc4UjdKendkdHJ5UUV0VjUrOTA3M0FPcWdDNWZidlFsRkJ5?=
 =?utf-8?B?UFU4TElSZXpETjFFK3F2VUxLNEZoazRoVDRUVWZKR2V6blF3TldYdXdtZ2dy?=
 =?utf-8?B?N1Z0SzU4OWF6NzZucnAwQTdNU2d6NmxIL0ZsTHovbEpsM1BxRTVFTlpQTGhm?=
 =?utf-8?B?L2dDSnA5cUNtNFF6TTBpcHp4QkJEenlLam9OdURrK0pPUlRWTGhCelNXc0tv?=
 =?utf-8?B?RmFFcDlmSHJoNkh4dHljL2ZqdUc1OHRyZUt6SmJpVm1yb1ZpaEJsNXM1RE5Y?=
 =?utf-8?B?MjJWSUZkVEIxYktqeWdlU2U5eDBmMFlyUktlME0xY2QxdVZjQ1VQdEZZVzhw?=
 =?utf-8?B?ZENrZ2lodDV0UUhXTjNwcjZOLzIwNkFmbGwvSEhYS05ROHZHWDNnL2pmdFlL?=
 =?utf-8?B?aDZaK29nNlFmVE5vMGIvZzVWSi85VzdYUDBjblN6elNXMzJjZThyRnlXN2FF?=
 =?utf-8?B?N1pFMkFqMmtqNTZkTDZEdkhNTVdPRitrUTFlVDdsMFl6bEEweUY3SnRMSlJW?=
 =?utf-8?B?cG96UHNPTy9iQldRSk1paGlJMUl5elArR2Y5aDVYM3Y4YitoS0ZUMExMaEhz?=
 =?utf-8?B?Q2EvTDZ0dGZZcFViVzYrL3lhdjFzU0xIVkZKUXVlakU5RkRMd2VyWVZRQ0kz?=
 =?utf-8?B?UXdqZmtLaURYZy9ZNTl4OFFmUHArdFZPOEsyRXltZlExMCtiNEhIbllzZGVl?=
 =?utf-8?B?SmFPTGZCZWJGcmRPdVVaVVFLTnQvWVRzL0IrdU5sOEFQbU94a2g4aUQrV1lU?=
 =?utf-8?B?K2lCdXRUaVlGS1VHeTVOQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55EA289D4C265347A264AAFE6FADF41C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc668f-030b-4c7c-596b-08d973460657
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 03:58:03.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UY3TiJEo0HZRYKsX3B4XIEBFAtUihnSYLpIo8eb3OrPmyGZLpmpkesau4DOUOvwfyfTlgXH5P4lLeySkDVPPZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBTZXAgMDgsIDIwMjEgYXQgMDg6MjI6MTRQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDgsIDIwMjEgYXQgNTo0MSBQTSBOYW95YSBIb3JpZ3VjaGkNCj4gPG5h
b3lhLmhvcmlndWNoaUBsaW51eC5kZXY+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogTmFveWEgSG9y
aWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPg0KPiA+IGNvbW1pdCBmY2MwMDYy
MWQ4OGIgKCJtbS9od3BvaXNvbjogcmV0cnkgd2l0aCBzaGFrZV9wYWdlKCkgZm9yDQo+ID4gdW5o
YW5kbGFibGUgcGFnZXMiKSBjaGFuZ2VzIHRoZSByZXR1cm4gdmFsdWUgb2YgX19nZXRfaHdwb2lz
b25fcGFnZSgpIHRvDQo+ID4gcmV0cnkgZm9yIHRyYW5zaWVudGx5IHVuaGFuZGxhYmxlIGNhc2Vz
LiAgSG93ZXZlciwgX19nZXRfaHdwb2lzb25fcGFnZSgpDQo+ID4gY3VycmVudGx5IGZhaWxzIHRv
IHByb3Blcmx5IGp1ZGdlIGJ1ZGR5IHBhZ2VzIGFzIGhhbmRsYWJsZSwgc28gaGFyZC9zb2Z0DQo+
ID4gb2ZmbGluZSBmb3IgYnVkZHkgcGFnZXMgYWx3YXlzIGZhaWwgYXMgInVuaGFuZGxhYmxlIHBh
Z2UiLiAgVGhpcyBpcw0KPiA+IHRvdGFsbHkgcmVncmV0dGFibGUuDQo+ID4NCj4gPiBTbyBsZXQn
cyBhZGQgaXNfZnJlZV9idWRkeV9wYWdlKCkgaW4gSFdQb2lzb25IYW5kbGFibGUoKSwgc28gdGhh
dA0KPiA+IF9fZ2V0X2h3cG9pc29uX3BhZ2UoKSByZXR1cm5zIGRpZmZlcmVudCByZXR1cm4gdmFs
dWVzIGJldHdlZW4gYnVkZHkNCj4gPiBwYWdlcyBhbmQgdW5oYW5kbGFibGUgcGFnZXMgYXMgaW50
ZW5kZWQuDQo+ID4NCj4gPiBGaXhlczogZmNjMDA2MjFkODhiICgibW0vaHdwb2lzb246IHJldHJ5
IHdpdGggc2hha2VfcGFnZSgpIGZvciB1bmhhbmRsYWJsZSBwYWdlcyIpDQo+ID4gQ2M6IDxzdGFi
bGVAdmdlci5rZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb3lhIEhvcmlndWNoaSA8
bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL21lbW9yeS1mYWlsdXJl
LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCB2NS4xNC1yYzctbW1vdG0tMjAyMS0wOC0yMy0xNi00
Mi9tbS9tZW1vcnktZmFpbHVyZS5jIHY1LjE0LXJjNy1tbW90bS0yMDIxLTA4LTIzLTE2LTQyX3Bh
dGNoZWQvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+IGluZGV4IDYwZGY4ZmNkMDQ0NC4uMzQxNmM1
NWJlODEwIDEwMDY0NA0KPiA+IC0tLSB2NS4xNC1yYzctbW1vdG0tMjAyMS0wOC0yMy0xNi00Mi9t
bS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gKysrIHY1LjE0LXJjNy1tbW90bS0yMDIxLTA4LTIzLTE2
LTQyX3BhdGNoZWQvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+IEBAIC0xMTI2LDcgKzExMjYsNyBA
QCBzdGF0aWMgaW50IHBhZ2VfYWN0aW9uKHN0cnVjdCBwYWdlX3N0YXRlICpwcywgc3RydWN0IHBh
Z2UgKnAsDQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgSFdQb2lzb25IYW5kbGFi
bGUoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gIHsNCj4gPiAtICAgICAgIHJldHVybiBQYWdlTFJV
KHBhZ2UpIHx8IF9fUGFnZU1vdmFibGUocGFnZSk7DQo+ID4gKyAgICAgICByZXR1cm4gUGFnZUxS
VShwYWdlKSB8fCBfX1BhZ2VNb3ZhYmxlKHBhZ2UpIHx8IGlzX2ZyZWVfYnVkZHlfcGFnZShwYWdl
KTsNCj4gDQo+IEl0IHNlZW1zIHRvIHdvcmsuIEFsdGhvdWdoIHRoaXMgbWF5IGNoYW5nZSB0aGUg
cmV0dXJuIHZhbHVlIG9mDQo+IGdldF9hbnlfcGFnZSgpIHRvIDEgd2hlbiBNRl9DT1VOVF9JTkNS
RUFTRUQgaXMgc2V0LiBUaGlzIG1heSBjYXVzZQ0KPiBzb2Z0IG9mZmxpbmUgdG8gbWlzaGFuZGxl
IGZyZWUgYnVkZHkgcGFnZSwgYnV0IE1GX0NPVU5UX0lOQ1JFQVNFRCBpcw0KPiBvbmx5IHNldCB3
aGVuIG1hZHZpc2UgaXMgdXNlZCwgYW5kIG1hZHZpc2UgZGVmaW5pdGVseSBjYW4ndCBzb2Z0DQo+
IG9mZmxpbmUgZnJlZSBidWRkeSBwYWdlLiANCg0KWWVzLCBtYWR2aXNlKE1BRFZfU09GVF9PRkZM
SU5FKSBzaG91bGQgbm90IGJlIGNhbGxlZCBmb3IgZnJlZSBidWRkeSBwYWdlcywNCmJlY2F1c2Ug
dGhlIGludGVyZmFjZSBjb3ZlcnMgb25seSB1c2VyLW1hcHBlZCBwYWdlcy4NCg0KPiBJdCBkaWQg
dGFrZSBtZSBhIHdoaWxlIHRvIGZpZ3VyZSBvdXQgdGhpcw0KPiB0cmljay4gTWF5YmUgbmVlZCBz
b21lIHJlZmFjdG9yPw0KDQpJIHRoaW5rIHNvLCB0aGUgY3VycmVudCBjb2RlIGxvb2tzIHRvIG1l
IGZyYWdpbGUgZm9yIGZ1dHVyZSBjaGFuZ2UsIGJ1dA0KSSdtIG5vdCBzdXJlIGhvdyB3ZSBjYW4g
aW1wcm92ZSB0aGlzLg0KDQpPbmUgKG1heWJlIG5vdCByZWxhdGVkIHRvIE1GX0NPVU5UX0lOQ1JF
QVNFRCkgcm9vbSBmb3IgcmVmYWN0b3JpbmcgaXMNCiJpZiAoUGFnZVRyYW5zSHVnZShoZWFkKSki
IGJsb2NrIGluIF9fZ2V0X2h3cG9pc29uX3BhZ2UoKSwgd2hpY2ggbWlnaHQNCmJlIG9sZCBhbmQg
dXNlbGVzcyBjb2RlIGZvciBub3cuDQoNCj4gDQo+IEFueXdheSB0aGlzIHBhdGNoIGxvb2tzIGZp
bmUgdG8gbWUuIFJldmlld2VkLWJ5OiBZYW5nIFNoaSA8c2h5ODI4MzAxQGdtYWlsLmNvbT4NCg0K
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQotIE5hb3lh
