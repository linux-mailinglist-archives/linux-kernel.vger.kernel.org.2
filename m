Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3763736035E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhDOHcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47205 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618471899; x=1650007899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=186Kt6GwWJkZi2txkOS8jQyEjGgatzWDQ+tymQuUraE=;
  b=wsSQl7Rf6PieDYRlfAeXs++S4mAyU3aGodm5qbHV2Xw/02Ct3HP+gm/L
   T/F5q68WT5LjqnB8r1qoZIm4GXVZ3mmSmQKjNGIPwzNY/aTFs7Y5uUktu
   7gap0s3MQKh3XneNHoYkNSsezbjx3+ZcejytvqB8ukBq+WqUMXQU1Vwbm
   24WV2Lfw8mk9d8we0RubYczHnHuJ/NqilXY6gLe8e8BRuAYMl26RFKBcX
   P0pFdEzI+42EW6rDF1jS1TXOvdLIsoVhLh6vMuAz2OB2Q1auFo4iWiiMw
   eAh1NGos7og/8UXjKI4jp1zsnDr09rQWJnGhBg5eMZFrRsmBmrviq75Jq
   A==;
IronPort-SDR: zn+vxpJDzSC8RWg3b2Y8D/7AfXmQJFnLxPm9B6uPQW9KvqmuOeadRbZYAAWAUwjQHxJH+vQdCS
 R86DD0xXEHUagNh4i6JWt+zd/8oNcLpFdKn6qdIFgVb9rdHvAJxfOb6a1HZv344TdvamXw205N
 s5NSzOY21ijkJcHr26O66/OaWLDFyY/oLyI0VMliUXcuqddqfhOBwsVWp8syEPDnuQzVhDgxOR
 U80qghnHnR7viZY+OT5JTLUQAHWbmbkG3mSxj8848aLOn/m61rakEqqhkaicY1xwDmKK6UGpX7
 hxw=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="117091429"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 00:31:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 00:31:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Thu, 15 Apr 2021 00:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKRc24pz+EsS7bZAtMuVdsS+1DufZeihwYTZAtRQL1hJ2NUQJHfEwtR9R2FupQdtwJ33bW5pi3hkI43BVDq7pZkRHuSCklqXbv/bMhUhU15H1fSakmYFKHpx7l5yDgvQlYyz2fECEW4VyBHkZW9dGOExb5AUCyYXOLza6F6KQFsekCeVZUl5X18a/zo3DEtlz1EjU9hOS5oxtAArS7XA+hdG0b8jagUKzU59VPh78ZHwYiXp6XluUyPVgeVYCvH+mHl24ZV0MTXpsTZQXL1QlFNsCEhyrYJT9W9/WpAGv8A13ZgTFq2BocS8IoACfbmW9qq9jtjwlu9tjIGfBJFFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=186Kt6GwWJkZi2txkOS8jQyEjGgatzWDQ+tymQuUraE=;
 b=HdXypT9EvM4qsl6WRFsiJVmFdxkb+pbCdcXCRElRpidDuJO2YgVvqGsdZJZx/k5Y3SkMPCC5IElRpTgJ0kA2iNPWgUHjvU6O3fF8JtlPdUuI5A1+Kja6DtMLZ7QzESA9suWDeFQ1r61VzF2ogboUk3AXqJu+J+u5hZlRfqnzLfgCurBpwdnnzfChwaP3fBhD4wkOYhGx81qb2FVCgUZJgQBLWSHkNNqFQ7O7NtT6pwl8I8ZKsD1YwNr+v4fMz+RkMoX+n1dxQIYFhMKG/W/CKpc38vjp5NfvT1dhMQZJ7aNCQ+332WYmBvbJp0w7BNbdnhhQ1bjUFxxkTPNI9E5vNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=186Kt6GwWJkZi2txkOS8jQyEjGgatzWDQ+tymQuUraE=;
 b=YD4TXQa9XVM7NJ78QIKBN34x0zPDVyDcDgZsYgqwMXNrXPquepE0SWIjXHAYeGHQffudYIx4f7bjYCIyXHKuOvpa7ffVXYgNfkWLJtf2aGdfmmr0EWIGkni38LPxszrP9SJsZk/pwq+2njtuB+EHzG2MkMIijJi/bWouEAN0dlc=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1691.namprd11.prod.outlook.com (2603:10b6:3:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Thu, 15 Apr 2021 07:31:36 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 07:31:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 16/24] dt-bindings: atmel-sysreg: add bindings for
 sama7g5
