Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC98415B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhIWJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:43:50 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36414 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240135AbhIWJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:43:49 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5FBB540A7F;
        Thu, 23 Sep 2021 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1632390138; bh=kS9144v2sSIgDHdfCOjC/M0GPSqMaz/Mvj77DMC6BQg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FXkcaEj0PcyAEte+/VY4mSpyEpmHyyXVLissxFp/qgPvvi3zpUc2qbfOt+jXOpvxB
         CbpzOPbYL9kz6sARc93uChg01M18hNmiZu9i9iXTJzUBxpOAzH94Wam9hn6WsnGjzY
         FooVAetJWexuLMjacvjSm0YeIotdoPCtwal8tKabf70iB+Cg1FqfE/1Mhh5ehHarEv
         y5e8gbCeHxfZpwwHxCltzH0Ea7sYco5zjq3RA+WGojk2tmxRigppcYYjRNTqLSzl5T
         HKbKVEcnljWORRG/vUJ45zwm2PUm5wZaYWry95UylBfi9ilzRZzYHN5LEWDl3o1L2y
         vtuQWlt9gxFvA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 902FFA0099;
        Thu, 23 Sep 2021 09:42:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 27C2A4009D;
        Thu, 23 Sep 2021 09:42:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="BiWi/ZL1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4dsFsUkIOOY+aJ4w9xh1/1p+02VhOPW7HapH/HpG90hes2xXAWxQZbCyXUTm9dPHa+NKGrPtfsXYibH7wzhbYdhNY084CLZM4rExLxC0Wi2+SMvq5oJ8x/3X6cDsotN/0y+NorK8imgAl7aOc5OdrKwHCJ8+v8Ez7oUKldhWUgKZEBq/4bvyA2rqrzzRq5I8x246qHq33Fc2oRY7psVjwh1CLG1EOGqG0eg8Wft8b1GcM3KmuYnV2sW0i4NL77AuaMMo5sVwD6BJSdyPwSLNG+fOIZuze1A8giGbP06DLAUarI6aXguc0uypZNII5LeEJhMNvI8hLfUa6Q8KYCzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kS9144v2sSIgDHdfCOjC/M0GPSqMaz/Mvj77DMC6BQg=;
 b=oc25u4DNlHO0Ru5aVddyLL0HvdFcMzp1QpgSzGPD9OaaCGgL/0pV7ZAKAEUBjHNG8FaVWm9B89EWyH0bt3xxrFe2+wUL+c52u6Rq3e9h1ZMnhvzEfbsNUjusxx4pSmfM++darFQWKTJYUbQqv5j+Pgxd/2ImaXqPH/WBpH9p3miG6WT7qYuzrl2k8QzfAfHoE/BM776qnJbbXDvCopKRWyKCXFaH0sBTofkUECV3dBA5DYjD8SeBhJl0si11GBpLkEkC8wSITqq423XJQIg7r2Iuf8c6ejrunKLj6iSyX20clP4OXjMEs94ooZsgB7hwFi8V6+JARLX/o1q4vErRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS9144v2sSIgDHdfCOjC/M0GPSqMaz/Mvj77DMC6BQg=;
 b=BiWi/ZL1KMNDpR8bpohEIH0EogH5TMjCKe2V67v9QCVawCsBpwTDJZ6epHSdiBhzPQL2YoKx3X0TAcJkvLKrDJ/c+ICBYr1n+Pd7n2mRUPo8BTJO1QpANvbrzA5cfPmjeY+FSIuLx2LRuidyrDRjHE2G3ZXb1Q9SixIf8YnrtX4=
