Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2027F41EB75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353744AbhJALMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:12:09 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56358 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230514AbhJALMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:12:08 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 01F65C0B90;
        Fri,  1 Oct 2021 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1633086624; bh=H5DltQTasUfP1GjfRhjORlr8g8ukOViMtA0ynp/epOA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XGqY3vuiYQMlpHhJDAjceNFEfvT4zsAIjgvGRBZl/4NUDcpX12qk+WkuU3z2ku40T
         H2pBkurR5RB38XwkjgV0uHr+SoXUi+xDV1FLHKw74i8bNmZkYRI5TwU591Q0vLn8jY
         54ukpIb9SZWC1257DGdfOCpkW9Pvklx/+jySrNarThEYX5hZxCJ/CLlR+YngPGdizz
         OR6g/Nchtl3QqW20BJowDN7EA6l9lC0QnZT2SbXjFrgE2P0xZ9/rAPw1hlrbdXbGxV
         h8Vo1l9tuaPOxznnnqT7CnHYDlMtspaZwabc9tQcKwuZymNtqsRWLU3tf/sdgIwbJo
         PcwO6yyL/OBDA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 898B9A0081;
        Fri,  1 Oct 2021 11:10:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6F801800BA;
        Fri,  1 Oct 2021 11:10:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="WIJoajwi";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpVb7guU5i9X1rQ4eUPP3VX1Qfvsz23Bso++GXaOXIwV7XBxujHyavfc+FqpR/coHvFf39pvUQ5Ng20+11Lz+18m9IF+A44Tuileg7GJ+zgZtddjyISlSUlTnBMATu63TVl7u5LF5HVssABKTkjL0eNOCV5CkkF1aPOkbAx3XbXBNuXJFzZNxw5yiQ308RFQUvmm39fUhzuZjwWTkLc7HkAbB1IzpFag27V247m/vBNNset2ap2c7ihaF3gRHRMkti98mMO+EPv1oppw8BKEFtwJBiCkf2NRJAAlUqCEwsEc3VXhuQPqKg3jUF3JIq88eHS+i/qOOa/3JgcLwGecgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5DltQTasUfP1GjfRhjORlr8g8ukOViMtA0ynp/epOA=;
 b=BDm74tjlLzlVvM/gK/O3l/iHcRQFlXdj5xS+p0uIrm/Ct97Y7OiHDxs+OyCDJ4xAM3U99NjsxFXxMXAQITXghqQtvYD8qOB5Bo5o5smKmJVOiIRD2I/oRtsgV+LdCoNI/oCwSiXpLIsKNmTgwOPPRCPHdpE0CzqYk8iunPdeIMNHIgEFlGLEwGPxbkHJ1FKtmmRBSaMWqjjv1eONnRwJi1VDWMXNQR2WAhXWOPthTLaNyFjrNifezKOzJ9c6cIo2BrXQ2Um8cltiZ/gWSb2VXNT63hhLM424MnLtSMx/dSn6/SqHnUCJjwEgpxLlYGjF/xQTac+ZYluQCG8L4ozsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5DltQTasUfP1GjfRhjORlr8g8ukOViMtA0ynp/epOA=;
 b=WIJoajwih45XuwyvUDXp9x4VcPSpYJv/kVzvqxtrIPAsQ0moKduI6gW78NeX+IPWe25j08nuh12HIjZJJ/a/bL6wwe4SfFgoPKpzllWqicshA8Qa85h6PuHvCYPzwTFHzyeIsO669jmpN8sdP1RmTwIRNMhoMGyD0DERwSYBFwQ=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Fri, 1 Oct
 2021 11:10:19 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::c91a:f6fc:9847:4dcd]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::c91a:f6fc:9847:4dcd%8]) with mapi id 15.20.4566.015; Fri, 1 Oct 2021
 11:10:19 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/3] usb: dwc2: add otg_rev and otg_caps information for
 gadget driver
