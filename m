Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12B45992A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhKWAev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:34:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48546 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230411AbhKWAeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:34:50 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMNtUXq015340;
        Tue, 23 Nov 2021 00:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b0q1dbKWdt69qRaF9o03k9L6nO+yx7S73+mGJS8+v8g=;
 b=Cz5e+wEUp8E4R3/VKlZCv2mqSOVI0vZthy+Z9OacYdReUj39zBPTK0YyidMDosifbQ6T
 +szBnrR7Edi+7r5waZGUUqwwaA9CsOBEkhS73RfqJ8pKJx3FLnNbl6EB5wnXMqRqlukl
 Tkdq58eMbgfMdBS2slMH1ff74BoxyZ/Yj6cMoKwIgSXD0yjoven8sTqY+jkkMDL6DtVX
 61iY2DZMzKywTtrU4oE0sigr5WWHEkSyRX5C/mcrj7rK8XmQou+fyrEyK8cPMUzl31WP
 7jUOcQmIHOvJRc3qkU8WfNfPp2E3bYJSdmFiCuyFwP/1ws3BYm1qfP+pJwrG3pa3B9rb KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46f63pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 00:31:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AN0Kad4124536;
        Tue, 23 Nov 2021 00:31:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 3cep4xhmdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 00:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRmQt4moQ1UjuNLC+agkIEw1rqiZbC75NtNjlJCxBKMXo+8iuMLWZld3RMspdHwG6SlX/DCffLulyaetMmPgEMPo2CUwnotDEtpV8qrZgJummMoG+UraTLTdGO1jbc/ssvsYWEXPrZ17b9XyKZxmPrAUo9kmmUSGo21t8hV0mert3I63OHRuEPU/uxjLG0wGH3w9C0EGZ4MXK0UUc9wzOEY2srABWWw30kEfpECi/OOF60DjO9XCFZAp9088DUGf0ZZq1sSETY7CLTLceKen3Iz1pyVRhxLmf0ekqCumTIpTdYxCjHcE6AyqKrczQxYHCWKsZYFKow0+7r8z2JPa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0q1dbKWdt69qRaF9o03k9L6nO+yx7S73+mGJS8+v8g=;
 b=TULV1HvkcDnvSfQ6hWdkjfG6l4YsyfUVnlag3qUTsMDos+FjMzApes8YCVM2F2Sm1ym7OiaQ/bNnShnUHJjWz5jOyxvsFWiZQKF5qd62Y9w68PMOrXTqFAip0Ea0WQHQE04J1/K5vzKdUcsthr6E6gnoRZDIP0dBKW3NT6wPryc90FXUrPg7e6VcXWgr/S9LTEjymAYUrO8h9FnLKd1TfegybmdUjK2ecN+ibn2opqs1PC9Hq5NWsofKEIji4xJTOrhXtdKu9izCqoPe0CnyvRq9A4t2bc6GajaAV4achdTahpESmtld0KUQ1iSUE5blKZv4QMnk43bjR9nwFUt4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0q1dbKWdt69qRaF9o03k9L6nO+yx7S73+mGJS8+v8g=;
 b=k2d9Bq65LzAfNr90R0t0oGDO9Yeeg1iayrhW45tc1FTXEJSyGvnmyPCtDl8/kB5WtqQPyS4iLDjh0KgmLntsyf/dkrYxStGGSWdpubFZiN0xnzHaMTAaGutJgZpj6I3q8Pj0IbPqLdEyvk8C2bZEp8bEa9do5w/44+xpqfUPLwk=
Received: from BYAPR10MB3270.namprd10.prod.outlook.com (2603:10b6:a03:159::25)
 by BYAPR10MB3512.namprd10.prod.outlook.com (2603:10b6:a03:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 23 Nov
 2021 00:31:27 +0000
Received: from BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::715c:4853:52ce:dd7e]) by BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::715c:4853:52ce:dd7e%5]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 00:31:27 +0000
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     Nishanth Menon <nm@ti.com>
CC:     ARM SoC Team <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer entry for keystone
 platforms