Received: from CY4PR12MB1160.namprd12.prod.outlook.com (2603:10b6:903:38::12)
 by CY4PR12MB1911.namprd12.prod.outlook.com (2603:10b6:903:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 09:42:10 +0000
Received: from CY4PR12MB1160.namprd12.prod.outlook.com
 ([fe80::2d3a:44fe:fd31:11e2]) by CY4PR12MB1160.namprd12.prod.outlook.com
 ([fe80::2d3a:44fe:fd31:11e2%7]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 09:42:10 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] clocksource: arc_timer: eliminate redefined macro error
Thread-Topic: [PATCH] clocksource: arc_timer: eliminate redefined macro error
Thread-Index: AQHXsCmraQ1C4wDZlUWDP8GpstWP/KuxXnGA
Date:   Thu, 23 Sep 2021 09:42:10 +0000
Message-ID: <61fef534-36df-2ed9-5662-ccebefef494e@synopsys.com>
References: <20210923031808.5945-1-rdunlap@infradead.org>
In-Reply-To: <20210923031808.5945-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 352f7496-83a7-434b-fcea-08d97e766a5e
x-ms-traffictypediagnostic: CY4PR12MB1911:
x-microsoft-antispam-prvs: <CY4PR12MB19118A016C2303C30138F0E1A6A39@CY4PR12MB1911.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jE+K3PB96SixTL4iAPT6xJ19Tzh82g+y3qG68GWWnn1y316y03w1NRx+/l6qdTUJG6TOiZ9FVWDF8J5Ov5cYfWebVmzLy8CoedgXHEWtWNeoeWu/K9P4jwYPXtw4L9+Tqp7qydvevvcwLiXM40XpvIMocRGGkGFnpavsR09Cwh7oA4iC6MiSy9OTSDTxjRPmjLSPOlmCLy4FzBOh4/BJlufj732g2ovHWcfKehdDsIbi7UVrD46WMoGmSGxUMgrE3sp7rIPmsfn0n7wTRMKTSC68QtCd67jK6FK5EUi5W3KnDRgbZnnOAL5ExPJwSV271n++AcMQZeQUByJgIgMswkkRJ7mALZTurskIxIQH0GuHn+hpEqW4cfhic/3vO5Zxev9E9KjBTkxJtB+M4UYo3PtWoOmPhR9faLgEPHqX5jsirI5djy3F8ZusAZKrRmdUFp8/ykol8Bs3A7K0bTBI8uY6rLZtVvEqQ499V4c5nhLOXl8r6PxNVw0HLvzVmSpH5aaCvzlasjtFqu1dxWs/6wHN3CESgEVZJVbFXFl7v8Xq0HBin0Hm4mxg+lYubX65uorEGwwImMBFd6Cq81BiA0KK4EodzeliySIqDK8mG3TK4uDWE3JpMxudGZgTylcL3nQqFk4A9FG9Mwn82fzse42MJHB90N2BuO/GNzykFdk5b1bea0jhMe2rGbjQF8NRtw/vXv9dBs0mnGR1aa2UyJmQ9orDd/dwiR+akzaFSP6tHyXWZDrOJTYplYU0iHYXGSPV0YwagdzevTmDS2PRXxmvRi3FpSPxo7B23pk6GgrD+eiPjzVgciNbDq9/GsYT9UMbP3P1rUt9vlThp8ycXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1160.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(53546011)(6512007)(6486002)(8676002)(36756003)(91956017)(6506007)(66946007)(38070700005)(66476007)(66556008)(71200400001)(76116006)(4744005)(2616005)(83380400001)(38100700002)(5660300002)(54906003)(86362001)(31696002)(316002)(31686004)(508600001)(110136005)(186003)(122000001)(8936002)(2906002)(66446008)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2tFV0Q2ZGlZSWE0YmVBbjF4ek41Z2NkNDdRaS9SbDd6K3BGSFdXQkZuV0JY?=
 =?utf-8?B?RkwxNGRaUStmc2prSW9kYktJM0NraDg4U3IyRDhDYUhaSUZyb3plS1BpeVlv?=
 =?utf-8?B?MFBRaTk1em9ucUZOWlJ4NjFtYll2ZEtzVUJqb0dRaGdpeElRTWJheHRBNVpl?=
 =?utf-8?B?NXd3aFNUS0Fndk13dTRvemtPcVhLY0dPelBhK2RBODBNUmFKUFc5ZG4zZ1pJ?=
 =?utf-8?B?RkRYOE4rQUlsSlBDU2d3K3ZWSUZya0FuczBoWm5scU90bGc2SXpqOGVKY1RT?=
 =?utf-8?B?bGYyWVhqbURwUkpiWFdML0pIREZkUGpPTlZWeHpOZXhoL28zZ1hCb2xrUzUr?=
 =?utf-8?B?dEtCc0crYUhEbDlnSGF2NjZRSHZHckxURHYxVU5nUGU2Ykc1N1BQQjM1NkVi?=
 =?utf-8?B?M1FBYmlQOWFKMzF0eEpqTXJ6QWluT1BrZmVmbUc2dkl6SzZzektyaExjMm4r?=
 =?utf-8?B?YWZueHNSdU5pMkdkSWczeGJFMFZCK24zVUttc21jc0hleERwbENoT3lHL0dI?=
 =?utf-8?B?WnNsRDhwSEF0NEF2Wis0Sno0K3g0ZDN6M0s2ckt1NFpTV3FxL0VEWjI3RE5N?=
 =?utf-8?B?ZHRRZXEzbEF1dEJSbWtEeU13cGlhYy9iakdmZy92YW1IK0FTUWhmV2c1ZVA4?=
 =?utf-8?B?S1c2SW5VRlJMM1czR3ovaHZkT2F0NG01Wno2eExubVk2N0VJVWNrWXhMVkZI?=
 =?utf-8?B?YkxrSURmTG03cGZmMHFESjRCOXF0MGNmajhkKzBhMmtRODV0Y3dHUWRGdnJW?=
 =?utf-8?B?R2tsTzlKWi9UdTRISW5CUjJwVzBFQyswZ2FKOWFuT2JjTSs0ZktiSHVCWEZo?=
 =?utf-8?B?ZGtQdXpTRFhxLyt0WDA5UVhDNk1uaDZrMm5KY2pKeDFsaVpMWmFac2JBY29o?=
 =?utf-8?B?bjlIVTJCVU9IR3dldG9KQnRVQ2c2aDM1eHpwUWhLSVVPMU1JZkp6WWFCM214?=
 =?utf-8?B?RkdqMVpwa3FOdkduSXJOdGpwaDlvTTRuZU9wd1dQai93ZFMvZGg1TFZoWjM4?=
 =?utf-8?B?TjQ1cDh6OHVrUmVhcFhnVDFmVUc5V1psLzlXa3h3anpURXQ1dHUydkErMTdM?=
 =?utf-8?B?WXphUENzNm5nYzlCbFFxRGdqRGJLSS9RdTZZZlljNWgxR0ZEbUQ5MytRZFBv?=
 =?utf-8?B?Zy9QRzlqUDVOa3ByTnBvSHJodFpUVUNuZXdSVHE0TGxBVlNJeVQ0b2l6QUdF?=
 =?utf-8?B?QmIvT2t6LzlRVlhPV3VLL2xzVWR6WVBoUTVvZWVOMTFZVG94a1pEbWtHQ1My?=
 =?utf-8?B?RUJhNHJFK1JsSTBPMUhaOU5UcHAzNldQLzVOcGYyWCtRSElkd0laWUVEL2ha?=
 =?utf-8?B?dlF5WXJJMmRRMUFQOVhlUm5MajJVWUdsWnFscExJMWZXWE1BcTVjZThjU1VX?=
 =?utf-8?B?R2lrdzI5UDdoRkZaQWJvWllyWFFRd2lINlZvaE1XS0t3RnlOc1F0NHBWU21v?=
 =?utf-8?B?RnhmOWpmTEwvY3I3cnJ6QnlsNGFoNklYN08zMzdtR3hUTFdSa3ZWU0hEdjJs?=
 =?utf-8?B?Ukd4Smg3NnROWDhrUkJjZnZwSmRTU0RSaGx1Q3JrOHFDOHg2NW9wZ0NlS3JL?=
 =?utf-8?B?TEs1RmNmb3lTNGhHYm9nNFJ4WG11TmVhWTMzNEoySG1xSFJ6bzhBdmpFNlFZ?=
 =?utf-8?B?dlBOQ2dtTTUyUjBzNXJ0eG83M3FHMEpFTnh2Mm9PSEREMkNZLzBqcmNsWFBD?=
 =?utf-8?B?MWFmalp2bHB3VWVBR1JIaStWVVJJTDlDb0Q0TVNsdGozYzJTVlZ4SWJSbFhC?=
 =?utf-8?Q?jC2NPA4By86d4S8FnjRyp8m3Qw4wiahwhOt0Oph?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA11333469DDD040A2D4CA61A650E0C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1160.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352f7496-83a7-434b-fcea-08d97e766a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 09:42:10.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+5mIpTMDz3OEAe0JKk/c0lw5qymjq3K7NHdW2P7YRJf6rHeETYJcyw8tw9CzE5SD585y9Rq54ewAxIevjZyxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1911
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCkkgaGF2ZSBvbmUgbWlub3IgY29tbWVudC4NCg0KT24gOS8yMy8yMSA1OjE4
IEFNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IA0KPiAtLS0gbGludXgtbmV4dC0yMDIxMDkxNy5v
cmlnL2luY2x1ZGUvc29jL2FyYy90aW1lcnMuaA0KPiArKysgbGludXgtbmV4dC0yMDIxMDkxNy9p
bmNsdWRlL3NvYy9hcmMvdGltZXJzLmgNCj4gQEAgLTE3LDcgKzE3LDcgQEANCj4gICNkZWZpbmUg
QVJDX1JFR19USU1FUjFfQ05UCTB4MTAwCS8qIHRpbWVyIDEgY291bnQgKi8NCj4gIA0KPiAgLyog
Q1RSTCByZWcgYml0cyAqLw0KPiAtI2RlZmluZSBUSU1FUl9DVFJMX0lFCSAgICAgICAgKDEgPDwg
MCkgLyogSW50ZXJydXB0IHdoZW4gQ291bnQgcmVhY2hlcyBsaW1pdCAqLw0KPiArI2RlZmluZSBU
SU1FUl9DVFJMX0lFTgkgICAgICAgICgxIDw8IDApIC8qIEludGVycnVwdCB3aGVuIENvdW50IHJl
YWNoZXMgbGltaXQgKi8NCg0KQ291bGQgeW91IGNoYW5nZSB0aGUgbmFtZSB0byAiQVJDX1RJTUVS
X0NUUkxfSUUiIGluc3RlYWQ/IGFuZCB3aGlsZSBhdCBpdCwgcGxlYXNlIHJlbmFtZQ0KIlRJTUVS
X0NUUkxfTkgiIHRvICJBUkNfVElNRVJfQ1RSTF9OSCIgZm9yIG9idmlvdXMgY29uc2lzdGVuY3kg
cmVhc29ucyBhbmQgc2F2aW5nIHVzDQpmcm9tIGZ1dHVyZSBjbGFzaGVzLiAgVGhhbmsgeW91IQ0K
DQotLSANClNoYWhhYg0K
