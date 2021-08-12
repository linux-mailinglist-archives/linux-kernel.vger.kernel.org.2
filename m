Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846AD3E9BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhHLArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:47:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33416 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232949AbhHLArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:47:37 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6CDA74134A;
        Thu, 12 Aug 2021 00:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628729233; bh=AwwvzslHPDCiIZEEnX+gWLtLgHQDMpSsnWCysiFgDgk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DmVCY9SZCeIDYkhRH+BhwBPKjwbovN1CcfPXPUyymggWrAaZNB2x9qAIxcSeP+hiC
         fpTFBC6kqHOzYfLXK35zBxX02PyZnZ+zpKbaFcCK0QFwBveKi7mvfBJNp2G3TVKp1r
         lNmw7S8WGdkWbHvH7/6E2MR2vbf+7itQLFZFSQvfbONRH43mztZHUuw2gGkENIJoeW
         KOV6pPY4Ttx1z2EOmghpUlLnevkfyyQ7Qrz6HdEnkLXfcfEYyK197GQ6WGKw6Nwr28
         TLaBMvVylvHVx0Cl6QjZvyuM9hGmIGH7uMytvCr4/CKf7PrEsCOeaCuboxK3HdMMcH
         h8IFx3lMVTqsw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 86EB9A0091;
        Thu, 12 Aug 2021 00:47:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 689C34011B;
        Thu, 12 Aug 2021 00:47:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="kVWNlMxn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqBoGOIGlg5yzUf+Cd0oy33vmVPMVeXI0RQUr0YA+QCqsxSpiGcPN9PVmETeOWRL6kFIU71AYHQoFyJnpe/cxfm+mbWS9Zxc53jkZWGsNX9e7JrU3GG0QKBat7nSotNJYzYKJMkJ3BZE/4KROl1YtyQsS4sGTqyhQX/r2vWpEB6X3yJvnrnrV9D9bdWklmr4x0gFtLm7jQygv5Qv7CI/oz3qZxaJ/9vIFCSK1NCj3VFIIN39b2PS8fnVzdiVDfLh7QEW/PG6Jg/EunnO9hdc2tz7QIC/e7j2Li1RQcoozOjeqWMLXy4JPvFCM3EgLdLat+AtwzDLBYszJToFRpRK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwwvzslHPDCiIZEEnX+gWLtLgHQDMpSsnWCysiFgDgk=;
 b=TyoKR/Oka4qvDth+zMSAco4/XYQ38e0LsOJdJhP8xrrkuM++pKMwei3bCu/vPB9xMa+BDY/C9B6BysSVd1FxD8oM+7v2rBFG9XGGE5PxA57Z9YiK8IlNYlVvI7s0ybEmA7Ju4v5c4YvyEXwAPAKEDhvOn5EZUjlNzykS7+2tDfh87FZ3WSnzaN79HSPYThbJnTiLbcM5LtX/3luT5a1MK1BxunP9//4xVLPXbtrDdO6M7xMMteRvjFqHGwdA5VoAaML2k5O7AN8yeCO3CASnRbsOH8LccnralwKknEQjp++iBDxG/u0FRYKBedAJh+m8izVVKCtGXtQ93L5Dl79zAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwwvzslHPDCiIZEEnX+gWLtLgHQDMpSsnWCysiFgDgk=;
 b=kVWNlMxnc2QAOPeqjTWcqLsVZME10iMTSko/btfH/u2wS6JyLFxgc6nlNiSrss1cVXDwVE57wlDsulH4kk63s+Y/IKp2olsQG6eSblPBz2OBB9dAz/5ngRMZQNRjF+YOezZfNgLY8XnR/ywpK8vxvWMcSDtSW4zVrU9mbc/OP6A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 00:47:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.014; Thu, 12 Aug 2021
 00:47:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Topic: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaA
