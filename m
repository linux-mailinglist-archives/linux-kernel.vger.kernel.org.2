Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417B7390A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhEYT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:58:24 -0400
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:57614 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEYT6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1621972613; x=1622577413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IUmhv0YIR4zpj/HmKQg/SUTS9sJap0MB3HJy+zBawXQ=;
  b=vVQGHzQpkfvGR99647iojgoJKP0sSRjJMoiSLMG+3PgIgwZTHZI4PqHh
   bG4QUqV7ABX3dC0DGTuAIZMxL2RZ7bcMZC+agUEFj3QXQsXiclo55PHZN
   85i6uB7/CwswACm4zaTOZwnpbljXqUepWmAfGkCn2p3B7xL8JjF8m+Hnh
   0=;
IronPort-SDR: O7+s4DdiPlJSiVIG29L8Ny+oFzM8/frOWsGPnz92steGBQl4A8QYy/AELGiNIBzSmCJZgdFGzD
 BbrVJ9bNOYKCJHolxCVRj3U2j3rRz9GIXXWnzrbYBK8VoW2Lnk2pOev6l+dshukzQXe6Gt2yEh
 9l8DM/4+0SCpjaa682W/mYhN1+Thi4gxHXkWcYdG+XRr+1UDEznk4f1PsGWRKLA9iRZicoEbVv
 2Tnd3T+hC25bCC8ZtKhYr9CQGH6MgtepC5mYavNeg0VqqoPOh/hIvW1INwa5cfpIaX/57jSGTt
 ZiI=
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 19:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LW+2ophzR4/tFv4qwo4FNp+Lhi6BnNP771UW9Krya9Gd/P0U6WMqZjFZHdpZZZIAJH7BYBPddEz5oh26iFR6IIrsQ+ITqmpFrnLKwL3hdC1xDsVXrPyxIKWLq38S02JCMcRtoWnXBoL2zwxyMdW0QgFpHIvTZl0DYUst5NaGV+jZHri7wwGiAwHGWwbNpfEg2ekE70xPscmKU3Owdjqca+djlyKJ0jD99AUL7SluOJa0SqRfoLE6wleDTNViWUP1wXU7a2ft8wSKCpym7lePeHy8+iopqO4igQ+3G+xx/i2TN1XDVSvpWmG1qu4ZQKvIkrTII3pJfpI15OVL3Aa9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUmhv0YIR4zpj/HmKQg/SUTS9sJap0MB3HJy+zBawXQ=;
 b=BQ7i2VRUqSSC+vc3/dEFtH8P/dwIe4GvGUGGWZjU1LJIBHVjPL5cV41DTdCZvcbmgNPA6pNOEEIU/9hYxM2+I23xZZuUsBdj8DL6Uet37EAV1CDfHdjzWJnOj1KHG+NAwb6RzVPKeiMTwz51IX0OF7dxO8SBhcuIdCLK/dUt8azV7eJDs5za0koxiMhg5mNEhTN5JQGL+FhtJOvONWLFN/9uXSSpxC9iX/gI4gj3OVe6xJk44szVxzHKrZA4JJXUJqYhJirqcSISwRgvg0x8VCiZlJKg4xdN2HXopkPZizEn3GQDfBEpBPiegHBbwiZeJjdmINPoDRcGwZ+GJCqC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com (2603:10b6:4:7f::24)
 by DM6PR02MB6843.namprd02.prod.outlook.com (2603:10b6:5:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 19:56:35 +0000
Received: from DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800]) by DM5PR0201MB3557.namprd02.prod.outlook.com
 ([fe80::5dd9:4dea:abee:1800%3]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:56:35 +0000
From:   "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Arm64 crash while online/offline memory sections
Thread-Topic: Arm64 crash while online/offline memory sections
Thread-Index: AddRetGCwamVTZ1PQ4mClPUkiBXM1gAAXfkAAASqPiAAADiPAAAAa0oAAAORkwA=
Date:   Tue, 25 May 2021 19:56:35 +0000
Message-ID: <DM5PR0201MB35570CBA70B13484205FF9C28E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
 <DM5PR0201MB35576CEF62C53EF393E3D9768E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK07NhNOnKNB02RY@localhost.localdomain>
 <8e0dc9de-6834-72aa-364c-50ce1c717437@redhat.com>
In-Reply-To: <8e0dc9de-6834-72aa-364c-50ce1c717437@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [163.116.135.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4754d378-a226-4d00-3876-08d91fb73364
x-ms-traffictypediagnostic: DM6PR02MB6843:
x-microsoft-antispam-prvs: <DM6PR02MB6843BDF6D63CBC9943BA0819F2259@DM6PR02MB6843.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sf0/0UQxlYJP/uE+6l9YvcXLSwcXB4fi4jp/pb5E6Ph0yGMmMatLnL4OhI99GWfkvB9qL1kPLC8xQc5QmN+8c2m8obPXRbDHPrf5tEAmmsMDbNoBsD9B4h4Pim7I9PzRV4QFI6GGK8YXPR3WfJOd4rP+aEGXRamU7XuhuN+kE4413rP5FZM79eqb4WcFsqLQQ11uam0aWH4gAycEFhbRHUngBTWlqPPNS21HNProU4vN7wz+FWmNQgAWZ0zd0izAMVqp27luNC4HwvcZ0Fg6i5ZDmB97MbTtu8ElYtNYk4643adZGxJuug3rFpkh/+aQeo5aoZWYo/jBzyorBzLahTC/eDYMcxovD4DRWt1yBI0uMbkngIzoNn59qfXreV3iCnF2/qNU6kr6K0qiz+LoOusOcyeQiL6/t4bns0vb35GAhzef+g4VsTv1k07PiSPPhpohiEMaGGzpS6ibPZWb8jWDWuyK5zEEFzjjeJ6OM2Tm6BVXxbTHEES73IHpP7AYIRAOSPTaxANFhQDCeE1XRKQHxHWCscuEIH69uSq4EtU3Y9Tc2Q3yEwqbO+8UBvlLcvXY0HRk5bSw5Y2TrlgiCJzFkVZapCZPVO1skDKoo8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0201MB3557.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(54906003)(55016002)(66556008)(9686003)(8936002)(8676002)(316002)(66476007)(76116006)(52536014)(5660300002)(7696005)(71200400001)(33656002)(186003)(83380400001)(4326008)(478600001)(110136005)(26005)(64756008)(66946007)(2906002)(66446008)(86362001)(122000001)(6506007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmRqcVloRFR4R0l4cFBPVkluV08wK1lySWdtMjIxOFk3ZHQxSGxldFkzOHNQ?=
 =?utf-8?B?aUp3TlpvbUZZN1dhcSt6aUxuQnJvUEFITEhBNllQUEoxUy9zUGhBWnVKRFo5?=
 =?utf-8?B?clNkaFVoeC9KM1BzY2ZmbGVlcG1CeDlNNjRmWUMzWWNTUWpEa0E1bmU5b1Y5?=
 =?utf-8?B?cG5YNmhSUjlzN204RDh5TzA4UHozTjVESE11eXhFd3JDcnVhNzhrTCs0UWk2?=
 =?utf-8?B?VEdXaVUvUlBNQzFyYWdLVlF2dW1vWTc1aWdNWmNaMWdhYlBhMUVRSzBSZ1BP?=
 =?utf-8?B?MmVZNXlCcjdpOEVGekJpRXNScEdUU1FwbnExZUUxaElsbUoyazI3c1ByYWVI?=
 =?utf-8?B?MzRvKzAyTXEyaENnRWpRNS9IUWRUVjlnTDlNUDA4TG9LeFkzellaWFNYS1ZR?=
 =?utf-8?B?VFA2TGNuY1pWWElQZ2hVbGI4UEdpL3VmclJhTHBIaDREM05KSTVraXIyS29K?=
 =?utf-8?B?ZjBqNWZmREhaZW5SOXl1UDJBWFVrQzAyVU5QdzBMcWNzdzF3MmhWN3BXNnBY?=
 =?utf-8?B?cmxHWStrekZ6c1EwU2tXUXNPSWF1blhXYk9wR2k4S0lkUFdGQkRIQnZmbkNP?=
 =?utf-8?B?N0tCZGE5aThoUUhOdHBiay9YQkFlSWMrbFlrRTZWU1Y1TjNFQXVWZ3lMb3lu?=
 =?utf-8?B?Wk9sZmRVZElLeWNNVlhYMGhJU2tnYzErNmkrS3JiK0hVS2NnSktlcWRJSFdM?=
 =?utf-8?B?c1ZnU1BPY2UxaklrVEZONmZMMFBWWDF6MUdNQ0Vma2tXRGhkSjRxWkxDRjZV?=
 =?utf-8?B?V2tqbDN2bDBSY3BLMG5rT3FCL1I2QXczemd0RnZkc0hHTUxCYnJ3cXN3Z1Bk?=
 =?utf-8?B?WkdQVGI2azlzWERFYnRMM3V3VEY5QW95M3F0eGFwUDJna1pVcDNPdHlDc0V3?=
 =?utf-8?B?STBXSDJEK1Z3S1BGeklhdkxLWWQ1RDlGVmhub0huS1JkbkJhRUhyZDAvTXli?=
 =?utf-8?B?R0VDQThCMXh1UTYzSFRyUWcwUmFXUWcyT21RRTgzeWx3RkVWN251b21pOFRE?=
 =?utf-8?B?MGR3T0RqNVBYbG9PUTVGeG9vZ2l0VjZFanZ1WTJ2MGRwc2Y1a1VmVnZkZW90?=
 =?utf-8?B?blF2aWZ1TFJJbFp5K1J6dWdDS3phMllyYjA0UXhJNS93SmhCNmVmWWUvdWNk?=
 =?utf-8?B?dW9BVS82TDZnNXdnVHJKbmpySEI4dGdOemtZbGU1YVU3OEoxenZhaHF2aHho?=
 =?utf-8?B?a3BDQzBqREtWbjJUR2piNEx5VUJUZTJtN1pxeUhITFNoZGZCaGY2MjNReE9v?=
 =?utf-8?B?QzBzQXJVUjNWQVBEUklNNTlkdXhTQ3RWVDhHZDlUWlRlbVVHUEpNZU1NejN2?=
 =?utf-8?Q?2SRgqXGJi5?=
x-ms-exchange-antispam-messagedata-1: pF/Ejlq1caiKG799wBD4NFWDvqsv1sKMiUkFDgdwsI1EXtyHGHap57sdT3LlP1R8btO+oF6bJS9vIPbVIWAs5NVH22fThXgr/Gqy8U/V9/vEnT/23EDLiI9hTH0/8G4utdLCz1jm++/z+UYpTtD1UcvtncVPSsxEbrIrYw31JcY9GnI0eHzHHwAW+dpzW8DWj8Kxk84fS+ctphpeLgIdYW9xhJba5G6wZe4NwLIDR8oMtY4s5q3TMWgrDyGKsHcwm1hbP7FokaJfh+yTK68zNgVqMhDb1nT04d0NlW4A6Q6ZMCFHdUYQjn2051lrnAcASMyPfzdCDeiX6hVgaFchdD8e
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3557.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4754d378-a226-4d00-3876-08d91fb73364
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 19:56:35.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJKVpn1G3iBZ7Mpogz+et5dqdevOB35sG/D29JZlJq4KoQqqCzGJLs/NPiYBtNtRcoNA2ir1h/ZC9OdfgV5UlBYttOcGbu1oMlQQxtp87/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNSwgMjAyMSAyOjEy
IFBNDQo+IEkgYXNzdW1lIHRoZSBmb2xsb3dpbmcgd2lsbCB3b3JrOg0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmFzZS9tZW1vcnkuYyBiL2RyaXZlcnMvYmFzZS9tZW1vcnkuYw0KPiBpbmRl
eCBiMzFiM2FmNWM0OTAuLjZlNjYxZDEwNmU5NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNl
L21lbW9yeS5jDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9tZW1vcnkuYw0KPiBAQCAtMjE4LDE0ICsy
MTgsMTUgQEAgc3RhdGljIGludCBtZW1vcnlfYmxvY2tfb2ZmbGluZShzdHJ1Y3QgbWVtb3J5X2Js
b2NrICptZW0pDQo+ICAgICAgICAgIHN0cnVjdCB6b25lICp6b25lOw0KPiAgICAgICAgICBpbnQg
cmV0Ow0KPiANCj4gLSAgICAgICB6b25lID0gcGFnZV96b25lKHBmbl90b19wYWdlKHN0YXJ0X3Bm
bikpOw0KPiAtDQo+ICAgICAgICAgIC8qDQo+ICAgICAgICAgICAqIFVuYWNjb3VudCBiZWZvcmUg
b2ZmbGluaW5nLCBzdWNoIHRoYXQgdW5wb3B1bGF0ZWQgem9uZSBhbmQga3RocmVhZHMNCj4gICAg
ICAgICAgICogY2FuIHByb3Blcmx5IGJlIHRvcm4gZG93biBpbiBvZmZsaW5lX3BhZ2VzKCkuDQo+
ICAgICAgICAgICAqLw0KPiAtICAgICAgIGlmIChucl92bWVtbWFwX3BhZ2VzKQ0KPiArICAgICAg
IGlmIChucl92bWVtbWFwX3BhZ2VzKSB7DQo+ICsgICAgICAgICAgICAgICAvKiBIb3RwbHVnZ2Vk
IG1lbW9yeSBoYXMgbm8gaG9sZXMuICovDQo+ICsgICAgICAgICAgICAgICB6b25lID0gcGFnZV96
b25lKHBmbl90b19wYWdlKHN0YXJ0X3BmbikpOw0KPiAgICAgICAgICAgICAgICAgIGFkanVzdF9w
cmVzZW50X3BhZ2VfY291bnQoem9uZSwgLW5yX3ZtZW1tYXBfcGFnZXMpOw0KPiArICAgICAgIH0N
Cj4gDQo+ICAgICAgICAgIHJldCA9IG9mZmxpbmVfcGFnZXMoc3RhcnRfcGZuICsgbnJfdm1lbW1h
cF9wYWdlcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBucl9wYWdlcyAtIG5yX3Zt
ZW1tYXBfcGFnZXMpOw0KPiANCj4gDQo+IFdlIG11c3Qgbm90IHRvdWNoIHBmbl90b19wYWdlKHN0
YXJ0X3BmbikgaWYgaXQgbWlnaHQgYmUgYSBtZW1vcnkgaG9sZS4NCj4gb2ZmbGluZV9wYWdlcygp
IHdpbGwgbWFrZSBzdXJlIHRoZXJlIGFyZSBubyBob2xlcywgYnV0IHRoYXQncyB0b28gbGF0ZS4N
Cg0KR29vZCBjYXRjaCwgRGF2aWQuIFRoaXMgcGF0Y2ggd29ya3Mgd2VsbC4NCg0K
