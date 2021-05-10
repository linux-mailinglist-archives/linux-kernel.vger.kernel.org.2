Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA237930A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhEJPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:52:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46234 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhEJPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:52:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AFo0p1184950;
        Mon, 10 May 2021 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4DuTaM4My8ywEaxMr3hix5tSvexauWjIL1HMCoDf3ns=;
 b=owqEarYzITUP7vLrDj3SyzcOL92Hyo/2HxQcEzBiyKeMCniob0i+5rtCmPZw7QhZRo4X
 oiJ4zJgQqm9jb9TwELl5E0R/yPzlTP6p+Z/JuwKVwYrj/MDpr1zWFXXPedRgyLKEX3tA
 zbFF8aEiLZoLB5bn4W8o7xx260wMk/PqeNCsJ0CeOk8Y+W4rtL/wMayUc6i6a6Blhp89
 z8hVLf+zijaV2j3fN7ODzi7ZJ+9TIba31p7fH1snCXEE0GgcQ7B7bDjgYd0sq0Fk6iKq
 PHnJKxiwSy3DirReE52mvQfaoh1f/V430KfjtKY12kb70rvnkTpkEvEHa69ad0+Pii07 WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38e285b072-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 15:50:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AFVXJ7102036;
        Mon, 10 May 2021 15:50:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 38dfrvnaep-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 15:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGwK1NdWIKPs4eA8UAk0dj810yct0kUCbkIUdepL6t4pLYQ/20X8U60qpFzVgoWsV4ZZiZhk0fDufHF1osexdVXmfCzyjM/NETVFj4bo368ZBqRkaDTbyKTR/m5UQbRkrWm6PZr8ucM/Pyzuaj0ItzEbShAFTYX3JQsiN7/cOMzFjJiR70abs/MMEf1Sq/Q0EmJc250Qi49kYeBF1fX06vykOG5p2ytswtzmOw4/AJG4QTZ41vmPgtu0BcQETaWaqdpvEq7Hd62mBAfej2Db0QzzasZqpqtnaK1Zq/da2XaBlVTBGFIU4YMqlnELUcnCk1wMuvsVlcrguk0r9ko/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DuTaM4My8ywEaxMr3hix5tSvexauWjIL1HMCoDf3ns=;
 b=YDQHC0sFVn8v/ybGzaiv94ajOnmImehDsmS4EE08LjlSfQOgW1jEuUXIxWS9cX/3Y+HsPmWoJe1B7Fe4XX7kFd/Y5AGNZKT27KFdmM8QRlXLqe4j4mMwMJSIqrBbFLJjIFzWx4JuxuMwI9EwHFoDJHyQWtTcAfQrW7emUV2q4+ATHcqiM9p01bS8ZtMFDWzR4vutPhXRorGfM/dero4bNOgggQcvOTF4n/xrIVv6wLgrlUOaF134bZpp1XeWQoTEMJgSb9Mepazgbei+d8OqgsB21Jhc+XUz4xuhZ5v5RbuQqImSowdn3MmJM9g01XuvPlxN2VgbNLv/WGrmqYCAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DuTaM4My8ywEaxMr3hix5tSvexauWjIL1HMCoDf3ns=;
 b=v1z7DAg2sr0oOobGxWoZgKZKnHzEExnDhh3Xio/qU2HKuZ/FRtK6+VZkPxKoa+inGsWIeWsMufTseZO0QAsqsKqid4l5FLzaQcP0lGQcXB1n8NlGMhL4OA+0a3P2j8uwVSeseFaBWM4dy2LfLZJmJ/4hf6ranPTMbj9lRF9VwlM=
Received: from SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 by SN6PR10MB2766.namprd10.prod.outlook.com (2603:10b6:805:46::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 15:50:46 +0000
Received: from SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::459d:9552:66ce:5b44]) by SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::459d:9552:66ce:5b44%3]) with mapi id 15.20.4108.032; Mon, 10 May 2021
 15:50:46 +0000
