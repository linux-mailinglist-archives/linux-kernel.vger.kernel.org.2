Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F43365389
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhDTHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:51:53 -0400
Received: from mail-eopbgr1410053.outbound.protection.outlook.com ([40.107.141.53]:46028
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229475AbhDTHvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:51:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5SqT0ETY1qeGsmztrJn055bxZKf5eedhVed+1SMhKQwH7YZaupU6cDYqX2wYhpGXBtOugmREpPpiJuesfvV7D7r7j23vmT2RLQg6Z+bEXbPgXE07X8wGsTcXqMk/tHWBA1gLYSGJODwNqa11Pjkdsi7RWCHP/a6dweAy2k48Zks4DVqoNRp+YOkOc5IfQLrfV/atLZRrv3jBnnnZFeDBuGjdpe9u7hrmkuHVkR1F/u9gzXztpnzsWuLDfYZff2f+fi4s47JOchpZOqlgf0f4acYQnqEwgMVij91fAxWrcITHs/b2WoGUcBLtz6BrlIcumBGX4sxasa/vuHi37t5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFEWREvh+FVf+6zHGD0PXcTlpTLiuVRFqDynkSBOwQM=;
 b=d9UZ09g+CyA7zoKstX9au9Tc6OgRdYMhKsjxNgx7gWINVdwkWUaQoqg1ohYinAoJAPI59peFbOO8C/wa7yErPRXWRo9k8b5/JPUfGH9WHOhnJGJ3ZjUrU71HHYbirAkojBrFXfoH4sI6BSlTl76OR8CrDnXIBLmqRsdHzMsmQ6sReA8+2HFdHV6WKuxHFwkj9FbDRwzyCMR0VPlFam2OOD55WRKMX4sHOAIRMsl/qSJYry8mpcL53navyhvYZ+mo8FhHM6XbDylFNRSwaIldF6wDKCxWNWFNvN2e3JpYeNYW6P1ydfqnnXZFBFFbrB/lXYNBIZFK0RU/E2indevUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFEWREvh+FVf+6zHGD0PXcTlpTLiuVRFqDynkSBOwQM=;
 b=gsVxCOEk9Joz7czMIp1aikiCLLoo7y5Tg5Aqv/PNNcW+HhnYVyT0nOKEGOpR1KV2uUGj6OdITZwjdcAUG0xn3cICyDAhUuWKPgf1T/sD3E+nmK0uF/RkFcxhkp9Rrd6juDm17iuIFWXBsvJBrwVnSfCAyPMpGV5UqiHnmDcD8FI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5344.jpnprd01.prod.outlook.com (2603:1096:404:802f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 07:51:19 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 07:51:19 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Jue Wang <juew@google.com>
CC:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "david@redhat.com" <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "yaoaili@kingsoft.com" <yaoaili@kingsoft.com>
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Topic: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Index: AQHXNYdoX4FIkyH7hUy4oJlfZBfW8aq9CNUA
Date:   Tue, 20 Apr 2021 07:51:19 +0000
Message-ID: <20210420075118.GB24451@hori.linux.bs1.fc.nec.co.jp>
References: <CAPcxDJ6OAd=qdfxoTQ4cp5vQ6_+phWqX8gJfec48XyAZybBpsw@mail.gmail.com>
In-Reply-To: <CAPcxDJ6OAd=qdfxoTQ4cp5vQ6_+phWqX8gJfec48XyAZybBpsw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee5fc4c2-cff6-4a7a-9976-08d903d115a9
x-ms-traffictypediagnostic: TYBPR01MB5344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB53442EFC564B5F8AF6F92399E7489@TYBPR01MB5344.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pu8pnG7Me7nqB38zEt1573Kedw9DGEGpM8EsD5BefwQwBGx4Tnymd+Ov8jVob5GMG2D6omIkvsKtaS4GFHqaG+E/kfuhzx9qAFZuHxOoEtCq3ByKSaPNBQ5TzBNudImzY0MPBHbbDL9+lNaKhX91vO+SkBIRBdLDwvJH6rI1vRvUYLSQut+vTNs2YLnFcqFnwS8PSNM1600zhryr/cUAjMXj6Fd33E12+tUzM88ukNtbhULrZUfFvK2SCP5jlloQg6Y+IkTX5GzKpoK78GX8cgBLonwU5il1QV9868wiUTWoRAL8mrVRQl5a2rZWR1HVg+Uj1hePDIwxCdNdkC9lSCFAXngwmAhy0K4RqcuZmIZTSWD9wQ/+3peCoXlZ8FkzF4kkVds2peptcerkoEycFNZ4+dv7dKWM5/BGqURFHRREKQS840ahTH5TQ5pVK5YEd3XF7SUoLcacHAOdGLzg9W74EY8tbBAGczTu2qmMn7ewBNdKhWYTtxGTZnUtJuLhySD6yyOJEtwTi7USCyO/hN9Ams+35EL5Gpoydvss5CLVY4jDRfAHuFDUFGpavLINBLJsXzrTk30BejcKKwgwkTdLUIMoyqa8JEydSmpnGNIK+YjAETpzZnT1TZ5v3HO3accD3LonPwWJ3/u4YIy6MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(122000001)(8936002)(83380400001)(6506007)(1076003)(86362001)(6512007)(7416002)(9686003)(54906003)(38100700002)(316002)(4326008)(2906002)(76116006)(85182001)(55236004)(26005)(64756008)(66556008)(66946007)(66476007)(6486002)(71200400001)(4744005)(478600001)(66446008)(8676002)(5660300002)(186003)(6916009)(33656002)(37363001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MlFYT1FxMW1wOUkwYkZNd2RZSmJTVDdlQnE1MVVtMWVLaFkySHNaTHhqb1d6?=
 =?utf-8?B?bnQ1YldkNDZKOTNxek5qdzhsbTJ0UUZzdHN6QURiZUdZRUs5bnUyOEZEWnJE?=
 =?utf-8?B?Z3RJQTUxbm5oY2xKREorb25RMkZDbmJqYndueHprZWx5YTNFa2FMWlI1TjRx?=
 =?utf-8?B?L3IzZUFsWUV0ZTBmbDBEckVuL0VqdjZRMkM4TnUvWTR4UDdOYXVJR0NvMkt5?=
 =?utf-8?B?ZnBoSkVLakNxajZ0dmY1QjIwVDhOZHAvQkoycy8rdWM3bjNUZWI1TDZsNUFU?=
 =?utf-8?B?dFR6MkFubmh3SVpheTVXcnNTM01jdXhRenhzbTRmM09XSVMzUndybHV3WTZx?=
 =?utf-8?B?dWRJemt0M2hjRHRRc3hCamZHNm1yQVY2V0lzTHc3eVlsSkhhbVBnbUdiazVY?=
 =?utf-8?B?dlUvUDJYL1VmY3VUOExTYmwzNGJVUkN3UVZESGZlNTNrSjdOZGFIaHlXWDRi?=
 =?utf-8?B?WWtjS3ZjL3RzaTV0YWtNN09mbXZCMXc5WXFpc2ZkZjJ1OHVLM3A0TU1OYjgz?=
 =?utf-8?B?OVJjV2lDNndhdUZxYnRnbVlnQ29WUDZXaFpwMndVaTY5RGpROXZZN0Q5ZXFD?=
 =?utf-8?B?MnN0LzdCaGhqc0RvNE9ZUHZBNEUzUjNxRmpNMEw5R2JHVkNUZ0J2SWFUR1lR?=
 =?utf-8?B?aEY2bk1tdzJHYlJLbjZJN0J1MkN4aDRLSVRsV0ZqT24wbHNGeUREZUgvTmlG?=
 =?utf-8?B?dlJqd1EvYVNsTVZIWEk1d2o5SkFwVEIvM3pCekgvbFF0U2I0OU1HQ01nbFhR?=
 =?utf-8?B?NzJ0c0tZYm14U1FHY2FsNENydm1jcTUyelV0Tm5pS214NEtjTUU0NURPU2ha?=
 =?utf-8?B?VzcydmNKalNCQlRtNnNybFViVUYxbjNRODlCTE8rdk5qVVEzbzZ6eERWU0Ft?=
 =?utf-8?B?eFFHKzZSUm1hSWx1T29aNWhGVU1tSS82VktHTUZBcUNkU0VQT2Y4S1hTbGk1?=
 =?utf-8?B?TjRqaU00U21pd2FyZnpJQXRmYTBvSWxUOXNqNWJKcmt3VkU2b1R0dXRndjRx?=
 =?utf-8?B?NHN4ZEtBRmZ0YXlMK1JTNms0NE5tOENYZzMydkpBVjVyUFQwKzJpLzF2Y0Ri?=
 =?utf-8?B?T09hMnFRaWRURlRMNDRpUDZCTGM4YmdnMUtVUGF5VVBEeE9pNWY2WHliL0dK?=
 =?utf-8?B?MFZJNjUyM0lFOEt4V1BiMGZZUTBaRFp1YXV5WmZOdHZGMHdHZjFnMUFqcEI1?=
 =?utf-8?B?ajdSNmFBRndIVm5MOW5ybHZxYVhVaitudEFNNGlkUlZ2VHdVRk1TZkxTTm11?=
 =?utf-8?B?Q1NvNnFaUkRGUWxMUk5vUUJURHlyUlBmN1ZjTzB6R2tWa0Nra0F6S3FCUnBp?=
 =?utf-8?B?N0VVRXZJRHdtY1J3c0VWdENrT3BkeE9lMHRNejFJNENPOG5NcE5hT0Zpck5i?=
 =?utf-8?B?Njl5WWxKMmZoY1c1dDlNU3BOQ1Yyd1N3QTFPd2Y3Wm1rNFRBTUl0UkZ2NU5N?=
 =?utf-8?B?MSsxZCszcnprb2gydkdTMVVZNWoyakY2cFdGV0tkeTF4RFg1SWpyc29nMmlC?=
 =?utf-8?B?czFVSDR6bGY4TFovRW1lU1oycmtqTUxhV1lHcFdkNEY1YlkzelZ4TWx6M1cx?=
 =?utf-8?B?OHViUEVjWFhoOVZOK2RvNDRMSGFxdnVYZHAxdlh0RjhVRmx6OXFwTkNyVjNh?=
 =?utf-8?B?b2RFZzVOZ1lYVE1EdjhpaW1IZmNpNGxJUE9jZ2JwdG9KNjJVNjR3cHJBUUdr?=
 =?utf-8?B?Y2g2NzRoOHladzVFQzJIZmp0bm5jYlhyT0d2VUR0NlF3OUhNd1QzM3dkOU9r?=
 =?utf-8?B?ZG9UaUkzalV2S2RBVTZzZnZSRDZSMWMwM1hwVzRweENRRzY5aVI3MDJIL1Ft?=
 =?utf-8?B?VUVEdTRvK2lQL0F1WE0rUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09A701AA764B64EBFE07073A1400108@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5fc4c2-cff6-4a7a-9976-08d903d115a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 07:51:19.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4/wuiPsEXX/dRAqxkZp/je+pVG90PspDW34gucZy4Hdaso+l17OfeBRI+2c0y1MpyKHdmvgLCcXmEQobyrKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTksIDIwMjEgYXQgMDY6NDk6MTVQTSAtMDcwMCwgSnVlIFdhbmcgd3JvdGU6
DQo+IE9uIFR1ZSwgMTMgQXByIDIwMjEgMDc6NDM6MjAgKzA5MDAsIE5hb3lhIEhvcmlndWNoaSB3
cm90ZToNCj4gLi4uDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgaW50ZW5kZWQgdG8gaGFuZGxl
ICJBY3Rpb24gUmVxdWlyZWQiIE1DRXMgb24gYWxyZWFkeQ0KPiA+ICsgKiBoYXJkd2FyZSBwb2lz
b25lZCBwYWdlcy4gVGhleSBjb3VsZCBoYXBwZW4sIGZvciBleGFtcGxlLCB3aGVuDQo+ID4gKyAq
IG1lbW9yeV9mYWlsdXJlKCkgZmFpbGVkIHRvIHVubWFwIHRoZSBlcnJvciBwYWdlIGF0IHRoZSBm
aXJzdCBjYWxsLCBvcg0KPiA+ICsgKiB3aGVuIG11bHRpcGxlIEFjdGlvbiBPcHRpb25hbCBNQ0Ug
ZXZlbnRzIHJhY2VzIG9uIGRpZmZlcmVudCBDUFVzIHdpdGgNCj4gPiArICogTG9jYWwgTUNFIGVu
YWJsZWQuDQo+IA0KPiArVG9ueSBMdWNrDQo+IA0KPiBIZXkgVG9ueSwgSSB0aG91Z2h0IFNSQU8g
TUNFcyBhcmUgYnJvYWRjYXN0ZWQgdG8gYWxsIGNvcmVzIGluIHRoZSBzeXN0ZW0NCj4gYXMgdGhl
eSBjb21lIHdpdGhvdXQgYW4gZXhlY3V0aW9uIGNvbnRleHQsIGlzIGl0IGNvcnJlY3Q/DQo+IA0K
PiBJZiBZZXMsIE5hb3lhLCBJIHRoaW5rIHdlIG1pZ2h0IHdhbnQgdG8gcmVtb3ZlIHRoZSBjb21t
ZW50cyBhYm91dCB0aGUNCj4gIm11bHRpcGxlIEFjdGlvbiBPcHRpb25hbCBNQ0UgcmFjaW5nIiBw
YXJ0Lg0KDQpIaSBKdWUsDQoNCkkganVzdCB3cm90ZSBhIG1pc3Rha2UgYW5kIEkgbWVhbnQgIndo
ZW4gbXVsdGlwbGUgQWN0aW9uIFJlcXVpcmVkIE1DRSBldmVudHMgcmFjZXMgLi4uIi4NClNvcnJ5
IGFuZCB0aGFuayB5b3UgZm9yIGZpbmRpbmcgaXQuICBUaGlzIHdpbGwgYmUgZml4ZWQgaW4gdGhl
IGxhdGVyIHZlcnNpb25zLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
