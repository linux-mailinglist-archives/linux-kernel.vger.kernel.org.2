Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8323EB2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhHMInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:43:14 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52294 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239335AbhHMInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:43:13 -0400
X-UUID: 3c632efeefa64ee19e0161ea714376cd-20210813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=matbe6wxTuqRli4YDm3gRK1X1cvs/fwwH4pFJ+/meFg=;
        b=nhLdnpXv5NFVusG361FKlNNQlIef0xBR1s6aPoGaQplnmGvhLR16g8hqwV/LVYqyvvNFlw4t+8hdqQg9w8+DhnZOxBMJ1V83tTxaitIyk3BnPs1UW5xBr/hS8HIMZoYUeVBWPJleeF9JnVtvAs9/6pBq7SNx9fBKIaSavZGxwLc=;
X-UUID: 3c632efeefa64ee19e0161ea714376cd-20210813
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1169582705; Fri, 13 Aug 2021 16:42:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 16:42:41 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 13 Aug 2021 16:42:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8zzG4FpUI80hr6q4OM2yo2QCGi4BkJgQzFuqn24crjRX4BTYJ+f1nM4CHQmbAoKIVqKxpdW7NC8fJFL2pdGc/ZqtOiNza7KIab6I7LGSbjqu5TGwlxxbq4DJ2MQd/hgKdb3bepeWY84OVMDpblKYiWTQxs3/pT/ZF2xZFidk4QfWyO1mH21QPaEOPz1RBByThHCfKEF3JPehxhJKerdNHU8PLQH6YPBNLQNbmhYbD5N4pFe0kliFYJ+dMF/VgCUeIuroo59GB3/JxgRYf/bGN5j81yR5PEwQ3eYvz/x19q/YDNUZ9M8kRSzU+MwuhnvCTK2wtDu4w1FEKC6XxHo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=matbe6wxTuqRli4YDm3gRK1X1cvs/fwwH4pFJ+/meFg=;
 b=JZ8z4hImRJGZhrPOJ52quuXbrN0w6LTXIuxUaJvuJ88aJWaJ6R+iuFIYySxwvxYLTF/FF1iVjBMPVYZ5cya/d0pcxwrqqb1BPCW4pYjuGbBYcouUDSdkTHUdY68YM+2ZCLBo4oi/oKUDO6G5cTEKXDTeLYOAG/3irfELzwL69pRuV2Ih7NCQwbKHlhK5X7D1nAypCCIV88ABy16QEMCR5mh5hQFMVShoic/BECS0GRMn2GPPi+eOH4x027STh1FswEHg/T/wGemqjHvknItnvGsw5KtTpLTTz5wb2iFTKLvbhlB8Rl1TFPo/vKe2dAZ8NfkZQMIyqjYbSd0Kc1WUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=matbe6wxTuqRli4YDm3gRK1X1cvs/fwwH4pFJ+/meFg=;
 b=bydEx5BfQmu6U1pGr8l8hBiZ+PSDdw2mXR14rb/MhonotVXcRC0Fmfm7Yu4p8JS06LoJqi4TiJguDg4Ve7FpGJHcAOrs/yxSZYzvB14oo5OmjnNklxqlDAlSflVCp7q/pSwWb++ejWI3QBNjINLbCsY4Eh0aWudgzmZ9zRKLpLs=
