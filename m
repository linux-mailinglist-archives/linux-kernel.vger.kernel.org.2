Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA540FDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbhIQQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:19:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44600 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhIQQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:19:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HFwrZv027370;
        Fri, 17 Sep 2021 16:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jUqG/ypkDUPa0YvYvkyvi1Lspd2LSJFerD3NKqY2gno=;
 b=WWQHdVUmp3OuuGi5Mk/e+jq5MIrkh4X2rXQsmWXciyb53eRv4FlnwD5KsoTk+OAvfw03
 5ofFdHiQs5T3d8gz7+4terdnQUEH0npeEal/GLWpv2I85ekVvh7pV9Ob+DSXVaa9RTCY
 N1lg+tLJ3s+feoKmcJtvRxFOYsY44PeS2oeqVK7IOE08VG/B9gzL5Cd2oCGlW2n5mjxY
 nFfTzstMPVdFR5SEywpAk3R4F2Lia2CpWVlEWNm3P8kr/olGADlqbttrK8UBmEYAUR7O
 w9ecyQudf/m4UHvVjd5Gw49Ub3NqqsrlfP80xm7O4a6ztLSmQM/1Fs7oWZH3oU8Z1OQ8 tQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=jUqG/ypkDUPa0YvYvkyvi1Lspd2LSJFerD3NKqY2gno=;
 b=eLPQ0+QuYUdWETYGpqChBve6zukgMNsLUweBu2K5rQR3dY8cIJG5ATiiugkp7zGbzxMV
 +fKlxioRjeynL576rnugLnu48y5cApjwv4mTzR9FrasikWcS0EFsxIQbuC0ZpPPhc3T8
 aDAnApg6Jo3fG7jwAF6dFDo/ioztDPPhL89gUIpg5XpSQZsg4ivZJ0rwmLGPHWYx6rfC
 fftdJFII9Z2vfDvhvTdS4M7U4e8z3WI/Owc78EnQPcSo5+mg8m4gTd85R7qY0Tury/f3
 YGVXZ/iX1LkT56KSxQrxTmzAm6ZJ6T9OM19HK+tqzSMG6I4LmtS0LTqdjCtCCRRNMAI1 tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4qv9hfcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:17:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HGAhSS012568;
        Fri, 17 Sep 2021 16:17:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3030.oracle.com with ESMTP id 3b0jghujgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:17:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3Rbd3PUsU3vhzNKS67N7xsWuQ1VozBVVuJ9jsi5zgb5Dqt4dySRtM0RUrrEgBGH4wWRcU6rg4K2uEFDK5XGMnGVSJCiMjPOGplw1O5Nw/L0XSZZoLA1w9u/yuCrizJYkkK7v6/kvPZjtoshQI74rzvCrGWLt4yeqth1S9pboSjaZ5WZFy0hxywkZ3l1D+P0K7kyX6txv+Cd1I8OkvL8kEe7Hfsedvesf4Baz8ZMbultbUCRZK9+xwAA7Ooo0FOhmExhpmRrM59puJUZj7EDP5lXZic62z8m6Jf/f/WLFelOzbbdxEWmpNabjxxZlHca3aiu2UIDRqUDC+znYBUQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jUqG/ypkDUPa0YvYvkyvi1Lspd2LSJFerD3NKqY2gno=;
 b=Zf7RT2yqJ0cJk0E+86fGOniu/uY8zfW19Ds4UK7MhsfEbJg2JO6/N8H9dOmbN4bu8UPVX6L8ADp/gDbKmLg6cQJ67mIHELgn6HHD9f1iPaK+mO8SEX7hl9GpTASMMn4o3N36Sk7sU3UxpcPWR0b5xG0AbRWy7lQzunGLOrT/YyeHbeVk1Ubt0iTtS71Gfp2St9IVf6fJIUGGomYzZthggW+bUbUFUhetCvFBSqYdr4sUM5CQZlXsR3w8ZcNCiGXGN//5ppME8WouwrzjZD4Z4fV9mQW3CJM9wXefvdsJu93zA731TIuz/PpBcxm9tF/3NDP1O8QlIDso/BYKPiHT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUqG/ypkDUPa0YvYvkyvi1Lspd2LSJFerD3NKqY2gno=;
 b=hFAPO0XN4JmDo9ql4FGPPjGk/TazSvnl56uiuywf/AIuvqOgu8OiFZoo42pWbTMOPBeSwADXe69/nnrOL7fVrM6ONnF9XRr/pWgv4sHAtHJOaThVJ018IsWgYQxyNUIWOq0wxyKcjH4ksILi4guBgS+ra2vItBK9yrSf6/QssU8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 16:17:08 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4500.018; Fri, 17 Sep 2021
 16:17:08 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
        roger.pau@citrix.com, jgross@suse.com, sstabellini@kernel.org,
        hch@infradead.org
