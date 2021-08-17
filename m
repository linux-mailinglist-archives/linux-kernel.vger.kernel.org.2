Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25AB3EE20D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhHQBZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:25:49 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42738 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233253AbhHQBZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:25:48 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E7E9AC0910;
        Tue, 17 Aug 2021 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1629163516; bh=vgAtLcuPM0RKciVx/bxoEuWTJRqNPK0WE5ek/+l0wYY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jYfHBBFCDpogIJTccwWej7/fpQVn1XscKLU0HyP+Z68h5R5stvdqoRma1vZdo5AMw
         bZaxlYZrPbnSfsTe15EQLVrUjCwHBlvFawhjixAQxxbE8ezvyYVYCE4m40GI2mcEE1
         Bec/3UXgPU/C5+4L4d+7CjS/pC0Nqfs9DyIuJb/QXgbXb8FFLqL7h/jpKxPCIbC3yd
         KWJGd6GrL3qoIkzzwK+6UAfHCywJXHwXBQmAWqSUCfrWaw5qEaoLtQ9ua1U0lAk/74
         yeV8h59k3pOHnp/MZC51gv69uFXa7CFPClGC+bEZKT0DDKAgwRW4/i05Kn7pYatov1
         Ju1VVAxnXsD6g==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8DB40A007C;
        Tue, 17 Aug 2021 01:25:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DABE580362;
        Tue, 17 Aug 2021 01:25:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UQHqjfIm";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIlA5D9hMNViH0+WPJ2Is+6MCuSwZrMVNt0bnjJbsa8WkqsNJYlyHuzgGdpP+5fzbIlciwI21S/0ZCMiMq1+LOW6eIWem6/paLurIldo1C3cP5H5odwwmobjFfq3NbZGVJAvCQDnjPmrW0DY2SSOh5xl2JWRVUL0FDHU54odm96rHhVzaz7JWOxx9qZ1V44HjWVyC6lTF4ofb0X51D7PVX9+/jo9R63B+zYM/RNT23JvToYJvi/NzkUiPqWd+mM5mvocvEF7VF6OxdRO5wzzNpE5F04rCvFKM8i1iICXxiGKwc4xnw72shiEbovingqK3P7wh5g2VM9xXUxc533Buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgAtLcuPM0RKciVx/bxoEuWTJRqNPK0WE5ek/+l0wYY=;
 b=Ykakdp+V7y4sISloILlhgPWplnNtOpgY0OhZOiULJpR9dPyB7LS7mS6xDCiI/25Adz6kHGHuQJBD9P4AXELZ2dFFQhhTuaSHF57KurZ7u6qRXHDn1MqDnSDbhzHpPuoNnMYPjYlBZuNvZg+jwWpvOLeVqYRXptHfL6L8TWx1jc4ifUp/psYt5Bh1sxlaC1ffSTfbUVsx/hfqheP2m1GlPjscZTNMTwl3AgT0408HtvbuZ3gSH7AneJDahcqpIeFZc0Ina1oIotEq2eTJfdlUx0GgUGn8LTAkNRiLEHK0sdw3+PfWnOc57S4ONQLWnv5aIWmsKlqFt8p1/uSk076clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgAtLcuPM0RKciVx/bxoEuWTJRqNPK0WE5ek/+l0wYY=;
 b=UQHqjfImOWjndOfYjiF0TbHYx51T7o6g1CNoFOSDb2eVHsyjjpY2vymh2QEkUP/mhTHgTR+ZL9s0PaE1e/uFLE2XcF6A48jq1lKfYvNWHGRrJN0dk+3Efg6m9Fzd3o19Tn9hoP0IRaxaLC7xLBiXBm7Svecn2NOvJf22H7Np0ZU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 01:25:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 01:25:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Wesley Cheng <wcheng@codeaurora.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeauora.org" <jackp@codeauora.org>
