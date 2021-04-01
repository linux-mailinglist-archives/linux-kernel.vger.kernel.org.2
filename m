Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD8351763
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhDARmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:10 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47536 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234170AbhDARga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:36:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48F3CC054D;
        Thu,  1 Apr 2021 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617297496; bh=Fv/Goj9G16T6C9WpuV13UQgI1KVTRVJkQjNI6uWU6bE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lN83d5DzE4n3Fghb5FhT7ws4xKf5HxfcY37fP4YTHQ3Oi6WJmrGEXzvKO7dSh/V9p
         l9fue5bB2vxWiXUEP8S6PULWI1bRbctNUq7ZJkPOG7+M4YAgeZVFqLEu7ywxxrDIyg
         SbVEK/0vD59qTYu7CzXmFASqL1FJ4gRsm11V0F8yQUO8TNEcD17ZKk6NKNC/fGYST8
         v9lGyb1U0eMAdHCGQzQ5w4PMiF5AMMD/iluJCzz+NOJUfRb0+VBRoLADiTITu8V2O6
         S0M1o4ep6hxRDApV3XCLfFeY+M0a3r7T71CX0ue05uFQ98boYGL05BuZClvCuwYP3c
         Q8mwTmMSVdx7w==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 50F02A006B;
        Thu,  1 Apr 2021 17:18:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5C52E8021D;
        Thu,  1 Apr 2021 17:18:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MJNLPWuv";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hae9utDgPk87Ha/m3yCM46TzbbINRoacQ2UDxlVPoh5kfWIT35coICyAUwxZY/eR09g7v3XjjLeNvbimBAMyhO/NGMT8pOUbjhUTM0yBKZxpnu6SXI6ZGBrpLhWHCD/ZVAlBVjX7nzzDeE2ZoM1dn/7qXDH38IPucCI5AzrYLHugM+sc6Nhea9FuZhlQkHViFk2I0r5aNivfXOsphW/GvIJIiNaNJe6srB8U29rEwPSjX6yI4s8xr0NxCqagI1HIwkekRL+1Ifl7L7oVcRLRJi2a8TPPr5JmNjCYqycWKUe31g4vlwgj+zivOJmjXF0PKzCtdhAoKqaWfIBc+LeKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv/Goj9G16T6C9WpuV13UQgI1KVTRVJkQjNI6uWU6bE=;
 b=bG/tm1DbXq0J7S2IoEGsdXh+7HdAjoL84o8UWmEaUsjmwd/7w9kZQvS5NbOdSXiI47DtUD6lzuy6hFLyXK7s2Q+KpCCFLIt8g51xMb0jUcD0O0Tl1eraZiaeipZwRplsJJZGmCN+1SAvm6exERvKwlpLhTOyq7L7j2ZKLvFqph4AUFGsYcIJ99+z3jwWMUQs1te+JsYftFNAbRB0U8ykTMJazR1HmlN1YW0zwpaGFU+wPj1VGDPwguG+G66nqMgOph5NCWKokOMjwwKZbsQ3G2ntagWZiT2pOVwCYOf8HTcnbKnEquB+LhTXWIrTwBl0jmxuRmDuzGWQhGxj+VS8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv/Goj9G16T6C9WpuV13UQgI1KVTRVJkQjNI6uWU6bE=;
 b=MJNLPWuvkWd4Ar02eJqG/y43SVshbpNGEYscOaawccC2JLNQj4/xG8hfAZDWFjmy3mynCPMFvNGi7cUKImFG0n6uStgopnux1IMHf0z2UDjqKxYrhtEnn70nGAFE6Tu0J6JWwALaDCsBycGv25x1d4Q9ye8RLcjWWxGdZFtJ5Do=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 17:18:00 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982%7]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 17:18:00 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 1/6] mm: Generalize ARCH_HAS_CACHE_LINE_SIZE
