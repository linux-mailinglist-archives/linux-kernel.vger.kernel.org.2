Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9041EB7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353759AbhJALM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:12:26 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35386 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230514AbhJALMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:12:24 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 451D745AB2;
        Fri,  1 Oct 2021 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1633086640; bh=pgoyj8C8dOf0QxqdXTKpVIQ24LNEOPSO+Hg9YHK7HzA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KK8wjpCihyfJiqAdzmbHQMPQeNDGl05/n4UattZhe56/VfBlYU3iMVTYTlyLBzUcf
         qUuZaGbNGsywLWXrmvVgbnf4EZy6XA2pKG652u3QxI5dbhutM2MxGyV3CtzmbjMrd9
         lreU0cbPE2KZSBJ24dCWXVYd16iqxebTHdKnbp6VWnrpbuIAXlDgqSc+JFp6VKHiBy
         ER6LSCqeUvLgouHFfF/GPVy4OuedX0XjTTqmOD0oRZX/5wSgKdqnSfaHCfZyKt6Zcu
         k3m43lR5/LBk9kOWuJ1YHG8mk2i9JGQ78wUlnxcr1W9ZpMzyYf1495rMe4sCAskZ0U
         eLrQ5O26dtMUA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7AADFA005C;
        Fri,  1 Oct 2021 11:10:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6CCEB40096;
        Fri,  1 Oct 2021 11:10:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NRXd/6yG";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbegjpfsdZ+A41RkgkuJtr39owM6J21r+ApEcAvKX3smuIfd02vjLCJFDGUh7vMeaNGkJWeIPGoBXbjGl+NZ4vNLLZqhcybP8UMFFSus9cwagxdw8ynjtO+mLrm7YlkawUGwcEYXFRPufOVNRUqVOm03KpK5arsaUZQ08P9yRH+YOcLRHzB9Uddaf95vTfdcccQR6nSZDQp0cS4wXE84H1nPhyGiClx4P2d7mAJn+0npsEKIvi7CBmTwKO7dUQiEw+Lpd28WJasjo1enyw3VkuI1sir7gL5+KVve/50xBulc9BltX0QVFYnvXZbuIZITo96hhb6kbk3+Yltcdv+j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgoyj8C8dOf0QxqdXTKpVIQ24LNEOPSO+Hg9YHK7HzA=;
 b=BG+GllEclS0B/4jH2rqPtoDpc2N5zim8lRbxuFD0BQF8s1A2SLDKaUHaBIPKuYPgRjUnVPvUyPxPlYd6YB4rTiKIkiAvhbOCpidTsYuzQbK04k8WkLOCXEbZZaX0fEdFxEVDFVV7X8QFOeTn+lHWImGyw9bXPedWs3IU4L8TUTPCP0FXIocLokMX+/iYEKihz2jC79XfwWv4ohDMYiZG7dEVsb6R+xNbP34eVY+3DFiXgLlLshKA+ZTyYkibj3Qoz6mnSHytexZo4jYOw7sFxLWA/JYUDP6dlz2Dzh/zWSjwPjBoq7mGD/bovo3w5CykjKl9br9BjdQc1EgwSD5UGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgoyj8C8dOf0QxqdXTKpVIQ24LNEOPSO+Hg9YHK7HzA=;
 b=NRXd/6yGvXzYuJbLIVI63Tikn1n9W831q4owIeCE0qyf2Y239sjwX77+dcAkOW66hA6w+xF0KwKAaRSBHlq2A/EgncpoX/+Gp7ujiIPaHYhAXr+tdxfU5Wl0YK8mujSdBLZIu5kujy961D04Pj+z3gVIciVVj4Xg2qeFjl1g6qE=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Fri, 1 Oct
 2021 11:10:37 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::c91a:f6fc:9847:4dcd]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::c91a:f6fc:9847:4dcd%8]) with mapi id 15.20.4566.015; Fri, 1 Oct 2021
 11:10:37 +0000
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
Subject: Re: [PATCH 2/3] usb: dwc2: stm32mp15: set otg_rev
Thread-Topic: [PATCH 2/3] usb: dwc2: stm32mp15: set otg_rev
Thread-Index: AQHXqgb3AqBmN1fqR02aX1IZQ6ivsKu+Fd0A
Date:   Fri, 1 Oct 2021 11:10:37 +0000
Message-ID: <92611706-3847-9ba1-8d2a-2e9eba654e1d@synopsys.com>
References: <1631692473-8732-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1631692473-8732-3-git-send-email-fabrice.gasnier@foss.st.com>
In-Reply-To: <1631692473-8732-3-git-send-email-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: foss.st.com; dkim=none (message not signed)
 header.d=none;foss.st.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b1dfbb8-f7a4-4819-cf44-08d984cc18a9
