Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07BB330964
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhCHI2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:28:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11186 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231406AbhCHI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:28:16 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1288K0Gq010686;
        Mon, 8 Mar 2021 00:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=FFls1fe9SPi8foe7H22hoGjqZwaxXzNan+HX/REV2Cg=;
 b=BGzVPX6T8WUOzsCG0Z2VHg0jW4+Ty+aiLMkNMzWUW0AanpOH8GQ58EHLTGLQBmSJ2iFb
 gx3eCHed5BLFCWizO140nnWK84uaM0jxwQ6qqUncDLZRVqUvCiL5oJEziUAWw85tXpf6
 rfrqfSsVwE5fjaYgFG2PuAyR6n5NYWjzmtZvlfDGGgo4sjwWRv66jO7XajY0Vi0b1qhW
 A/VHsgWxDCU+SBPwkLeYeZtTTck6JubnE60cmRDGyf6GJ3wpjPq/0li3wdMOUtgG/B6U
 tg6tmYkQapPJn7LtqHnkvekF/FcQzP1wDNQzF1Zf6XW5TWgtGZElciqy2YPGPqHZzQLN 4A== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0b-0014ca01.pphosted.com with ESMTP id 374674vju9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 00:28:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y19Htl7nCOm10/NVdZPOnW6NmKyc/xOzozUhgXKnWmTqkGivaDOOX0bf26r0ewtrgK0AZsBGdEBXwygKqd1lieE1mUD/L7ZzfSvu5rftcu893rZOvC2GBfs2SIKDJ//twDFFFegcoldxipUDAWFotAL1mal7LP1Azbk39xciVmMJ4gi7H0V046h1mM1UPh212xwR4f3gzxWJ//2CpbS9jYTDiu9hof+912yVfDR2XDzI1XlTyBDClxrookyJ5mESlqKI2nTobsks+1PlTzUkG/oAiSuSHPzekBPywjDWgPh3eR8iBssC3WJGkhzJMmG7D92+eysWHaVPJHw1Vh7RuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFls1fe9SPi8foe7H22hoGjqZwaxXzNan+HX/REV2Cg=;
 b=VkbdKbzA6oMO39ru8nCBGFICvetdOTxR81uHWsXUZpH7Pwd0ydEROHkTO9nFlOwzZ3+J0LL4tqWl5vvZIb6H14dpwSLkutk2eNcGjYoL1HMTerXAu076cJbMV9BFAdMfwzloq8KKVR3md091utRymGzJanoDHpY6fD7SjvQQNbKeq0Db+p8sKdV7Zk8Y6LcOdmGDhiFXTYmz8237PjAZy5CNTo+515KM/K3q7aXv+KAO66jDnXUqXZLR6nMr70X/XVJWovxbhkBptWYLCJi2vTf01NCWqQhtqm1pWYTLETemgBB2cAM1GbgUN2n8QFFg8MzuAFw/PWRcOCfA8tPBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFls1fe9SPi8foe7H22hoGjqZwaxXzNan+HX/REV2Cg=;
 b=kNLP80PdNwejU9zFrvNCGiR88mj8FpRlm8fVG1rWfRWw/+lB7b1fZaqy5SjPSJoKeB44EhsIYq9O4HK6fqLSOE2GL4xP62JmO/w17AOh0J129onFAJ6ewrycNZwUkf6nCvAm1aqhgrSJBXVdlaiL8anI3XX0u0sFuT3NGDEIc/w=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5304.namprd07.prod.outlook.com (2603:10b6:a03:6c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 08:28:08 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 08:28:08 +0000
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
Thread-Index: AQHXEOxGZWqwmYnLykyxBly6kdc+cap34W8AgAHiinA=
Date:   Mon, 8 Mar 2021 08:28:08 +0000
Message-ID: <BYAPR07MB5381E3BFF03139C805E6EDF5DD939@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210304104515.35933-1-pawell@gli-login.cadence.com>
 <CAL411-p4C4F9K--U=C+Yhu7Uy6GxOxwCHpXtdrXYMObLegFm9Q@mail.gmail.com>
In-Reply-To: <CAL411-p4C4F9K--U=C+Yhu7Uy6GxOxwCHpXtdrXYMObLegFm9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzM3ZTFmMDQtN2ZlOC0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDMzN2UxZjA1LTdmZTgtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjYzNSIgdD0iMTMyNTk2NjU2ODQ4NDg0NDYxIiBoPSJ6dkcyVFRpVHNvUTM3dU5xSGErVFo0QnNrVlU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 093938b3-8c98-45b4-e61c-08d8e20c1a54
x-ms-traffictypediagnostic: BYAPR07MB5304:
x-microsoft-antispam-prvs: <BYAPR07MB530482C7BCA4F32A26F23247DD939@BYAPR07MB5304.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hu+rAXLQYAuLw7x4OrE0Vjxa2R0KjfyZcsjrWJs86d9/tjwwSDkKIPsiTwFfTXwTgpBpiYdNqD53vVftjjppVTiCTECAyGFLSkRDiUZXTCQxMImqSFNYls0UBFDGJW8lNiVvtK9Vs7rOyTKjGdi9ISPL/pHqKL/X2xeoekFf8Ebsn4yIS/Yu2NZDnBRF43WLH8dALkzWQzthHdNvMaKR6+BvVK0Wd21ijbOKnqhTQAu56QgpUZyGnzN5R+89TcW5z79nvCqQax/vvv8GCg5IndAJJrh6CSG2jUjlIq4i8lxaQ+u/ibJ5RozomV9b98hLV6GO6y9t5KbE4hcxqojl8t2ZVM5Njx5Rhs8J415926cuNfabrEKu8SB93cUwqD1FG9HaMYgbwip/F8pNz4m62X3YKxHcLkkyuIrozBylZ0UTVWO+5ShTOaeTZuSykYbxqoUfJybFXnrDfPXMMWG3+R7Jgx0gPkfAO6nVwW6nCH4FZEV9/N28Z8tnQhi+xFnd9N8om1/+lyDEqHuof20cO/LS6l0RdrPYQqoTMAi7tKi+DzCnowPgu2KpYok9SMZKRwQEs7Yq5GWo68ygDRONbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(36092001)(478600001)(71200400001)(6506007)(316002)(7696005)(64756008)(66556008)(4326008)(54906003)(33656002)(26005)(6916009)(9686003)(186003)(5660300002)(55016002)(52536014)(8936002)(76116006)(66946007)(2906002)(66446008)(86362001)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M6TpNGmh/dLc31mDjBDGomuZWeG94aRe9ktoy4yE85MWD27SNUxE4ocSFp+8oj6r8rCiWLaIsS9ZafgW0zGhp+wFtByPgkLENsf1TTS2xbZh/y+FwLnc3GGqsVaQOBZ5s3OuTC0OFMxicQv42xbZRg57ER9AvDvN4QtUWRKu1ZwFsw7D6BSk612ixszxao0QCI7PbtDqj7AshC0ydj8+iFDtCqAOBZs67xh+CDVBSRaBFWnDMk7HUJrfq0KpaiRbKAGCZG6ZRWlJxETKs4ZPiGjpU48fXsMONdNYcbDfNFp9ympFPpTV8BoXtNRCjRQ9MmmLFyenBtatmk3sCTsw12slMXbFMQc7RFvdo3zqKrxr3GV5ydHQDKVWycsz5+ksSV6lH0KRlFhkueEH+OMAjlf9vDjL7x89/w8E0XU35NNHtPzba9rt0tnXnNALUwXBJZzSBv37GEClZlKPRfgifJfmmfEdEHFMxxaAUizMwSfKsbgJPJMu/8+d7zRcgVgXk4h9qmr8m6HNFUSl9VOYgo53efdrXvG88L1eRM+iIadbw4g8cxOIuggIT6sSNd83yRuT8H1slnUDItflbodmqvDRlQHR8w/oxfOdjttGW1YidABMn/qb+AwPxDW0KOWPtPi3L/nkopRpaaXv8wpIsOFS/l0VWVfmpN3U8hSNupFqmlNpbBG7mtSHoFRWWwGuzF0oIn8fQwxV6+TOUF+H6LUhVv2ru+AHko5mcZzCBfU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093938b3-8c98-45b4-e61c-08d8e20c1a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 08:28:08.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJhkbgW1hZgucTjDWi49bhfAhngWWFTssOlRZXaiYW7fq58zkzOzhZVu4zhEyP9aEZvPCdY3ZtrS/WOG0cVIiGya7MnbC6nmTxx4t/Dk/PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5304
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_02:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=913 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgMTI6NDAgQU0gUGF3ZWwgTGFzemN6YWsgPG1haWx0
bzpwYXdlbGxAY2FkZW5jZS5jb20+IHdyb3RlOg0KPkZyb206IFBhd2VsIExhc3pjemFrIDxtYWls
dG86cGF3ZWxsQGNhZGVuY2UuY29tPg0KPg0KPlBhdGNoIGFkZHMgZXh0cmEgY2hlY2tpbmcgZm9y
IGJJbnRlcnZhbCBwYXNzZWQgYnkgY29uZmlnZnMuDQo+VGhlIDUuNi40IGNoYXB0ZXIgb2YgVVNC
IFNwZWNpZmljYXRpb24gKHJldi4gMi4wKSBzYXk6DQo+IkEgaGlnaC1iYW5kd2lkdGggZW5kcG9p
bnQgbXVzdCBzcGVjaWZ5IGEgcGVyaW9kIG9mIDF4MTI1IMK1cw0KPihpLmUuLCBhIGJJbnRlcnZh
bCB2YWx1ZSBvZiAxKS4iDQo+DQo+VGhlIGlzc3VlIHdhcyBvYnNlcnZlZCBkdXJpbmcgdGVzdGlu
ZyBVVkMgY2xhc3Mgb24gQ1YuDQo+SSB0cmVhdCB0aGlzIGNoYW5nZSBhcyBpbXByb3ZlbWVudCBi
ZWNhdXNlIHdlIGNhbiBjb250cm9sDQo+YkludGVydmFsIGJ5IGNvbmZpZ2ZzLg0KPg0KPlNpZ25l
ZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxtYWlsdG86cGF3ZWxsQGNhZGVuY2UuY29tPg0KPi0t
LQ0KPsKgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgfCA2ICsrKysrKw0KPsKg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlv
bi9mX3V2Yy5jDQo+aW5kZXggNDRiNDM1MmEyNjc2Li41ZDYyNzIwYmI5ZTEgMTAwNjQ0DQo+LS0t
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMNCj4rKysgYi9kcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYw0KPkBAIC02MzEsNiArNjMxLDEyIEBAIHV2Y19mdW5j
dGlvbl9iaW5kKHN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqYywgc3RydWN0IHVzYl9mdW5jdGlv
biAqZikNCj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjcHVfdG9fbGUxNihtaW4ob3B0cy0+c3Ry
ZWFtaW5nX21heHBhY2tldCwgMTAyM1UpKTsNCj7CoCDCoCDCoCDCoCB1dmNfZnNfc3RyZWFtaW5n
X2VwLmJJbnRlcnZhbCA9IG9wdHMtPnN0cmVhbWluZ19pbnRlcnZhbDsNCj4NCj4rwqAgwqAgwqAg
wqAvKiBBIGhpZ2gtYmFuZHdpZHRoIGVuZHBvaW50IG11c3Qgc3BlY2lmeSBhIGJJbnRlcnZhbCB2
YWx1ZSBvZiAxICovDQo+K8KgIMKgIMKgIMKgaWYgKG1heF9wYWNrZXRfbXVsdCA+IDEpDQo+K8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdXZjX2hzX3N0cmVhbWluZ19lcC5iSW50ZXJ2YWwgPSAxOw0K
PivCoCDCoCDCoCDCoGVsc2UNCj4rwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1dmNfaHNfc3RyZWFt
aW5nX2VwLmJJbnRlcnZhbCA9IG9wdHMtPnN0cmVhbWluZ19pbnRlcnZhbDsNCj4rDQo+DQo+VGhl
cmUgaXMgYSAidXZjX2hzX3N0cmVhbWluZ19lcC5iSW50ZXJ2YWwgPSBvcHRzLT5zdHJlYW1pbmdf
aW50ZXJ2YWw7IiBhZ2FpbiBhdCBiZWxvdyBjb2RlDQo+QmVzaWRlcywgdGhlIGRlZmF1bHQgdmFs
dWUgaXMgMSBmb3LCoG9wdHMtPnN0cmVhbWluZ19pbnRlcnZhbC4gV2hhdCB0aGUgcmVhbCBpc3N1
ZSB5b3Ugb2JzZXJ2ZWQNCj5hdCBDViB0ZXN0Pw0KPg0KDQpUaGUgaXNzdWUgb2NjdXJzIHdoZW4g
SSBpbnRlbnRpb25hbGx5IHNldDoNCiAgICAgICAgZWNobyAzMDcyICA+IGZ1bmN0aW9ucy8kRlVO
Q1RJT04vc3RyZWFtaW5nX21heHBhY2tldA0KICAgICAgICBlY2hvIDQgPiBmdW5jdGlvbnMvJEZV
TkNUSU9OL3N0cmVhbWluZ19pbnRlcnZhbA0KDQpUaGVuIGZvciAgQ1YgQ0g5IFREIDkuNTogRW5k
cG9pbnQgRGVzY3JpcHRvciB0ZXN0IGl0IGdvdDoNCiIoTXVsdCA9IDIpSWxsZWdhbCBoaWdoIHNw
ZWVkIGlzb2Nocm9ub3VzIGVuZHBvaW50IE1heFBhY2tldFNpemUgOiAweDQwMA0KKFVTQjogMS4y
Ljc4KSBBIEhpZ2ggc3BlZWQgSW50ZXJydXB0L0lzb2Nocm9ub3VzIGVuZHBvaW50IG11c3QgaGF2
ZSBhIE1heFBhY2tldFNpemUgYmV0d2Vlbg0KNjgzIGFuZCAxMDI0IGFuZCBiSW50ZXJ2YWwgdmFs
dWUgb2YgMSB3aGVuIHRoZSBNdWx0IHZhbHVlIGlzIHR3by4iDQoNCkZvciBkZWZhdWx0IHZhbHVl
IENWIHBhc3NlZC4gIE9mIGNvdXJzZSwgSSBjYW4gZml4IGl0IGJ5IGNoYW5naW5nICBzdHJlYW1p
bmdfaW50ZXJ2YWwsIGJ1dCBJIHRob3VnaHQgdGhhdA0KaXQgY291bGQgYmUgZ29vZCB0byBoYXZl
IHByb3RlY3Rpb24gYWdhaW5zdCB0aGlzIGlzc3VlLiANCkVzcGVjaWFsbHkgc2luY2UgVXNiIDIg
c3BlY2lmaWNhdGlvbiBzYXkgdGhhdCBiSW50ZXJ2YWwgbXVzdCBiZSAxIGZvciBoaWdoIGJhbmR3
aWR0aCBlbmRwb2ludHMuDQoNClBhd2VsDQoNCj5QZXRlcg0KPg0KPsKgIMKgIMKgIMKgIHV2Y19o
c19zdHJlYW1pbmdfZXAud01heFBhY2tldFNpemUgPQ0KPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGNwdV90b19sZTE2KG1heF9wYWNrZXRfc2l6ZSB8ICgobWF4X3BhY2tldF9tdWx0IC0gMSkgPDwg
MTEpKTsNCj7CoCDCoCDCoCDCoCB1dmNfaHNfc3RyZWFtaW5nX2VwLmJJbnRlcnZhbCA9IG9wdHMt
PnN0cmVhbWluZ19pbnRlcnZhbDsNCj4tLQ0KPjIuMjUuMQ0K
