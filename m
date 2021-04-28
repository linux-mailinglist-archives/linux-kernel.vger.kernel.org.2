Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFA36DBD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbhD1Phy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36324 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240069AbhD1Pg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXuw015928;
        Wed, 28 Apr 2021 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=It8RwG4GiSF/n1GEYEDTTysFK9GXt2LMSPKSJCdTsHg=;
 b=P6v5Gc4NuvVbchZdt7cJIFqUdq2M0MVqqFJk/T+WFxIASr4cY1KP3ovjPb3OTf+OX0/p
 NT6Rf1vlZ4ZYtmEpViZ3v1B3ve/benGsCeF49PdTXnnj+hQTqU3nhlGyg5mAyIJSYdxs
 avGrrMrcoHgLQ23bPiEn19lxwcHTxoP5VWwFpbq4elxxs4/H7T3iobh5EnoALsi6q7J9
 QykUtuXGzDh3Luc7h9lVv+4LBNidVVFhhrdsIsZksxIwm/A3fuidKo+7jrYmPEnxiYZm
 3TtXQOvvlG3hVyIFsyXV+dy9kYV7E7NaihWGzqM4Mk+gBuA5MrHM1V9Amusnsb5iPzet Ag== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZorB158269;
        Wed, 28 Apr 2021 15:35:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3848eyqw48-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAUoK6vkIIKJ8E+aIGg98U+P9ULj6WPDgN1tDmEXsHjqKReFMZLwmMXf0PFOoaP/aN38VWLi9HGfS5G96UjDx/QI7OiZ5dsUtX/oEsK/EzTE2YyIPPj6/80/FH7ujhF2GbfBKeT1mYSPgE14kYHM7QTPt23o6ZTYQ0jT9Yj2yo87S1UDbKBFU62gUv8rJdW+LkSzsY7WGJhWAw9W1AvEngqgrhV7DCIuWheX7flipW7uSerEocupjipS699R4XVQyjE1XWX9VGsGn9AdYPt3v0L4WeaQgwDKa5IBtSmR5BGAEqvh5tVtfd4gDEjZ9q4qq4mHHKlJP5fnU4luGLTg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It8RwG4GiSF/n1GEYEDTTysFK9GXt2LMSPKSJCdTsHg=;
 b=h+IffiTRgBoPDXET1x7Y+tiy1xwt/LNNsDUEo4UV/ukC5+fEY26ELYUKA2uPTF/6LyqBMiTsn2e31dVs5US1Wi2WMr6lEJaoa6m4gYmqbK5wFvb0xzre/gssgASS5w6HD125AGSQiXmdD9IFA6iE0SxixOBj12n38DwViTMwVI2BJIvVRrdPbpAB5OmUIqGuMta7825nDFPH3ayUknsnhjhQ4SU4wpMFZFtM7O211ub8by5hnkSzOf0A6Dqk9kGOpa8o6OFaz3rR4zYYCJiaJySBd/htzJL35ECW15PSl0StkwtksLJQO+e4dygesTXHQDWnf3Mh/Y7zogkzuU7OTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It8RwG4GiSF/n1GEYEDTTysFK9GXt2LMSPKSJCdTsHg=;
 b=eZKZ14ca7h7KEPWEhFAwL3puOO6zTXJ4wZQjEaCX0cS4qgPbjJsYI1Lp80i+1O2QYYe+h6QDSam7sMBGT5wIcTXUy+hZ5C9wYHkggf1161SGDA4YGBtKgHw2xd2NOu4Qgrr4WhFJmzApk2mzr/4rT84SMrCDY/r/0p8eiJUj6jM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:46 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 08/94] x86/sgx: Use vma_lookup() in sgx_encl_find()