Subject: Re: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Topic: [RFC][PATCH] usb: dwc3: usb: dwc3: Force stop EP0 transfers
 during pullup disable
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaAgAETMgCAAEh3AIAAHhwAgAGTEQCAAAe1gIAAC4YAgAGREQCAAF71AIABNUyAgABO3ACAAVIKgA==
Date:   Tue, 17 Aug 2021 01:25:10 +0000
Message-ID: <71e97c23-73cd-2713-75e5-c2b8e6187c6e@synopsys.com>
References: <1628648608-15239-1-git-send-email-wcheng@codeaurora.org>
 <bcc8ff30-5c49-bddd-2f61-05da859b2647@synopsys.com>
 <3edf74ba-d167-0589-a7ab-827b57aa5d9c@codeaurora.org>
 <e07b7061-e9cf-3146-d115-56967298051e@synopsys.com>
 <c82ee8f3-a364-f96f-76ac-2b78c1dc0517@codeaurora.org>
 <f760fdcf-cd59-2c71-8c85-a4624620edeb@synopsys.com>
 <5be881a9-c79d-3f21-9e2e-173307fef734@codeaurora.org>
 <dc37617c-0fe4-47b3-cbd0-1d729ce6201a@synopsys.com>
 <00952bdc-acc2-f373-9286-6a8380e0b7d1@synopsys.com>
 <875yw7jkz6.fsf@kernel.org>
 <89b4d57c-f44a-ceff-45f3-a308e1d8d135@synopsys.com>
 <875yw6j7cz.fsf@kernel.org>
