Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3146B38CCA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhEURuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41994 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbhEURtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUivM083360;
        Fri, 21 May 2021 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fIRcoajTFMiabKZ8RzY9HcQHD9zt2KiAxqTFQo5plv4=;
 b=w1jNNWnVu2RlzqWuiRoXKhet8Jp5KOFhiJ+P6IqmflUY671Deh3cCwiI/ue43ZtAgRHc
 Z0FiWpgEoHWPqS9q70sr7Et1Dhz2oj33yXdiJxx7Y/euNaq0NmQNjzqUOTvGfog2C8yX
 aaXKB0IFGYRq8j76uoaeCwMSEs20eTvnEkGGR41h2z3D4xwxWcSFAo/eQWn4/gM3IjJr
 kzxnTeI6TCyGHS6FqMFKnhmlDnwBIHng//wzY8lOzhyrnufk0YSgp6euTB1+5JsB0TaG
 iadWwUs/wGFscB4edJf1CUNYRAFO7gKqnjilYi7QwO5MWo52Gd5+RZwRu38WgL8PxGDt 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0ra189475;
        Fri, 21 May 2021 17:48:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2CdcXQ0vrBOg/ZLSuDifhCs2rD0iJZ5DksYGyVZY/0qjZTxMDM0njU2gD/4OuT5NQ5b5qjpQYENTJPMyuNap3Y/qyuLql79hW6pH3UujuqylP+YuehMIJdDHV7H1B8PbG8d0kz7R6hRWfBNZaRUQ5fY8xhacRr2R4Q8GIxCzS7eP7+CoPP18s1Ujk/65v+qVW4dK4foHRwUlYXAgffF00Q2hS+y+TvIvYS0vaFW3sm/i8jTjWp4/4lqS7vLDoPEQQXSW4qBA+Xm2KiVbYeE2vrfKM4O7rf9GQZEIftRgC8CCZXsKkMXpi8AfLnYDLotZWJCBYxHodRAV1fTogYRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIRcoajTFMiabKZ8RzY9HcQHD9zt2KiAxqTFQo5plv4=;
 b=oCkfZzPkbEiiG8ITJwlSjm4ggGPUbD+GnIVnOQ+/MjrbrVE5DTzyxPu7cK/IRQUs3iq9+V1KDx20rbV+7AkbYz2pWzEHUBTspf5hCIseIPsbaltuyZrHtFnKoRTw9s4xFqZUIkZIAMX1BPWofcqqs5DqLrz10fg6y4wadG2ds+GX9mMfsFnvRnXhlQ748szifJG+tEQrJBmf+SYlqrtXKBJBAC/qJ5KcNkuRrFXZE3AfbEA7efCwxZitJuJSZreHHnDdufOJX13oqrgYZHdEdIOqbpIqwSdhFf+JxOeDxc9B/gvdJlL7cwQ23+S/tKxQQwc4ckJkzocOSAroApIDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIRcoajTFMiabKZ8RzY9HcQHD9zt2KiAxqTFQo5plv4=;
 b=xq/fS8qyYG6ZfPfkc3tsyidA6Fap0fcR1qP5Rn0E3r6vx9kHnOECksCFyJ6xf/qmQKQUZeZA56ymABJh61CByCiQahScwqdY630xGIqBn9tAWO0upy3MG00OGFRn77OnYWc9E9E+JfaBl7ECXi8nxt20NaiBgDfkSn9COyE6Eyo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:03 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 12/22] net/ipv5/tcp: Use vma_lookup() in
 tcp_zerocopy_receive()
Thread-Topic: [PATCH v2 12/22] net/ipv5/tcp: Use vma_lookup() in
 tcp_zerocopy_receive()
