Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B425407026
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhIJRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:02:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47350 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231414AbhIJRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:02:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18AGVpVl007216;
        Fri, 10 Sep 2021 17:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NE9e1i0srdR9z/mz/nFQv4hYd8+tMG1dwljtwJ+9aXw=;
 b=PxStgMrjhHbc9NNtfJIZnwBqXD0pWLPkBCXf1wXFLXm4aKbDyacT7nB/LAq9qg+v6KZj
 rtBgycRluV2mp4UYQI3DmJUXSVLYH8DbLSwis6FeZV+IBOMDx7Q6XxsbIuqbENgm9lDa
 pdCb3yYp9JSsxJ2WRPHMxQWIAtQITufzgtK6/Z9LGZgbqpoBl95okx7V/xn+laj+kJaU
 PXY00bnNU3vMkstI5JbC0EcFj9H2cq3Z9pj2GgqQ3RuDf9BfL+VcDdy4levB2VpjcKzM
 5Vrzuz2tzoRi3Z4H/xSrZtw+0rbhc1Taw4T8R+PHYalAGPfMVT+eEtl5ZazJW1OhvNkW Ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NE9e1i0srdR9z/mz/nFQv4hYd8+tMG1dwljtwJ+9aXw=;
 b=Vm7cM2qfwTFsVO9c0t7mPSfRqtGlTUDliXojs4raWk4VhJEFl3wqVxn6wToup2nZTRWv
 tF3ECQRIAoRTWJnJyGIkD14dJIO2s8Ot/FT4q6O8ZidOXZ/wNUHJQyrafq3OxLc6wmMk
 83hxulv/VobRaiyH5p3uYQDezgbyDQY3vdlNKT6Y0bh16S0+Lq7QPXObDOChriXrDSBw
 ZVLtjnmqbTTtcKWizIR037ngMvPhx2WNx1Dt9YYVwMPBOkhSCiE6pHqqTUde3QCsxIes
 orHmwh9OHhNs4EUz08tnG6RgfVVZc+iEN6HjCJ6WeNunSXXk0esZBOJpIr6estQKt/o3 hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayttbjj6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 17:01:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18AH0x1l152573;
        Fri, 10 Sep 2021 17:01:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 3aytfu5jsn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 17:01:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTohIzk/MRr2oNp1NstymghUWza+cz4SXtArtDV98KyWJZK30a3N9zijMo/kV5U5cZ/0WSpGYS0selyEMOSDw7EcmUb0DVHksSpo+2xdYox4mJ8m8RaTVhJT2g/k4Psdq3vLnV5lBLav6QqhEham7wOoszUDOfltkNmYo8vntgej0gKtAKIUFVA4n1ZNSYD20nc9uEYnYcCoPdxx5EUujMDRWnThL6s1ECfcX7ipxXK53OqX9R3IbN1JBIuKLAKwTzXX8oyYqe+mc8ULoZYXKEuC2bcYuTGK/CmUTHTbuZOHsbS3A56T5iXCWgY93G24nNFKojsKTGE4iwmlrJLgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NE9e1i0srdR9z/mz/nFQv4hYd8+tMG1dwljtwJ+9aXw=;
 b=G7CYoo7lNpRYIOKZB3E1d2K/w528kKdv8Q6y2PoQj16h7yIBSxrKo2qRdVYfHZhZzv8xr98dhfa/jinxrAjD9VbqhnfcIuUOMKRepW8AppO9JjnberVIedsNGgiH4/YDv5x7zGG00GfQkzyXZtnDjofsJzAHAi8D7j7Zr3bHGeaSoB7M+UgCyIfElCeE/bFYyP3rAEYzFxr9fBiT7ku+a+VPRhAB0klP+/qKBbeuVeJoJ40o6JPJsbFwix3hMAJ4uCQIMfLWkZSHMIAckWHZg6sFEP1Z6vos8Gru4btsP7V07gfJUBEakC2aT5hU/AvuiFgsnadKgaT1XC84P8OrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE9e1i0srdR9z/mz/nFQv4hYd8+tMG1dwljtwJ+9aXw=;
 b=Pn80T7rXbQDUPRRQxzW9Zv5NQ6DKRZdgbvDssOWmspIVMUqSs9HKg3CKWJa9HgtVLR034Wqs+KZ4+z9xoxdRM6Nj3W+4obvx6QC6kN8UebgJ47gQcJx01MFHcznnchxVUXZe+BSEdLx6TqOX5TAz9h7PHJjpNW1lYj7wpEcG2Fk=