Thread-Topic: [PATCH v2 16/24] dt-bindings: atmel-sysreg: add bindings for
 sama7g5
Thread-Index: AQHXMcldhEurLqFwnkehOGNR0LrUfw==
Date:   Thu, 15 Apr 2021 07:31:36 +0000
Message-ID: <11fa6a06-7498-bff3-2b40-3c5eb908f7a5@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
 <20210409111345.294472-17-claudiu.beznea@microchip.com>
 <20210412160216.GA3970458@robh.at.kernel.org>
In-Reply-To: <20210412160216.GA3970458@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c91d7f4-56f5-4bac-5d76-08d8ffe08038
x-ms-traffictypediagnostic: DM5PR11MB1691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1691F865569963897EE5F3D2874D9@DM5PR11MB1691.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/cyK11MglBWm+ce8Ro0qdKC4jDwtXZgdgvZTR6YWQ+6JiUClGaqFeCIB9jGG8gU01tipGM6bLI2caWk7nflOsHKbdbaY/10DW6nd8pf8a+icPNuT/LqwXhnkNVdwyIAsiUIvPdpUBA1RXv9M26Rl8n/fNPfYNJlybmxvLEi7j0k5fFp6msOT0KNKbVKfWDi9vUEKmZHf1cZ5qLGLY/J++Fkp4BGriRL0IwAnbg8mqXTBDASHk1c5TrKV5TlWYSkv3mHXX6ESCKaOQfL8iAlWiNeh04nDTuOkLZjiNkkVFBetTBwmXkXgmOkDklKKpXLwU8C0kaL6s6oAwzExAV6huLx1UjFBMIzAxy9j0uA7zvcVC5CQM1vdX4RV7tjdaKfmmPVkZRx/7rJjA0cEzKT8PaTKeCyxlb6zyG0vL/y2uHLNR7jZ237oH0Mzx6arvVUC7vNNTQeDQciEXg6Cp8JJHxe7ghy3lb03yo51EjPYn6FHj1qB/bcy8wWsIyrNY+/T5TQYFEp1HD2EsOnreKV+NJdS6z6xgCA09kHpDwqgutPm0ACnOMRUHyW8fFyxZ4+VgFFhKB09/O6TIe7aXzeiDLjtk1twRxKUs0MWyTCJdUB7/uT2BTvPjDO2LtlyxjYlfIAHxusneziC3H795YimTYiC/Ceg+O7r+/d3+fChTwF0A4f73JtV/A9vdzGhRBkY52yE6sBWDip2NDDWSashFaftJ9haHceet4yNotWoME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(376002)(346002)(396003)(366004)(66946007)(4326008)(64756008)(66446008)(66476007)(8936002)(36756003)(86362001)(66556008)(31686004)(2906002)(53546011)(6486002)(91956017)(6506007)(76116006)(71200400001)(122000001)(83380400001)(31696002)(8676002)(5660300002)(2616005)(6916009)(38100700002)(26005)(478600001)(316002)(54906003)(6512007)(186003)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MTk1Y1JTZjVvTFpESzRCT05VTVVRU0c2aFNtb3pzc0JEbVlacFpjd0ttcCtv?=
 =?utf-8?B?M2hhb3cvdDBMVFJEcFROWjJZdFJCaG5nQ3dWN0tDV2lXRnFIbUZQS3hJVzJ6?=
 =?utf-8?B?VU1IbStFOEdPeWh1cDF0SUxmY29qWThFbTBVYjlIYTE4UXBWZFBUaWZnRWFr?=
 =?utf-8?B?aUIwMjVEMGVDeCtCRjRTZGhqQ0FaUmphc0JpUXMvTXJkY2duL3VOUWdGWkVp?=
 =?utf-8?B?aEIxL0JQWlRJREhUOGRpU1RxVk1YT1JNTklGazdYUmpPejgvR1ExZTlmbTBG?=
 =?utf-8?B?VE93QUwxcm9GbXlHWldoNGhYQjFmZTRLcWgrb3VPN0E4S0hFNFI0SlVYYUw1?=
 =?utf-8?B?Q0dwYWpuNzNyMUV3NG5sT004WGMzeVpXNXZTN2VlVFJ2cE02c2pMdXdGNGVG?=
 =?utf-8?B?SG1ITFhKcEdCL1FXNlhXdCtOMmhyVUFPOU9rNmgyV3o1RDBZeVN1VmxnOENj?=
 =?utf-8?B?L1prTUlJOHJ6MC9jSDY1UnhSRm9CZ3g4MTJHR2RpUlgzNVVYWlpqeGNJeTBh?=
 =?utf-8?B?eHN2aFhWU0xYTnFEcUNWWXdIdUIyN3pLY2FZd3M5eE5xQXJZcEhlNkxyRm5C?=
 =?utf-8?B?a1NmRVlQa0xhVWRDRStUQms4RkNKbW9ORHZpdkp6TVNQaklMMEZncFdHUU5S?=
 =?utf-8?B?OHFTd3VjR1BLR3hWeHh4WFBJeDB5NzdzZklKdkNsdTdobURRdUdPcWJIM05x?=
 =?utf-8?B?bW8xNHNyNEZ2TTZmZTBXa1J6YUhYd08yYlJIUHVXSHVDTHI4Zm9ZYjAzOE5T?=
 =?utf-8?B?ZzVoUnpDQ2t6d3VyMXZmZ1BaWlVCazNnQWRYVGYrWHZDR3ltQlVMeUsrRWYw?=
 =?utf-8?B?UWthVUdXaVRBSHVpcE5NclgxQXROWFNQYVhBeGtzUGFjcnR6anh5UGtSeU9s?=
 =?utf-8?B?RU9yYmU0T1NyT0NIOU9xRVNrWWFOWGFwQkszOFFZQjMreStUclYyR1NCSEZh?=
 =?utf-8?B?OW40OFAzb0VIWS9ROVdyaHNyc2FLUjlPUjhScGJtVVFVNGcxTDh0ZngrTkxY?=
 =?utf-8?B?bjJJRy9Md0ZhUWVMTXYxQWpFWHdCVUFqcVdVZmFGU1JzcWg1Zy83M1M2eGM1?=
 =?utf-8?B?UXNkVjJLSEJjbG5rUndVSEJZRDFlZzVpQWZmYUFuaWY4WHc2bUZNZzluTzA0?=
 =?utf-8?B?anBXMHMwR0JRTVpxS2RVbG9nMXUra0x5YUswUFlVR0IwN21lSmdVc0xHUE1v?=
 =?utf-8?B?M042VE5vYjNVVTdoRFk0ZTJOTTJla1IxdnBta0VaY0MwbTVKa1h2a09DT0l2?=
 =?utf-8?B?TWpwc0J4NjdFK0tuQlJockZadkpGRXZaMjRWVDk0VDVFS2Z6aGUweHgzY0Fi?=
 =?utf-8?B?V0pHdWJ2ODVRQjQ4NkFpSUNIdkhkUXJOZXhEeU0wRXhzM1NEakxnekRPTFNx?=
 =?utf-8?B?SE8xTi9kcU1RR25uTTY4UEREU3JGUFpod0p0NmJ3WXhjRHNRV0JwalJxbGVT?=
 =?utf-8?B?dVptT3dNUzZweExoOGdCeGdEUk1oc1kyY2prR2N4WlNRY0pYemtoWng3c1lw?=
 =?utf-8?B?NEJCNjF0d05rcWhVUERVWk85clRjcVF5ZTVhQzdYMGlmTGRKajdnRUUzbGpT?=
 =?utf-8?B?Rk4zWlluMVdZeHM1OVhaMUlHNXN5VnM1cmtCUWZuMExWdFB4ekNLN3Ezd1l1?=
 =?utf-8?B?NkNEcldLMjg2T0tVcHdpb25JeTBuMlcyVlMrSGdIdFlMNUZhT3dMYzA5QmVy?=
 =?utf-8?B?andsSDI0cWxTMTJmeDg1TksvcG5OVUxNY3FaaVcxeklYZ2pDR2ZUR3E3bm5t?=
 =?utf-8?Q?sXCNrYmSKvtvMpBaTs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1F47CD3BC3699439ADB78418AB714B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c91d7f4-56f5-4bac-5d76-08d8ffe08038
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:31:36.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GP6oxU8MRR6Yo1q8wECnMwZQK9bo1Qb8FHiU9DP+S16L6UWEyfSi7tQtDwcO+YZVuqW2oyxM41PS1T98zQjQwXpC5Wjhm1o2Z6vuk664nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDQuMjAyMSAxOTowMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBBcHIgMDksIDIwMjEgYXQgMDI6MTM6
MzdQTSArMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBBZGQgUkFNIGNvbnRyb2xsZXIg
YW5kIFJBTSBQSFkgY29udHJvbGxlciBEVCBiaW5kaW5ncy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0K
Pj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dCAgICAgfCAx
NSArKysrKysrKysrKysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPj4gaW5kZXggODA3MjY0YTc4ZWRj
Li43Y2Q1NWE3NjBkNDEgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0DQo+PiBAQCAtNDUsNyArNDUs
OCBAQCBSQU1DIFNEUkFNL0REUiBDb250cm9sbGVyIHJlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgImF0bWVsLGF0OTFzYW05MjYwLXNkcmFtYyIsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgImF0bWVsLGF0OTFzYW05ZzQ1LWRkcmFtYyIsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgImF0bWVsLHNhbWE1ZDMtZGRyYW1jIiwNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAibWljcm9jaGlwLHNhbTl4NjAtZGRyYW1jIg0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICJtaWNyb2NoaXAsc2FtOXg2MC1kZHJhbWMiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICJtaWNyb2NoaXAsc2FtYTdnNS11ZGRyYyINCj4+ICAtIHJlZzogU2hvdWxkIGNvbnRhaW4gcmVn
aXN0ZXJzIGxvY2F0aW9uIGFuZCBsZW5ndGgNCj4+DQo+PiAgRXhhbXBsZXM6DQo+PiBAQCAtNTUs
NiArNTYsMTggQEAgRXhhbXBsZXM6DQo+PiAgICAgICAgICAgICAgIHJlZyA9IDwweGZmZmZlODAw
IDB4MjAwPjsNCj4+ICAgICAgIH07DQo+Pg0KPj4gK1JBTUMgUEhZIENvbnRyb2xsZXIgcmVxdWly
ZWQgcHJvcGVydGllczoNCj4+ICstIGNvbXBhdGlibGU6IFNob3VsZCBiZSAibWljcm9jaGlwLHNh
bWE3ZzUtZGRyM3BoeSIsICJzeXNjb24iDQo+PiArLSByZWc6IFNob3VsZCBjb250YWluIHJlZ2lz
dGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiArDQo+PiArRXhhbXBsZToNCj4+ICsNCj4+ICsg
ICAgIGRkcjNwaHk6IGRkcjNwaHlAZTM4MDQwMDAgew0KPj4gKyAgICAgICAgICAgICBjb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxzYW1hN2c1LWRkcjNwaHkiLCAic3lzY29uIjsNCj4+ICsgICAgICAg
ICAgICAgcmVnID0gPDB4ZTM4MDQwMDAgMHgxMDAwPjsNCj4+ICsgICAgICAgICAgICAgc3RhdHVz
ID0gIm9rYXkiOw0KPiANCj4gUmVhbGx5IG5lZWQgYW4gZXhhbXBsZSBmb3IgdGhpcz8gSWYgc28s
IGRyb3AgJ3N0YXR1cycuDQoNClRoZSBzZWxmLXJlZnJlc2ggY29kZSBuZWVkcyB0aGUgYWRkcmVz
cyBmb3IgdGhpcywgdGhpcyBpcyB3aHkgSSd2ZSBhZGRlZA0KaXQuIFRoZSBzdGF0dXMgaXMgbm90
IG5lZWRlZCBzbywgYXMgeW91IHN1Z2dlc3RlZCwgSSB3aWxsIHJlbW92ZSBpdC4NCg0KVGhhbmsg
eW91LA0KQ2xhdWRpdQ0KDQo+IA0KPj4gK307DQo+PiArDQo+PiAgU0hEV0MgU2h1dGRvd24gQ29u
dHJvbGxlcg0KPj4NCj4+ICByZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gLS0NCj4+IDIuMjUuMQ0K
Pj4NCg0K