From:   Wengang Wang <wen.gang.wang@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     "mark@fasheh.com" <mark@fasheh.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: Reomve err less than zero check
Thread-Topic: [Ocfs2-devel] [PATCH v2] ocfs2: Reomve err less than zero check
Thread-Index: AQHXRYkPxMPQNbSFOEK6538DsP9rzKrc3WkA
Date:   Mon, 10 May 2021 15:50:46 +0000
Message-ID: <1EED85DE-EFE1-4FBA-9AA5-648D8E586DD9@oracle.com>
References: <1620643062-124920-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1620643062-124920-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [71.198.166.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df2ca04a-6acb-4d08-371c-08d913cb6092
x-ms-traffictypediagnostic: SN6PR10MB2766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR10MB2766BAFE59622DB6AC5B88B5CF549@SN6PR10MB2766.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tdvK+3XNIh0kSoD7RrJsZSFCdKeg18CPSvFOWl+K8hc2wK2xxm91xD4fa0QmTx7QIvRJYESavn0W+ghm3bumchA+8xkwGWQswenEtf2/EeFafADMQ9rlaDABBhHKdADiHiD4NuojObcLAHC2GFQWvpn2On25L1sdJCFm99xD0qTFW2jVWv3O/RhGmS7ZHVnMFZXt8i1LN/dmf7UgjreCn9uilwLOXJM9GApHGk7ID1FoLuaQsbgJSQnw8MoLP1MDltLMGOpR5ero7wYF1mQUFstO3SUvmQ7E4kPD6FYcc+FejF/OB+exVlPbg8YgDw4cSdGo06vwMEZEe7fQFllDH+4DbJ8qgrxzEw1e1sOPb/YI9z/0U16WIq8/EwtnV+padZSch/KPGNxHUftlRvixnO8F3q7m0UxWoUC8ooe14rYdHBHjOfy9dGDm/vKd9K5vGMZXAPHCTU1XWco8+qAw3g1VUe14RHV0sHoRlsSzY7leSZh4qNCRO5rMZ0flPjwLrcvqKShjJndwhUS2/05wKtLRgOnbmDnfkJ4nCft9HjeoUgtpjCBsVaLDSgVoFRDi8xragKFS51YrdHq1FONLkJ77tIaqpYMnvKRxZgZjf2Hvt2XZF9T7azIa2fA12KUSNjYnw+EnHBL6eD1Q/79jXYASBvQdumI5bKkeBfoF4aMZnOlGtaMdE7VKw7JR2sUVfjX0mrS4vvbUiPZQOWzYOCFluNN2NeFGGfsTdv/6QLWQUH6nBaFm9GC6k/Ycuxx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2701.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(136003)(366004)(71200400001)(66476007)(66946007)(66556008)(2616005)(64756008)(66446008)(36756003)(76116006)(54906003)(8936002)(4326008)(83380400001)(8676002)(316002)(6916009)(33656002)(53546011)(186003)(26005)(478600001)(86362001)(966005)(38100700002)(6506007)(122000001)(5660300002)(6486002)(6512007)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VmY4WDg0YVVDVWxkem5Xbk5qVlJCb1lLMjY4SEIvZVEzcDJNbjdzaUNxV2pP?=
 =?utf-8?B?aCtsNWVjNkt5emZEaTdNZUYxcjVQOFF2YThJT0prMnNWTDRuYzMrZGNza3VW?=
 =?utf-8?B?UWk3bHBGb0tjRDJIMXVYOCszT0hpTmpadWw5NmowTi9QSWt5c2pKajNITUww?=
 =?utf-8?B?WS92ZE4ydkRpUDdrTlZOWUdxN1M0dE0xYzBHeXBEdEx2cFp0QmdUajk3ckhm?=
 =?utf-8?B?WXBQRFlOQ1A1MjdselQ4QVVzVjZHN0dsbSt0Z0VzRXBPYWdPSHNQNWZzenF4?=
 =?utf-8?B?SW1INDdGVlkwTURXOUtYaVMyU2piTG9pTzlGOWx0azhncjFrSUhqTFFyWXZk?=
 =?utf-8?B?cm5WaytzQVNFYVJFTkx0cVl4YWJnM01JOWY0cUtDMEsyMnAya0g3eFUrSmpj?=
 =?utf-8?B?dUozNkFsd2RJdjBZZXMzbTcweGlIcTRJd1B2RjFkc2FiUWM3S01TaHdwbkc0?=
 =?utf-8?B?UTJ6NE4zUGdrRkMvaEJDL3ZhUGFzWWlHWUVpZVk2bldZY1ZzbzN0QlZ5bEdX?=
 =?utf-8?B?UXh5QU5OUkRLU1krYmpnR2RvaGNyQWxVSlZCM2xoajg2N0xkOERSUnFZMmda?=
 =?utf-8?B?eHhka3V4NE15NjBkWHBVY08zbFhhbGIwVTdnaGhxY3FtQ0hhdGlRKzBGbGZK?=
 =?utf-8?B?QVBsWENqaGp2L3ZEc3FYQmdJYnplVGZhK2dhQTFpZVorUG5DQmlOcFhrV2ZQ?=
 =?utf-8?B?a2JGMTZ4V3huN1JiemVLa2JvWXd1aUduSlJjbmJ0eTdxYUQ3ejNaK2IzMndQ?=
 =?utf-8?B?bFVUTEVFVENacVV2L01wckxOTDRrTnE0MjVOdnJYYXc0V2lISE5qYlFCZ09q?=
 =?utf-8?B?VTdPdlE0ZkZlNllEU3ptZ29uZTZBMjVtd3kvaDdvWnVzaFlZLy9nQXRnaFFH?=
 =?utf-8?B?c2tGanE4YktaSERiRUZ3T1dXVlV3RDFDQTRHYi91MUtwRVdYTHdrcDhJR2tY?=
 =?utf-8?B?NGN5bzVCVFdjQVA0cTNWK1htVkplRnNTVVZmUWxWaUxvV1FGb1ZENEhIKzRR?=
 =?utf-8?B?OFpNVlNWUHo0T1hpcW02YzZxWWkyYnNzMUxLenM4NE1yODVTeE1BZWFGazNT?=
 =?utf-8?B?OEorQ2hhbE5SYWE0RHZjWG1FTjRwbXRjOUNlV1czaE9aTFVEaDJCVXRqL2FM?=
 =?utf-8?B?b0tjSTFXMTR3VEY1cThlZDRYSk5BbVp0U1IyVkl2eGFxdVR3VTVDVTd6aUVy?=
 =?utf-8?B?bWVRd25Bc3pwT2JYdzVUS2pYVmlDZGM5ZFN0NkxEUmI2UDNGMHl1bkRMRmFG?=
 =?utf-8?B?OXhBK0JjNzV2WlBMZEV5ZGJFKytndU51V2JGUjdZMW5oR3RjS1dVLzBQenk3?=
 =?utf-8?B?NXBLZ01WYlF3OHFEeHpFR2VWUDFIUDJSUzB3UnpUd3FzWFlGSSsrSzU0UFdZ?=
 =?utf-8?B?QWJSUEFiSEE2bjRHRktNeXUwZ1RmUXRVZTNrN2VOSnJ4VzkwWUJQODFHU3ZE?=
 =?utf-8?B?RHhhaWd2UlJTdVQyL2JvQ3lMUldYZUJlT0ZZT0s1cmxEYVRpR1lpVkpaYnRu?=
 =?utf-8?B?ZFA3WFoxb1FOWFBkc0xWdjFnb2ZwQnJId2tkczdzajhVemFDSGc0VWE5K0Fx?=
 =?utf-8?B?YWlmODhmbmZZSWhlM0x3ZTlwMEdnWUdzZ2hJT1VtaDNnZUpzTGtiN0FqL1lh?=
 =?utf-8?B?TVZlQVZNcFdkMDJDdDJiUFhNWlFnTSs4dGhGbVdnaVg1dzJVTWFDeTVLNUxT?=
 =?utf-8?B?Sll1VC90RGlrVTRSYW96QWZMQWlBOVhRNVZHQnA3NVdRekgyV3dJV3J3Y1BL?=
 =?utf-8?Q?/KjJTnzWt1NY2id6ptrD4AhzWYypaJGYPOHNDjk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D47CC74CFA872C49ACFD742C65B6D700@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2701.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2ca04a-6acb-4d08-371c-08d913cb6092
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 15:50:46.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7utcMz2CYi2GaiZ5ZH42YV93vtJWt13SnfNLT5vSWndUubNbSAcj9HttJrkq3gJKM/AMK5TOghb4cm5+26ekTDGVGyHdqZnQmgx0RN4uNRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2766
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100110
X-Proofpoint-GUID: -pWBa305qOV4X1noDuTUYkc5YbTXniOS
X-Proofpoint-ORIG-GUID: -pWBa305qOV4X1noDuTUYkc5YbTXniOS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlhcGVuZywNCg0KVGhvdWdoIHRoZSB0eXBlIG9mIGVudW0gZGxtX3N0YXR1cyBoYXMgYSB2
YWx1ZSByYW5nZSBzdGFydGluZyBmcm9tIHplcm8sICBJdCBjYW4gYmUgYXNzaWduZWQgd2l0aCBu
ZWdhdGl2ZSB2YWx1ZXMgd2l0aG91dCB3YXJuaW5ncy4NCkkgYW0gd29uZGVyaW5nIHdoeSB5b3Ug
YXJlIHN1cmUgaXQgY2Fu4oCZdCBiZSBuZWdhdGl2ZT8gIFlvdSB3ZW50IG92ZXIgYWxsIHRoZSBj
YWxsaW5nIHBhdGggYW5kIHNvIHlvdSBhcmUgc3VyZSBpdCBjYW7igJl0IGJlIG5lZ2F0aXZlPw0K
SWYgeW91IGRpZCB0aGF0LCBJ4oCZZCB0aGluay9ndWVzcyB5b3Ugc2hvdWxkIGFsc28gYmUgYWJs
ZSB0byBzYXkgaXQgY2Fu4oCZdCBiZSBETE1fTUFYU1RBVFMgb3IgYmlnZ2VyLCByaWdodD8gSWYg
bm90LCB3aGljaCBjYWxsaW5nIHBhdGggYXJlIHJldHVybmluZyA+PSBETE1fTUFYU1RBVFMgdmFs
dWU/DQp3ZSBzaG91bGQgZml4IHRoYXQgdG9vLg0KDQpJ4oCZZCB0aGluayB3ZSBzaG91bGQgdHJl
YXQgdGhlIHR3byBjb25kaXRpb25zIG9mIChlcnIgPj0gRExNX01BWFNUQVRTKSBhbmQgdGhlIChl
cnIgPCAwKSB0aGUgc2FtZSB3YXkuICBJZiBrZWVwLCBrZWVwIGJvdGguIGlmIHJlbW92ZSwgcmVt
b3ZlIGJvdGguDQpJ4oCZbSBzdXNwZWN0aW5nIHRoZSBjb2NjaWNoZWNrIHdhcm5pbmcgaXMgYmFz
ZWQgb24gdGhlIHR5cGUgb2YgZW51bSAoc3RhcnRpbmcgd2l0aCAwKSwgYnV0IGlmIHRoYXTigJlz
IHRoZSBvbmx5IHRoZW9yeSB0byByZW1vdmUgKGVyciA8IDApLCBJdOKAmXMgTkFLIGZyb20gbWUu
DQoNCnRoYW5rcywNCndlbmdhbmcNCg0KPiBPbiBNYXkgMTAsIDIwMjEsIGF0IDM6MzcgQU0sIEpp
YXBlbmcgQ2hvbmcgPGppYXBlbmcuY2hvbmdAbGludXguYWxpYmFiYS5jb20+IHdyb3RlOg0KPiAN
Cj4gQmVjYXVzZSBlbnVtIGRsbV9zdGF0dXMgc3RhcnRzIGZyb20gMCwgdGhlIGNoZWNrIGZvciBl
cnIgPCAwIGlzIGFsd2F5cw0KPiBmYWxzZS4NCj4gDQo+IENsZWFuIHVwIHRoZSBmb2xsb3dpbmcg
Y29jY2ljaGVjayB3YXJuaW5nOg0KPiANCj4gZnMvb2NmczIvZGxtL2RsbWRlYnVnLmM6MjIyIGRs
bV9lcnJuYW1lKCkgd2FybjogdW5zaWduZWQgJ2VycicgaXMgbmV2ZXINCj4gbGVzcyB0aGFuIHpl
cm8uDQo+IA0KPiBmcy9vY2ZzMi9kbG0vZGxtZGVidWcuYzoyMTQgZGxtX2Vycm1zZygpIHdhcm46
IHVuc2lnbmVkICdlcnInIGlzIG5ldmVyDQo+IGxlc3MgdGhhbiB6ZXJvLg0KPiANCj4gUmVwb3J0
ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSmlhcGVuZyBDaG9uZyA8amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4NCj4g
LS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAtVXBkYXRlIGNvbW1pdCBsb2cuDQo+IA0KPiBmcy9v
Y2ZzMi9kbG0vZGxtZGVidWcuYyB8IDQgKystLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL29jZnMyL2RsbS9k
bG1kZWJ1Zy5jIGIvZnMvb2NmczIvZGxtL2RsbWRlYnVnLmMNCj4gaW5kZXggZDQ0MmNmNS4uODE3
OTE0ZCAxMDA2NDQNCj4gLS0tIGEvZnMvb2NmczIvZGxtL2RsbWRlYnVnLmMNCj4gKysrIGIvZnMv
b2NmczIvZGxtL2RsbWRlYnVnLmMNCj4gQEAgLTIxMSw3ICsyMTEsNyBAQCB2b2lkIGRsbV9wcmlu
dF9vbmVfbG9jayhzdHJ1Y3QgZGxtX2xvY2sgKmxvY2tpZCkNCj4gDQo+IGNvbnN0IGNoYXIgKmRs
bV9lcnJtc2coZW51bSBkbG1fc3RhdHVzIGVycikNCj4gew0KPiAtCWlmIChlcnIgPj0gRExNX01B
WFNUQVRTIHx8IGVyciA8IDApDQo+ICsJaWYgKGVyciA+PSBETE1fTUFYU1RBVFMpDQo+IAkJcmV0
dXJuIGRsbV9lcnJtc2dzW0RMTV9NQVhTVEFUU107DQo+IAlyZXR1cm4gZGxtX2Vycm1zZ3NbZXJy
XTsNCj4gfQ0KPiBAQCAtMjE5LDcgKzIxOSw3IEBAIGNvbnN0IGNoYXIgKmRsbV9lcnJtc2coZW51
bSBkbG1fc3RhdHVzIGVycikNCj4gDQo+IGNvbnN0IGNoYXIgKmRsbV9lcnJuYW1lKGVudW0gZGxt
X3N0YXR1cyBlcnIpDQo+IHsNCj4gLQlpZiAoZXJyID49IERMTV9NQVhTVEFUUyB8fCBlcnIgPCAw
KQ0KPiArCWlmIChlcnIgPj0gRExNX01BWFNUQVRTKQ0KPiAJCXJldHVybiBkbG1fZXJybmFtZXNb
RExNX01BWFNUQVRTXTsNCj4gCXJldHVybiBkbG1fZXJybmFtZXNbZXJyXTsNCj4gfQ0KPiAtLSAN
Cj4gMS44LjMuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IE9jZnMyLWRldmVsIG1haWxpbmcgbGlzdA0KPiBPY2ZzMi1kZXZlbEBv
c3Mub3JhY2xlLmNvbQ0KPiBodHRwczovL29zcy5vcmFjbGUuY29tL21haWxtYW4vbGlzdGluZm8v
b2NmczItZGV2ZWwNCg0K