Received: from SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 17:00:47 +0000
Received: from SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe]) by SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe%5]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 17:00:47 +0000
From:   Wengang Wang <wen.gang.wang@oracle.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
CC:     Chenyuan Mi <cymi20@fudan.edu.cn>,
        akpm <akpm@linux-foundation.org>, Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: Fix handle refcount leak in two
 exception handling paths
Thread-Topic: [Ocfs2-devel] [PATCH v2] ocfs2: Fix handle refcount leak in two
 exception handling paths
Thread-Index: AQHXpJ+H0ttR42xfTUiCjMce85OD7KuaYEsAgAEsHACAAHAfAIAAh6mAgAD9XQA=
Date:   Fri, 10 Sep 2021 17:00:47 +0000
Message-ID: <70C24A61-6E9C-43D8-BB43-1D56A8081E19@oracle.com>
References: <20210908102055.10168-1-cymi20@fudan.edu.cn>
 <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
 <6018AF95-3613-4D43-A3E6-7BAA0E0BE009@oracle.com>
 <c48fb54e-0dd9-42c7-f53d-2ea58fb97255@linux.alibaba.com>
 <CED0D2AD-7905-490E-8D36-50D192CD9BF1@oracle.com>
 <ee86ea1a-0348-e975-3c67-8d574eaadbe3@linux.alibaba.com>
