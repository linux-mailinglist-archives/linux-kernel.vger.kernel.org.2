Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF33E4F76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhHIWpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:45:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36034 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236858AbhHIWof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:44:35 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2D029C015F;
        Mon,  9 Aug 2021 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628549054; bh=FSK4cLBe8ZUAw3+5tQQPhqzYmvKp4gk78RIBVEsE17I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=beidDDLpgPGwSxxbz8sCg45hNqkGLYS+CFslO/9TR5QQ4K3KbnVTkOb51Bxzdzxvd
         XLe5HMhGunYYvbpBhJxbyhYS8tr0L/Sfo7jaaV19hezHsl+Lvt9fqYCRO9Uu07tmDg
         rcNayOv9266bRXuwoZTNhWGDgKRV+bmRFHuN4gts2zdWAeMOkn0g0vCC2fvvYLRklD
         9JoQBHJhm9qj3OlW+wliSfn5G2mQ10ldBExJf1ECOfLz83ju5k69JxbnPg4h5NZUfC
         qQAAu+rlWLd8PnxTMbHE+RjYPevg3camU8iDthitgRWYl5C+lXDB+V2TD/suR0Bzoh
         Em25Pt9KcPsnA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BB53FA0080;
        Mon,  9 Aug 2021 22:44:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A9DB7400E9;
        Mon,  9 Aug 2021 22:44:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="tTTfLpM7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNZYZFmR3lNO2mFRpdVTLlQ9MdIOT2Y9m+KUrk17sAL72cLHdaDeyo4AKP75EbuVex5kTtjZ1EEx8T+r9vkm3e0L4cq/w50ki7VqvAQUqZscfVA/F9oUpNHcBb0juSiHyrXywIPnXLp+S1F+dTMWkRi/zFtQmFph4YiQXxl/C7hsuT/OUxumq+2kg2C9//DQ+UtApbZC71i9UcBm3qTvqtcU1a1upBfvZanN8Vekh6cCoKg704QKT7hbpDWZ6UN+NKvhjm/SfXR20SAzbvy2EkaRMaY/keZaO675dyCoYawTHDl2qvbP4wZ1OsEoJFKnkhcQeRM/tpOIlHdcrjR3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSK4cLBe8ZUAw3+5tQQPhqzYmvKp4gk78RIBVEsE17I=;
 b=DIOjWHokO/xx/8155eCPkuLPwCQ60ecptZAeD+kly8Gfc4Ouqxpw4RRQOxmZO2zCKWF/3f44VKkeDOZYtsNRjJPTqiz1ZpiMYhK9oCDjkkntxIgCcLY4MVeJKKPnaCbmeCjaRAqL12q/Ee+Lu2QoExV2q8+Zf6/04iuQMR9ZA/bSFgm8e7wh+s1iN894sAUS53znNQGRFVqWVKtDwcwwCuDVjc3Wi2MJim0UeaTN2+ljF4HuRVx3p2C/54BXQVMBqs0fGr8JMnxS9V8t0lYAo3uJG1GjZW4QCUJmAM4iw2Qj8sIHzSahqIepSl+3NVOWegFl+mSkholzy8zVfUj8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSK4cLBe8ZUAw3+5tQQPhqzYmvKp4gk78RIBVEsE17I=;
 b=tTTfLpM7/SgcXY9sM2ucn7VW7Exr3FXqjtnuAkyfBZMoQNAHJ/iCzTAU7yvKUA+HM8gzZkIaHAGH2FNHYtezISmpdfhFv+jF9w/5FE7J28Y2alZVMarBQnXuNPLltWbvyRRXd9Ni+PrbTGAf5xE5+RHKBpnoJfUy4nf/Gs9bgYs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 22:44:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:44:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Wesley Cheng <wcheng@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Petri Gynther <pgynther@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Topic: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Index: AQHXjW5ko6qYUR8aokekS5eRbPy7oKtrxUWA
