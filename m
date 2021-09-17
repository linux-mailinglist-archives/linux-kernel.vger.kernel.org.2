Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6540FDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbhIQQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:19:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46184 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239720AbhIQQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:19:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HFwpGp015161;
        Fri, 17 Sep 2021 16:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5wUVzIQopH2a/4k8gL+G1vhtAw/3lVT5LkGhNPXcGUQ=;
 b=QqpZp97GgC4n80SmfuyYp3yhEIFzs0MqhaVMjZAM6TReWKTTA0QFhyX+qCrZQH/QIV9J
 EvFVALgtGuisHa3qCKAfykglQn/E14ogss77QSb0IF0s7DoqcZqEoqcxGd/bpCbr3vmV
 gtyHI1JRbZ1SBaMEu+nKd5G+LoS+/Aea3A2pAw5gIIkqi1b4FtVhzECi04N48payXTFo
 85EswGNg0qRdbM6kygbq+lVNIl2bbtRY1rZnwUrnK9O7dqDuB9B8A/mkRoLSqY3SqcwT
 2yNMEE2Xnb4CyBIo6b+YLW+NUwGtZmgJcZ43PoDrohPS3iolB78Pwg4Pbxf6oG0pBUy7 FA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5wUVzIQopH2a/4k8gL+G1vhtAw/3lVT5LkGhNPXcGUQ=;
 b=kPJ1I1TqOzJSe2AUecvzHs3HIlCwOQbkl/D8nUC/ul16mDgLWsGRrlYRBhdrs6/c2CBU
 bUsVJLwTqPgiCvpR+8dA7qm5pqfg3HMtdKSrLuH069WisRttnf96/HvhbT0+9Azig95y
 Wi46xCrYVRJjpae8DGvEyng7hfoSNEIyMCWsaC4XpmKm64wqCpINULW9pOBXsUe75oT2
 fIvTWluJjRxcIHqRigyuT/p00Se87bLq17dRYBBvML0NOPRtEA4lPCN5bhlycuRY+OzJ
 psyGjXTgA5G+qivHWOlhb0kn74ZgHgf+L0xk8AP9Ot5yn3a8l4517u6DLLh3ULXCp4Mh yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4vvy0dse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:17:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HGAhHW012571;
        Fri, 17 Sep 2021 16:17:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3b0jghujj6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYK+c27LEd0C6jB8mjRYCQz3Zm3CpUgi88fVbNyNqJ+arPbQYjHgkeOXZVxXfNbjXaUENfx2gGKvGhPtijz9NgeVz1XiSr3K4mOxNTz7AX4juJiF2kr9eTjB4hHzcL6h2lxbqESU/cXAampaNNXw1Glm79aqsjCp2QudSsCW8Zyc2XTKSteXbqxaM8zEFkbrQdxGyADsdMyfbZKOopDd+9k96OONvTtZpP8qUGouu1/xEsoUo6TYEC5rAngxdjrE7uKI89cSvtJt/FKxenWiwx9+QLjG2fGO382UvFumirc1JDVYTgNtjXBfXFFUC1fucrk5UfzggO3zFVNNhy2zeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5wUVzIQopH2a/4k8gL+G1vhtAw/3lVT5LkGhNPXcGUQ=;
 b=cc+2lqUTD1rak6h80HvmcdpPfRav+3EHlq1vN+qdl7XTvkcy1R3J9lSgzRuzyFJfHx6Mf+fzdmnDi5OTR14d2Myy0pBdBnx8gwayD7unB8z4rGGtKjVmHzV0nDKLVyoUsH5rHBdSF8XyY9SsZK7NqRWFecqKM/5G2dKdbchrjOad8obbAoohTTjbOFFDeyygV9E4Psmk72W2ZX1V04WeV5vFSXoZxy5/8zB9HE/3tYdtUQOCeabtlD8IFUzdaPxz8o6ieS9RB1tp6+q+J9xxm5SwlTHkNRMZoofUnPFHL5VR4epDMPEOJUMPgmFjSR4CwXUewJ+bdPn3ee41vzs7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wUVzIQopH2a/4k8gL+G1vhtAw/3lVT5LkGhNPXcGUQ=;
 b=Xc+csHL5MpGTLl51ySVf7NCw56jrnv5ws4iGK+pZBlACloNbjJzd240YwYxQVPpfzPkUX/qrFG99ftXhFdTUIM7FlhdsCUA4KoF4+yKJ8fbHoaDvmUI7eYKmXMyHwsQZoaT4YmmVDerenU8Xw7jnVkYsOzUbl+WDVxu0MDmGum8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 16:17:10 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4500.018; Fri, 17 Sep 2021
 16:17:10 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
        roger.pau@citrix.com, jgross@suse.com, sstabellini@kernel.org,
        hch@infradead.org
