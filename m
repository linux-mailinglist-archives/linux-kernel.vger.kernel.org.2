Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEAA421BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhJEBdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60520 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230452AbhJEBc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:32:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950Cu1q004475;
        Tue, 5 Oct 2021 01:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=yqOwy0PpDnXlKLbvm3VvBaFh/6mb0gmXE0jBLFYZ7ypqIjITJfAAlp1OUSvZUrGn4MLP
 uLFiol0TH3Co+6w6pWK7AHKVTiLs3qxg4QrFJoL6XlSCv/xgO+4SKTtiqBFrjIoA9BLX
 jgIo7y4khiAD4aP1GMwBuojcx+vvCLtobulS/KlNIP+4s1frrUx+2CskHDYYysxipDuK
 nSnruJd1Bwj+3o4fhT9j3o0aUcAuuxkT7rg6JYH9YLZB4QDIOWNKTL1z1pOImowHxB7Z
 sRQwxgo6n/66KQZ/rhkQqeanUF/Mr4MQE2aLqquK066YCcFuRrumP8hRNIRjmRVMsaqw Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHf1178354;
        Tue, 5 Oct 2021 01:30:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3bev8w02af-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osme9fZF+3pg0q5fYRCu4pswHC6IAYZ5bHCNe3Ba2qQs0cLGeaBJE8SVshZgIWlf5B/lqMJrfof5ATtps5eFsThEjO7YPyQNBhGhgn7zTs0K1ijVmBzQyAQagEkiTAOKPFofBIFuOOHQSQhRUZSwcSDg58lxTCEM0jcrs6RKtghcB/2XwLbjVjS68r6FAQWNjkknKN019bYeakGxNwj7x/AcBxhqAkAA+1Xk0NWQ8HPmFOT39mIbLDA7pGfh/UaqBAIIdgwkGjqO8WcVqJYSha5TxaVkIHf9uzybxozJmSQQnUyEFg4lW+e05aaRr7E2wqCpFyC58HcUJCNnxnJehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=RhzrN11vCnblrVt0pArNgIt2i3XDPTg4sf/KjDKZsMslwixR6iWIlnb7ZmTVjEBfWg9PpuaHEwGHiJ64y8BuAlVVuRDLlazR+972Ru5M99nDT/byteOonwyTERtC7IhVe/qs3cGdMtdAyC9hQUKXtK36MrxwaCJAKvh929H25sw3/YY4lSf1dxnoMdh1m7CNkmUgjknpWIn1eNJyGRxtZh5m9AB5MAkiVZ7sqSw5u79tMu/5UfCiqMDe2SSWIgIRFSmxvRFjUeYzNpNfwyHopZjMOM5uvSH8ek5P4mg9GPH0gkzbZ/2peHsuHHZmBWx4tonIz5i56sIQYQ0P1yLhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=pIIGs8rMyYolXIdTyWq3HGf3K8u6E2JCU3A2itJelSt8FR0yKmo/CMpsdwuN9RObgkXCydY1OfjdaYfgZKO781GWeUOLpJt6rJjKuAZFiTSwO+MHg7gHOxygYhVkQ8zEGVVmHAOWppDWuqkZSSP6YDWtqGUe17nTn1QFCfeJWPg=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:26 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 01/66] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v3 01/66] radix tree test suite: Add pr_err define
