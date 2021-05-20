Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6460E38B871
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbhETUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:31:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45774 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236909AbhETUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:31:50 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A0BD1401D5;
        Thu, 20 May 2021 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1621542628; bh=u9UdingWeuK5OdRspiyMnusj/xxkwVfdxCKMHL+hF7M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h9U2JEgRIJKZoeXWT9fkVdK6jIaMotXXfytK22j44LPmDwe0HQfLBZBpJrWRj3c+g
         /+SEEWwrBbKn6AjM0DWrmDz5JdvovZSWNNr6vdRcjlRC/KruAaN2oaL2EZ2nLBr3iF
         d+oLbfkCFeska2W8mFOVl3WapMfWi3xyt4p1u8X1rjW4KRm1OkAp4BDxEV+VGTNl4p
         BCqDNkGg8/926HUaGPtJlGBuU6RHyrcDbtBPen4cafaJnNykLnFDKduJ4BjtZMglyU
         xNrtfv04KJZGpdDw0yz9tdg270NN8UBluuesXOB/kwBSkOTnmNCyVsccQqSf1wSvx8
         yFGz3rkAbrovg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3145AA0084;
        Thu, 20 May 2021 20:30:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id ABB68800C3;
        Thu, 20 May 2021 20:30:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="i8usbOYO";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1csO1bZoFME71mbU7fEE9EYonwqmDjkSM0aWcla3MC1SUFMgZs8pB60tnGU0eXZ3zprATFNDk48P90fwDDI+/Yawp4VJlV2U5qxCqZrdPPbvSa0Fl4F/dhJnlQVlp/l3hhw9ZcL1GAWd7avkl4VZzm13349HsL4piEQvrX0Bu7QqUNNGnYcMVDve1jUm264rBpPbJRLOKbZmMULM4gPAPXVCZWTO4PT42nOJUmtOO5J5Z+Ty9PAXYmncUmMWgjw3DA9TNXDzy37kSgLSlFFGCyvLUbYBlBH1GJkK2UfZfTWsiK33xll3bHeAlJ98oZOkV0df9ic5klSUlo9Gi9rnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9UdingWeuK5OdRspiyMnusj/xxkwVfdxCKMHL+hF7M=;
 b=JSBZKwZ8b7EeqiZ9jkh2/FjYrjmEgQ17v4kb6QL66GswQJc+k8JZ72qu1g8QQU4rPi7YoNedwz/tssBOuSWMIon9AjdDQySFVc0Gksv9t+dyVjPIvOiRuyVQQKAvIFFKWAsYsBRTn5Ibm6DY3mwUeLjNVJSd2RXv2DWyUaMnb5EkIXVlVcQGnVCNQ+YxpEEFgjkh8hTy0BULL9rlsz/R2sbsAqAdxiHDxwK7Cu7WnykmoQfywkSZKPoEJ/unlKNshjs45IAEo96n5sxOMSYq6qgqQCraTNq8y/cwvHdgedaBoLNcNeQOGX4IvuyxAgw9uOiuzbbQFpwPJAo/3xj/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9UdingWeuK5OdRspiyMnusj/xxkwVfdxCKMHL+hF7M=;
 b=i8usbOYOnI+hHi38C1OOrine4gRGe7bCV4GvGi01ds4wQtvP76cqrc+yGiT2RhlekHI91Br7kJ7uU9pjSvWwezEcFxVeYlsvIZIm+fbzWDpCDy7ZuFJW4vqWMX4iZ6aVS4nQU+fD7Yl5+aO6g6LGBn8HgXlN2Po8JYpk/d8FZWE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 20:30:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::88be:f751:f493:25f9%6]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 20:30:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
        dave penkler <dpenkler@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [syzbot] INFO: rcu detected stall in tx
