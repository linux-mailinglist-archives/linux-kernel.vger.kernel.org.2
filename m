Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F63909B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEYThY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:37:24 -0400
Received: from mail-eopbgr1410102.outbound.protection.outlook.com ([40.107.141.102]:30396
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230404AbhEYThX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:37:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSvXpP75tDt+GajOmxSzoh+Byi+rhFNwlznQhC7ErKO+jN23xNDtwDmYpctIM5LslNPVV/6r2Jp8dffvovxNhu3mZkDc+z4IG7zA7CnOb96XwAmeM+7Wcv47PLU/zt8ZJrnGmh9Nw3971OgnX9YiOyAySGxGU2o5pFWNFLvquHOHCvdbo4g4DoNAa0ZEgr1pDNAcsPTSnkqyCYmA2lhbohpEJmFtBKEqFgJYSCRANcbQCj+s8NwkmfdXQnR74c0CrtbJBQMBVovkVZ48gSqDwajwj+/b+IW5OY4bUAFzcmJLCSAfszBlRr94VcbWltLyajPIM57JQDiaBjv3ZM57QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgKzfcAp7jtpzVyxSSh4bsTgTCOA6D1NLCcHpfsdbnc=;
 b=Vbf4auOvwEA89wwcpBZNod2A1XY5BgAldLrdjkKU6cTpYq9wyxm6tRBd8vMhhNWa4A2j0Gg0RfS5u2n0p/MiIZ4+Mtjr9s6nPYje0qOi4iqOmDP7SkSiaXaCxrBOD7kB8Q3gn7Ieo08rxPhIcA8yX49dbBKkf0qQky1mTtjKurmUdhZK2bxrGMPVrmSzacTFYHqS/Ud3tR85FXmrAn831BZ9i2TV8zhRXLTEqHZybijFztlxc3ZWkUcSTAX5VjIR4X5YEuJaD8dunomu3JCV0JCLQ0xS7VlUCaFUlNxLVQFrVUrTLZv0AqYZaNK9BtdF+goKhEH43zAjjHrAw4DuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgKzfcAp7jtpzVyxSSh4bsTgTCOA6D1NLCcHpfsdbnc=;
 b=RJSR385eo/Kiw+TdrD0rNdmK8mukTdVAdN8Jjg7xwpEiv2YxkJnJ2Lr9BQ16GUIReoBXptpwTNdReA+lfCSQl56ghmt8wzY86xffKFETpF5DJSJv/VOa8R2jjO4ryCHGbVTVtupgtznQG1un51Ky3iNhSlAGcbBryTZ19s6/zGI=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSBPR01MB4136.jpnprd01.prod.outlook.com (2603:1096:604:2f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:35:51 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:35:51 +0000
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
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rqloqAgAnkEuCAADXEgIAAEOBw
Date:   Tue, 25 May 2021 19:35:50 +0000
Message-ID: <OS3PR01MB65931F0244E7D2CE6FCB4080BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
 <OS3PR01MB6593170DE2814540F6C3F900BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <20210525182311.GE4005783@dell>
In-Reply-To: <20210525182311.GE4005783@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [173.195.53.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a7cd2dc-fc64-4e01-2ac8-08d91fb44dd6
x-ms-traffictypediagnostic: OSBPR01MB4136:
x-microsoft-antispam-prvs: <OSBPR01MB413637B9FCA7F0C33A745235BA259@OSBPR01MB4136.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vGFdBedy9JPmHSchCHDZ29QvSOY0h4TbzVDatL+efsxVHY41VKmX9XM2Z3N2O6oPdndjG9Rx3UDnAGnpOYYS1Qfr+n7VN/PElB+ubdGh3kNfi+p/qVF5cxMI7yfZ3aPRNRN6LH4419mP/GBNQmcFqt64fixvCCT39SWk6iN3GgfGVa0A87E2/5diI74CfiCT1oQeUCF7o22xwix4ZVmSHaBet6Gr2f3TgR+ETZPeVQdO0ZR/B9sJcuozljQsnnGoQiA30ONun6wAhUSiEinqg5l2h2O9FcXK5yXbLAXVNRXsTdxh4U1p/vybBbhFLYvlRw7mU/j/KlzQwoH1o4FZyYmEILJywoHPdhMr8V5CgbQvKHIBOwDYH5HQkFq8fkpVB6x0N+XYbUGrc6uBNjpC4UvtC55iovjP2NheQWFJEgwVVizi0VjVBK42Uqx28ssSydCYk4/NUzVwqj6GaqD9D1UW4xHtg1gEc+fEsEmtHKqbDG/Lh3AlHHO0PqZesehI2LQRmyk+2U9CAWpAk41QHQxA+ZUBHduqMAaOo8UIDlnq6uUhD542TAFlDTJORoMhUGOJbVn2V2OVDe6VDmGx2HjPCHxA4Xvgkm/Otr9WRs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(66476007)(86362001)(558084003)(8676002)(7696005)(186003)(66946007)(52536014)(478600001)(9686003)(66556008)(122000001)(38100700002)(66446008)(8936002)(26005)(6916009)(2906002)(4326008)(5660300002)(54906003)(33656002)(71200400001)(55016002)(6506007)(316002)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WlJCeXI1aXFDejllZTAvSE5Gb09mSmNzSys2ZEdpV3hlbnpLVVRTbGwyUnM5?=
 =?utf-8?B?NklDRG9pb3pwa3NjUGlvSEJ6c21aenllM0ViMTNmMlBwdzNJdzZ2MzRDNmlG?=
 =?utf-8?B?TUFTOURLTUh1YkdsZ1NpZEQrVWppR1l4ckFBSy9makV6N2ZqMzhZdG1xeXZz?=
 =?utf-8?B?M21uWGpmVkxNb1BXbStVVGNsRzcxVExxbllZc2VkZlZ6RjRqSUhUaWdCQnRV?=
 =?utf-8?B?cXJQVnovOHFaNG1DbHRkVlEzYitsdGpQcmpRYzlDRVJST3lBR1NOaE9zaUNN?=
 =?utf-8?B?ZENKbmVaL1RZOHBsdVdOY2ZoclZyOVBuckdic2doWEpHM2RqRjd5YmlEOE0w?=
 =?utf-8?B?elMyNVlKdGs0bFpGWjFxQVdMMDFnbnpHdER1UHBubkk0U1JXNS9FTGx0T3Vy?=
 =?utf-8?B?Q29VU0NoUGtFQ0VXK3VtaVgzSkdCN2xIbXNmQXc3NlpTNHhJdUhPaUtuRHAx?=
 =?utf-8?B?dXdFV0J0Y1E5d1BsdTdGZktUaE9MWUJUbFJPaEJ0RG0rQ3pZbmpYL2lpUE9U?=
 =?utf-8?B?N2QwaDJkcWtMclNLMHZvTHMyS29EUGVLSWp4MkxJclhlRW1yTGpORUc1SFdk?=
 =?utf-8?B?Y3E2dm5zWmZnNm94R0dFOVhoalEvYmQyUUNYM2VwdmNJUzFtRWF4VWhvREVz?=
 =?utf-8?B?YlVTTmdyam1MVFlNdEgycTF4QTFWWWlKZUs5eFIrQncvMWFGVEgrbnc2T21R?=
 =?utf-8?B?cTFQV3c0ZlRFdWJlNFBZeEMrWlNNaDZvWEdlNXFJYVlBRm44eXM2Rnp0Z1F0?=
 =?utf-8?B?dmpicG12eEdwTDZvV1gyOUxtdG5EdHNKTVRzSXhIU3Jvc3JwM0EwV2tWa0hx?=
 =?utf-8?B?ckNvYjdrZzNIUzh2QnRYcmZYdkNXN0VRcFgzM2NNOEFZWE54UGNTZldvaVM4?=
 =?utf-8?B?VFpDOVdPdVNQU0JhOHNHMlorRGY2ZG10UE1kQU9yb0FENWNUN2FpMGpUQmJj?=
 =?utf-8?B?ZEJ2WkF5Mm14UzZVamdYSFBYY1ZLUXdqQmNuR3JiSXpKY3o0NTh1eW1JMTM0?=
 =?utf-8?B?Q04xdE9JcEx5eGw0QkJSalduSTkzY1ozdkNCeVNHUVNRL0kyZ2J2VnZ1WHB6?=
 =?utf-8?B?bVBlWVN6NElZRi93YnVXRmRRNEc5NXJ5TC8rMllRbFJ2LzZueEhJL2k2YXpp?=
 =?utf-8?B?d0J5U25STFNlUnVvWmlGK3RpdEI4QUdlTlh0V01sM1NhYXRaU3dFTEVBQVE3?=
 =?utf-8?B?ZkZuRXkyV01OUXl1UHNUaWx0U1FKclZ0bjVYaGJ0UkVBcWMzS3NGWDUvRUV3?=
 =?utf-8?B?MG9qTk1GYnM5SjBabEZuSnlSVGdFNnpoL1h5eHJOOGFFM0ppVThYbmFCeDNs?=
 =?utf-8?B?L1E4cUg3TGxiRWhIUVVDM0FGT3E3UjVkVW9hSllaUU1Mam5LSG9XS2VaNStk?=
 =?utf-8?B?MDFPNlBNUlhhZlJRTzFmS2xtUjZPMVJ5VGpheG5OQ29FTDJkZFg3R2tQbU9G?=
 =?utf-8?B?Z2s2a2dXSDVtRG1EMk9vemhFR1hyUk9qcDlYZ2hMMUVxWjl6aFB4QU1iREgv?=
 =?utf-8?B?cU5qa2dYV3kxVGg3ZHMrajVuYTkxS2d2bEpyWFAzaVJQR3VZc0c0a1VieTJO?=
 =?utf-8?B?TklaaUk3RXRTT1pkSlZUc3lCbUd1SVp4MnZzaHJmdEc3aVBFS3l5RWoyRXZU?=
 =?utf-8?B?MkVyM2YyaG8vakc3a09LV0VxalV6MzZvaTQxeUVmQkpZakptRHE2SzJLN01Q?=
 =?utf-8?B?TVpESkVQakNudU5XMTUvQnEwZVc1ZjlKTDYwdnpneGxLeVJTaFhIMTNnUFhO?=
 =?utf-8?Q?rft3zgvln7n94UJupsCTHLAfJulpwd+poiE05IW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7cd2dc-fc64-4e01-2ac8-08d91fb44dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 19:35:50.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 042JCFR3xCr5y18V5BFo4in/Oh2jJJZLNZKODKJ0Yo+RauUonq+xhNkI6gLsDc0TKVTktA8kroPx2snnUN1Y9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4136
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBXaHkgZG8geW91IG5lZWQgdG8gdHJhY2sgaG93IG1hbnkgdGhlcmUgYXJlPw0KPiANCj4g
V2UgZG9uJ3QgdXN1YWxseSBkbyB0aGF0IGF0IGFsbC4NCj4NCg0KSXQgaXMgdXNlZCB0byBpbmRl
eCB0aGUgbWZkX2NlbGwgYXJyYXksIHJzbXVfY2RldltSU01VX01BWF9NRkRfREVWXQ0KIA0KVGhl
IGluZGV4IGlzIGFsc28gdXNlZCB0byBlbnVtZXJhdGUgdGhlIHJzbXUgY2hhcmFjdGVyIGRldmlj
ZSwgc2F5IC9kZXYvcnNtdVswLzEvMi8zXQ0KDQpNaW4NCg==