Thread-Topic: [PATCH 08/94] x86/sgx: Use vma_lookup() in sgx_encl_find()
Thread-Index: AQHXPEQoV5l7mDb4p0aYXEbJUwmqHg==
Date:   Wed, 28 Apr 2021 15:35:46 +0000
Message-ID: <20210428153542.2814175-9-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edeade04-f477-4252-6db8-08d90a5b4b2a
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44971A60E4554C315AE5560AFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qW0+2lZi8QBN1GTYWcverz7kOsi4zvwMWNznbCwngu8LsgJDkHZpVadgofsy6FV5ktiOxY9GTTI3/0W85cEcIfUTTKtAVU22Xd6kK/Fs2KEwbxFQ3SUy9VJhCZ3RxQwmQ3DBngMvQjUHu0XIZnMI3FaNk6OvEer6HdcAfbDcDm4I0SxqGWiUs5z/7k8Mgb1uIbWT5X44dvdFIbiZfRdn4um4T+y/yQaaM9C33XC+0blWeat4MRevh8USrTNTeTOkdZqwsolV4q2RHtmOpbUlstYf4MWWgOZk5ERIcXMOIPj/M0veeTaaAE3gV/Oadib3auY8KZ9ZVse5tNXTtsd2ev3Rnfv7/epHlxt4wWgq2SgzuRy/ARL5zQ6tcDjlKNmhKzoqwyzOFO5CBZF9RGjYE16iRYSX5UMSRPA1T23+dvfb1f2DOeWvsIknzRoIM350XCSInIVpYfcY4oZXmzUJhvd8sfUZVNjvtteyG7gGqjXYZq+c0odTFSwoQ1356Sb6ttCoGzPfX5fCc2XTjeMnu7nyNXENaaTwQzXceUnptkDBuTe78qqhfncNQNC/cKIp9iFA/bgZAYD75squ83jKOsapgrg16vmTQ3QZL4cXqw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?78zJd56uqwc7n1x1XAU5QKDPDu4mBBteMY1+qpohnIS1FS8wdHKKh+vla+?=
 =?iso-8859-1?Q?m/x7Q7PjkJwh4oxKg/3EaVjx1xp+/MbAejW9rh3UCsa35bzKhrpj279OF6?=
 =?iso-8859-1?Q?N8ztywklJ46xZC/R0bzd7umwz54KnfFEVrorV3bG9Ax9cBdsd6kLTaVrzY?=
 =?iso-8859-1?Q?76IQWH8bqvr0J66zlIAB8WGSQJ87IWxag0ptsxpXWN73WnX/nbcEDzXtGE?=
 =?iso-8859-1?Q?FimhFewsh8Wqzx4sbp2TzpmuJjy8qqyQXQGN+2KBmkALDkwRRnaMHzdm3o?=
 =?iso-8859-1?Q?TWI+pZd143bXSbtZKvHbs+6CIzC6B5NC49a1I85fl6lym7wF4IzhiQPAXO?=
 =?iso-8859-1?Q?fwjerykEY/awIZ6I/B13p8ew8XY4wc8axNNCM94r9Su+QOmGj44iBHvX6R?=
 =?iso-8859-1?Q?Hv3z8IZCzIuF7iuN6ciAzr4HlXhax4VwC3oyb4Sum0SwqEfWCD9G8XK1aU?=
 =?iso-8859-1?Q?0O7ktm2NtonpItc15r6AFbuiTYeeAx16GcNfLjYXnwU5G8BVXfRq8VVBFK?=
 =?iso-8859-1?Q?L1ZLLFl4TkKBbhmOGeWU3jwbcme2o4SLdBXezEV48v9eJwVR6MA1RqMRyQ?=
 =?iso-8859-1?Q?qwTW/Jryze6fGuCHCoD7NL+OiE3dJyobAHpoqY69Fv/3vhrwJ4SYTIo5fs?=
 =?iso-8859-1?Q?fPgRGhEUW1AzJdc4blrUX8v9JFiAb05umgXxfjPQ3OjX9GyO2XpJtXyer5?=
 =?iso-8859-1?Q?Jxo67/wwyRTea0Z+lW1HHOU+PSaB8FZz2wFQMrMmHZdAZcOtrdFBp5JApu?=
 =?iso-8859-1?Q?JS6zwc51FmDJ5aQY3JyqU5t5DOXrr0fM5YAMQBjdAlj+7tBdKOKvcnxCH9?=
 =?iso-8859-1?Q?iChB6TMBI/nWXogovERgUijpVsyEEVh2X7nRVsppybeikzG0Z7azxMgPiu?=
 =?iso-8859-1?Q?1Z137f+yK49S4NcQ0pjIStxif0dzID8H9cUdHbe//qICNPBixe4X3AEMHu?=
 =?iso-8859-1?Q?2aceQD6WGqFKBUW3SLloEUEpDH46DI+/l+0e4N5cId88FDOHOSuK5MGVVr?=
 =?iso-8859-1?Q?CB1P3s0jseAkJ8kwn0SYixUDJkmeasVyjYw8M0kLKLTqjcXvmUAxKEkOOZ?=
 =?iso-8859-1?Q?44TOZlMbstWJtha6/x4iPBpBYriL/DTtBz3OU4yKoUdAgjYj3IMD3zk/ap?=
 =?iso-8859-1?Q?F/DwqVBjKp76WDEowE9UvYDt1I8nDkD4uGpcTHHraJ8gX7MVtIjt+1q4o/?=
 =?iso-8859-1?Q?T+9NmIcIiHsYgZzRsquc3NyK2I0qxynjyfQc5OrTnYpubPNxoD7lQpx1CL?=
 =?iso-8859-1?Q?d5HeWmsa6pkCmprSeg3p3qQQX6ylZhBkI8dxqBeQVMThJnAYfIRnEyaOPb?=
 =?iso-8859-1?Q?mFH9ePB4O1hgFeagzQAJqTh2bAnfbDnkFKdk4SdGWF1Rum+UbwCXnO1m4c?=
 =?iso-8859-1?Q?k3bl0wZKUNuhvpxWWZEdbjHoW9lS3dfw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edeade04-f477-4252-6db8-08d90a5b4b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:46.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qFKM+DPDai5uI6977syq9QUdqzpMyVCjFLPs2pDT2h7gPoJ0FSCMk8gukDSMaodeSdBpfRLDFoD2m5mfX07TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 6Zylzc67Rz54HtMFMz2S9e6AH5wQ5LHp
X-Proofpoint-GUID: 6Zylzc67Rz54HtMFMz2S9e6AH5wQ5LHp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() removes the requirement to check if the address is
within the returned vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/cpu/sgx/encl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.=
h
index 6e74f85b6264..fec43ca65065 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -91,8 +91,8 @@ static inline int sgx_encl_find(struct mm_struct *mm, uns=
igned long addr,
 {
 	struct vm_area_struct *result;
=20
-	result =3D find_vma(mm, addr);
-	if (!result || result->vm_ops !=3D &sgx_vm_ops || addr < result->vm_start=
)
+	result =3D vma_lookup(mm, addr);
+	if (!result || result->vm_ops !=3D &sgx_vm_ops)
 		return -EINVAL;
=20
 	*vma =3D result;
--=20
2.30.2
