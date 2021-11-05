Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE114466DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhKEQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:21:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38570 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhKEQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:20:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5Ft6iM003132;
        Fri, 5 Nov 2021 16:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LiMl7+frWKHnuo2d/R6WXCSNAcHWPM+ltuzefmlKNfc=;
 b=aq62snMYE2etkHoxjezcfMRHuSkO4YtnPNTyyVljEq8DfnOkJlJla/z2ZawK+qHzgNGP
 g4ugHlUjtFRLDPhDI4R8cZuaDemaVzhQ1rqk6UApyj7RsDPQahm+8EfR9oyeNUUNzmzO
 +a/pU3DqU3w1lcAjaxfatjk16GMUDOB/ubJF/DT4w3pG3iGz9IknGj778/mGlOLJGc4N
 RHMd67XgyKeGvKrBEPp6OS20Jvao8/qKCuofwLvYPbW7RSq2nW0yqopUpBM3EgjEmwbi
 NCcwpCLApg4xx6sIcYzeR9sHgT8d1R3K5YPGrn1xWkQj3yhBd9pWHWdXoBDbNm4QRT4+ Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7buamw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 16:18:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5GFBu0029980;
        Fri, 5 Nov 2021 16:18:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3c4t5d64u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 16:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfPrqavTv6IeB0MC+5bUKlPfAD84siAkIbZBQcHuRLkii5f2QaUf+yAiQPOewLUqYKaq/DvF8tmjdrVCvfP6RHu8Lx65kpMU1BMIDrjFmomM+mNgZlU5axCnxGG6jYdIjJ3nd1fkioL4r8Wb1XYJlj5t4GECUA2fSDROXzJ4JkM/gmKnl7lIwd2skx01CjHr8d1d/Miq1gtZ1Ghu/D86VWTGrWRCwB+M8p4jpVHZMKpNkQQtEzbsWnSo1SYMDvsM/88qg6HUN2a+510KqB9JlScGZBkkb0WseOz3qT7n824jiDy2nRc9yqFta9gb2kkY/ikCEbLUHIDe8zFbBD/ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiMl7+frWKHnuo2d/R6WXCSNAcHWPM+ltuzefmlKNfc=;
 b=Ma8mPvw5Yrc5Ea56XFB6eEM08pKAckVHKoEPpwNAipQbSFyWHHdG7Taqjklx8sK3JE7BAE0DU4gNUgNLMke9N3Dc6nLiFTpF8ASWfLDbuVqPnfeHYgmSluE7vTS0q1O1FULUH8LbRtEA71MLwmUDuOE9UpRlMAMBtX2ehg4rN/Z5I494kpevhjfJet9QkjaOTr57U7eWD726721tj+WQ/5y1FSJib9kY94yXJZOcOzaTp1ZaSndVnwaHDdM8kIamfxn+8jVQnWarHS3dpbHv3RYzU/OFWbpcqavUBSmXU/FCySTZeB9bXXPoiNAdN/yhWdiRn0QVjqeHTE0knqW4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiMl7+frWKHnuo2d/R6WXCSNAcHWPM+ltuzefmlKNfc=;
 b=LowBmzP6DlGNoJl4XBJg2JXe5XiuF1akaX/0Rs8kcTkrB0hs0RIWsK5c//iUJXmobvlg/1gqCzgjokQEE20H8cy35rgHUnoy2b79VVPVvA4T45RtiKsuJ3ZfE0u2reNIB5XmrzCJ2j1eVSDC+eourjnYKrbCaLyE7EQUY+YerEw=
