Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF43C20F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGIIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:44:59 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25166 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhGIIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625820135; x=1657356135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Pu12NnU9dyrHrUa4BNan8X43T/gIDN62MmwKI86gRc=;
  b=IqAK5pZtFiddCcerSLokPOte6Dt91naO93TG5KjD9E5c5uHOaef4rzho
   7XdX4RSBIgR47nnHAhPGh8yyi8CK5nCjfTtYjLJdhXV/18H3nU728xVXy
   oHAbBTEwxg7d9Se0ZwWxx1kEWfeQHo4xeftPWKOiYT5kQEtSsiuPTA5J7
   dJotyGIQofdd37f+VBwupJ1cKw8aujjcT5OPtY3WMTgdZnx5EPlyQ0JyA
   9xfdkWF4jSiytXEup8PVyxqYGIQc+19PDAq5SSXbLPlB+ABCUSf9IQobb
   ASDr9417PkelGpq1O7n5c0MBQFLVLkJ48gimFNME175Bl63ymC8DcQ004
   Q==;
IronPort-SDR: mGufUcuR+8/YdHqZL5N35NDKnn20SIttYAbRshDVUId9E5Qc3GfmulYC0pbXVbOaE8X0r8kA/o
 liQ3ybn4b8UkTR5AHnHCPqGzY+T91Ey+HEeB8hPdqfoJ1mPvfe9p35hUR8hJ2pelEMv6FHhqjj
 CifQGevuAggYsP63KE7cqAdVb17zuXTiKZa1lH7162XGSQvQX3L4my8OAUVTq1FqJiEZ/hTkVf
 2aleD/uuhnzmq8Ka0dj/HDNeKffeG/EQHDPapLqrmu10CFwJ4tmeqwQ4ZWJvd3fgb3jp4lxrDx
 pis=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="124013736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 01:42:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 01:42:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 9 Jul 2021 01:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbkZETa9w/wuPxDtAlpQA3tyxjACrzPfpN+kyO1fGrQYLh2d9EZ4kflHUMyUUe51wBhoxnZz2lFCIXyR3nZaeTqJTslNyfjwPcnUIx399Bg4PvjpDGnaX4XTSqpQmwWPiYbvHqmjojTn8XF2M51swKT7/8j/UYQOTypxoGPa6PGliuq6LUasAdq5KU838Up2zo9KoJrwfCHpi+g5kBCursrSHkSYsoSjh3Xi77lNL8Pd0l3BhryMiNAS0Pb0inZNoplQnHp9480nxpnc+0joatbGjPM7G/7JL0xOwT5z2ms4OouhkCsKOrahw37xj9JOjxtG1xbnPIZ1tse3eMQWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pu12NnU9dyrHrUa4BNan8X43T/gIDN62MmwKI86gRc=;
 b=WL2hGD1bKmlULfsAqV9HPxPTNeOKmRW81pbNcP+5KTFW2f9r33dyTuj8E3ZzZ6W+KCxiyRg2Z9BQw32pK8QL3AOhHYJ21vGut5sWq2+6JUyq75CZkm3b5mv7A1jgeZij/0EdUCfoqbrZwUq0YR74GhXE+USq7yscN7UbHfP7yRv4dFvDHcKbcys8fRGGnfHJ0tAzkJx3d7bTatpFNhJ91A//f5krsX978qxQyL35bbpre7IBmH+eN5+3JaRV2tmyGSDKRxKfDvLeeTMx4Kt4Wg76DIN+xHrbOtg4IcqfmmkaYOr5PCttD/Y/ZjU1r7loOPrXV7wM5+Ozr6hqILhL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pu12NnU9dyrHrUa4BNan8X43T/gIDN62MmwKI86gRc=;
 b=aoeOR/ggpeXKgVIlQlBn5Lw0KJZfb6wrnbg8xYjEihxqTgi1JmjQx2M/UaJ5cPnRnzH+rVkcFripWSB65EnipblDc6RksrOG9qv//23gImfJVQQcpxf/gfLzZV2K6PbywvQLrHt4OB43gKQ8Jz4RKvX+yqXT/RF+X1+YpZD2B/g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 08:42:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::7476:4bab:7cdb:8957]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::7476:4bab:7cdb:8957%5]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:42:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <atish.patra@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <Daire.McNamara@microchip.com>
CC:     <bin.meng@windriver.com>
Subject: Re: [PATCH 1/2] riscv: dts: microchip: Drop "clock-frequency"
 property of cpu nodes
Thread-Topic: [PATCH 1/2] riscv: dts: microchip: Drop "clock-frequency"
 property of cpu nodes
Thread-Index: AQHXYnVF06x5/3pZjk+WP/cBJfg+2as5OF8AgAE/UwA=
Date:   Fri, 9 Jul 2021 08:42:10 +0000
Message-ID: <48f0a6c0-13af-e2bd-6849-e84448f71b51@microchip.com>
References: <20210616060251.398444-1-bmeng.cn@gmail.com>
 <CAEUhbmXQt0pnqvzCGwGU38_U0qRZRmgGA4qgaFT_HevbSZRDBg@mail.gmail.com>
