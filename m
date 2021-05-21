Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3538CE88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhEUUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:05:42 -0400
Received: from mail-eopbgr1400123.outbound.protection.outlook.com ([40.107.140.123]:62886
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhEUUFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTfjBvhreif0YfWkdfBITM2YSCJdbYYJF0QhWyej+FtvOGzv8LQ45CqV3XNOPOIqAxvfE7qc0DQxewRWEzcbb+v5PdkUnu482Q0jxIRbPIKYectlhRCkXSeOHE9UY6NU4wtPu2QXLGmZwQ1B+iQEv+FllfEhX+PAsz2C7tzFiqVT21JAUWFhImRAR7QJJ3xOcelYUFvHAbi7QX7iP1fnCrSZYBxtY79YUBgm1VdDfSQYkPy8mirrUMc2ddpypaLJ4+vAAQh6YKy6lY2EugzlNnWhQBkFW9/QY3jwvT4Ts2klQvhEKtZidvH9pGtVI3QGy/QHgkMTfl0g7rtYv/EFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FON/dQjyh8cQLlJrr32r2OxkW9BnrCVLZu+HrSY48QI=;
 b=OIeeu0afaOwmqxXU7pZc8jmq6Jp3hGn5XAvjCs4i/NRVhWI3DPrlvMI+qoVM69gzwnbrkI/4gYVI1tIWJ1PK0dNrasNstxIywxkGEXDDoDEZAsRZZ8wQ8ZYSLCKCOpIAIrhku+SmUYTlF4teiLvrQmQq69C1a3FJbO/+k1bLt20Rwv+zsEmUFJUgwgrJ/MakhqGUni39ZoWafSzKqxHhJJXhtc3jiwS4G6l2XLsl08xqW3WnbTogiA5KNxUWlEqvtLPYp0STktVu6qibV4KbITkaOl+fGCxjffOv64G4rYTffdTJJJDoKGDF26XLzCRsypV3uASyXMtgKV6s0DAfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FON/dQjyh8cQLlJrr32r2OxkW9BnrCVLZu+HrSY48QI=;
 b=ft/nCkBcKxWh+T6fatcYhmPyUrriVhCrsMVA52iWPz+S/aHX6U1VH77tXRSPxTEkVjuoHS9gU/kZPNm65leftQkvOLYrgEHrn3r8lb4yDSsZlUOjXCe1mtXvbIlXWuvIFQGoR4rscu++kdRgF/9lA82pocS/UQrjPtKKoa9wmfo=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSYPR01MB5446.jpnprd01.prod.outlook.com (2603:1096:604:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 20:04:14 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2%7]) with mapi id 15.20.4150.025; Fri, 21 May 2021
 20:04:14 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rqloqAgAONlTCAAArCgIAAUn1Q
Date:   Fri, 21 May 2021 20:04:14 +0000
Message-ID: <OS3PR01MB6593B9868844AF3D6BB35453BA299@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
 <OS3PR01MB6593794BFE3A4A08C62E708BBA299@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <20210521150209.GI2549456@dell>
