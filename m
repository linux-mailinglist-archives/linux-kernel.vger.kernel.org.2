Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E156403E38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbhIHROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:14:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19116 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352378AbhIHROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:14:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188GxgK4008821;
        Wed, 8 Sep 2021 17:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c5OPC/iclTaYDi4FiZalz24QVCbCAIaXz9zrbRxsYow=;
 b=ZlKmpRoxCpDTtrOkQQm/qNO1E2RknVkCRZUH0NLpT6AN1gslSX7raATkQ3y/MZHnWkLQ
 1rzg8Ll3dTV4uPAGOGHf1MhBnLTa7G3NegMs4Os8wCsUAycZQCMNYFRdl1YwoTlJcK2Z
 x1alas+XPNt15TPgS8WzWhTNP8TCdzPhbyO5OYmEOn+HOQ7MllsIVlj403lpg9IRdSZB
 1bocV1c9oqmytYDkwUk0dks68fifddmtBesN+dToFGbJlbtk5jvSvnZJGCFi7EARsV0k
 Jm0uRA8g9abR9W9zaFIC1hyBtl+5pIYz0HjHo/6CFSaXquPnmYvdRtrNx7FPHopbv6X3 Gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=c5OPC/iclTaYDi4FiZalz24QVCbCAIaXz9zrbRxsYow=;
 b=ya/HaRi63e1xB7x8BAg7vWa2XFJEELF7s0trn8OOR6B1SmgVzT7LvXDy+rTZRfimVwOo
 aKg5VZCcFmEkLEHWNjTy+dMiLuKI+l8jAatvp+yg9wOrX1S/4f+2Alo61g0a4p50joEp
 WzipsdUHZ3Wn3LJXjAOSJqp3Q67sTWgCNymL5wk57PONqmrTEeWuoXOWBVgez5ZGuBer
 E0JE/TdWZYMynUhssIdE5CmZvgaSslntLKp3+4BYcRpKmOQ+p10mLkXHI1oU38z9xMQX
 IM6I/35UfPr0sYzTZpAeWv9WFt8dzOtridhK5X0ALyJXMMOZkGaz0J3waK3XRJFWt8hT Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuqbdfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 17:13:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188HApeM012775;
        Wed, 8 Sep 2021 17:13:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3axcq1psk5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 17:13:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD2I2ZuQfiwrALaigDiIJoI6yx3fJYak1+KiYOE1jpxzjgy0VHtfoZgIE40kCW9x3VtixrD5xJfffwiI5WNtSYApDaWwAXBnUPYp6L1XMnDWWguhMFVotGr76AZb4YlU+dLg0VsbAx3DEIV3hnRrmpUfuW6T0f2nlr2uhY8WPFiz+GKrE3kt2c12MsBnwep0O7jHvfIbPp3DCGBqOu9HrZWUqWyrLK6PxWQf0tSHcf00DKUwToNNISphMTSvbfhROM2IvMVHUA4kQx9pxTwgjD83q2lvQZhXT71xml4DFwuP5s69loK7b/5UkqR+gJGPCBW3D+NDxbNJ0xKQbqebTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=c5OPC/iclTaYDi4FiZalz24QVCbCAIaXz9zrbRxsYow=;
 b=T/P+gOBShBJ6tvFCN4q5Hxhv9Su2Y0eddXOEvyvKGt1+VArbg2KZd7ZfcL0af4270T8Qh0KnIn4sZIYYzmtaVY4FnDdPlcC68jvvQXsIHqSRMQt36Kndp+wmsAtHUYslZVBue85xCXb+1ABWD3wW/K9TKZjVV5aNa34k1pj/VwPZbIJR720CdMy5benAqpWZkcppg2/aQLqinAz3vFfQlryveAfDm+5N4RpugjXxcF8vEN7/0uqUv7wWpAHNzm+yevmacUzEQDuCJlZQcDtoq5sjGT1ivgizz9DmalS1vs2Br/iWJUYmswPcAMxTl6oT5hqEZ1KgRsKw6653mDcZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5OPC/iclTaYDi4FiZalz24QVCbCAIaXz9zrbRxsYow=;
 b=HvWnAWsl3t9+6uLNQPcWZ4j6BhkZtryeNH8qZ31L5w+Ub1R3RQbiq4lRbHmm5KGPEBOVZoY+ZviS41IsflkWpiyJeI50KRTtdnAe0HIgY8lm8Nj8lhhnK7Ea3HzAOKlVzudfxZNo+WquUpTRkuCuNEmqB29D+7FhbQM2BDcR8A8=
