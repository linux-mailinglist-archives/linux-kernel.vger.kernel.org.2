Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9849349B49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCYUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:52:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34854 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhCYUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:52:25 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 85C02C00E8;
        Thu, 25 Mar 2021 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616705541; bh=VVBbjPX95HIbr1VBE4sPyv/J1wuztkBCIti9rTctXhc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=drT5xL4H0NIspB4zzHzE0oUxtW8+KDstXxoOUQbQzv0Cx/cjsnDYBso1mrplp0CTW
         ZAx74CBm22qAzghjY5oTdA0OiSkcBtKiRz+taOx3AK9RPrQG9qLKAp27Q2roF84CP4
         XH7Z/wambBLpwZWFe4hv0t/720YuhiSNhqby406MAuiGSh0ZdwNka3tzXUZOcV57RM
         88HPTHbA/s+YnsRdBa4ctRKJhsGfBfAUOk3f2ymr15dPNZ64pIjxDvhX/yS8Is/LSr
         bpE6BrfrqJMAbzMzwUk0T5Rk+yP9Nv9KZBGSrgDcs1EHD/twI5onx+6JfyiSyaWNgD
         QfnWwxKh16K4A==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 08FAAA00A4;
        Thu, 25 Mar 2021 20:52:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CC5F48026E;
        Thu, 25 Mar 2021 20:52:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EeVkuvEJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc77+02oIJEkIqzmTStIHYAtkwyUq0FQWfaraDEKQwSpFdZvhewa5MHpCeUpm0bc/7uXA+aBXuFPe4I5mttLw10qSzgLht+i82hvogVipdCuqbmx0lWrRVurjhTjh+xhUyz7M9kA89/KhOBsaVFu/lgGX6hIh4X9jrI+zpn9+Nm34CAaqSNSQgsxrnHUA44uBywioBqJVOTRQB5jLBeMwVPf/znG11kgxmEETKh5wg1ezXAVCjzGF0PtCdRjbsdhs1V9nhxcLPT43T/JJ1FVLuUSdvAFCld3brMROBLBXADDGa0nLqKKxxkmYTdg24A0vsL3+wouDc/N3MLM3++J9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVBbjPX95HIbr1VBE4sPyv/J1wuztkBCIti9rTctXhc=;
 b=FbAq9x0//dWHJOvHXTreFGNELc6qtQQoBMZyTZ8EoTbWZHC8doOSmZvOM6dK8NRQengluIjlKlkqPU55hL2iNSK51jijO907BrxO2tKKIgQvMROoJhCv26nkkeQ3/OfL0SjnkLfH3wCB8sC7b1yX1ARnf0LK0hH0e2juYQNO9+noe5a6J6vrn/svDLVhH02w0trRzod8vP2iQV/zbJiwwuG3NUi8gQts+FJ2ioC5NAkgCr0fOgex8h5ZSGp39hvasyA0+d83HKF4dPjFE46NkMFDG8w1Qmeh5mRBLwvZTLlQ4AIP7nX95IASAbinH9qf7PJFGPr+bXYfzRfzDSfKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVBbjPX95HIbr1VBE4sPyv/J1wuztkBCIti9rTctXhc=;
 b=EeVkuvEJ1+yuQhl0Vtpm5eBJneiEJVoDEggAfQ3KjhCTfBJxmUeDOr8ezIiVxkp2wZzKOOFKR3kdRiCMyJV7INvCfqxPnlyzjxNzc9QGNX8PLRPv2k+3p6+XT/enTqyNRgUact10aohTwP29622M/Nk9lhAtYipY92MJuvK8c5M=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2742.namprd12.prod.outlook.com (2603:10b6:a03:6a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 20:52:17 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 20:52:17 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ray Chi <raychi@google.com>, "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "albertccwang@google.com" <albertccwang@google.com>
Subject: Re: [PATCH] usb: dwc3: add cancelled reason for dwc3 requests
Thread-Topic: [PATCH] usb: dwc3: add cancelled reason for dwc3 requests
Thread-Index: AQHXIW2nGqzRRQomD0uNMTRrx8NI/KqVLp4A
Date:   Thu, 25 Mar 2021 20:52:17 +0000
Message-ID: <5f3f6c78-a584-aaef-3f5d-7734620c433f@synopsys.com>
References: <20210325115436.861299-1-raychi@google.com>
In-Reply-To: <20210325115436.861299-1-raychi@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7d3547e-c5bb-4852-b5fa-08d8efcfe048
x-ms-traffictypediagnostic: BYAPR12MB2742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB274202D3C5DEBF88210EBE3EAA629@BYAPR12MB2742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KG5IHBDZpoIagC8NsQ6G5nYjLWzoD2gnjZ95NBV7ajteHd0sOq2wwsCMdKXVhqr54FwOkxuVyR3T/zd2/qXodOTmfuCydn9gVcR3BxtPX5z37aPoNFb6nhxbaagsVuUcfMGG6h+r6tVz90nO9TyroydRY90r9MJ/TrPbRkcG9rZNaTVNaxnYJWMcPu1vCowsrZifxz8q7n5JmxheM0LVTk+vcA7ByrWvYKEmx8xjtAbfF8EMeNjc7GDwd7DXLRmNW4K3gHmlKa1VGF6tS9b8KIA/Q0IAuieA6ThNRsMpOBytKWeOkdbW8kwdaCUJTTgjydXNzYkmdyOMD2czG4snUrV7pDCsLzgiw96gH8qc4Nm4aZKYdtL0eGKMRBeM9yM9yGaPMip28UhX59QEPWd6JLARmdr8245rdDMtieNjYksILcBGyQMmKtxyHCa8FiiMnYyhQgP89CQz4pD1FsUXsD6C+BZcfnVjdsuBvR6Uel5XMAaIOyGulR3n/EYkAFK0r+oq+aAUmTThAzN4+fkFh5n9GHY5b/Cfjw4+hAddzbHnGQIhsyBfA487t9ee4mzB9ga2ZL4kQ+NX3CLymnWtaug1ZBrcfwugT1r2ed9Fll76JeOgIl8gGJloQoFYVxHvsS6U6aao7AxRwX+7oITUPdPvg/D0nZzcJ8Zl6C0aaoGD8g0KuYPbAYUAgM89IurdIFooLXsAjZjpX2FXI0QtJBV/u32Sm40zdPY1o1OtqFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39850400004)(346002)(66476007)(4326008)(6506007)(54906003)(26005)(110136005)(36756003)(83380400001)(6512007)(71200400001)(478600001)(316002)(2616005)(2906002)(5660300002)(8936002)(66446008)(8676002)(31686004)(38100700001)(31696002)(186003)(66946007)(66556008)(76116006)(6486002)(64756008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlhKYWtacXJyK3JBZHNGYlJnYkpONHhvZzR5UU01cjc1dG1qQmtncDJtd3Fu?=
 =?utf-8?B?ajY3TDNOcGcyNVNXRjRWa3c1ZEtOQTJ1bW1TcU96NFQrQW5LcVE1Q0RJUU1i?=
 =?utf-8?B?YVB2UzJ1SFRGZmtyNjRlSFRZYUkvL0xCVmRkRWRnRU1PWlhtdTYzc0wyYmQy?=
 =?utf-8?B?eEUrRUQ0azl5NVdGTkFKbnlBMXZIc0tnakFVeUVxbjJOYkJRR3Q3UnZrSnk3?=
 =?utf-8?B?a3VHQTNpK0oxaDZHL0ltUGxhbWhQOFpWaEVWMW9mcXA5S3VDY2NjT2JzQ2Yy?=
 =?utf-8?B?T2d4MHg4d09ybUVkbnlkQUxKZ2E0Q2wySS8yUnhBRGNPMndMRHFhUDRWTmtS?=
 =?utf-8?B?Z01PZ1d3MzM3b2s2M01ORjFkQ1puR3A3eVEyY00yZDIrYnRPdWU1eVdaQ2tK?=
 =?utf-8?B?ZERVYll4N2JWcVRCcGFidmdmTkQ0dTI0UGJnU2tvRytoMkd2bTdyaFlUanN0?=
 =?utf-8?B?ZlBGUWQyWm80WHpsMGxZVzVJOVpHdnRCVlUvV0NuZ2RJd3JIQ3dmWGJ2eTQ1?=
 =?utf-8?B?UGVTbXc1a3dtTGVTWEZ6M1ZsN1VFeGQ2UFlnMjRCWHRybGlQekpMYVR5K0NU?=
 =?utf-8?B?RDU2UjhnWE91a2VSOTg1OVZSM1BlRVphUkQwamoranBzTUk1T3lTMEpJTXpm?=
 =?utf-8?B?NHdSQTFtR1FaWmNhUW1Pd01SdHY5cVN1bkVBM1k1Y2hNczUyRkE2Y3h6QVd3?=
 =?utf-8?B?N25BeEFBYlpITWhyMHFKb2hTdWQzOVR6bW9HMUJmOVlhSjZSWFU1ODc5cEZK?=
 =?utf-8?B?S1poaytjY1hSK3FqK2pWRWhLTEFlWTEwTUdoeDBkZTlQUE05M2tDcUQ4Vy9a?=
 =?utf-8?B?QVVWSFY5VDhPTmxJUVVaOG9GWnVQdzd4U1lpNnhsTGVMdzlLdEJWR0Jic3pP?=
 =?utf-8?B?RTRhQ0IwK0ZnN0s1ZXJCVTlxS2FGUGIzS1BDc3YwSDk1MG0vK1FyaEdpU1No?=
 =?utf-8?B?YWtyTWJ6RzhJYVkwUHZERE55RWh2WHg2K2Q2bzAyOXFxK1VjazQ5WGJjRm9k?=
 =?utf-8?B?UGw1c2ZybCsyaG44UFVsTUwzMFEzWklpcUNYWjQrOXRwTXB4NHBmK1F1eXBX?=
 =?utf-8?B?SHdXUG1VY0VvMTQwdXhMRDBjSXAzSW5idmhKb0lQL2tTRnpOVmFkOHNRakdX?=
 =?utf-8?B?QjVlRS8xcFN0QmFpZ1pPc25CQTBBQXpUaHpSRHl0ZzlJbEgwaW9OeVhPSHVy?=
 =?utf-8?B?ZlA0c0U0NDdpRjNtTWlvNitZMHY1Yk9JY0ZvTHpvUzFrVTIxS1NIU0x3dXFr?=
 =?utf-8?B?aXVnVytKYkFWVFRITVlYaDdDZ0lQbkFMNnFhc3lCYUpsSkd4Nm1YeVkxTisw?=
 =?utf-8?B?S2RaNlVudTV1R0kxSFdzOWFZZWdVaDA5NWtGZy9BV0IvZFpSSnU3bTlaNjFG?=
 =?utf-8?B?VC9HZEFRYTQzNm9iQ3dJd1pGY3pEbkRLK3hiMlF6NWl4TVFkaERwbW9mTGo0?=
 =?utf-8?B?MXBCYlVEY3hnM2ZZN2lML3NscXFwWU9xdEZhTW5VdVkrQVVjUmNjcTN5WlBw?=
 =?utf-8?B?SXB3UkRTVkJYRElJZHJyZkFqTmpSODRoYkVRVkxZeDRrcDJGVXFVZU1mMW9B?=
 =?utf-8?B?SW1LU0ZYRkNHd3pPZUhMam54WTJ6bUNLVVhQQmp4c3VGMU0wdy95WHVmTTdx?=
 =?utf-8?B?bUltU1RuWldDMzJjL3BRZndTaVFTQ016WTZsSUl2ZksxdW04ZTVLK1VJcUJQ?=
 =?utf-8?B?WSs2TVRVTnM4eUdCTThDUkNpMHdmZlNjMjVvZW5xc3ZyWmtSWGNIL3JHT3p0?=
 =?utf-8?Q?fHGSSeThRrcr1zt7iM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08D2765BC16B9F43AD34BA47D4B7BD33@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d3547e-c5bb-4852-b5fa-08d8efcfe048
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 20:52:17.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vH16qgcVrQhBvVi/Ihht6CI3d0WFD9n1IXvQIbWfL4xw9O0eJzN4K8TZqgulgn63ng+e4NdJhCJSiA2cZ1l/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmF5LA0KDQpSYXkgQ2hpIHdyb3RlOg0KPiBDdXJyZW50bHksIHdoZW4gZHdjMyBoYW5kbGVz
IHJlcXVlc3QgY2FuY2VsbGVkLCBkd2MzIGp1c3QgcmV0dXJucw0KPiAtRUNPTk5SRVNFVCBmb3Ig
YWxsIHJlcXVlc3RzLiBJdCB3aWxsIGNhdXNlIFVTQiBjbGFzcyBkcml2ZXJzIGNhbid0DQoNCmNs
YXNzIGRyaXZlcnMgLT4gZ2FkZ2V0IGRyaXZlciBvciBmdW5jdGlvbiBkcml2ZXIuDQoNCj4ga25v
dyBpZiB0aGUgcmVxdWVzdHMgYXJlIGNhbmNlbGxlZCBieSBvdGhlciByZWFzb25zLg0KPiANCj4g
VGhpcyBwYXRjaCB3aWxsIGFkZCB0aGUgcmVhc29uIHdoZW4gdGhlIHJlcXVlc3RzIGFyZSBjYW5j
ZWxsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXkgQ2hpIDxyYXljaGlAZ29vZ2xlLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgIDYgKysrLS0tDQo+ICBkcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5oIHwgMTAgKysrKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGlu
ZGV4IGUxNDQyZmM3NjNlMS4uY2M2NWZjMDY0MDc4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAg
LTE0MDIsNyArMTQwMiw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVy
KHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICAJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVw
LCB0cnVlLCB0cnVlKTsNCj4gIA0KPiAgCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0
bXAsICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkNCj4gLQkJCWR3YzNfZ2FkZ2V0X21vdmVfY2Fu
Y2VsbGVkX3JlcXVlc3QocmVxKTsNCj4gKwkJCWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3Jl
cXVlc3QocmVxLCBEV0MzX1JFUVVFU1RfREVRVUVVRUQpOw0KPiAgDQo+ICAJCS8qIElmIGVwIGlz
bid0IHN0YXJ0ZWQsIHRoZW4gdGhlcmUncyBubyBlbmQgdHJhbnNmZXIgcGVuZGluZyAqLw0KPiAg
CQlpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORykpDQo+IEBA
IC0xNzc2LDcgKzE3NzYsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2VwX2RlcXVldWUoc3Ry
dWN0IHVzYl9lcCAqZXAsDQo+ICAJCQkgKiBjYW5jZWxsZWQuDQo+ICAJCQkgKi8NCj4gIAkJCWxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZShyLCB0LCAmZGVwLT5zdGFydGVkX2xpc3QsIGxpc3QpDQo+
IC0JCQkJZHdjM19nYWRnZXRfbW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyKTsNCj4gKwkJCQlkd2Mz
X2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHIsIERXQzNfUkVRVUVTVF9ERVFVRVVFRCk7
DQo+ICANCj4gIAkJCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfV0FJVF9UUkFOU0ZFUl9DT01QTEVU
RTsNCj4gIA0KPiBAQCAtMTg0OCw3ICsxODQ4LDcgQEAgaW50IF9fZHdjM19nYWRnZXRfZXBfc2V0
X2hhbHQoc3RydWN0IGR3YzNfZXAgKmRlcCwgaW50IHZhbHVlLCBpbnQgcHJvdG9jb2wpDQo+ICAJ
CWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsNCj4gIA0KPiAgCQls
aXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocmVxLCB0bXAsICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlz
dCkNCj4gLQkJCWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QocmVxKTsNCj4gKwkJ
CWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QocmVxLCBEV0MzX1JFUVVFU1RfU1RB
TEwpOw0KPiAgDQo+ICAJCWlmIChkZXAtPmZsYWdzICYgRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVO
RElORykgew0KPiAgCQkJZGVwLT5mbGFncyB8PSBEV0MzX0VQX1BFTkRJTkdfQ0xFQVJfU1RBTEw7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5oIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuaA0KPiBpbmRleCAwY2QyODE5NDk5NzAuLmEyM2U4NWJkMzkzMyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5oDQo+IEBAIC01Niw2ICs1NiwxMiBAQCBzdHJ1Y3QgZHdjMzsNCj4gIA0KPiAg
LyogRnJhbWUvTWljcm9mcmFtZSBOdW1iZXIgTWFzayAqLw0KPiAgI2RlZmluZSBEV0MzX0ZSTlVN
QkVSX01BU0sJCTB4M2ZmZg0KPiArDQo+ICsvKiBDYW5jZWwgcmVhc29uIGZvciBkd2MzIHJlcXVl
c3QgKi8NCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX0RFUVVFVUVECQktRUNPTk5SRVNFVCAgLyog
UmVxdWVzdCBnZXQgZGVxdWV1ZWQgKi8NCj4gKyNkZWZpbmUgRFdDM19SRVFVRVNUX0RJU0NPTk5F
Q1RFRAktRVNIVVRET1dOICAgLyogRGV2aWNlIGlzIGRpc2Nvbm5lY3RlZC9kaXNhYmxlZCAqLw0K
PiArI2RlZmluZSBEV0MzX1JFUVVFU1RfU1RBTEwJCS1FUElQRSAgICAgICAvKiBCdXMgb3IgcHJv
dG9jb2wgZXJyb3IgKi8NCj4gKw0KPiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8NCj4gIA0KPiAg
I2RlZmluZSB0b19kd2MzX3JlcXVlc3QocikJKGNvbnRhaW5lcl9vZihyLCBzdHJ1Y3QgZHdjM19y
ZXF1ZXN0LCByZXF1ZXN0KSkNCj4gQEAgLTkwLDE1ICs5NiwxNyBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZHdjM19nYWRnZXRfbW92ZV9zdGFydGVkX3JlcXVlc3Qoc3RydWN0IGR3YzNfcmVxdWVzdCAq
cmVxKQ0KPiAgLyoqDQo+ICAgKiBkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0IC0g
bW92ZSBAcmVxIHRvIHRoZSBjYW5jZWxsZWRfbGlzdA0KPiAgICogQHJlcTogdGhlIHJlcXVlc3Qg
dG8gYmUgbW92ZWQNCj4gKyAqIEByZWFzb246IGNhbmNlbGxlZCByZWFzb24gZm9yIHRoZSBkd2Mz
IHJlcXVlc3QNCj4gICAqDQo+ICAgKiBDYWxsZXIgc2hvdWxkIHRha2UgY2FyZSBvZiBsb2NraW5n
LiBUaGlzIGZ1bmN0aW9uIHdpbGwgbW92ZSBAcmVxIGZyb20gaXRzDQo+ICAgKiBjdXJyZW50IGxp
c3QgdG8gdGhlIGVuZHBvaW50J3MgY2FuY2VsbGVkX2xpc3QuDQo+ICAgKi8NCj4gLXN0YXRpYyBp
bmxpbmUgdm9pZCBkd2MzX2dhZGdldF9tb3ZlX2NhbmNlbGxlZF9yZXF1ZXN0KHN0cnVjdCBkd2Mz
X3JlcXVlc3QgKnJlcSkNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX2dhZGdldF9tb3ZlX2Nh
bmNlbGxlZF9yZXF1ZXN0KHN0cnVjdCBkd2MzX3JlcXVlc3QgKnJlcSwgaW50IHJlYXNvbikNCj4g
IHsNCj4gIAlzdHJ1Y3QgZHdjM19lcAkJKmRlcCA9IHJlcS0+ZGVwOw0KPiAgDQo+ICAJcmVxLT5z
dGF0dXMgPSBEV0MzX1JFUVVFU1RfU1RBVFVTX0NBTkNFTExFRDsNCg0KTXkgc3VnZ2VzdGlvbiBw
cmV2aW91c2x5IHdhcyB0byByZXBsYWNlIERXQzNfUkVRVUVTVF9TVEFUVVNfQ0FOQ0VMTEVEDQp3
aXRoIG1vcmUgc3BlY2lmaWMgc3RhdHVzOg0KDQpEV0MzX1JFUVVFU1RfU1RBVFVTX0RJU0NPTk5F
Q1RFRA0KRFdDM19SRVFVRVNUX1NUQVRVU19ERVFVRVVFRA0KRFdDM19SRVFVRVNUX1NUQVRVU19T
VEFMTEVEDQoNCmFuZCBzZXQgcmVxLT5zdGF0dXMgPSByZWFzb247DQoNCj4gKwlyZXEtPnJlcXVl
c3Quc3RhdHVzID0gcmVhc29uOw0KDQpOb3QgdG8gdXBkYXRlIHRoaXMgaGVyZSBhcyB0aGlzIGRv
ZXNuJ3QgZG8gYW55dGhpbmcuIFVwZGF0ZQ0KZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jYW5jZWxs
ZWRfcmVxdWVzdHMoKSB0byBoYXZlIGEgc3dpdGNoIGNhc2UgYW5kDQpwcm92aWRlIHRoZSBhcHBy
b3ByaWF0ZSBnaXZlYmFjayBlcnJvciBjb2RlIGJhc2Ugb24gdGhlIHN0YXR1cyBhYm92ZS4NCg0K
PiAgCWxpc3RfbW92ZV90YWlsKCZyZXEtPmxpc3QsICZkZXAtPmNhbmNlbGxlZF9saXN0KTsNCj4g
IH0NCj4gIA0KPiANCg0KQlIsDQpUaGluaA0K
