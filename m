Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5613F55C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhHXCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:19:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52000 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232779AbhHXCTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:19:30 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 881B1C0CF8;
        Tue, 24 Aug 2021 02:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1629771525; bh=oYG/XvgYJtD8R65t5OFLxVIm+ciBB0G0d1ql1K6/ZAM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jPALk6FdWc9BCgHkkFqXgba0kxQ8UjqkNQ7r0LxeWsByBg8pcaAmUAOtyncIIW+Qa
         56IGXClFje3J1446iVqqx3mlaXETgWHnvAlqovkO7N/zsLfVEWU38Vvv/DSVONC4+c
         YS/+AMx8W446MXrVN4SK1NPs6+0JMLNoftNnIkAS3FKhJ+cZTNai8PKS40G3Z3UGyQ
         AOSjy8twHw2ivsAN74MaVzZseuxU3OQA128hb/wTQxIhajk+WHUUBSrm6ynuf9a94H
         Y/1y4orfmm6wdtBAF1I4iX7Jsxhmi+r8diSGREJg6b4nbhui1D95VlfTlKg8LDjUi2
         KrCzff3SQyf+w==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE251A006F;
        Tue, 24 Aug 2021 02:18:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (unknown [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 361F04006B;
        Tue, 24 Aug 2021 02:18:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FaGd2xDu";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDcg3S3q+XIfmu9Hwvvgss7MPcQBUaERKL8BmiVFm0Q6m+Ybd90hXAd/DYvsaHf9t/rLFV/yZGrl3BLGwAFpEcQ9dDny9gSySZvlcdPGSDKC8Netsz6K4wwHljh28X/TKwAGX3TP3i0bA0bw//HSbMcYJgMB2bHvpWQRD+iNomllpP/f4uv0u5lW329Mz1eTNcjjp0zJLTnyrcXARszXpZcp61vJfDOsUDHxxTnL6DgWONk6inNMTO/aRphbTPA3+k7D4/gFw1U29XBf45TRQ0W4Kj1/V79ltUnDTzXfJ2RVaQ5H1nJVNDv7brhqKPqKtqmxKwnUEyumVf5BdWQkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYG/XvgYJtD8R65t5OFLxVIm+ciBB0G0d1ql1K6/ZAM=;
 b=JPDMPrN3ahaeXX5QtmGrtAPoO/YUcIoEOw0IA8X/RcmA6KfKmZNv8GD+F6sZhLQf/EBgxyrOO/v3yoSho0m2mZKF6HuCUhPh9h3tQDoW3gJJFIhqZ3dU68HS5UV5obF51s8GhSuDJjZQ3LSurt7kN0tvMKMxUcvEjiiygbbdTnm6UAu3fzkYHvFlXT5n63s+iSE9OpacVy0j4HXwvmWATWdF4+v/bb0R0TROELeOKhSw+zH3rp4VpHvrdm/tfvjMOwQYLhwixWPxq6WJk8KC+kYajOjC8haZ0sjIHIsj1QEwX1cuWFH9TbgnZ9mjMtzcJ7Jr52QljFaT9QO/rRf9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYG/XvgYJtD8R65t5OFLxVIm+ciBB0G0d1ql1K6/ZAM=;
 b=FaGd2xDugh/pR+f08OwQHk9MYtSk6r+DNuTVnYHvg5sN0K8sl7Qhk8+mIaG69A4RzcebFJAwOJIVooaRP30kgzCJXy1h6ep7/D6PF10ZnggS4xmrIx6OBdNglVgJoSckcczaIuwOMCzSRAfBir742unt9PJMkbApDEiu/g55eXo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 02:18:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 02:18:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v4] usb: dwc3: gadget: Stop EP0 transfers during pullup
 disable
Thread-Topic: [PATCH v4] usb: dwc3: gadget: Stop EP0 transfers during pullup
 disable
Thread-Index: AQHXmG29Lg+UgmOHbEWN/Ed8Qa8JAquB69iA
Date:   Tue, 24 Aug 2021 02:18:40 +0000
Message-ID: <fc529936-d290-c102-1f2d-82dd5ff9cc2f@synopsys.com>
References: <20210823222458.3760-1-wcheng@codeaurora.org>
In-Reply-To: <20210823222458.3760-1-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0bc48b9-6cb6-4837-4318-08d966a57cfc
x-ms-traffictypediagnostic: BY5PR12MB4147:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41472B67753618EC2DC1B6EFAAC59@BY5PR12MB4147.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdX3heQWC7ifx2HnjQNbY+3RwaPhdQKlLDf1TnLqbviT5LjojydeXJ1Ppk59bB8dRfXWccPzXfex0iHubhAzvp3HHl/DBDOO3SbdhDl2W7r0R7GfgnNmQATHKJkSzCf4obo+bVzvIHVI+MjDGXhrrvgHpkoJBdkojaaTzpglgUauoZpaTuLpEL+p+02fZuSQXEQq/uog+QAU5iGhYLmZf9D7t7faILjjDxc7AytLRTM1URzjItw2aIrmA8/q5K46DXFxUkV9CIpJipQ5H2ALafaECSgzz0yj8EFjKX8Vysf012hQ9ju50k5Krm8R9nUZ76Im7wH/8waYbRxIEIO/mqSfDv1pfpa1gzJnifJuB5FSsuH4mdwjB0abshiKAXfXCkYjJcrxZH89yjpmSMtps9erkO0PtXHZwx4ZiAVABheBjNTd/FKQ8ZyCDfYoe6no+E0T48rUwUmmAdGh/uhWMzIeDb69E9pIVKbaxfLH7K8OG0paExlekjfqM3vKcAtXIg0oh9DbkrjRGlBVV4adTemSpPjZrdqdTvWqL3GdhYYaeh4wOQY8lLiVmQiPrhvq1YZoZLT/BNvRY9k23GlMRX1v59f4uGvuaRf1PORrjrHR6PObD7H2WCSESX1OJDbdHO3PWdvtp8Zo6EKwhc2pJmGKspw2+TA3acv30wjJLedVBWHwOSz2+3wi8e5YIfLnUCc1eMcORYxrDcVQXDieu5Da3xTv9nl+qEOazmelpJ8lfbcxXHUHeerpKHVjyC/nvYQ7MT84oPUTdeT8dO4LnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(71200400001)(186003)(8676002)(4326008)(6512007)(31686004)(8936002)(6506007)(2616005)(83380400001)(36756003)(508600001)(5660300002)(86362001)(31696002)(76116006)(26005)(316002)(122000001)(66556008)(66476007)(38070700005)(6486002)(66446008)(64756008)(66946007)(54906003)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjF3TU1KdXlDZTBMTUlRZ2FuMFBGSE5wRmZPVTFCMld2MjhDQ00xRXNmbXJ3?=
 =?utf-8?B?a3laZnRCM0UyMERzL1pUa2F5a09uaHdIMm1GeG53cStOQlFqbW5aTWxrSjgy?=
 =?utf-8?B?cUNOY0EwNTEzZmdtL1VPa01jZUVRVXhYSE9TTFJyR2dTZDJDdm03SlNsMXNF?=
 =?utf-8?B?OGJOaFlEcU52THlWTHZnaGYrc1BHd29DNFBpa1hCOVVoc21IUFovMlMyR2Rs?=
 =?utf-8?B?TSt5Ujh4WlR5WS9hRm11RUNaWXFJZzZFRFdUc3dZNldyYU5FTmQ1clZzK3M5?=
 =?utf-8?B?NlhKYk9ZSHNvaEVzQ3V1MUtMWFJZWjJLSWc1aG56ZTc1a1lZRTFPY1I2WGtw?=
 =?utf-8?B?bTJEUEMwcWxoYTFrbnZGR1RIV0FhaHlBa2IwVHJoaUV6MUliWTRGcENDOFVY?=
 =?utf-8?B?bzZQS2RkRGt4MFFEaHhaWGNvdStnV01ZM0padThCM2MybHVHMzduL2hjdW9v?=
 =?utf-8?B?ZUR2YUxjUWRYMEJ3VkZlUlhjb1BwNFBKTVFCUEFZV1lSY285WDdtYStqTWgy?=
 =?utf-8?B?bkd5RXRVOW13UGZ1MUZsdFNBZGNYYVhYWmpkOERlazk5bUkzVFEzN1Vtb0hX?=
 =?utf-8?B?Z25NT0NTUVl1Snk0ejM1Wm52bDNkYmNpL2hmL0tMOTg5VGV0b3dpbENwSjhU?=
 =?utf-8?B?V2FieEpVRXFlbXNUUjJYTlJVakRWTFhidUcrdGljNU5sdW5NdkVGcVFFWUNz?=
 =?utf-8?B?bUxCa3lIRkhjd2J0S1Q4U3ZIZDI1VkErZmlPVUlwdlJIOTZnaVNnVkJpTGR4?=
 =?utf-8?B?M0dHTTNTSmJPSy91SDFJcGxwNXNXdzBMeGsrUDV3NEx2d0VIVm1RNmRQN2VR?=
 =?utf-8?B?aDFjOGpLOU5wVXUxYkZZajc5Tms0K0pNcTlZRlhxMWZ6Smhmd1hyQmRpbmxI?=
 =?utf-8?B?Z3FXZXEvTmhjRy9iREhZb1h2TlFDSXc3VTJrekZlcGxZdURVUFhjWEFRSFVF?=
 =?utf-8?B?YlNSRHJrbDJWZnJibEdyU1ZsOTZwdHRqUGpFNko2VHRWbXBOd1FlRGVWUGhW?=
 =?utf-8?B?VXpmb25LalozQ09HRWtramZlejJCeGRsVGczMnNqREQ0TzNzS3RoamNodXFr?=
 =?utf-8?B?bHcrNE5pL2hEZlhydFN4VU5nMk1UeUE3c1NYdTBPSWFjZE96SDhob0pUSm1p?=
 =?utf-8?B?SE1penFSRCtIUzlWelUvdnFpL1ZkQjNtazdDSWhKYzV2N0p6Qkp6TWdMdHhh?=
 =?utf-8?B?K0ZmeHpTcVp6dS80dnBkc2svNFEzWk5rL2pkUGFBa2pVNVJia042TGFOY052?=
 =?utf-8?B?RDdEcDFaSWQ3QnhWVlBFT1R2UFhIckZ0UlhLZ3lCaFBVei90bDcrVkRCdi9Z?=
 =?utf-8?B?SXd3Y2Q3OVFmQ2M2cHFBL3dOU0ZGZHJRU2VYekJSSTlHR1NleGxDelI2Vllk?=
 =?utf-8?B?MngrMnhJOFZYT2x5MWg5SVE5ekppd21hYW9JR0llVE83amNoWldXUkFaTlFn?=
 =?utf-8?B?bXI0dkJ3QU1BZG9JVEhhL1QvL0p2ZXlTbWE1NFFiUCswNEZFZVdVbDh3VTNC?=
 =?utf-8?B?WXFFV2RkcXZSS0xYMHJRYkU2QWNEUUdlc2k1RHgya1Q0aW5wejFNbTFvRlpw?=
 =?utf-8?B?V254NVlqQVM4NFNRYWVsczlMUkpDYUk2WXdIRElCL2R6VWZDeis5Um5pckxj?=
 =?utf-8?B?bjh0cXBFQ3NTSVorS3Y3MzRvcUhYU0xJUGNoNFc3ZXFKQkNvRkpQRkt3YzBw?=
 =?utf-8?B?eDlOSktaWFJ3NElLbmZ4cTA1YWR1Q0tJdEZXd1hJQ3E1blY5R3RXdmFXKzdN?=
 =?utf-8?Q?oyqbuMbQGGYQ2mUpkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B80DC79F3ED0488D082EA6F1B4266A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bc48b9-6cb6-4837-4318-08d966a57cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 02:18:40.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M+f4LcQeP1WJcESeVEkcq8kXa0+ZGHVG9TST2bwmcvHXJ0BpKvg03yFoBBxWsCJJrtjEpqlmkUf7pXEmR18Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBEdXJpbmcgYSBVU0IgY2FibGUgZGlzY29ubmVjdCwgb3Ig
c29mdCBkaXNjb25uZWN0IHNjZW5hcmlvLCBhIHBlbmRpbmcNCj4gU0VUVVAgdHJhbnNhY3Rpb24g
bWF5IG5vdCBiZSBjb21wbGV0ZWQsIGxlYWRpbmcgdG8gdGhlIGZvbGxvd2luZw0KPiBlcnJvcjoN
Cj4gDQo+ICAgICBkd2MzIGE2MDAwMDAuZHdjMzogdGltZWQgb3V0IHdhaXRpbmcgZm9yIFNFVFVQ
IHBoYXNlDQo+IA0KPiBJZiB0aGlzIG9jY3VycywgdGhlbiB0aGUgZW50aXJlIHB1bGx1cCBkaXNh
YmxlIHJvdXRpbmUgaXMgc2tpcHBlZCBhbmQNCj4gcHJvcGVyIGNsZWFudXAgYW5kIGhhbHRpbmcg
b2YgdGhlIGNvbnRyb2xsZXIgZG9lcyBub3QgY29tcGxldGUuDQo+IA0KPiBJbnN0ZWFkIG9mIHJl
dHVybmluZyBhbiBlcnJvciAod2hpY2ggaXMgaWdub3JlZCBmcm9tIHRoZSBVREMNCj4gcGVyc3Bl
Y3RpdmUpLCBhbGxvdyB0aGUgcHVsbHVwIGRpc2FibGUgcm91dGluZSB0byBjb250aW51ZSwgd2hp
Y2gNCj4gd2lsbCBhbHNvIGhhbmRsZSBkaXNhYmxpbmcgb2YgRVAwLzEuICBUaGlzIHdpbGwgZW5k
IGFueSBhY3RpdmUNCj4gdHJhbnNmZXJzIGFzIHdlbGwuICBFbnN1cmUgdG8gY2xlYXIgYW55IGRl
bGF5ZWRfc3RhdHVzIGFsc28sIGFzIHRoZQ0KPiB0aW1lb3V0IGNvdWxkIGhhcHBlbiB3aXRoaW4g
dGhlIFNUQVRVUyBzdGFnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8d2No
ZW5nQGNvZGVhdXJvcmEub3JnPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gIC0gRml4ZWQg
Zm9ybWF0dGluZyBhbmQgdHlwb3MgaW4gY29tbWl0IHRleHQNCj4gIC0gUmVtb3ZlZCBicmFjZXMg
ZHVlIHRvIHRoZSByZW1vdmFsIG9mIHRoZSByZXR1cm4gc3RhdGVtZW50DQo+IA0KPiBDaGFuZ2Vz
IGluIHYzOg0KPiAgLSBBZGRlZCBzdWdnZXN0aW9uIGJ5IFRoaW5oIHRvIGNoYW5nZSBkZXZfZXJy
IHRvIGRldl93YXJuDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgLSBSZW1vdmVkIGNhbGxzIHRv
IGR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoKSBhbmQganVzdCBhbGxvdyB0aGUgZXAgZGlzYWJs
ZXMNCj4gICAgb24gRVAwIGhhbmRsZSB0aGUgcHJvcGVyIGVuZGluZyBvZiB0cmFuc2ZlcnMuDQo+
ICAtIEVuc3VyZSB0aGF0IGRlbGF5ZWRfc3RhdHVzIGlzIGNsZWFyZWQsIGFzIHJhbiBpbnRvIGVu
dW1lcmF0aW9uIGlzc3VlcyBpZiB0aGUNCj4gICAgU0VUVVAgdHJhbnNhY3Rpb24gZmFpbHMgb24g
YSBTVEFUVVMgc3RhZ2UuICBTYXcgZGVsYXllZF9zdGF0dXMgPT0gVFJVRSBvbiB0aGUNCj4gICAg
bmV4dCBjb25uZWN0LCB3aGljaCBibG9ja2VkIGZ1cnRoZXIgU0VUVVAgdHJhbnNhY3Rpb25zIHRv
IGJlIGhhbmRsZWQuDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDcgKysrLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA1ZDA4NDU0MjcxOGQuLjYzZjZkOWYyYTY5MiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IEBAIC0yNDI4LDEwICsyNDI4LDggQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4gIA0KPiAgCQly
ZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmR3Yy0+ZXAwX2luX3NldHVwLA0KPiAg
CQkJCW1zZWNzX3RvX2ppZmZpZXMoRFdDM19QVUxMX1VQX1RJTUVPVVQpKTsNCj4gLQkJaWYgKHJl
dCA9PSAwKSB7DQo+IC0JCQlkZXZfZXJyKGR3Yy0+ZGV2LCAidGltZWQgb3V0IHdhaXRpbmcgZm9y
IFNFVFVQIHBoYXNlXG4iKTsNCj4gLQkJCXJldHVybiAtRVRJTUVET1VUOw0KPiAtCQl9DQo+ICsJ
CWlmIChyZXQgPT0gMCkNCj4gKwkJCWRldl93YXJuKGR3Yy0+ZGV2LCAidGltZWQgb3V0IHdhaXRp
bmcgZm9yIFNFVFVQIHBoYXNlXG4iKTsNCj4gIAl9DQo+ICANCj4gIAkvKg0KPiBAQCAtMjY0Myw2
ICsyNjQxLDcgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KHN0cnVjdCBkd2MzICpk
d2MpDQo+ICAJLyogYmVnaW4gdG8gcmVjZWl2ZSBTRVRVUCBwYWNrZXRzICovDQo+ICAJZHdjLT5l
cDBzdGF0ZSA9IEVQMF9TRVRVUF9QSEFTRTsNCj4gIAlkd2MtPmxpbmtfc3RhdGUgPSBEV0MzX0xJ
TktfU1RBVEVfU1NfRElTOw0KPiArCWR3Yy0+ZGVsYXllZF9zdGF0dXMgPSBmYWxzZTsNCj4gIAlk
d2MzX2VwMF9vdXRfc3RhcnQoZHdjKTsNCj4gIA0KPiAgCWR3YzNfZ2FkZ2V0X2VuYWJsZV9pcnEo
ZHdjKTsNCj4gDQoNClJldmlld2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5oDQo=