Received: from BYAPR10MB3270.namprd10.prod.outlook.com (2603:10b6:a03:159::25)
 by BYAPR10MB3605.namprd10.prod.outlook.com (2603:10b6:a03:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 16:17:59 +0000
Received: from BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::715c:4853:52ce:dd7e]) by BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::715c:4853:52ce:dd7e%5]) with mapi id 15.20.4649.020; Fri, 5 Nov 2021
 16:17:59 +0000
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        "soc@kernel.org" <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: fix wkup_m3_rproc_boot_thread return type
Thread-Topic: [PATCH] soc: ti: fix wkup_m3_rproc_boot_thread return type
Thread-Index: AQHX0mCzyDluYOvIlUuUPwqCbkMc2A==
Date:   Fri, 5 Nov 2021 16:17:59 +0000
Message-ID: <7A4FCE6D-292C-4E04-BAF2-03C85E94ABDF@oracle.com>
References: <20211105075119.2327190-1-arnd@kernel.org>
In-Reply-To: <20211105075119.2327190-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: febe80b7-d039-4154-72de-08d9a077d5ba
x-ms-traffictypediagnostic: BYAPR10MB3605:
x-microsoft-antispam-prvs: <BYAPR10MB36056D748E88BB90B71D5781938E9@BYAPR10MB3605.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21+wD6RDi3gzSkSExHF7bD8EgdMOTI96rzBIUtQsDliz8e4BykC3sQ7YGTq77BbZsWQjdMPBGJ4inIZBgYBI5T3MIH3yDuBNSVeHIv4za9xWUOI9i0gu39O0Gt+ATzTKGPw+woyz9MAvzmG+n5puJwDlSn4f2Eo53zzGwmeQ3S1TIj4hN2/0SfMZYnCjqSYLpxUJUblnRohWRaCWPxT+3ps44US/Vm0n9YqYWrdzRXN3sxQ/VYJJ0KSYFTxkpCnWSy5NRxrgdTCBYwB5ppHJfD+CWNx8T6DELbuME6qU4E1oDJrygfNtqVK4DiQRQGjLVk21/EidUjLaFDf1zVlXGjknho9I23NGFQIVxCAcI+cyAhXBvrsyEMs72XPYhm7RFgBBYQmIery2eixHJB8m4HYDcUxm6eD+ztdy0PrlmPJk1oA4hoQBgvpFPeDtl1fOhU3IMLogBGOn2S/3hBvPOydOTrE5+DlFo3HXHvonddFzHE8c91mXWK/KZsnHGFbNoI/FBthCZwxg87MXao6MeFaEZ9F/eg6L8BIKzv4iOmE+eG3r0GWc+VQmekOCaAxAep4KjIpcvnPM9iisCgUCfVm+rLQmioYwABQkwPRuyClFx5EvMZhan0jmBIYP5+JpgnNCGt64oLvNfvLsD0Nv8aheG+4A6Zk4C+woQLN+afbKhKRgNKXUl8NmfRMvDOSr6DcHULSnqtqJcOvYcgxWMqHPyc/yv8hS8pW3mTY1jbzyNCA1ePR9578UBD+ncD90
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(71200400001)(122000001)(66946007)(53546011)(86362001)(4326008)(6486002)(26005)(6512007)(66476007)(33656002)(66446008)(64756008)(76116006)(2906002)(8676002)(38100700002)(8936002)(4744005)(91956017)(5660300002)(186003)(66556008)(7416002)(36756003)(6916009)(44832011)(2616005)(38070700005)(54906003)(316002)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGZZWTZMbThHUWlqOHJIeDAxUGI1dGwyNlZDbUF6YTFBMVZUZVZhRklyMVJT?=
 =?utf-8?B?dnUvdmpwSU5TbjlIZGhudnpTeHpnYWR1bzVjbEcrTFhMcVdmRnczUXloTmdY?=
 =?utf-8?B?ZXN6d2libjdDWlBWazIxdnZPZjFrNml1S29TVUd3cWJmeEhxS251bERYT0Vu?=
 =?utf-8?B?aTZiUklGc0JSS3ZQOUI2Y0dXcngxNG81K3BkcnM4Z3Nwa1VDTy9rdDZtNXA2?=
 =?utf-8?B?elJoVUN6aWR5dXk0TVRma0lSRjJnS1lnOEhUYXd2b2FUVVpBZys5OExmK2cy?=
 =?utf-8?B?cmdMcEIwMkRid09VU3NGa2xpSS9XbUhhTWRiazVKR3JjUlJhdWJrSzV1Znk2?=
 =?utf-8?B?U3JZQ3dDMVVXcmRTL0w1VmI2K0pIL285WDJUNXJ2Smw2TE1RdlpvMWZJR0Jk?=
 =?utf-8?B?Sk80NGtTbjhrSVUxQjFvNFcxTGJodjhTK3FmWFpHR2pXbER1emxJMGNOSjVF?=
 =?utf-8?B?TW1jRlVsdlBhSXAxeWpRNS8xenVPdEJ2UGlKenRDZGIydjQrYmRhU3o2UkJC?=
 =?utf-8?B?eWZ6elFiWTU2Skx2dlJ0MFpjdGNiZWxOZ2xyNmZHTHdhSmNuaXdqeVRRQVdM?=
 =?utf-8?B?MWR2Z1h4VjhzdWhCWTIzTmlua1VvN3pIZHdXcVN5Z0xWV3cyRXM3a01XTGJn?=
 =?utf-8?B?ODRCL094Q3UzdVJUb0R5SzhGODJvNDNNQnZPRm5WRis0MUZHcW1hQng0aW14?=
 =?utf-8?B?L3MrNDJUQXFxVW9vd1NLaEdxWjIyQmVmbzdlakFidDdBSGJzdDBLTTVaU1F2?=
 =?utf-8?B?bHNXVkwzUTdybmxiczJnZ2ZJaUljNUVadHJ0VzdYOTk2WGhTRllzQWpvUVlP?=
 =?utf-8?B?TTg5NmZVRjVRQlJudUZBTHE4UmxyaUk2U3RNOERtdTNWTWVPQ3ZVN09IbHdm?=
 =?utf-8?B?R0hNbElDd0x2MDFuRWMwRjBGeHFRbnkvWHhiRS9aZ2lFVThTcDhqMXJZQm02?=
 =?utf-8?B?TS8xZytDZldDRi9pMURjSHlJVEl5aGpwMlZGc0J4MnBEQVFzRVRwSkdBaUww?=
 =?utf-8?B?bUNaRUh1bFVycmx0SFBmOStsQ1dFS2c1NGRKZHUrNVkrTzlCdnUyd1U3ZDRn?=
 =?utf-8?B?Ti9mejFmNTZvNWhLTzg0SHdieXo5RW43a0ZDUno1SWZOTmR1Q2lxeWVocExL?=
 =?utf-8?B?OGl3WUdlTm00SjVIMythR3ZhM09oVUo2WjUxTlVFU2lSSVZrTEp5UnFLcEYx?=
 =?utf-8?B?c2M3WmRMbC9KSXNCaytvYTYyV1A0L0pBN29tcFhnSDYvdDMvVU5WbnNnbElz?=
 =?utf-8?B?M2FJcnJOWGxoR3NvVGtpZUwwVWRWQ1B1ajZobkpvRHkySEFhN0o2aFluSDUz?=
 =?utf-8?B?UG93KzlYRmVybUl2WUlBYVVJSys4MURTblp1a25rMDJEMTg4YVl0VVp6dUlh?=
 =?utf-8?B?V1FRUHpzUHpoRmNiS1ptcytpOEIwUjhpdTI2RmR0MHZaVFZLeUhJMEFhZktE?=
 =?utf-8?B?K0hJUnRENGZDd2NOd0Nudk1kb1daRXNxMjJKOGpoK3ZTdWJsS0N0cElRQTFi?=
 =?utf-8?B?WEplYmYwOVhaTFU4dTVlcTBOd1NtWW8rYWloTnZXNjhFWkJIZUZ4M2dyMFpH?=
 =?utf-8?B?M1dXVHlobkZhZU1sSFE2VHZnQUxtVWJCYlhKY2FweUtqVU52c1AzZGFCeU9I?=
 =?utf-8?B?bVJhVUkvMHdEa21mK1ZwNkNTLzlZdWtBQjJMUzdVdWpKQmtFL1IrSGZ4UTRQ?=
 =?utf-8?B?WXRKTm84R0VZN2RCZURMWlYyVlVXOFJPTXVSTFlLSU4yK0FDZVJRdFFtN1Yx?=
 =?utf-8?B?c2FpTDkvWWtQeXl5UHhqcjV0NUlmOGpYMVdZbDdUeG1KajVJdG9YcjJ6Mkxw?=
 =?utf-8?B?cjRSUTFFL3JqdWtHRmpabzhyOEVSNjE1MUllYlRYVjZaVmkzd0pjemhnZXNT?=
 =?utf-8?B?Vmd1ZEJseGdwdjRMbjlnMTQyLys4dHN0eENnOUZGM1RpQmxiMTUrZGNnK0J2?=
 =?utf-8?B?ZzNBUkJYOGdtalhvNU4yeHI2aXlsZXJYUVIzY1o4OTNqZCtwREkvTGNvd0NL?=
 =?utf-8?B?TktHUjk4eC85VTVudGN0Si9idElIWFg4TlcvYWVidGNRNkN2d21TQnRLcWVD?=
 =?utf-8?B?VmZQZEw2K3dGMjhocnRPdnZ2Rk1sQ3hZYlVCR0xtdWxXRmN0Q2NLUWpnS2Ez?=
 =?utf-8?B?L0VsK3hiU3VRWkZCY3o5cHhTRHVORDREZ20yRzJsV2UveWxFZm9kdEZGZ2lZ?=
 =?utf-8?B?MDNNMlZ1UlkyQXM2elgrY21KOWVMaW5mRWFPdE5DL2NPV0F6REVXWVJ5cm5D?=
 =?utf-8?Q?41IaDX7EhSKJ/XhkxSbQ7LMIkGokuxiWKPj3zewoSQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CE13D97E719704A80283799AF25DE16@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febe80b7-d039-4154-72de-08d9a077d5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 16:17:59.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZVxa/Z182rMrx4UEmze67BsRCxVCdJEj8MBdNY8F/+myP/IjpvnmnOXys5P42HKt+hcaloeGbLwVsdh7T9YwYYCKcnX7lJ2OSmzRwnxGk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3605
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10159 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050092
X-Proofpoint-GUID: 5QClNwbjkbZY2MBQnphy9FSnXGmRTyD9
X-Proofpoint-ORIG-GUID: 5QClNwbjkbZY2MBQnphy9FSnXGmRTyD9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDUsIDIwMjEsIGF0IDEyOjUxIEFNLCBBcm5kIEJlcmdtYW5uIDxhcm5kQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4NCj4gDQo+IFRoZSB3a3VwX20zX3Jwcm9jX2Jvb3RfdGhyZWFkKCkgZnVuY3Rpb24gdXNlcyBh
IG5vbnN0YW5kYXJkIHByb3RvdHlwZSwNCj4gd2hpY2ggYnJva2UgYWZ0ZXIgRXJpYydzIHJlY2Vu
dCBjbGVhbnVwOg0KPiANCj4gZHJpdmVycy9zb2MvdGkvd2t1cF9tM19pcGMuYzogSW4gZnVuY3Rp
b24gJ3drdXBfbTNfcnByb2NfYm9vdF90aHJlYWQnOg0KPiBkcml2ZXJzL3NvYy90aS93a3VwX20z
X2lwYy5jOjQyOToxNjogZXJyb3I6ICdyZXR1cm4nIHdpdGggYSB2YWx1ZSwgaW4gZnVuY3Rpb24g
cmV0dXJuaW5nIHZvaWQgWy1XZXJyb3I9cmV0dXJuLXR5cGVdDQo+ICA0MjkgfCAgICAgICAgIHJl
dHVybiAwOw0KPiAgICAgIHwgICAgICAgICAgICAgICAgXg0KPiBkcml2ZXJzL3NvYy90aS93a3Vw
X20zX2lwYy5jOjQxNjoxMzogbm90ZTogZGVjbGFyZWQgaGVyZQ0KPiAgNDE2IHwgc3RhdGljIHZv
aWQgd2t1cF9tM19ycHJvY19ib290X3RocmVhZChzdHJ1Y3Qgd2t1cF9tM19pcGMgKm0zX2lwYykN
Cj4gICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gDQo+IENo
YW5nZSBpdCB0byB0aGUgbm9ybWFsIHByb3RvdHlwZSBhcyBpdCBzaG91bGQgaGF2ZSBiZWVuIGZy
b20gdGhlDQo+IHN0YXJ0Lg0KPiANCj4gRml4ZXM6IDExMWU3MDQ5MGQyYSAoImV4aXQva3RocmVh
ZDogSGF2ZSBrZXJuZWwgdGhyZWFkcyByZXR1cm4gaW5zdGVhZCBvZiBjYWxsaW5nIGRvX2V4aXQi
KQ0KPiBGaXhlczogY2RkNWRlNTAwYjJjICgic29jOiB0aTogQWRkIHdrdXBfbTNfaXBjIGRyaXZl
ciIpDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IOKA
lA0KDQpMb29rcyBnb29kIHRvIG1lLiBUaGFua3MgISENCg0KQWNrZWQtYnk6IFNhbnRvc2ggU2hp
bGlta2FyIDxzc2FudG9zaEBrZXJuZWwub3JnPg==
