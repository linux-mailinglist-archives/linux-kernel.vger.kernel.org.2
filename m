Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC63794E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhEJRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:03:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhEJRBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:01:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGs6tu073853;
        Mon, 10 May 2021 16:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ntlMHOPLYmSjgymaNUj6SXC0Tp4wnz2KZDjXjM5Og4Q=;
 b=FyUtDiieV/Xak6XZnCw9rXC5SFjPZWNFyplaRKbDKbKPj6uvHAUty66GbHgR+al5/7fc
 9bO9r3jJcIWfUybBJzULZkBK4mLMdDhYAS9wXTXruhh8iPGJgiHIEgq/ofVeoqv6iecT
 2jm//9eZyeCJWC+bSJu2FXtV2JvICzwFWKE3VEv6aQFNRrQQznKEwhuxAreBxW6ScJ6o
 m9ZLDQpcM8rNMEH2eMNZ7TXLUBz9SEN70ryQk7tCvqM9zPh6QukL1Z7Jhzub3/PmNyl3
 8NtGSwX8O9bFgjXS9cNObZS3ydfaDhpQU19NsbvXOodVTI1l1wT2X9TyIpOx4P3fiOr2 PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38e285b772-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHE109288;
        Mon, 10 May 2021 16:58:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl+kvRKb53Qg/kB2myJcdz7vx+xISikjxXL8dD90Z5jg3ygA2H3osVTTWLjPr4b9BxfO348wthznUHuCyA1HQC5yAZmGq0XlBWHxu+dMV6NvnK1Efs5Iviiel2M2ubzzCPJMoWIzUviPkapn4kudf3bQy8ZYpsugFc+kWmRn6xs6jE6j68y5eraYPUROQspcemAsrSsu27QCa1/x0g4b+Bog92I08Bfk8qpjtqD+3X0hp44d8icM2P6Gpd2Eu84m7TCBCfnOPA8FTyCBhe85lgxUPm2gNGLxR65WKkioW7Vftt1Gpv+DlJOEas3DRJ0rhQ9LPSvzVimHPu5aIUllKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlMHOPLYmSjgymaNUj6SXC0Tp4wnz2KZDjXjM5Og4Q=;
 b=nK35NBiJ5lzTNMOa80XvmPKwVzkwySKS6nmGJUXwfGWIKKRQObV6O0SnGQNKtV7UGgQB//+ZAUq6NK9u5QreMVQQOCbhTNlcIhmWn5rSlef5N3jdJ8Jlnyfe/dF0cCjJeI2Ub9HL8aSEX2ChcwYVTF+4IQHAGY8PoN5zlNQG7zvPbq90v37OM8yoDv7rrKbuYsVQwPEijBiDZJ9c+gfy/tj5SeI3ojHCfhvN+rXTCyFwQEx6UHuWPyyWWm/G067d9Fqs8vSCiX4NAtZsmR3vxvlgGu9H1r82bLgdVZoBo6xKLfygGR5PDL8SxaVX/0DgXqbrh0AK4y1xOfe372zOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlMHOPLYmSjgymaNUj6SXC0Tp4wnz2KZDjXjM5Og4Q=;
 b=AuRGdRkJuPV8YkLDn81TfcVTxpVfd8cflJP35a519/OZRXo/WVRtIkgF6dXghl4XnyV451bFUdX5fX/xsvgt0/FyeL7BlKxw6cDTsNRmzRs4RzYIjYjHjpzpvC7OxB167S9hpPu2STB4wfoEZTsoI4fgfKWkjkFFY3gL+C5cezY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:51 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:51 +0000
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
Subject: [PATCH 05/22] arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup()
 instead of find_vma_intersection()
Thread-Topic: [PATCH 05/22] arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup()
 instead of find_vma_intersection()
