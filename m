Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801A133358A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhCJFpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:45:44 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52762 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229712AbhCJFpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:45:34 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A5eOpn023293;
        Tue, 9 Mar 2021 21:45:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Wfw5UZiOf229q2zSAR3yMHWG+luhueeuQQadWnMogtc=;
 b=sc5GLxIS3thmzHFRD7XpKEmNz2QSuRWzHJtB/g15SwBKA6VNOW8TOEM2UXnmjTKdd8+5
 6pCS0IODFq9BGbIg7f8gzQqMD2ZchEPf4xdJNfocQDEiURK4Ci19s+UYG54AtXygQwLc
 SiMFhgjv6FgP/eLg6Sy9cQQojQNJeqSFk9VxjRptr7+e10ml2scOpRQRGRes/2c9tRXx
 Nn/JZ4pyjYMBV0cZc9swqAhL4G9Mc5iTMLrG6Cu7vzp/zwkQqNTtkmPHthVIAZHbeUFC
 OfPw5BxRYwrKQwNftIPcfhL8bq+CJ63P1Xs8W1kjuEDOa4Gn88WDVYxkOd636SDcoKgP gQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3746753kq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 21:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVhc7nNfEWbxDwDBVXFgy16pyJyVuMMLn8b7HOuxoKQirfmk9o9nk5YdHyRe/qDwBLdaiZZerwi6783dEiLW7a7M+oRC8HCkGAg2gdHpMPCkeaD4J+wDu4uERhBPbDffodk/PSu6Yyl5hwWRQAmTexg7qfzf/09I9u9f/u7IsvdhojfjMn28XN/YJ/Et9hk+UwYZdzrmvU4zURoUEMKJvxSbiZVWB9h6xbWX5KHkku6rN1jgbSI00/ksMKd3KoRRvGSSTflB+cQMxUYnqpnrKAjD78+6Ghk0qByhG9oWBTAxBN1eM3if8hMs+HMuFveJ5Vn99byaXYSRXWYWuGAXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfw5UZiOf229q2zSAR3yMHWG+luhueeuQQadWnMogtc=;
 b=ggxS749IhCuFnBW4nc7QndrHbZefBISSZYjuWgpkSZtnofJF6ALeEK8mhduNCEwu7MakKC4pVI04cqDI44kbYDxwVeo1Zl6Sa/Y+67GGORPKGm5GeZdUAMzn4xQY0Hp1ji2IKK8/QuJTeFPe84q2QuN8RYeIwp8c0MU0vjLPhfpIY4VSb4Z32Oel9ViptxQQqQdDcw5TDNaQTMVvp2Kfe0W/1HOAXLJeXylQIdoUCEG3iCTd4YpNPPLQSHlXlEQKUTIJZ7ng17fU/d4YOUqiXdL3pvpjGRALFz5Bb/2pQGWsVa+P2KTfGbNknevMQl3CFcAM7ep6chj+VAb5l5SUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfw5UZiOf229q2zSAR3yMHWG+luhueeuQQadWnMogtc=;
 b=KcojDixMbLlbG8w4WpSFbx5wOx9PjGgDlPT+uT/AL/vI5LCaCmjGPTSTpdlO2GpGpekeHgdUJ1PuNSBjnyF7kJ9stwzH3r233yXGjFaU8KUVdsANpK1RO7cjP/Hr3vSxpb+t9tKQWmtXJW5G2cIGrejT9jDKkV2BZdPuvGXI8Lg=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5126.namprd07.prod.outlook.com (2603:10b6:a03:68::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 10 Mar
 2021 05:45:27 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 05:45:27 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH] usb: gadget: uvc: add bInterval checking for HS mode