Thread-Topic: [PATCH V2 1/6] mm: Generalize ARCH_HAS_CACHE_LINE_SIZE
Thread-Index: AQHXJsJYcp3ljdBebk2oPjA6MJyA26qf6GiA
Date:   Thu, 1 Apr 2021 17:18:00 +0000
Message-ID: <c88eb6c2-505f-bde7-d60d-4fb33078012e@synopsys.com>
References: <1617259448-22529-1-git-send-email-anshuman.khandual@arm.com>
 <1617259448-22529-2-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1617259448-22529-2-git-send-email-anshuman.khandual@arm.com>
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
x-ms-office365-filtering-correlation-id: 1ff25300-9df6-4523-0343-08d8f53219f3
x-ms-traffictypediagnostic: BY5PR12MB4919:
x-microsoft-antispam-prvs: <BY5PR12MB4919CE5D9C729F4E6032117BB67B9@BY5PR12MB4919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2umh84qqZq/SukhggjFwzxxVKlgWy1ADdfVL5jUrL1mLijrhLwg24JYr6jnHio8G7WTIsUdxRbnCPBCsDSCtVn2/OCws70YcL2ViCoUnvZ0Pn0HhZBoRygtaMJnluNoTr/2ycBBehbM6SP9KRzA77nofOCSi2jg3Wk8qOx2NA2IMxRjPtj8HWIuLwIMWmnoIhrzjdb4MAsdYg0uzt3xmTcSHDO+R5lc8LmBPJ/B6OJbEEU2+QVzowjgZPZyhYCKsBPRyDPGdFEVNQlyw9LdtUJhOaEmGeguzeJE+8yursydCqTzreob5NOatQPQXdtJJkEpny0eTwyGUVbl1ypNE1WFSg43Rb4YGKxTtmbaGqlRaLif3q9Ow2uzDC7qeKJZZYsRuQFYFhZNbaxa+nzywljRC77VtoSRvwshqcrRSA7uHypBT+zLSs+gEfDu+h5u6ygoJzdOk4yTE56DRzRFjv0nNfvTKLaVpY+uDpiU6LXvA03OZhWFdDziAUzsdtINy7CjESzu4JwJ/waKWIcKQC+b1o080ZgAeTFKHcb6gqx+Y+4npy44xC0Q+VmuNW5h0wSqcdYoFuz46Xo2D1km4b2po2gOpnjcOhW5Va/ZZKZcOORl4F/gBOqITlPV7h5i0yDTNWZYCDX2LoXPV2upK2XHgLW7rq6qz5ZmdZH3qngIUItYS2608oYfPUXbwkWqH1iAW9Z0WiNbt3LBxqOSrG09GUJmVU3XMLHp4vjmDVpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(5660300002)(66446008)(86362001)(66556008)(71200400001)(31696002)(66946007)(4744005)(53546011)(76116006)(66476007)(38100700001)(8676002)(6486002)(6506007)(64756008)(7416002)(26005)(110136005)(4326008)(186003)(31686004)(36756003)(8936002)(54906003)(6512007)(2616005)(478600001)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWNpbTBETlJWWUpIYS9MUnRMRWhScDdjMWVlMXZiTmlrUm5HbFBGb1hmeWZY?=
 =?utf-8?B?K2JhQ1hYYytSYzRmQ01sS0hlRytsOUNIbXVEMUNaelprbURmalFCZ3k4eTNW?=
 =?utf-8?B?K3N5eDJ4UkFKajVFMC8va2ZDSWlZL3djeWRCeFlDTHlsOWQ3N3QySnRZb3hy?=
 =?utf-8?B?RkZlSzlnNEltVjQzdUtWcVFQdS9IRGdvSmJoWEFSUWY0WkZjbmFBOGZKSWNh?=
 =?utf-8?B?cTUyOGg2cE4zNGVBdXhES2hxYkVpbnZ4WkZKeUNKMWludFk0d2ZaYW9zOXBB?=
 =?utf-8?B?cXl5bGNhZk04SUVpQ01LT2VZK0RlaE5Lc2llZE1FWXEyWWFLN0E1YzZva2Jt?=
 =?utf-8?B?ZXJpUDdzRFMwYVI5djE2NE9VLzh1UFlpTWU1SzJyMldZY2RkdzRPdUNjSHNB?=
 =?utf-8?B?djM3Qk1RUE9jakg1UW5PckZMQVRka1hOekxVUGQ4U1M3TDdOcThpdE0zWXl6?=
 =?utf-8?B?aDdTcytDS0doSlRkV0NsNkEwYngyVmxIMmRpRmpaRmxHYmpzbUVROURydk14?=
 =?utf-8?B?c0gvNC8yM2w1dVJVSFFQSlhta014NEpEaHlXUXdQdkthOWhpcXpPMlBPZGJU?=
 =?utf-8?B?K2FIS1V4cURTSmVHclllNUFLT21VNVQrVGIrL3dvRHdmYTBzQnExY1YvSFV1?=
 =?utf-8?B?WUs1Rk9qT0dMaVRZc2krWS8wQUd5dXlWbUttUS92VjZLUCtnMmtiSjEzQWdw?=
 =?utf-8?B?ZnU0ME5Zekkwc095eWVxdm8zOUg5dU9URHJMVHlwSThteVRYWlQxRzZ0ck5C?=
 =?utf-8?B?N1UxQ285bE5uY0J1Z21Dd3V0aDM2d2U5UnJ5NmpWdFdEVUQyaVBzYnZxWGVi?=
 =?utf-8?B?RHQ4aERtblRtU2xRV1FNOWI5bWI3Q0VXN09KMnduUGhpZW85R3RDY1p3QUpw?=
 =?utf-8?B?S2NtUkFLTThzaUNMRTFUOEF5TEZTVTFQOVRKa1RZa2ovU2pxajBNREpoRTBY?=
 =?utf-8?B?SmY4Y29aZUVCY1hFWWxyc3ZpY0RyaHU5VDQyOWt1NlFhZkhpT0xacG5GNm1O?=
 =?utf-8?B?aCtyM2Q5Y2JHK1NPZzZzUmt1TmVaMHNHeC8yeHRib1JLL2tHUWlzei8vR3gz?=
 =?utf-8?B?ZFkyTWZNTmM3ZCtHTFB2UEh3TFVzSFpUdHlEK011OXNleEV5TlhHVVpaWng0?=
 =?utf-8?B?WTQ3Z01HTFE3VTZpak1iMUtTZXo0bkVZelNDS0ZQa3lRR0wrakdFckZBV1gx?=
 =?utf-8?B?WTlGQkhXbmRZcFlVcDRxY29xTzJWRlBVVGQwbG4rcElPS2UrWWJzRmZjNzZu?=
 =?utf-8?B?djJCbVBLZk1ta3dVWThOcVEwSlpoZHdTRG9OdDgxUTNUaVlCVk1PUGZqYmpO?=
 =?utf-8?B?aEdaeXlmNXBsbVVKSGpIQTR6MDNNZUNVZ3diTFNQT3dMWDJYY0RJUWh2cGpH?=
 =?utf-8?B?VG1VVTFoSjB2N0YvVEJJWGRNY3lwY0c1akhFcTNYUllNVHg3cVlXOVhSaklN?=
 =?utf-8?B?Z0NQT2lLc3F1a25SR2IzWlBvM2xldkRQKzgwVHlWUWM2UnZ0bmNUdkFKRlUv?=
 =?utf-8?B?RnFFSTdZOTl3cFN3dVg1WTFIY24ralBYR0VSTGxRZ1l5WWpjaTQzUlJhV3ow?=
 =?utf-8?B?eTBUYnpHOVZDMHcxcE1QNXRiR2twQ1lzcGNvaDBGd2xkbnFaSkhQZDhDSlRr?=
 =?utf-8?B?SDEwcTZDYk9nY1BsMFh6cVJlVkFYVmZNYU1iUjZsQ3ZQM2w4bXJWMDRpYUk1?=
 =?utf-8?B?aS9KeFVTNWVrbzAxQ0tzeWVsb1hRK2tyUlljaU0wTVd3M3A5TmFQa1hzMWhv?=
 =?utf-8?Q?rI2Zo6U9+N1KU+EGKs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33F95B8A09AAD245A5BFA26FF7FDD662@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff25300-9df6-4523-0343-08d8f53219f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 17:18:00.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIOKiZVjsn6xN2k4/PCHIRCa1KgN9Fa3H7OBqkFt+fduR12iOijH46uf+xLh6TzfFru+AASzL09k+ohBF2CT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zMS8yMSAxMTo0NCBQTSwgQW5zaHVtYW4gS2hhbmR1YWwgd3JvdGU6DQo+IEFSQ0hfSEFT
X0NBQ0hFX0xJTkVfU0laRSBjb25maWcgaGFzIGR1cGxpY2F0ZSBkZWZpbml0aW9ucyBvbiBwbGF0
Zm9ybXMgdGhhdA0KPiBzdWJzY3JpYmUgaXQuIEluc3RlYWQsIGp1c3QgbWFrZSBpdCBhIGdlbmVy
aWMgb3B0aW9uIHdoaWNoIGNhbiBiZSBzZWxlY3RlZA0KPiBvbiBhcHBsaWNhYmxlIHBsYXRmb3Jt
cy4gVGhpcyBjaGFuZ2UgcmVkdWNlcyBjb2RlIGR1cGxpY2F0aW9uIGFuZCBtYWtlcyBpdA0KPiBj
bGVhbmVyLg0KDQpBY2tlZC1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPiAg
ICNhcmMNCg0KDQpUaHgsDQotVmluZWV0DQo=
