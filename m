Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4193794DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEJRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhEJRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGskbt166750;
        Mon, 10 May 2021 16:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SoX3PjAhZafJ9fXnrhrjzlZmatq1ISzcNukNOsIeh6Y=;
 b=EVGb1heCYA8Xm+qMPLwLb7zcuTBToiuk3x8aq1nKnGZc6JG2XnGrtEmwH7Rn/JRJ8BBK
 VFtQ6XV8DksnT6WeO8i/+sCEg0mB83j9qUfC3g8e5iT18TgoS6ntgzwbtQvf6EkUUZLs
 +yHM8UiWDw6gWFBfJa/cQOnNSLyTvlMwfMNSWZMtF0gT8aIXsAUkWtHdR/780fM8ix7o
 zPr6hPH9D7f8RqVN5Chnd6LmT4YvlwF63SpBi9/qVjNUxv1NE/3i3YtrbM4vBJEV0UnW
 Qwvc+tfj30hvfw0VRabUi8+f7SQqsoZ/3CU5JDp+B9qKdxTVv4OQTz4zxi7ggVFfiW2T qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9nbx1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHJ109288;
        Mon, 10 May 2021 16:58:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQHQ8uPUQcKMutiH6hwj3dGvAJQWWdVPYjODmGBpOYEZaCRBMLcRLeqQ5zREeukw+pSqpMmcqR+vtWbOWufkcgC/Fu7QbtqD1qAxq6C4RaFWqnf9z2xE2GBCBwgj/O/OW/p5JcCJywKkLJ3yHC+SRdWRq0ShUMZYKhaKPYknZD4sGx8BIxVnSGf07HL1l7o3wDLiKWwGX8UPnrLbzjE/jul1Qm1zkIhj2UZl7YN0TC/2LWQdUSYY+c11ZSDXjuVdRgrAgpia0pvOBws1wdgEiSf+x31zotjhLD3G1peA3Lbec/39auCftTTaoxacSe5NVIWJ7aWU28zovzO7okAdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoX3PjAhZafJ9fXnrhrjzlZmatq1ISzcNukNOsIeh6Y=;
 b=D8VOJL9/9C+PWMztsG/mFTM0h3Kn7kT6S3pP10xgo1TxOztEyF9qHnh4vGlIhvkYbqNMrMj4onQYwNk1C07lTumkZFK4SFFOXBnK+bWcGdQwy3z1I8sm8do/mDjoBigNEQVY1vZRx64+Ml31+J2M4KeZmbHFazndrHAn4YBPqqfxUO9ni4cuyD7Z0SqZK/LGJyZmOBW53XrcKVaxNr8VLIgFTGKLtVbCKdtZWwIEHggFHZ8x13HCV8yI0MNNY2oFN5WTEzrHMerx4D5OT+BVnLtrSXgg/qEEJc1gQ50bjznpZrTlHm5XmAKgRhYP1R9+BYFUJsJ9uEhwAorp+ehvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoX3PjAhZafJ9fXnrhrjzlZmatq1ISzcNukNOsIeh6Y=;
 b=aNkpDqqfB0hrmG85UR4wNJk8BabZv9Rxq6PtB9ilb3mcQlfynqVNQ/wG3qPwlx7A+YgT0BfJPmIZjxKmUUfiRPB5RjT1FHrvJ8gCfHN54kPaV3shjmI8GdIL7WCGa/oejrFzEfobSCPt+FxH3RjtIdB3Ca9enTEZjq2Hj3lDb4k=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:53 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:53 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 09/22] x86/sgx: Use vma_lookup() in sgx_encl_find()