Thread-Index: AQHXRb3A47kvhfAFhU299amlOGtqPA==
Date:   Mon, 10 May 2021 16:58:50 +0000
Message-ID: <20210510165839.2692974-6-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: d3d0cfa2-10bd-4bf0-92ef-08d913d4e2e4
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB476987A430974C96078EDB0BFD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bt431u/OrkOh1rdiM53nw4+gYPbevobO8S/ThgEAlv1GKYcFxe37spr5w/HMPDAKYgIgVVCbSErEwkw5+D6yuxf8sNearKZxE+PeKb92kbVXPTazgmpBk7UKZ8PahFe6nwDjNTwdVmpsTTLmuGIGe3PZYBozJBSPmhD8LS6a19q+nGgMiNoWjVNHmtW0HxEn4jzln6774NIIR8no8Qmz759M//1fKjT+SBG3x1zqpl9FOAqWkSGtaBcxTJ5Sqibn2kH+O9vAubsdV25EcSKt1mgJOGvtDA+ep6xFksL0tHkJOkqMSFGgq8nCnXZtaUWBjHc0S+Cz77DhLZcwt1dmi5Y75lRpMe7RLex3r4WfGSvbtOv6Ox86NZdz8vjV5dWdd+B8ubBUc6nxjCmiMK6BiozaGBvoRYCCSY9bJAtChAgcAwS8dP4alaUC+G7lQSDlrHbI+FiGFuEZzLGJRyVaVTnBivDQgq+cpSFDlBT6E0iAvrl+eKtQ1EBEwceXTCL3LZ+gMCoggWDcIDPt0qDcGBDq9+1t7ofX9427fl731us1VQgyjsN+xjLKGKL11ABHtxi+qPHPp+PQion4v3wvxWSqrptt7wKh27ihe4qLc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?TkniFNJ21m8Zv1UEfuL4aOEcgOU3wnKBz9zieKY26le2+AcmEwLS6bOQ1A?=
 =?iso-8859-1?Q?jSyI0xjcsktSnyqjV5v82FGU6H0UvrV2vDWkdALgmTiPe4NdOZ3L0wVGpN?=
 =?iso-8859-1?Q?dJmbg6RkQB6PiMrV0M++nRR5tzf7nujUFXjGBaYUrv1cJ0yMrAecCN/dzQ?=
 =?iso-8859-1?Q?wHJsfcggKmu/41oxEcap17HUbSCOqEnSUIOsf8GxBNoe38uAfJtjA/IFM+?=
 =?iso-8859-1?Q?OhGijhsEQrlyNj+nfih46fUb094ZZltMxTWc/N06f2jOCPvHJ7bhgV12Uo?=
 =?iso-8859-1?Q?1mG3oVq9DH/d46/ZEqOGSZisedEbZypmmgLt9xkqql1NbkQoKuG+b+4YNi?=
 =?iso-8859-1?Q?vjY4Y11SZvzzzlqXmzGXnEyLBfgC780La2u7Q6GHDhrKQ3Wqmq563freI4?=
 =?iso-8859-1?Q?8uh9O6MTAfgGCyAm/UYfvxpNU1B48yNN+fSWpdO+dgMzFH93ySCMu+SinB?=
 =?iso-8859-1?Q?aE335RmfDfQl5sAq1VzAqraFqF92x0beYDg6R4tkmqeNFb+lNTfw6Zv4/f?=
 =?iso-8859-1?Q?4sEt7nriw5y3kt0kfSePOSLm/czTDZajpuym5rqCluyTw1aYHOsVI29F6O?=
 =?iso-8859-1?Q?rzb6LmRxwW1WeUWPLZJvWQ+zlsG6RJLkaGEqu40I65AQ6ylKK+JhFK+cQ9?=
 =?iso-8859-1?Q?SvEbbYzephpZFtBbCVWw9HBXWw5we1ingY/XnHFrfQKDafkWWm4ucQO3Dd?=
 =?iso-8859-1?Q?iHNjx1tGLVh4mVeiYhlL1blinKL51zMXKhAsldEhu0/iU6CE2uksLXj+UW?=
 =?iso-8859-1?Q?6zUKGkEii/JNJAsQFmXNmoaG0Y4+RsXPQ+s3FhBpGgddDzFbIevminO4he?=
 =?iso-8859-1?Q?GIQho0Pk6sQNLGYYzqI2AOJYdWX2TEckrXpvRGbWHpahx5sZpuWsnKmyxy?=
 =?iso-8859-1?Q?qA7PK3EAAeSo4TIW+kKpFmX8SmMqs/J1Bw8T7JlGO5wN+LhWhJ3LwfpDrw?=
 =?iso-8859-1?Q?eFjPkN5DP619GwVBi/HvoJ2xouG6AasQKF7hH4pNB4mYDZOlot/BueWOsu?=
 =?iso-8859-1?Q?RFwo2mAEBAdfRwFWcpdZHfoWYrBoIy2yxtTOXo/2GNFTvFLRbsATFsB/Sp?=
 =?iso-8859-1?Q?HlAdpnkq+1FIXpDOIcdEiZaXEEjoABb2FI2AVW4wumwQbILirPlXArgxz4?=
 =?iso-8859-1?Q?TqkMksLvyg74Bgrsmi3WI13MGKUEkByrTfe2eO/PZ/LXTiVP++UaK8z4nx?=
 =?iso-8859-1?Q?cWDyJ01wN7nc/MJ8CcNvQAv05sj3g5GmTAiqDQ3/RVHSD0JRf/PvNl9HrY?=
 =?iso-8859-1?Q?foIaUs9Rx2u6SJHndIxd8waXujfzQ+7JqSDvgB2um+db4fKIz25Ge6HUWf?=
 =?iso-8859-1?Q?HKZo9dQaOFmoygFc9vDlSpi/xwuVQIBhYusAUIP9fpvuFYqoiVXwJOSa5h?=
 =?iso-8859-1?Q?s1C1EciLU5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d0cfa2-10bd-4bf0-92ef-08d913d4e2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:50.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5V/hEiGbquLA3FYIeTV/DkJIsEEn5VTUDicaXZN1M12ezqRP9tkGR2UsZQelHiy06OEktdMywMTG7nX3iFy5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: 7F8srUHoM6NyMfYZIE9ftN4uffrxDnqw
X-Proofpoint-ORIG-GUID: 7F8srUHoM6NyMfYZIE9ftN4uffrxDnqw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_h=
v_uvmem.c
index 84e5a2dc8be5..34720b79588f 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -614,7 +614,7 @@ void kvmppc_uvmem_drop_pages(const struct kvm_memory_sl=
ot *slot,
=20
 		/* Fetch the VMA if addr is not in the latest fetched one */
 		if (!vma || addr >=3D vma->vm_end) {
-			vma =3D find_vma_intersection(kvm->mm, addr, addr+1);
+			vma =3D vma_lookup(kvm->mm, addr);
 			if (!vma) {
 				pr_err("Can't find VMA for gfn:0x%lx\n", gfn);
 				break;
--=20
2.30.2
