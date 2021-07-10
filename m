Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A946C3C34ED
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhGJOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 10:54:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229805AbhGJOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 10:54:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16AD3AZN023118;
        Sat, 10 Jul 2021 14:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=PdZNTG2Uostk1/W54fKGIApXPUkA2P6zTjRY472nrGM=;
 b=ZH5f6MWbsEd78DOmAgKfqfu2E3MNiKl9ULwr3EW3Z/Z1FANs3rfUNafTW4lqwxvAtROd
 SbsNep+OymG5c2N1xcJPSMG5UE56ArSKLLTCMA1DI1iEGOqetaa9yASnqcCn/3cuvuii
 qYMKvN3jP17XD0zWFzB8dIRfdkC7mFhCuTJAPV0ksMlmL+BCPhXDkH+xfDpgtUnFDlJc
 e3vXEoRoTUkqyvC+auu+WFODl+1Bf/sjE3IgPNSYFG9LfV6RuVmYhT9npYAAQ1f+YlwV
 kiCHDR4Z2DYEpzHZRJHkr/RD6rOGoruKGssgmvtJT8/QsAxiP3/MH/1Gb5Nbd8Ik8FUq 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39q2b2gfg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 14:51:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16ABZgir042679;
        Sat, 10 Jul 2021 14:51:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 39q0nv0k9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 14:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUdkiSuvna1CATSddRYI/c95os5OXkf/gQx3PbFk7ay7wViPNOKU3IqWrJU0mgd46Lg/zdYpoHQA6WJIUlbaQxJJVI+2j5iLNh50+2Fg/ooTMPj2Ef+FA9KMsB75GIizgRqHO08B4b3HLuVoIP1pNQW69jK27OAVDdIyUVurGSKPaIhnas6JyAIQXOChQb0iL/vVzvsKX02prfLeJnbIePC6x0/tqXO55aN5VpXp2fpwEDPpKqAaf5F/m7pKPSbMQ56BREnvuQV7Oo1182mm/RtozMYAGc12TBobZOQBKqiMiGQcrfU/72/z4YyGWGObxnZ61ISus4EVvuMs77FNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2z1qgQ6d9+EEvvn96KcFzmM4EBj86MWuAkG+B97uRs=;
 b=b3QiHQtjfDdE592GJ+3lRWIEVErDwYxCvSypHu/LqaU4I5SnsOslUqiZ+z2UOY1PIPNQ+f77wlU8QzV2xbUFRjhIzt9HNWHOlqtpcx0j3qNY3f2xNf+rNfUPmY+tE36ox3r8UI5RGCajF1Xh6o9dt3nFHFyHYIef5/UINOLGS3BoSpCAh8q+o6OtV1+6GmS0SlMy5xeR+0HqwbH5Qn2f3tnxKB+194a9dGjlnUKIeIRhnEjVG3nh2jEz8HbV4cMYi3Qk6QJHLn1EECAUyms1dxR9rjbuSM5AAXcSrZ/SHL+4HyEBtVb+4newQCWRvy0hPhHN82b3IkepgixT+QbwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2z1qgQ6d9+EEvvn96KcFzmM4EBj86MWuAkG+B97uRs=;
 b=iPWki/rWra1SHpNMMQ3afTFOaqqJFXCF3wfG8JcPzSFCYlnB+49mD3IVV1sk22CO1OJQL6GKfFWE5ION7L6afoqQAdY7kRP/pLfu5KJkRismSrZtVd1MxwjWMkaARbi9rwztt8gVuvusjzxTHBt8N5F9CV6syKJ7vYuzDeut/vA=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1486.namprd10.prod.outlook.com
 (2603:10b6:300:24::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Sat, 10 Jul
 2021 14:51:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Sat, 10 Jul 2021
 14:51:37 +0000
Date:   Sat, 10 Jul 2021 17:51:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-01 1/3] kernel/bpf/pifomap.c:149
 pifo_map_lookup_elem() error: uninitialized symbol 'pkt'.