Thread-Topic: [PATCH] MAINTAINERS: Update maintainer entry for keystone
 platforms
Thread-Index: AQHX4AFzhNhH1vxe/kWrhzOFD+fm3w==
Date:   Tue, 23 Nov 2021 00:31:26 +0000
Message-ID: <4008B83B-9D2A-4004-99D8-2B1CC131EFC7@oracle.com>
References: <20211123001725.21422-1-nm@ti.com>
In-Reply-To: <20211123001725.21422-1-nm@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f18092c2-0048-4320-95e9-08d9ae189628
x-ms-traffictypediagnostic: BYAPR10MB3512:
x-microsoft-antispam-prvs: <BYAPR10MB3512882C22D712D565ED06AF93609@BYAPR10MB3512.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tsg4fRgg2jiQMa+8ft9vB2iKOoo5Ny7+i3Xur8tZ03XPTJwqzNtCQRj9y5+Ldt0vJe7llTVPcLv1KDzDCh2SvLXvQElZkwchStFjqvVPXrVJW5YSTu+q1Jk/0p0KgkCNAE0fNrPCMWAbyg0jQMCg+dVGvLj8pUjpJW489CHYdaFHiTlsiivqy5jXzFtooj+nPxtCM8pZoStp/bKtrI3PIgyrONw+IJKOTfr5eJzxYeMYa/yDgtpG8ifGZqvZtGzdaMWxRptZyJXVWsETEiwKaeSZ/roWLBb8MifqPMQgWD2bie3Qj0d76ju4WmF+8diyJ/LXAGHfyIcb1tRTtTmhhfaOc+rxlEfXFsC5QXasoO10T6weSHFYGO45HS6evQskQ0B5r7hF3hKEqfnRY3aNi3d0auVaY8MGKJj4+6Jx/q/SlnB9I5tjYQ8FDOxaN8f/y49JeCcbE7VV4UHDb7kYAyBIZdWLL2aCxuteynU4wekUDFr+b2WqJTxokY1imwWHpqR65qPNipN7C8Wrwv8djo4aH3VJXVI4q+AmsSU5hLNFxGJNcssQ8Qdk3t4JkFu7SBYkvcY+aTcWwJZ1cNxMp5XBnEkmPl0BBNofE/0r3jZPYKyjGNua1QsVq6rB5CiCLxM2NL/EZ+PswWsJmp2isVYU17gOQxNoCrnau6ZAhcvAtrtSPPP87AjZiZI6TdpOwIT4wOf9kPHiMHqyYtZps3XqBaYPJvYWlwPFUVIdr0w9jx/lmh4fxd1tcAWRUj6M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(38100700002)(26005)(122000001)(6506007)(66946007)(71200400001)(66476007)(66446008)(5660300002)(64756008)(66556008)(91956017)(76116006)(33656002)(38070700005)(6916009)(36756003)(2906002)(186003)(53546011)(316002)(8676002)(86362001)(2616005)(558084003)(44832011)(6512007)(8936002)(508600001)(6486002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekxuTHU0bjZicnNaS1lKUUhYN0JvMWUzbkU0Q0lvdmlERTNYSmhDaGdqd293?=
 =?utf-8?B?bFlXR0ZKVGMwSldDUWR1K1VvdHZSd0Fib1l4SjE5ODRIRE9nN21FQVBaTGgv?=
 =?utf-8?B?bHhVYjhwUHZhYmdUbzVOOEx3YUVrQ2ZwN25MaDhFdjBrcnJBOG8zRlB5OVVt?=
 =?utf-8?B?MFRodldNbTlhVUo0ODV1Vjhua2ZhaEFFQ0ErL0Q3dy90U3VZUkRFWmlkSUt3?=
 =?utf-8?B?OTRXeENlZmhhZGY1UnVCQmhiZmE4QWYzRlQwR3A2ZEwrOWdNVk5kblVFSklV?=
 =?utf-8?B?bTVpb0hmeUtkSGpQZENCSWw1Nk9XWXRCc2FXNHVxdm1nL250MjV6aHJ4SmZY?=
 =?utf-8?B?TitHNHg2TE1jZ01YSDMwbjNsNnRjdHV0dGN4UzZIeEtJN3pjQ0xHYUNNSTYv?=
 =?utf-8?B?d2QwaitRM1hFcTYrMDM1TjNibXo0NnRpRVlUTXhESG1VdjUrc0JDM09VTkpC?=
 =?utf-8?B?NlltcUxMTTA2aFJJU25aclhQL0c2US80eXZCVXY5VHdaQi9JZ1N5UWFxWWp6?=
 =?utf-8?B?UlVwdmJMNVkwMXBubHkxMDRwQi82c0R5bjA4RVF3Zm9WUzFZUzRvNy81NDJP?=
 =?utf-8?B?YzltTlZpZ1EvL0VsQnY2aWZVUlRMTEVOSExmRUFIejdKeUZ5elVrQVg3WUIx?=
 =?utf-8?B?T1U2Mm92ek1ydWEzN0laYzVzVFJQWDV0TGtQOXdkZHpVOHZIakNwNmE2dVU0?=
 =?utf-8?B?TXpaSktyNXQ2R0MvQ3g1akpWNkpHQ2tuL2huUjlES0Vwa2tZd0lvWDFyRDlu?=
 =?utf-8?B?dnczUDhWM253OEpsTW9nUDN5aFZBcndnVFhQTWs5R3BwNTdiclNLNFJTa3lF?=
 =?utf-8?B?UjNzMFBjYlhjbGRJc0RBVkNudmNtZ3NOM2R4L2lmV29ka0E3SG1XbGZGSlNZ?=
 =?utf-8?B?S0F0aXhDSFhuMm9UUklvQllMQk5iemVDb2g5eDVod2UwUFlEYTY4QnBTc1F1?=
 =?utf-8?B?c2JzMTVWb2xxOU1GUlZSaFgyR3E1RG5hdzdyWFRJb09WMGc2RDQ3b1RDNytS?=
 =?utf-8?B?d1VPNFJXU3Z3RGRWNnlvUWZKRHE5a2hRUWdQKzlQK3pYRE93K0dmRTJxZE5v?=
 =?utf-8?B?bjRvT0ZXRHVJMC9rZzVpVGlacTVTRFpFa2paK21JWnJ6Zkova2JXQmw0RmVy?=
 =?utf-8?B?ZzMrdHgvZFAvbVp5R0lJQjBxby9pQzIvYzlncUM1TDcwWG84djd3V0FCeHlm?=
 =?utf-8?B?N3pucmFmVGdjMmxIOXAzMDJRaFR0aU9FYXpmSjFmMVBaaEI2R241Mk1EN2p3?=
 =?utf-8?B?Z1dMVXN0OWpvVEJQRjNKcG1pUHVEQW5odWJmOTVJZlQ5RTBQYW5hSVFiY0hV?=
 =?utf-8?B?ZzU0dWVHdVJMaXVmR2FNQzNjK3NSdVYwdGlrWXl1azI3Y3hBSm1zWGNCd0VQ?=
 =?utf-8?B?d1MvTzR5MWhrclhCWnFjSERhRHFwRXFVTmcwQTlBSldqRHhDYm9LK0pSTW9B?=
 =?utf-8?B?ZzJmemFrbjVQNytNQko4eW1PZ01vMlV0RTN6WDkyMzQySmFEdGtWVks4SXJT?=
 =?utf-8?B?bXJ0dGxtNlNaS2ZESm9aQmdFWlRQeCtuUm9qdm1qNG9od3lCTzNOUjVjUEVy?=
 =?utf-8?B?eVhJWHNHWDZNaTh6YVBMcEgyRUY0V21LUWFHU1F4cE9uMklXWmRUdmtsMk5p?=
 =?utf-8?B?T0NNWWJoZUJpZ3p2YUgrZzk2bGZmWlJZS2I3djQyQno5Vlk1cGt6T1pwejdW?=
 =?utf-8?B?ajdITTVvMklXNCtIU1dkS0V2bERSVU5LVWJRdFhyQ3NueFdBQ2JCYkZNUDNy?=
 =?utf-8?B?dFBsRUtzZGRWdC9sZmE1ZFNkL0ZXbzRGYzZMdElWalBWbGNuYVI4RGxzVXYz?=
 =?utf-8?B?UFpCZmQ5MURrTTY3ckJFclNabVdzcVNKVUx0VDhaK0hsL2dIWWRpdWR1ZDBp?=
 =?utf-8?B?RTFKL2dWd1JpN3UvdXdMdG92N3ppbkdwbUxoSnJHbitUUGR0NVZwWkU5aVpp?=
 =?utf-8?B?cmJ2MnpYR09oYVNuZG5kb2ZibFRSUHVMK0orYytPSkZOSTBobnpCeXV4OWd3?=
 =?utf-8?B?ZGJBdFFWN1hXUkF3U1ZPOGJ6b2pxbHNtQ3pnbVJXblEweTQzM1B3NCtOeHY1?=
 =?utf-8?B?Wm9sNEs3UXBBVk1FYWErV01RK3htRFk2QmU4eFVQbTFzczh0TUxnZHhPZ0hh?=
 =?utf-8?B?NFN4QXFtdm92ckVjU3dPVXY4S29SSk5JaXUzaC8rcVhsR0JNVVBza1dncDJz?=
 =?utf-8?B?ZFFpZVRLWjEzVHM5ZHZVMXhuTHpRdlJ4eUFJNTNYYVk2MmM5ZVVHTnozWFZx?=
 =?utf-8?Q?1PQa2+MXnNKcjsDrV2bP38QSjUtmVByeJnjeZbju6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E16C665050604F4DBD30A44B876E7F7C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18092c2-0048-4320-95e9-08d9ae189628
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 00:31:26.9956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xva9B8N+GguafvGX4lpQAhSoqj5+wrk5Ol9D9daAhNmFnSSEcYmz/6IIsAvqf244j0AlVTeVetNQdzk2ntMnvV8sptYsPfUw8f3qeDUeJOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3512
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=965 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230000
X-Proofpoint-GUID: DBYnubh5eYFPGW7d_3rHN_qVV2doTFXN
X-Proofpoint-ORIG-GUID: DBYnubh5eYFPGW7d_3rHN_qVV2doTFXN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE5vdiAyMiwgMjAyMSwgYXQgNDoxNyBQTSwgTmlzaGFudGggTWVub24gPG5tQHRpLmNv
bT4gd3JvdGU6DQo+IA0KPiBTd2l0Y2ggdGhlIGtlcm5lbCB0cmVlIGZvciBrZXlzdG9uZSB0byB0
aGUgY29uc29saWRhdGVkIHRpIHRyZWUgYW5kIGFkZA0KPiBteXNlbGYgYXMgcHJpbWFyeSBtYWlu
dGFpbmVyIGZvciBrZXlzdG9uZSBwbGF0Zm9ybXMgdG8gb2Zmc2V0IFNhbnRvc2gncw0KPiB3b3Jr
bG9hZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pc2hhbnRoIE1lbm9uIDxubUB0aS5jb20+DQo+
IOKAlA0KDQpUaGFua3MgTmlzaGFudCAhIQ0KDQpBY2tlZC1ieTogU2FudG9zaCBTaGlsaW1rYXIg
PHNzYW50b3NoQGtlcm5lbC5vcmc+DQoNCg==