Thread-Topic: [PATCH 1/3] usb: dwc2: add otg_rev and otg_caps information for
 gadget driver
Thread-Index: AQHXqgb2WiIYWLtBVEidgzMo9ji6xau+FccA
Date:   Fri, 1 Oct 2021 11:10:19 +0000
Message-ID: <a183ddf9-c578-0b45-1aa2-4fcd1fbf17eb@synopsys.com>
References: <1631692473-8732-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1631692473-8732-2-git-send-email-fabrice.gasnier@foss.st.com>
In-Reply-To: <1631692473-8732-2-git-send-email-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: foss.st.com; dkim=none (message not signed)
 header.d=none;foss.st.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f02c8de-98c8-44ba-df65-08d984cc0e3c
x-ms-traffictypediagnostic: DM4PR12MB5328:
x-microsoft-antispam-prvs: <DM4PR12MB532849C218FDF7C35349B1BDA7AB9@DM4PR12MB5328.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3a7fKQD8lomE7HrippnANRdFep8eElDaPPrIk9pwam6nafoORyQYCv2vkcY+vMxiZpgdUGnB12NgQedrg7CI89U9KO5cpwKNKza7XDzxG44r0h6US4sbXrMFsDrlHNadDAloMZ0eCc9vxVhPdBhNnAVWKkF2Qyi5yeMCJC6J8d6o7aTNnA1VIexPCHvy1N4mW+9p+D/TDI2B6Gjh0uJ5gDZf1M2uuVdDPnKlQ1AdnG3a+AAqnSVmPbTzzPOGW4su8OwT16Wuo+hrq4kYswXZGEN+QaPDsX4+jrQcbf7BJArZ683CH+v8xkj8cd3LXdwUQKe9sfm0NfW2RzfTRpUGG/LXQpXsxPsZ523ep+yLj3iolGIyeuPvnezRLCNMM1YITqBCR23DP0zYrbxikgHJkoa9l3BP+B/cBjoGW8Rg9RhkV6cHAaH8QDm+jyGaPLpseiszLEol7W4H2n+KROiknh/NWq5+ysRQZDDs61FBTZsipqDief1bvqiOmuErN+UQ/UzgPsiUmDbAvqdRAoCbCdqwBKMm0NSKOXJzA7Ju0Lob2RlJI3YtwhYbm74LQ2ycF3Kahzud9rYZEQXd6AoxuPWI/GYzzK4PVzdOID4POU4d6GQSPqjVRy/G2L/VmsrHxW0rzn9NMH6qoQoTJFGTBNZgZbtBSQSB3ux316nuTw2Pc/p4XGws92DyIvKL2EtqakJhyC7I+WtZ8uvP/tiwm6r/REbTBi7C3w3W5HVpmyGEp3nXdxvRTbIPDEw8AYc9/2BFrwKGA0ML9XKd2ocNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(7416002)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002)(38100700002)(91956017)(122000001)(76116006)(6512007)(6506007)(53546011)(4326008)(38070700005)(36756003)(86362001)(2906002)(54906003)(110136005)(31696002)(2616005)(316002)(83380400001)(71200400001)(4744005)(186003)(26005)(31686004)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODFaWkZwTkVXbHNvYmdEOW9uMnVpMDZrVDVLYVhsSEUySlRxaDdoa3I2ekhl?=
 =?utf-8?B?eUVCK0lUK2RPcEtsWWc2THhFNWt2K1NwWGpJWDBRNHVaSlp0TmlDYXhyelQr?=
 =?utf-8?B?MXBLNjdPUng1VllMbVBEVUtWYVV6OENSRGdhWUo0dHNVM2tQMGdFMmhidjNN?=
 =?utf-8?B?L01oekN4VVZGK2krbFRiOTJOdXprSkxWdE1yYXdPSXdONmcvdUJIN1UwVHYz?=
 =?utf-8?B?bGRMOE1NVzNGUnh0RVVUYnl3Z1NGN01TcUpCd0FmL0FsTkZlMVBWazl4SlYx?=
 =?utf-8?B?UDdzZ00vOXRPdHZNbXcwbnhoTlVxWWVTbXlUbEdiSmtjRTF0UWlVMW5Mbjhx?=
 =?utf-8?B?QkJiUytjNTB4blhncTBpU2g5VjBFSUoyYWh5QWRzUmVUcml3TlVsdkgzdWhP?=
 =?utf-8?B?d1BGSnZadGoyTXR4c0RLNEt3QVNVTTYvYWFRei9YSW5OZzYxcXFrcWFlbnNU?=
 =?utf-8?B?bG53UnRLdHE2ajFUdGMrNzh0VUNkRmVCUGJDZGMra1V0MmN4THgrUHY2cmwy?=
 =?utf-8?B?eVo4NzBTSmNIM3dFcm13Z2NSRzdaaHFnMlBya3l1RGNoUHYvNjJva3dtL0dH?=
 =?utf-8?B?V201bUdFS2tIOVZIclJHbkZiMDBON0Y4V0RjSnI3bDE3V2plTFFXTHNENlNp?=
 =?utf-8?B?OE5mcXlzbTd2VXdVUTZDT3J6ZVVFeHRSSEhyVEIvQjR1NzdUYThOd25hVGFV?=
 =?utf-8?B?cVl6VDZjMEZTbVA0U29CSTVycDF2V1NJS3h2YWtHMDN5QytWdzJteGJFMVNt?=
 =?utf-8?B?NTVVQTlidFJOWGxOdVRVRW5BaFdEcWNVR3RVbEpaLzhjTTdhMXdKVWR3RFZ2?=
 =?utf-8?B?MmcvK0lZbGRaUmRDckxyQk4yV0RJVFR4TDR2YU1QdDJiL0F1ZDN3Qys1YVhu?=
 =?utf-8?B?dGhaSU1uUElTVXJHcStRZVhpVUdmcFZHTnRKY2ZCNWR5NG1ndTBaaGVPbmJK?=
 =?utf-8?B?RVROU3JjdThJRDZIdTN4ajlEWjJ3TGdXVlUwWklnNmNqOFROR2p1R1NWdjhB?=
 =?utf-8?B?UVRJY2JiZmtLZGwyd0dSUzVOdTI1T2FNclB1R3d1SGQ4V05QVlJvbTFsSG5W?=
 =?utf-8?B?S041UzJvQTRpVkJGZzkrR2FwcGpKaVBYQU9GWDNEdEFobHZySzViZ0R4cEhM?=
 =?utf-8?B?M09kZFRUQ3JDYzZzR3RZTytzM2RiMW5RZ3UvZktXb0prblF4TEF3cEthbWJo?=
 =?utf-8?B?L2Zzbi9lcjRNMG1DdlljMVpvbjhaNVMrSTFpQUhZRmx2QW5ZR0NGNzYyLzVk?=
 =?utf-8?B?QWNpR1VDQlErM0VzY3ZkY1Q2bzVwN25UTWdXRUEwV2taaGxMOHFUNzZ4SXFn?=
 =?utf-8?B?U3ZrdGdRTFZQaFcxajhNUEFucGI0MVlHSUtmMnRCeFRvZjJLZUxNRnloYUdq?=
 =?utf-8?B?NHVoNWNpeXVIeVo5dHhRZVFlcXNxMW53SWRqZEFPYXIrdzZHWWxmSXc2UHVX?=
 =?utf-8?B?MDYxR2FITVBUdkZXR2lSazd0a2FlSnVPNnZUOWFjaUxtcjBMZnJXbDd0SHQ0?=
 =?utf-8?B?MjJ4Q1JNcjBSVUhSZGs3enZEU2NGcDhvU3RVVFU0d1VLOEtQRWMwREFvWlAv?=
 =?utf-8?B?ZVpPY2lnTHI0TVNCMHFvR2xTcXBUajNSRzhnd05BemdHUW40UFF3TG8xOUVZ?=
 =?utf-8?B?VjJ2QUczcHV0TUxVZEJDd1lnQnFiN3lKT3ozU2hGcm9DSWxndkxHanQyRGcx?=
 =?utf-8?B?cFJLbXMwR0tvSWMxbGtxano5Y0dYK2hiT0N1dmsrQTVWSHM2OXBRVUpsSnAy?=
 =?utf-8?Q?k0boDkIXijx1z26xZk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <51436DF2D402CF40BB308AD2480725C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f02c8de-98c8-44ba-df65-08d984cc0e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 11:10:19.5446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXb2fbMoKAbJXY5U2Z3PQfs1xWxm3d6Wdxcka4NDRfwT8SkCftj0+IAWcvTq1su7wD4KA2Mx1wwGfBk+OAzHmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNS8yMDIxIDExOjU0IEFNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IEN1cnJlbnRs