In-Reply-To: <CAEUhbmXQt0pnqvzCGwGU38_U0qRZRmgGA4qgaFT_HevbSZRDBg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c86cc6d-eb8f-465d-5d0f-08d942b57154
x-ms-traffictypediagnostic: MW3PR11MB4697:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46971340271458EEA8D60BA698189@MW3PR11MB4697.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4EashJnlxW3ehI8ALZ9fhjvJnU/pLZvjWzRZNFF/j2Ji3rT3iWB5Q2q5j2kcLzp02Uu/a5jlNu/M0F+nzUB0v/K5AElX5i3UPW/pkw4NNzag/WsACpH5Oikl63mCtTQwdP5TEHpXkRlcnHG0aNN0UNXMin1B15l7IsdMEOy2sUxfVYpU2ZAwP2glqYjBe2PxCpNq0xlmOr1GpUhml89YHx0ZqAYDYtheJB0RxewIv3xjmtggoniguPoYA3mAiZaFtWZKEnBdUHeAs0unSql76rDselAPy9/eK0DopRPNw5f0LLe9GHk+PGiEpv755ZdFI4yN8sOf6MXCeQpYhS16mHxpGAY7rvWdRkfIiIIS99qtdJXlZ2ZtNLHYvi8aHGI9nORlfADIYTcmgQiTBhjlcpbalkFEsuR75WjUurZBdIwnbvdwGWvmdnjaHEQUxigQoNRHitn1XSlrTv+wlrluu/AQq4Lz4XmDU8lizdq5H4w57CI8OvLywKdG+Wsf9ooFIcXUeRe9VgwtK97/G5cPaSs4DO6iJqRq9Mz89in6xEkqgQDA6HVnBGm70UWQnTV6mx9cYUBz9tFHiFyKvT4D7mHXw6lFWg3clLtJLevH+eN1H0+uEe7bRH+n+UHLl0J7oMuLLNZ+e3+//k/psEXamCuftTCa+b3iYc0NDhySH5VGy+ts5uzBNRMP8WcMjwP2Qfpw6UqTyZ+NJb9R79sJTJ2cKRsIL8G/Gtfa4dL+3oOJ0xjobS0qVPmXzpHIm9z0hCWIbimAXOPkwyDdE5GZQClR2nJzw/lb/Ccp12XGBSEfQp5YdE0xS6047q+mXWnQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(91956017)(66446008)(31696002)(4326008)(2906002)(6506007)(66946007)(64756008)(5660300002)(110136005)(8676002)(6512007)(8936002)(53546011)(66476007)(76116006)(66556008)(316002)(2616005)(86362001)(4744005)(83380400001)(6636002)(26005)(71200400001)(966005)(478600001)(6486002)(122000001)(38100700002)(186003)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWIzaTliYzNaQitTdzNxbDMwQUJ1V2IrWGIxMnhlQnFMbXZkUS9Vb21LeWpi?=
 =?utf-8?B?SmNqWkNVQ2x0Q29xbFBJanExRFlsWExScW5ZL0FuZHQ0RUR0UW1qcUxDWHVT?=
 =?utf-8?B?MWMrWWo0MHM3bzZWNm1ueTd3M2xKR2h1UTZjakMrMU5NSUdYM2kxZE5zcXRz?=
 =?utf-8?B?YmlpNmUvQm96dkFERDV3VlEwTGVBaGZjTUtRZkxvYzNEaEpKREh1OXphVWJP?=
 =?utf-8?B?WGZ3aVV0T252b1J2Q3VEVEU5b3V0VFFDbXdVZVBXME95VjNPNWozc1d4TkdN?=
 =?utf-8?B?T1pqdlkyOGtIVDhoOFlwZnZIUlJuRjZXYlFKcVRCYXNSTTBPd3RmMENjeTU2?=
 =?utf-8?B?amdGV2hiSlU2WkhoalJLaWMwbXBJUnhqemRNRmI3eENhc2JRMENJZXcwblVa?=
 =?utf-8?B?eEk2YmIzMFNqZVh3Q1pibzdaTkpqSG1KcVdzZWZZdzE0WUIvNFNNMnZGM1du?=
 =?utf-8?B?QzVwN1NnTGkyb1N3OWdzdEdER0puZmdVSHF3bVNpd0RNK3dpTE1mYWFTTTRm?=
 =?utf-8?B?VWVDRDQzU1ZEdW81cVpIZ2s1ajVWOHRlVGx4WVpNOUg2b2ZJeEVpL1RqME52?=
 =?utf-8?B?MkN2VndTNTB1RmtJV2dLR2pZd0luTGRnb1JVNzNWQ3JZUW9vRkhCZDFNWndo?=
 =?utf-8?B?cGQyYXBIRzl2WkdiaThLRzRNWTJmZTBaanlMaitIR0VXdGlhUVQydnlxcGpG?=
 =?utf-8?B?ajc3V1lCdEltVVFiVFNSTzA0ekY2Q3lCOURhSFVEVXpIWXhKYUMrTnZWdzVt?=
 =?utf-8?B?MlF1NEhiOVd4TmRRTm5rYlBINmduZ3lYWG1BaG9jM3VSSnMybHRtb1N5YnJq?=
 =?utf-8?B?MVJRV2JWT3RyWEIrVHZueFVYMEhIYURlZWlaVm96bHpTODBMQmhmblhnK0cz?=
 =?utf-8?B?enNJMm9BWUZnOFM5TUJKbGYrTVJEZllxMGU4WGtNS3A1V0RHaS9TMWlUZXE5?=
 =?utf-8?B?MFZCRXZJWEtoZkZaZUI0YUVBdGR4YWRaRFBkcVV3Q0JqZitkdHNuajdzNG9o?=
 =?utf-8?B?WG8yai9MZ1h3UU85M083b1FzK2VWd0J4ZFlBSGJWUi84VkNSM2ZxZDVpUm9K?=
 =?utf-8?B?cWJRNllFRTZ2UVdGVHNxSEw2Sk84dlVTNWt1WlRDS0FuWXpRQ2dQYVFRYUZr?=
 =?utf-8?B?VDRTOGtxVkdlNnJKYjN0UG5NVVBaeCtYREY5LzhFRVJHSXo2MHY5R1R4TFI2?=
 =?utf-8?B?RWFnczk2bVN3UFRTbE82ZnU2MlhpN0hjSGVqNGd6VGVDTFE2eWVwdFR3bU9p?=
 =?utf-8?B?Vmh5UzdZTnMzU1NuUXJocVgrRVRIVjhqSTdZS2hSazVUU0tBZ200TGRzb2x2?=
 =?utf-8?B?N0lEOG4wUUxMbjhQNC82U2htUDlkdWUxaUZDeFZyQ1d0UzhhM0VJRWFab3hr?=
 =?utf-8?B?NXRqd3pOUmJKKzNLSU53azBLSmlzUDdiNmhVRUN4d0dmK1c3TWZWK2hyOGhq?=
 =?utf-8?B?M2dLZDc1S25tcmFPTTU5MkUwenhUaktMK1FVZk5sa0xDc1VPUWNUamlTcGtR?=
 =?utf-8?B?UDB5dUQ3NkdmNVdpWVRpT05kTzNSY01HZ1VuYkljS2Q2eEVIcGdsTFlJdllF?=
 =?utf-8?B?cWhJQ3Mxay9ORWF5Sm5yVG1Sc2wrdWVyb2djWWNEdDVXMUUrS002bDZISWJM?=
 =?utf-8?B?dFFpSjNVVFFTTGZoV08rYllhTWFicThnSTR3YnJrc1RBRUdZQ2RhSWticDgz?=
 =?utf-8?B?YU5ZUG5JU2hGOXNsVmxCMGUyVm5zbXVSTmpZb3NvNnhNWHoxWHd2MFdDdkF5?=
 =?utf-8?Q?u5u4u4amISSvUlEfzc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18C7ECB61211344085B2911E066A277B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c86cc6d-eb8f-465d-5d0f-08d942b57154
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:42:10.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kK5Tk9DlRhCvcaptueoJ6hxX/FcgqsTYbr++o/xBJ/1mexmDMJ8jUEsfDMCJLZjw8R991Q2o8JOOsTkLkVQ7IS3n149FxRmRF0+dWwsxVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDcvMjAyMSAxNDozOSwgQmluIE1lbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBXZWQsIEp1biAxNiwgMjAyMSBhdCAyOjAyIFBNIEJp
biBNZW5nIDxibWVuZy5jbkBnbWFpbC5jb20+IHdyb3RlOg0KPj4gRnJvbTogQmluIE1lbmcgPGJp
bi5tZW5nQHdpbmRyaXZlci5jb20+DQo+Pg0KPj4gVGhlICJjbG9jay1mcmVxdWVuY3kiIHByb3Bl
cnR5IG9mIGNwdSBub2RlcyBpc24ndCByZXF1aXJlZC4gRHJvcCBpdC4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVyLmNvbT4NCj4+IC0tLQ0KPj4NCj4+
ICAgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMuZHRzaSB8IDUg
LS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQo+Pg0KPiBQaW5nPw0K
RGFpcmUgY2FuIHlvdSBoYXZlIGEgbG9vayBhdCB0aGlzIGFuZCB0aGUgb3RoZXIgaGFydC9jbG9j
ayByZWxhdGVkIGNoYW5nZT8NCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1yaXNjdg0KDQoNCg==
