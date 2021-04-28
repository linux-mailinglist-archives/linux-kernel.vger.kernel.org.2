Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34C36DBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhD1PjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64308 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240051AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFLhoI030867;
        Wed, 28 Apr 2021 15:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xtt6YQK0HMcVyFb4aWSSpKHxwmNuHT0K9k9tF+ZgLdc=;
 b=kb2J8B1sRP5ULqRURwVBy+XS7Oe6dt2O5HOaKSIrOC5ZzalnD3Rh6KMwwMOWzpFGvpZo
 MX7/3KyMn61ZeI1LD1Ps7HcrwummQPFhIC84FUJhtfxs+mJsNMVym2Y38/k9oq1vOf0a
 5Bn1Hk39cwCGVSMMzbbjnITmhRbBX83Gb5dWSzlGqHPj4UnXXwXspj5Izh4eYmSzpi+K
 4HscMrpvm8yLU3WqrwxhIW1VlRfuoBIn2XOE+2kYVK8aktf4vcXFl6VivDYIXYABUGHT
 UI2GBfW6R5JdFoQcIFo//EUFjVxVBehZhY+aIzul3AEDbwDLd9FEfNUcIRLawnSo68sW kA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0ep0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAS003673;
        Wed, 28 Apr 2021 15:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5CfEb8i3LBDoCyDjEImdHULyZlpouKd1P1Xq6cid6862dEHSnm3FDRiWr1lLrvy3dJM5o4xoRkuQGpiGzZK8V4+Czyb013jl6XXhzEZ+4ghWOx4O8EZHoZ7ka01UNNO+oOEBOJifYaPmcKOnUNVIZxtVjTAOvgEkYVoJvMneCH04Yl6SYJW1ogz/aLUNXfA2kmsd/RCt1MzgYgITcZuAcFTbdYfIe3l1dz9RgIqVAmU+WK0ms0LXE8xYGY7btknd0aOIxtVIrmeg47RvdHTGdhoIHq7zC6kxFIROFCsSWZhZ1K9iJ8LqKDBl+0IgWgID/eVHU0qMDC7NPnUECpWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtt6YQK0HMcVyFb4aWSSpKHxwmNuHT0K9k9tF+ZgLdc=;
 b=nk1aN1yr1v9473wWQ2I9NZ6BERTfZegXlOV7+cvIyzlkyJSFsI2n/hkAYG3Kd39uCnlXrZ6UKuh/yNjyMpvaufQQ7Pbx05/nvrclaf+XVhlEKD/3TK02ShwS2V2pG/E+jvQ0/OyP5pHj8QiVXYu4Zj6QuGldPMipVe47PhTIMyXHMDlExwVZ/VwOyxPGsvAHe7EPos/sSrXAk+U1VeeqxO31ETfKbbEoGOzOYsNLaTix/i8z07fDH9aT23AsGXKfYa2HBVyHiZDod3qsYVdqbd5yZDXLt5m8wqbdeU/HD0s0n6sow0G+wYMf1cUd8hfLcpE4IcjQzWeeLhfKwenlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtt6YQK0HMcVyFb4aWSSpKHxwmNuHT0K9k9tF+ZgLdc=;
 b=YW0OT+q2S1VqwTrqpy76rmTf2+ZH0JYfBLhOjkeUpZtW6jjPkQ0R3P2ZlTEUNG7a2P0j884SyPKsy+7Ky55n5eup/ES1CsEuRIy44ZnGiK6XzvqLaTax3bcc9y8uAIgQy2+d2MhO9MaBLBrcWnm4tSMbGT5p4Ih29+JdeDJ+HfQ=
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
Subject: [PATCH 06/94] arch/powerpc/kvm/book3s: Use vma_lookup() in
 kvmppc_hv_setup_htab_rma()
Thread-Topic: [PATCH 06/94] arch/powerpc/kvm/book3s: Use vma_lookup() in
 kvmppc_hv_setup_htab_rma()
