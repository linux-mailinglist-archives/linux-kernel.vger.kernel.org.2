Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7537246A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 04:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhEDCVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 22:21:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45970 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhEDCVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 22:21:38 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0909DC00AA;
        Tue,  4 May 2021 02:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620094844; bh=useweJrcsV44A9vCYOnQkEUCA/hd42wo22VqH5v5f/o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZunTS0xblsYmK1OxmZzyZFNLQxmebpxGZl54IMYV1EwAGFEFECjfbXB/lspn2kSOl
         ++NItR3vGghPeHB/AgtJXQ6a8KGXP8LgtncdjGt6Pc9t3vz9KGIgiSUffVBcIk3il1
         QAJVIOf61JNJ+flEpOgueLP1VAmtYefbh/8KW+sipDfPn7s0/bCsImjxtApybw304B
         JaXupB3eCrpmakJ6e00MdeVE8QXous85LJ/nhzz802eUB6RvBxORUTFBJjy6uzeR8t
         l/UswvhXaGlmGA6oYGMjJ2fIvgr0vVG1emihXQlx2lkVs+7FaD6CRiWPmpVce2MWcm
         RfCL5Nq3RZjYA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 52DE5A006B;
        Tue,  4 May 2021 02:20:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1E308800C5;
        Tue,  4 May 2021 02:20:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="skwb1vUH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUco46vebqAP+3WCmHKu1tKnLbRz5wxz26tZ1pZWUgumUbruYIMJi3GaKV81f0Pmneg3uCorxmV3/L1/yU8hXHW6uDulGYBovbpZxg6QB8QKMZmhVPKxQHQQhhHBL8+PNcCcNmxpdNgqOUtLiassu0FgMtWpUQ1+5njfVBFv5uJQW6JBhmSUGXe4879gfVLlN2jcWUSCDfkabqjFOTLoDAOmWs3IFt0mp5Skanbd73jbyR4hiydwhn5KS2E2owA+qVJuCBkbrolKV/ogo64M8zXYwOkBG60u9h2wlG6VxVtWxI0kDNRO/TbjEbQsBOxfJf5fQswIkWuKwzvQ5ISEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=useweJrcsV44A9vCYOnQkEUCA/hd42wo22VqH5v5f/o=;
 b=dfiVIMrK/QJ5Btk6Z8vFS/q+IO/VDL7btBvrGhYV+cxjjtAkkzh4k0xRtsG5X6zvQt5D3aFhQx3ZvZl/5YHc3rV4ItS2gE5Hat6qMVG5i3IyGi/HAiQAOE8Ok4aU0kkSoGJaAwmxaKh4LmwDMIbQRkZT4rmP2C5mlDIYqhZvNr+zBsbouws6EDBgYDCL1dQzx9JOYXlE8+WY4R9i8iWhhpEdGbK1/f44pm+YTZ3gXB6Ie8myJjmSQazfoumzmSsF8AiMHZfFATnwmggRdDlYPbqdQZv6ueDijkdycfU6U/xppg/h2029NvbO/y9ff+I0G1s7nMZ8SB7hCIL2R+YVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=useweJrcsV44A9vCYOnQkEUCA/hd42wo22VqH5v5f/o=;
 b=skwb1vUHJakpUDfa5ucUzgwsf0EL3pmFzTGMrGubNdBTnjMoDuVcq9OVvADw0S8XIYsAbNkX2y2Gz3jmT3lUzl/ozGaHgEx1hNbVhia7D+Rxp9qV8+b+if4HcLKXhfFRAR7Je2ArYPEa04QdJOYe/32/asfwuLHAZhldIb+7f7s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Tue, 4 May
 2021 02:20:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.4087.038; Tue, 4 May 2021
 02:20:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