In-Reply-To: <875yw6j7cz.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ec3081b-1ebc-4524-e945-08d9611ddb12
x-ms-traffictypediagnostic: BYAPR12MB2952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2952F00EE42834CC175EE7F0AAFE9@BYAPR12MB2952.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNA18gDhBC54ij9pF3KXjgff2ShAIjdgwDcFCuLtnf/U41piI6BUjopLm1dtvRajfS2FdWdoRbe30A8szYyb8p/fIZfWl137ZZmTGQABNlbF7AputOy1oMC3HmRMAHDajKu1RwLV6rKW6qoXT+fJtWb3LyZDEfawBo3cXQLOOp1tkTtofm/jCFRsUSmn9SCLzFrzW6AZvFfJkHqQTT2DQtl55MgC9v56+rK/1xH5JY7cTYXa5qRISm/Ary2EXmRYqHkOPKBs5wQgkHRpqvCrFg4Sx+Y/KeHvg/pXMDneVGpJ5njI0zZcKJpUtaLiTQmCrwHhPhvh//86EmKM9XuzOYF6ACMfg85WWyJlww6Vzhi3LXRGq2somIuOoP1N+F/+3oFF79Vg5jcKf3lCHbHUGuPKLC99S8wbcq2BKhevXHeejuUfwRn7Bm1LBNui7JxzQRb+44xdi6khS5eT0Su6oYNjm6WxAWuUJCD67wY2Gl3lGOfcgGor6plsd1ql/joMqJR9XfF8+m10yCLaLNB6QiudydthJaVA2IdONRCsfp0YHecwvC0YJRwyeePTMj4TX5p1ZCwfKbMlGaqFgO2MNoiaA3Yql3JY0GDh43K8VYBdBh6ZFY82EbhjCMJ5OqRwSf+ZGvFyXGRlmc4VawwlaDV70uijL4zdnYZ95uFXHhsRX/JwNY2JL/1pRwXgUCIAO1jLKITEvtqd3AWdo4E8vSYHkOlS3VaDMqFjMQbXuJzF6qJLT0LlCLGOLwoJpgFaV3J2Y4/o+SOHdN23o7kKrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(38070700005)(26005)(31696002)(5660300002)(110136005)(83380400001)(6506007)(2906002)(8936002)(8676002)(6486002)(38100700002)(478600001)(122000001)(66446008)(66946007)(186003)(64756008)(66556008)(31686004)(71200400001)(2616005)(76116006)(54906003)(86362001)(36756003)(316002)(66476007)(6512007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aERIZWQ4amd6cVFibDdSbWRoQkVVZEZSYzBZK3JGSHFTS0kxOGRIMU5NVFFN?=
 =?utf-8?B?ZzNoUUh0NW91cVVZTVBoTmJrNlpydWFYS01nMytZbllEbWwyUm9DKzhheUhq?=
 =?utf-8?B?aEZ2eEs5dng3alhVUExlZ05FUzNwdm8yZk9yRU0xanZiVmRZZktCRnRNYXhj?=
 =?utf-8?B?WXFIOUszeDIrTjlTWGd3b2hFM2prZkJZMkFXQnN6blFZQU9jSFZIT1VVYlh3?=
 =?utf-8?B?VzJ2YnF0K3FIRkJRUFk0UnVtVU5GUDAvNWp4UWRNNzQ0UlpjcnByN2l6UU9L?=
 =?utf-8?B?dVVRdVdXc2RQN05Sc3ZwUnBSOHY3eWx3amk0aXE4bVA5V1BoRERtZENMWkVU?=
 =?utf-8?B?blZsbUNCMTJ6R2R0TUdhUG9UUDhSd1NYVG9BT2x5ZXNyQVgyRy8rK1QzMjMv?=
 =?utf-8?B?SU5UU3hQRU9lelhqa2ZsaG93TDlmZ3JaNGhSeFVueEJ3ZThGa3VIVDJORUEx?=
 =?utf-8?B?Qll1OGFRVFYvQ2VHTFB1QmxkN3ZaRGNBRHB4bUJESlA4b3o4ZXRBbFNHa0xp?=
 =?utf-8?B?OXdsZm1mTDZ0QXA4NHpFeFRHMjFXeHJsODZNTVFWbFJsckc4aENFWWthcmdD?=
 =?utf-8?B?MlNZTjZvZjl0TTN2cjlGM29tT0xDdE1JRU85VFpoMnhESUR5OEE5eHlxRDJi?=
 =?utf-8?B?cHMyam9UZ1RlNDJ3dmZIMy8rTjA1bWtlOE1heUFDMVZnaE5lUDRqU0NORG5D?=
 =?utf-8?B?UXlqaks3cFk4WkFNN2Q5SXN1ZHI3OHAwYWVZVnlhYnpseDB3cHQ2aDV0YTgw?=
 =?utf-8?B?eWJ5bC9oVjZUajg0cUh4akp1MlRHdFZhSUlML0M3QWtmZFlZWTBVY3BKVjVU?=
 =?utf-8?B?WG1KamIxblV3Tk45WjExYVJRaCtub1BxWDlwMDJzbjB5Y2ZEUG11dk12a0VZ?=
 =?utf-8?B?a1FxN0lBL2E0MDZQRXVHNTFoYTRRenJiTXRRQ0JRUitYcCszV2hUZXpaMzg3?=
 =?utf-8?B?ZnY5SzhoNnoxWnFOa29hNmxFTHptc3dGUUZMaS9CR25Qdml1UTBnbWo5aEFm?=
 =?utf-8?B?c1VONldSU1Z6bHFieDlvWXhUUk12WWUxYlBVSzhIYVNmL1p2Z1FRSWRkT3ds?=
 =?utf-8?B?Yk5mRjVZN3ZjdUVTaVh3RHZuNm9LMWY1RHVETjF3bmdZQ2o3SGhGaUVFT0RV?=
 =?utf-8?B?YTNRcSs3UHBmb0tpUXUrZ0NKcTdnSFJEWGZUWWVnL0dWbDJ5S1ZVbjhwRjdx?=
 =?utf-8?B?bFB3N3ZkWG14NGZ0YXk5WnI4ZmVtUXQ3cXNDNHNIRCsxcEdiVkh0RGllcGZ3?=
 =?utf-8?B?YWlkQjlLVEdud0s0WEQ2VURSYWk5M09mRForeFNNVkFBNW9telRUUGxVcVFi?=
 =?utf-8?B?UTU2SkhYc3Y0QXVTZDRDSHJYanB1bzkyUVE3WHc5ZHNoTFFkR1Z6a1QrTDRq?=
 =?utf-8?B?b25wYk1ZWmVmUHNUNmcvVGpXOTBhVzNUYWtnL0k1Q01lNEU5UXVJZ2NTcVFk?=
 =?utf-8?B?VXpIcGszMEs5YmN2NDkrM0FTd0RzckFWYmVzdEh0VS9UbkkvUnJncHpvWkN5?=
 =?utf-8?B?WFN0Q0c5b2hCY3puSWdmRFNXU3R3bUY0M0EzMFo3ZUhZRHYwdHpGOXcvVUdF?=
 =?utf-8?B?SkdjT2J2dWtwREdOTnY4dXZ5WW1ieXg2SGxhYXhiYkU1end3YzBqRERmTTNW?=
 =?utf-8?B?NXBiamhpa0NmblR4K3dlSDNOd1ovOUZYd0FKSzVQS3N6Rld4UkZwSGhmK2M5?=
 =?utf-8?B?clQvR3lxT0FaZFR5NmJRSEI5Nm5Gb1JZVlQ4TjlNRVZkNE44bythcEVlUllh?=
 =?utf-8?Q?7SvmAUvNC0IXVCvK5Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A626A0DC89B841438C9811775A9143AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec3081b-1ebc-4524-e945-08d9611ddb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 01:25:10.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJNw8qPAurMxaFM/FucE1iYIzGaWeJd1SQozliyrTktW7HpqYSaiek4Ycv7fV3+NG53bh056RlcO63TGvfQZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+IHdyaXRlczoNCj4+PiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5n