In-Reply-To: <20210521150209.GI2549456@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf77c216-930a-4d4b-418e-08d91c939b77
x-ms-traffictypediagnostic: OSYPR01MB5446:
x-microsoft-antispam-prvs: <OSYPR01MB5446CF16677A7632C9F7A4F7BA299@OSYPR01MB5446.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yybdcwFiZd7Amv+ExFSyhoWQ/myYhmbe3kURIVhSTYdB5Uh4ynX1DzKqu4idnTmZkvLMzs3sdMiGeMixtQIg77SB6Ui2i6mI/9unwKU/biqRSoH0pYYOg1H5ABQ+d71omA6HccaIs5VqgiJ9/BMQJW8CNRr4WeqlxRs6PvJI1YkIII3VYdAhX86hJpIHDY34X1eq8DeRhFVihyUD5JSm8Y/X2ZdDVcw8vBpP2FnGjHwZIuM7gRs/1mhN3tyEfotOKmENHwlPQzUUJDEJeaPjZ2uoQZzxDHLU07v+QsVjSaP6f9U9wSx8I08dS96gqItfgoyBA4A9HJc2sMpyHiuWgQIyS136AM7q0dlNErtLgU2JDACbAT85vCKQZ4ANpHl5/Oue7ZntN6H+DICel/TVR4xxs5yBQcqJRQxNnRXvqpGjwy9tcmIgOhrgfIqSkkAv0J9EMM+xa/2hpgv8ke9mmjjZ/LNTXiZkSsL0i1QbkM9DDeH6RcGKrhNGe4z5ztGitLys6Nvo2ym5VA5wwJEWZ4phH271hiRetYjonsj/Pk7dyTf2RcPvIhs6OS37x1DtkEbJ4Uvvgvwyr9ubRPiSLvz7NdPBEQ04MCW/oJ4QTzY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(71200400001)(86362001)(122000001)(7696005)(26005)(6506007)(66476007)(66946007)(33656002)(76116006)(8676002)(66446008)(64756008)(316002)(66556008)(38100700002)(8936002)(4744005)(52536014)(186003)(54906003)(478600001)(55016002)(5660300002)(2906002)(9686003)(6916009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WDhQblpDMzdUclRQMmlUUFNIeVVCL3ZMTVhwaUVVLytUM1RPeVh6Y01VcXpu?=
 =?utf-8?B?VE95UlgySzVuUWZ1dG4vY0NsVGNKSTNYTGNybFhEVlREdmJIU25PT1B6Wk9M?=
 =?utf-8?B?STZpS0pKRURYN0IvRE83Q3RWMFUrKzRSeXY1T3A0SW9QNHdlNkw1emI5Rm1a?=
 =?utf-8?B?eDBDNzQxLy9ydjliOHgvK3RFTW1UMmxubjVtY1hOVUFMY2ZBSXZmemt2T0p6?=
 =?utf-8?B?VGFCN2FZNU5lWG1xejlmMHlaM2RPbDhoMWw5RGhtQ09tb3dyT0dvSitET1cz?=
 =?utf-8?B?QUUrOHRNbW02anJ4Q3dtVTVnVldjVCtQbnVHczBSUHpwVmF5NnU4SEVTUXJz?=
 =?utf-8?B?UmxvQjB2NXJSaXZITWRmYXJNWXQyRElQdjRSZHJjanY0K3g0NjJHQk1FV3lG?=
 =?utf-8?B?bk10ZmFPV01JQ214TkRvTkZLKzUzL2RFUndZNHRXdU1BVzE3TTZRR2RSMDNT?=
 =?utf-8?B?L1FZa3dqZ1NYUWsrZkhqMnlzZG5IT2lObHBmcDU2WlF6OFRrTHJmenlEUU9R?=
 =?utf-8?B?OHdzVmVRSzV5ZUVrSklqZWtNTkVORi9TTHdKR1p3ZURnT0JQWFJYNDZyd2tS?=
 =?utf-8?B?MGZrV3lXbnlNNmo4c2tnRXcwR0xsYmR5cE1jblMwM0dyUkNURGVROFBEY2FZ?=
 =?utf-8?B?TDdkUUozdTh4dHBWUHJaRjFVblhrRnpDM2R0byswUExJSk1wQk1BRkd2RVA0?=
 =?utf-8?B?UDNOV2hMeWQrWURSZEZ2MndEdXhqdG10VlVnMTJka3BEZ0tiaUMzd3ZBWTQ2?=
 =?utf-8?B?cXNkR3IzR1VBS2lIVzVwNDMxd1VUR3MvRVVJSFBiNkdZRHpiSjV3YUlmLzBJ?=
 =?utf-8?B?cjI3NTQ0eWZBUHJNdTlReFd0OVE3UzZZTFllTnVidElMRG5oTS9RRVQxcWRW?=
 =?utf-8?B?WnFSd2pqSDR1Z093Rlhtci91cmZDSk9NQ2NYdE9od2VnMHlDclNhV3RoQVRP?=
 =?utf-8?B?KzZaNld2bVBwaWd1VXVvTll4a0Q3d1hhdDdXNlNockxTazJDL1pGV3NHYVU4?=
 =?utf-8?B?OERGaktsTFM0NWxralYxbU9HdnpwbU85ZmxCcEV2VmdJM3lVcjk2dk0wcXZK?=
 =?utf-8?B?YzdpdHNsV0lNbmtTc0VNd2IrY3pRdkVkSG82blMwSG5nZ0xHaVJ0cmV4aVE0?=
 =?utf-8?B?RUdIZElIdCt1dHUrZXR0ZWxNT2RWNW01S2kyVkJaN2xKSmZwQjlHcmR4cCtT?=
 =?utf-8?B?cUV1MVdVSlE5WC9lSEM1Z3FiYTBNUlVWeFRmYWZTVHB5UjBxaGk2QjVvTWE0?=
 =?utf-8?B?TCs2VWV6aGhZdEpuRjVoeVp5T0JZQWxsUFgvYVZRUEgxT3h2TGRtQWJrU3lC?=
 =?utf-8?B?bzZXSUNkdTBMcFlZT0k0K0UyOFNkMWpqaFI1SGl5NDV5TEVkMDJubGY0VVVP?=
 =?utf-8?B?cjRXZ3RRZUhxVlA0ZmZMbDlmOEZjME91WEs1Y3BDUmNhRkxVei9OckFucTk4?=
 =?utf-8?B?TzltdkRad1luV2U3L1VpbDYra0NoOFpacENqb0hRL3lFUVFDaTNmTlVkRHoz?=
 =?utf-8?B?V0VkZGllVC9adDQxaEF1Z1o3dXpBRW1IQk1MaytBRkNKK1oyeXVJUWwwVHp5?=
 =?utf-8?B?dGk3cTY1L0RHeE12dncxcmY1bEpjSlpqVm1GNlNFMkhiVGtJa2R4aDVSVkVQ?=
 =?utf-8?B?QTFTSHUvUE9XMnhmMnNJcVlYbTVlcDNEaU1VcHpZT3p4UklpM3A3bUsxL2pl?=
 =?utf-8?B?RklYQ054ZUhyR3dpSEdRbldDQzNVSDQyWEdZb3c4SlJOSXhwSFRkS0ExRjFp?=
 =?utf-8?Q?Y+lufvLqlOL5LnQ3x24hmh2PUaU2vrLkS+qRFW/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf77c216-930a-4d4b-418e-08d91c939b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 20:04:14.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+2PJR/v7dqyfbcMc8mSoaHUW5T28+4UxRQ9waLial5Y7VChAbNdN3EMiYNzvhqlmjHv4y1q+IBz+L9+9lxz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5446
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gSGkgTGVlDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRha2luZyB5b3VyIHRpbWUgdG8g
cmV2aWV3IG15IGNvZGUuIEkgd2lsbCBzdGFydCB3b3JraW5nIG9uDQo+ID4gdGhlIGNvcmUgZHJp
dmVyLiBCdXQgS2NvbmZpZyBpdGVtcyB3aWxsIHN0YXkgYXMgTUZEX1JTTVVfSTJDIGFuZA0KPiA+
IE1GRF9SU01VX1NQSSBsaWtlIHRoZSBleGlzdGluZyBvbmVzDQo+ID4NCj4gPiBNRkRfTUFERVJB
X1NQSQ0KPiA+IE1GRF9NQURFUkFfSTJDDQo+IA0KPiBBbmQgTUZEX01BREVSQQ0KPiANCj4gPiBN
RkRfREE5MDUyX1NQSQ0KPiA+IE1GRF9EQTkwNTJfSTJDDQo+IA0KPiBBbmQgUE1JQ19EQTkwNTIN
Cj4gDQo+ID4gTUZEX01DMTNYWFhfU1BJDQo+ID4gTUZEX01DMTNYWFhfSTJDDQo+IA0KPiBBbmQg
TUZEX01DMTNYWFgNCj4gDQoNCkhpIExlZQ0KDQpJIHRoaW5rIEkgZG9uJ3QgbmVlZCBzZXBhcmF0
ZSBLY29uZmlnIGl0ZW0gTUZEX1JTTVUgZm9yIGNvcmUgZHJpdmVyIHNpbmNlIGNvcmUgZHJpdmVy
IGlzDQptZWFuaW5nbGVzcyB3aXRob3V0IGJ1cyB1bmRlcm5lYXRoLiBTbyBjYW4gSSBnbyB3aXRo
IHRoZSBmb2xsb3dpbmcgZXhhbXBsZQ0KDQpyc211LWkyYy1vYmpzCQkJOj0gcnNtdV9jb3JlLm8g
cnNtdV9pMmMubw0Kb2JqLSQoQ09ORklHXyBNRkRfUlNNVV9JMkMpCSs9IHJzbXUtaTJjLm8NCg0K
VGhhbmtzDQoNCk1pbg0K