Received: from PS1PR03MB4908.apcprd03.prod.outlook.com (2603:1096:300:82::17)
 by PS1PR03MB3271.apcprd03.prod.outlook.com (2603:1096:803:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Fri, 13 Aug
 2021 08:42:28 +0000
Received: from PS1PR03MB4908.apcprd03.prod.outlook.com
 ([fe80::6848:1a9b:8c85:fa8f]) by PS1PR03MB4908.apcprd03.prod.outlook.com
 ([fe80::6848:1a9b:8c85:fa8f%7]) with mapi id 15.20.4436.011; Fri, 13 Aug 2021
 08:42:28 +0000
From:   =?big5?B?UnlkZXIgTGVlICin9amwv84p?= <Ryder.Lee@mediatek.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: RE: drivers/net/wireless/mediatek/mt76/mt7915/init.c:134:41: warning:
 passing argument 1 of 'thermal_cooling_device_register' discards 'const'
 qualifier from pointer target type
Thread-Topic: drivers/net/wireless/mediatek/mt76/mt7915/init.c:134:41:
 warning: passing argument 1 of 'thermal_cooling_device_register' discards
 'const' qualifier from pointer target type
Thread-Index: AQHXkBS4E7N9rvXb/ku6PAExWpniS6txHgbg
Date:   Fri, 13 Aug 2021 08:42:28 +0000
Message-ID: <PS1PR03MB49083C10BECCC3F16D41980291FA9@PS1PR03MB4908.apcprd03.prod.outlook.com>
References: <202108131536.fI3monk1-lkp@intel.com>
In-Reply-To: <202108131536.fI3monk1-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMDk1NzdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02MWNkOGE5Zi1mYzEyLTExZWItYjdlYy1mNDM5MDlkYWFmNDdcYW1lLXRlc3RcNjFjZDhhYTEtZmMxMi0xMWViLWI3ZWMtZjQzOTA5ZGFhZjQ3Ym9keS50eHQiIHN6PSI0MDkyIiB0PSIxMzI3MzMxNzc0NTU2NTAxMDYiIGg9Ikl4Z2o1ZWNvSlpGVVFPY0N6YlpRSEloM29rVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 724ffef9-f056-4e4a-8f2c-08d95e3648a4
x-ms-traffictypediagnostic: PS1PR03MB3271:
x-microsoft-antispam-prvs: <PS1PR03MB327129E20A10C299E7421EAF91FA9@PS1PR03MB3271.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6zeqoJORAxA5nMy7oNM5qiKP/xXtkjgSCtIjB/xOCrHd3LZPDPg/jc8ELsu/T9wbefcqtUnKqZ5l7QYFqT6ZmCoYeKZf92UswrOJ+x3Ry+tixocc96sXk3LirZJZPOhMoYPfYnU+L3LG74rCIBYIQQVZNERPioekETQuyk6AsD7Kwf3A8dSGr6w55mh94Xj5cqfhS3PD3+0eKJVCZLZOLSwfLlLcDpaw105o+McvKXh4aURoYLSOehWUcUN7vlkON58KbunD48w4HGCOlLWQ9kufCKPpMrAGqc30CSXy07eBshG0C/JevzH/QdVkpDGGgRQLh8HrpOtFCikqZm40fNtAW2oo8OC1CtHDhzcs7KP5X4tCAROHBcN/W0jTGsUcF6HeF2Z4hujYweXGW+wfGcJ1FUAt5N8AOJkTPvVOXiUIIVgMkUKKL/9S3PXiWnatqzZ3XBXpsf/ILfJrcYJ9QxH7qIwq6cxJn+1EOVT2YRqwg2omJNc2IwdgYAo62I9tA+EorIKyv8HaRe/7b1lzDeVQ56m2IyRJBTNxj4pJf4wizaeNkjrdmSRcXzdvnuVm2QYGEeYZ1qmoIIPrM48OP/8QH69uvY8KZM2VqSNQv+r8ru6pHSFm4hpRI0EQXK/Ql3+MPYukPpAqqU8jt7j2IMZtmtMgAzYDTrPG4cYv0YqcLmrwcX9S0kn9IlGvTg+EHs37r+JrsPccXc8xsw+HTsH5QPvoHXoKzNpqf8VoeJtUuab1qgQck3qYqQi3QpbtsCapxA9+eArXtFJ7GSk4oC5bw41KHyrjMoIf4yYbuy4+fFb6FXlW6wC7JsAe4qF0e/TsAMbIDY72Ilzzw3Rcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4908.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(4326008)(6916009)(122000001)(54906003)(26005)(2906002)(33656002)(5660300002)(8936002)(8676002)(186003)(38070700005)(478600001)(85182001)(966005)(52536014)(7696005)(55016002)(66446008)(76116006)(66476007)(66946007)(38100700002)(64756008)(66556008)(86362001)(6506007)(71200400001)(9686003)(316002)(83380400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?SElndkkwSTh3cGgwc29tUk9sMzBOL2dDRFo0NXRJSnpiQ1ZFelNTRWd2Y3lNY1dG?=
 =?big5?B?SHJ1OVlZVmJrZHdSZm55R2lqTVNYcTZwUUF0Q2d6SzJYOFRTTW5CSXAwOHAyTjgz?=
 =?big5?B?YzBCL1lpVyt6cU82SlBZWldGMWVLSmJDRGh6Smlwd1NnRlN5cVJZUDJ2WnBLZS9z?=
 =?big5?B?K3dWYWx6UnJ1SXpPY3k1NGc2WDh5MWt6em1oYjB2L1puSnVOeUUrWE5EeURDcENk?=
 =?big5?B?dXdYV3NESjNVdjlraTdrMFhYeVNLNnQrY1VXVGU2Wk1GdWV6eXhTYXBYSFRSVFJj?=
 =?big5?B?aytiaUFIQkZwSXNlVnNwUFp1d2ZyazcxWGxMSlJnVWVibmdYZ3M4RCtWZFZRTnI2?=
 =?big5?B?MEUzV1B2Umh2cnVKaGg1SkJEaWhpSHozaEFHQmhYUGZySUFkL2FweFJSOEU3Y1hx?=
 =?big5?B?TVVkUkdXZnlhdUpMT0tjWEFVQk43RG5zZjM0N0V0NFoyVjJVOStGMklVdkU5M2Fu?=
 =?big5?B?K2JMN3BjZmo2VC9NdXlyZlIxUXRydXlad256K3hEMVdsYmp5RjVyd3BqWmZIcXpW?=
 =?big5?B?UmIzMUp0WkR0MzJpaGQ3WGpDU0dnZzk0T2Y2VU5JTnNXa3ZTRFY3LzVTT2FFTkhZ?=
 =?big5?B?M21Pc2taenRDbzR0ZW81RHBGQ1FaWmxnSHZsZjJzZGJxbjJvRmFQQlI3NnBFT24x?=
 =?big5?B?NkhYOE9vV1ZxL2VhQWJwL3Q1SWQwSDAxOHREZHpLeGhHLzJwQkRNcG1FZld2aTh4?=
 =?big5?B?L3p0R2JEM0QzZVplUzdaVXA0emV2bWZFZVBOMDYwZmRnT3AzTEVra0l1MjZuUXRr?=
 =?big5?B?bmU0YVJKZjhkNzE3L3VYQ0JTdEhZRTVqb2w5T1hiVlBsRE1lWkFZTTB5bmpFQUJl?=
 =?big5?B?a2tjUm5rT240NVRVWWdMY3FVOWJDSEZxS0JINm1BbEpzWGRFNUJrcTc4bFR4eXBU?=
 =?big5?B?aWd3ZTJkVFpSeTJlU0o1RWE5Z0o1TlZ1VVlGUTNYSGtWZWUvZ2hBRnYwdnQ5aG1R?=
 =?big5?B?Q290SkhhbWovTEVvUWRhQjdEazVicGppeSs3T1lOVVJKVnpCdkZvZ1dEMEFHWTll?=
 =?big5?B?aG9XR2dYZEtqVHI4aVJ3aWRheGJOcmZRWjNDRS9BZzRQZDQrUEVPT0pEbllBdzB5?=
 =?big5?B?TWg1a0JNYVhTRUFFaDBUcGQrUmpKc05GSUtJTy9JNlhRdGV3NXBKOU9SYWk4T2RB?=
 =?big5?B?WWZadytCUHR3azROTUZHU01TYm5xKzlFeHcraDNlMmNpN095QnNmS1plSWJwTDUv?=
 =?big5?B?WjZuOUUzY0gxTGhUMm81dEMzZnJkN3h5MzdyWHJEYTRqNytCTU02SFFuazRiSGtv?=
 =?big5?B?MmU1QW5OOURLemhCbWw5cWpvTzRreElTZ3VBcFZpYTFMUENybzB4UmhwVm9NR2JK?=
 =?big5?B?ZE1YZ1FzL2psZmxZREZlTS9hK1ZEU2tZV3F3L3NZL3BkemlGZWZDYS8vNlExdjJM?=
 =?big5?B?TWM1elJLYmc3Q2hiTTQ5TnN5b0swcWFJOFZTREIxU1RtWmlzTjJ3Y3RRM3JvLzB1?=
 =?big5?B?Ums3cmFVM0k5MU11RjlYbVowNm5uRHBoNDU1TUFUbkVRdFhaZHEvS0gxdkM4SzdJ?=
 =?big5?B?R3lUOXF5UGZabXBrNEs2eVdJZ2dRSyt3dnpPOFVlWUtDWmNwWnNVMnRRQzIxRHBR?=
 =?big5?B?RDh3bk5BVTZDUXY3MmFDZ0w2T21kTlRSUGdvOEdVRERHSVpkTHlaV3NMenE2WFNU?=
 =?big5?Q?HJ18uQ2jSWQpUIY30iLgwcQ/Oqv0gmbGcFxDuDt1iA+aMUSr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4908.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724ffef9-f056-4e4a-8f2c-08d95e3648a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 08:42:28.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjkQJRyU2dmVUj+3YQC3AOmVUUJKyffBGVf3HNUTfNxEXKmyXElwuAwo17pJFQRX9ykPvKjSObHxLMfVQ/ePyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR03MB3271
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGUgY2F1c2UgaXMgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9BQkRBRkNBQi04REY1
LTQxQTctQjFFMC00OTUzQTlCRjMyQjNAZ21haWwuY29tL1QvDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IGtlcm5lbCB0ZXN0IHJvYm90IFttYWlsdG86bGtwQGludGVsLmNv
bV0gDQpTZW50OiBGcmlkYXksIEF1Z3VzdCAxMywgMjAyMSAxMjoyMCBBTQ0KVG86IFJ5ZGVyIExl
ZSA8UnlkZXIuTGVlQG1lZGlhdGVrLmNvbT4NCkNjOiBrYnVpbGQtYWxsQGxpc3RzLjAxLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1l
Pg0KU3ViamVjdDogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5p
dC5jOjEzNDo0MTogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAxIG9mICd0aGVybWFsX2Nvb2xp
bmdfZGV2aWNlX3JlZ2lzdGVyJyBkaXNjYXJkcyAnY29uc3QnIHF1YWxpZmllciBmcm9tIHBvaW50
ZXIgdGFyZ2V0IHR5cGUNCg0KSGkgUnlkZXIsDQoNCkZZSSwgdGhlIGVycm9yL3dhcm5pbmcgc3Rp
bGwgcmVtYWlucy4NCg0KdHJlZTogICBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0X187ISFDVFJOS0E5d01nMEFSYnchMXlHaHlaMnpjZ0RTQVpJbnlGQ3BUV1FxN3dtMEtLN013
b1lXS0VNRV9EcmF5ZmNZZnhoNGk5ZG51ZlZOOUMtYyQgIG1hc3Rlcg0KaGVhZDogICBmOGU2ZGZj
NjRmNjEzNWQxYjZjNTIxNWMxNGNkMzBiOWI2MGEwMDA4DQpjb21taXQ6IDM0Yjg3N2Q5NzJiZWM4
Y2JmMzk3YTU3MzkzMzE3NjcyY2Y5Mjk5NmYgbXQ3NjogbXQ3OTE1OiBhZGQgdGhlcm1hbCBjb29s
aW5nIGRldmljZSBzdXBwb3J0DQpkYXRlOiAgIDggd2Vla3MgYWdvDQpjb25maWc6IHg4Nl82NC1i
dWlsZG9ubHktcmFuZGNvbmZpZy1yMDAxLTIwMjEwODEyIChhdHRhY2hlZCBhcyAuY29uZmlnKQ0K
Y29tcGlsZXI6IGdjYy05IChEZWJpYW4gOS4zLjAtMjIpIDkuMy4wDQpyZXByb2R1Y2UgKHRoaXMg
aXMgYSBXPTEgYnVpbGQpOg0KICAgICAgICAjIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvY29tbWl0Lz9pZD0zNGI4NzdkOTcyYmVjOGNiZjM5N2E1NzM5MzMxNzY3MmNmOTI5
OTZmX187ISFDVFJOS0E5d01nMEFSYnchMXlHaHlaMnpjZ0RTQVpJbnlGQ3BUV1FxN3dtMEtLN013
b1lXS0VNRV9EcmF5ZmNZZnhoNGk5ZG51ZVlsbWpkSyQgDQogICAgICAgIGdpdCByZW1vdGUgYWRk
IGxpbnVzIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXRfXzshIUNUUk5LQTl3
TWcwQVJidyExeUdoeVoyemNnRFNBWklueUZDcFRXUXE3d20wS0s3TXdvWVdLRU1FX0RyYXlmY1lm
eGg0aTlkbnVmVk45Qy1jJCANCiAgICAgICAgZ2l0IGZldGNoIC0tbm8tdGFncyBsaW51cyBtYXN0
ZXINCiAgICAgICAgZ2l0IGNoZWNrb3V0IDM0Yjg3N2Q5NzJiZWM4Y2JmMzk3YTU3MzkzMzE3Njcy
Y2Y5Mjk5NmYNCiAgICAgICAgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4IGJ1
aWxkIHRyZWUNCiAgICAgICAgbWFrZSBXPTEgQVJDSD14ODZfNjQgDQoNCklmIHlvdSBmaXggdGhl
IGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcgYXMgYXBwcm9wcmlhdGUNClJlcG9ydGVk
LWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCg0KQWxsIHdhcm5pbmdzIChu
ZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQoNCiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L2luaXQuYzogSW4gZnVuY3Rpb24gJ210NzkxNV90aGVybWFsX2luaXQn
Og0KPj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jOjEz
NDo0MTogd2FybmluZzogDQo+PiBwYXNzaW5nIGFyZ3VtZW50IDEgb2YgJ3RoZXJtYWxfY29vbGlu
Z19kZXZpY2VfcmVnaXN0ZXInIGRpc2NhcmRzIA0KPj4gJ2NvbnN0JyBxdWFsaWZpZXIgZnJvbSBw
b2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQ0KICAgICAxMzQgfCAg
Y2RldiA9IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIod2lwaHlfbmFtZSh3aXBoeSks
IHBoeSwNCiAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+DQogICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jOjc6DQogICBpbmNsdWRlL2xpbnV4
L3RoZXJtYWwuaDo0MDc6Mzk6IG5vdGU6IGV4cGVjdGVkICdjaGFyIConIGJ1dCBhcmd1bWVudCBp
cyBvZiB0eXBlICdjb25zdCBjaGFyIConDQogICAgIDQwNyB8IHRoZXJtYWxfY29vbGluZ19kZXZp
Y2VfcmVnaXN0ZXIoY2hhciAqdHlwZSwgdm9pZCAqZGV2ZGF0YSwNCiAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5efn5+DQoNCg0KdmltICsxMzQgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQoNCiAgIDEyNwkNCiAg
IDEyOAlzdGF0aWMgaW50IG10NzkxNV90aGVybWFsX2luaXQoc3RydWN0IG10NzkxNV9waHkgKnBo
eSkNCiAgIDEyOQl7DQogICAxMzAJCXN0cnVjdCB3aXBoeSAqd2lwaHkgPSBwaHktPm10NzYtPmh3
LT53aXBoeTsNCiAgIDEzMQkJc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXY7DQog
ICAxMzIJCXN0cnVjdCBkZXZpY2UgKmh3bW9uOw0KICAgMTMzCQ0KID4gMTM0CQljZGV2ID0gdGhl
cm1hbF9jb29saW5nX2RldmljZV9yZWdpc3Rlcih3aXBoeV9uYW1lKHdpcGh5KSwgcGh5LA0KICAg
MTM1CQkJCQkJICAgICAgICZtdDc5MTVfdGhlcm1hbF9vcHMpOw0KICAgMTM2CQlpZiAoIUlTX0VS
UihjZGV2KSkgew0KICAgMTM3CQkJaWYgKHN5c2ZzX2NyZWF0ZV9saW5rKCZ3aXBoeS0+ZGV2Lmtv
YmosICZjZGV2LT5kZXZpY2Uua29iaiwNCiAgIDEzOAkJCQkJICAgICAgImNvb2xpbmdfZGV2aWNl
IikgPCAwKQ0KICAgMTM5CQkJCXRoZXJtYWxfY29vbGluZ19kZXZpY2VfdW5yZWdpc3RlcihjZGV2
KTsNCiAgIDE0MAkJCWVsc2UNCiAgIDE0MQkJCQlwaHktPmNkZXYgPSBjZGV2Ow0KICAgMTQyCQl9
DQogICAxNDMJDQogICAxNDQJCWlmICghSVNfUkVBQ0hBQkxFKENPTkZJR19IV01PTikpDQogICAx
NDUJCQlyZXR1cm4gMDsNCiAgIDE0NgkNCiAgIDE0NwkJaHdtb24gPSBkZXZtX2h3bW9uX2Rldmlj
ZV9yZWdpc3Rlcl93aXRoX2dyb3Vwcygmd2lwaHktPmRldiwNCiAgIDE0OAkJCQkJCQkgICAgICAg
d2lwaHlfbmFtZSh3aXBoeSksIHBoeSwNCiAgIDE0OQkJCQkJCQkgICAgICAgbXQ3OTE1X2h3bW9u
X2dyb3Vwcyk7DQogICAxNTAJCWlmIChJU19FUlIoaHdtb24pKQ0KICAgMTUxCQkJcmV0dXJuIFBU
Ul9FUlIoaHdtb24pOw0KICAgMTUyCQ0KICAgMTUzCQlyZXR1cm4gMDsNCiAgIDE1NAl9DQogICAx
NTUJDQoNCi0tLQ0KMC1EQVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZSwgSW50ZWwgQ29ycG9yYXRp
b24gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGlzdHMuMDEub3JnL2h5cGVy
a2l0dHkvbGlzdC9rYnVpbGQtYWxsQGxpc3RzLjAxLm9yZ19fOyEhQ1RSTktBOXdNZzBBUmJ3ITF5
R2h5WjJ6Y2dEU0FaSW55RkNwVFdRcTd3bTBLSzdNd29ZV0tFTUVfRHJheWZjWWZ4aDRpOWRudVY5
RGIzaGQkIA0K