dXllbkBzeW5vcHN5cy5jb20+IHdyaXRlczoNCj4+Pj4+Pj4+Pj4+PiBJZiB0aGlzIG9jY3Vycywg
dGhlbiB0aGUgZW50aXJlIHB1bGx1cCBkaXNhYmxlIHJvdXRpbmUgaXMgc2tpcHBlZCBhbmQNCj4+
Pj4+Pj4+Pj4+PiBwcm9wZXIgY2xlYW51cCBhbmQgaGFsdGluZyBvZiB0aGUgY29udHJvbGxlciBk
b2VzIG5vdCBjb21wbGV0ZS4NCj4+Pj4+Pj4+Pj4+PiBJbnN0ZWFkIG9mIHJldHVybmluZyBhbiBl
cnJvciAod2hpY2ggaXMgaWdub3JlZCBmcm9tIHRoZSBVREMNCj4+Pj4+Pj4+Pj4+PiBwZXJzcGVj
dGl2ZSksIGRvIHdoYXQgaXMgbWVudGlvbmVkIGluIHRoZSBjb21tZW50cyBhbmQgZm9yY2UgdGhl
DQo+Pj4+Pj4+Pj4+Pj4gdHJhbnNhY3Rpb24gdG8gY29tcGxldGUgYW5kIHB1dCB0aGUgZXAwc3Rh
dGUgYmFjayB0byB0aGUgU0VUVVAgcGhhc2UuDQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4+Pj4+
Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDQg
KystLQ0KPj4+Pj4+Pj4+Pj4+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNiArKysrKy0N
Cj4+Pj4+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaCB8IDMgKysrDQo+Pj4+Pj4+
Pj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+Pj4+Pj4+Pj4+IGluZGV4IDY1ODcz
OTQuLmFiZmM0MmIgMTAwNjQ0DQo+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9l
cDAuYw0KPj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+Pj4+
Pj4+PiBAQCAtMjE4LDcgKzIxOCw3IEBAIGludCBkd2MzX2dhZGdldF9lcDBfcXVldWUoc3RydWN0
IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxdWVzdCwNCj4+Pj4+Pj4+Pj4+PiAg
CXJldHVybiByZXQ7DQo+Pj4+Pj4+Pj4+Pj4gIH0NCj4+Pj4+Pj4+Pj4+PiAgDQo+Pj4+Pj4+Pj4+
Pj4gLXN0YXRpYyB2b2lkIGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KHN0cnVjdCBkd2MzICpk
d2MpDQo+Pj4+Pj4+Pj4+Pj4gK3ZvaWQgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoc3RydWN0
IGR3YzMgKmR3YykNCj4+Pj4+Pj4+Pj4+PiAgew0KPj4+Pj4+Pj4+Pj4+ICAJc3RydWN0IGR3YzNf
ZXAJCSpkZXA7DQo+Pj4+Pj4+Pj4+Pj4gIA0KPj4+Pj4+Pj4+Pj4+IEBAIC0xMDczLDcgKzEwNzMs
NyBAQCB2b2lkIGR3YzNfZXAwX3NlbmRfZGVsYXllZF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3YykN
Cj4+Pj4+Pj4+Pj4+PiAgCV9fZHdjM19lcDBfZG9fY29udHJvbF9zdGF0dXMoZHdjLCBkd2MtPmVw
c1tkaXJlY3Rpb25dKTsNCj4+Pj4+Pj4+Pj4+PiAgfQ0KPj4+Pj4+Pj4+Pj4+ICANCj4+Pj4+Pj4+
Pj4+PiAtc3RhdGljIHZvaWQgZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShzdHJ1Y3QgZHdjMyAq
ZHdjLCBzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPj4+Pj4+Pj4+Pj4+ICt2b2lkIGR3YzNfZXAwX2Vu
ZF9jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4+
Pj4+Pj4+Pj4+PiAgew0KPj4+Pj4+Pj4+Pj4+ICAJc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9w
YXJhbXMgcGFyYW1zOw0KPj4+Pj4+Pj4+Pj4+ICAJdTMyCQkJY21kOw0KPj4+Pj4+Pj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPj4+Pj4+Pj4+Pj4+IGluZGV4IDU0YzVhMDguLmEwZTJlNGQgMTAwNjQ0DQo+Pj4+
Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+Pj4+Pj4+Pj4+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4+Pj4+PiBAQCAtMjQzNyw3ICsy
NDM3LDExIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0
ICpnLCBpbnQgaXNfb24pDQo+Pj4+Pj4+Pj4+Pj4gIAkJCQltc2Vjc190b19qaWZmaWVzKERXQzNf
UFVMTF9VUF9USU1FT1VUKSk7DQo+Pj4+Pj4+Pj4+Pj4gIAkJaWYgKHJldCA9PSAwKSB7DQo+Pj4+
Pj4+Pj4+Pj4gIAkJCWRldl9lcnIoZHdjLT5kZXYsICJ0aW1lZCBvdXQgd2FpdGluZyBmb3IgU0VU
VVAgcGhhc2VcbiIpOw0KPj4+Pj4+Pj4+Pj4+IC0JCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4+Pj4+
Pj4+Pj4+PiArCQkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPj4+Pj4+
Pj4+Pj4+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbMF0pOw0K
Pj4+Pj4+Pj4+Pj4+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNb
MV0pOw0KPj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IEVuZCB0cmFuc2ZlciBjb21tYW5kIHRha2Vz
IHRpbWUsIG5lZWQgdG8gd2FpdCBmb3IgaXQgdG8gY29tcGxldGUgYmVmb3JlDQo+Pj4+Pj4+Pj4+
PiBpc3N1aW5nIFN0YXJ0IHRyYW5zZmVyIGFnYWluLiBBbHNvLCB3aHkgcmVzdGFydCBhZ2FpbiB3
aGVuIGl0J3MgYWJvdXQgdG8NCj4+Pj4+Pj4+Pj4+IGJlIGRpc2Nvbm5lY3RlZC4NCj4+Pj4+Pj4+
Pj4NCj4+Pj4+Pj4+Pj4gSSBjYW4gdHJ5IHdpdGhvdXQgcmVzdGFydGluZyBpdCBhZ2FpbiwgYW5k
IHNlZSBpZiB0aGF0IHdvcmtzLiAgSW5zdGVhZA0KPj4+Pj4+Pj4+PiBvZiB3YWl0aW5nIGZvciB0
aGUgY29tbWFuZCBjb21wbGV0ZSBldmVudCwgY2FuIHdlIHNldCB0aGUgRm9yY2VSTSBiaXQsDQo+
Pj4+Pj4+Pj4+IHNpbWlsYXIgdG8gd2hhdCB3ZSBkbyBmb3IgZHdjM19yZW1vdmVfcmVxdWVzdHMo
KT8NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEZvcmNlUk09MSBtZWFucyB0aGF0
IHRoZSBjb250cm9sbGVyIHdpbGwgaWdub3JlIHVwZGF0aW5nIHRoZSBUUkJzDQo+Pj4+Pj4+Pj4g
KGluY2x1ZGluZyBub3QgY2xlYXJpbmcgdGhlIEhXTyBhbmQgcmVtYWluIHRyYW5zZmVyIHNpemUp
LiBUaGUgZHJpdmVyDQo+Pj4+Pj4+Pj4gc3RpbGwgbmVlZHMgdG8gd2FpdCBmb3IgdGhlIGNvbW1h
bmQgdG8gY29tcGxldGUgYmVmb3JlIGlzc3VpbmcgU3RhcnQNCj4+Pj4+Pj4+PiBUcmFuc2ZlciBj
b21tYW5kLiBPdGhlcndpc2UgU3RhcnQgVHJhbnNmZXIgd29uJ3QgZ28gdGhyb3VnaC4gSWYgd2Ug
a25vdw0KPj4+Pj4+Pj4+IHRoYXQgd2UncmUgbm90IGdvaW5nIHRvIGlzc3VlIFN0YXJ0IFRyYW5z
ZmVyIGFueSB0aW1lIHNvb24sIHRoZW4gd2UgbWF5DQo+Pj4+Pj4+Pj4gYmUgYWJsZSB0byBnZXQg
YXdheSB3aXRoIGlnbm9yaW5nIEVuZCBUcmFuc2ZlciBjb21tYW5kIGNvbXBsZXRpb24uDQo+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJIHNlZS4gIEN1cnJlbnRseSwgaW4gdGhlIHBsYWNl
IHRoYXQgd2UgZG8gdXNlDQo+Pj4+Pj4+PiBkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKCksIGl0
cyBmb2xsb3dlZCBieQ0KPj4+Pj4+Pj4gZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoKSB3aGlj
aCB3b3VsZCBleGVjdXRlIHN0YXJ0IHRyYW5zZmVyLiAgRm9yDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRo
YXQgZG9lc24ndCBsb29rIHJpZ2h0LiBZb3UgY2FuIHRyeSB0byBzZWUgaWYgaXQgY2FuIHJlY292
ZXIgZnJvbSBhDQo+Pj4+Pj4+IGNvbnRyb2wgd3JpdGUgcmVxdWVzdC4gT2Z0ZW4gdGltZSB3ZSBk
byBjb250cm9sIHJlYWQgYW5kIG5vdCB3cml0ZS4NCj4+Pj4+Pj4gKGkuZS4gdHJ5IHRvIEVuZCBU
cmFuc2ZlciBhbmQgaW1tZWRpYXRlbHkgU3RhcnQgVHJhbnNmZXIgb24gdGhlIHNhbWUNCj4+Pj4+
Pj4gZGlyZWN0aW9uIGNvbnRyb2wgZW5kcG9pbnQpLg0KPj4+Pj4+Pg0KPj4+Pj4+IE9LLCBJIGNh
biB0cnksIGJ1dCBqdXN0IHRvIGNsYXJpZnksIEkgd2FzIHJlZmVycmluZyB0byBob3cgaXQgd2Fz
IGJlaW5nDQo+Pj4+Pj4gZG9uZSBpbjoNCj4+Pj4+Pg0KPj4+Pj4+IHN0YXRpYyB2b2lkIGR3YzNf
ZXAwX3hmZXJub3RyZWFkeShzdHJ1Y3QgZHdjMyAqZHdjLA0KPj4+Pj4+IAkJY29uc3Qgc3RydWN0
IGR3YzNfZXZlbnRfZGVwZXZ0ICpldmVudCkNCj4+Pj4+PiB7DQo+Pj4+Pj4gLi4uDQo+Pj4+Pj4g
CQlpZiAoZHdjLT5lcDBfZXhwZWN0X2luICE9IGV2ZW50LT5lbmRwb2ludF9udW1iZXIpIHsNCj4+
Pj4+PiAJCQlzdHJ1Y3QgZHdjM19lcAkqZGVwID0gZHdjLT5lcHNbZHdjLT5lcDBfZXhwZWN0X2lu
XTsNCj4+Pj4+Pg0KPj4+Pj4+IAkJCWRldl9lcnIoZHdjLT5kZXYsICJ1bmV4cGVjdGVkIGRpcmVj
dGlvbiBmb3IgRGF0YSBQaGFzZVxuIik7DQo+Pj4+Pj4gCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xf
ZGF0YShkd2MsIGRlcCk7DQo+Pj4+Pj4gCQkJZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoZHdj
KTsNCj4+Pj4+PiAJCQlyZXR1cm47DQo+Pj4+Pj4gCQl9DQo+Pj4+Pj4NCj4+Pj4NCj4+Pj4gTG9v
a2luZyBhdCB0aGlzIHNuaXBwZXQgYWdhaW4sIGl0IGxvb2tzIHdyb25nLiBGb3IgY29udHJvbCB3
cml0ZQ0KPj4+PiB1bmV4cGVjdGVkIGRpcmVjdGlvbiwgaWYgdGhlIGRyaXZlciBoYXNuJ3Qgc2V0
dXAgYW5kIHN0YXJ0ZWQgdGhlIERBVEENCj4+Pj4gcGhhc2UgeWV0LCB0aGVuIGl0J3MgZmluZSwg
YnV0IHRoZXJlIGlzIGEgcHJvYmxlbSBpZiBpdCBkaWQuDQo+Pj4+DQo+Pj4+IFNpbmNlIGR3YzNf
ZXAwX2VuZF9jb250cm9sX2RhdGEoKSBkb2Vzbid0IGlzc3VlIEVuZCBUcmFuc2ZlciBjb21tYW5k
IHRvDQo+Pj4+IGVwMCBkdWUgdG8gdGhlIHJlc291cmNlX2luZGV4IGNoZWNrLCBpdCBkb2Vzbid0
IGZvbGxvdyB0aGUgY29udHJvbA0KPj4+DQo+Pj4gSUlSQyByZXNvdXJjZV9pbmRleCBpcyBhbHdh
eXMgbm9uLXplcm8sIHNvIHRoZSBjb21tYW5kIHNob3VsZCBiZQ0KPj4NCj4+IE5vLCByZXNvdXJj
ZV9pbmRleCBmb3IgZXAwb3V0IGlzIDAsIGVwMGluIGlzIDEuIFlvdSBjYW4gY2hlY2sgZnJvbSBh
bnkNCj4+IG9mIHRoZSBkcml2ZXIgdHJhY2Vwb2ludCBsb2cgZm9yIHRoZSByZXR1cm4gdmFsdWUg
b2YgU3RhcnQgVHJhbnNmZXINCj4+IGNvbW1hbmQgZm9yIHRoZSByZXNvdXJjZSBpbmRleCBvZiBl
cDAuIFRoZXJlIGNvdWxkIGJlIGEgbWl4ZWQgdXAgd2l0aA0KPj4gdGhlIHVuZG9jdW1lbnRlZCBy
ZXR1cm4gdmFsdWUgb2YgU2V0IEVuZHBvaW50IFRyYW5zZmVyIFJlc291cmNlIGNvbW1hbmQNCj4+
IGJlZm9yZSB3aGVuIHRoaXMgY29kZSB3YXMgd3JpdHRlbiwgZG9uJ3QgbWl4IHVwIHdpdGggdGhh
dC4NCj4gDQo+IGZhaXIgZW5vdWdoIDotKQ0KPiANCj4+PiB0cmlnZ2VyZWQuIElmIHlvdSBoYXZl
IGFjY2VzcyB0byBhIExlY3JveSBVU0IgVHJhaW5lciwgY291bGQgeW91IHNjcmlwdA0KPj4+IHRo
aXMgdmVyeSBzY2VuYXJpbyBmb3IgdmVyaWZpY2F0aW9uPw0KPj4NCj4+IEZvciBhbnlvbmUgd2hv
IHdhbnRzIHRvIHdvcmsgb24gdGhpcywgd2UgZG9uJ3QgbmVlZCBhIExlQ3JveSBVU0INCj4+IHRy
YWluZXIuIElmIHlvdSB1c2UgeGhjaSBob3N0LCBqdXN0IG1vZGlmeSB0aGUgeGhjaS1yaW5nLmMg
dG8gcXVldWUgYQ0KPj4gd3JvbmcgZGlyZWN0aW9uIERBVEEgcGhhc2UgVFJCIG9mIGEgcGFydGlj
dWxhciBjb250cm9sIHdyaXRlIHJlcXVlc3QNCj4+IHRlc3QsIGFuZCBjb250aW51ZSB3aXRoIHRo
ZSBuZXh0IGNvbnRyb2wgcmVxdWVzdHMuDQo+IA0KPiBUaGF0J3MgdHJ1ZS4NCj4gDQo+Pj4+IHRy
YW5zZmVyIGZsb3cgbW9kZWwgaW4gdGhlIHByb2dyYW1taW5nIGd1aWRlLiBUaGlzIG1heSBjYXVz
ZQ0KPj4+PiBkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydCgpIHRvIG92ZXJ3cml0ZSB0aGUgVFJC
cyBmb3IgdGhlIERBVEEgcGhhc2UNCj4+Pj4gd2l0aCBTRVRVUCBzdGFnZS4gQWxzbywgaWYgdGhl
IGVwMCBpcyBhbHJlYWR5IHN0YXJ0ZWQsIHRoZSBkcml2ZXIgd29uJ3QNCj4+Pj4gaXNzdWUgU3Rh
cnQgVHJhbnNmZXIgY29tbWFuZCBhZ2Fpbi4NCj4+Pg0KPj4+PiBUaGlzIGlzc3VlIGlzIHVubGlr
ZWx5IHRvIG9jY3VyIHVubGVzcyB3ZSBzZWUgYSBtaXNiZWhhdmUgaG9zdCBmb3INCj4+Pj4gY29u
dHJvbCB3cml0ZSByZXF1ZXN0LiBSZWdhcmRsZXNzLCB3ZSBuZWVkIHRvIGZpeCB0aGlzLiBJIG1h
eSBuZWVkIHNvbWUNCj4+Pg0KPj4+IHJpZ2h0LCBpdCB3b3VsZCBiZSBhIG1pc2JlaGF2aW5nIGhv
c3QsIGhvd2V2ZXIgZGF0YWJvb2sgY2FsbGVkIGl0IG91dCBhcw0KPj4+IHNvbWV0aGluZyB0aGF0
IF9jYW5fIGhhcHBlbi4gTW9yZW92ZXIsIEkgaGF2ZSB2YWd1ZSBtZW1vcmllcyBvZiB0aGlzDQo+
Pj4gYmVpbmcgb25lIG9mIHRoZSB0ZXN0IGNhc2VzIGluIExlY3JveSdzIFVTQiBDZXJ0aWZpY2F0
aW9uIFN1aXRlLg0KPj4NCj4+IFllcywgaXQncyBzb21ldGhpbmcgdGhhdCBjYW4gaGFwcGVuLCBh
bmQgZHdjMyBzaG91bGQgYmUgYWJsZSB0byBoYW5kbGUNCj4+IGl0LiBJZiB5b3UgcmVtZW1iZXIg
d2hpY2ggdGVzdCBpbiBwYXJ0aWN1bGFyIHRoYXQgdGVzdHMgdGhpcywgbGV0IG1lDQo+PiBrbm93
LiBJIHdhbnQgdG8gY2hlY2sgaG93IGl0IHdhcyBwYXNzZWQuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5
LCBub3Qgb2ZmIHRoZSB0b3Agb2YgbXkgaGVhZC4NCj4gDQo+Pj4+IHRpbWUgYmVmb3JlIEkgY2Fu
IGNyZWF0ZSBhIHBhdGNoIGFuZCB0ZXN0IGl0LiBJZiB5b3Ugb3IgYW55b25lIGlzIHVwIHRvDQo+
Pj4+IHRha2UgdGhpcyBvbiwgaXQnZCBiZSBoaWdobHkgYXBwcmVjaWF0ZWQuDQo+Pj4NCj4+PiBC
ZWZvcmUgd2UgZ28gYWhlYWQgd3JpdGluZyBhIHBhdGNoIGZvciB0aGlzLCBJJ2QgcmVhbGx5IGxp
a2UgdG8gc2VlDQo+Pj4gdHJhY2VzIHNob3dpbmcgdGhpcyBmYWlsdXJlIGFuZCBhIG1pbmltYWwg
cmVwcm9kdWNlci4gVGhlIHJlcHJvZHVjZXINCj4+PiB3b3VsZCBwcm9iYWJseSBoYXZlIHRvIGJl
IGEgc2NyaXB0IGZvciBMZWNyb3kncyBVU0IgVHJhaW5lci4NCj4+Pg0KPj4+IEtlZXAgaW4gbWlu
ZCB0aGlzIGVudGlyZSBlcDAgc3RhY2sgdXNlZCB0byBwYXNzIFVTQkNWIG9uIGV2ZXJ5IC1yYyBh
bmQNCj4+PiBtYWpvciByZWxlYXNlIChiZWZvcmUgSSBsb3N0IGFjY2VzcyB0byBhbGwgbXkgVVNC
IGdlYXIgaGVoKS4NCj4+Pg0KPj4NCj4+IEFyZSB5b3UgcmVmZXJyaW5nIHRvIENoOSBVU0JDVj8g
SSBkb24ndCByZWNhbGwgdGhlcmUncyBhIHBhcnRpY3VsYXIgdGVzdA0KPj4gZm9yIHRoaXMuDQo+
IA0KPiBObywgbm8uIFVTQkNWIGRvZXNuJ3QgaGF2ZSB0ZXN0cyBmb3IgdGhpcy4gTGVjcm95J3Mg
VGVzdCBTdWl0ZSB3YXMgbW9yZQ0KPiBleHRlbnNpdmUgdGhhbiBVU0JDVi4gSSB3YXMgc2ltcGx5
IHNheWluZyB0aGF0IGNoYW5nZXMgdG8gZXAwIChhbmQgYW55DQo+IG9mIHRoZSBsb3cgbGV2ZWwg
Y29udHJvbCBwaXBlIGhhbmRsaW5nKSBzaG91bGQgYmUgZG9uZSB3aXRoIGNhcmUgdG8gbWFrZQ0K
PiBzdXJlIHdlIGRvbid0IGJyZWFrIGNlcnRpZmljYXRpb24gZm9yIGZvbGtzIHdobydkIGxpa2Ug
dG8gcHVyc3VlIHRoYXQNCj4gcm91dGUuDQo+IA0KDQpZZXMsIEkgYWdyZWUuDQoNCj4+IFRoZXJl
IHNob3VsZCBiZSBhIHJlZCBmbGFnIHdoZW5ldmVyIHdlIHNlZSBFbmQgVHJhbnNmZXIgY29tbWFu
ZA0KPj4gaW1tZWRpYXRlbHkgZm9sbG93cyBieSBhIFN0YXJ0IFRyYW5zZmVyIGNvbW1hbmQgd2l0
aG91dCBhbnkgd2FpdGluZyBmb3INCj4+IEVuZCBUcmFuc2ZlciBjb21wbGV0aW9uLiBUaG91Z2gs
IGluIHRoaXMgY2FzZSwgd2UgZG9uJ3QgZ28gdGhyb3VnaCB3aXRoDQo+PiB0aGUgRW5kIFRyYW5z
ZmVyIGZvciBlcDAgZHVlIHRvIHRoZSByZXNvdXJjZV9pbmRleCBjaGVjayBpbg0KPj4gZHdjM19l
cDBfZW5kX2NvbnRyb2xfZGF0YSgpLg0KPiANCj4gVW5kZXJzdG9vZC4gRG8geW91IGhhdmUgc2Ft
cGxlIHRyYWNlcyBzaG93aW5nIHRoaXMgY2FzZT8NCj4gDQoNCk5vLCBJJ2QgbmVlZCB0byBjcmVh
dGUgYSB0ZXN0IGNhc2UgZm9yIGl0Lg0KDQpCUiwNClRoaW5oDQo=