Subject: [PATCH 2/2] MAINTAINERS: Update Xen-[PCI,SWIOTLB,Block] maintainership
Date:   Fri, 17 Sep 2021 12:16:52 -0400
Message-Id: <20210917161652.2431563-3-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210917161652.2431563-1-konrad.wilk@oracle.com>
References: <20210917161652.2431563-1-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (209.17.40.42) by SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 16:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d900e5d-e0da-4e2c-f0c2-08d979f69a1b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB40652E22CB6418D39A34AA5989DD9@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SMbA5vSAM63/fmEEu1xYz+gMJgmvwaT43LAX9fBMXnL+v4DMAeRkkOhxMj1M2vSnoK0YXJ+z1LTbbO4daaMxjC9terJ+90Kf4Dz3Rg5qIt4vd369jDsBGJSMvxN2Um7YWeae25+vufAGPI1qMOmZ3RlHQx/QKrbnfj+uJDkPAj9SyEMZsZTC0pHeuvdO3/oZQsXUCSkoamVDnMJaGiK6HDgfkjxGYGBrFLdnnbBsBow/G/JSdpjgQy53FNfqLUgtgTd/N6okikG5R8n7LsRQXgYQqVqQ9kMp0jp36ychG8f2wRzKbOtqPahJNmQV33TWHsPZundVSHoOTIdC4FMYjNUHmtbUFlxzbPV/LWmONd+TpbNLSftG8DxpiHlxDNsOQyK5LUCtnrYelfQGvQffQ8cUBKUHMHLvohWgoeNaAvNmeqyBieSRDR9sRHZJ0OHyLdWWs9Tf7v3LCQaIpcwEP2f4H+Dze41Izqfy3VfIf+9oiE0xstjWwQX3tAUopCvbWHuMgCt84hNVrB43KKWnXFEIdw1+IGhmv+o2yjtVd5udlwEfZd/tYs+bS0+e0g9rORDdMzKD6PgmgDcPzW0jraVrWwQaP7JZs+h5a7jZbji7yJnb9Oy8kKwNSbQvEEpjoBY2ERUPdVLW4wiMEw3S1JPNXLpxgeYPfkRbU7UABg6TvzP7/6caBM4X9KcJ69GPi54RMmpOua6lUbD9RXxWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(6666004)(186003)(8676002)(86362001)(52116002)(26005)(8936002)(956004)(2616005)(1076003)(6512007)(38350700002)(66556008)(316002)(66476007)(66946007)(6506007)(6486002)(38100700002)(2906002)(5660300002)(478600001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1reWQ3cm1BUndnM1RwMkkwM1FsYUU2bXRPK1ptOHJLRE1vNjBVTW1VL2hD?=
 =?utf-8?B?akFYSzFxK3hVTHlKNm90K3JCVFRPRUZQZ3hBU2JaNGtWZ0F0aXZ0dVRiVEdm?=
 =?utf-8?B?eHZHUFo4SlJ4MWhPU05RdVNqUHd5M2FyVkJyV3RwNGpENlRMUVpNWnpSbGtC?=
 =?utf-8?B?SjBPTUxwQmtsZmp4dVptMHBCMWhYMEhZbUF2RmlmNXBNOThPN0dHYVdwUGVt?=
 =?utf-8?B?V1A4QWMvVUN6UEJXK0JDdktlbm5GcTdtRkFDclM2aC8xUmJLcDVvL2J2RzFS?=
 =?utf-8?B?Rm5Cb3lVQ2VLRW8xRnpBZW9XVURxVW9qWXQzT283NnhoVXRvUXR0b0YwNStL?=
 =?utf-8?B?RXNaN1FTcUNhNThWTTZCcWpEcFVVR1R5b3lTUlkyUFlnZzY5MWF2QXVzTXov?=
 =?utf-8?B?VEV4VFdmd0lLRklld0FCQTJlTGtsT0psRjBPSTVrdi9WeTR4SjVjRXFGSUtD?=
 =?utf-8?B?RVFkTEFLcXNJaUY1QkhoTW0zZ05PNHFKdTJSTGNxdm5JNGRwVFA0L0M0VnYv?=
 =?utf-8?B?VGhyWXJ2ZEwxUUIzTXVzSU5FME50UmRoVm1Sa3JDdjQ1ek1XSVBlakRBOXlR?=
 =?utf-8?B?cDQ2QmRtYjFrWHZjRTNOd1NFUDVXU0c3RFhHVUZ1NDhJcUtUcmtYSi9vaHN6?=
 =?utf-8?B?RXhrRjBDa0JNSGpXSE5wSWh3dlV4SDQybjYzUElMVVVRYWpvcm9RSDloRmQ1?=
 =?utf-8?B?VlkwcTZ1dXJVQ05JZE5DdGZHdnlpNU5zcWt0WUY4dmhCaU9xbmViUDAxelI5?=
 =?utf-8?B?QXE5SEd3RFJWRDNMVERVaU04VDFGUUF3aGY3WUNnZW1uKzUxZkFnbVozVklk?=
 =?utf-8?B?OWFXdFMxdksxK3ROYlc0bmxkazI3OE5POFhyay9ON0c4MklQT1hJOTJ6Rkdv?=
 =?utf-8?B?Y3RKMGRLR1JSZ0hYZ1JQbHQ1QUdSN3RMUUNoQ0RFODE2dHRhZUVWbk5nNkRE?=
 =?utf-8?B?N2xnNlhjWGwzRkpySjhlVnl4U0F5TmcyWEV6T2w3VmIvZ082QkVua0ErRzFx?=
 =?utf-8?B?a0xVY2dOa2pzWDZ2d0txMS91RkE5ZFRlUmtkZHlYR2FtVjRYekRvZmx2QjA5?=
 =?utf-8?B?Nk1UN0hXOHdhY2N2bU5YalZGakRBZ29ZMGxZS0VsbFN5eFNVbTFXYksxWnBU?=
 =?utf-8?B?dTE1cnNRYkcrTTUvUy83enI3Y1JvRGJ4Z1ZMTWFkTFA1ZS9BcEVpRUI0bGND?=
 =?utf-8?B?c3MyQWdGSUgybVdVLzhqZGFwcFRZSXFjbktXMzloSmtCeC9RT3AzYlRuZEt2?=
 =?utf-8?B?SGp5QXhSa1VUUEtqM2szbUJ6OE5kd1FBYjlhUkVXdG1La2tleFBWQVBRTnpr?=
 =?utf-8?B?N010b3hiQkZ5NkhlTXV4RWcrTlQ5eXc4MDNKaTI3THltZkp3Sm9uLytGMHRz?=
 =?utf-8?B?dG5QT1p3anBQdDVLVjFXcUZrQ0ZGREZyRi82cy84c3VZMERWQjdIby83Qkp4?=
 =?utf-8?B?NHkvUGZQSmNwNFdFWnJDWUZLUzlrL2JlSDBOS294WDRQdlp4QkwxblQ0ZnE4?=
 =?utf-8?B?SlRHVFR6NG02RzNSbEwyWitnOEdnSVlaNGlQbExVRnhwaUcrOWdmTnlucEJ6?=
 =?utf-8?B?aVl0VUQ0WEgvNG5paWxkN3RvVEs1MTE5VFpqTytQaVN0RUY0UURCOHJiSHll?=
 =?utf-8?B?a1BPWEF2SjFOOGJaMC9FbDFBK1oxNWRvTFR6aE93dHRiVlhXdGNMTExiL2h3?=
 =?utf-8?B?bmhxczhuWm16M0g3VE12NWN6V2lqbWNFZUtIZ09sTGRybW5GTEpsSW9QQVpj?=
 =?utf-8?Q?TDXzznYJbUhpNE5X87iFO99+Krl3IjOpjgtjUsn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d900e5d-e0da-4e2c-f0c2-08d979f69a1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 16:17:10.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXAvh61iiHDF7FGVu7y/zmBxKRBstcNAbe+KxZ6INfSuwhMAdABIiV5//jGsm9PIc9V7Y/qCCWG/J3DDWG1GYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170099
X-Proofpoint-GUID: oMn96HfuKsg9wty8IzDJ0IRz5RAHOMbw
X-Proofpoint-ORIG-GUID: oMn96HfuKsg9wty8IzDJ0IRz5RAHOMbw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad's new job role is putting a serious cramp on him
being a responsive maintainer and as such he is handing off
the reins to Juergen, Roger, and Stefano.

Thank you!

Acked-by: Juergen Gross <jgross@suse.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 084f7af20ca4..dd5cfd39e1b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20475,7 +20475,6 @@ F:	samples/bpf/xdpsock*
 F:	tools/lib/bpf/xsk*
 
 XEN BLOCK SUBSYSTEM
-M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 M:	Roger Pau Monné <roger.pau@citrix.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
@@ -20523,7 +20522,7 @@ S:	Supported
 F:	drivers/net/xen-netback/*
 
 XEN PCI SUBSYSTEM
-M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+M:	Juergen Gross <jgross@suse.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/x86/pci/*xen*
@@ -20546,7 +20545,8 @@ S:	Supported
 F:	sound/xen/*
 
 XEN SWIOTLB SUBSYSTEM
-M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+M:	Juergen Gross <jgross@suse.com>
+M:	Stefano Stabellini <sstabellini@kernel.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 L:	iommu@lists.linux-foundation.org
 S:	Supported
-- 
2.31.1