Date:   Thu, 12 Aug 2021 00:47:08 +0000
Message-ID: <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914d01e3-ae41-498c-039b-08d95d2ab6d8
x-ms-traffictypediagnostic: BY5PR12MB4019:
x-microsoft-antispam-prvs: <BY5PR12MB40190D422E075837E0CBB817AAF99@BY5PR12MB4019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRUOy4jzCkslZ/Wa2tJGXX0QjRW0+rsTLEMDrggIf89pxqXVlLBT8/QFULTtbI2/z8IMGIJC7QfrHoOhaaHe+dZ6p+bippUZjyrc6HssxqEygmd+ySFaH8MGHrj5IFgdiz+wdsW8qtcrS4XJQvb6dpBLxnFNnj6XNXM12IaF+2p6IuYHafkHD/2e4ChyWNlGLAxXxafleAZT2NxUmjWiSpAEOATGqr7JsvJLvFhvGZtYCbSaL9FXLHzZ1MKbTdMDN8UjVNWEPvej+JA4nPjBgLnPQ667+82qQmgwZrv9nciOfw8N1VnhcdcpPGJuk4j4d1a7hAM6MpK4NqeVfDFTHnQrxlFGOTppbtUBlIVYieHhpU9354r61WaNyk9DyJnHUbgi42TszjLsglDJx/LBrEoeBtHdJ4yuAoz6GZ2Z4qrCB95OvVfVe8GZAmEQ1gb7q6xk9tlIRLTM9XvdUf5w8+aMlHVEFaRvArLTEFSDv+tVRsrdIEKiX0+wgVXfZA6D6804tzWZDLDDslITilpxByik5gsCuRDMj2d9k2FDPSNQnrwodiRQ+jocj0Hj2jgULi+xrS3wdF5fp0k9dKIFkc/FqCrNVcbmaS1u8Afw1AHt+SoPaRiELFPYXqndb9ap0bys3RG72hX1oeo/lKUwIZHuEWECBIOALw6YYJdh68xEa4MtrrW9L/TPXN/Y8kK9trhonIU76RIXbehZNm5biLlh9+BqfwTRpeF++p5vIXepJzxeNFoZJQUH7Kt17tmj9lMuIkljoNLy3T1MDq/3fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(36756003)(83380400001)(76116006)(186003)(31686004)(6486002)(6512007)(64756008)(71200400001)(4326008)(66556008)(66476007)(66446008)(66946007)(86362001)(38070700005)(31696002)(2906002)(2616005)(54906003)(26005)(38100700002)(478600001)(8936002)(316002)(8676002)(122000001)(5660300002)(6506007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW9TTjQyWWNIWWkvTmpiaGtYM2VTWitYTFFHcG43eHhybURIWTV5ZWZrTXBu?=
 =?utf-8?B?THVkMFc4djl0V2RVcG9tVlNpVHk5bkFDUUkzd3ZneGhUd1oxK2NCdVduSjBE?=
 =?utf-8?B?dHlIK1hUbTB4UmYwektaL1d0a0J3UXVmS1prRFJPZHFsK1RSeVgvS2VCNlBx?=
 =?utf-8?B?UnJUS2IxZnJNYkFHWjR3VkFDOUxnNlFVTGRSa25pbDVjTm5XQ2l6SHZ0T2Rw?=
 =?utf-8?B?K1ZLSFNRbjM0aDFKczczaGQ3SVZvNitPeHlMVWZyV1hBZWhXOHpoMjhMaEVh?=
 =?utf-8?B?ejJoWFB0M0FRaGdHMEJIdU9HYTJwNVZLRE9GUGhKY0JleHZGZkRKMGU0S1lT?=
 =?utf-8?B?L0dHR0ZORDdsODRoRmNlem1XK2pPSmxjTmkrTGUxLzB6Tzg0eGFRa0txMStl?=
 =?utf-8?B?Z3BvTnJlWWc4cHg3OU1oRjZPMDVjSVYzOTRnUUV5MDFlMC9hZXB0WnVPQmlK?=
 =?utf-8?B?RFdzVE12aWgrNVRXYjNBVXJtd1QwYXVFRGVqemVwNU9kS2FvY0hkSGtWNHli?=
 =?utf-8?B?WXZEUEJQSkpmMEs2Uk9CVDVtcDVrTXp0Q29HajRDZ3BYcml5TmNxVytRaDdV?=
 =?utf-8?B?SWRycXNNN3NvenVrcktVZUlHRUJPQ3FGSmtvbk9ONGNFeXRrOEJDcUpyL3U4?=
 =?utf-8?B?c1czQmdsQ2trajIrbXpIbjBRUkZRVVNJd2tWR3A4OTErRitrTGJFbU90M2JV?=
 =?utf-8?B?azg4cDZxOVJiYjFlN0IrUUZrdWxzcHFhQ05MTGVQTmRKQ2xsS0hDMHBZYity?=
 =?utf-8?B?cXZVaUc2ckIxemxwMDMyYUZ6Z3BjK1BkK3BzbGxhMjdCbUxUQjhmNnB0bEky?=
 =?utf-8?B?U2RJbWp2MzVXcWpJWFVmUFRSMXg4Ymxxb2d1R1FxSWczSndVUTh1M1dyeWtP?=
 =?utf-8?B?SXkxYTJEc3lRVW9RZDBremk2UUpGVml3eERFcUEzdkZSeWk1VjByN1FOWGRP?=
 =?utf-8?B?WGpSWHJ2eXBWWlpxTmFIRm5LSW1YcE1GbDUrRnRLcklGYXNWTFVBZkFNcktk?=
 =?utf-8?B?dlc1Zm5qTExON0thUnBESzRsd3cyOUh1aWc0cjRXVFR3TEhxUHJoMUJGbUpP?=
 =?utf-8?B?Sm5jTTR0TXdTZVhrTjQ1d2oyVmdIQUdXTDRtaFJDWnFaRHdWZEkwU1B0Wmw2?=
 =?utf-8?B?RGoyTU9PeFZlMTlNQkNQSFVDWmcvejFJb25SQnpnM0UrUVV0TEhLclc5QWUz?=
 =?utf-8?B?WHZmRGhndDZ1cVhxamhacWNFMTNObU9NUlp3SW5vSjJOUXVFckRraGQyNGc1?=
 =?utf-8?B?WUhNQlVUR2sxelM0aG5ScEJuNTB5b3llcTNIbGhtYlJqRkR6aVpVUnRhRVg2?=
 =?utf-8?B?YTZHT00vY0x1UFB5SjZmSUlIYmplc1NjdW4wdVlTTUhyOVVlcmZVQVhUeG9y?=
 =?utf-8?B?aEw3bGdDQnk0dGF6OXdMeXRiUVVWT3ppZWlTRFNlTDluR2lmNXhkUTYwRUQw?=
 =?utf-8?B?RTNFU0hEeWhCbU9xUTl6V0pOQ0QyaG54djlPbWdsKzdKQ2hqK3BiWjAzaHQz?=
 =?utf-8?B?cURQNXVYK0hnL1Jha1NQRzFnc2VNcVVmbmNYTlduYXNaRUlxRGRkUXh3TEg2?=
 =?utf-8?B?RzNhY05TVGxMYm9BNXJIQkV6bU5XR0NwMFUzVkxFK0NwL3hqdHZ2VEdZZnBU?=
 =?utf-8?B?bkdBYXpkMU4wd0RLNlVwY2E2dzRyeHJLQmJERE5RYSs4SWdEOURVZmNaa2du?=
 =?utf-8?B?RmVrQ200UTZmblU3aTlkNzZEMzdYeFUybnY0VTQvSCtNQjJNM1JNZ1VvbnR3?=
 =?utf-8?Q?6ImSMfPjV/cIC+OPY8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB1EBB7E4F928747B448B5A6ADE6372F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914d01e3-ae41-498c-039b-08d95d2ab6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 00:47:08.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gK3CGvt/DLfFxiUThif5+YQ7Y6sv4K0fywMQJOckeUXsX86BpFUgVkcPgUhWBbg5Db4q7GDx+q3YTVT9d2xOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBEdXJpbmcgYSBVU0IgY2FibGUgZGlzY29ubmVjdCwgb3Ig
c29mdCBkaXNjb25uZWN0IHNjZW5hcmlvLCBhIHBlbmRpbmcNCj4gU0VUVVAgdHJhbnNhY3Rpb24g
bWF5IG5vdCBiZSBjb21wbGV0ZWQsIGxlYWRpbmcgdG8gdGhlIGZvbGxvd2luZw0KPiBlcnJvcjoN
Cj4gDQo+ICAgICBkd2MzIGE2MDAwMDAuZHdjMzogdGltZWQgb3V0IHdhaXRpbmcgZm9yIFNFVFVQ
IHBoYXNlDQoNCkhvdyBjb3VsZCBpdCBiZSBhIGNhc2Ugb2YgY2FibGUgZGlzY29ubmVjdD8gVGhl
IHB1bGx1cCgwKSBvbmx5IGFwcGxpZXMNCmZvciBzb2Z0LWRpc2Nvbm5lY3Qgc2NlbmFyaW8uIElm
IHRoZSBkZXZpY2UgaW5pdGlhdGVkIGEgZGlzY29ubmVjdCwgdGhlbg0KdGhlIGRyaXZlciBzaG91
bGQgd2FpdCBmb3IgdGhlIGNvbnRyb2wgcmVxdWVzdCB0byBjb21wbGV0ZS4gSWYgaXQgdGltZXMN
Cm91dCwgc29tZXRoaW5nIGlzIGFscmVhZHkgd3JvbmcgaGVyZS4gVGhlIHByb2dyYW1taW5nIGd1
aWRlIG9ubHkNCm1lbnRpb25zIHRoYXQgd2Ugc2hvdWxkIHdhaXQgZm9yIGNvbXBsZXRpb24sIGJ1
dCBpdCBkb2Vzbid0IHNheSBhYm91dA0KcmVjb3ZlcnkgaW4gYSBjYXNlIG9mIGh1bmcgdHJhbnNm
ZXIuIEkgbmVlZCB0byBjaGVjayBpbnRlcm5hbGx5IGJ1dCBpdA0Kc2hvdWxkIGJlIHNhZmUgdG8g
aXNzdWUgRW5kIFRyYW5zZmVyLg0KDQo+IA0KPiBJZiB0aGlzIG9jY3VycywgdGhlbiB0aGUgZW50
aXJlIHB1bGx1cCBkaXNhYmxlIHJvdXRpbmUgaXMgc2tpcHBlZCBhbmQNCj4gcHJvcGVyIGNsZWFu
dXAgYW5kIGhhbHRpbmcgb2YgdGhlIGNvbnRyb2xsZXIgZG9lcyBub3QgY29tcGxldGUuDQo+IElu
c3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVycm9yICh3aGljaCBpcyBpZ25vcmVkIGZyb20gdGhlIFVE
Qw0KPiBwZXJzcGVjdGl2ZSksIGRvIHdoYXQgaXMgbWVudGlvbmVkIGluIHRoZSBjb21tZW50cyBh
bmQgZm9yY2UgdGhlDQo+IHRyYW5zYWN0aW9uIHRvIGNvbXBsZXRlIGFuZCBwdXQgdGhlIGVwMHN0
YXRlIGJhY2sgdG8gdGhlIFNFVFVQIHBoYXNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5
IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9lcDAuYyAgICB8IDQgKystLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDYgKysr
KystDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oIHwgMyArKysNCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBpbmRl
eCA2NTg3Mzk0Li5hYmZjNDJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTIxOCw3ICsyMTgsNyBAQCBp
bnQgZHdjM19nYWRnZXRfZXAwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3Jl
cXVlc3QgKnJlcXVlc3QsDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZv
aWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4gK3ZvaWQg
ZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlz
dHJ1Y3QgZHdjM19lcAkJKmRlcDsNCj4gIA0KPiBAQCAtMTA3Myw3ICsxMDczLDcgQEAgdm9pZCBk
d2MzX2VwMF9zZW5kX2RlbGF5ZWRfc3RhdHVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJX19kd2Mz
X2VwMF9kb19jb250cm9sX3N0YXR1cyhkd2MsIGR3Yy0+ZXBzW2RpcmVjdGlvbl0pOw0KPiAgfQ0K
PiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKHN0cnVjdCBkd2Mz
ICpkd2MsIHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICt2b2lkIGR3YzNfZXAwX2VuZF9jb250cm9s
X2RhdGEoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIHsNCj4gIAlz
dHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBwYXJhbXM7DQo+ICAJdTMyCQkJY21kOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNTRjNWEwOC4uYTBlMmU0ZCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+IEBAIC0yNDM3LDcgKzI0MzcsMTEgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAo
c3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4gIAkJCQltc2Vjc190b19qaWZmaWVz
KERXQzNfUFVMTF9VUF9USU1FT1VUKSk7DQo+ICAJCWlmIChyZXQgPT0gMCkgew0KPiAgCQkJZGV2
X2Vycihkd2MtPmRldiwgInRpbWVkIG91dCB3YWl0aW5nIGZvciBTRVRVUCBwaGFzZVxuIik7DQo+
IC0JCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gKwkJCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gKwkJCWR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoZHdjLCBkd2MtPmVw
c1swXSk7DQo+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbMV0p
Ow0KDQpFbmQgdHJhbnNmZXIgY29tbWFuZCB0YWtlcyB0aW1lLCBuZWVkIHRvIHdhaXQgZm9yIGl0
IHRvIGNvbXBsZXRlIGJlZm9yZQ0KaXNzdWluZyBTdGFydCB0cmFuc2ZlciBhZ2Fpbi4gQWxzbywg
d2h5IHJlc3RhcnQgYWdhaW4gd2hlbiBpdCdzIGFib3V0IHRvDQpiZSBkaXNjb25uZWN0ZWQuDQoN
CldlJ2QgYWxzbyBuZWVkIHRvIHdhdGNoIG91dCBmb3Igc29mdC1jb25uZWN0IGluIHF1aWNrIHN1
Y2Nlc3Npb24gYmVmb3JlDQp0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQgY29tcGxldGVzLg0KDQo+
ICsJCQlkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydChkd2MpOw0KPiArCQkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmggYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5oDQo+IGluZGV4IDc3ZGY0YjYuLjYzMmY3YjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiBA
QCAtMTE0LDYgKzExNCw5IEBAIGludCBfX2R3YzNfZ2FkZ2V0X2VwMF9zZXRfaGFsdChzdHJ1Y3Qg
dXNiX2VwICplcCwgaW50IHZhbHVlKTsNCj4gIGludCBkd2MzX2dhZGdldF9lcDBfc2V0X2hhbHQo
c3RydWN0IHVzYl9lcCAqZXAsIGludCB2YWx1ZSk7DQo+ICBpbnQgZHdjM19nYWRnZXRfZXAwX3F1
ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcXVlc3QsDQo+ICAJ
CWdmcF90IGdmcF9mbGFncyk7DQo+ICt2b2lkIGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KHN0
cnVjdCBkd2MzICpkd2MpOw0KPiArdm9pZCBkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKHN0cnVj
dCBkd2MzICpkd2MsIHN0cnVjdCBkd2MzX2VwICpkZXApOw0KPiArDQo+ICBpbnQgX19kd2MzX2dh
ZGdldF9lcF9zZXRfaGFsdChzdHJ1Y3QgZHdjM19lcCAqZGVwLCBpbnQgdmFsdWUsIGludCBwcm90
b2NvbCk7DQo+ICB2b2lkIGR3YzNfZXAwX3NlbmRfZGVsYXllZF9zdGF0dXMoc3RydWN0IGR3YzMg
KmR3Yyk7DQo+ICANCj4gDQoNCkJSLA0KVGhpbmgNCg==
