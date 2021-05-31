Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30B53956A3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhEaICt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:02:49 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61707 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhEaICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622448063; x=1653984063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=itPxXjx+cF3QygUszFoOlfDAR4CQKf/mOPTGJ9FxvZQ=;
  b=G0iVkfjs6jfJw1K24FTfF/6y01ZOftRYkyxcKU5U5g9HoBLKGfH8UVaU
   VAOuCes18hKGIcGnt1Iy/4TpXldbLgpPFXhKkrQxfbgkngzhCDe+y43bn
   V2cgfhdZgJgIZli9uCGUsFRCTkQPHfNCihZinzZXsi8Sv2lbA8yl2/t8A
   XgqhZ0n8m3Ik9J8wk6K8z+5UR0BB1vzuZtnxFe66q52EvePDJ54iidP2a
   4dbc0K2e0XcVSbMxRUsHWczkJOZYSRudQ8J7WMRhSLxs3ee0ulVo7h/jt
   nSp2F/wQcrfm5+23CoJr8+uHx/ZHh/9ut/YeJtXe0SpGVPhm4Y6VA/G/U
   A==;
IronPort-SDR: LnHG4AN3Y8jNC2gIYdbd+ZHvq2UXswVdkoRczpiMdpyg6/v+BXevNbDwfZXgRH7scX9EpBXYCW
 exe/Fy7z6E7mvM+mHRvkPjXt/cD/tkVEvqocgoLxyz76P/rv8v7NqUGVDPm5o+gkgq49FwXvYL
 bWSLLpLM5c028q0oAeTN9X85+N4n2fYo59myuqWv/vFT3GV1VOz95BIYBirYOsb1DEixubKV8T
 j7L4XetaqOkvEDHxcnUh/tblj7TjKVGpmxp3NG8Gv7R3EigmMq24K/HDnrlyj6xF7lJZqiBKFS
 J/w=
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="130073848"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2021 01:01:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 01:01:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 31 May 2021 01:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+LyjIQSWQdvsytEn/JYfLLwNvw8mWo98pkdMt9sQlV+opYu54duAYBBKel1dPHHnvTFnBp7GUCVvNiSenCJWFV9ZACpvyuKOf/84yVFvJOCflN5mnnGs3Bv+Wx7bEcZKX5eqV7PxI1fUmOIQgeKBRmijaPlx3VEE2cIfDICF3DCGemlZQ9oHuDnZOX3WjW5mMDuorbXdZUdPBBGTakU+41rc9aNq/22+T2J8pi0k0QcbBKyHOEm152gZm82dPpRmWFMFqx7fUT7OeNTjPizP92N5CdbmiZG8bwsACqoiJ6k6M9gtrVZGMFw3JxgkezmCDeZ/uTu5Y+xMkkGg0zbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itPxXjx+cF3QygUszFoOlfDAR4CQKf/mOPTGJ9FxvZQ=;
 b=LVig17CVopAAKq/LWz01IPqfe2UxNeIVzNFFBR+sE7rHRTDsaCQCdTW42EUKQFrJW2AZlHvFD0cKJEms2cM9mYuQ1777Ewfg3jAjz9RF1os9dfNLoy0wCdMeXbzo7zgtjFBX7/Ek0/SHi0enGDUmWzKsS8R1XTwwsFAtp8p99hZj9LMmYDXEZWoaG4WdpdwQxCL8jC1hE6bY7DYUYvb+BLKDpvFtyi04tywxh+4GXfm08T1LkbEvzcG0XN1u6SplxQIAgyKSZ7+5To76WDvveJPwOSpl5ZVkjxnvwyhOPQhpYFj+GHFWro/pciqBpC73mSPU1xceeWCerJqGluMJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itPxXjx+cF3QygUszFoOlfDAR4CQKf/mOPTGJ9FxvZQ=;
 b=RKxg8YuWOje1d6JKlznZzXubm/3YGme6R9FVqZHh7VIH7/21cyCg3o/n6Ayx1N5HK0/FhePTNhzJGTgJ66Dw2ANAxl8u1YjoWQjYuPqMp3Nux5O1brMuFDNJno1qHywNZltIGLidkt2cv6rRcvkS1/QoN8t/xO6BQL8+fo56/BU=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2365.namprd11.prod.outlook.com (2603:10b6:300:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 08:00:58 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4173.029; Mon, 31 May 2021
 08:00:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Thread-Topic: [PATCH v3 1/3] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Thread-Index: AQHXVfMWCjsPzVIZekeG1VBfbNM9Zg==
Date:   Mon, 31 May 2021 08:00:58 +0000
Message-ID: <0cd72191-e195-eae3-f741-a3c3e38298cc@microchip.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-2-michael@walle.cc>
In-Reply-To: <20210520155854.16547-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9223ee06-e439-4b74-b194-08d9240a39db
x-ms-traffictypediagnostic: MWHPR1101MB2365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2365B99AED4BC9B2371E68A5F03F9@MWHPR1101MB2365.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ugzzi6QGZMCGQuxiefUIAzMBD7AqBFZpXRT7siiHoH8kaCUuXOThzOuPXpVPwqG/dJPdLd4Z9OI2BMydmrIxAn7+JcMcoKzPTthfwflHar0cda6B7f1JOYmIbNG/8cnEaUzsYBdVyjMo8tIGO9QYvmK9rlClKnKeCQcL/KvAUPsfxEOF8LPcrtyrumxOjiVm4wSZ6ChWGXeQbASzdcNHmOa3S7S66rvs7+aIL6Qc49dkJPvf7mT7aM/IqFieypFhJPC5ycjBytu8fQnbOHzzf5NIJOsSy5MlvxG+gsuuBZJRtjL8lO4MhUyTvk/V5itY7aKlLtiVetcy5jjetClQvZYYWPg1ZuGfvW0+RAzwpZ8LYfsZT0voVoFUb6yCdCuINxFA4p2EkSuVnorRkxCYYsRwPP6jzcEA8Th41JHOzDB+MTtpwq7rSqCIfpvaZC1cTnDEK2sqngeBt8LPdAnWhDcpEi1F+IsW4wa/e8urJrRWPgELpOmdIbF+XtaZj28ZsmZKvaz41BVIIre36RF04yvutHFJ16Fy86GRJQ/tSvZ3qdrU3hFEJ+AE/+RhyuBw/ZLCAbq7r/EmIANRBbmiTrXxSd0pmtcOMedJKyfcYgAIklwzdes48b9KUneuCDRAnznbexw2QFf98ZKYHppgO7EB43EtzxfsAEaih1QkMkCw0DitfBQ8F8c5X3bzJRXdwt0wTCSkadR7rOKYwWG4ZKYLp1d0bJxB0IN/bMEW3AZX7PLCl+/1826xHi3qgfaAjvmfNX8oEXYyLGGHjmLEvH4Y/+ILDWdHMPWTXwLr6TJVarrM5AVtYnAhUUOEUj2O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6506007)(6486002)(966005)(316002)(478600001)(38100700002)(83380400001)(71200400001)(110136005)(54906003)(122000001)(15650500001)(26005)(86362001)(53546011)(36756003)(186003)(8676002)(5660300002)(66446008)(66556008)(64756008)(66946007)(66476007)(8936002)(31686004)(4326008)(91956017)(2616005)(6512007)(76116006)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlJZS3NvSVlpa055b3FOaERSYUpJRkRiTk9WeCtaQ0lFTUNCUndrYjZKWnJt?=
 =?utf-8?B?OGNrbDRROWlyazBKRFZSbGEyLzl0c25sN3p5azFvODdsSi92VnFwY2gwRXhC?=
 =?utf-8?B?S3V4enZwOWlidEgvZmZoUzdmUVFtaEhxcm5zT0pnWjAreVpUSXEvYWlhNXlh?=
 =?utf-8?B?VnVuZUNPRDFYN0E2WndQczdtMGtFUE1WTktJa0JGb3pOeFJwdUdSU3pSNHBM?=
 =?utf-8?B?ck00ODEvaE9ETHFWaWxwZmYwVFMzUTlUS2ZwbVZpTFc3Yi9Wb25WNHdacmRz?=
 =?utf-8?B?ZEUwdjNVNi9PSWRVTVBxdVVZZXdTOWRaWVBpSGtNR24ySld5dkNBVlJLYitI?=
 =?utf-8?B?TzRDdUNFWE5uRTA0NU40bW9xWWR1bEhhY1RwL3ZMc3FjR0dWTno1RDJyS2tF?=
 =?utf-8?B?bFVwMG4wNkR3NTFXU2IrempYQ1c3YjRWck93b0wwUG9acGVZT1ROWnRhSlNy?=
 =?utf-8?B?Qi9qaWpjZFV1T2NHZWRjdlVud1Y5dFRLNWNHQzVxV2dqR0dPN2hNeW00K3Y5?=
 =?utf-8?B?Wkh2Y25DajhBYVF4R1pQZmlydnlKWDFndHluTUJOcE5IektSd2lCOStsd21u?=
 =?utf-8?B?MHc2VTBlN2U2eGxuaWQyak9zTGlZS2wwSk9wZ0MwRjlPeTNGWHd5eWY4WnVE?=
 =?utf-8?B?MFh0TmlxRmpzVzB1bHdweVBQcFVEVjVPU09hY0xKTlA0eXBFU1ZMVXRQVmZj?=
 =?utf-8?B?bVd1d3pTTFBiN1BuaWpNT01nU082c3dHbno3RHpTdVhka3hiODQrOUtWN2dP?=
 =?utf-8?B?YXNiT2dVK1hQUWdXTDNkc0VVcW5PZzlsOXJPZEFHcVNFWGJhNkZpNDVIRGVp?=
 =?utf-8?B?QU9Pd3NPNk5mYmtGcWZZaTZ5TjJZeW1YNC9jdStKT2dWVU9RN0RPZVNsWEl3?=
 =?utf-8?B?V1J2MEUrdVJJdEFZSXJsTWROSkdXdGFwaE5CcGJlb2VUbnlwQ3dwcDc0aGtZ?=
 =?utf-8?B?NU1kbU1oZFhtSHJzeEo5a1htSXdDd1d5MGZpTWhiRk5QWHZrQ2s4Q2VyNlhu?=
 =?utf-8?B?dGE4UFdRVjlXTlV4N3FmMnNzKzZzOFJxSk9GK0RFbnVaQTFCWUNiRlkrYnJi?=
 =?utf-8?B?ekExOGkwY1Z3eTYvU1U3WWxHVndJRjByVjIydnB4SlROQ1hZS1UwMlZCa2gv?=
 =?utf-8?B?ZWxqb1lxRWNPZWVHWGdRait6ZU5iUkpRalUrUW9UMUVYZC84OGRDeVlZUnU0?=
 =?utf-8?B?eEhpL0lQRWpQT1VwQlRKclhpM3dPb2RVcDhMb01QTHRrbDdwOTgrOXdMYUxa?=
 =?utf-8?B?Y3pzSTl6TEsyei9qS3ZpV0hTMlIzQk1LQnBwY3lrNnJyQVRuSEJxS1oxTGh5?=
 =?utf-8?B?cjF6TUNvaXhyTEF3SnpFcytGQklRQW5lMTNvSXZvdFhlSjhVc09DSjlFc1Qz?=
 =?utf-8?B?WW1VMnY0dXlXUmRyV3djclRSYWl3MER0blNLT2FZeWNSTG5DNzRkSmZWdklp?=
 =?utf-8?B?ZXdqWHVsa09NeTZnM0t1WUduNEM1MlZJbzQ0Zlk1NFVjMnZwZkZRMzM0Tk84?=
 =?utf-8?B?SGlhNVZaWUFqa3JNa1BsZmN4RnRzZlo4cC92SkZPVlV3eXlEMGZYVnpZc3NH?=
 =?utf-8?B?a2lyUFlBTklMSmYwSzlNN0dxMFg4TmVmeGhyVElLUnFGbWNrSzFSQnpqaDR5?=
 =?utf-8?B?TzR6bldaaDNIMVhEaSt6T2lTbzdMaUdHTWtkYnVJU1MxMGNudWUwQU1oZ0hH?=
 =?utf-8?B?SlJJR2dEM05NdnhhWGpUM2laNEc2bWtuMzFwTkRXTXZzRFNPejVNR0VuMkF1?=
 =?utf-8?Q?MLsLaFDI8tfGHqArng=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <791C03D5ED837B4DAF969D2A01B25526@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9223ee06-e439-4b74-b194-08d9240a39db
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 08:00:58.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sQSEUktIrVIj9BcchtOpH/kHrX0NLp8S76Vl6o8nk2lh1GIRn394C25MzAJ5xixCrr0Yhh7i9kmGGkPzA4wtNdaLcuhqyIOj+WELRUOYQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMC8yMSA2OjU4IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBzZWN1cml0eSByZWdpc3RlcnMgZWl0aGVy
IHRha2UgYSAzIGJ5dGUgb3IgYSA0IGJ5dGUgYWRkcmVzcyBvZmZzZXQsDQo+IGRlcGVuZGluZyBv
biB0aGUgYWRkcmVzcyBtb2RlIG9mIHRoZSBmbGFzaC4gVGh1cyBqdXN0IGxlYXZlIHRoZQ0KPiBu
b3ItPmFkZHJfd2lkdGggYXMgaXMuDQo+IA0KPiBGaXhlczogY2FkMzE5M2ZlOWQxICgibXRkOiBz
cGktbm9yOiBpbXBsZW1lbnQgT1RQIHN1cHBvcnQgZm9yIFdpbmJvbmQgYW5kIHNpbWlsYXIgZmxh
c2hlcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+
DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9vdHAuYyB8IDIgLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivb3RwLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+IGluZGV4IDYxMDM2Yzcx
NmFiYi4uOTFhNGM1MTBlZDUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL290
cC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMNCj4gQEAgLTQwLDcgKzQwLDYg
QEAgaW50IHNwaV9ub3Jfb3RwX3JlYWRfc2VjcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qg
YWRkciwgc2l6ZV90IGxlbiwgdTggKmJ1ZikNCj4gICAgICAgICByZGVzYyA9IG5vci0+ZGlybWFw
LnJkZXNjOw0KPiANCj4gICAgICAgICBub3ItPnJlYWRfb3Bjb2RlID0gU1BJTk9SX09QX1JTRUNS
Ow0KPiAtICAgICAgIG5vci0+YWRkcl93aWR0aCA9IDM7DQo+ICAgICAgICAgbm9yLT5yZWFkX2R1
bW15ID0gODsNCj4gICAgICAgICBub3ItPnJlYWRfcHJvdG8gPSBTTk9SX1BST1RPXzFfMV8xOw0K
PiAgICAgICAgIG5vci0+ZGlybWFwLnJkZXNjID0gTlVMTDsNCj4gQEAgLTg0LDcgKzgzLDYgQEAg
aW50IHNwaV9ub3Jfb3RwX3dyaXRlX3NlY3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IGFk
ZHIsIHNpemVfdCBsZW4sDQo+ICAgICAgICAgd2Rlc2MgPSBub3ItPmRpcm1hcC53ZGVzYzsNCj4g
DQo+ICAgICAgICAgbm9yLT5wcm9ncmFtX29wY29kZSA9IFNQSU5PUl9PUF9QU0VDUjsNCj4gLSAg
ICAgICBub3ItPmFkZHJfd2lkdGggPSAzOw0KPiAgICAgICAgIG5vci0+d3JpdGVfcHJvdG8gPSBT
Tk9SX1BST1RPXzFfMV8xOw0KPiAgICAgICAgIG5vci0+ZGlybWFwLndkZXNjID0gTlVMTDsNCj4g
DQoNCkknbSBub3QgY29udmluY2VkIHRoYXQgdGhpcyBpcyBnb29kLiBJIHNlZSB0aGF0IHdpbmJv
bmQgdXNlcyAzIGJ5dGVzIGFkZHIgd2l0aCBmb3IgdGhlDQpTUElOT1JfT1BfUlNFQ1IgYW5kIFNQ
SU5PUl9PUF9QU0VDUiwgZXZlbiBmb3IgYmlnZ2VyIGZsYXNoZXM6DQpodHRwczovL3d3dy53aW5i
b25kLmNvbS9ocS9wcm9kdWN0L2NvZGUtc3RvcmFnZS1mbGFzaC1tZW1vcnkvc2VyaWFsLW5vci1m
bGFzaC8/X19sb2NhbGU9ZW4mcGFydE5vPVcyNVEyNTZKVw0KDQpNaWNoZWFsLCBjYW4geW91IGRv
dWJsZSBjaGVjaz8NCg0KdGENCg0K