Thread-Topic: [syzbot] INFO: rcu detected stall in tx
Thread-Index: AQHXTOaYgJWmk5cMcUemqbVphw6dSKrrnjyAgAE1xgA=
Date:   Thu, 20 May 2021 20:30:01 +0000
Message-ID: <74b2133b-2f77-c86f-4c8b-1189332617d3@synopsys.com>
References: <d673611ca53f42a3a629eb051cabc6eb@rohde-schwarz.com>
 <20210519173545.GA1173157@rowland.harvard.edu>
 <12088413-2f7d-a1e5-5e8a-25876d85d18a@synopsys.com>
 <20210520020117.GA1186755@rowland.harvard.edu>
In-Reply-To: <20210520020117.GA1186755@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
authentication-results: rowland.harvard.edu; dkim=none (message not signed)
 header.d=none;rowland.harvard.edu; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [73.15.163.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d504aad8-837d-414b-a673-08d91bce0b66
x-ms-traffictypediagnostic: BYAPR12MB2806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2806560F5C3B624ABBDAED43AA2A9@BYAPR12MB2806.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaRL2AZlS1+KryEtzW7BhJ6egebGDmobp2IArxSfJ0Ov5zjwNsWlEsAeGpN9cpZ6uLk19HhBIyAhe0zaOK3rQ06KY+6/L31b3EWPhnsLl/DmlXXrqFe2i+JVWpFBPDCzF6Kej9YBH3TaEdjgHXl6DWjmj4d6vtBV9hfS6TRRVNbvuJ+1K7l/RzECUKGkI1BPUSEbWPE3mi5N7eiXhjYA1bstjxwXrOY8/L7iRo1mcKrgUtKAfGGl4xw/it1z6aCf9LCYq86F/dqAhNKz9gWyXK6ce0fE1V+ipAYwWwt0beveOMoBGc05qUHagDvxUA0HS350sGJG/XDN7BpUuM5Y7VbiKQ67Q0y+NGAe8ql1+CEbWyLEP/bCQNWMVu6RdKe1zABp+r4VPxARkOTzqaXPnTuBoDsRhfbftCztF+3XibuhBLlheWZpUKpV4T5WMtK32bq3j/wc5mwrr3rbJI1poQSnZOcn0+YUYyvX/DYhp42CMqDhHi8EQKpXxLX7IIBxKW+yNWCZP5IhtyVRR7CFXTu6/q3WOcX5yzhzwKJ5+D8SFlryR3NvabgVmkGQTEaGpsP1E2JqXhG4b9FfckZA3UYB7NPveNx+3RrorMxpJ0vgqCqX2wQmwPzqSfmzt1XaY0bXGGOqzC8MFoPoZqEAJe0is4x0UJ51EkDJ6jAuDgEPC1PCIIkOpnLcKyHeoejM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39850400004)(36756003)(478600001)(8676002)(66446008)(38100700002)(66556008)(31696002)(64756008)(122000001)(66476007)(5660300002)(86362001)(316002)(66946007)(186003)(31686004)(8936002)(110136005)(54906003)(76116006)(7416002)(6506007)(2906002)(26005)(83380400001)(6512007)(6486002)(2616005)(4326008)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUQrUTN0MVlXcFc4N25qdDdZTW9HMHFLWjlpTmd3T21aR0VKV05KNlV3ckFt?=
 =?utf-8?B?TFBsN0dmOWpIZndtRkYrWDBoV1Z5QXpUS1RnekpXT2F4N1BlTlhjamFCRUlE?=
 =?utf-8?B?Ryt3WmtBMU5HOE5FeE5CK2Y3d2k0cjJKUVE4Rm84M2wxbXZjQXZOcWpDM0Nr?=
 =?utf-8?B?eVdJLzhsWHMwOU5CUFJQNC9zcmErOW40a3kwamQ0Ym0xUlNiSVlxNFpaWXpS?=
 =?utf-8?B?RnYyMGdNb3plS210WE9ETnlQOURuUy9WVElVNUZ5KzFIQ2RLcWxHOGpoWkRP?=
 =?utf-8?B?YUVjVnVDczg0UmVhWGdGWC8vaG0rQlFSV25vZ0ZCL3RtNGttZmROQlJ5Y3Jq?=
 =?utf-8?B?d3hxQW5TSHREUHViVU1IMDJCdG55djRwaW5uSHh6MFg0cEpmT2ZqTVJjQUdQ?=
 =?utf-8?B?UWVvNVdhSi8zNW1XZ0JBWWV1cVYvSXdHSWdRVWNnZUd6MGNGTnU3aHluRzRY?=
 =?utf-8?B?UTVYZnZlZzJVanZ6eE51Z1lWYkpJdVlMVi9aMGRFSGZZb2J5UXc1K2doWlF5?=
 =?utf-8?B?ZStUM3cxRWI0Z3pQSmdvbldCNnNyaTAzKzZ5MGFoa00xZmtML00rRHRTblhn?=
 =?utf-8?B?WHNPaU1tL0lhb1BzY3U4RWNSUXQwdlA4c3dzWEpvR2paV3p4QXVLbFVqNVlN?=
 =?utf-8?B?UEFrcnFZMHRjTlZRaXIxWkpIa1lGeHRiYzFQaU1LK1IyeVdpZDZsT1gyMjFi?=
 =?utf-8?B?bDl3S3ZWR3dtK2dyYXE1Kyt6MEpMNFFFeTBjYWpYamNQaGhuK1BBbThFYi9o?=
 =?utf-8?B?QnhWQVdDR2V5bkdWNG9PTUJ2YSsxVU1CSTdVUkxlc0FwMGFpU2F5K2Znb2VY?=
 =?utf-8?B?dTFaUjU5WXRuc3FhSzJPeDY1M0h5dTNjSE40bGJEK1NLd0MvQmE1Vy9GRUY4?=
 =?utf-8?B?ajFQQXpRSVN6Z2NKSFYxSjBpU2ZrajVVV0FrUytZSFB6TXR1Ri9tTmpYMWwv?=
 =?utf-8?B?Y2lsNm9nc2dQZ3B0NnhxY1pDVHp5eHNnZ0pMQ1RCWHdmdHVEMjBnUitaTXR6?=
 =?utf-8?B?NVZSTVNMWlh4RTJuT3c5emtFeXB6a2hjOWVPb1VWb3ZkRmhnRHJLSVg5akZz?=
 =?utf-8?B?TUFzZHNoWk9FOGxkVi9FTUVrRjBVVkEyOEdKWEpUYUdFd2xzRkVQdWhnNStq?=
 =?utf-8?B?NG1XVnphQmxVZUc0ei9ZS2NVbVBxeDRyUFUreVgyd3FSTWptL2hHSU9rRmU3?=
 =?utf-8?B?STREZ0I4akVGWDl6ZUp6V1RxeG8wWnRnWWJPSWdpVmsrQnZEL1pnR2dtNVc5?=
 =?utf-8?B?MHl0a1hVZTZLRVM3VTNBVnQybytGZ0ZKVXBOYnZ5TU1qUDJQNjVOU3lnZ1Fj?=
 =?utf-8?B?QmJPY283N0NkZ1VFVEdxSW9UcUs0QmRlQ0x6OVg3cUo0NlpqcEttb29OOHRC?=
 =?utf-8?B?VzNTdWJLVzFvZ2NLbWM5YmFvRWovekZ0UUxieGJIWSs1bDR4cEF1TWpZMG1O?=
 =?utf-8?B?TDNMUVM0cFdYdXViOEtqbzc5NnQ2K090bUF0enYwMFJmeVdJZGJRWDBkU2ww?=
 =?utf-8?B?aCsyaVNnRnMyME1wcXBKVjZna1FQRTdIZFRFR0dCazc2VlcrdUNJbVhSSzJF?=
 =?utf-8?B?ZUNFYUpvdGFtdkVTOFJadkJnRmc5Tzd3elJheEJ5MU1COXduR2VmYjVMZDYw?=
 =?utf-8?B?aHMyaUp0OVd6QkV1YWpJdXROZHlmMG80dk1Kcm9XQnRVNmZQUDVZUVhqcDgx?=
 =?utf-8?B?WDRwV1AyTlRYb1lhak1BM2x5ak1xU3NzdkNOcjlBUnoxeDY0ME5tN01IZEY2?=
 =?utf-8?Q?npSueYI+Ex/oTeaLA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <397DB2C8DB33894B97A0EED91A068C26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d504aad8-837d-414b-a673-08d91bce0b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 20:30:01.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/p4/x3uBgeqzJmH57wVG+G++W4lDWmCW2JuEf7SurD46Ss/6A1cEtGng5Z29fR7JT/lSh7oK/yrzLHYDzEC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K01hdGhpYXMNCg0KQWxhbiBTdGVybiB3cm90ZToNCj4gT24gV2VkLCBNYXkgMTksIDIwMjEgYXQg