In-Reply-To: <ee86ea1a-0348-e975-3c67-8d574eaadbe3@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100d97de-cee3-4469-f059-08d9747c8945
x-ms-traffictypediagnostic: SA2PR10MB4604:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR10MB46047F543A5993B1BD633F5BCFD69@SA2PR10MB4604.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrNWxATHUvnY8WgpPgYHmtSW0izWVNMymvToKSoxAUhOKyeqpMszI8Ks32TaTKvJxmlTYUe9BkMgWXwDULlrAHYr0wVzj9TOxjShIOZNgpdyIJIwqie6i0YqT9Pjt9nnY9GFPPphKIUFqgvHjsLm6RI5LrwtrPheI9VHGUa+Fxn1+eE6C4dSUnWtSaADxCiJCkyHfnEImdRPkEUqR7z9rxVOmzN+KqxPVQkRtTzpT2sTo0YRomfaunhh0sYj6BOfDypxC6+NXS5MbrMqnfrwKqf/QqTJrkOrQZk+1bxX5uod7zB9PKLEjTzENRQdb6jOYBebjh6vng0pOQdb8z2d3x04azJsvCMttgTAHzPhee5ypshtHPaDsLU+kS3pj8MMzU0uiHWLE7de0CxcpZoME3f848bN1r/14wCpXAqVaTD6p+X/qjfrVpWT6PcqUk1ew8b157ao++TftMzhujfZUp/Vr3cT34gplcckTfpVILynmwDUT6olTmS2ZTvDu1ESAZYIsWC4zi3GGwxgBn/XIvSXjrZLLYOHmnx2AeH/QZkzWe23x7BWcKBSf1p5EnGqKGkEf41REi6ueuOZSiKS1+l3T/+Ukj7IbcFTvGpbDBzahaifCPCGt1nNFfssM5AVg+TdEEjD6+qViX89IpTAOyW4YyR/aREiRVMI45vi8mdMS6XYqk4pftFD6Ef/f3D3HELEqmLyn5ThS2orQrZaXMG7Tp8mQvQmqfHqwhJQvDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2701.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39860400002)(53546011)(6506007)(478600001)(2906002)(83380400001)(122000001)(38100700002)(71200400001)(33656002)(107886003)(2616005)(86362001)(4326008)(6512007)(38070700005)(8936002)(6916009)(8676002)(36756003)(66446008)(76116006)(64756008)(54906003)(66556008)(6486002)(66946007)(66476007)(5660300002)(186003)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0FubVA0bzJNekpQR09ON2xQQXM5ZFNtK0tyYXFCOWZTTXlKZE9MYkpta0tL?=
 =?utf-8?B?THhnNkZvdDZsRmc5VkdHYTY1a0ljZVF2YTBjOVlZa2NMRzF2ZFpOdzM2eEVP?=
 =?utf-8?B?Y3RzMzBTUVNuOElrODdZSnNXVExyT0k4YVNEZUVkNG5iMXJVK1hsYkpvd3pZ?=
 =?utf-8?B?dVBGY0NOdGpxOGFzZHZidlA4Q0xZYzNCaW9RbmlXdkxLdVJxcWl2Wjg3cEVR?=
 =?utf-8?B?ZkxwNjdGSE9rL0NNMFNxSkVHMldma2ZSUVpyR1U5ajJJd2JlWHpTc01uZ1hC?=
 =?utf-8?B?NkhSOTM4eXQ2SXFPd0pJZUlITmpaQnhDSGZ1WENSNi9RWThta1lvanErWmpo?=
 =?utf-8?B?R2liNEhyQThUUmZMbzliRXVRNmFjVE16K3lla0VBdXJaZTZXOGE4eGFVUmFp?=
 =?utf-8?B?elh1TVFxaFNZQXBab2t6UVFnTXFKcy9meXNNWmhjeVUxb285NHZkaEtOUTNi?=
 =?utf-8?B?VkNxdTBGS3o3eXp4UTRRVHVxY0QwRTNMcEtsdWl6MWk0NlBpLzBIU0NHenlr?=
 =?utf-8?B?UFdaaUVWUVQ1b1M2cjZVVXc1SUY1MEM1NnRYblRYY09Wb2d6ZkVTV2FVQTFC?=
 =?utf-8?B?bldVUWZtcGhnWUtkaFVSc0JERWdDU2Fpd2pVTEFvbzFTUmlxZHdzSjVNL282?=
 =?utf-8?B?dVBmaUdmVWxURWRUeEhxdWR4TkhqalJrMklGSkhRNkloN0h4YjhWQUp4dzJG?=
 =?utf-8?B?QnNRZ29neFRnUis1ZUl4a1JDZGhXK0N4OWxCS2RIR1Izd2J0WERDUTl1YTFM?=
 =?utf-8?B?MTg1SlRyUjJ5L0VPK3Y4aTlRelg4TlBrQ3Via1NHU29CUXhRTXBJYXU5U0FI?=
 =?utf-8?B?cGlzRDBjVlFINFdGNTdCSGpsREV4dXJpc2trYnBHVjN1ZkpzcEovL1ZLSTNk?=
 =?utf-8?B?cUVRZktDeCtZL3p2NTVzWFgwbSs2R3lrdXRHYThZRlRReE1EaW1ya1dpaDdN?=
 =?utf-8?B?MmsyRVNVYUxnRGZUK2I1Q2p3a24rbENwTTk3dy93UzFaemk1QVdLWTVSNXky?=
 =?utf-8?B?UjVsa3BHVnNSTWZ0WU9DUElveHNxcDNwckNBNUc1Ri9qMWdvakh2eklCS3M0?=
 =?utf-8?B?OTQyR0hMT1hXZFdzWjAzZHI3WU1XN3ZLcXFHRk9TSUhHem1NUE9adFRpc013?=
 =?utf-8?B?VmcwNlQvL2htLzhKVTNJT3Y0UWJ6dUdPZ0plWWpYVTJRUzFocmowRkoxSk5x?=
 =?utf-8?B?K3RXUEV2dTB2bnVOTFA5Mmp3U3FIRCs0cVFqL3lVODgraEJBalhBeXVaOERL?=
 =?utf-8?B?VWZ1N2xHckpwTERzWmkzT2ljVXk2S2pubkdYUzNWaEh3Q0pialFyU2xVVmJO?=
 =?utf-8?B?UEZINjkzWCsrWkZLM0M3QnBIdDJtUW9LUEMxOWl4UGk0ZDBxN3B0bFJxZGpv?=
 =?utf-8?B?QzVzMEY4amUzTE1sWDRNRlVOVlNDNnZSMzZ2NU5JMEtQWjloaDRrQ3RkNzhM?=
 =?utf-8?B?a3J1ZEtVOExLa3Awc3F4cWh6UEdqOFlJOUowSWpMOGMwTGpBYjFsQzQybFRs?=
 =?utf-8?B?ZkJsZy9Zam1NYmUvait1VVhmQUVEODczK3Q0UFhzRFYxb1c5TExnaFNGYWIy?=
 =?utf-8?B?RDVkZHNIcmM0Q2JGVUVnVGFoaUs5c3R5cVFOOXJaa3JYVy9mZWkyUTNMNCs5?=
 =?utf-8?B?c2RrWDBBKzBZYmx3MEpyaktGVWxMcWltUE1pUVphNzZQOGVNVXBnWTJhNXVq?=
 =?utf-8?B?Ynh5cGY3a25paVJkaWNzVmpIeXZWTm5TamZTekJOVWl4NDVFQjVnenZXS0ls?=
 =?utf-8?B?bWdqdjhPNlVocUd1OHFsMXFjTUtRZHJIZHZKbEkzWEFhN2dLL2pNUUNrZW1m?=
 =?utf-8?Q?4gp3eNR1HIKQFD0U1M76txu+WcrsUq6js5F/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E1267F022600B439DD03BDDA99E2273@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2701.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100d97de-cee3-4469-f059-08d9747c8945
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 17:00:47.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tileHCFlJ3JnXUnSxkuqGzDz7lua/G0EcScwW5qjWmgvs0M7Hon71b1NtCnJfbc9NLbx3XAG+V59N/zrhjnM92CW1bBhFl/tsMtmjBFoFDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10103 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100099
X-Proofpoint-GUID: YtUfFzqNB93c5URjXGFRE6C_c32HQejp
X-Proofpoint-ORIG-GUID: YtUfFzqNB93c5URjXGFRE6C_c32HQejp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDksIDIwMjEsIGF0IDY6NTMgUE0sIEpvc2VwaCBRaSA8am9zZXBoLnFpQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gOS8xMC8yMSAxOjQ4IEFN
LCBXZW5nYW5nIFdhbmcgd3JvdGU6DQo+PiANCj4+IA0KPj4gT24gU2VwIDksIDIwMjEsIGF0IDQ6
MDcgQU0sIEpvc2VwaCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPG1haWx0bzpqb3Nl
cGgucWlAbGludXguYWxpYmFiYS5jb20+PiB3cm90ZToNCj4+IA0KPj4gSGkgV2VuZ2FuZywNCj4+
IA0KPj4gT24gOS85LzIxIDE6MTIgQU0sIFdlbmdhbmcgV2FuZyB3cm90ZToNCj4+IEhpLA0KPj4g
DQo+PiBTb3JyeSBmb3IgbGF0ZSBpbnZvbHZpbmcsIGJ1dCB0aGlzIGRvZXNu4oCZdCBsb29rIHJp
Z2h0IHRvIG1lLg0KPj4gDQo+PiBPbiBTZXAgOCwgMjAyMSwgYXQgMzo1MSBBTSwgSm9zZXBoIFFp
IDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb208bWFpbHRvOmpvc2VwaC5xaUBsaW51eC5hbGli
YWJhLmNvbT4+IHdyb3RlOg0KPj4gDQo+PiANCj4+IA0KPj4gT24gOS84LzIxIDY6MjAgUE0sIENo
ZW55dWFuIE1pIHdyb3RlOg0KPj4gVGhlIHJlZmVyZW5jZSBjb3VudGluZyBpc3N1ZSBoYXBwZW5z
IGluIHR3byBleGNlcHRpb24gaGFuZGxpbmcgcGF0aHMNCj4+IG9mIG9jZnMyX3JlcGxheV90cnVu
Y2F0ZV9yZWNvcmRzKCkuIFdoZW4gZXhlY3V0aW5nIHRoZXNlIHR3byBleGNlcHRpb24NCj4+IGhh
bmRsaW5nIHBhdGhzLCB0aGUgZnVuY3Rpb24gZm9yZ2V0cyB0byBkZWNyZWFzZSB0aGUgcmVmY291
bnQgb2YgaGFuZGxlDQo+PiBpbmNyZWFzZWQgYnkgb2NmczJfc3RhcnRfdHJhbnMoKSwgY2F1c2lu
ZyBhIHJlZmNvdW50IGxlYWsuDQo+PiANCj4+IEZpeCB0aGlzIGlzc3VlIGJ5IHVzaW5nIG9jZnMy
X2NvbW1pdF90cmFucygpIHRvIGRlY3JlYXNlIHRoZSByZWZjb3VudA0KPj4gb2YgaGFuZGxlIGlu
IHR3byBoYW5kbGluZyBwYXRocy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQ2hlbnl1YW4gTWkg
PGN5bWkyMEBmdWRhbi5lZHUuY248bWFpbHRvOmN5bWkyMEBmdWRhbi5lZHUuY24+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogWGl5dSBZYW5nIDx4aXl1eWFuZzE5QGZ1ZGFuLmVkdS5jbjxtYWlsdG86eGl5
dXlhbmcxOUBmdWRhbi5lZHUuY24+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWGluIFRhbiA8dGFueGlu
LmN0ZkBnbWFpbC5jb208bWFpbHRvOnRhbnhpbi5jdGZAZ21haWwuY29tPj4NCj4+IA0KPj4gUmV2
aWV3ZWQtYnk6IEpvc2VwaCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPG1haWx0bzpq
b3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+Pg0KPj4gLS0tDQo+PiBmcy9vY2ZzMi9hbGxvYy5j
IHwgMiArKw0KPj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvZnMvb2NmczIvYWxsb2MuYyBiL2ZzL29jZnMyL2FsbG9jLmMNCj4+IGluZGV4IGYx
Y2M4MjU4ZDM0YS4uYjA1ZmRlN2VkYzNhIDEwMDY0NA0KPj4gLS0tIGEvZnMvb2NmczIvYWxsb2Mu
Yw0KPj4gKysrIGIvZnMvb2NmczIvYWxsb2MuYw0KPj4gQEAgLTU5NDAsNiArNTk0MCw3IEBAIHN0
YXRpYyBpbnQgb2NmczJfcmVwbGF5X3RydW5jYXRlX3JlY29yZHMoc3RydWN0IG9jZnMyX3N1cGVy
ICpvc2IsDQo+PiBzdGF0dXMgPSBvY2ZzMl9qb3VybmFsX2FjY2Vzc19kaShoYW5kbGUsIElOT0RF
X0NBQ0hFKHRsX2lub2RlKSwgdGxfYmgsDQo+PiBPQ0ZTMl9KT1VSTkFMX0FDQ0VTU19XUklURSk7
DQo+PiBpZiAoc3RhdHVzIDwgMCkgew0KPj4gKyBvY2ZzMl9jb21taXRfdHJhbnMob3NiLCBoYW5k
bGUpOw0KPj4gbWxvZ19lcnJubyhzdGF0dXMpOw0KPj4gZ290byBiYWlsOw0KPj4gfQ0KPj4gQEAg
LTU5NjQsNiArNTk2NSw3IEBAIHN0YXRpYyBpbnQgb2NmczJfcmVwbGF5X3RydW5jYXRlX3JlY29y
ZHMoc3RydWN0IG9jZnMyX3N1cGVyICpvc2IsDQo+PiAgICAgZGF0YV9hbGxvY19iaCwgc3RhcnRf
YmxrLA0KPj4gICAgIG51bV9jbHVzdGVycyk7DQo+PiBpZiAoc3RhdHVzIDwgMCkgew0KPj4gKyBv
Y2ZzMl9jb21taXRfdHJhbnMob3NiLCBoYW5kbGUpOw0KPj4gDQo+PiBBcyBhIHRyYW5zYWN0aW9u
LCBzdHVmZiBleHBlY3RlZCB0byBiZSBpbiB0aGUgc2FtZSBoYW5kbGUgc2hvdWxkIGJlIHRyZWF0
ZWQgYXMgYXRvbWljLg0KPj4gSGVyZSB0aGUgc3R1ZmYgaW5jbHVkZXMgdGhlIHRsX2JoIGFuZCBv
dGhlciBtZXRhZGF0YSBibG9jayB3aGljaCB3aWxsIGJlIG1vZGlmaWVkIGluIG9jZnMyX2ZyZWVf
Y2x1c3RlcnMoKS4NCj4+IENvbWluZyBoZXJlLCBzb21lIG9mIHJlbGF0ZWQgbWV0YSBibG9ja3Mg
bWF5IGJlIGluIHRoZSBoYW5kbGUgYnV0IG90aGVycyBhcmUgbm90IGR1ZSB0byB0aGUgZXJyb3Ig
aGFwcGVuZWQuDQo+PiBJZiB5b3UgZG8gYSBjb21taXQsIHBhcnRpYWwgbWV0YSBibG9ja3MgYXJl
IGNvbW1pdHRlZCB0byBsb2cuIOKAlCB0aGF0IGJyZWFrcyB0aGUgYXRvbWljIGlkZWEsIGl0IHdp
bGwgY2F1c2UgRlMgaW5jb25zaXN0ZW5jeS4NCj4+IFNvIHdoYXTigJlzIHJlYXNvbiB5b3Ugd2Fu
dCB0byBjb21taXQgdGhlIG1ldGEgYmxvY2sgY2hhbmdlcywgd2hpY2ggaXMgbm90IGFsbCBvZiBl
eHBlY3RlZCwgaW4gdGhpcyBoYW5kbGUgdG8gam91cm5hbCBsb2c/DQo+PiANCj4+IERvIHlvdSBy
ZWFsbHkgc2VlIGEgaGl0IG9uIHRoZSBmYWlsdXJlPyBvciBqdXN0IHlvdSBkZXRlY3RlZCB0aGUg
cmVmY291bnQgbGVhayBieSBjb2RlIHJldmlldz8NCj4+IA0KPj4gWW91IG1heSB3YW50IHRvIGxv
b2sgYXQgb2NmczJfam91cm5hbF9kaXJ0eSgpIGZvciB0aGUgZXJyb3IgaGFuZGxpbmcgcGFydC4N
Cj4+IA0KPj4gDQo+PiBGb3IgdGhlIGZpcnN0IGVycm9yIGhhbmRsaW5nLCBzaW5jZSB3ZSBkb24n
dCBjYWxsIG9jZnMyX2pvdXJuYWxfZGlydHkoKQ0KPj4geWV0LCBzbyB3b24ndCBiZSBhIHByb2Js
ZW0uDQo+PiBGb3IgdGhlIHNlY29uZCBlcnJvciBoYW5kbGluZywgSSB0aGluayB3ZSBkb24ndCBo
YXZlIGEgYmV0dGVyIHdheS4gTG9vaw0KPj4gYXQgb3RoZXIgY2FsbGVycyBvZiBvY2ZzMl9mcmVl
X2NsdXN0ZXJzKCksIHdlIHNpbXBseSBpZ25vcmUgdGhlIGVycm9yDQo+PiBjb2RlLg0KPj4gQW55
d2F5LCB3ZSBzaG91bGQgY29tbWl0IHRyYW5zYWN0aW9uIGlmIHN0YXJ0cywgb3RoZXJ3aXNlIGpv
dXJuYWwgd2lsbA0KPj4gYmUgYWJub3JtYWwuDQo+PiANCj4+IEkgZG9uJ3QgdGhpbmsgc28uIElm
IGVycm9yIGhhcHBlbmVkLCB3ZSBzaG91bGQgZmFpbCBvY2ZzMiwgcmF0aGVyIHRoYW4gZG8gYSBw
YXJ0aWFsIGNvbW1pdHRpbmcuDQo+PiANCj4gDQo+IFVtbS4uLiBub3QgZXhhY3RseS4uLg0KPiBU
YWtlIG9jZnMyX2ZyZWVfY2x1c3RlcnMoKSBmb3IgZXhhbXBsZSwgd2hlbiBpdCBmYWlscyBpbiBj
YXNlIG9mIEVJTyBvcg0KPiBFTk9NRU0sIHdlIGNhbid0IGp1c3QgYWJvcnQgam91cm5hbCBpbiBz
dWNoIGNhc2VzLCBiZWNhdXNlIGl0IGlzIG5vdCBzbw0KPiBzZXJpb3VzLCBvbmx5IGEgYml0IGJs
b2NrcyBzdGlsbCBvY2N1cGllZCBhbmQgdGhleSB3aWxsIHJlY292ZXJ5IGR1cmluZw0KPiB0aGUg
bmV4dCBtb3VudC4gDQoNClNvIGFyZSB5b3Ugc3VyZSBhIHBhcnRpYWwgam91cm5hbCBjb21taXRt
ZW50IHdvbuKAmXQgY2F1c2UgRlMgaW5jb25zaXN0ZW5jeT8gYW55IHByb29mIGZvciB0aGF0Pw0K
UHJvYmxlbSBpcyBub3QganVzdCBpZiB3ZSBjYW4gdHJ5IHRvIGZyZWUgdGhlIGJsb2NrcyBhZ2Fp
biBvciBub3QuIFRoZSBwcm9ibGVtIGlzIEZTIGluIGluY29uc2lzdGVudCBzdGF0ZS4NCg0KSSBk
aWRu4oCZdCBsb29rIGludG8gb2NmczJfZnJlZV9jbHVzdGVycygpIGZ1cnRoZXIsIGJ1dCBjYW4g
aW1hZ2UgdGhpcyBjYXNlOg0KDQoxKSBXZSBhcmUgZ29pbmcgdG8gZnJlZSBzb21lIGNsdXN0ZXJz
L2Jsb2Nrcy4gDQoyKSBXZSBtYXkgbmVlZCBhIG5ldyAobm90IG1lcmdpbmcgaW50byBleGlzdGlu
ZykgcmVjb3JkIHRvIHJlbWVtYmVyIHRoZSBuZXcgZnJlZSBleHRlbnQuIA0KMykgVGhlIG5ldyBy
ZWNvcmQgbmVlZHMgdG8gYmUgaW5zZXJ0ZWQgaW50byBmcmVlIGV4dGVudCB0cmVlLg0KNCkgdGhl
IGJsb2NrIChibG9jayBBKSB3aGVyZSB0aGUgbmV3IHJlY29yZCB0byBiZSBpbnNlcnRlZCBjb3Vs
ZCBiZSBhbHJlYWR5IGZ1bGwgdGh1cyBubyBzcGFjZSBmb3IgdGhlIG5ldyByZWNvcmQuDQo1KSB0
aGVuIHdlIG5lZWQgYXQgbGVhc3QgYSBuZXcgYmxvY2sgKGJsb2NrIEIpIHRvIHN0b3JlIHRoZSBu
ZXcgcmVjb3JkLiAodG8gbWFpbnRhaW4gdGhlIGZyZWUgYmxvY2sgYnRyZWUsIG1heWJlIGFub3Ro
ZXIgYmxvY2ssIGJsb2NrIEMgaXMgbmVlZGVkIHRvbykuDQo2KSBTbyB3ZSBuZWVkIHRvIHNhdmUg
dGhlIHBvaW50ZXIgKGJsb2NrIG51bWJlcikgb2YgYmxvY2sgQiBpbiBibG9jayBBIGFuZCBzdG9y
ZSB0aGUgbmV3IHJlY29yZCBpbiBibG9jayBCLg0KNykgSW4gdGhpcyBjYXNlIHdlIG5lZWQgdG8g
bWFrZSBzdXJlIGJsb2NrIEEgYW5kIGJsb2NrIEIgZWl0aGVyIGJvdGggaW4gam91cm5hbCBsb2cs
IG9yIG5vbmUgb2YgdGhlbSBpbiBqb3VybmFsIGxvZy4gIFdlIGRvbuKAmXQgYWxsb3cgYmxvY2sg
QSBpcyBpbiBqb3VybmFsIGJvdCBibG9jayBCIGlzIG5vdCwgcmlnaHQ/DQoNCmdvIGJhY2sgdG8g
cXVlc3Rpb24sICAgRXJyb3IgY291bGQgYWZ0ZXIgYmxvY2sgQiBpcyBhZGRlZCB0byBqb3VybmFs
IGhhbmRsZSBidXQgYmVmb3JlIGJsb2NrIEEgaXMgYWRkZWQuIEluIGNhc2Ugd2UgZG8gYSBqb3Vy
bmFsIGNvbW1pdCB3aGVuIGhpdHRpbmcgdGhhdCBlcnJvciwgd2UgYXJlIGNvbW1pdHRpbmcgYmxv
Y2sgQiB0byBqb3VybmFsIGJ1dCBsZWF2aW5nIGJsb2NrIEEgbm90IGluLg0KSWYgcGFuaWMgaGFw
cGVuZWQsIGJsb2NrIEEgY291bGQgbmV2ZXIgaGFzIHRoZSBwb2ludGVyIHBvaW50aW5nIHRvIGJs
b2NrIEIuIFRoZSByZXN1bHQgaXMgYmxvY2sgQiBpcyBwZXJtYW5lbnRseSBsb3N0ICh3ZSBjYW4g
bmV2ZXIgcmV1c2UgdGhpcyBibG9jayBhZ2FpbikuIA0KT3IgaWYgd2UgYWRkIGJsb2NrIEEgdG8g
am91cm5hbCBmaXJzdCBiZWZvcmUgYWRkaW5nIGJsb2NrIEIgYW5kIGVycm9yIGhhcHBlbnMgQWZ0
ZXIgYmxvY2sgQSBpcyBhZGRlZCBhbmQgYmVmb3JlIGJsb2NrIEIgaXMgYWRkZWQuICBUaGVuIHdl
IGhhdmUgdGhlIHBvaW50ZXIgcG9pbnRpbmcgdG8gYmxvY2sgQiBpbiBibG9jayBBIGFmdGVyIHBh
bmljLCBidXQgYmxvY2sgQiBkb2VzbuKAmXQgY29udGFpbiB2YWxpZCBjb250ZW50cy4gVGhlIHJl
c3VsdCBpcyB0aGF0IHdlIHdpbGwgaGl0IHByb2JsZW0gd2hlbiB2aXNpdGluZyBibG9jayBCIGFz
IGEgdmFsaWQgYnRyZWUgYmxvY2suDQoNCg0KPiBUaGF0J3Mgd2h5IHdlIGhhdmUgImVycm9ycz1j
b250aW51ZSIgaW4gbW9zdCBmaWxlc3lzdGVtcywgd2Ugc2hvdWxkIGFsd2F5cw0KPiBjb25zaWRl
ciB0aGUgYnVzaW5lc3MgY29udGludWl0eSBmaXJzdC4NCj4gQWxzbyB5b3UgY2FuIGxvb2sgYXQg
ZXh0NF9mcmVlX2Jsb2NrcygpIGZvciByZWZlcmVuY2UuDQoNCk9DRlMyIGRvZXNu4oCZdCBzdXBw
b3J0IEVSUk9SU19DT05ULCBvciB0byBzYXkgaXQganVzdCBpZ25vcmUgdGhhdCBvcHRpb24uICBO
byBtYXR0ZXIgRVJST1JTX0NPTlQgaXMgc3VwcG9ydGVkIG9yIG5vdCBieSBPQ0ZTMiwNClRoZSBr
ZXkgaXMgbm90IHRvIGxlYXZlIHRoZSBGUyBpbiBpbmNvbnNpc3RlbnQgc3RhdGUuDQoNCnRoYW5r
cywNCndlbmdhbmcNCg0K