Thread-Index: AQHXTmlyDt7SC7vGkE6pf511w4R8Yg==
Date:   Fri, 21 May 2021 17:48:03 +0000
Message-ID: <20210521174745.2219620-13-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: bd7d0fa7-1ff8-4670-2e47-08d91c809516
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467FCCC0E9AC8284457365DFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYYL/51e96dZp8fS5dfjUcVNhQAvwB0xsXkLYRLhHXhDihWVD3itrvx7MiQfuDl9MHDmeDWHQeeU7V5jvNP0Kqxq5MtBasQm0RejToS8B/gZBrLFcCWKZ/WEGQQBgreg3T2XBm6euX/Pgb4robrW5yV2tYb3csCQP/0J4FwCgrlzjZvWPb64BaT5dqffAfIP1ko9wOu6vSBhsJLsfe3/9bVBCRxwIdtJlPvUW5hsRPUnPNmO673DbXnqyMXNzrB5sEdayG/NT22jcVADd/peDLFg/QmWFwTLvYdJWB12RDcwnOQPriL5BFNRRNg+JA1geDHOT+iHzKzd3h58bz9C0bTE/4OjURy3YIi7QRdu7iWHJBAyYdRCeRUhN2YKuHwpExR4RXL2Pnt25zYBA1gwx2G4HqHu+0EHdFssFJrgX6biGuCxrh2g92JgTzVOQw3N6f05FEJz/v7dw2uUiuqQQQetXPfMqhV3+aBk6hcPOVdHWj/0KQHrmuplkuzR2+x4gEYA17Ix6mGdMjgF3K0UWMFRA1ratAtqN8l9kAiJZum25O7/JnamPnLdg/+g3NWmaaMQXiVaAKjq4q27CqrAWgZe7C5wf7KYsbTyNuhojpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?M+FUwI49zwqzsWhd9bpUpFHa1mU56e4zWC63+uxpTLioIh5JMdJiCMV/Uh?=
 =?iso-8859-1?Q?LnAZKKMhWz4GwhuHWFynAmuZTI6YzXis5TH1oBcHp+EXYj/w9VHKIlvoFN?=
 =?iso-8859-1?Q?gEttp/zsScWIe2lfKvUhkL9ibqL0YaOR4oK7Rly8C14Ayzo6h5sEIaioil?=
 =?iso-8859-1?Q?8rD7lNEjrokui7wTXR7n1tzEW2XltlmrapD4TaAOWqbV9BQJucOd6ofuBQ?=
 =?iso-8859-1?Q?5dYXJog2Y02iBAxfNXOEEqgNT0fWkoRMioQLyFLDmmCCEL0gvkOV2m8NK3?=
 =?iso-8859-1?Q?m7Uddtdn679K46JuTHxMlvtdC8yvr4xAIoznBldrUCrD7sIKZYzitssK8s?=
 =?iso-8859-1?Q?BMt3FA09NOU6RSKkYMsNcOz26kHNri/BNviQqulNkh1Y5t5zv4znhJaxrA?=
 =?iso-8859-1?Q?LQOc8/ENgKrHap6YyvfXljrZBN6eSMupSsfO4fkoNMjNdBy17zH2v+0dVc?=
 =?iso-8859-1?Q?CA+jIKhThsILs3OmvgJ4DhAB5AsQWVQnd2FoTTT5xzgxjhmKXxeEM4ZhbM?=
 =?iso-8859-1?Q?+cw5BvDiJ2ezDBqwwbfC40AxwN64uPiDtgLu9ZoFwVH4G6aqbuGWeEKXeO?=
 =?iso-8859-1?Q?rDagveoYM4t0IaWyDjH7kuhEv/HewlewJmh2LxW+2kP+yq5p5fKSbyIfZ3?=
 =?iso-8859-1?Q?dQDjsUkHsztCHUHxxUowA8ew0TUU2Q0/2fE0Kn8CLs/2jeaH1+QeEKlJft?=
 =?iso-8859-1?Q?by3jxECubmIpmC5RZARJ7bXwMDgJTj+HJOsAnI6F/TLJLnHhDDBCUR/ESZ?=
 =?iso-8859-1?Q?BqY6GGKDYpgCE6qoIlTjpYkqKcZjvDKNx6FGAHXT7Dv/PuI2lwiBqc2HoM?=
 =?iso-8859-1?Q?7YYNPOS69EquV/ExEk/QmPlb2pApVSVNDgAXa4Q3LmWtsI1GL01N64CFTW?=
 =?iso-8859-1?Q?sqSjVTBhODKcqyygfQEpXjxMLhwD/LniLbxw8RAjp6toq7EVHalseVIOS/?=
 =?iso-8859-1?Q?3yVGdWjK4d7svrqf+/dUnKjPz9zuo7eQe9EV5tFqee6d+Aql75Ga3dPAzL?=
 =?iso-8859-1?Q?ymUH3HtNXlFBWV0wLWd33LBq0YuLVYUY1m8U9AmgvaX6nIQxr2uBkJ/sPv?=
 =?iso-8859-1?Q?V3T5/6n2HdQdavH3qH0VswG171j0RVKJcxnQiDqefkxd6zZK3EKOxepQXx?=
 =?iso-8859-1?Q?FXb+oWOjQJeCsKgr+IYzXjYelHPUFTTBZ01N6nMZ3BzlhrdapRD6P7pNYb?=
 =?iso-8859-1?Q?0wNueBAni5gAlh6sOYAqqv+6+aaRViONDpPoozBt5OPl32mx+nynOjzL5I?=
 =?iso-8859-1?Q?YExEr8nIQu+BIQfyAAtrnTHv8cBVAkcSWZ0HCsMXz7IORkBuIXOlGYjoX4?=
 =?iso-8859-1?Q?EyhloN0z2e8du+KF8X5fGC5XCHFvXOdNzto5f9Bw3KvdS6TkttQVCyYw15?=
 =?iso-8859-1?Q?TgAkk3gEOR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7d0fa7-1ff8-4670-2e47-08d91c809516
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:03.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7m2dITF/Fw3OA4M+3u0wklaH5zeA3Zjk1a0e1kY/azLtqwqpW+p0l3SSV6RXFfd+4F/SRrax7+6Jso1Qo6v0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: UYhckXECVaRgxlXFYmeL43bh9aSKL-nS
X-Proofpoint-GUID: UYhckXECVaRgxlXFYmeL43bh9aSKL-nS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
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
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e14fd0c50c10..d4781a514012 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2094,8 +2094,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
=20
 	mmap_read_lock(current->mm);
=20
-	vma =3D find_vma(current->mm, address);
-	if (!vma || vma->vm_start > address || vma->vm_ops !=3D &tcp_vm_ops) {
+	vma =3D vma_lookup(current->mm, address);
+	if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
 		mmap_read_unlock(current->mm);
 		return -EINVAL;
 	}
--=20
2.30.2