MDc6Mzg6NTJQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gSGkgQWxhbiwNCj4+DQo+
PiBTb3JyeSBpZiB0aGlzIGRpdmVyZ2VzIGZyb20gdGhlIHRocmVhZCwgYnV0IEkndmUgYmVlbiB3
b25kZXJpbmcgd2hldGhlcg0KPj4gdG8gYWRkIGEgY2hhbmdlIGZvciB0aGlzIGFsc28uDQo+Pg0K
Pj4gRm9yIHhIQ0kgaG9zdHMsIGFmdGVyIHRyYW5zYWN0aW9ucyBlcnJvcnMsIHRoZSBlbmRwb2lu
dCB3aWxsIGVudGVyDQo+PiBoYWx0ZWQgc3RhdGUuDQo+IA0KPiBOby4gIFlvdSBhcmUgbWlzcmVh
ZGluZyB0aGUgeEhDSSBzcGVjLiAgU2VjdGlvbiA0LjYuOCBzYXlzOg0KPiANCj4gCS4uLiB0aGUg
c3RhdGUgb2YgdGhlIGFzc29jaWF0ZWQgRW5kcG9pbnQgQ29udGV4dCBpcyBzZXQgdG8gDQo+IAlI
YWx0ZWQuLi4NCj4gDQo+IE5vdGUgdGhpcyBjYXJlZnVsbHkuICBJdCBzYXlzICJFbmRwb2ludCBD
b250ZXh0Iiwgbm90ICJlbmRwb2ludCIuDQo+IA0KPiBUaGUgZW5kcG9pbnQgaXMgcGFydCBvZiB0
aGUgZGV2aWNlLCB3aGVyZWFzIHRoZSBlbmRwb2ludCBjb250ZXh0IGlzIHBhcnQgDQo+IG9mIHRo
ZSBob3N0IGNvbnRyb2xsZXIuICBUaGUgZGV2aWNlIGRvZXNuJ3Qga25vdyB3aGVuIGEgdHJhbnNh
Y3Rpb24gDQo+IGVycm9yIGhhcyBvY2N1cnJlZDsgY29uc2VxdWVudGx5IHN1Y2ggZXJyb3JzIGRv
IG5vdCBhZmZlY3QgdGhlIGVuZHBvaW50LiAgDQo+IFRoZSBob3N0IGNvbnRyb2xsZXIgZG9lcyBr
bm93LCBhbmQgY29uc2VxdWVudGx5IHN1Y2ggZXJyb3JzIGRvIGFmZmVjdCANCj4gdGhlIGVuZHBv
aW50IGNvbnRleHQuDQo+IA0KDQpZb3UncmUgcmlnaHQsIG15IG1pc3Rha2UgaGVyZS4NCg0KPj4g
VGhlIGRyaXZlciB3aWxsIGF0dGVtcHQgYSBmZXcgc29mdC1yZXRyaWVzIGJlZm9yZSBnaXZpbmcN
Cj4+IHVwLiBBY2NvcmRpbmcgdG8gdGhlIHhIQ0kgc3BlYyAoc2VjdGlvbiA0LjYuOCksIGEgaG9z
dCBtYXkgc2VuZCBhDQo+PiBDbGVhckZlYXR1cmUoZW5kcG9pbnRfaGFsdCkgdG8gcmVjb3ZlciBh
bmQgcmVzdGFydCB0aGUgdHJhbnNmZXIgKHNlZQ0KPiANCj4gTm90IHF1aXRlLiAgVGhlIHNlY3Rp
b24gb2YgdGhlIHNwZWMgeW91J3JlIHRhbGtpbmcgYWJvdXQgc2F5czoNCj4gDQo+IAlTb2Z0d2Fy
ZSBzaGFsbCBleGVjdXRlIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2UgdG8g4oCccmVzZXQgYSANCj4g
CXBpcGXigJ0uLi4uICBJc3N1ZSBhIENsZWFyRmVhdHVyZShFTkRQT0lOVF9IQUxUKSByZXF1ZXN0
IHRvIA0KPiAJZGV2aWNlLg0KPiANCj4gSXQgZG9lcyBub3Qgc2F5IHRoZSBob3N0IGNvbnRyb2xs
ZXIgd2lsbCBkbyB0aGlzOyBpdCBzYXlzIHRoYXQgc29mdHdhcmUgDQo+IHdpbGwgZG8gaXQuDQoN
ClNvcnJ5IGZvciBiZWluZyB1bmNsZWFyLiBJIG1lYW50IGZyb20gdGhlIGNsYXNzIGRyaXZlciwg
c2VlIG15IG5leHQNCnNlbnRlbmNlLg0KDQo+IA0KPj4gInJlc2V0IGEgcGlwZSIgaW4geGhjaSBz
cGVjKSwgYW5kIHRoZSBjbGFzcyBkcml2ZXIgY2FuIGhhbmRsZSB0aGlzIGFmdGVyDQo+PiByZWNl
aXZpbmcgc29tZXRoaW5nIGxpa2UgLUVQUk9UTyBmcm9tIHhoY2kuDQo+Pg0KPj4gSG93ZXZlciwg
YXMgeW91J3ZlIHBvaW50ZWQgb3V0LCBzb21lIGRldmljZXMgZG9uJ3QgbGlrZQ0KPj4gQ2xlYXJG
ZWF0dXJlKGVwX2hhbHQpIGFuZCBtYXkgbm90IHByb3Blcmx5IHN5bmNocm9uaXplIHdpdGggdGhl
IGhvc3Qgb24NCj4+IHdoZXJlIGl0IHNob3VsZCByZXN0YXJ0Lg0KPj4NCj4+IFNvbWUgT1MgKHN1
Y2ggYXMgV2luZG93cykgZG8gdGhpcy4gTm90IHN1cmUgaWYgd2UgYWxzbyB3YW50IHRoaXM/DQo+
IA0KPiBJbiBnZW5lcmFsIHdlIHNob3VsZCBkbyB0aGUgc2FtZSB0aGluZyBhcyBXaW5kb3dzIGRv
ZXMsIGJlY2F1c2UgbW9zdCANCj4gaGFyZHdhcmUgZGVzaWduZXJzIHRlc3QgdGhlaXIgZXF1aXBt
ZW50IG9uIFdpbmRvd3Mgc3lzdGVtcyBidXQgDQo+IHJlbGF0aXZlbHkgZmV3IHRlc3Qgb24gTGlu
dXggc3lzdGVtcy4NCj4gDQo+PiBDdXJyZW50bHkgdGhlIHJlY292ZXJ5IGlzIGp1c3QgYSB0aW1l
b3V0IGFuZCBhIHBvcnQgcmVzZXQgZnJvbSB0aGUgY2xhc3MNCj4gDQo+IFRoaXMgZGVwZW5kcyBv
biB0aGUgZHJpdmVyLiAgU29tZSBwZXJmb3JtIG5vIHJlY292ZXJ5IGF0IGFsbC4NCj4gDQo+PiBk
cml2ZXIsIGJ1dCB0aGUgdGltZW91dCBpcyB1c3VhbGx5IGRlZmF1bHRlZCB0byBhIGxvbmcgdGlt
ZSAoZS5nLiAzMA0KPj4gc2Vjb25kcyBmb3Igc3RvcmFnZSBjbGFzcyBkcml2ZXIpLg0KPiANCj4g
VGhhdCAzMC1zZWNvbmQgdGltZW91dCBpbiB0aGUgbWFzcy1zdG9yYWdlIGRyaXZlciBhcHBsaWVz
IGluIHNpdHVhdGlvbnMgDQo+IHdoZXJlIGEgY29tbWFuZCBmYWlscyB0byBjb21wbGV0ZSwgbm90
IGluIHNpdHVhdGlvbnMgd2hlcmUgaXQgY29tcGxldGVzIA0KPiBxdWlja2x5IGJ1dCB3aXRoIGEg
LUVQUk9UTyBvciAtRVBJUEUgZXJyb3IuDQoNCkhtLi4uIGxvb2tzIGxpa2Ugd2UgaGF2ZSBhIGNv
dXBsZSBvZiBpc3N1ZXMgaW4gdGhlIHVhcyBzdG9yYWdlIGNsYXNzDQpkcml2ZXIgYW5kIHRoZSB4
aGNpIGRyaXZlci4NCg0KV2UgbWF5IG5lZWQgdG8gZml4IHRoYXQgaW4gdGhlIHVhcyBzdG9yYWdl
IGRyaXZlciBiZWNhdXNlIGl0IGRvZXNuJ3QNCnNlZW0gdG8gaGFuZGxlIGl0LiAoY2hlY2sgdWFz
X2RhdGFfY21wbHQoKSBpbiB1YXMuYykuDQoNCkFzIGZvciB0aGUgeGhjaSBkcml2ZXIsIHRoZXJl
IG1heWJlIGEgY2FzZSB3aGVyZSB0aGUgc3RyZWFtIFVSQiBuZXZlcg0KZ2V0cyB0byBjb21wbGV0
ZSBiZWNhdXNlIHRoZSB0cmFuc2FjdGlvbiBlcnJfY291bnQgaXMgbm90IHByb3Blcmx5DQp1cGRh
dGVkLiBUaGUgZXJyX2NvdW50IGZvciB0cmFuc2FjdGlvbiBlcnJvciBpcyBzdG9yZWQgaW4gZXBf
cmluZywgYnV0DQp0aGUgeGhjaSBkcml2ZXIgbWF5IG5vdCBiZSBhYmxlIHRvIGxvb2t1cCB0aGUg
Y29ycmVjdCBlcF9yaW5nIGJhc2VkIG9uDQpUUkIgYWRkcmVzcyBmb3Igc3RyZWFtcy4gVGhlcmUg
YXJlIGNhc2VzIGZvciBzdHJlYW1zIHdoZXJlIHRoZSBldmVudA0KVFJCcyBoYXZlIHRoZWlyIFRS
QiBwb2ludGVyIGZpZWxkIGNsZWFyZWQgdG8gJzAnICh4aGNpIHNwZWMgc2VjdGlvbg0KNC4xMi4y
KS4gSWYgdGhlIHhoY2kgZHJpdmVyIGRvZXNuJ3Qgc2VlIGVwX3JpbmcgZm9yIHRyYW5zYWN0aW9u
IGVycm9yLA0KaXQgYXV0b21hdGljYWxseSBkb2VzIGEgc29mdC1yZXRyeS4gVGhpcyBpcyBzZWVu
IGZyb20gb25lIG9mIG91cg0KdGVzdGluZ3MgdGhhdCB0aGUgZHJpdmVyIHdhcyByZXBlYXRlZGx5
IGRvaW5nIHNvZnQtcmV0cnkgdW50aWwgdGhlIGNsYXNzDQpkcml2ZXIgdGltZWQgb3V0Lg0KDQpI
aSBNYXRoaWFzLCBtYXliZSB5b3UgaGF2ZSBzb21lIGNvbW1lbnQgb24gdGhpcz8gVGhhbmtzLg0K
DQo+IA0KPiBUaGUgZmFjdCBpcyB0aGF0IG9ubHkgYSBzbWFsbCBwZXJjZW50YWdlIG9mIC1FUFJP
VE8gZXJyb3JzIGFyZSANCj4gcmVjb3ZlcmFibGUuICBTb21lIG9mIHRoZW0gY2FuIGJlIGhhbmRs
ZWQgYnkgYSBwb3J0IHJlc2V0LCB3aGljaCBjYW4gYmUgDQo+IHByZXR0eSBhd2t3YXJkIHRvIHBl
cmZvcm0gYnV0IGRvZXMgb2NjYXNpb25hbGx5IHdvcmsuICBBIGxvdCBvZiB0aGVtIA0KPiBvY2N1
ciBiZWNhdXNlIHRoZSBVU0IgY2FibGUgaGFzIGJlZW4gdW5wbHVnZ2VkOyBvYnZpb3VzbHkgdGhl
cmUncyBubyB3YXkgDQo+IHRvIHJlY292ZXIgZnJvbSB0aGF0LiAgV2l0aCBvbmx5IGEgZmV3IGV4
Y2VwdGlvbnMsIHRoZSBiZXN0IGFuZCBzaW1wbGVzdCANCj4gYXBwcm9hY2ggaXMgbm90IHRvIHRy
eSB0byByZWNvdmVyIGF0IGFsbC4NCg0KSWYgdGhlIGNhYmxlIGlzIHVucGx1Z2dlZCwgdGhlbiB3
ZSBzaG91bGQgZ2V0IGEgY29ubmVjdGlvbiBjaGFuZ2UgZXZlbnQNCmFuZCB0aGUgZHJpdmVyIGNh
biBoYW5kbGUgaXQgcHJvcGVybHkuDQoNClllcywgaXQncyBwcm9iYWJseSBzaW1wbGVzdCB0byBk
byBhIHBvcnQgcmVzZXQgYW5kIGxldCB0aGUgdHJhbnNmZXIgYmUNCmluY29tcGxldGUvY29ycnVw
dGVkLiBIb3dldmVyLCBJIHRoaW5rIHdlIHNob3VsZCBnaXZlDQpDbGVhckZlYXR1cmUoZXBfaGFs
dCkgc29tZSBtb3JlIHRob3VnaHRzIGFzIEkgdGhpbmsgaXQgY2FuIGJlIGEgcmVjb3ZlcnkNCm1l
Y2hhbmlzbSBmb3Igc3RvcmFnZSBjbGFzcyBkcml2ZXIsIGV2ZW4gdGhvdWdoIHRoYXQgaXQgbWF5
IG5vdCBiZQ0KZm9vbHByb29mLg0KDQo+IA0KPiBGb3IgdGhlIGNhc2UgaW4gcXVlc3Rpb24gKHRo
ZSBzeXpib3QgYnVnIHJlcG9ydCB0aGF0IHN0YXJ0ZWQgdGhpcyANCj4gdGhyZWFkKSwgdGhlIGNs
YXNzIGRyaXZlciBkb2Vzbid0IHRyeSB0byBwZXJmb3JtIGFueSByZWNvdmVyeS4gIEl0IGp1c3Qg
DQo+IHJlc3VibWl0cyB0aGUgVVJCLCBnZXR0aW5nIGludG8gYSB0aWdodCByZXRyeSBsb29wIHdo
aWNoIGNvbnN1bWVzIHRvbyANCj4gbXVjaCBDUFUgdGltZS4gIFNpbXBseSBnaXZpbmcgdXAgd291
bGQgYmUgcHJlZmVyYWJsZS4NCj4gDQo+IEFsYW4gU3Rlcm4NCj4gDQoNCkkgc2VlLiBCeSBnaXZp
bmcgdXAsIHlvdSBtZWFuIGRvaW5nIHBvcnQgcmVzZXQgcmlnaHQ/IE90aGVyd2lzZSBpdCBuZWVk
cw0Kc29tZSBvdGhlciBtZWNoYW5pc20gdG8gc3luY2hyb25pemUgd2l0aCB0aGUgZGV2aWNlIHNp
ZGUuDQoNClRoYW5rcywNClRoaW5oDQo=