Thread-Topic: [PATCH 09/22] x86/sgx: Use vma_lookup() in sgx_encl_find()
Thread-Index: AQHXRb3BQwyhr4gn1kGPsSIfl16+IA==
Date:   Mon, 10 May 2021 16:58:52 +0000
Message-ID: <20210510165839.2692974-10-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: ccce0cd1-644b-4b40-4eff-08d913d4e41e
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB476953428735E55C8FA7936AFD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pS/Q9x2TvvqUIz/RcmaBu2kqwfQGxge7yHlOGGndz4IAWj2zEJcZNlR2g5zmZu+Jz2OouIppY845N0p5I6dDK1I7LkugoW+MK7Lyto2IYyEXH36xLPSh246ogHMMp6LIc3ESekCtq3ZO7oAbOqIk3jQMBQ822SYFqT658on5+ZSkbjKoKDhiFI7hmZYd2Cv8TvUPFu4V917vqXH1Nh6oQXkfQ95RrdC4kK/xO+khFYQjurRgz3lAsgJiNOcsoLXBD5D12hF+cEoB2IxycQMS3SWsmXzazA10nofUew5FglMAHsFJdI92Y5HuWXsVrP1Om4c5J/ekxsfntIQ7EAChDtMaznASIH1j2akyPaCXjoEVoYDBIBEP79tal/x+KIUPk/eP5kDozEpBMG1Aaxuj1DBTWZZW2Ggr0xPMKbI/4h4rAnKu2FPVAcLEwWLKRszBO63RNLFs3UyX8cOHulLGmZowHb88yAr8nsDJxt0O5GtExgGMKeXTKBkkvIn/hjuWXTKEvTdp19WPLirBTSdOlrPnWtChDghgxql+OKoFDL+q58Fgg8DykZDf7P4R/85Jc+0R4ozmgMQKGK2l56/6SFnB4fKjZ2Wq4VnAW7tEzmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?FjQKWHUFbEdQ3xcS1rYuPhkx13+as4wOx0vz3tyBP8msHfAgN36A/fhLKj?=
 =?iso-8859-1?Q?Hnoz6dST2d/cXzF8HDbqOH1zALFZv+HhgmXcsJCcqvHw8l88U6Q061Y/6y?=
 =?iso-8859-1?Q?MiEFe35zK1B2S6boSfwrMtgL1CXpLB/MErpqo3PMWFo0I6IDnZVqH6DO/L?=
 =?iso-8859-1?Q?gp5JdaJHnahGatlleGItwf5jsFE8GM4axK6Sobe5KPWHSxApi83gZHo3Us?=
 =?iso-8859-1?Q?MN5WWc7Y5oyYvbsIL4iA8/B0KaUdy0zCZNXEXYdujUI+ZMFLAAWAWHFcgs?=
 =?iso-8859-1?Q?bBuYt1voOXuSsf1IXKVl2sviR4Mo3QVSLC3XYtEl2h/7emE+1Un55wQtSf?=
 =?iso-8859-1?Q?uJNjaoS3oAik4hu9AYDt1LPDV+adMd86+kTxB2sMQWuZo71AdIJod+Ta6k?=
 =?iso-8859-1?Q?Wxl+sMakfD+hTdwwQ2yWRhe2gaChIwtgM5iF//Upyq9dlEkX83hfTRDOO7?=
 =?iso-8859-1?Q?fliJ33RijLinr1FNqMXbj1k3LDgeGEBQkUUnamNmS8Z5m3aNcO2rStygPf?=
 =?iso-8859-1?Q?hFkmkW3NhtZlXf5T4DjXLGSdeQNwXqIDUQke4vbMsfBpBQze1nPlCxFv/b?=
 =?iso-8859-1?Q?/zPpkQolWCa7mv49Bu8az2W+TQVZQu25b8ol9BGLqS2nrFztF0jzasd1bs?=
 =?iso-8859-1?Q?EANI+/6ISYKYTJmLR9mxmDQqTVSw2WJGxFIA5q58vQEMlNKIR8OBbxdiIl?=
 =?iso-8859-1?Q?H6YwJUYEKqALtoLWjizangZeIdOr0LKrkWPGDBkfrQBYBxbB1r7uBlqTky?=
 =?iso-8859-1?Q?2sU/dDJ33IMwMsfMGZrk2h966Zw8IWc1x2M6h1RKRzUtN9w/MvFQc890ff?=
 =?iso-8859-1?Q?Xo8Me6JEBJJwUT6TqaZsBSvNfAYXoJJW2hh2J+F8B0gsrWhqGCGS4RNzCj?=
 =?iso-8859-1?Q?EvuViTJoxxpWo8pDRI37u9LJkKlAH6z30BthdY7DHRAMwIK+QiZxoDaXqG?=
 =?iso-8859-1?Q?NM+5ry4utpKfJEDg0B5oyqFK0zrTjx77bQygStc4Ed9q10Pb+QADfG9Ncy?=
 =?iso-8859-1?Q?jPdU2ubhI89W+cMO4/20Fx65RUTqaGdGjHof/2cscjCkHk384Ft/KcWNwj?=
 =?iso-8859-1?Q?u7qoIEQuYHogCh7k/7lzFutuH45/r72CN8U+9DiM+7JN1V6gCX8kWR5zpW?=
 =?iso-8859-1?Q?JR5P4hUp7ZfVHKxpWqC0gHsyNjO8fWEUyIB4DtPX9buIt8mZQf0kNdY1Od?=
 =?iso-8859-1?Q?uDmlAaDee0I2SACLqBp7lFqU2UXk+3wbK5JGpM5O59wrxT1b4pK+wPDSt4?=
 =?iso-8859-1?Q?n2c2sB1nIP1SgJe4AWq43soyJunEkEOhm3fskW09obYmRid5R8JRl4dy0S?=
 =?iso-8859-1?Q?gdbki3o9xE6FoiEZaEiVP2V543XVlJMZHAwiIJX/Hp4Nkpgj0jnhFBSH5i?=
 =?iso-8859-1?Q?6Us4aharVD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccce0cd1-644b-4b40-4eff-08d913d4e41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:52.9712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocoU1NfYbX7ZMRsWMBiVtheA8rAPxaoePfC1e3z4MDYQmK5MKQTe2OMVqawSUyll1HDFe+9woGH7mrNmGZhO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=989
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: LQnGQnzQsEFXHfoYIr-NmwdfJwfJWE34
X-Proofpoint-GUID: LQnGQnzQsEFXHfoYIr-NmwdfJwfJWE34
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

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