Thread-Index: AQHXQIPY22SwGH1kNUWWUhU4M8TqE6rSlx0A
Date:   Tue, 4 May 2021 02:20:38 +0000
Message-ID: <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c4407b2-59fd-4031-3fdb-08d90ea3358d
x-ms-traffictypediagnostic: BYAPR12MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2854EB4CF446A644CC818008AA5A9@BYAPR12MB2854.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWEptxD8EnySYIoqlFw8Uks1A+JH+ExIbss4cIw/pqNZqDoY2p7a2AsVQ/P1ZnaC+X2q5P5t6vL6JiMfBo7GYInk0j06xsk2cs2Tgv2FEG58Wn7cKKQhVCuLT8V5n0blI0bMDxLf2E4LkhSstVl4EXM+85fEy52chSWaQWiOKfuMYMays17YcREVACn8Xo9gQp2Ya42xraImYqAVApLjp+tAxpF9YCcuE5jfrDBAG5tVrNr0+U/Km9IxetOZzxfEABbLY4aC7ZsSRX5wljQfgbQtxuRv0r6U6euGG+AX+3QMNAufTfT0TBrAwuHkeyipkzWS4LivFRye8m+ixkXvuBAxgiTVL5226h0QTJyHDgcAXIpuwyBDScGSfddE8X25ugwSbEUrAbfwWE+hvQwuDw5Sv8BijmbepglKSs7y2+NUrqdEpUrQs/7/nnjxYoWQ1iG/XQPojsOeCQbySK78nosOJfcTw5GlEf6PiKd6uD8Jy0Cd9oRQ3P01lu+68SOIHd1R+3iWTA90scvhL0L3gbr4YrqXbDYVS+TLqx7SKMlmrFhvu02Yj9x7/58GGnV3ZZuQxCRWq0ZRs3Y16QrEjy+Eadxj40jjo1nZcKkIKg0TJxi9El1w3zQQ05DaxWAbwIcmHY+Z5hvSfIciLXkCPMeHutko+oX7qTG8i+EJnqssnWZYFRiShGvCr5fGGWT4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(346002)(39860400002)(31696002)(122000001)(8676002)(36756003)(38100700002)(76116006)(66946007)(64756008)(66476007)(66446008)(66556008)(31686004)(8936002)(5660300002)(86362001)(186003)(26005)(83380400001)(478600001)(2906002)(4326008)(110136005)(71200400001)(54906003)(6512007)(6506007)(316002)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eTNlOXQ4RTJhZTRNNjIxenZsYmFxdFBWVERYTUlWcjNCTGlpbTR1NThVK1hY?=
 =?utf-8?B?UUdoOS9veDFWS2h4WEREY1VzL1pVMzZ3anFaOVRZK2JyUEhjWHZUSzlQVGpl?=
 =?utf-8?B?UThFWGJYMmRrOUplV2FaYWtIQ3pSTEUvOUswYTZ0dUFjWWhEb0VRTmZBY3N1?=
 =?utf-8?B?WGwrOXFSdlp5REVPUGxLK0QvZy9nb1B4aTNXVldNZFkxREdnaEo1b0g3dHVC?=
 =?utf-8?B?WTBEbVE0ZTRXakRqVC9vNERCTllHS2tRSnE0TUk4bTc1emsveUkyVWlUUXNy?=
 =?utf-8?B?N1VkWXJaTEpmN1pnanhXSDJiNXdiMk1hajMwQ0FOQ3ZjM2tQUEt5RWxuNk56?=
 =?utf-8?B?OTFad0NNRXRaRUx6SHUrWGJLbGVwR2lxZVRrWGc2TWY3ZFdxK3FibG05eCtr?=
 =?utf-8?B?T2RpVUIyM1F2NVBGSEtOK0xNa0NXMlpnN1oyeFNDWWFXaHBqdFVtTWpTbzFU?=
 =?utf-8?B?K1NkYmhUR3puQktuVDBlSDB1blRDdTNIUVJJMVVvL0NNM05UK2VLRUZpR09G?=
 =?utf-8?B?M2ZabTNTdDBpNVJLWGFsQUF5MXZ0VE9WRnRHelcwc2psdmdrd0lxdlo0R2Nz?=
 =?utf-8?B?OEl0WGlVT3Z4WGo3SE1WR2lwT1p5RG1kZU1UYllRWkxZc0tFWXYvd0pFQml1?=
 =?utf-8?B?L25RZm42aUtrSjZId2pEZ1dVUTlPSU15L01NSUFpMGlhY3ZPM1A2MkpMZ2FN?=
 =?utf-8?B?VXFuQWZyenZzNkJRMGwwTERtMGpFdHhxTzA5S01SV3d4VVBkd2N3ZTR4ajlz?=
 =?utf-8?B?NmFTNkVuM0V5WUozN3o2V0ttWW9idDJwTFgyaVJUM2U4cWU4dCtDRm5Ca1BQ?=
 =?utf-8?B?ZHN5bVZKMkR2OUkvK1Jub1NIa1VldFo0OXNTeGhUQ1ExNSs0V0t5QjRZZjRO?=
 =?utf-8?B?c051Q1BjYVJxeER3L0s4STZKYVJOMktVUnkreS9MaTNkd0JhZkFmKzU2SGxM?=
 =?utf-8?B?a2pCUzJGQjdFTzdmRklNNW5renFiT09hOWQ2VDN4VmhCWjI2UmR5YnlEc3p4?=
 =?utf-8?B?alIrNUI2Q0kzQnlkeHBhUHpnbjg1dndJWkNiQjZKTUsvR29razZOVzIxQWxC?=
 =?utf-8?B?bEcvUkJZZk1ZZ2ZEVzRQK3pCL0NnbFlwbk43Snh1ZDBDMHFqejJ5c0IxZkQ4?=
 =?utf-8?B?aGcwZ1NIU2tWY08wOWFLS2dEaHdsUFZTeXB5bVZuZTNteWNPb3lUWnJjRjBr?=
 =?utf-8?B?Y3luekxKaFZFTTMwLzdNWTlkeGIvcFliZG9YU1JNdHFMVXZaT0w3L0M3MUtU?=
 =?utf-8?B?NGZQOW9vVUdKUkM2OFE0NnZVQ2o4VGdtajFaQmVyNDhWd3RoU3R4dm8reDFp?=
 =?utf-8?B?VjFEQ01XOWRTZVptNUdzRUw3OTJzMnRmeGd4NytXU2VsK2dqbkNJMkc5KzRk?=
 =?utf-8?B?ZTJvZXF0aFE3dmxmTTdwMFdVMGFvNjVNS094WjY3cG91LzhPVUN4NEtKVEZQ?=
 =?utf-8?B?UWhzaEhYMzlmaHpySzRKS0UwWDVpcVdIc003eHVxSENkUkd1U2dpZHZzV1Br?=
 =?utf-8?B?aHZRYkJISzVNTHdBeEdYK0JYQ0pxTzVVRVVsaW5Sd1BnYUhaSDhlWUt1V3pU?=
 =?utf-8?B?KzRnQ1RhRjlMR2RYMk9ObEZzcmZYTWhTVXhXZ3hNN1A1U280azNyejQ0cGVR?=
 =?utf-8?B?aVFzN1ZERVppNG9ZMW84eUJ5Tm92OHJCOEhjTVprMnJkREV5YTRiNm9tUDRU?=
 =?utf-8?B?U3g4UHdFY0h2TkhyMHNrQnh2ZEVMY3BXVGJ2d0NuWEVpK0Q3SlpURHk0WENh?=
 =?utf-8?Q?7vNvTV5xhPGrjBwxCo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <395B29ACD9E1124BB444C88F5EAE12C5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4407b2-59fd-4031-3fdb-08d90ea3358d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 02:20:38.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1ZQDJWEdRzRbuHCvNNgFWn3CwyNZNMh5yRnBfFbIj7Oz/AmBNzvjM1ha8LWwZ+5s0tCYQDTh/St0WPnYnYAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldlc2xleSBDaGVuZyB3cm90ZToNCj4gSWYgYW4gZXJyb3IgaXMgcmVjZWl2ZWQgd2hl