Subject: [PATCH] Mainternership changes.
Date:   Fri, 17 Sep 2021 12:16:50 -0400
Message-Id: <20210917161652.2431563-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (209.17.40.42) by SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 16:17:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04fed80-2d2f-4ce0-9415-08d979f6987f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4065D949F6ACC27FAEABAF8D89DD9@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSAzwnW5blG931/CyBs+I/rdA59/jeP1GtEYBs0l9Cf+FYQmmN4Wd+isBISNy49MDmYyOQ2lrvok2CfT45fw9br8Bm8FRObkPp9G18s5vqr4u9Jte2J8jLnU7JBBRbX1Hp0Q5LGOQ5xEWitpm3z3AnJ2Szx1YCAz/26wmIpCP57ZXN28egDeqGtIEANPZIvxiCkoZw5pJ6qFMKL3GVXpO+h2aXUkBK5TOG0eCqu0BUTq61qQMoo/NdvKQKzoeSITCTkAMzgSxsXca+Dpmtv/iOUG3QzlHIwHVliD5eq0FoCW2Gzu/J6Gxa4sdX8KIB5y1AwiLKsZBMkQBETF7jkmGv05n3rvsBAU+uUMu6vdbNd+t8TdbtS7LRvp07zvEnixm7NZksnuV9Za7M8jpKMcyZyeKER/almowoC1thqPDY7DkBh/PWa0GrZNdzjxXXeID9PlXC1866Ev5+bXEwbVvaJzUpHCn2Fw7GVVo8Z4F+NGS0ylkH+fbHIHng1gZNZy+Zfb6HgFVcRFp5LCFCmjWH5mP6eS9wo7yg2mmKLIXXUhJ4B0SkFYt9bgFeqljksECp7kHkIOMVOe0lS8gfzklqm7y4KutpA6xK1forPR0VcgZKKTrbL0tfeQRN4eZ7wqeDc3E8PVZre1kVNZEyVUNa3QWMCElCH6Ep1RBHllp0b+SHBcuJF0p0UMm5nSZYcUR3TfqDSQcXDxD9dLQBWwoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(6666004)(186003)(8676002)(86362001)(52116002)(26005)(8936002)(956004)(2616005)(1076003)(6512007)(38350700002)(66556008)(316002)(66476007)(66946007)(6506007)(4744005)(6486002)(38100700002)(2906002)(5660300002)(478600001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Io9tjyaHy9H8meMoAgocYMjjxQVvc1llPsA8iKs8I+7obPnU+NFXz9WCEkRz?=
 =?us-ascii?Q?uNSkNf9BMOd6vBbUPlknf3gYuSKDRlAk7DuLysnUDDb67ZpOZ7MkLfch1NRF?=
 =?us-ascii?Q?U53nufjNUI8fJ5CV/9oUxKnnyA25RjMUT60PVD3BaGVHmXOde099inJN9Nli?=
 =?us-ascii?Q?ApcS5qlw/+G8qLcWUZXZaFPqWi5HB5qnaMPt/x1VLLpLOP9mOBe9esH92/Y2?=
 =?us-ascii?Q?K3b+R5gxowjXMKLEnLhpoR86Xf3VeTwAtX9ekAr4Aphczb4e6s8KlwTdc7+x?=
 =?us-ascii?Q?0rKXSJAaIRMqOkYfuKCewT6/ds4V3gymd64h4cvMTa8ONosRSE5bSf7tqFyq?=
 =?us-ascii?Q?2hx/MGHQQn6ej1OApRviDlymKo+JbCtiUXRVZ24IT9ZDZZQh4jAfnPpHN09g?=
 =?us-ascii?Q?7Ly6XUJoVmv3XpvwfRK7BYyLDMBRjavNwqeDoXGxuzxaGnGS/lSLJLyTEEzx?=
 =?us-ascii?Q?2Mr5E+3EuxY9tD/q28++X1BtpSNZFBaTj+v7KX0eFUUM292u69TynipAlkvG?=
 =?us-ascii?Q?UqNJwmaqWfXVInwIUU+9ElV5cmgqpB/azpwKUd7h4ei+Re2FeE4nFv83Dkd+?=
 =?us-ascii?Q?y5lK+V6c5wgVWUBuGVKeKxrTRbMG2uxx1vCikzw5HmvHLcNFpobRviqm1Ixd?=
 =?us-ascii?Q?FwKvT3AzZ22fJ+qQUGgUVLPjGwFYBmHGLFuzkuCxkB3KM9N5KHY5A2XuBLJ9?=
 =?us-ascii?Q?CjjGa1F9zB3czOys2ys4EeRsKhzVi3PFjSinkQPW7neB2qI/0k54e7M2DRnv?=
 =?us-ascii?Q?TEhqzxuyMew/mF3RtuL8PkmX/o9Hknze9ldjZNgLpMtVMHn/rz1USudICu12?=
 =?us-ascii?Q?DIjYvi5pq5xewZbZsiaVHMO0RsKzYXEqMr/HvZkjoPYOyKsXrx58gLL1RSOA?=
 =?us-ascii?Q?Oggl7j5iTn1x/mFLkejfX+ddip8o8QNjGvs/+gUz8R0HRFzG37N4mAtFk7Jv?=
 =?us-ascii?Q?u7WGjsG0SdJuPdU6hkRY7Iswf0uj9Q/e+FM8kc8LCIp0Z3Bx2R0c43x9qifj?=
 =?us-ascii?Q?TCYnvYExwnECQTLrXMlrJU4lsfuUJOf7i8HB1AtO3Cn0vXcwEcACo2iROvd1?=
 =?us-ascii?Q?NRTohOTvxJ6frKionJBoRI3EvCC1PUWHo/k37pL4bSSkjvW38GF1EGgTGshb?=
 =?us-ascii?Q?Ea+0NU08HDv9gXynXVzHk9eoMjBEnlq0cGt2btF87/AgYKFlO7Nf9lwUoP86?=
 =?us-ascii?Q?XGOvESOidyjaXdrsXHH8/hAYYTvEDMp4zxhmatfxGhpDU7AFqbMNZ2w/D5j3?=
 =?us-ascii?Q?rYvLTL8dbIiEj79wcLarJoTheT10NQ2P4zVOlcY5i/Xi3Ba591GTeFI6C6gV?=
 =?us-ascii?Q?xBjP2uEDgpodyF3Cysnr4UdU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04fed80-2d2f-4ce0-9415-08d979f6987f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 16:17:07.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttBaZvxebsSWqfy45NIw1S4chrmot1R2t79LoNksiBwh0gG5Yn7ghivtaAe6Jk1IgfOFNNmJ9reRj9SftQ8mPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=752 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170099
X-Proofpoint-ORIG-GUID: SWincw2gQrmp35PoQPIOvECXT6HkPzTb
X-Proofpoint-GUID: SWincw2gQrmp35PoQPIOvECXT6HkPzTb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heya folks,

I am finding that I don't have enough time to be a responsive maintainer
as such I am handing it off.

 MAINTAINERS | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Konrad Rzeszutek Wilk (2):
      MAINTAINERS: Update SWIOTLB maintainership
      MAINTAINERS: Update Xen-[PCI,SWIOTLB,Block] maintainership