Date:   Mon, 9 Aug 2021 22:44:10 +0000
Message-ID: <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
In-Reply-To: <20210809223159.2342385-1-john.stultz@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bbb422b-9d89-4e42-925d-08d95b873423
x-ms-traffictypediagnostic: BY5PR12MB4033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40335267FF034746EE31FAC9AAF69@BY5PR12MB4033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwtBfsSUq9BlN/oIgRDlMkdLCVX2RUnepHUQvyxt37wefR0cCQ5lfts4Kwbic9sMyafoIaLGL/90eL/r3QQY1r4wM4r01NqYqd+LxCAgrRqOB3b+GzxadSrri9bFr7II4c6PojDORGtxsu2p6Xw1kE5YeqSDYAiIYyN5apFGvbOUMRFD3xpiZQtH8WmTcPA/y82mQKU/2m2eFT3Wdk3psJwnzXqgLhPyhnNzGVqY14VFSAfMPldaMBVIt+anKqV5sAhgNHbQyUTBDa2u56bL9eWlmJ1gbD98cT3TKjLYRDlpF+9LYqy8v7jAnVCldBIvp1mvGTJxgbb7EG/VxFB5drIRLE9hznga2jQEIUgusY5RIKQps2QqAYBTKrHIxmpyoQ6KujzKCNHwArD9VyyZf+6TddJuTvwt5b1uggz4rvmuYlRZHHi8NGHzb2EFauR8t0NkiKAEJ+78o7UE76MHtSHiZjHz+8M+io48wRpwLYZJIdyYdCNpMp9R/V6B4qQyy/XQmdm35V73qA3C+M5J0OGELEvkYR8BrbyjcGQm3uGQW/Y5gaOiyHnkf6bKBEZjPgvxa+XZzFRDw9+J2tel5/GuZap8SLAG7sx96zONatMA/EP0xy2O8yTeByyfq4giI9xCaUkZH2QNUG/XVuA0NVp0DWGW23it0tNmH5Wp4KosxsEsu7bKvi/l1zCq6P8r9Onk6XKQ1zp6iRWiXpAuAiR+v3OiHwUO5dIb3RuPiwUYdb+tdDOpNmpuPMR3ov+y9XjW+DyxVp5eMkZK2iczcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(31686004)(2616005)(54906003)(8676002)(8936002)(478600001)(7416002)(86362001)(110136005)(316002)(4326008)(31696002)(38070700005)(66446008)(5660300002)(66946007)(66556008)(66476007)(6506007)(83380400001)(64756008)(38100700002)(71200400001)(6512007)(186003)(76116006)(36756003)(6486002)(122000001)(26005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rks0TjhCdU5aWEkwbk1oMkh3TDJCb0hVNmJqdHlUTE4wL3ZhSWFqaG9YUkoy?=
 =?utf-8?B?YUcxbzhtSHBHdSttNkN0S1IvMzVJL1NkYTZhbUJlbjBRd1pHRkZtaHNPMnJO?=
 =?utf-8?B?R21hai9pQ0ozdFhUSVRpc2N3RmJwbTNwT0YzejlweER5U2dPb28rVGZmSC9C?=
 =?utf-8?B?Rm5FWEdHTC91M0RUaWJlSHBnbWYzdG1PbzRNb2w3d054cFZ6Y3BOUnI1c01z?=
 =?utf-8?B?dHFsb3prOFNBUXdwOE1aK3lkY1EyMEZLcDl1eGNMTXBWY3Vjbk9zZXRlKzVU?=
 =?utf-8?B?dXgwYTVGV3BPZEhKYytVQndWcVV6SkRsbkt6V0lvNzg4cWx0ZndRSHdFeG1W?=
 =?utf-8?B?MkFZSGFyR1dyY00wbDc2WG55cWo3NHRndW1IMzduMnRPdi85c3M4dGQzTUx3?=
 =?utf-8?B?aERjK2VacFE2UnJMZ0tFc3JlZFkyU3ZXVjNZU001dXRLU3FLV3dHd3VxQ3V3?=
 =?utf-8?B?eUlqVXN3TmNZbVVjU1FhRzhCeTZ1akhwOTFKUWJ6VUpsQWNMODJKTnozellp?=
 =?utf-8?B?Qmd4WE9icStCVDhZM01Cd21WbGtpcG50Y2NLVXhadFV6MnJNdXdoM1RzL3Bl?=
 =?utf-8?B?TG1JeEZkSlAzUnFNd0hDNXBvSkkreENFRUZ6T0pvZ2tWQzc5a3NaSGl0ZHF6?=
 =?utf-8?B?WldiTFJZWVN2M1ZNckoxY1hwdUpqL09EUzdIUXJMTEx1eTBldC9Zb0xvZnFS?=
 =?utf-8?B?YkxvRUtrL1JxVkROdGRSa0FGYnFVVGN3d2VnKzM5aEJoY00vcERyQWFSdDVx?=
 =?utf-8?B?TUVndlhIbTZFZHBvWUdRTi9pbnRjU0wrY3JRMFBBbHFMRmc1Z01oMTVXa2Rt?=
 =?utf-8?B?SFIwc0VJc3daMUROSW14b3g5SGp0UlllOHc0TFZ5NGNCbURrR3FBQ0xLQm5L?=
 =?utf-8?B?Vld2WkdWNU1Dd0VBVHE5Q2JzdUdpVkdzcVdjUFZtQzljMHZ5R051ZGx0QVFl?=
 =?utf-8?B?UlJ0VDBES2lRZzNrSVhWZHhEcUdHcHFUb3ZLaWc3L0JqMDZ0UVdnVVBibWNX?=
 =?utf-8?B?ZFFwOHJxRzk5SlVGa2QzODNmRjJRLzQyd28yZ2hIaEZJNDY2SW9YcTh1QVNH?=
 =?utf-8?B?UGErT1Z5cXc4ci85d1hTM29FVHU0N0xFL3pYczZKSkJPWEFpZWdkaE94QlJ0?=
 =?utf-8?B?Y09QUFkxdk03a2txV3F3NTh2aUQyWDJzcmZLcTd1ZkNXN3dtR3pLb1lSVUx0?=
 =?utf-8?B?UGt2OXZFUUpqb2ZKREs5WnE0RFVMSWJPZVFKbE5DUUovN2J5OEZvSEVLd2c2?=
 =?utf-8?B?UC9BSFVDTVhieThWWHJLeFhxZVNqNFlZcERYY1BzRFA3cldUWERDcFo3eGxI?=
 =?utf-8?B?cEl4ZTZub3ZKTzlNUkJKUkZ3YW81YjhmWEVqS3FLS3IrcFZFT3A1YmYyQTNs?=
 =?utf-8?B?d1lkWllmQmlhdDZ3dFROOHNXMTE2NWdVVVRxRFkyNkxyYU5zRU1Rd3A5K3ZV?=
 =?utf-8?B?UmlZWlExMzEwUEQxN3YraDBacVE1OVpRdnZ0M2xCOEJVazF1OUV1UWN0dVAw?=
 =?utf-8?B?VW1wOEtNaDUzTUsyVkZYL1JCdWcvbVJDa2o0MVE4TCtWRzNhZFNWUExzUjZy?=
 =?utf-8?B?OHZWWWRIcEtuVEpQYStSb3lPQ1hXaUs2bVFqL1ZJUDB3LzBVTnVNck9QaUVW?=
 =?utf-8?B?UElMTW5XeWlJVDFjM3Z4VmxmdGVzMDBqNjZLZm40NWVKWUdxOEdRWXdWZkFG?=
 =?utf-8?B?bDU0MWV6ZnBORlErRDdVSWlyVTkrdzNpL2pGWXZVZVJaRzFqT3UwRTdsV1dO?=
 =?utf-8?Q?fDhPlE3xunxkTghG0A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E8F91F960AC6443B5FDABA2911E4677@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbb422b-9d89-4e42-925d-08d95b873423
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 22:44:10.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMx0Wt0+Os9GrhAKVi9mzYcpxhmQQgYyXoq05txBEF+PGv8oBj6pWaEWeBcwAldqIAFP8Q1dAYwDIpZjLZ/tHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9obiBTdHVsdHogd3JvdGU6DQo+IEluIGNvbW1pdCBkMjVkODUwNjFiZDggKCJ1c2I6IGR3YzM6
IGdhZGdldDogVXNlDQo+IGxpc3RfcmVwbGFjZV9pbml0KCkgYmVmb3JlIHRyYXZlcnNpbmcgbGlz
dHMiKSwgYSBsb2NhbCBsaXN0X2hlYWQNCj4gd2FzIGludHJvZHVjZWQgdG8gcHJvY2VzcyB0aGUg
c3RhcnRlZF9saXN0IGl0ZW1zIHRvIGF2b2lkIHJhY2VzLg0KPiANCj4gSG93ZXZlciwgaW4gZHdj
M19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMoKSBpZg0KPiBkd2MzX2dhZGdl
dF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0KCkgZmFpbHMsIHdlIGJyZWFrIGVhcmx5LA0K
PiBjYXVzaW5nIHRoZSBpdGVtcyBvbiB0aGUgbG9jYWwgbGlzdF9oZWFkIHRvIGJlIGxvc3QuDQo+
IA0KPiBUaGlzIGlzc3VlIHNob3dlZCB1cCBhcyBwcm9ibGVtcyBvbiB0aGUgZGI4NDVjL1JCMyBi
b2FyZCwgd2hlcmUNCj4gYWRiIGNvbm5ldGlvbnMgd291bGQgZmFpbCwgc2hvd2luZyB0aGUgZGV2
aWNlIGFzICJvZmZsaW5lIi4NCj4gDQo+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gZml4IHRoZSBpc3N1
ZSBieSBpZiB3ZSBhcmUgcmV0dXJuaW5nIGVhcmx5DQo+IHdlIHNwbGljZSBpbiB0aGUgbG9jYWwg
bGlzdCBoZWFkIGJhY2sgaW50byB0aGUgc3RhcnRlZF9saXN0DQo+IGFuZCByZXR1cm4gKGF2b2lk
aW5nIGFuIGluZmluaXRlIGxvb3AsIGFzIHRoZSBzdGFydGVkX2xpc3QgaXMNCj4gbm93IG5vbi1u
dWxsKS4NCj4gDQo+IE5vdCBzdXJlIGlmIHRoaXMgaXMgZnVsbHkgY29ycmVjdCwgYnV0IHNlZW1z
IHRvIHdvcmsgZm9yIG1lIHNvIEkNCj4gd2FudGVkIHRvIHNoYXJlIGZvciBmZWVkYmFjay4NCj4g
DQo+IENjOiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gQ2M6IEZlbGlw
ZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5k
LmhhcnZhcmQuZWR1Pg0KPiBDYzogSmFjayBQaGFtIDxqYWNrcEBjb2RlYXVyb3JhLm9yZz4NCj4g
Q2M6IFRoaW5oIE5ndXllbiA8dGhpbmgubmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IFRvZGQg
S2pvcyA8dGtqb3NAZ29vZ2xlLmNvbT4NCj4gQ2M6IEFtaXQgUHVuZGlyIDxhbWl0LnB1bmRpckBs
aW5hcm8ub3JnPg0KPiBDYzogWW9uZ1FpbiBMaXUgPHlvbmdxaW4ubGl1QGxpbmFyby5vcmc+DQo+
IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPg0KPiBDYzogUGV0cmkg
R3ludGhlciA8cGd5bnRoZXJAZ29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5l
bC5vcmcNCj4gRml4ZXM6IGQyNWQ4NTA2MWJkOCAoInVzYjogZHdjMzogZ2FkZ2V0OiBVc2UgbGlz
dF9yZXBsYWNlX2luaXQoKSBiZWZvcmUgdHJhdmVyc2luZyBsaXN0cyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGI4ZDRiMmQzMjdiMjMuLmE3M2Vi
ZThlNzUwMjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjk5MCw2ICsyOTkwLDEyIEBAIHN0
YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzKHN0cnVj
dCBkd2MzX2VwICpkZXAsDQo+ICAJCQlicmVhazsNCj4gIAl9DQo+ICANCj4gKwlpZiAoIWxpc3Rf
ZW1wdHkoJmxvY2FsKSkgew0KPiArCQlsaXN0X3NwbGljZV90YWlsKCZsb2NhbCwgJmRlcC0+c3Rh
cnRlZF9saXN0KTsNCj4gKwkJLyogUmV0dXJuIHNvIHdlIGRvbid0IGhpdCB0aGUgcmVzdGFydCBj
YXNlIGFuZCBsb29wIGZvcmV2ZXIgKi8NCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiAgCWlm
ICghbGlzdF9lbXB0eSgmZGVwLT5zdGFydGVkX2xpc3QpKQ0KPiAgCQlnb3RvIHJlc3RhcnQ7DQo+
ICB9DQo+IA0KDQpObywgd2Ugc2hvdWxkIHJldmVydCB0aGUgY2hhbmdlIGZvcg0KZHdjM19nYWRn
ZXRfZXBfY2xlYXVwX2NvbXBsZXRlZF9yZXF1ZXN0cygpLiBBcyBJIG1lbnRpb25lZCBwcmV2aW91
c2x5LA0Kd2UgZG9uJ3QgY2xlYW51cCB0aGUgZW50aXJlIHN0YXJ0ZWRfbGlzdC4gSWYgdGhlIG9y
aWdpbmFsIHByb2JsZW0gaXMgZHVlDQp0byBkaXNjb25uZWN0aW9uIGluIHRoZSBtaWRkbGUgb2Yg
cmVxdWVzdCBjb21wbGV0aW9uLCB0aGVuIHdlIGNhbiBqdXN0DQpjaGVjayBmb3IgcHVsbHVwX2Nv
bm5lY3RlZCBhbmQgZXhpdCB0aGUgbG9vcCBhbmQgbGV0IHRoZQ0KZHdjM19yZW1vdmVfcmVxdWVz
dHMoKSBkbyB0aGUgY2xlYW51cC4NCg0KQlIsDQpUaGluaA0K