biBpc3N1aW5nIGEgc3RhcnQgb3IgdXBkYXRlIHRyYW5zZmVyDQo+IGNvbW1hbmQsIHRoZSBlcnJv
ciBoYW5kbGVyIHdpbGwgc3RvcCBhbGwgYWN0aXZlIHJlcXVlc3RzIChpbmNsdWRpbmcNCj4gdGhl
IGN1cnJlbnQgVVNCIHJlcXVlc3QpLCBhbmQgY2FsbCBkd2MzX2dhZGdldF9naXZlYmFjaygpIHRv
IG5vdGlmeQ0KPiBmdW5jdGlvbiBkcml2ZXJzIG9mIHRoZSByZXF1ZXN0cyB3aGljaCBoYXZlIGJl
ZW4gc3RvcHBlZC4gIEF2b2lkDQo+IGhhdmluZyB0byBjYW5jZWwgdGhlIGN1cnJlbnQgcmVxdWVz
dCB3aGljaCBpcyB0cnlpbmcgdG8gYmUgcXVldWVkLCBhcw0KPiB0aGUgZnVuY3Rpb24gZHJpdmVy
IHdpbGwgaGFuZGxlIHRoZSBFUCBxdWV1ZSBlcnJvciBhY2NvcmRpbmdseS4NCj4gU2ltcGx5IHVu
bWFwIHRoZSByZXF1ZXN0IGFzIGl0IHdhcyBkb25lIGJlZm9yZSwgYW5kIGFsbG93IHByZXZpb3Vz
bHkNCj4gc3RhcnRlZCB0cmFuc2ZlcnMgdG8gYmUgY2xlYW5lZCB1cC4NCj4gDQoNCkl0IGxvb2tz
IGxpa2UgeW91J3JlIHN0aWxsIGxldHRpbmcgZHdjMyBzdG9wcGluZyBhbmQgY2FuY2VsbGluZyBh
bGwgdGhlDQphY3RpdmUgcmVxdWVzdHMgaW5zdGVhZCBsZXR0aW5nIHRoZSBmdW5jdGlvbiBkcml2
ZXIgZG9pbmcgdGhlIGRlcXVldWUuDQoNCkJUVywgd2hhdCBraW5kcyBvZiBjb21tYW5kIGFuZCBl
cnJvciBkbyB5b3Ugc2VlIGluIHlvdXIgc2V0dXAgYW5kIGZvcg0Kd2hhdCB0eXBlIGVuZHBvaW50
PyBJJ20gdGhpbmtpbmcgb2YgbGV0dGluZyB0aGUgZnVuY3Rpb24gZHJpdmVyIHRvDQpkZXF1ZXVl
IHRoZSByZXF1ZXN0cyBpbnN0ZWFkIG9mIGxldHRpbmcgZHdjMyBhdXRvbWF0aWNhbGx5DQplbmRp
bmcvY2FuY2VsbGluZyB0aGUgcXVldWVkIHJlcXVlc3RzLiBIb3dldmVyLCBpdCdzIGEgYml0IHRy
aWNreSB0byBkbw0KdGhhdCBpZiB0aGUgZXJyb3IgaXMgLUVUSU1FRE9VVCBzaW5jZSB3ZSdyZSBu
b3Qgc3VyZSBpZiB0aGUgY29udHJvbGxlcg0KaGFkIGFscmVhZHkgY2FjaGVkIHRoZSBUUkJzLg0K
DQpUaGlzIHNlZW1zIHRvIGFkZCBtb3JlIGNvbXBsZXhpdHkgYW5kIEkgZG9uJ3QgaGF2ZSBhIGdv
b2Qgc29sdXRpb24gdG8NCml0LiBTaW5jZSB5b3UncmUgYWxyZWFkeSBjYW5jZWxsaW5nIGFsbCB0
aGUgYWN0aXZlIHJlcXVlc3QgYW55d2F5LCB3aGF0DQpkbyB5b3UgdGhpbmsgb2YgYWx3YXlzIGxl
dHRpbmcgZHdjM19nYWRnZXRfZXBfcXVldWUoKSB0byBnbyB0aHJvdWdoIHdpdGgNCnN1Y2Nlc3Ms
IGJ1dCByZXBvcnQgZmFpbHVyZSB0aHJvdWdoIHJlcXVlc3QgY29tcGxldGlvbj8NCg0KSGkgRmVs
aXBlLCBjYW4geW91IGFsc28gY2hpbWUgaW4/DQoNClRoYW5rcywNClRoaW5oDQoNCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gLS0tDQo+
IENoYW5nZXMgaW4gdjI6DQo+ICAtIEFkZHJlc3NlZCBmZWVkYmFjayByZWNlaXZlZCBieSBtYWtp
bmcgc3VyZSB0aGUgbG9naWMgb25seSBhcHBsaWVzIHRvIGEgcmVxDQo+ICAgIHdoaWNoIGlzIGJl
aW5nIHF1ZXVlZCwgZGVjcmVtZW50aW5nIHRoZSBlbnF1ZXVlIHBvaW50ZXIsIGFuZCBvbmx5IGNs
ZWFyaW5nDQo+ICAgIHRoZSBIV08gYml0Lg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMgfCA3NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gaW5kZXggZGQ4MGU1Yy4uYzhkZGJlMSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+IEBAIC0xNDAsNiArMTQwLDI5IEBAIGludCBkd2MzX2dhZGdldF9zZXRfbGlua19zdGF0ZShz
dHJ1Y3QgZHdjMyAqZHdjLCBlbnVtIGR3YzNfbGlua19zdGF0ZSBzdGF0ZSkNCj4gIH0NCj4gIA0K
PiAgLyoqDQo+ICsgKiBkd2MzX2VwX2RlY190cmIgLSBkZWNyZW1lbnQgYSB0cmIgaW5kZXguDQo+
ICsgKiBAaW5kZXg6IFBvaW50ZXIgdG8gdGhlIFRSQiBpbmRleCB0byBpbmNyZW1lbnQuDQo+ICsg
Kg0KPiArICogVGhlIGluZGV4IHNob3VsZCBuZXZlciBwb2ludCB0byB0aGUgbGluayBUUkIuIEFm
dGVyIGRlY3JlbWVudGluZywNCj4gKyAqIGlmIGluZGV4IGlzIHplcm8sIHdyYXAgYXJvdW5kIHRv
IHRoZSBUUkIgYmVmb3JlIHRoZSBsaW5rIFRSQi4NCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgZHdj
M19lcF9kZWNfdHJiKHU4ICppbmRleCkNCj4gK3sNCj4gKwkoKmluZGV4KS0tOw0KPiArCWlmICgq
aW5kZXggPCAwKQ0KPiArCQkqaW5kZXggPSBEV0MzX1RSQl9OVU0gLSAxOw0KPiArfQ0KPiArDQo+
ICsvKioNCj4gKyAqIGR3YzNfZXBfZGVjX2VucSAtIGRlY3JlbWVudCBlbmRwb2ludCdzIGVucXVl
dWUgcG9pbnRlcg0KPiArICogQGRlcDogVGhlIGVuZHBvaW50IHdob3NlIGVucXVldWUgcG9pbnRl
ciB3ZSdyZSBkZWNyZW1lbnRpbmcNCj4gKyAqLw0KPiArc3RhdGljIHZvaWQgZHdjM19lcF9kZWNf
ZW5xKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICt7DQo+ICsJZHdjM19lcF9kZWNfdHJiKCZkZXAt
PnRyYl9lbnF1ZXVlKTsNCj4gK30NCj4gKw0KPiArLyoqDQo+ICAgKiBkd2MzX2VwX2luY190cmIg
LSBpbmNyZW1lbnQgYSB0cmIgaW5kZXguDQo+ICAgKiBAaW5kZXg6IFBvaW50ZXIgdG8gdGhlIFRS
QiBpbmRleCB0byBpbmNyZW1lbnQuDQo+ICAgKg0KPiBAQCAtMTM1Miw3ICsxMzc1LDI2IEBAIHN0
YXRpYyBpbnQgZHdjM19wcmVwYXJlX3RyYnMoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIA0KPiAg
c3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxsZWRfcmVxdWVzdHMoc3Ry
dWN0IGR3YzNfZXAgKmRlcCk7DQo+ICANCj4gLXN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNr
X3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2dhZGdl
dF9lcF9yZXZlcnRfdHJicyhzdHJ1Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0
ICpyZXEpDQo+ICt7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlpZiAoIXJlcS0+dHJiKQ0KPiArCQly
ZXR1cm47DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgcmVxLT5udW1fdHJiczsgaSsrKSB7DQo+
ICsJCXN0cnVjdCBkd2MzX3RyYiAqdHJiOw0KPiArDQo+ICsJCXRyYiA9ICZkZXAtPnRyYl9wb29s
W2RlcC0+dHJiX2VucXVldWVdOw0KPiArCQl0cmItPmN0cmwgJj0gfkRXQzNfVFJCX0NUUkxfSFdP
Ow0KPiArCQlkd2MzX2VwX2RlY19lbnEoZGVwKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXEtPm51bV90
cmJzID0gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJh
bnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gKwkJCQkgICAgICAgc3RydWN0IGR3YzNfcmVx
dWVzdCAqcXVldWVkX3JlcSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3Bh
cmFtcyBwYXJhbXM7DQo+ICAJc3RydWN0IGR3YzNfcmVxdWVzdAkJKnJlcTsNCj4gQEAgLTE0MTAs
OCArMTQ1MiwyMyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1
Y3QgZHdjM19lcCAqZGVwKQ0KPiAgDQo+ICAJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVw
LCB0cnVlLCB0cnVlKTsNCj4gIA0KPiAtCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0
bXAsICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkNCj4gLQkJCWR3YzNfZ2FkZ2V0X21vdmVfY2Fu
Y2VsbGVkX3JlcXVlc3QocmVxLCBEV0MzX1JFUVVFU1RfU1RBVFVTX0RFUVVFVUVEKTsNCj4gKwkJ
LyoNCj4gKwkJICogSW4gb3JkZXIgdG8gZW5zdXJlIHRoZSBsb2dpYyBpcyBhcHBsaWVkIHRvIGEg
cmVxdWVzdCBiZWluZw0KPiArCQkgKiBxdWV1ZWQgYnkgZHdjM19nYWRnZXRfZXBfcXVldWUoKSwg
aXQgbmVlZHMgdG8gZXhwbGljaXRseQ0KPiArCQkgKiBjaGVjayB0aGF0IHJlcSBpcyB0aGUgc2Ft
ZSBhcyBxdWV1ZWRfcmVxIChyZXF1ZXN0IGJlaW5nDQo+ICsJCSAqIHF1ZXVlZCkuICBJZiBzbywg
dGhlbiBqdXN0IHVubWFwIGFuZCBkZWNyZW1lbnQgdGhlIGVucXVldWUNCj4gKwkJICogcG9pbnRl
ciwgYXMgdGhlIHVzYl9lcF9xdWV1ZSgpIGVycm9yIGhhbmRsZXIgaW4gdGhlIGZ1bmN0aW9uDQo+
ICsJCSAqIGRyaXZlciB3aWxsIGhhbmRsZSBjbGVhbmluZyB1cCB0aGUgVVNCIHJlcXVlc3QuDQo+
ICsJCSAqLw0KPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAsICZkZXAtPnN0
YXJ0ZWRfbGlzdCwgbGlzdCkgew0KPiArCQkJaWYgKHJlcSA9PSBxdWV1ZWRfcmVxKSB7DQo+ICsJ
CQkJZHdjM19nYWRnZXRfZXBfcmV2ZXJ0X3RyYnMoZGVwLCByZXEpOw0KPiArCQkJCWR3YzNfZ2Fk
Z2V0X2RlbF9hbmRfdW5tYXBfcmVxdWVzdChkZXAsIHJlcSwgcmV0KTsNCj4gKwkJCX0gZWxzZSB7
DQo+ICsJCQkJZHdjM19nYWRnZXRfbW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEsDQo+ICsJCQkJ
CQkJCSAgIERXQzNfUkVRVUVTVF9TVEFUVVNfREVRVUVVRUQpOw0KPiArCQkJfQ0KPiArCQl9DQo+
ICANCj4gIAkJLyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5vIGVuZCB0cmFu
c2ZlciBwZW5kaW5nICovDQo+ICAJCWlmICghKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFO
U0ZFUl9QRU5ESU5HKSkNCj4gQEAgLTE1NDYsNyArMTYwMyw3IEBAIHN0YXRpYyBpbnQgZHdjM19n
YWRnZXRfc3RhcnRfaXNvY19xdWlyayhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgCWRlcC0+c3Rh
cnRfY21kX3N0YXR1cyA9IDA7DQo+ICAJZGVwLT5jb21ib19udW0gPSAwOw0KPiAgDQo+IC0JcmV0
dXJuIF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXApOw0KPiArCXJldHVybiBfX2R3YzNf
Z2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwLCBOVUxMKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlu
dCBfX2R3YzNfZ2FkZ2V0X3N0YXJ0X2lzb2Moc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gQEAgLTE1
OTMsNyArMTY1MCw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9zdGFydF9pc29jKHN0cnVj
dCBkd2MzX2VwICpkZXApDQo+ICAJZm9yIChpID0gMDsgaSA8IERXQzNfSVNPQ19NQVhfUkVUUklF
UzsgaSsrKSB7DQo+ICAJCWRlcC0+ZnJhbWVfbnVtYmVyID0gRFdDM19BTElHTl9GUkFNRShkZXAs
IGkgKyAxKTsNCj4gIA0KPiAtCQlyZXQgPSBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVw
KTsNCj4gKwkJcmV0ID0gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCwgTlVMTCk7DQo+
ICAJCWlmIChyZXQgIT0gLUVBR0FJTikNCj4gIAkJCWJyZWFrOw0KPiAgCX0NCj4gQEAgLTE2ODQs
NyArMTc0MSw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9xdWV1ZShzdHJ1Y3QgZHdj
M19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEpDQo+ICAJCX0NCj4gIAl9DQo+ICAN
Cj4gLQlyZXR1cm4gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCk7DQo+ICsJcmV0dXJu
IF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXAsIHJlcSk7DQo+ICB9DQo+ICANCj4gIHN0
YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1
c2JfcmVxdWVzdCAqcmVxdWVzdCwNCj4gQEAgLTE4OTMsNyArMTk1MCw3IEBAIGludCBfX2R3YzNf
Z2FkZ2V0X2VwX3NldF9oYWx0KHN0cnVjdCBkd2MzX2VwICpkZXAsIGludCB2YWx1ZSwgaW50IHBy
b3RvY29sKQ0KPiAgDQo+ICAJCWlmICgoZGVwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RBUlQp
ICYmDQo+ICAJCSAgICAhdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2Mp
KQ0KPiAtCQkJX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCk7DQo+ICsJCQlfX2R3YzNf
Z2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwLCBOVUxMKTsNCj4gIA0KPiAgCQlkZXAtPmZsYWdzICY9
IH5EV0MzX0VQX0RFTEFZX1NUQVJUOw0KPiAgCX0NCj4gQEAgLTI5OTIsNyArMzA0OSw3IEBAIHN0
YXRpYyBib29sIGR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYnNfY29tcGxldGUoc3RydWN0IGR3YzNf
ZXAgKmRlcCwNCj4gIAkJKGxpc3RfZW1wdHkoJmRlcC0+cGVuZGluZ19saXN0KSB8fCBzdGF0dXMg
PT0gLUVYREVWKSkNCj4gIAkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRy
dWUpOw0KPiAgCWVsc2UgaWYgKGR3YzNfZ2FkZ2V0X2VwX3Nob3VsZF9jb250aW51ZShkZXApKQ0K
PiAtCQlpZiAoX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCkgPT0gMCkNCj4gKwkJaWYg
KF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXAsIE5VTEwpID09IDApDQo+ICAJCQlub19z
dGFydGVkX3RyYiA9IGZhbHNlOw0KPiAgDQo+ICBvdXQ6DQo+IEBAIC0zMTA2LDcgKzMxNjMsNyBA
QCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lbmRwb2ludF9jb21tYW5kX2NvbXBsZXRlKHN0cnVj
dCBkd2MzX2VwICpkZXAsDQo+ICANCj4gIAlpZiAoKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZ
X1NUQVJUKSAmJg0KPiAgCSAgICAhdXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50
LmRlc2MpKQ0KPiAtCQlfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwKTsNCj4gKwkJX19k
d2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCwgTlVMTCk7DQo+ICANCj4gIAlkZXAtPmZsYWdz
ICY9IH5EV0MzX0VQX0RFTEFZX1NUQVJUOw0KPiAgfQ0KPiANCg0K
