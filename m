Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85B331D262
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBPV52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:57:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15529 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPV50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:57:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602c3f9d0002>; Tue, 16 Feb 2021 13:56:45 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Feb
 2021 21:56:44 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Feb
 2021 21:56:42 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 16 Feb 2021 21:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6OOX752S7MpBicEkx/fks1iF/4VSQJVojIDLmg1Ax3ZpkUK3ZbsQaI8NA42ozAiq29MNpg/teUEE3xaH2PoU4hFUHQtS1P8U7Z8RGcFMxojXe52nwk444CxpcyKfh/0uJxlQFcIwDuUeVLSeBfc+aeKpv3/bn6fkY83vfj0+shyYaoKcxysZo2G1GP72YT01U48Of5tUc4vIWlfBmH7UvFwgC8Ej7OyDlZIxJI/WQXn0/zHekmkacZ1mHm2wiM8UEPvvjcuYYVzug9V5hq6KDsgxaFb0sker4pkRWbp1kKEdylxbw0t9KoCxsr9zQJEmDHYXSAtbLSNdTQS2q5c+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrhT4Ti7e7uIMbr0p1sUEDl2NXje1AF+NXo1/zJsdKk=;
 b=GeXo575W/uNjNeRwKbaVrVABmTyPUkg73h8JQ3X0oZv9OG6ANCaQ5EHAl1zQdCrNVGdznCrkr8qppnP5x/NPDM0tRwnqGUvHFitOrR4T785jHmpsZgAYR5r44HAVvjeMdE4NByMZN2k+eMrS67xOkqsmSktFbQj6PafRZm9pTH/ODVhaQUqGc+ej8puBy9DYQO0zLGwLvaO24+1QUsIz4g/D0L+3E4bdrdgHv2N3QsE4afIzvNKMO+jP6aphd1JBG2LlsTqL0UVVL4ORPdKDpalUEulHH5kP1mrDfrGRRoNYv/awuNwWC/6EvUaCJ5R54BfrngZ2VfaLSsk/4+IeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 by BY5PR12MB3747.namprd12.prod.outlook.com (2603:10b6:a03:1ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Tue, 16 Feb
 2021 21:56:40 +0000
Received: from BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::e16c:ea19:c2a6:d8b8]) by BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::e16c:ea19:c2a6:d8b8%5]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 21:56:40 +0000
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     "jamesspader.linux@gmail.com" <jamesspader.linux@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Saeed Mahameed <saeedm@nvidia.com>, Raed Salem <raeds@nvidia.com>,
        "Huy Nguyen" <huyn@nvidia.com>
