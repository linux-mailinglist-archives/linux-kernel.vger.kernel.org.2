Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D404E3ECC19
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 02:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhHPAdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 20:33:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39988 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhHPAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 20:33:40 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C3B27C0145;
        Mon, 16 Aug 2021 00:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1629073990; bh=BSuFWYTL1bVa81aB+z76CbyX+mfGpGpqv0mYj6YAGpQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RyQSau/a6uFEgCLoNRKZVbJiDUFcG/ifsAcNUYSV2+lLrvrF4M12EzCODGzDoiLzH
         nKiDgtQGJtzHv2QjncbwVPpzofodj4FrXumwQgRWm24UDIj/uv5Lgl1vgjgme71UEL
         MZwLBFhdQsC4m3NLoiQd/5zfh0KCnDXH9qlR0poQUdP5iVK51YlNX07Vz5ZKJ6/QuZ
         a83kMyF644SWYNFqK3max+BhatuWJix57OfV9xN3GgaMjiD5C3Ps8PiUasUXF80nue
         qBNGpalLwBfjOui0xhUHt6fZ+sKXJ4tTgfUgdqSep5GqEEhmpHv70N7U432HNh4xGV
         McWgGxclbZ+yw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A1FCEA0084;
        Mon, 16 Aug 2021 00:33:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 229D240097;
        Mon, 16 Aug 2021 00:33:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="obVTZbER";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAj0hKkZp/SSf0l77y+EiySL4jnAORGyVKsB7opMlzqc2449fM/DMwlHfGzcPo5pqrXwnq/VntpZndwQXFT2zNXT+wDXco8KH/rBKnfJx9Xn+PTPFGhYHYQ5X5zqAsZ99vLRtNyCSn3bRJCtmXNAR0Mhp/wkKH1xcbRa1Hd9heIEZgmqXcCusvvevLoGfGA9qMvSXGjsj0qnjYXzYynyAVeXvAD7k1+QWVpr0w7fPTlz3Ftx3/EgRq3U+aeV53zIz6uEP0+hBPyPqJ+1NgiqFrvbJRbiQZ/tIttqb59oc+WUmUjImvTJhF9F3o2ocD8KLNxDcQtNdCjQi4tm6DIPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSuFWYTL1bVa81aB+z76CbyX+mfGpGpqv0mYj6YAGpQ=;
 b=RsxSOUz3LBGCx5hZaN02OTegKR5Xmt6osa07EMX1mJsGqNSom6Nzlkd6xRj74oJBfKygnUEJy5FGkypQtO6pFCMFIyoBSRWPnNtmXz1c5fmY0VS2qNKwmaczrglJMiSCkjCM5UAZ6HBVzaOXp7qMqs9RP6NHw4R7gA2W79j4hHQmd0Ud18u4TJXiOa0qGNACc/Ma9e75GgAbhMFrUw5TKVd+iRuBWBfO9noax8tHTsRVZ1e1bQJPHBwZjsiBAfPQb+LZMAP+DIffUNWTI+TYvC/NxS6LB/g/9rgpoASCMXzTO/X6vz2DupqDPO/lxospFsEt5rvUtxzLx6/X3r/FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSuFWYTL1bVa81aB+z76CbyX+mfGpGpqv0mYj6YAGpQ=;
 b=obVTZbERJsjaBr3+Jf8r5dhwdv81lE5Z2+Vid/o7QvSvwqMUFnycPrisP92LAUkDpkjcykJA5XFd6ZVFm5Qhmz1fRKxeI0l22fFLcr6vXsQbjFP1bXNZzjQ8bn/E6/LwAckBwhMWJZ8IBWSe8foTnkJ8P1r12NeZn/Xouh16XsQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3015.namprd12.prod.outlook.com (2603:10b6:a03:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 00:33:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 00:33:02 +0000
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
Thread-Index: AQHXjlfnBCk6lwHDK0Kvf9A7ww7BQqtvCnaAgAETMgCAAEh3AIAAHhwAgAGTEQCAAAe1gIAAC4YAgAGREQCAAF71AIABNUyA
Date:   Mon, 16 Aug 2021 00:33:02 +0000
Message-ID: <89b4d57c-f44a-ceff-45f3-a308e1d8d135@synopsys.com>
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
In-Reply-To: <875yw7jkz6.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d1dab43-733e-40c8-bc0d-08d9604d6804
x-ms-traffictypediagnostic: BYAPR12MB3015:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB301515262029D34FFCCEB9B3AAFD9@BYAPR12MB3015.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BB0VL5Vmw+Uwkn4Ytnt5J5sB+vTqJyZY+YsIj3xgDRC6YEXAWmtwYDpbqSOzrdhAN0GG/ieadnp8y/2wWoQgkw+GeziMkJToxWte4lyDpwR7GqdYzLupVRH7vym354G0bfwlxer/WZ0YUAtoJvNyr7WbwoBm9CGl+hvbbnO/6c77fAObVpvQgr0gu/TzBMzJHmlpJa4bFDIC9amCxOs1+xUAbZk6wa81waJ/3GwBURmnruIT9kWvD+8ITHwbWqAlgoxdT4lgOawfSN5ZNV7ncafN4x9FEWb6UdbYMiyB3IdQpPUCvkZ/Ne+sGc642t+AYWM1bP0nDpiwvN5WMhdNqAQneIEaR8SYs784PAZQBsZV+zT9SOkygM9kfXH5rCQispptkxiHsvNU+gXXgtAlhCtmJVWBucmddlcNVmuUbWB7FrDgkv/wfhU1ExmYF/M0imz6Yn8htteW0wlP+SmPr4KunPsqgc5pnxX7w+yxQ/iveY1ldq3r87jcxZyuNsvZEXNRHXARcOSKi4b2BxQTnWWf8h55mNJJ77526V9Xu6/r0iaWyhNciggqoAcNkhVs+FSbKHTDjWHhAZz4U0agIpcniW5zcrG2Px9rgrcfJ63Na8s44V90eAWDvSQ75EtcgQJ44hXuc1Vlq6ARtHE+l0TPchp76dlupNOYcl21rcgPZ0hREL2wQmLWjcZ7G3ft7rwEI5upCiRNtxHzaJfRj38rFaNmixPnKnzwdwLNS0liyNAgaEGmkp8yQGl6A/duRBlTbtY6b4a/E9b87XaoOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39850400004)(376002)(136003)(122000001)(31686004)(316002)(8936002)(71200400001)(31696002)(26005)(38100700002)(86362001)(2906002)(66946007)(66556008)(76116006)(2616005)(64756008)(66476007)(66446008)(5660300002)(478600001)(6512007)(110136005)(186003)(8676002)(54906003)(6486002)(4326008)(6506007)(83380400001)(38070700005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1NM3A2MzdjTU1wRmJJNFZpeWdsckU0dEhGVkhJNDJRQzRLRWE5bUViT1Iy?=
 =?utf-8?B?NngwVW5VV0tlWXJJYTFyb1RUS045K29WMUJGNk56bnFRenYvUXNvRTdXd2gw?=
 =?utf-8?B?Mml1ZS95QXJNd1FmRUtGaXIyTkxKL2V0YWRzQWVwcXVkS0I4em5FbExBWDlV?=
 =?utf-8?B?bk5mTjA4TC80VWgyYkNoN2tzUWorYnBpbGdmL2VFUmFTRDZCR2lVV2tPSkgw?=
 =?utf-8?B?d3FPSTV5ZGpFZjZia1pLZmw4Wk40N2h3QllLZ3EzNkU5ZElwaGRLWTVpeUJl?=
 =?utf-8?B?MzQxdWo3cDVYbGxQbGtnTkMzMjVzZXlJS2djMTAvOHRudWV5ZDh2UGVqOUpD?=
 =?utf-8?B?a2REcitMZHh2SmcyNzFkejdveER3amNQM3ZNc1lBc3lzRUZyTEkzeEpNdDI4?=
 =?utf-8?B?Z1NkaGhYRVBONEFoQ0RJWWYwVFNNYS9JL004cnJVZWM4dnNkTXdPTVhweEZl?=
 =?utf-8?B?K3Z3aXZadFk1QzByUmkxRGUydFpNbXpsSW9JNEVxRUVzamVVWkNUMUZYaHVS?=
 =?utf-8?B?ckZnNVBLczQ0SHpsbXdub3dGZDZzK0VtWFA1eTg2anRtVVMyVVFOYXVLOUQ2?=
 =?utf-8?B?TDZ4N0ROeU5vVjh4UGZabG5TOHk2eW5DWFI2TXByRHlIVlY5V1E1NTVtUUdJ?=
 =?utf-8?B?enFTZTJhcTlEY2FXTDg5Y28xVmVuNWV3YTdMc3ZyUUNxYUl1dExXbzMrM1N1?=
 =?utf-8?B?Uk1BUk4rekRuTDBqaEJXenpHSm9ZUWJVR1dvb3NhMlByL2ZoWmZVcWNGMUM2?=
 =?utf-8?B?SW5wMlYwbldFZG8zenozd3FubDF0Qk8vbElGeTcwUHAwdk9JL0xQc2RuL3Bh?=
 =?utf-8?B?bU11N1lRMElrcVlGeFpsbGVveVZrclpydGVIbGsyVlN1ZUVZTXB0Tmpjb1pL?=
 =?utf-8?B?eVBCRnYzVVh4Q09uaWlhc0tMaFp2cnMwQUJXSFJxWFBSUHgyelFQRDNBRjFE?=
 =?utf-8?B?OUM3ZDFDR2tOTVVMY2RKNUdrNE02Vkl3b242eVZybGhjTG01WUpxKytQWlB0?=
 =?utf-8?B?V2hWUWtSNWRnMnE4NHZkL0NCL2Q0bVJnbGY0NVUvL1luMUgyVHNBK05uSW14?=
 =?utf-8?B?MGk2dE5FZmJBTlowc0FvV0l0UVdTdjJ3WDk2WFk1ckV5VVZ0Z0ZteWxSR09Y?=
 =?utf-8?B?WVlIc1lRcHhMRlA4WXBTY0pSWGZidDBpeWc3OVBYYjVNOGxNOTIzWkJDS1NH?=
 =?utf-8?B?R1RjZUpreE1Ha2RvejFWeWZxNTlZbnFLMHk3d2hQNTRYcG9CVitWWEg3OHJP?=
 =?utf-8?B?dVpFM044N1I3OHUvMTZwdm9lQWhDTGdMb0dHN2ZnQzhBWEh1THpmNFVsZE8w?=
 =?utf-8?B?Z09zOTY0ODFvd0NOc1MzMGExeUR6R2huTmY3emdDb0IyZmExL0Q2ZEI3Zml4?=
 =?utf-8?B?MjhxaFBTMnhUWUZmaEg4bFB6c256L0hXeW01SjhpU28wbmJ4NlZ5clV1RXRm?=
 =?utf-8?B?S0xVdW1kR0EzNWZQQzZ2TGR4OXZIcGhWdFJhQUVsN2JRNDJvR2xRSTEzUERa?=
 =?utf-8?B?NWhYK2xtY3U1djNjOVJjZGtlRExjd2ZlSjFpckVrb3V5aUxhNWtTd1ZmNFBt?=
 =?utf-8?B?Q0Mzc0grUlNQemxNS1dEYmlwT3pvdHQ1anBrOGZJSlovYkdwcE5RN3BKYTBx?=
 =?utf-8?B?ZExHYkh6aEJ2NWltSisybVAxVUxNbFp3SU84ZkVkL3Y4M0YzdEwzeTZTOHBB?=
 =?utf-8?B?WnQxcXdPT1RzU0I3NTc3bk1sNEpZbllvUkdYRmY4dUVRR1BBc2FFMmlQZEpz?=
 =?utf-8?Q?8U5/wguwdub0zS9TkQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D23E6C0D1CF4094290B82019CACEAA36@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1dab43-733e-40c8-bc0d-08d9604d6804
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 00:33:02.1535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8vAc4Wqam2jl0aUV8nRS44rKmOkc4ArPlzJcYJudH+u78FgPaai63U3xaJ8x+EvlkQ/Tz1QoIXt35MUSSM1ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmVsaXBlIEJhbGJpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+IHdyaXRlczoNCj4+Pj4+Pj4+Pj4gSWYgdGhpcyBvY2N1cnMs
IHRoZW4gdGhlIGVudGlyZSBwdWxsdXAgZGlzYWJsZSByb3V0aW5lIGlzIHNraXBwZWQgYW5kDQo+
Pj4+Pj4+Pj4+IHByb3BlciBjbGVhbnVwIGFuZCBoYWx0aW5nIG9mIHRoZSBjb250cm9sbGVyIGRv
ZXMgbm90IGNvbXBsZXRlLg0KPj4+Pj4+Pj4+PiBJbnN0ZWFkIG9mIHJldHVybmluZyBhbiBlcnJv
ciAod2hpY2ggaXMgaWdub3JlZCBmcm9tIHRoZSBVREMNCj4+Pj4+Pj4+Pj4gcGVyc3BlY3RpdmUp
LCBkbyB3aGF0IGlzIG1lbnRpb25lZCBpbiB0aGUgY29tbWVudHMgYW5kIGZvcmNlIHRoZQ0KPj4+
Pj4+Pj4+PiB0cmFuc2FjdGlvbiB0byBjb21wbGV0ZSBhbmQgcHV0IHRoZSBlcDBzdGF0ZSBiYWNr
IHRvIHRoZSBTRVRVUCBwaGFzZS4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogV2VzbGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+Pj4+Pj4+Pj4+IC0tLQ0K
Pj4+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDQgKystLQ0KPj4+Pj4+Pj4+
PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDYgKysrKystDQo+Pj4+Pj4+Pj4+ICBkcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5oIHwgMyArKysNCj4+Pj4+Pj4+Pj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2VwMC5jDQo+Pj4+Pj4+Pj4+IGluZGV4IDY1ODczOTQuLmFiZmM0MmIgMTAwNjQ0DQo+Pj4+Pj4+
Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9lcDAuYw0KPj4+Pj4+Pj4+PiBAQCAtMjE4LDcgKzIxOCw3IEBAIGludCBkd2Mz
X2dhZGdldF9lcDBfcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAq
cmVxdWVzdCwNCj4+Pj4+Pj4+Pj4gIAlyZXR1cm4gcmV0Ow0KPj4+Pj4+Pj4+PiAgfQ0KPj4+Pj4+
Pj4+PiAgDQo+Pj4+Pj4+Pj4+IC1zdGF0aWMgdm9pZCBkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFy
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+Pj4+Pj4+PiArdm9pZCBkd2MzX2VwMF9zdGFsbF9hbmRf
cmVzdGFydChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPj4+Pj4+Pj4+PiAgew0KPj4+Pj4+Pj4+PiAgCXN0
cnVjdCBkd2MzX2VwCQkqZGVwOw0KPj4+Pj4+Pj4+PiAgDQo+Pj4+Pj4+Pj4+IEBAIC0xMDczLDcg
KzEwNzMsNyBAQCB2b2lkIGR3YzNfZXAwX3NlbmRfZGVsYXllZF9zdGF0dXMoc3RydWN0IGR3YzMg
KmR3YykNCj4+Pj4+Pj4+Pj4gIAlfX2R3YzNfZXAwX2RvX2NvbnRyb2xfc3RhdHVzKGR3YywgZHdj
LT5lcHNbZGlyZWN0aW9uXSk7DQo+Pj4+Pj4+Pj4+ICB9DQo+Pj4+Pj4+Pj4+ICANCj4+Pj4+Pj4+
Pj4gLXN0YXRpYyB2b2lkIGR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3
Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4+Pj4+Pj4+Pj4gK3ZvaWQgZHdjM19lcDBfZW5kX2Nv
bnRyb2xfZGF0YShzdHJ1Y3QgZHdjMyAqZHdjLCBzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPj4+Pj4+
Pj4+PiAgew0KPj4+Pj4+Pj4+PiAgCXN0cnVjdCBkd2MzX2dhZGdldF9lcF9jbWRfcGFyYW1zIHBh
cmFtczsNCj4+Pj4+Pj4+Pj4gIAl1MzIJCQljbWQ7DQo+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+
Pj4+Pj4+PiBpbmRleCA1NGM1YTA4Li5hMGUyZTRkIDEwMDY0NA0KPj4+Pj4+Pj4+PiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4+Pj4gQEAgLTI0MzcsNyArMjQzNywxMSBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3B1bGx1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGlzX29uKQ0KPj4+
Pj4+Pj4+PiAgCQkJCW1zZWNzX3RvX2ppZmZpZXMoRFdDM19QVUxMX1VQX1RJTUVPVVQpKTsNCj4+
Pj4+Pj4+Pj4gIAkJaWYgKHJldCA9PSAwKSB7DQo+Pj4+Pj4+Pj4+ICAJCQlkZXZfZXJyKGR3Yy0+
ZGV2LCAidGltZWQgb3V0IHdhaXRpbmcgZm9yIFNFVFVQIHBoYXNlXG4iKTsNCj4+Pj4+Pj4+Pj4g
LQkJCXJldHVybiAtRVRJTUVET1VUOw0KPj4+Pj4+Pj4+PiArCQkJc3Bpbl9sb2NrX2lycXNhdmUo
JmR3Yy0+bG9jaywgZmxhZ3MpOw0KPj4+Pj4+Pj4+PiArCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xf
ZGF0YShkd2MsIGR3Yy0+ZXBzWzBdKTsNCj4+Pj4+Pj4+Pj4gKwkJCWR3YzNfZXAwX2VuZF9jb250
cm9sX2RhdGEoZHdjLCBkd2MtPmVwc1sxXSk7DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBFbmQgdHJh
bnNmZXIgY29tbWFuZCB0YWtlcyB0aW1lLCBuZWVkIHRvIHdhaXQgZm9yIGl0IHRvIGNvbXBsZXRl
IGJlZm9yZQ0KPj4+Pj4+Pj4+IGlzc3VpbmcgU3RhcnQgdHJhbnNmZXIgYWdhaW4uIEFsc28sIHdo
eSByZXN0YXJ0IGFnYWluIHdoZW4gaXQncyBhYm91dCB0bw0KPj4+Pj4+Pj4+IGJlIGRpc2Nvbm5l
Y3RlZC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJIGNhbiB0cnkgd2l0aG91dCByZXN0YXJ0aW5nIGl0
IGFnYWluLCBhbmQgc2VlIGlmIHRoYXQgd29ya3MuICBJbnN0ZWFkDQo+Pj4+Pj4+PiBvZiB3YWl0
aW5nIGZvciB0aGUgY29tbWFuZCBjb21wbGV0ZSBldmVudCwgY2FuIHdlIHNldCB0aGUgRm9yY2VS
TSBiaXQsDQo+Pj4+Pj4+PiBzaW1pbGFyIHRvIHdoYXQgd2UgZG8gZm9yIGR3YzNfcmVtb3ZlX3Jl
cXVlc3RzKCk/DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBGb3JjZVJNPTEgbWVhbnMgdGhh
dCB0aGUgY29udHJvbGxlciB3aWxsIGlnbm9yZSB1cGRhdGluZyB0aGUgVFJCcw0KPj4+Pj4+PiAo
aW5jbHVkaW5nIG5vdCBjbGVhcmluZyB0aGUgSFdPIGFuZCByZW1haW4gdHJhbnNmZXIgc2l6ZSku
IFRoZSBkcml2ZXINCj4+Pj4+Pj4gc3RpbGwgbmVlZHMgdG8gd2FpdCBmb3IgdGhlIGNvbW1hbmQg
dG8gY29tcGxldGUgYmVmb3JlIGlzc3VpbmcgU3RhcnQNCj4+Pj4+Pj4gVHJhbnNmZXIgY29tbWFu
ZC4gT3RoZXJ3aXNlIFN0YXJ0IFRyYW5zZmVyIHdvbid0IGdvIHRocm91Z2guIElmIHdlIGtub3cN
Cj4+Pj4+Pj4gdGhhdCB3ZSdyZSBub3QgZ29pbmcgdG8gaXNzdWUgU3RhcnQgVHJhbnNmZXIgYW55
IHRpbWUgc29vbiwgdGhlbiB3ZSBtYXkNCj4+Pj4+Pj4gYmUgYWJsZSB0byBnZXQgYXdheSB3aXRo
IGlnbm9yaW5nIEVuZCBUcmFuc2ZlciBjb21tYW5kIGNvbXBsZXRpb24uDQo+Pj4+Pj4+DQo+Pj4+
Pj4NCj4+Pj4+PiBJIHNlZS4gIEN1cnJlbnRseSwgaW4gdGhlIHBsYWNlIHRoYXQgd2UgZG8gdXNl
DQo+Pj4+Pj4gZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YSgpLCBpdHMgZm9sbG93ZWQgYnkNCj4+
Pj4+PiBkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydCgpIHdoaWNoIHdvdWxkIGV4ZWN1dGUgc3Rh
cnQgdHJhbnNmZXIuICBGb3INCj4+Pj4+DQo+Pj4+PiBUaGF0IGRvZXNuJ3QgbG9vayByaWdodC4g
WW91IGNhbiB0cnkgdG8gc2VlIGlmIGl0IGNhbiByZWNvdmVyIGZyb20gYQ0KPj4+Pj4gY29udHJv
bCB3cml0ZSByZXF1ZXN0LiBPZnRlbiB0aW1lIHdlIGRvIGNvbnRyb2wgcmVhZCBhbmQgbm90IHdy
aXRlLg0KPj4+Pj4gKGkuZS4gdHJ5IHRvIEVuZCBUcmFuc2ZlciBhbmQgaW1tZWRpYXRlbHkgU3Rh
cnQgVHJhbnNmZXIgb24gdGhlIHNhbWUNCj4+Pj4+IGRpcmVjdGlvbiBjb250cm9sIGVuZHBvaW50
KS4NCj4+Pj4+DQo+Pj4+IE9LLCBJIGNhbiB0cnksIGJ1dCBqdXN0IHRvIGNsYXJpZnksIEkgd2Fz
IHJlZmVycmluZyB0byBob3cgaXQgd2FzIGJlaW5nDQo+Pj4+IGRvbmUgaW46DQo+Pj4+DQo+Pj4+
IHN0YXRpYyB2b2lkIGR3YzNfZXAwX3hmZXJub3RyZWFkeShzdHJ1Y3QgZHdjMyAqZHdjLA0KPj4+
PiAJCWNvbnN0IHN0cnVjdCBkd2MzX2V2ZW50X2RlcGV2dCAqZXZlbnQpDQo+Pj4+IHsNCj4+Pj4g
Li4uDQo+Pj4+IAkJaWYgKGR3Yy0+ZXAwX2V4cGVjdF9pbiAhPSBldmVudC0+ZW5kcG9pbnRfbnVt
YmVyKSB7DQo+Pj4+IAkJCXN0cnVjdCBkd2MzX2VwCSpkZXAgPSBkd2MtPmVwc1tkd2MtPmVwMF9l
eHBlY3RfaW5dOw0KPj4+Pg0KPj4+PiAJCQlkZXZfZXJyKGR3Yy0+ZGV2LCAidW5leHBlY3RlZCBk
aXJlY3Rpb24gZm9yIERhdGEgUGhhc2VcbiIpOw0KPj4+PiAJCQlkd2MzX2VwMF9lbmRfY29udHJv
bF9kYXRhKGR3YywgZGVwKTsNCj4+Pj4gCQkJZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQoZHdj
KTsNCj4+Pj4gCQkJcmV0dXJuOw0KPj4+PiAJCX0NCj4+Pj4NCj4+DQo+PiBMb29raW5nIGF0IHRo
aXMgc25pcHBldCBhZ2FpbiwgaXQgbG9va3Mgd3JvbmcuIEZvciBjb250cm9sIHdyaXRlDQo+PiB1
bmV4cGVjdGVkIGRpcmVjdGlvbiwgaWYgdGhlIGRyaXZlciBoYXNuJ3Qgc2V0dXAgYW5kIHN0YXJ0
ZWQgdGhlIERBVEENCj4+IHBoYXNlIHlldCwgdGhlbiBpdCdzIGZpbmUsIGJ1dCB0aGVyZSBpcyBh
IHByb2JsZW0gaWYgaXQgZGlkLg0KPj4NCj4+IFNpbmNlIGR3YzNfZXAwX2VuZF9jb250cm9sX2Rh
dGEoKSBkb2Vzbid0IGlzc3VlIEVuZCBUcmFuc2ZlciBjb21tYW5kIHRvDQo+PiBlcDAgZHVlIHRv
IHRoZSByZXNvdXJjZV9pbmRleCBjaGVjaywgaXQgZG9lc24ndCBmb2xsb3cgdGhlIGNvbnRyb2wN
Cj4gDQo+IElJUkMgcmVzb3VyY2VfaW5kZXggaXMgYWx3YXlzIG5vbi16ZXJvLCBzbyB0aGUgY29t
bWFuZCBzaG91bGQgYmUNCg0KTm8sIHJlc291cmNlX2luZGV4IGZvciBlcDBvdXQgaXMgMCwgZXAw
aW4gaXMgMS4gWW91IGNhbiBjaGVjayBmcm9tIGFueQ0Kb2YgdGhlIGRyaXZlciB0cmFjZXBvaW50
IGxvZyBmb3IgdGhlIHJldHVybiB2YWx1ZSBvZiBTdGFydCBUcmFuc2Zlcg0KY29tbWFuZCBmb3Ig
dGhlIHJlc291cmNlIGluZGV4IG9mIGVwMC4gVGhlcmUgY291bGQgYmUgYSBtaXhlZCB1cCB3aXRo
DQp0aGUgdW5kb2N1bWVudGVkIHJldHVybiB2YWx1ZSBvZiBTZXQgRW5kcG9pbnQgVHJhbnNmZXIg
UmVzb3VyY2UgY29tbWFuZA0KYmVmb3JlIHdoZW4gdGhpcyBjb2RlIHdhcyB3cml0dGVuLCBkb24n
dCBtaXggdXAgd2l0aCB0aGF0Lg0KDQo+IHRyaWdnZXJlZC4gSWYgeW91IGhhdmUgYWNjZXNzIHRv
IGEgTGVjcm95IFVTQiBUcmFpbmVyLCBjb3VsZCB5b3Ugc2NyaXB0DQo+IHRoaXMgdmVyeSBzY2Vu
YXJpbyBmb3IgdmVyaWZpY2F0aW9uPw0KDQpGb3IgYW55b25lIHdobyB3YW50cyB0byB3b3JrIG9u
IHRoaXMsIHdlIGRvbid0IG5lZWQgYSBMZUNyb3kgVVNCDQp0cmFpbmVyLiBJZiB5b3UgdXNlIHho
Y2kgaG9zdCwganVzdCBtb2RpZnkgdGhlIHhoY2ktcmluZy5jIHRvIHF1ZXVlIGENCndyb25nIGRp
cmVjdGlvbiBEQVRBIHBoYXNlIFRSQiBvZiBhIHBhcnRpY3VsYXIgY29udHJvbCB3cml0ZSByZXF1
ZXN0DQp0ZXN0LCBhbmQgY29udGludWUgd2l0aCB0aGUgbmV4dCBjb250cm9sIHJlcXVlc3RzLg0K
DQo+IA0KPj4gdHJhbnNmZXIgZmxvdyBtb2RlbCBpbiB0aGUgcHJvZ3JhbW1pbmcgZ3VpZGUuIFRo
aXMgbWF5IGNhdXNlDQo+PiBkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydCgpIHRvIG92ZXJ3cml0
ZSB0aGUgVFJCcyBmb3IgdGhlIERBVEEgcGhhc2UNCj4+IHdpdGggU0VUVVAgc3RhZ2UuIEFsc28s
IGlmIHRoZSBlcDAgaXMgYWxyZWFkeSBzdGFydGVkLCB0aGUgZHJpdmVyIHdvbid0DQo+PiBpc3N1
ZSBTdGFydCBUcmFuc2ZlciBjb21tYW5kIGFnYWluLg0KPiANCj4+IFRoaXMgaXNzdWUgaXMgdW5s
aWtlbHkgdG8gb2NjdXIgdW5sZXNzIHdlIHNlZSBhIG1pc2JlaGF2ZSBob3N0IGZvcg0KPj4gY29u
dHJvbCB3cml0ZSByZXF1ZXN0LiBSZWdhcmRsZXNzLCB3ZSBuZWVkIHRvIGZpeCB0aGlzLiBJIG1h
eSBuZWVkIHNvbWUNCj4gDQo+IHJpZ2h0LCBpdCB3b3VsZCBiZSBhIG1pc2JlaGF2aW5nIGhvc3Qs
IGhvd2V2ZXIgZGF0YWJvb2sgY2FsbGVkIGl0IG91dCBhcw0KPiBzb21ldGhpbmcgdGhhdCBfY2Fu
XyBoYXBwZW4uIE1vcmVvdmVyLCBJIGhhdmUgdmFndWUgbWVtb3JpZXMgb2YgdGhpcw0KPiBiZWlu
ZyBvbmUgb2YgdGhlIHRlc3QgY2FzZXMgaW4gTGVjcm95J3MgVVNCIENlcnRpZmljYXRpb24gU3Vp
dGUuDQo+IA0KDQpZZXMsIGl0J3Mgc29tZXRoaW5nIHRoYXQgY2FuIGhhcHBlbiwgYW5kIGR3YzMg
c2hvdWxkIGJlIGFibGUgdG8gaGFuZGxlDQppdC4gSWYgeW91IHJlbWVtYmVyIHdoaWNoIHRlc3Qg
aW4gcGFydGljdWxhciB0aGF0IHRlc3RzIHRoaXMsIGxldCBtZQ0Ka25vdy4gSSB3YW50IHRvIGNo
ZWNrIGhvdyBpdCB3YXMgcGFzc2VkLg0KDQo+PiB0aW1lIGJlZm9yZSBJIGNhbiBjcmVhdGUgYSBw
YXRjaCBhbmQgdGVzdCBpdC4gSWYgeW91IG9yIGFueW9uZSBpcyB1cCB0bw0KPj4gdGFrZSB0aGlz
IG9uLCBpdCdkIGJlIGhpZ2hseSBhcHByZWNpYXRlZC4NCj4gDQo+IEJlZm9yZSB3ZSBnbyBhaGVh
ZCB3cml0aW5nIGEgcGF0Y2ggZm9yIHRoaXMsIEknZCByZWFsbHkgbGlrZSB0byBzZWUNCj4gdHJh
Y2VzIHNob3dpbmcgdGhpcyBmYWlsdXJlIGFuZCBhIG1pbmltYWwgcmVwcm9kdWNlci4gVGhlIHJl
cHJvZHVjZXINCj4gd291bGQgcHJvYmFibHkgaGF2ZSB0byBiZSBhIHNjcmlwdCBmb3IgTGVjcm95
J3MgVVNCIFRyYWluZXIuDQo+IA0KPiBLZWVwIGluIG1pbmQgdGhpcyBlbnRpcmUgZXAwIHN0YWNr
IHVzZWQgdG8gcGFzcyBVU0JDViBvbiBldmVyeSAtcmMgYW5kDQo+IG1ham9yIHJlbGVhc2UgKGJl
Zm9yZSBJIGxvc3QgYWNjZXNzIHRvIGFsbCBteSBVU0IgZ2VhciBoZWgpLg0KPiANCg0KQXJlIHlv
dSByZWZlcnJpbmcgdG8gQ2g5IFVTQkNWPyBJIGRvbid0IHJlY2FsbCB0aGVyZSdzIGEgcGFydGlj
dWxhciB0ZXN0DQpmb3IgdGhpcy4NCg0KVGhlcmUgc2hvdWxkIGJlIGEgcmVkIGZsYWcgd2hlbmV2
ZXIgd2Ugc2VlIEVuZCBUcmFuc2ZlciBjb21tYW5kDQppbW1lZGlhdGVseSBmb2xsb3dzIGJ5IGEg
U3RhcnQgVHJhbnNmZXIgY29tbWFuZCB3aXRob3V0IGFueSB3YWl0aW5nIGZvcg0KRW5kIFRyYW5z
ZmVyIGNvbXBsZXRpb24uIFRob3VnaCwgaW4gdGhpcyBjYXNlLCB3ZSBkb24ndCBnbyB0aHJvdWdo
IHdpdGgNCnRoZSBFbmQgVHJhbnNmZXIgZm9yIGVwMCBkdWUgdG8gdGhlIHJlc291cmNlX2luZGV4
IGNoZWNrIGluDQpkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKCkuDQoNCkJSLA0KVGhpbmgNCg==