Thread-Topic: [PATCH] usb: gadget: uvc: add bInterval checking for HS mode
Thread-Index: AQHXEOxGZWqwmYnLykyxBly6kdc+cap34W8AgAHiinCAAvq9kA==
Date:   Wed, 10 Mar 2021 05:45:27 +0000
Message-ID: <BYAPR07MB5381F90E3E2C4AE585F76520DD919@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210304104515.35933-1-pawell@gli-login.cadence.com>
 <CAL411-p4C4F9K--U=C+Yhu7Uy6GxOxwCHpXtdrXYMObLegFm9Q@mail.gmail.com>
 <BYAPR07MB5381E3BFF03139C805E6EDF5DD939@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB5381E3BFF03139C805E6EDF5DD939@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctY2VlYjdhYmItODE2My0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGNlZWI3YWJkLTgxNjMtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjg4OCIgdD0iMTMyNTk4Mjg3MjQ4NDU2NDMzIiBoPSJPaVZEL0NpZlNqRlJ4SWdMcGgyQXg4QUFtWG89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15063e1e-a062-4438-7a87-08d8e387b526
x-ms-traffictypediagnostic: BYAPR07MB5126:
x-microsoft-antispam-prvs: <BYAPR07MB51267E0F2127F37964FC7B17DD919@BYAPR07MB5126.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypJBmgneYTe/jr4uNlv94ESPVK6A1oOxW30RqCvNAbUEh9bM4xkZUGIVefpDN21YVVV0rXcnMnloDVxtGEy2lRWdGXYrHhogkV8arjHVxstF2ATiseyDEVMe+uyvVd230BOhWvPIJsWpZYdDupiMRL7EKDjnjSrUTilvl14yrPyQeX3AqbTUPX6O1ZwPo5Q+SQrjEtSAmj5ep0j8YnetYK1Zi9coLr3UrtBuOUXs12dEK9D5yeqcLxbSTBMMOEOJqlJ//ID2Igb8nFqircJn84wRbrTQTfPqpkxhIaZcXkUnrjb6oNjqUNcKMOTIzk7sYfvYh0SGNvT/llDQmVnotq2xGBOkCJbP1NrPOtm6VWzqJuxuTKq3DnvfCHhVjs9GMdg+WbsjgEGVzhddhqAIG3SYG+mj853dPRUwYqcCKZDsP9E68JcgSTBz3xWRa6uzrDkoxlVu2GpQKTu5Kg1FBevDQAHthd5ELENnvZEyplpbsqKC+Czxe0ZZt+tUZ0S2tiVqNfyyzJGd6gMx2iMoOlouRNJ5P6RRrL3rCUrirTidVJjlIoW6o4tVGmJkWHX4WXjgpaPZ/15KUljfyQJ4L+PxwGq09z/S6lutFllNjKsIMqhPRUZJursWYUmTSZw0GUB1I4X+SIEO5nsGWeOwJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(36092001)(6506007)(6916009)(66476007)(966005)(8936002)(54906003)(66446008)(8676002)(66946007)(186003)(33656002)(71200400001)(66556008)(86362001)(316002)(9686003)(76116006)(7696005)(5660300002)(2906002)(55016002)(4326008)(64756008)(478600001)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aGlGeGF4SG82QytlNlJJSUQwWTh4NDVKZWxUVXcyWm5iNWZqQUVzeUZXY1Bm?=
 =?utf-8?B?Tld6MFVaV3NLSFFHM1NUQ0xVdnZkTEMyc0t3ZGVCRk1ZMXRLK0dvdFhHR09N?=
 =?utf-8?B?eS96K0NlekV1Q1NCNGlxWUtZRGw5ejVzdHAzNVBCbW5Da1NFS2VoM2VoQ2tG?=
 =?utf-8?B?c3lQYTJJSXBjMDNYZmFQdHhRRjdmdUozRmdJanhzRC9SL2ZBc1VZMVpHdG9r?=
 =?utf-8?B?eHZHdThoOFJtdDRlZjBLUnR4Rit2VXpFUzNzZStLUXB4TE95c2Nrd3ZhMmdH?=
 =?utf-8?B?bWluNzFuQ2JaUDlMVlovYWNaT05USWZXV3NPbG5Ga1pRS21MWno1enl4YXlK?=
 =?utf-8?B?a1NEUnpGYzFHQzNtQXcwVE1ucW5jaEkrMjdWeUZ5K3c3VzFYL2p1UnVsKzR0?=
 =?utf-8?B?NlFRTWZEN2liR3JVTDJnaVlCaHVCb2owcnhyTVpRb09vVkhHOEsyditMdzZM?=
 =?utf-8?B?WlgrdWcwSit4OW5RNlRoQmtjTUZhU2FUWkhSRnlWR0xlNW5hUTdYbE5Jb1BC?=
 =?utf-8?B?T0hSNlRZY1IxZGhPSWw2SFhUL1EzRCs5dE9CeGtCaDZyU0xLMGRSZVd4c0Ns?=
 =?utf-8?B?Q2I1eDBTUXRSL3JUclJ0WEovUnZOSnh4czdvb0Q5WnFBTDJ5akxYaERCd29q?=
 =?utf-8?B?enBycjhONW8wb0ErMGJJMVpqU1hEU0JSaHVUUGJQU2RwaGtHZzIzenF0dHZM?=
 =?utf-8?B?dzAvOHl2bklGdFQ1UGQ4bzlOZmlFeEpib0dVdFpWYWtiWWR4cmxpcmxiOEFP?=
 =?utf-8?B?QjhPeWxZTko1YjdKUlA0cGJTS1V4akVjcld4SGQvMVg0WjJ5UERXOEdEaGd5?=
 =?utf-8?B?VnZVY1VWNk9kS250blJxNjk4ZzFUOXcwVzQ0UmYrYXBrYXEzSjA3QkJBWnVm?=
 =?utf-8?B?bmVINGZMMlNscEdJWHlsbytIcE53aEFvKzdZcnVpMWVGNGNGVkw3R3dlb3Jr?=
 =?utf-8?B?VTBHenFrK2xtV1hWWm9IWlVobHIzTWJ4Zm1heUhsYVVwMjdHQStTZDdBRFoz?=
 =?utf-8?B?ZGxIWWpUbkF1aXFoekx6dW1MVURHZ2MybS95Ynd5MVd1cWliQTZGOHRTeDFk?=
 =?utf-8?B?c0JtOC9kQWtFVkZZL21Gc1RTYS9WQlM1OW14Zkh3RHFGM1QyaERZeWgrUi9G?=
 =?utf-8?B?VVluNnhGSVY3Z3VsOXhpS2RneUM3T1c2bWw0b0dBdENqN05HbXV6NUFDT3pv?=
 =?utf-8?B?b0Y1UWxsYUw2VE9QSGgyWFZjMDErR1A4WHB2K2xISXEweHZFeWljSlhHWEJC?=
 =?utf-8?B?WnpGdmhpQ2RzMHlManNWYlpJa21CVUZQdU9rR1ZtSHlCNzErOG1WcVFPMldw?=
 =?utf-8?B?bzJxN1RMaHlQQUcwOE1hY2tWZVpJK2dyRTc3T1pVTDc1VTUxZTBVblNHQnBw?=
 =?utf-8?B?Q0cxQXJyUnVSVkFWNHNZQlNpVVUxNDVGOGV3S09zeWY3TUZITW5zaVoraUth?=
 =?utf-8?B?YUx5S01FTnZneHZRV0F4bUhEc1FtU1hvb1k3TEVtZlNUaVVhQUZJSkR6cURQ?=
 =?utf-8?B?QkVDRXVwZEExbzNGc0ZMazRXNUZUSzRNSlkyZnQvNUNGeS80R3hXR0tXVENi?=
 =?utf-8?B?eTRVVlVvMUtEWmEyT1hnUjg2c2tqYXI5dDFEZDc5SzhkYTdzUCtqZjVWMlVu?=
 =?utf-8?B?eVFvRzUwK05pVCsvTHZqcmZTRWJSL0I4WkdmeDUwOVFKVUthS3ljSmV1cnIy?=
 =?utf-8?B?U2J3N2xjMTZUZEpLTzcrVFMyR0t0N2trUlo5RmRHOTBiOTNvUWU2VThXeXA4?=
 =?utf-8?Q?jlYN9FoYqM4we1tXZhs9e6WrQ635aKDkf6daPkJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15063e1e-a062-4438-7a87-08d8e387b526
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 05:45:27.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+9EcG1UznC0R6/k2qf+1PgSIIYqFnLPKFabb4/wpFA091Ca12mqJ1iZtDaiqc3hSj026FDJOXjKC6ODtQFKL31cY+vAPCLS58YboTpI/2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_03:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGNoZWNrIHdoZXRoZXIgdGhlIHByb2JsZW0gb2NjdXJzIGluIHRoaXMgZnJhZ21lbnQg
b2YgY29kZToNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2Uv
ZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMjTDI1NjkNCg0KemxwX2J1ZmYgaXMgYWxsb2NhdGVk
IHdpdGgga3phbGxvYy4NCg0KUGF3ZWwNCg0KPj5PbiBGcmksIE1hciA1LCAyMDIxIGF0IDEyOjQw
IEFNIFBhd2VsIExhc3pjemFrIDxtYWlsdG86cGF3ZWxsQGNhZGVuY2UuY29tPiB3cm90ZToNCj4+
RnJvbTogUGF3ZWwgTGFzemN6YWsgPG1haWx0bzpwYXdlbGxAY2FkZW5jZS5jb20+DQo+Pg0KPj5Q
YXRjaCBhZGRzIGV4dHJhIGNoZWNraW5nIGZvciBiSW50ZXJ2YWwgcGFzc2VkIGJ5IGNvbmZpZ2Zz
Lg0KPj5UaGUgNS42LjQgY2hhcHRlciBvZiBVU0IgU3BlY2lmaWNhdGlvbiAocmV2LiAyLjApIHNh
eToNCj4+IkEgaGlnaC1iYW5kd2lkdGggZW5kcG9pbnQgbXVzdCBzcGVjaWZ5IGEgcGVyaW9kIG9m
IDF4MTI1IMK1cw0KPj4oaS5lLiwgYSBiSW50ZXJ2YWwgdmFsdWUgb2YgMSkuIg0KPj4NCj4+VGhl
IGlzc3VlIHdhcyBvYnNlcnZlZCBkdXJpbmcgdGVzdGluZyBVVkMgY2xhc3Mgb24gQ1YuDQo+Pkkg
dHJlYXQgdGhpcyBjaGFuZ2UgYXMgaW1wcm92ZW1lbnQgYmVjYXVzZSB3ZSBjYW4gY29udHJvbA0K
Pj5iSW50ZXJ2YWwgYnkgY29uZmlnZnMuDQo+Pg0KPj5TaWduZWQtb2ZmLWJ5OiBQYXdlbCBMYXN6
Y3phayA8bWFpbHRvOnBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+LS0tDQo+PsKgZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgfCA2ICsrKysrKw0KPj7CoDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykNCj4+DQo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vZl91dmMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jDQo+Pmlu
ZGV4IDQ0YjQzNTJhMjY3Ni4uNWQ2MjcyMGJiOWUxIDEwMDY0NA0KPj4tLS0gYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYw0KPj4rKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vZl91dmMuYw0KPj5AQCAtNjMxLDYgKzYzMSwxMiBAQCB1dmNfZnVuY3Rpb25fYmluZChz
dHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMsIHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+PsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNwdV90b19sZTE2KG1pbihvcHRzLT5zdHJlYW1pbmdfbWF4
cGFja2V0LCAxMDIzVSkpOw0KPj7CoCDCoCDCoCDCoCB1dmNfZnNfc3RyZWFtaW5nX2VwLmJJbnRl
cnZhbCA9IG9wdHMtPnN0cmVhbWluZ19pbnRlcnZhbDsNCj4+DQo+PivCoCDCoCDCoCDCoC8qIEEg
aGlnaC1iYW5kd2lkdGggZW5kcG9pbnQgbXVzdCBzcGVjaWZ5IGEgYkludGVydmFsIHZhbHVlIG9m
IDEgKi8NCj4+K8KgIMKgIMKgIMKgaWYgKG1heF9wYWNrZXRfbXVsdCA+IDEpDQo+PivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHV2Y19oc19zdHJlYW1pbmdfZXAuYkludGVydmFsID0gMTsNCj4+K8Kg
IMKgIMKgIMKgZWxzZQ0KPj4rwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1dmNfaHNfc3RyZWFtaW5n
X2VwLmJJbnRlcnZhbCA9IG9wdHMtPnN0cmVhbWluZ19pbnRlcnZhbDsNCj4+Kw0KPj4NCj4+VGhl
cmUgaXMgYSAidXZjX2hzX3N0cmVhbWluZ19lcC5iSW50ZXJ2YWwgPSBvcHRzLT5zdHJlYW1pbmdf
aW50ZXJ2YWw7IiBhZ2FpbiBhdCBiZWxvdyBjb2RlDQo+PkJlc2lkZXMsIHRoZSBkZWZhdWx0IHZh
bHVlIGlzIDEgZm9ywqBvcHRzLT5zdHJlYW1pbmdfaW50ZXJ2YWwuIFdoYXQgdGhlIHJlYWwgaXNz
dWUgeW91IG9ic2VydmVkDQo+PmF0IENWIHRlc3Q/DQo+Pg0KPg0KPlRoZSBpc3N1ZSBvY2N1cnMg
d2hlbiBJIGludGVudGlvbmFsbHkgc2V0Og0KPiAgICAgICAgZWNobyAzMDcyICA+IGZ1bmN0aW9u
cy8kRlVOQ1RJT04vc3RyZWFtaW5nX21heHBhY2tldA0KPiAgICAgICAgZWNobyA0ID4gZnVuY3Rp
b25zLyRGVU5DVElPTi9zdHJlYW1pbmdfaW50ZXJ2YWwNCj4NCj5UaGVuIGZvciAgQ1YgQ0g5IFRE
IDkuNTogRW5kcG9pbnQgRGVzY3JpcHRvciB0ZXN0IGl0IGdvdDoNCj4iKE11bHQgPSAyKUlsbGVn
YWwgaGlnaCBzcGVlZCBpc29jaHJvbm91cyBlbmRwb2ludCBNYXhQYWNrZXRTaXplIDogMHg0MDAN
Cj4oVVNCOiAxLjIuNzgpIEEgSGlnaCBzcGVlZCBJbnRlcnJ1cHQvSXNvY2hyb25vdXMgZW5kcG9p
bnQgbXVzdCBoYXZlIGEgTWF4UGFja2V0U2l6ZSBiZXR3ZWVuDQo+NjgzIGFuZCAxMDI0IGFuZCBi
SW50ZXJ2YWwgdmFsdWUgb2YgMSB3aGVuIHRoZSBNdWx0IHZhbHVlIGlzIHR3by4iDQo+DQo+Rm9y
IGRlZmF1bHQgdmFsdWUgQ1YgcGFzc2VkLiAgT2YgY291cnNlLCBJIGNhbiBmaXggaXQgYnkgY2hh
bmdpbmcgIHN0cmVhbWluZ19pbnRlcnZhbCwgYnV0IEkgdGhvdWdodCB0aGF0DQo+aXQgY291bGQg
YmUgZ29vZCB0byBoYXZlIHByb3RlY3Rpb24gYWdhaW5zdCB0aGlzIGlzc3VlLg0KPkVzcGVjaWFs
bHkgc2luY2UgVXNiIDIgc3BlY2lmaWNhdGlvbiBzYXkgdGhhdCBiSW50ZXJ2YWwgbXVzdCBiZSAx
IGZvciBoaWdoIGJhbmR3aWR0aCBlbmRwb2ludHMuDQo+DQo+UGF3ZWwNCj4NCj4+UGV0ZXINCj4+
DQo+PsKgIMKgIMKgIMKgIHV2Y19oc19zdHJlYW1pbmdfZXAud01heFBhY2tldFNpemUgPQ0KPj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjcHVfdG9fbGUxNihtYXhfcGFja2V0X3NpemUgfCAoKG1h
eF9wYWNrZXRfbXVsdCAtIDEpIDw8IDExKSk7DQo+PsKgIMKgIMKgIMKgIHV2Y19oc19zdHJlYW1p
bmdfZXAuYkludGVydmFsID0gb3B0cy0+c3RyZWFtaW5nX2ludGVydmFsOw0KPj4tLQ0KPj4yLjI1
LjENCg==