Subject: Re: mlx5 HW crypto offload support
Thread-Topic: mlx5 HW crypto offload support
Thread-Index: AQHXA8KaLMEDjU/7Hk+NLT0ZPBAWYKpbVa+A
Date:   Tue, 16 Feb 2021 21:56:40 +0000
Message-ID: <875d20889c9528190cd661202030b6fccc25d120.camel@nvidia.com>
References: <CAKpeocV5osRZL2W+rXJVOQS0vcTCBXNp4aWMsVs9TqjhpBuEBA@mail.gmail.com>
In-Reply-To: <CAKpeocV5osRZL2W+rXJVOQS0vcTCBXNp4aWMsVs9TqjhpBuEBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [24.6.56.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca0d80ab-aa8a-4c46-05ee-08d8d2c5bd6f
x-ms-traffictypediagnostic: BY5PR12MB3747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB374718EE8D522B3D25F86C9CB3879@BY5PR12MB3747.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrqmwZtgUNC1Y0gYJxhpFRthdYmLfO4PIU8DfPRI4rFZV1xiVi4CbwR4uaThTL8hwi4QJaS2Fpru1TJ8z0AxHlLLSHvqgd/VSU/R9pQXWk+Ad68jIlcA2mk99WA2RG2BzNL946CHS1Js26oWKfM0xit9J8rPrbZxO7uoOMyZCxazasl3NXG/HF+4aSGlSwIfON0oPNidPCTleWKBDiCYx6/TOpVTRzfwg0Zb5gHkD1wrYmgpKEsQ7Pla2bf4spCxacBgMapF7TDjpKB3ZD2VLD5Ltxs/KxxOCn0DaFIUmysSc2jJcFtN76xzxihoaZOIwLmOdNDofnDrhvuiYciPa+BM/MfLAgJyFktQTcaVg3ehscUW+vVPFwJ+41ELwh6EBNUIH7lGYw6ZrRy9EWlbCiHATJMDd9/OZbvpUki5H80suAR7KC+Mt9tmMtVYMqxM2OWc0UNtzlZ8yvKs0tkcIenFwjIZomKJXt5QMvlQ+mtpkz1wIUNlXK2UPPn5MFcP/8AdRaSn7HgjUQdHidpLxr0kwq/9QgtEfNrR7s8ggedK+aOKI++uiZorW6BerCRvdKYpZJ8rkP8LjDapoTNjZ21Hi+EXpBWsN+6LKmYbLuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4209.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(91956017)(6512007)(26005)(4744005)(71200400001)(66946007)(66476007)(66556008)(76116006)(2616005)(64756008)(86362001)(66446008)(8676002)(186003)(6506007)(5660300002)(110136005)(107886003)(36756003)(4326008)(478600001)(316002)(966005)(2906002)(83380400001)(54906003)(8936002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UkxXSFdNWjFPR0NmZkt4MzJtSFJ6UUlSZ1RIV3VkbjMwZnJsMTVLakZlTzdq?=
 =?utf-8?B?R05DdTBoMDJtOWJqdW9sTlZIMlJweFZEVjFBK0JYeURGMm1SRFJhMGpsTTFK?=
 =?utf-8?B?dzNoSzJPUW5RdWZGZUgrVHQvOTNCUEJ0QVFxSEpNU2VMT3pBOEFyQ0VPM2ZJ?=
 =?utf-8?B?VXZ1WVJjcXJvZ2RyRXpTSExKZXVIMk1tRFNiSWUzNTVPdGJqYWltRWJacEFJ?=
 =?utf-8?B?Qk8zaGFjMzFaN3lTWk1zU1J5L3o0NnFDcWtoNzBYeUEzL3ZvTXRxd1ZabUtn?=
 =?utf-8?B?V29Kb0JkVjV2ZjN4UWU0YlU4aExORXErc1lmTnFETFA0U0ZXZ0Y4WkhuYlpr?=
 =?utf-8?B?UVR1cGVjUzBZUHgyY0s2SzBvRUd4VFpLVW43TWp4QWVLU3EzWllXbm5ySExv?=
 =?utf-8?B?dGt5aTVpclNwSWU0azRnaER1SFBkbGxJNGpvcEk4YWRUS0NVNVErMUhEZlps?=
 =?utf-8?B?Y05QYnZpKytpcWgvNTk5SE1XNGk4TzhKSEsxRFBnTmwyWHFxTHpCWU5kVkFW?=
 =?utf-8?B?TWttVDFCNkJzandaaStXNEdCMFhYbUl2cy9jM3RNdUs5aHdPbzdLUGs1dWtC?=
 =?utf-8?B?Y2EvcmtoOW1kV2l0bmJ4RCtCV2k4YzBrN0xodHlSNUVmdkJOQWliclpRaTF6?=
 =?utf-8?B?V28wWTJQdEJXSkY5MVBnZStCTkdwUEYrRjNEYjd4QVZsUGVEcnVIL2VFU3ZC?=
 =?utf-8?B?R1hLVEFicjNIMmJSY2pGVFZGVGptUG1Dbi9Ebm04NXpXMkFaME5pcmx4dzVz?=
 =?utf-8?B?M0FLZjRnL1p6b1NvQUZ1TG9ocmdWdGFHQjVvcTB0UWxmQmJHd2dNbHZoeDhr?=
 =?utf-8?B?VDFvN25yeFg5TmhqcTZ1ejY1QkJ4VkJCaXZQZFZadVZEOXVnRVNzTEpvQ1Ry?=
 =?utf-8?B?di9uaktIS3kxUGN5R3RxRUVjaWRWTWZpR3o5eGtvV3pNeFkzd01kN0ZOOW93?=
 =?utf-8?B?NGh1V2JwdlZOQnVUWEIwU0crWUY2dG84VFQ3LzBUVmxidjYyekx6RVVyN2o5?=
 =?utf-8?B?WGJkUkJITGVhZE12Q21ENExzd1ZXWnI0OWNrNHdMQUV0RXRhdTc2b2Y5K0w2?=
 =?utf-8?B?SEtXajE5dUxISVNHTDlQZmZ5SmJYYndzVlh5VjdaNWlPUm9BcStWcmVabysw?=
 =?utf-8?B?ZlQxWkw0clFwTitmbnRKSW42VmVKZTV1VXJUZ3pLTmFOV1VLa1VVSEFBTEZk?=
 =?utf-8?B?RVB6NGxVN3pnWkJzTTBsc1lobW9PZXlwZmVtTTRIK29DbnFxMy94MSt3NXEz?=
 =?utf-8?B?Q0dhYjU2cTZnQWh6bUFOUGlUeEVYdzVqSW13Sm9mM0VvVjZsVmwyZE1BM3pP?=
 =?utf-8?B?OXVBS2s3WmNiVjc2U3BkVlN5M2lsYXJ2VE5NNmNYZGxSdkR6eU9EQTVpTkVa?=
 =?utf-8?B?SFNGckhWcmZLK0FOcUNkUWtpS2JiOXg1UlZrQnZuL21xRjRkUFA0emIxRHZH?=
 =?utf-8?B?OXNuNVdoUG9qNndJUTBzZ0JlK3l3UTJrODVacGVVZFdtc3ZuSDMwR2ZqSVRi?=
 =?utf-8?B?S096V0xJWUtneWxMSjQyTzRFY3VkT05EWkJSUnUvK0RXeGsxQjY0VktlampI?=
 =?utf-8?B?RmVaTHdtOW9kOWRtaG1kajFpaUU3SE5BNkpKdnBKUEdNRU1MTEJJbSsxSzF2?=
 =?utf-8?B?alk1MDNQZEFBdVJ5aFlhbGlkVXpSUzh4ZHowL2pYc09GenBBSjQ2QzNzMExo?=
 =?utf-8?B?OXArVjBSSEo4a1M1K3QvWWpPL20yVFBpZlI4dm56MDR1bmxSazdrcWtaR2Iv?=
 =?utf-8?Q?2Uzp0x/mtLSpwrgpn+OwbcJI6r1rKjv5bXtSnxr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E56C06DD3154C14D8150473501A93B66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4209.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d80ab-aa8a-4c46-05ee-08d8d2c5bd6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 21:56:40.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3l9ulwx/Pf0ykLWe9hR360/zWWEoB2jiNSqBO1jO3IUCXizAIWHnKVclaTyipKnYvM3uwpCy4HFQOjVrDIgYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3747
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613512605; bh=LrhT4Ti7e7uIMbr0p1sUEDl2NXje1AF+NXo1/zJsdKk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:user-agent:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:x-header:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=aoz3loSwOAgTSSidygpHzghVyrhijGaSohTxRcAj/0abP9PCt/3uCNDjCOBwWaAIg
         IPePYC9vCmwHB0ob1yLUISKbRFou//xskpy3aMpRRG6IGbthr9Ryzy+X/WHp8PdNtg
         2+JQmHrs52v5GO47/IluYayRtrVFdFS7fHS8mKhjWOqd+6pMognQg4AxjegWv9qPqO
         9KaKFcNpMRsRT6Vb+cFBjQbknXCXCdo6YbC7grmHxOxd/JiEo9i4jynvijq3Kut+S7
         fJurRk4FBnMsb5e97lPpnmH43yHYr1xP21fCmJq9NVaF8L1gga3JgO/0GC8pa2IUq9
         z7IMxzVyQ0pSA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTE1IGF0IDIzOjE3ICswNTMwLCBKYW1lcyBTcGFkZXIgd3JvdGU6DQo+
IEhpIEFsbCwNCj4gDQo+IERvZXMgSFcgY3J5cHRvIG9mZmxvYWQgc3VwcG9ydCBmb3IgbWx4NSB3
b3JrIHVuZGVyIHZpcnR1YWxpemVkDQo+IGVudmlyb25tZW50Pw0KPiBGb3IgZS5nIHdpdGggUEYg
KFBoeXNpY2FsIEZ1bmN0aW9uKSBkcml2ZXIgYW5kIFZGKFZpcnR1YWwgRnVuY3Rpb24pDQo+IGRy
aXZlci4NCj4gDQo+IElmIHllcywgdGhlbiBob3cgZG9lcyB0aGUgaW5mb3JtYXRpb24gdGhhdCBp
cyByZXF1aXJlZCB0byBjcmVhdGUNCj4gc2VjdXJpdHkgYXNzb2NpYXRpb24gZ2V0IHBhc3NlZCB0
byB0aGUgUEYgZHJpdmVyPw0KPiANCj4gRm9yIGV4YW1wbGUgaW4gcnggZnVsbCBvZmZsb2FkIHRo
ZSBGREIgdGFibGUgbmVlZHMgdG8gbWF0Y2ggdGhlIHNwaS4NCj4gQXMgdGhlIHNwaSBpcyBjcmVh
dGVkIGJ5IHRoZSBWRiBkcml2ZXIsIGhvdyBkb2VzIGl0cyB2YWx1ZSBnZXQNCj4gY29tbXVuaWNh
dGVkIHRvIFBGIGRyaXZlci4uLg0KPiANCg0KSGkgSmFtZXMsIA0KDQpwbGVhc2UgZmluZCB0aGlz
IGd1aWRlIFsxXSBmb3IgYSBzdGVwIGJ5IHN0ZXAgY29uZmlndXJhdGlvbiwgaSBob3BlIGl0DQp3
aWxsIGFuc3dlciB5b3VyIHF1ZXN0aW9ucy4NCg0KdGhlIHNvbHV0aW9uIGlzIG9ubHkgaW4gT0ZF
RCBwYWNrYWdlIHJpZ2h0IG5vdywgSHV5IGFuZCBSYWVkICJDQ2VkIiBhcmUNCndvcmtpbmcgb24g
dGhlIHVwc3RyZWFtIHN1Ym1pc3Npb24uDQoNClRoZSBsaW5rIGJlbG93IGRpc2N1c3NlcyB0aGUg
Y29uZmlndXJhdGlvbiBmb3IgQmx1ZWZpZWxkIHNtYXJ0IGRldmljZSwNCmJ1dCB0aGUgY29uY2Vw
dCBzaG91bGQgYmUgdGhlIHNhbWUgZm9yIE5hdGl2ZSBTUklPVi4NCg0KWzFdDQpodHRwczovL2Nv
bW11bml0eS5tZWxsYW5veC5jb20vcy9hcnRpY2xlL0Nvbm5lY3RYLTZEWC1CbHVlZmllbGQtMi1J
UHNlYy1IVy1GdWxsLU9mZmxvYWQtQ29uZmlndXJhdGlvbi1HdWlkZQ0KDQo=