eSB0aGUgZHdjMiBkb2Vzbid0IGZpbGwgaW4gdGhlICdvdGdfY2Fwcycgb2YgdXNiX2dhZGdldCBz
dHJ1Y3R1cmUuDQo+IFdoZW4gcmVnaXN0ZXJpbmcgYSBnYWRnZXQgZGV2aWNlIChlLmcuIHZpYSBj
b25maWdmcyksIHRoZQ0KPiB1c2Jfb3RnX2Rlc2NyaXB0b3JfaW5pdCgpIGNoZWNrcyB0aGUgJ290
Z19jYXBzJyBhbmQgJ290Z19yZXYnLiBJdCBkZWZhdWx0cw0KPiB0byBITlAgYW5kIFNSUCBibUF0
dHJpYnV0ZXMgaWYgdW5zcGVjaWZpZWQuIFRoZXJlIG1heSBiZSBhIG1pc21hdGNoIHdpdGgNCj4g
d2hhdCdzIGJlaW5nIHNldCBpbiBkd2MyIHBhcmFtcyBzdHJ1Y3R1cmUuIFRoaXMgcmVzdWx0IGlu
IHRoZSBkZXNjcmlwdG9ycw0KPiB0byBiZSBtaXNzLWNvbmZpZ3VyZWQgaW4gdGhpcyBjYXNlLg0K
PiANCj4gU28gYWRkIGFuIG9wdGlvbiB0byBzZXR1cCAnb3RnX2NhcHMnIGFuZCAnb3RnX3Jldicg
aW4gdGhlIHBhcmFtcy4gSXQncw0KPiB0aGVuIHByb3ZpZGVkIHRvIHRoZSBnYWRnZXQgc3RydWN0
LiBUaGVzZSBwYXJhbWV0ZXJzIGNhbiB0aGVuIGJlIHR1bmVkDQo+IGZvciBlYWNoIHBsYXRmb3Jt
LiBJbiBjYXNlIGl0J3Mgbm90IHNldCwgaXQgd2lsbCBkZWZhdWx0IHRvIGN1cnJlbnQNCj4gYmVo
YXZpb3IuDQo+IEFsc28gYWRkIG9wdGlvbiB0byBzZXR1cCB0aGVzZSBmcm9tIHRoZSBkZXZpY2Ug
dHJlZSBieSBjYWxsaW5nDQo+IG9mX3VzYl91cGRhdGVfb3RnX2NhcHMoKS4gVGhpcyBwcm92aWRl
cyBzdXBwb3J0IGZvciBzdGFuZGFyZCBwcm9wZXJ0aWVzDQo+IHN1Y2ggYXMgIm90Zy1yZXYiLCAi
aG5wLWRpc2FibGUiIGFuZCAic3JwLWRpc2FibGUiIChzZWUgdXNiLWRyZC55YW1sKS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEZhYnJpY2UgR2FzbmllciA8ZmFicmljZS5nYXNuaWVyQGZvc3Muc3Qu
Y29tPg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5v
cHN5cy5jb20+DQoNCg==
