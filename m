Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D039CE69
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 05:32:05 -0400
Received: from esa10.sap.c3s2.iphmx.com ([68.232.156.179]:65140 "EHLO
        esa10.sap.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 05:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sap.com; i=@sap.com; q=dns/txt; s=it-20200722;
  t=1622971815; x=1654507815;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4rS88nQyKsUFVjQz3ASVMWmYl8wK7lp7wSjTX5X+COg=;
  b=HVrHgtlMswNl5F/vxW4cqujkQ758c8VgIsnsCuPuAMjWs3u9aWIiZxab
   xITge4VRRUUZORn0WIGB4m+D6UzpdMUaGXixDEtWDKW/qT62b4ybn8rUX
   OgUPd8r7BageservvUpWZExwEEPyApqOux+jB2ZcOA/DooO6XMcZlNzlX
   PeIG8FShYYRHKNLiIHOo/Eg+5CiVCSWmUxD+vHVqFD3dzveXD6c1u5Hyj
   DwcTTbPFIX4dBpcbfvGYIHY3flxduAKsncXF3azOUPXqE+Y+ukDuNWxPg
   A3/yYkJmvmGD5Rwxcc2z2rIZSrDgpEn2Gt1eLa/7WXdRiruJm9iHAtPZK
   A==;
IronPort-SDR: F7c+ECQbm/VHw74CglZ2Jl7i8FGeHV3wTeGdWZNj9lYPOChiajqXJ6ptJAV4sgrCc0jsSRwI/H
 Rva9Vmmsm3UTiP+lkJ/JAqUr8ybLRT5KfDtliTImCzhO53SHFjXgGKnXSNmPR8k5wBpvWLDLoP
 F6GFm9uOmYDp4T2EOdRVye9zR78TEEjHiJswkq1i5aYxEAtCbJ8LcQODJNybIeDUBwbc6jIxIK
 gIkdMdP+DwV5aVpZmBlBN5/obEF/bUDKhLcHtore+X6rx7B5UsOkamGtctamJ6CkDPaj5rfWzi
 jGskN3EiGfRWjJqPvFCd7Ikf
X-Amp-Result: SKIPPED(no attachment in message)
Received: from smtpgw03.mail.net.sap (HELO smtpgw.sap-ag.de) ([155.56.66.98])
  by esa10.sap.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 06 Jun 2021 11:30:14 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.176)
 by smtpgw03.mail.net.sap (155.56.66.98) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sun, 6 Jun 2021 11:30:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjBZ45+K0jjtIQ0ArSFSbIcguH2CnWfoE7MNG/+7jvr73MNrG5TeTj5JItF12lHKuN/MJWTZ7ArEhTIDNi5JKvNt/vzOtry7xfWZufsbdD0dy8E3leT1wJPYd6/NvYOB9eEf7OrNwLSJAWk4yGBH/WeM5nnEr8Z1EZvrEffeyJXJIhxy/Rf9/Bcdc5cHIn/ueFXIIno3o6loOGFBpmGMzH5EfTV26bC1Q+3bpBYX1ohYrgJyOVv26Dk/cMqvyYek8MLyPqMyLZaoWGGAr852DPmK7P81/fIDFM7t69906Z4dTJegHjVo4moBQZAToVoXdVWi00XZI+M+DVNS88NPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rS88nQyKsUFVjQz3ASVMWmYl8wK7lp7wSjTX5X+COg=;
 b=hk8Pb8TnbRjDEJ4taGEEyUUwst7IeTtbMB+W44YayEi5zfim9ygfuazc4tviRYgDs0bldYhpE4u5H3qrjIiOAH8ftmGMObz2eJRWoYMlg0f7Wv2jkDsRZnqtot/DimedJlfZtdeyQoAAEvJJaFF59acGfWMbBWapXww9cf4i5/gR9nGQ0LsSREB8tK1PVmEenHksL8NJwt3TVSVay1lxfcT6ECbYUy0aqhHrCLbWJfd/Qiw0ymhynFk4ij5SdPIHxH6i3PJ1LZIxOOAj8+8f/xMp8e8tdt+6OAgbAmJpCMOn8D3l2byt/nsU9ZIB77YvFXWccGJS4nGs/RK9gZQ8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.onmicrosoft.com;
 s=selector2-sap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rS88nQyKsUFVjQz3ASVMWmYl8wK7lp7wSjTX5X+COg=;
 b=SMAvlRThyIpQbNMd97xk6w+KFfn1h2WWmqEAuVIf/0vO8ZKJudyyzBoodmfENKfjeK3rOmpTW9lCNBENn9ab1k9bYVoU32C6OevzClkAn/rBnTKhcoJdG4K0I5sI3OPm8w4OduWwG020f5AstJTG7YRCC+cdrXzzTq0PFnRRF8w=