x-ms-traffictypediagnostic: DM4PR12MB5328:
x-microsoft-antispam-prvs: <DM4PR12MB5328A4E4427F6CF895FAD097A7AB9@DM4PR12MB5328.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iC1VRNwFTO+lPcbC/LywPbsIxZbctdpRqO3kqcLNmr6IQHhOIestQhh2H4O+vfYOE1NEMzyE3wDYzTjKk67tLHssDsirYsH0s0sIpFhsV1XSsA6TTPWiV1yRH7chZtP2PmM63wMWavlOjzBPXeNiCcF//50saqJVfLobZpfWHGUOT8nVypc++cLEpnawTMijExRjH+63PcFrRFhZk3oupRwkJXYmPbLcZ538XUVx/LRQW3b4U42+g0cb/U//wvybrJfE85ck2L7Y1hKZtn2+crl4KJN+DaYLVmae0K8VoR40AWCKI8czvSHen2CLKQkpdvAeZncMNvGaWsJlEvZsbleDSFRmN8sZyJm2o/vkjeuPcurORvHn/haJxDEqE0sbU+J/osADY5sR5E6BaAItIHApwKEioTsM5rA4XSRSIdvA4LkY5rmltF1PZCBA9M7oqaMiDRd837mdISeuyOwD9hhhW9YqJljRaDHOeON4b5d7M70W51LRFF0ZCjZlGhkp3haQ48iHKqf2aGE9Z8al7Fw+5BNoo1uKi2uWNQMx4nTDhJAkC0gCYu/c5BsSHRRXYFOOopWFqlUYA93A/fFc6xPDLS0XwH3iWSdh/gW4O5BeWiTY7A9nywTYIKSVHhKdRfOx2eyb5Ita7Kw51sK3+nea/av39S15NFsxhCdsHwe44mVuKCZNRUN0GLZ22h3I+kchcW1W5CxuYME0kc+6t80OcSY8rRE3msgh5mjU58u9ar9KXF/kYM49/zD67+lQobMUGcuvD3PQHcIRbb+8Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(7416002)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002)(38100700002)(91956017)(122000001)(76116006)(6512007)(6506007)(53546011)(4326008)(38070700005)(36756003)(86362001)(2906002)(54906003)(110136005)(31696002)(2616005)(316002)(83380400001)(71200400001)(4744005)(186003)(26005)(31686004)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjhWS1UrUFZPRkpCdWgrVHc3STZaN2NFdDM3TExVaHJIS1A1ZTBSdnFvcXQw?=
 =?utf-8?B?ZFFRS3hGUTBodUNobXJ2SUlieCs4NE1YanZYK3hNTFB6Q0lmQnBBRUxKczcz?=
 =?utf-8?B?NDdvZGNocFhRenh3Q2p1RHk0ckt3U3ZLVStUWnk0RkJqWUkwZzR0UzNaN1BV?=
 =?utf-8?B?N0lQUFZEOTlxVXpSaFVSWEgydEQrUmZCK0tvbHc5Zm41MTJMaWs2TUJDWGg2?=
 =?utf-8?B?RWw3bllxdzJlZ0pZM0dwVFRoWnFicTF6TFJVZkgyNldWK29vaE9tdG1SeTB2?=
 =?utf-8?B?RmUwNFdib3NXNGEybFdJWXVXc3VHWjdqdWpqVTFUS0VidXNSZUdwVWZzUncz?=
 =?utf-8?B?UVZkUnpYQzdEcTdqaVFLUHVZRndZS3Y1YTRDTnBJMWFoSmdJcWNnMEFpbkFp?=
 =?utf-8?B?WDlpcjZUOTFQTGpwS1BVb3N3TG1PelpXNVBybUVIM1lUbGRtTmxPN28zTlhF?=
 =?utf-8?B?SHR0VWIrSjZmK2sxOWc2S1ZndUgySEJZcFIwTzBFVE5lYlF4UWk1VXkvSyth?=
 =?utf-8?B?ZFBMclRJRFZVQVFiWmtMQ0dXeFhkZDVpVFBHYzVGVFQwSVlMT0VUckZEamJ0?=
 =?utf-8?B?VmM4c3NKSUpZQjRSQ1NpUVI4YzMySVFtb2Y0aVNPQXhYazF0ck8vbmNSSFhj?=
 =?utf-8?B?SC9QL3R5cHlUb3lUQXhEUWZVMEJEa0RpQjJ6QnBmdDZabXpuMVUvTTFYaVh0?=
 =?utf-8?B?Rmd4aXdHcXJlRlArWC9Db3Jha2kwNjJWR29zZ0pLanNCMXpHclNiM1VjOXdi?=
 =?utf-8?B?T0xwQU5JVkRLZUdCLzlmR2hvU3pybXJtRGpzMHJGZFVjclFodEwzckpHZ281?=
 =?utf-8?B?dWk0VjdCNFV3Z2c4Z3RHZ2R4bmpaaVpNajJxS0pvWklvK3hpRWx0THVNUGVY?=
 =?utf-8?B?WWg5Vm5SSWI2YzZjSkEzNGFwVzBHdEZPNGhsSUREbTRaWmlTN0w3TFpqUFdo?=
 =?utf-8?B?a24wK2dEMHdFeHltN2p4KzBjY2Z5bWxjaWpvcTBIdFMvdTZRSW51YXZzSGVF?=
 =?utf-8?B?aGZPMnlBcG1xZEV6OFk4dFhmZWRVVEVNMnQveVZpY3RHbElHMCtacGY0Q3JW?=
 =?utf-8?B?VVB5L0pFQXl6eU5FckFReDRiaW8remhyZ2lEZlMvSUl3QXdpUFRPc0wvOTR2?=
 =?utf-8?B?MmhXQ0g3cFRGL0ZhT3NRN084K01PR3E1bnNnVVFtUmZRNWRpVmtiVVlKYysw?=
 =?utf-8?B?MWdjdWtMdlI0dkZXb094Y1dCem1LbEhLSU03bW5uaWt4ZFZFdDJPWUVVTXpX?=
 =?utf-8?B?ZEVOcEVRelZhc3ptZHZZbmZvWlpHa3FZbjhLdnF4bXlpdWRIbWhTYllYRS9q?=
 =?utf-8?B?RFpTbGttVTdydWJXblVwQVZpR0pOV1RPc2ZsVU5Dd0pUNThPcHArN05ZNTdm?=
 =?utf-8?B?UmxDeFNORFpNTFlKemdEQW42N3c0L25wQmVwdEhzeFdVVFllQjR1blhYWHpT?=
 =?utf-8?B?QlFoclppNWhNcGZNZW1sVnlySytwM2owSUZqNlRYSVFqVEtGY1ZGdXdhMFJL?=
 =?utf-8?B?OXNBQSsvTUVhZlNwc2xRazJjM2c4cHI3UXBVVmliYjlsbWlLL3hTM0tiZzMw?=
 =?utf-8?B?QngzaUR3TUFOSGdyNVNFWUFBMXBKTmE0Z1M3a2VtMkEzY0tPUjJpMVNjelA5?=
 =?utf-8?B?a3BTY21Ockw1Sjk1azhGM25lY3Z5TGkrS1hLUGwzOXM0NWxlTDBBTW51ZHBl?=
 =?utf-8?B?TDFxSlFsOXRtSUpYV3M0U2l4SW15c3VhdUhOb29yb3ROQ0h4NXlYY1JtOFB6?=
 =?utf-8?Q?CfQfyJpp7X8iG+s7SE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D566E548998CD42AE5FFC50B15CE09D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1dfbb8-f7a4-4819-cf44-08d984cc18a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 11:10:37.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TusLYVKt5LCyGXtoN3YaQG7U7xgmzcm+qVTAkHWVAJZxTvLY/lwS10c+1764t598LYuGl9/CifRRnSigEse1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNS8yMDIxIDExOjU0IEFNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IFNUTTMyTVAx
NSBjb21wbGllcyB3aXRoIHRoZSBPVEcgMi4wLiBTZXQgT1RHIHJldmlzaW9uIGFjY29yZGluZ2x5
LiBJdCBpcw0KPiB1c2VmdWwgZm9yIHRoZSBvZl91c2JfdXBkYXRlX290Z19jYXBzKCkgcm91dGlu
ZSB0byBjaGVjayBhbmQgdXBkYXRlDQo+IG90Z19yZXYgdG8gdGhlIGxvd2VyIHZhbHVlIGJldHdl
ZW4gRFQgYW5kIHByb3ZpZGVkIHBhcmFtcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhYnJpY2Ug
R2FzbmllciA8ZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tPg0KDQpBY2tlZC1ieTogTWluYXMg
SGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg==