Thread-Index: AQHXPEQoJ0FEWO/iOEuxn895AGs06A==
Date:   Wed, 28 Apr 2021 15:35:45 +0000
Message-ID: <20210428153542.2814175-7-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 98a2e5b7-adc8-45a3-d1c1-08d90a5b4aad
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497021452A95BA17204BCD1FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WaSBsqkAq4Aklfe8TYYPNEok0DtkKNjlU0uZZn3Sc0tHXRUW5V1GpZAdvMbx4P0fsNdG/JHYrW2NDwLjxHFydmfGJxCNJ9fYyp2iWdHNf8oHyob5z095WYVR4sXO/mK6QkUj+4vqNoCe0pE31b+UuOZylzWIB+r1ULvkRUnmiD+QwDfikuQdXEq1LQIhevNsh3eBqXauaun0S9rMKkhuD/0mSBnkrqF5T9+oiNjdUV6B/aiTXeh2ZXVW+F12+TzB3HThLoi2MtALDY3TiXzyJI3W6SAG3vckZ9kWguKi/8UDogF9/Pa0IF/rLlopjFzvYBh+CNsE1ejbTFOviVR6ChGLrBVIZCAwrrl4LFQmNkO72xtLec7ib8f1K0bAasGq9eggeM9OKurFilfTBW//lxqz+kWL3AsOSLd3tYCe7tXtwdMqZM7ZMRHYsg+bN3X2Z0x1wbb4eO5GvVns/cmidJSOvyUrxk0fEYRYmuw286YGphGeHQAn8VyobC0Aaddo8+YazhAGwN625h8Iyf4fV1Xk2lOmOUrHhXTnle9nqVIAqFv+IGDZwf+eXJhXiXopHehSwRVd1Ug2xWv3IbTZLM0Lno4Y2J6T+DIW7Cv/gqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?HHABS8HsAdqVNVzSQgsQjfIrf/l9wNXktcp4CjkqvoNxrSvWqzZlGE08I7?=
 =?iso-8859-1?Q?0H/5QbgSjswfSffKAIoV/i2y2+XryPVzeYwPm603pUNbyFH1XjRxZIPpwH?=
 =?iso-8859-1?Q?E1MCYCDndGvfUOzH4JYcJHKVPE34tyNKYyf/NCc8XfsD50JL/eVBHdzXxB?=
 =?iso-8859-1?Q?tp4CHzFO+OuOaLrb3Y/4eoyKtS2xfvlcSk0D/nDWW+GVJBjE9LMa4VOPxu?=
 =?iso-8859-1?Q?1z9w/8prSQBVNMGIq2atoc31LPWC9LHtVZcmJWgVedDSI78q5WGuzWxVUX?=
 =?iso-8859-1?Q?8LlLH2D1xl3zZF6XTLllgYVOaqgvcVzHb1IBrV5G7bvTz0CMK7IJ8wm3p7?=
 =?iso-8859-1?Q?O8CjWpXJWdVRhQT7g+zYPn5nDzP6kbDjZfxHOMUWu0VwVL+UhYynnQMX+f?=
 =?iso-8859-1?Q?IxfpxmXakH95+4R2XsPlV/kPO1u21c/KsHH/F53LLk2aJWYsVYkcg+dK/W?=
 =?iso-8859-1?Q?/c2qwvAaowRPLmMSrqOcvL0l/SiOo5cRMYymhC2lrqD05iDIDSC7DqlrXZ?=
 =?iso-8859-1?Q?mVoNctKF1jAa+4XA5TKPQqkh8s/94gc1eG/92d46xfTIoc1X+e4SNy3GtB?=
 =?iso-8859-1?Q?bAzPfWtpBHqchMMUT72WobT7HPjEvSbMhHSrDWBIYzeepN3zTdqR4B+Ika?=
 =?iso-8859-1?Q?T6XBrKFT4LXFXvKirtdLTmfTUkmlOhmPin+KMEXu/u+m/oMt6Wt+6hma9m?=
 =?iso-8859-1?Q?R0CLKrSGwMPOOsTUINUebnqBTHsCP3BP/CDVzbsiMEQbPQjviksojyYlXf?=
 =?iso-8859-1?Q?mVP17T5XSWuEXa+hGSu8/mUydu6bK6noFnFOHS4J4ub4BzhPps9kdo1eNi?=
 =?iso-8859-1?Q?EjAIr2dxIGWyC3Q+WKOpK8stZB0NtB+zTjgegbHVG0sV95j0Pu1I8o0AJC?=
 =?iso-8859-1?Q?uqyKrQCF4tRssljwGWiyVpVu84nnxWgA2/5Guw1GVn0JIG+esz4pLzuoxv?=
 =?iso-8859-1?Q?iQebmR+uyIE86SzhZXnYvgPcb8kTg4ENL9/gww09eYNmcDNWXHAWzVcRIB?=
 =?iso-8859-1?Q?2Sp4ensOCIR7vCV+pBpFzJV7xoGEfa+nnKGmyfWrdh4xlNKSUmFjonvAMd?=
 =?iso-8859-1?Q?6J9TD9zBbrz9DbVXo1PRCGRhnT+dyqTjxp+p3yNJG2HNdNZ8w+F//RWufW?=
 =?iso-8859-1?Q?RtLRCg1eDoDQKY0Z4Kn182NoPPVu/qGT9Bx67OFxtO8EF0yb0NMfdub+C/?=
 =?iso-8859-1?Q?zPniE3k2WlQ+LQ9rQbfk43AigMCUVskfjpn5cOwo1KcLOG+gQxSQbZCPwP?=
 =?iso-8859-1?Q?5qNFlUwyGAlZOmwQzkFCLJHZxpP0AdV5y2S6iGcWO6QLzknEfXD89PNX/3?=
 =?iso-8859-1?Q?8o0NCZAjDTEKbbrBLXoNd1Mb4po5vxaLC4OxAZDKwW9QA78vIq/xmzmoit?=
 =?iso-8859-1?Q?F8xRQ29+k9W8N2IO9KY0P+Z3h5Qr4Syg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2e5b7-adc8-45a3-d1c1-08d90a5b4aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:45.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ewi0YqJBtzR6oRBYIMkZAO84ulHjlj1gN+iVyFeaMq30i7nFVPe4n+j/g9qVONG4CTbOcyc6Q5p75NpWdIU2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: Mw1gI54qhPte_aiuhG31k2plbun9bMue
X-Proofpoint-ORIG-GUID: Mw1gI54qhPte_aiuhG31k2plbun9bMue
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() removes the requirement to check if the address is
within the returned vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4a532410e128..89a942e652e5 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4759,8 +4759,8 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *=
vcpu)
 	/* Look up the VMA for the start of this memory slot */
 	hva =3D memslot->userspace_addr;
 	mmap_read_lock(kvm->mm);
-	vma =3D find_vma(kvm->mm, hva);
-	if (!vma || vma->vm_start > hva || (vma->vm_flags & VM_IO))
+	vma =3D vma_lookup(kvm->mm, hva);
+	if (!vma || (vma->vm_flags & VM_IO))
 		goto up_out;
=20
 	psize =3D vma_kernel_pagesize(vma);
--=20
2.30.2