Received: from AM0PR02MB5668.eurprd02.prod.outlook.com (2603:10a6:208:159::21)
 by AM9PR02MB6817.eurprd02.prod.outlook.com (2603:10a6:20b:2c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sun, 6 Jun
 2021 09:30:11 +0000
Received: from AM0PR02MB5668.eurprd02.prod.outlook.com
 ([fe80::ecd4:f127:8555:8c4b]) by AM0PR02MB5668.eurprd02.prod.outlook.com
 ([fe80::ecd4:f127:8555:8c4b%7]) with mapi id 15.20.4195.029; Sun, 6 Jun 2021
 09:30:11 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     SAP vSMP Linux Maintainer <linux.vsmp@sap.com>
Subject: [PATCH 2/2 v2] MAINTAINERS: add entry for vsmp_64.
Thread-Topic: [PATCH 2/2 v2] MAINTAINERS: add entry for vsmp_64.
Thread-Index: AddatmxfSmiD9mikRfKGBXKQkGCvXw==
Date:   Sun, 6 Jun 2021 09:30:11 +0000
Message-ID: <AM0PR02MB5668CDEAF71950F84BAF8DE481399@AM0PR02MB5668.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.231.4.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8e6bc29-0af1-4ba9-f8ea-08d928cdaedb
x-ms-traffictypediagnostic: AM9PR02MB6817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR02MB6817A78058DEED7BA3BB5E2081399@AM9PR02MB6817.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+nVSkZdc6wVZJ/uEam+1kUdFTmO7r19MafOzB1wgLHqdjHIjaxvu+76iauHWi/H7yPSbLBddGHUinoQlBvVvBkZmRRFjSgzrgJ1N9XtDj8GAHaX9jyqqEoTdx3fr0MqB6hXVShRv5efbKqAXGPosZaREF8bC+dRVi6R0tD/F1ElOAHUxHP+JXgQR1MaM43inGWirFGRqa9Yu/Ii++5HkOqt8YoEf3j/JJx48bsDGCWrfBQ/WhLMGA9yMk6PD6W8yqr3/HQi3Xhvm6IB8hfasyPAn1jYAjHY0w91uEmY1ngZ0QPkHxn8KwdK+fAmKOXf8XAhxfG/funSqF/TyFZIqU5TyVJBZbSrlYHGSO0p7i/VqtaCJuP0JwV0k1lhJmEr9DiZ0KVx1CXy1GBnNE6HCsvQbFEwQtIstBQ57So//hMGs7adP78XZD4eWpHpvNVJCCf9/09WAF7ghKGAyCSKs68hSRccnRk+xKnFGwPHgt0d+NYgIxxxc/cZGRnErEt9U1msFmcfzCbJckuH1IeO99471w+EeqNSL1cvFZAxgna3Q1UkPxoPrrDxC/4LjVQUHK2r/xte3L5OPRh+oMiZttobnslu18S8D7Gw3yXZkjM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5668.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(26005)(6916009)(4326008)(6506007)(38100700002)(2906002)(186003)(9686003)(86362001)(8676002)(7696005)(66446008)(66476007)(66946007)(5660300002)(71200400001)(33656002)(66556008)(478600001)(76116006)(8936002)(4744005)(316002)(55016002)(122000001)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmlOZzVCd2RYU1Vic1B0YUU5Sms0aExUODNaTnpOZXRTNEZXQnlNNmd5bU5K?=
 =?utf-8?B?QktBTG94V0N1eit6RTZxRGtYQlgvVEJncHkvR3hjelBhOVg0Z3JXWnhaNFFm?=
 =?utf-8?B?MXhGNDhqVitSdmtZVFc3RDYwRC9LSWcxTGxNVzhZK1cvalc1bmc0SE5OOU1n?=
 =?utf-8?B?T0ZUVHY4NzJHRXNIM0ZMcmRYdDJiTGFESTk4VVlOVEVrWjU0UmQvemxMZ3JO?=
 =?utf-8?B?WnVjNmVWRWZ4aExNcDRnbUp3QUN2K2dwN3YwU0lmRVdyeklFK1RWZWZkMXVQ?=
 =?utf-8?B?SFVRQjVMUnVUdjVndWMwM0MwckQzVjJqZE1RdVg4NjVJS3gxemV1dnNnUGpD?=
 =?utf-8?B?bDQxUDdpVzQwcHRqamIrc2ZCK2dxejdlaUtoN1ZiMjBNVks4dVphOTBHVkp0?=
 =?utf-8?B?aUl2cXRUSGtoNCtaaEZ4UnBLcm1nQ1ZmN2MrNy9GU2kySFl2SDh3UG16blFT?=
 =?utf-8?B?Tnh6cXI1TUNlT3hRK0wrM0JLaUZObDFWQytHWS9CL0lvSVJkL0NOdlJzM2pW?=
 =?utf-8?B?S3Z2SEVCU21ZTTRtY1k2MEtHbVVNTHoyWTZXbXlKQThmeFViSHliUlRySlhy?=
 =?utf-8?B?NVU5M2xlRDFVNFVBYlV3STNBSVBDQnEwMERldmN3ZXJoRCtDMnJ0Y1hiUmc0?=
 =?utf-8?B?cGt6YklBSldKVkQxeUxYQk9OdVA0WjZucnc5SEFYVGNXeVR2eEVYY2RrNE0z?=
 =?utf-8?B?dThudXczbFYxUW51N2YwYnFVN1VFZEVmTTZUZE5xazFHbDFJdHNPS3YzMmQ0?=
 =?utf-8?B?UUpWZkhGTEFlOUpUTkRSM3lwcEc2NDZqNWhJYlE3djJWUlZZWGM4ODNheDR1?=
 =?utf-8?B?eVh4Y2VGdHdNeEIyR21ib1pDRDg0WFFUMFJNMmJVWnZPNUJON2FvZmhFbW0v?=
 =?utf-8?B?SWhyS3N1SHNRMUNZcHU4eXJSaDJkMGZTb1NMcVZudGhTNnVySVBjeXRXWkNY?=
 =?utf-8?B?TGdMUUlad01WVkZ4ZlFkaFBya21sZEloaHZqMnFhN3BKYUlyZUxweWY1aGNO?=
 =?utf-8?B?Nm8rZXcwM0w1UkdkZ0E3ZW1Ob0NsY3p1a1hIL2htc3kvYm1TMFFrUDdldzN5?=
 =?utf-8?B?cGhFRHRNUUZEcHduNW04YkFqQkQ3TjgxRmttczFlN3NXUUUxU3hKSXJXZm5U?=
 =?utf-8?B?N1RUcjR2aFFBSDFieXdTVWRLcTVBV2Jrd0V3OHlhakVTSDE4VitvZzl1bWpQ?=
 =?utf-8?B?emhQbWgzZU5PR3VFK0xOSjNDSnhveGErU0Y1czZSVk5ZNnk1RWJVaXhUeFRR?=
 =?utf-8?B?OWdPNnlLZW5CTENuUURCeUFuQTB2OExHR2g1R3pQeXlCbmYyaGVhcHcxTGtS?=
 =?utf-8?B?ZFhNQ0FQVHRUSGgyRDJTbHd4aVR6bzlxaGFscFJ2QmsyRjE2WjJ6d0VBTVdE?=
 =?utf-8?B?K2ovZXo5ZEZsbmt4QkFqY2poS2ZLck4vZEFMVUZKb2xyMGZQRTU5cm9qR251?=
 =?utf-8?B?TE4vNkQ1Mkc5YVRjTnEwYTRMVUlTTzIxMkZnaHIyQkFjZ3FTRFBYdkJPaWlt?=
 =?utf-8?B?ZktJTDNoMW9pdVd1K2JYQkl1SWVNdHJ0UjFDVURSSzNaM0RXVlU2aWRWYWdI?=
 =?utf-8?B?NElZQkhZeU0xR0g2RTI1WnNGVEYxc1RBOXhQemZJcGZBcG1ubmp1cEFBNktE?=
 =?utf-8?B?cFhpNjU4L2pvMnlHVVAvdUdDNDcyTXpTTEo0RHZxYkNWM0V6ampoWDFRRnFN?=
 =?utf-8?B?OGxqcTdjeDVHUW9rb2xkaDZlR2lHM1MyK0VRTHYvejNjb0RSTENBb1E4ZGVs?=
 =?utf-8?Q?DHwoqnzo0e7qSHgtCJX6/WOJWWqyLSCgbd6Z7ld?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5668.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e6bc29-0af1-4ba9-f8ea-08d928cdaedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2021 09:30:11.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cwoi/Gd6fDPJ5AQcOt1EUnNmdU0/jmkj0XI70syMxdDtmnMHc7xt+d/uE4VnlqBiJpJY/ebx6gl1SggchahvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIG1pc3NpbmcgZW50cnkgZm9yIHZzbXBfNjQuYw0KDQpTaWduZWQtb2ZmLWJ5OiBFaWFsIEN6
ZXJ3YWNraSA8ZWlhbC5jemVyd2Fja2lAc2FwLmNvbT4NCi0tLQ0KIE1BSU5UQUlORVJTIHwgNiAr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCnYxIC0+IHYyOg0KCWZp
eCBzZWNvbmQgbWFpbnRhaW5lciBsaXN0IGVtYWlsIGFkZHJlc3MNCg0KZGlmZiAtLWdpdCBhL01B
SU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCmluZGV4IDk0ODcwNjE3NGZhZS4uMjliYzFlYjdmNjdk
IDEwMDY0NA0KLS0tIGEvTUFJTlRBSU5FUlMNCisrKyBiL01BSU5UQUlORVJTDQpAQCAtMTk1ODcs
NiArMTk1ODcsMTIgQEAgRjogICAgIERvY3VtZW50YXRpb24vY29yZS1hcGkvcHJpbnRrLWZvcm1h
dHMucnN0DQogRjogICAgIGxpYi90ZXN0X3ByaW50Zi5jDQogRjogICAgIGxpYi92c3ByaW50Zi5j
DQoNCitWU01QDQorTTogICAgIEVpYWwgQ3plcndhY2tpIDxlaWFsLmN6ZXJ3YWNraUBzYXAuY29t
Pg0KK006ICAgICBMaW51eC52c21wQHNhcC5jb20NCitTOiAgICAgTWFpbnRhaW5lZA0KK0Y6ICAg
ICBhcmNoL3g4Ni9rZXJuZWwvdnNtcF82NC5jDQorDQogVlQxMjExIEhBUkRXQVJFIE1PTklUT1Ig
RFJJVkVSDQogTTogICAgIEp1ZXJnIEhhZWZsaWdlciA8anVlcmdoQGdtYWlsLmNvbT4NCiBMOiAg
ICAgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnDQotLQ0KMi4zMS4xDQo=
