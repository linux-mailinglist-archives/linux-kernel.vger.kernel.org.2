Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0303838CCA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhEURuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33872 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhEURth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTI4m078874;
        Fri, 21 May 2021 17:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=33atqMxiO6l6m0A0Kynzd+Rl1lY9pFNXnWGEyIOCirg=;
 b=ZbLgvvv+MVHbnQQ45e9GKy008IekYTk7NCzvPEoDZpreP3loPIn8EmwkYfEnGpteBqne
 x2i1/eeV95kVxwTVLPhFoe2Vl2Cd2fhpr1xBcW2vIi7RBYrsMk0/3B1YRnmKJSDgTq6u
 v8Y1CAzxQaQUicOe5d04aXjA/OLxQHXgEqUP+JNkOpkX1qRYfeVHyFjBwNSjdXyvdzZP
 yE61xozUSDMkUbPMSoEu/Tn+dBQupNjY5xFVuSW3Oa9ZZutKUosSCUJ1UtgZuom1EoJE
 Be7gYcw9/VRuCX6+ojncBXapDhS85jwOV3epbnBynRDbJiCXIelFezB3s5DIFPy1Gj06 sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38j6xnra80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rX189475;
        Fri, 21 May 2021 17:48:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P78BCAFtXTOmIjIuiZg9FBVmkBvFSkxJrets4wxDarrnGV46QXHdAD0TsS5pIlzqUuKdNc7eWAu/R/SWmxRaFqb/I4ihSbWu+AMxkY4RoPsnR5dbH3g4KnOs+sfL2z1j/ECkkLIPVXdmBrcePcK9X5bvanFApSVBzq0FeL5o9asj5rng4shFxs6TTNr3G74sAyVy0nbIQyqIXZNoUGPrPfiDh6JwXVBIkcUB9615urZ8FSj/3jxa/uWTaQOgdK4sGFKxF3HSRATZGZW4JvEWJZAJbM4masJCUE8uP4qyNpSd+c2j5mbVXyNIEnPmsEp8QogkNRqReZkFGXWJ/7gSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33atqMxiO6l6m0A0Kynzd+Rl1lY9pFNXnWGEyIOCirg=;
 b=O44vhJ3we4qVWxvk/Hhx4X8nIBWSq2g3Pml6wg6icD4/PhCb/0p8nKLG7ac1Eakjm8NcBZnNKu8Oo0hBrYIinG1Vqmk5ufcdrap8pShrEpaKz+G3SDQ4HIZeNHDfFjUV6B0rhIdPxH0hDRBWcoHispzT8NKD6aeYt0ySEfQHDPmLVLy7TopCzE8xC/9/HlIfWUFHLtD3ZlK2hhfBLUgHbnb97yFdYOhGYXC6vJgKcsT2nfRqKL+HsHB2uKRG11XNF4+O9Ut+S9K5ruQS7wrbr3QC72vdgoXDD3ZiFu2aHhHftxk7xeNxue9dPR9OXYrnO92t7lzD85H7+Fk2q2x9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33atqMxiO6l6m0A0Kynzd+Rl1lY9pFNXnWGEyIOCirg=;
 b=znIvjJUCKzJTADO1LIO0nhxjQ5fgUl6x62gL4mbyw1LUg57+K2opD9llzLT6h8pSCtLiECR3660HYqwMtHrl6QxHL4gZMolWZ42LcIjPsUEcu+wxLakINQmsvWip7BCOw5DCPxeec8FXqCmEpNipzQ9fBUBdGmBfBRP6spO4fI0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:01 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 09/22] x86/sgx: Use vma_lookup() in sgx_encl_find()