Received: from SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 17:12:58 +0000
Received: from SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe]) by SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::64da:7ae6:af82:ebfe%5]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 17:12:58 +0000
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
Thread-Index: AQHXpJ+H0ttR42xfTUiCjMce85OD7KuaYEsA
Date:   Wed, 8 Sep 2021 17:12:58 +0000
Message-ID: <6018AF95-3613-4D43-A3E6-7BAA0E0BE009@oracle.com>
References: <20210908102055.10168-1-cymi20@fudan.edu.cn>
 <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
In-Reply-To: <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec2a3e7a-e5fb-43e0-515c-08d972ebe815
x-ms-traffictypediagnostic: SA2PR10MB4683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR10MB4683A31F05C8FAAA85C9F400CFD49@SA2PR10MB4683.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8nsx8j/LTaKC4EzmpphARPMi1+OQxyMYLB4T0qG98SRS7Yv+U10KAGZpX+0dHxr4cq0dLjyNRnWpCQXRrTK57g4WYBJE3t8CmCWFiaMlyHkIhkjicdLn/qWqytK0Y2+QPrWp/LUvJgTsTHenRY8IV5AiqmlsRlCwV05tm8GdoJZbiR5QR2JPMUIrjJgLFcuS4PVdYeaW2pIDbZ5wTcX7+bQFqTrn22llKI6huKEHvMT8v3R9Tu5QTzMbJopH+Qs5o03qHhXhKoDgn4Ll3bLEFFBV3WMMH56NU7lpquneaFgaQVoF9vt14amtRu5h4CqXkj/89Xz5wGaEY4ShnhKEXirvTP7qgy1yk1vZf7KFtign8u4e6CuQE8DLxLme6fkUYziM5vQMBF9j95jLEiVA7jp49jiaUS0m+Y8Ma/5hOLbxZ/62WEjgs2KKU83CWFS/XEVKkjQTvHKGtsG3xGaL4nA4EUEKtngem0C67neSdOSJU/HYAJ4DuRIhY3ld0GhiY7hYaFltMnWPzcXf6ZwND/RdcTah9hPVxYv36jlhl27rbp1nFVnyASGku7cACI2p7cQpfHG7xT7LtqDyJqezlDKi1rpX/eL1ANzKANshZe8orIOTk0R9Nj4PwbMocubZkZxKM72kAXegoAQBGv1+v0ZVQE781GbMeMRDd2CWncYfqzCcHKxzwYOPMJFlzKckH8/+PpzhGXRIKhCWLZmwr2tXLgZx/DKiXJLcIF8UphcPS2F6H9A4V/YwiX/fGqh1C3hhE4HeyPwm6pnyktqWisbFsqP8lB1122bkKTOiXNBu0kHkptyXR82LqEgQENgbKWOtjyuQTJ6dnsYVNcWHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2701.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(76116006)(83380400001)(91956017)(66476007)(2616005)(71200400001)(66946007)(38100700002)(107886003)(4326008)(66556008)(66446008)(316002)(6486002)(36756003)(6512007)(5660300002)(54906003)(53546011)(2906002)(6506007)(86362001)(122000001)(478600001)(38070700005)(8936002)(6916009)(8676002)(186003)(33656002)(966005)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmNqSWZrN2ZLYStLbzJHbCtvdEJkVlh3SDdQT3lPRnFDSWtIMlBZNks0OVlD?=
 =?utf-8?B?aWVXRW0xaUk0RXhJTW5CUlFVcWg5QW1IZUo4M2lSUm1lbXZlOFU5R0NTL0pz?=
 =?utf-8?B?YmVTTCthRnBMa1F4Z095cTlnZE5CWm83ZjhhMlhWSU5KRmZlNFdOTUNudTRT?=
 =?utf-8?B?MEFFUk50ejkwcm00SEJtbk9yN3dTVW1ORjliNU5hUGwrblNlTGxZMlFsSjlQ?=
 =?utf-8?B?R3hXb1ZSTFQrd2ZvbEptZHB0UUxxK2l5dHJsczlPQnJVTmlyYmRCZ2tIN1Rj?=
 =?utf-8?B?MkZncU5vUWdMaWk0UWc2cVV1MG1LLzU3TlZwUDkxL2ZCZDJvaURaY1BMMmJt?=
 =?utf-8?B?bHlKU3NiWnpUNnpkU0Vrc3VCTlVpTzZZdHNHcW9kNENLL0JYZVg2SnR4bmhE?=
 =?utf-8?B?RlFWSUUwbVNaWXp5ZitoSVYwdkpSYmxNUkhORi9lbnF1UGZFQXA2UnJEVHlS?=
 =?utf-8?B?SCtuZ3RVRG44YlU5VWtIR0FzM1RYTDU0Z3dQdE1aYmhvbFdxQ3pQSEJJdkJO?=
 =?utf-8?B?TUJaRk40Qk9wRmhOc2FwWkpxd0JyQytCOXVhTEtFNDNOY1hwc3g2eml3akZs?=
 =?utf-8?B?MGxvVEkzNHp2UHcwOFEzUitFN3JmTFlkZllEaldIaEVpclpyeko4SzdvMFcr?=
 =?utf-8?B?TElRSVVqSkpDTnNPVDU4SEFEbFJTeHlHZDVXMzNMaGxMM3p1dm5mOGIzdjBG?=
 =?utf-8?B?TkZjelpHUFZLbWtOWm5wZFN2N1JwYzMzemZhZXNBbG1vR0pXSDY4aWRtYW13?=
 =?utf-8?B?bHdTc1ZGMlpZNVRMcGY3QjNNV3BBQURmOXZuY2RXZHpxd2M5WmhWb1lPbHJW?=
 =?utf-8?B?bllzOTVTOEwzR3RTL091Y3A0TFR5WXdIdGpoVEc0Q3RKY3FNaUZ1eHp0RnQ0?=
 =?utf-8?B?TzE4Y3VYMFNYQWFEY3VrS2cxOVFQV0hDVFZ5dVlYdHhSRmw2WFpmdzBnRStU?=
 =?utf-8?B?WmwzUkhsbHpSS2NnMjN0eVZId093NnJTOVBOOGVWdnZGcVh0OXIyYkUrZGFH?=
 =?utf-8?B?WTNvYTJsUklqaDZ6VVJLc2puRk1FMVY2cFRDSUJRNE43TERZbFJQeVVWWjdq?=
 =?utf-8?B?MVJOWUk4cS9MSkozWWUvU09ZTDRlL0ZmZGpUQUNyMDQ5VmRYNUhOYVA2QXd6?=
 =?utf-8?B?QlRNRXBpblIyU1RmQk16UTlwQTJTZ2t5YzBQcFdDdFQxTHB1Wm1PV1UrWUVF?=
 =?utf-8?B?dGN1TWR0UGl3Z3AxSmJDNXBobzNTYnFvaW10SVdVS1BBaG1tdWM1M0RNUFdQ?=
 =?utf-8?B?dWJ5QlpkdFVhczRXbUlBR0wvQVZxU1lGblIyQk5TaEZ0WWpGWUVHZU5mc2J6?=
 =?utf-8?B?QVgxc3VrcHNQV0h4N2RNU2xEdG1FY04zNEhpUnlFQzgveFlQMUtiZEgwSFh1?=
 =?utf-8?B?eUR5Qm1sa3dScUZTNlg5b2EwY2NCbkZ0bzVkRVZISVZSenR3YXlieUpCSmVj?=
 =?utf-8?B?VmZQMHNyV1BFa09ibWt6OFF0MUZBZTkwM2duZE1TQVRnZVozZEROVGYvd0l6?=
 =?utf-8?B?TGVwNnFqaS9vZURrRjNlYTJsZG5TSFVic0Jsa1JWbERUUlNEVnlMMXpYQjhi?=
 =?utf-8?B?bkRSQ2dsQmtrcTczcXdGZmFaTHJQRm9rTHN0RlZYWmRDTm1Pa25YbW0rZnRn?=
 =?utf-8?B?SVpsM3dRSG5SSEVuL203eHNnZ2FsZS9renBKL0tOUmduL21ENXZKMFN6MjBG?=
 =?utf-8?B?Qkx5MnZFbVZSU2Ezc0FnMk1wNlRpTTFZUFZCd3BPelExdmVkdDhzL2hZSWIv?=
 =?utf-8?B?Yno2Z3ROTVNwQ2w3ZTJESmVLYnhINWJhTGtjbkx3aUdLNjQ2WVJJeHZGQWZI?=
 =?utf-8?Q?Vgjffhx1HZtkRm5CmmlkXT/cuzUT6b6jBkeSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6EEE8352475D44F82A1B5524EED7510@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2701.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2a3e7a-e5fb-43e0-515c-08d972ebe815
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 17:12:58.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTJYwBhFHzprL5N3VGic8meuvGW4276Rh+vZHHwFMh/pIluHEBr7wzGqKZe5OA2CLQNoWxETn4aICJ0xrzWtCQjW/VOPO4BlnDtmZwRe7JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080108
X-Proofpoint-ORIG-GUID: R3DkCw7DjbVLWoT1EjTVQQXXzhQrndAL
X-Proofpoint-GUID: R3DkCw7DjbVLWoT1EjTVQQXXzhQrndAL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClNvcnJ5IGZvciBsYXRlIGludm9sdmluZywgYnV0IHRoaXMgZG9lc27igJl0IGxvb2sg
cmlnaHQgdG8gbWUuDQoNCj4gT24gU2VwIDgsIDIwMjEsIGF0IDM6NTEgQU0sIEpvc2VwaCBRaSA8
am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gOS84
LzIxIDY6MjAgUE0sIENoZW55dWFuIE1pIHdyb3RlOg0KPj4gVGhlIHJlZmVyZW5jZSBjb3VudGlu
ZyBpc3N1ZSBoYXBwZW5zIGluIHR3byBleGNlcHRpb24gaGFuZGxpbmcgcGF0aHMNCj4+IG9mIG9j
ZnMyX3JlcGxheV90cnVuY2F0ZV9yZWNvcmRzKCkuIFdoZW4gZXhlY3V0aW5nIHRoZXNlIHR3byBl
eGNlcHRpb24NCj4+IGhhbmRsaW5nIHBhdGhzLCB0aGUgZnVuY3Rpb24gZm9yZ2V0cyB0byBkZWNy
ZWFzZSB0aGUgcmVmY291bnQgb2YgaGFuZGxlDQo+PiBpbmNyZWFzZWQgYnkgb2NmczJfc3RhcnRf
dHJhbnMoKSwgY2F1c2luZyBhIHJlZmNvdW50IGxlYWsuDQo+PiANCj4+IEZpeCB0aGlzIGlzc3Vl
IGJ5IHVzaW5nIG9jZnMyX2NvbW1pdF90cmFucygpIHRvIGRlY3JlYXNlIHRoZSByZWZjb3VudA0K
Pj4gb2YgaGFuZGxlIGluIHR3byBoYW5kbGluZyBwYXRocy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1i
eTogQ2hlbnl1YW4gTWkgPGN5bWkyMEBmdWRhbi5lZHUuY24+DQo+PiBTaWduZWQtb2ZmLWJ5OiBY
aXl1IFlhbmcgPHhpeXV5YW5nMTlAZnVkYW4uZWR1LmNuPg0KPj4gU2lnbmVkLW9mZi1ieTogWGlu
IFRhbiA8dGFueGluLmN0ZkBnbWFpbC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogSm9zZXBoIFFp
IDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+DQo+PiAtLS0NCj4+IGZzL29jZnMyL2FsbG9j
LmMgfCAyICsrDQo+PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9mcy9vY2ZzMi9hbGxvYy5jIGIvZnMvb2NmczIvYWxsb2MuYw0KPj4gaW5kZXgg
ZjFjYzgyNThkMzRhLi5iMDVmZGU3ZWRjM2EgMTAwNjQ0DQo+PiAtLS0gYS9mcy9vY2ZzMi9hbGxv
Yy5jDQo+PiArKysgYi9mcy9vY2ZzMi9hbGxvYy5jDQo+PiBAQCAtNTk0MCw2ICs1OTQwLDcgQEAg
c3RhdGljIGludCBvY2ZzMl9yZXBsYXlfdHJ1bmNhdGVfcmVjb3JkcyhzdHJ1Y3Qgb2NmczJfc3Vw
ZXIgKm9zYiwNCj4+IAkJc3RhdHVzID0gb2NmczJfam91cm5hbF9hY2Nlc3NfZGkoaGFuZGxlLCBJ
Tk9ERV9DQUNIRSh0bF9pbm9kZSksIHRsX2JoLA0KPj4gCQkJCQkJIE9DRlMyX0pPVVJOQUxfQUND
RVNTX1dSSVRFKTsNCj4+IAkJaWYgKHN0YXR1cyA8IDApIHsNCj4+ICsJCQlvY2ZzMl9jb21taXRf
dHJhbnMob3NiLCBoYW5kbGUpOw0KPj4gCQkJbWxvZ19lcnJubyhzdGF0dXMpOw0KPj4gCQkJZ290
byBiYWlsOw0KPj4gCQl9DQo+PiBAQCAtNTk2NCw2ICs1OTY1LDcgQEAgc3RhdGljIGludCBvY2Zz
Ml9yZXBsYXlfdHJ1bmNhdGVfcmVjb3JkcyhzdHJ1Y3Qgb2NmczJfc3VwZXIgKm9zYiwNCj4+IAkJ
CQkJCSAgICAgZGF0YV9hbGxvY19iaCwgc3RhcnRfYmxrLA0KPj4gCQkJCQkJICAgICBudW1fY2x1
c3RlcnMpOw0KPj4gCQkJaWYgKHN0YXR1cyA8IDApIHsNCj4+ICsJCQkJb2NmczJfY29tbWl0X3Ry
YW5zKG9zYiwgaGFuZGxlKTsNCg0KQXMgYSB0cmFuc2FjdGlvbiwgc3R1ZmYgZXhwZWN0ZWQgdG8g
YmUgaW4gdGhlIHNhbWUgaGFuZGxlIHNob3VsZCBiZSB0cmVhdGVkIGFzIGF0b21pYy4NCkhlcmUg
dGhlIHN0dWZmIGluY2x1ZGVzIHRoZSB0bF9iaCBhbmQgb3RoZXIgbWV0YWRhdGEgYmxvY2sgd2hp
Y2ggd2lsbCBiZSBtb2RpZmllZCBpbiBvY2ZzMl9mcmVlX2NsdXN0ZXJzKCkuDQpDb21pbmcgaGVy
ZSwgc29tZSBvZiByZWxhdGVkIG1ldGEgYmxvY2tzIG1heSBiZSBpbiB0aGUgaGFuZGxlIGJ1dCBv
dGhlcnMgYXJlIG5vdCBkdWUgdG8gdGhlIGVycm9yIGhhcHBlbmVkLg0KSWYgeW91IGRvIGEgY29t
bWl0LCBwYXJ0aWFsIG1ldGEgYmxvY2tzIGFyZSBjb21taXR0ZWQgdG8gbG9nLiDigJQgdGhhdCBi
cmVha3MgdGhlIGF0b21pYyBpZGVhLCBpdCB3aWxsIGNhdXNlIEZTIGluY29uc2lzdGVuY3kuDQpT
byB3aGF04oCZcyByZWFzb24geW91IHdhbnQgdG8gY29tbWl0IHRoZSBtZXRhIGJsb2NrIGNoYW5n
ZXMsIHdoaWNoIGlzIG5vdCBhbGwgb2YgZXhwZWN0ZWQsIGluIHRoaXMgaGFuZGxlIHRvIGpvdXJu
YWwgbG9nPw0KDQpEbyB5b3UgcmVhbGx5IHNlZSBhIGhpdCBvbiB0aGUgZmFpbHVyZT8gb3IganVz
dCB5b3UgZGV0ZWN0ZWQgdGhlIHJlZmNvdW50IGxlYWsgYnkgY29kZSByZXZpZXc/DQoNCllvdSBt
YXkgd2FudCB0byBsb29rIGF0IG9jZnMyX2pvdXJuYWxfZGlydHkoKSBmb3IgdGhlIGVycm9yIGhh
bmRsaW5nIHBhcnQuDQoNCnRoYW5rcywNCndlbmdhbmcNCg0KDQo+PiAJCQkJbWxvZ19lcnJubyhz
dGF0dXMpOw0KPj4gCQkJCWdvdG8gYmFpbDsNCj4+IAkJCX0NCj4+IA0KPiANCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gT2NmczItZGV2ZWwgbWFp
bGluZyBsaXN0DQo+IE9jZnMyLWRldmVsQG9zcy5vcmFjbGUuY29tDQo+IGh0dHBzOi8vb3NzLm9y
YWNsZS5jb20vbWFpbG1hbi9saXN0aW5mby9vY2ZzMi1kZXZlbA0KDQo=
