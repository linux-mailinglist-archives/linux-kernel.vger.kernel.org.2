Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8A351772
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhDARmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:16 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47534 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234174AbhDARga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:36:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7E996C0531;
        Thu,  1 Apr 2021 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617297537; bh=JFlJlhzRjXio0PnKYmUZ0vQ0PuiPymg47Js7yu9QZkc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NfINQhuk4viWy8mJmV/wXaY2Dh8OkZJYCTaBYSopS6muh+ZCrmRsxGAmH8monR1Co
         t+Sj8kGOP2vFVj7/OrO0W2mECvUYLFwo9Ym0TiXhDd62qEiWzCb10sqlk/MmwRejX9
         GgA2o4j/M5e60KsiUUjCYFko013YG61zDtyZR00gbmMypAc/WmTDb5LpWAhQwovZl6
         uItx5tqrifoyJ6ytSCSkZt9cjQT8mnu28n5+rBUCTx0i3NpSHJdHIxXhpIcruCIFKV
         QodR3lsdoLv8BFNz0DbunLfdZVu4vFCznyjf75PLf3rIHKeLNnkENzA/UUtGOIdJ/t
         1SVECy9RErLdg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C9324A0079;
        Thu,  1 Apr 2021 17:18:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 95BF4801DD;
        Thu,  1 Apr 2021 17:18:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gjvQZnk7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0H7cKeP81DqAbf/Q/2FGnIUNMpXhOx/9yhpH8oCZqtL5b1Hr2YOoJC3n4432zcB6LYny+bZM6xkn39Ki1lzDP31Lp39os63N55ib1kWqh1hyv3jpkjQxLJgQVkOfjgZBrvgpMGscIpWklTgbenRnhLhRT/f8Vn27r8pbHg9Pf/n4YWMwPGCL43Zsor9L5NpgtqCyIzJ/hVRFNaQ24vPQ6+b/GXj2gyzmsojPCXWgVOeZla7XTd+BqXt1lMDQqoKzDwVJ5/7+WCAvw29JOKQ2mLp0+ue5ciz4Kk/9VCN/mlHC3jtzy1VngVkNqg1WUm0x05DcQwo2FmLTfuIow5LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFlJlhzRjXio0PnKYmUZ0vQ0PuiPymg47Js7yu9QZkc=;
 b=CpEO+M4jLUowurKfzx7ucUZfgS2NRrZ+6pFVg0RBlrU51yzqM8Hq8sL9OxPdkYZ6nPMzeGRBpvAgoVmmRTSfdljY8rqcApHzyJKEs/BTDY6fOxxZm/I/3YvY1WJWUPorRfTkrvKfjT4LdFKJIod4WvcmUiRKPeCw4Wx+FuAmVe5h+NvF/U6wyFpyFGcDH4oJawz/9ln6qQ/mGlILcD9eIXiHCOJsT0iv0VfGPE7shLgYTFwmG3EuC/RSwr7JvuNIcN3Z85SYyF4xXe8kQc+XBL3PeY3dIJgUSZVh9MsOLZU7ymuch9unVwmj3+V9XPN//aYoch8yJNJGocVO9TNQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFlJlhzRjXio0PnKYmUZ0vQ0PuiPymg47Js7yu9QZkc=;
 b=gjvQZnk77Nx/SGuNjLIDR6iX/LruXZMF0kXEkfK2oK3eshxxHpKth7j20H/cOC6s0VPNXyW1iKrh54DYKf+EXddvkI9AoUkwSQ6RFE6IgDYVkiJuF9J0ymp9+DM8pJD8ovAXIxx+Jt6fru5Rj7zF81GxZ2TzMDo/7oxOL2vV9F4=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 17:18:51 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982%7]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 17:18:51 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 6/6] mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE
Thread-Topic: [PATCH V2 6/6] mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE
Thread-Index: AQHXJsJrt7d98THsKkKTqF0AvhXoOqqf6KUA
Date:   Thu, 1 Apr 2021 17:18:51 +0000
Message-ID: <2d63f2c2-6478-d6ea-306f-885a58726294@synopsys.com>
References: <1617259448-22529-1-git-send-email-anshuman.khandual@arm.com>
 <1617259448-22529-7-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1617259448-22529-7-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 586dc3c0-0076-45f7-1d1e-08d8f5323839