Thread-Topic: [PATCH v2 09/22] x86/sgx: Use vma_lookup() in sgx_encl_find()
Thread-Index: AQHXTmlxUrZ/+VBwEE+/I3g6mMPxiA==
Date:   Fri, 21 May 2021 17:48:01 +0000
Message-ID: <20210521174745.2219620-10-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a699bd1-652c-4193-f148-08d91c809430
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44670D9691764973C82B60D1FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8tzBERVdTtoPul7lw40KDiT0/XY68Le9T9T+gjvVERsl8L6k05LzKrrsPDo/qQUMpbBgJRo3nqnEikuKOEeEXnJhVcauMfgJuLOAu50DXRsp1/Nayj7VeLwIKibPZcAC16n5VItctQDifsPuiwpVhldCzSVS4ASAZePFJgj6z+NoXzQ+tOjgNtx0OOF7P/PhmtJ/VsRg/6XpN8hYMlfS3/dY9Mhv+8BUGjriI2YoO4si+NWx5dTt357kGHBnztlh3+aY5v11H4Y5H5gWseiQEcVRp44XXAGe5Dzuqo/ImahiEAVmoRil3F8Ts/XYrR5qmhY2MvHtTBAZyletBSep1/+oa4CY7XWHEZdveZQbv2pz3arSg/tT5aWAF72yPL4SWlNgDAmvWUsntjKIfV61tM7slT8FBlyeWus2+XLgnGa/OTQTlrhS0p0M+q6oXzU7L23yZ7uHjqJTRc8jq8N3K73mii67G81Y4ZmL7QnmlqFCWyj4PDoy2swyTPEnTlA3lCW0G9VvQQL4SrYPAlZtfui7MnX2MoRJUCvzyMuhFqIvbFO0F6DmNw79CGFWLZrFNJFN44umK7elLRArkx1I0h7+iho6RBPatBs4V/jNl5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?v6xBoHiP8M6kMR67NxjjXAd7Fd7ds+DCJuu8sQW1mltRs72XCPY4gzqHEy?=
 =?iso-8859-1?Q?aHsBu13doJRKwzUVlGpciyS2/92c1lPMEcT0YxpSacG433I3y7ph7R5V2a?=
 =?iso-8859-1?Q?TAoZYgUk++L6PmDNjKUB+wpOPrk9fhMGSviLHXUJ6N2eUVqlpMQhzqcM/n?=
 =?iso-8859-1?Q?nylN/tWJjVygIcHYLAA0tiydPZu8HCjF5dLgXOkdHsqQiFyPJznX72NJbm?=
 =?iso-8859-1?Q?p3/oelRDJ9BwmBnL7ImMfPUsIiGZFq3SnemFjm35Qbkp0STSCkmD3FHEQx?=
 =?iso-8859-1?Q?6udO0HHKKVEoDwF3JhUchLajjNlBpJcCAr57i3HSvsBUEMLoKz9exwcQ3N?=
 =?iso-8859-1?Q?xh+bgzU+7iuPWrILkgJodQv2j9U/tZvNJvyCdeTo8rmJTaL1Nxwkd7+yBq?=
 =?iso-8859-1?Q?dgw6zi0DyJkvZqwPPPYWC1rMSklTnAtPq4tBG9wVOLNHzneEso54oVE2VJ?=
 =?iso-8859-1?Q?QXbonaq3puhedWZZkyw+k+A9M7DIyROUy+C0SHVRnzu/vwj9Gc5YHhcq4o?=
 =?iso-8859-1?Q?aWcq4yiY0l8qioLxRzfbfzOG/A7de2zsiUNLpIK0CvAaG+z5bqGmvHXRau?=
 =?iso-8859-1?Q?jjggRBG4hDN4GgbGTsfEthE5okokrPYvvlCvXaQ7CE1CKI/llk1w4lazzv?=
 =?iso-8859-1?Q?yliq7yK7xHjeKeyLiUHt8jgZbZJgNz1KUkECMeQvO5Jg6e6oQHt7pRWV0O?=
 =?iso-8859-1?Q?na7desE0g1mfs1MDQVwtX0eWEB9hu/Wpah2a1ivhcbaEtK3hw9D1D8hFJz?=
 =?iso-8859-1?Q?f6x9wyw6t5DgGo91O+bi45iWd2JM70KYNOcyMqDmNaTdGQy6CALiRkmhoI?=
 =?iso-8859-1?Q?5GpBTthzfyqSW9SmpXOCmuX0/JO+25mYo1RXLkW9eDvoDf5cI0AjcQHhaK?=
 =?iso-8859-1?Q?eY5jXHcTklA5/zabGZVFEq/OvSOAVb6uN9o2Yy81qs8aCJTkUR+MtBlkjg?=
 =?iso-8859-1?Q?7DIdaKVj5N+T8y93mm/W7CaFxXjmI8FABvA5h1YQpv+C8mU1Hk/6TsEN1S?=
 =?iso-8859-1?Q?2HtjauhxMlXw8ea0eqMCZN5shJSLzGxL+5FFbHFse4Fu2XBAajh/JVyLAZ?=
 =?iso-8859-1?Q?UpDq/BxnCgtgmU4QCQxGjvAVC+Q5spC2b+J+Ezp6OBowVaTeJHdL0QUj1T?=
 =?iso-8859-1?Q?HtGOGBv8g4/igAnXgHe2v+wFxBQrmDKkKck1YsjlRleloAoFeVkqjj+Neu?=
 =?iso-8859-1?Q?mDAVX7VaebYgxMzP7GAHXaHBsy7fUaBCykfCmkzxVplar8M9p8qbQR86Tp?=
 =?iso-8859-1?Q?83IoSQ/eODjcZNIZToBikxCHIG2xIAAOzTAC+W39cUTTyHTfhAqlDboTTw?=
 =?iso-8859-1?Q?gogmOyuVo6zVCzsC4to/7odpV+h+z9v/LZbMojvoQEL0S+J3rwnVW9Yobh?=
 =?iso-8859-1?Q?71GueFL9KM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a699bd1-652c-4193-f148-08d91c809430
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:01.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7mpVjyknAl2MBDMvnAL8/1aPdj5m95CPmqTlwEavDv3VI9gHEqfIoU2Z0ZiCs02hLz8Qt2Sq8BpvyvBDX2nyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-GUID: uScN3mqhpU5EwZ85wU2_ZlgQLOE_0u7e
X-Proofpoint-ORIG-GUID: uScN3mqhpU5EwZ85wU2_ZlgQLOE_0u7e
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
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