Message-ID: <202107100443.yNr9SYE7-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Sat, 10 Jul 2021 14:51:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f732b6de-28fa-4014-1742-08d943b237ac
X-MS-TrafficTypeDiagnostic: MWHPR10MB1486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1486898D31A77276B3A3C9928E179@MWHPR10MB1486.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIYMcVdCGKAyvLH4JA/jHnNZw699vd+/GoIcqYsOlW1WONqVlsIhXvUcR6OC1zN4HZaD0Vae+X42Mmxhocn3MJ632hHJmAIdA06jnmVntjceh2iGCWciliCkrh9KWGOgFO78l5USAKB4qIBT2jtMT9U5jIIKhFP16WGoQPbQ7YB2frV+H+ZIqWZZXRURbybbywrAFeu20puaXRoFIM3d2ktUc42q8I/ziU1Ei6S0wUxw4Ebhog0WkdG+764shRU0MoxJ/Lo49Kf/Yx9QKHeiIF7SGjkpKTMLAczSEt4X1ZRNlv53RMw48b4b44cs0b/y5D/x617kHKpWH38EMRopyiJKne0bvDi/I0kwsSha207W06EMFOmquEMPxvoliz5EUbA6AAr63CCrjAMtj7KIxF/L7RIszXOyxLpVfRG0gBxtP8QGm2m5ArL06wJaonyWKMXaNm3ekXm+Ef418UxUJOU7DiJt9X3FBM0Jvzu1V1mCJzouyfMfRjcAlRAAZOgxESyaBq5NJEEQ8wXlN7faO9cPNPKWaNtQjbcVcoUBX9c3a0lJKlpbGpmmUFWW6VTu7ANRSW9OpQpPtuV8qe3Ko1JKFa72rfJp8tFDWZgw7wD9BBkSrfr/6/RpbRJXyUcilXax/ODcj5Z1UbVS0FSBfXnreCjzIDzzcomn5kfZGSqnEV90y+H1W00pBa7xVubJYa059W0c0OjNvHRbuDUz0Lv9lo/4KmWYDpcden33Cn2+XgU+Pej8L8cFaBdPYs/2blOS4uebwDx9xz338QweB3fIJGHUimByDZOMVQLLJuF9ALg+/T8driYPf8f5cH2tsMPgdyz7Peozl/14esFpIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(44832011)(1076003)(66556008)(66476007)(66946007)(6916009)(38350700002)(478600001)(38100700002)(5660300002)(8676002)(966005)(9686003)(316002)(6486002)(186003)(26005)(36756003)(83380400001)(956004)(6666004)(86362001)(6496006)(2906002)(4326008)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?S/FvXFCIUXT48zzNhPYnkqIDrC+GtGxMMZgi+JUHqJOVHDUsshW9jEn1Za?=
 =?iso-8859-1?Q?1guP7y25OVrd8bruCicJPNH4PpvsnLt6uQ+QGH4CbXQmnwazTNJXizHB9k?=
 =?iso-8859-1?Q?J1QcEXB1DRkcPFagYhqiOF0r4MJ9yWXjU39ltouT2kse2iORXnM5jlgVeP?=
 =?iso-8859-1?Q?lQY5UjKewp7ydSZhlrs7/A5qYX0+M2FcLjaleuLtEG420FMZ0J91uDm/sL?=
 =?iso-8859-1?Q?84ONuTQVRrNnkP/RxaAUak/HT93PYKnPneE9ffrO/3f/309r54+GAsTrDs?=
 =?iso-8859-1?Q?9MbYGgYdr+eHrMYZbH+cgO2R/ehtO/1Z7Uv6rBU9lBt15EbQj+ZklCE4Ks?=
 =?iso-8859-1?Q?zpBBwj70lzUJU1ZAkCJf6NW7JX6hq2U2kS/bFb+fp/qLOahvgVohs1s5T1?=
 =?iso-8859-1?Q?82Pu/8JmHJU2cPaUhA9Ag5BjPNStX/OqK71sd8NP+qzHIz81jM5YcBlRcq?=
 =?iso-8859-1?Q?CxDyWic4Lx0NGG8i/1hmcOTtjqt7gVuY8enYu6lOC68ZNwaONlhGTrxcTX?=
 =?iso-8859-1?Q?Mc5odwK/QGjfstBFyaeaeSJ+ZkqUfieo4GBRI/G+/T9b+B882n/PzgPYzq?=
 =?iso-8859-1?Q?8nTluQSqOLi6uuorNR9TTQVpwOlTBJP5rHjLE5l6Lzx7q5vCfbRNgd2aFq?=
 =?iso-8859-1?Q?IULEcQ8RkvnRkzrfk15DLxF5XJjXGHGYFXLZvPncZ7hQ8YIuqncKMbx0ev?=
 =?iso-8859-1?Q?wpQgagvj69fQcvvG5rU6TkqcEh16juaU3N1q67WFE7RpweZexBenRPlhhy?=
 =?iso-8859-1?Q?IHsjd1A8hREP/mkZ1lmtVu4UVaJlGSh34yOysvKnnUBHnwiLjqDoWg1wG/?=
 =?iso-8859-1?Q?yEvuyexe1ce/KDI42I828hRanfD+0NuuA4HZknLy8O0a0r9C+/yk+OSA7z?=
 =?iso-8859-1?Q?0pEGSrGUWvLEubyag2QAAioZEplmV8WCe6fCDKcdaV9vegliv7G5t+i+E3?=
 =?iso-8859-1?Q?IMPEqd/UXWTFJe7n2NmOfi2ry7MBx2cnp4Rc1AwDHHsEg1YXHpJdseD6oi?=
 =?iso-8859-1?Q?8l+j71jGwA9eX3d9r1a9Gv6XI9TZTO5Qeltj00wOvrKXe6PZdyVrj0tKHH?=
 =?iso-8859-1?Q?O8LFEphDSNqVOepCBBtxE1mNcjvzzQ5Ynbino7RcSmxI1mpi6Izj7Dejh1?=
 =?iso-8859-1?Q?RpHCZUfoItjsz7fvk59tk9DYVKKdrPRvd5S3x1pVUQg9+/BzrK56sfUeMM?=
 =?iso-8859-1?Q?vioyoLPlesGdLlDnYFWJp4+EiM+YbHzzSgGDXA4VkETUf5aFbndb/yDt6n?=
 =?iso-8859-1?Q?zW/Ri8FAFnRNnFsKBa4OZzHL1/lhNi69Y159pXXtSYJNGRUTDsgop3iE1P?=
 =?iso-8859-1?Q?JIuQ9o7RZzKCmckhuhYLH85tnW3NvUON7LtHro+qilxK1K50GTEuOfpO3T?=
 =?iso-8859-1?Q?RZNzKzE2D8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f732b6de-28fa-4014-1742-08d943b237ac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 14:51:37.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofkYb8DJkUN4uLbO9e2Pkx7taQPAm3ItgzS+MJUtzXxf+2yuQCemYIeYDDdko1jkqf8lepOwOpxXiiAUiRxfJs91hvClKB09UBzF4llocDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1486
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107100024
X-Proofpoint-GUID: oDC1zaZWhPYq29I4FhXNfS4pAPhslpsD
X-Proofpoint-ORIG-GUID: oDC1zaZWhPYq29I4FhXNfS4pAPhslpsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-01
head:   6b5756c44933d2b55e5e59e1196ef95894203cf7
commit: b8d0d0f924c237daf55b430a85007bd41ad01d7e [1/3] Add a PIFO map type for queueing packets
config: i386-randconfig-m021-20210709 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/bpf/pifomap.c:149 pifo_map_lookup_elem() error: uninitialized symbol 'pkt'.

vim +/pkt +149 kernel/bpf/pifomap.c

b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  140  static void *pifo_map_lookup_elem(struct bpf_map *map, void *key)
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  141  {
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  142  	struct bpf_pifo_map *pifo = container_of(map, struct bpf_pifo_map, map);
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  143  	struct bpf_pifo_pkt *pkt;
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  144  	u32 pktid =  *(u32 *)key;
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  145  
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  146  	if (pktid < pifo->qsize)
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  147  		pkt = &pifo->q[pktid];

Not initialized on else path.

b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  148  
b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30 @149  	return pkt ? &pkt->pkt_id : NULL;
                                                               ^^^

b8d0d0f924c237 Toke Høiland-Jørgensen 2021-06-30  150  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