x-ms-traffictypediagnostic: BY5PR12MB4919:
x-microsoft-antispam-prvs: <BY5PR12MB4919BE554F0F19E9676C0D5CB67B9@BY5PR12MB4919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qikrFrq/B7b0QwufBncSmbZ/B/gVDMSPESMeoRbLh3BiU0j/BZ/BcXl/jwxuM0ajN/qXNH4AclaOBNvmAb2M85XudNNT8pmp6qx1I9Cfkufa35BnqWDeiUMINKvMb+gbcmDuzpdflkGLZWy2XnaKZX+iniytzq2OcuojY1C7D8/jqiLwsV5bJts7p+n6hcfU4XUme0HIrVD23WK09oCqIywbK2z5Wz5aYEzo6RjdLR3TWKhpNVsb0rvUCoKsY42kE+/4+vGUq5Q3X2kL86gqZZ7AHd9fYPr4/Qj84AamaUJfj1QONggm4nJyj+uggDJWiPd6XU0mcMtMHwqEs1Y8H0ctLdny+MofhH8oPUjA8nWK5XBV3bVVBO2N4QQwZoBP0F3BVw5fefbwUKLMERkqwhJ7v+T+yFtt9V6j3dnROMe7f2j6z/yhm+Muk2RyClEf9h8/3oNMHRcnGmbUU/7RntQ9DpYUzjcAUuL7s2ahK8OlRXwqH0kuNsbnZ2mHWrHUkTLVy82SR77n86yYLkiACUk6wZlhrsbI3Ek65sgrkWodN3akZXZfGWZeJGvG00C9cYZ3Q0C2mR4Aisb5VYNhel7hL/Hf5LqopWBEwVOjvEsVWxoadnrnzLrMYiuGsvu+kWa54QOJ2yVGbZ2KG/RC4CrFPkuHbYQkAL8Y9f5zSXh+3vYNtDELIddgIsDduuwjHI4MNjajZtSM08dUAx+vsnWHjV4egu/JkGru6miF9XM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(5660300002)(66446008)(86362001)(66556008)(71200400001)(31696002)(66946007)(53546011)(76116006)(66476007)(38100700001)(8676002)(6486002)(6506007)(64756008)(26005)(558084003)(110136005)(4326008)(186003)(31686004)(36756003)(8936002)(54906003)(6512007)(2616005)(478600001)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cDFYN2d5NVBjZEdOOVZhUTFjYS82NnpOL3NCSUhyMkc0VGdQc3U0dmlrK2g2?=
 =?utf-8?B?dEJkMjk0b2xPd2ZUQUxKdDhOZis2RXdqOGl1bVQ0b25lMFdKYUZYSUQvb050?=
 =?utf-8?B?WGY5N2hBOEdKczBtSy9CeWtIUi9MV2NnYlpPV0hENEF6S3BmUFhxMTVtRlA4?=
 =?utf-8?B?NmxGakcwVWxhbzN2MjFBSFZKaVFHWkMzMTVKeUdkY1cvYzVmVS8wNk5hRnNw?=
 =?utf-8?B?MVVBaHhaYzZFdnE3NWUvVW1OQjhLWXV6bFhjSTdVWi9oVWdaa2gvdGdTa2Vz?=
 =?utf-8?B?QmZFYmNRdW1zdy92ZERiSmpwQUY1K1Z6MUZyV0ZVTFZVMFlnNzhEL0h2OVFV?=
 =?utf-8?B?ZmR3cUxvZjB5SW9Ld25rK3k2OVVld216anBKM3VsSnRlRkExMExpSEx0TnNP?=
 =?utf-8?B?OHI2UW01cjZSWWdiM0VMWVN6dmhFT2gvVEVWY1VuSVNNSXIxaEQ5eGhTL05K?=
 =?utf-8?B?bzFIVG9Ndlp5RTRVNFdaSFpmbms1TzFJRDhobkZqSGZGQ0RPdkE4MWRoVHlk?=
 =?utf-8?B?L09WY2tZeVRYT0R6OVZZemxycG93czZCaEM1YWcvdGpHbnFxRmFsYnNOU1A1?=
 =?utf-8?B?bVJhaGdBSFFPY2c5MnBmVncxS3FLVS9xTEJCc0J3OVhFTXNuN3lUZC96cVdF?=
 =?utf-8?B?cDBUTUgwd00yUmJYSlc3YVN4WEhKM0MveGVlQ3FuS05CZVFUMzVXNFl5ZEIr?=
 =?utf-8?B?SWJHalkvb29nQTNSUTBWc0JTemROSGRtdVFqNkNtS0ZxZUczaW5LV0hOcWpn?=
 =?utf-8?B?THZOSko3Z3lnVmd1YThjMC9ZMGVUMDNKSm9mRFA5MU5TUkhWakxidnczM2RQ?=
 =?utf-8?B?R1RNT01nOFNaTi9rMWpPczNIY3ZLdWtYVERwaURrZG1pMWhxTGFnWWQ5VWtk?=
 =?utf-8?B?QnJyYzFXQ3pybDBnQnZwMGFzdGdxMGxlNXAvcms4YUhRUE1KWitaTks1c0tn?=
 =?utf-8?B?VDVaNWNaN3o1Qy9SdnArWmFTVlFqUnd6NjJjemk5QVltTE9CTzZpdmRqOG5Z?=
 =?utf-8?B?bFRVeWtkSXY5Ny9yVVVMeDR0Z1pnLyszMjE3bll6S0ZsRjhUbXZlRnVyQmU4?=
 =?utf-8?B?d0RBODVPMlJRTERNbGpOeHc5YTNreHdscFltQmtrcVBZbVBYc3ZRTHRibUp6?=
 =?utf-8?B?NC9rUTVmMkg4Y3piVHI3a2h4MVFETjJueU9tbGdUSXJSKzVyVVpuQ3N2dUhK?=
 =?utf-8?B?cFZwd1Zycit3M3ZRdDJKU0hIMWtEanhQbnpDUTFqcVcrM3FNdFBrODRsK0xx?=
 =?utf-8?B?VzVRbmZ2TjgrR0g2UnFKVk5VbXprdVk3bVhnUi9LdmhZT1RLQ29aaUNzRGN6?=
 =?utf-8?B?V0UvdzBwMXZsZ3FadUx5Q3F6OGlWVFdOUjVOVFpJTnVseFZlODBDRExRaDdZ?=
 =?utf-8?B?T01LQVlUN1lvOHc4SFl1NU1UbkVPcW9JTHNtWEU4V2s1SWRuSC91U3pEMXl2?=
 =?utf-8?B?RG5nSmRLK2QwTFNvQmllM3V2RFAxOElESENteUlhakhpbWtibVFMazlhaU9F?=
 =?utf-8?B?dlJweWxGWno4eXFCdUQ4eXdtS0Ezdm9NejVaQ1ZCei9nYzVFU1hUTUxydEdo?=
 =?utf-8?B?WUd5MndnZUlYZ0Z4c1F2WDN1UTJoRGJ1QWl4L1NzeFNrVjJLa20xS2dYOVQ1?=
 =?utf-8?B?VzlHTUVGaEQwMEdKdnM2UGRiZWR3WG95Q0lCWXhCTmNmODZXZms2VW9XcW81?=
 =?utf-8?B?SytWVG54OE5wZ2kxemROenM1Z0xjNFlvK2JPRDFkdk1oSTBOb2JnSXdZRXAy?=
 =?utf-8?Q?Orzc0LDTis9r6KyNOk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D246E13C18B0EB48AC6A2F0AC6F9567C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586dc3c0-0076-45f7-1d1e-08d8f5323839
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 17:18:51.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oh7RSRteWDLm4CP4/Fmp/H7/Vfp1yyJfsNqwwhKtyGTH+0WZqG2DXUyzBY/YQ2bSqzcxSH1SYz0/Kh4Y7sF8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zMS8yMSAxMTo0NCBQTSwgQW5zaHVtYW4gS2hhbmR1YWwgd3JvdGU6DQo+IEhBVkVfQVJD
SF9UUkFOU1BBUkVOVF9IVUdFUEFHRSBoYXMgZHVwbGljYXRlIGRlZmluaXRpb25zIG9uIHBsYXRm
b3JtcyB0aGF0DQo+IHN1YnNjcmliZSBpdC4gRHJvcCB0aGVzZSByZWR1bnRhbnQgZGVmaW5pdGlv
bnMgYW5kIGluc3RlYWQganVzdCBzZWxlY3QgaXQNCj4gb24gYXBwbGljYWJsZSBwbGF0Zm9ybXMu
DQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+ICAgI2FyYw0K
DQpUaHgsDQotVmluZWV0DQo=