Thread-Index: AQHXuYiSVsyN0h6aF06R5yGbnbLKTw==
Date:   Tue, 5 Oct 2021 01:30:25 +0000
Message-ID: <20211005012959.1110504-2-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f13573a-ebc1-4920-388d-08d9879fb559
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB5218F10C64F47BD34464F30DFDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOb+WytmgYAB+EfKRCIbh3BJoo1RGfvtXJCTKJuVb9hh54bKWhPff2SDWDUOkwMJyDymt5gD5CJRSuVn26+csK3TrhzKfQkT94jBqbeF64PEgJKdPAhGyNPWO8Cr/u+cB8LMolyBmpC/ho6hOqTlLS0xhxKSpLXz+Mv9CilOMlZ0UVIp9qBUG3nkFnqemCwppQYlhyn8OCpnOokX7DtqGcJo/dz/hWCpFvtNVn55zYbzklXIqsBDZlUivhLb+1nFuc8s1ACOBVlSlILLiRRAJZMhX9bQgM2ScQn2IEVBYD91oxIPaNW9KVuFtHkZWrK0Ady0XxwWFQmgScscowxYG11FSyD8edL7kr/ma5Y/3AzwvMZ9f0Myzs1hPpiWuLVuG7bhb2MSWw8Y7fGh/JY6alTgyN1MwDh/pJAy86eQnjFo2fwbAiRkrLH+41ZWCBuV/O8KG/wH/39Y/vUJPGD+YmKhafJSPKu/H5R816w4l+GRHRInLuLKVZrAzrsvAmVCr2zWUC7dUJstJilird6sKxs0pCJ1KQZvletke378vdZ8KIDmPpGUbdALRrY+0R8OQkfD1oD9XQgt7T2+At+xwjex+LQljpLBzoQn1DTPgXJWbeeV3VjmEAWPDUFJWGwctRiL6jor2vrZqk6iQ9nXNxKd1VGDLcjREOm3vlNDSB1YSx0+o24XoIG+M9YnX0fGljXIJahBHpRD9GVF3YajUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(8936002)(71200400001)(4744005)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NpmhiOdcv24oRXmFxDUaT2pOk5TwSyi8GuF9KMF12dGilkbQZjMRyBLEi2?=
 =?iso-8859-1?Q?MsCmuS1CNgCQ6Wxp56KgLlXJ1G/zxvX3dvhHxRjaqjVfRzv7z8oNHBZK/w?=
 =?iso-8859-1?Q?L+uCZMwVONjLGef2D24VKIuEoh03FtnVB6QLozF65GFExgeolPYFkuvNAs?=
 =?iso-8859-1?Q?wuzfFPaFh/Csr82DxNcrqFBnJBu9bgAA3AVEZd/KUAd91oYbTNeqw88B3/?=
 =?iso-8859-1?Q?JqWQMycC4AmihL1UPq5DqUyxaB741djh/bowWkK0wbPcPV+c2SK4B23ssH?=
 =?iso-8859-1?Q?so/mJQSR/HMp51eAvxfKLpoeaQ92NkAyQBI98j5ZlQXxezQwaU/BQF4kdQ?=
 =?iso-8859-1?Q?oCNqMbYHvdr65xs1ZyCZkBQrv+l6yCeheLpvssiZEjCS0xTidUnTIomFOt?=
 =?iso-8859-1?Q?ZqALT0jpQs9JTXVRR8Up7qLufM+WR+4As6n1WsF5UfoOyx089I2j76CSdH?=
 =?iso-8859-1?Q?PDbbck45NL1rm4tBcBgYDuoYIgkJkOWO0Al4ri1jA1dBiCOyJ0x0k9HipT?=
 =?iso-8859-1?Q?4ikO/w+lE/wTDFoKYMBmBLEXxWXLoohytCnKEosGjOJQCWFkuV3NgVMGKV?=
 =?iso-8859-1?Q?qilAQBC4xZDHmD/2Klgd71ZTq8MLjgf+bjvXEWBL4D7mN9qsIOZA94ahYZ?=
 =?iso-8859-1?Q?43Shfm/KSWcdrYYUBVJBqmCvLuW+jtotdeCmKBSwLFoxQYPZsTgjPDo5jZ?=
 =?iso-8859-1?Q?ufNnAggqav+aklDM8rW3/gP8T5kqH31RJAJ3C2hTfCaEWkUZWHLltfQmif?=
 =?iso-8859-1?Q?E1U9R0pL6B1FnWQNyZ7yv0p485lM1jwz0fu/bcTdpZBo3ZXtWFUGBoQtVu?=
 =?iso-8859-1?Q?6USGE/2GAz2fuUla4PM+BTsNNL59jG790Jc15Mm7B4fsyxFBscQkQdytGe?=
 =?iso-8859-1?Q?nQJqkiBFEyl6N+1WCaUWfnmkkrfhjbi4v+zsl1cUb0otQHFqa+7Si499Cn?=
 =?iso-8859-1?Q?VA1sq64GEuD1fbCoIQJiyxdGhlqlgi5B5pTizP0BS2ezKydxNqoYPjOmos?=
 =?iso-8859-1?Q?fgzX3gKKE1fV/nkvM8blCFdLDNPSoCX0GQ7V87SZcKnZXXiVmajP1bx7cc?=
 =?iso-8859-1?Q?rNMoU7SzTb8n+rhaLUU2v64nsppJ7B7Yuw8tz4vxbsQs3XXnoQUASFacO0?=
 =?iso-8859-1?Q?WHWBp6jyEMDZ4iNtJNqkFYOC5CXekAgGfJbNTKL/tTyau9La/E7I6qyBH9?=
 =?iso-8859-1?Q?MZycWdr+Qg1ORKKh/r/MMcpl11zuSczQvEPV7cLqQoDe4oSBDlkNzpbyjK?=
 =?iso-8859-1?Q?ye1m79OtbaEMF8ma5nmDwVlFEjqNShgeOCSc7x3yVlVZ3MeLgC81FmdlE5?=
 =?iso-8859-1?Q?p25S+4w0u1SDTcY4M7soz5sLWR1G7l8lU5tHHBIOxdbePH3FJRhI5qIMC8?=
 =?iso-8859-1?Q?FSTFosnxIF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f13573a-ebc1-4920-388d-08d9879fb559
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:25.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTYyyxh5zghGfS9+YMYtsGQf+9EsdGrD6u5sjz+MM9O0ZM9L0sEAlTrdjabJCNeuGve6uBPSp8+DTZ0mT1p7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 28XLUdUrJZjM2vWlyajWk-nKVcnsJ8zF
X-Proofpoint-ORIG-GUID: 28XLUdUrJZjM2vWlyajWk-nKVcnsJ8zF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.30.2
