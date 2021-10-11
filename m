Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF7428D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhJKMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:39:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37498 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236641AbhJKMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:39:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BCTKOZ022698;
        Mon, 11 Oct 2021 12:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=7JK4nQhNfcZTgivtlMpq+J92saSjcFcPgrqpMAd6850=;
 b=Ls7mz7kLsOUSegJ6GgDIbFrmaw02PVrdb7ZhzYR6FDD+I9xo2bhpFzF2NNcZcamfPqvJ
 KxCyq772xrfcMuCfw4qeCnQFYvWytFld7IiAoDoaoK1M0Ss7hbufANjV9pOCT3zaybrM
 61+OGT0wAyPP+PS/fRPs3APxJo/QzHTyGZtqC6jetPRhFFdSiI4sPxgVuIv1D3MPStYZ
 8VIwftiIQXT1Cjs+Qwd5okXkW3vB85RqqVgwZMsJOd8agHj/IwWaP1W+9perGqMyCSoB
 9IJXx5sLGD2cOv2PCcbTFQN/Legw1zdgAvPHmscz60tqinTHNc+6cU9g0FpjlzFYQgwd 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxxabnm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:36:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BCVHXm142525;
        Mon, 11 Oct 2021 12:36:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3bkyv6xvhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRqBHXKtNyd3lpjvYD2Cw126i8L8dWqssXnvueKGtNbMBYGAD/OipEiN2paVD86R+QVXy+l28X/YSRB61GK/FQGx3DjnBYbg/rB65wvZvlesEeXpVVwLPj85CV+OwB9zCZV7FGe7BIifSPskYa0ne5L//C5cXCQm3/DL3hPoGAr/RlAKd4FzhzjLbqw940rliG2Qail1jvqzm2TnqCg9Bcx2PtaiJISWhKbExWC++QjLK0t0trhqRdS9fG7nAKXJp1BZwXLKTQC5GDhRk5xFRgFNUT65N2rh8wn6pKXDpmRrYZUjdQClk655sUfBVqk6XDKGqQOnR8Tt1MBUA2TT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JK4nQhNfcZTgivtlMpq+J92saSjcFcPgrqpMAd6850=;
 b=M4D1HIN8buCW9fDhEDKlrS4z4IxzSKXHqbc5bY6ASwVy8LX43ioWsdMxVC2RZZzfIqyBskaAndhw+XStZUQmlYy6mq6XNq24PANMRF47zpPytFXc5oTvWae7xj3/09mM7GmMHELpdblFf+r2JRVUyuRaSb96m/6aApFnEhuj214up8tF7fMGvpReYE1i9jOkHxTEUnA4HBO7SUMV1Bnsz3tHowaItihan2bOqN36ubRM8oP6Zw8aZpXgEkkvX005LtawLDMiCsJ6OJQLkVFzparvVkV03IHiCFYKzQXeUyGY78ATEKQ/WEc9WBO/nj5z/30rLC5xjl0p6zFdPQLx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JK4nQhNfcZTgivtlMpq+J92saSjcFcPgrqpMAd6850=;
 b=UAmRSffFRsi4lIQHDxtGoFGgOgVmfBig4mo23cIEQmwy00CkKsRgdkl/MKCTnnCLyNIjBf+9aLqOujz182BdSwhRplT5eV9FdH4VmtU+ZzNnSi7JHxsoe7UwK+t7XUK0Nxnc7QY02+Ss1LNggZOQk5viinaoCtJ5ZYchGMmoUik=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1822.namprd10.prod.outlook.com
 (2603:10b6:300:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 12:36:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:36:51 +0000
Date:   Mon, 11 Oct 2021 15:36:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: off by one in
 imx8m_blk_ctrl_xlate()
Message-ID: <20211011123638.GB15188@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26 via Frontend Transport; Mon, 11 Oct 2021 12:36:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8bc677a-1214-440a-f325-08d98cb3ccc5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB182274242842D6B5CBC9451D8EB59@MWHPR10MB1822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBZVWLW6JsyCHRp20y0h9E+LmNQWC3LKGFWCuIG0sacLwJmRtKGD7f2qUlZx99AMrUZwBaVwl04d8gm1/Q8UNcbMuRewvkA/nhp0Yj+ceOJGALaB7g4w/Oskpz3kBnYWRQ2PIGPxJf0KpeAJInkBarrXlOPE4sS2ZGvb9/2mGBO0f65U4cu9uPbr1jvyIWgsvkGVqeLs3KFDHmft90i1id40NpsmLF+1nKZlSgpRuZgUfcZ93rUs3VUznpjjvu9eW/9Ue6PHxGULnd2L3n7RbmuREVZnJjwycM0iBqCG/6o9TXLx0dE1j90nvR8ONrhz4HLAEY+2C/1KNi4qsaUyVtmRw/1MeczjoyhYTq5TTJZRstqpmlu8LjHu1ir0tjnDj4Mk/NB4gXL2Sb5CNODa9YlBDecfgy3W2EsQx44nTX35SPOhPy71lyL/wji8gDBXWz8fkYNgnCdjoaPqgbsjVh6w5MJdtEcLO6v2ZN37i6Q8mFN2N2oNKDovE+9H49UJuiycbgQzF7aZWgKJwyPVH2PWAnqlxrrb8hztl4ht28CxXjbT7DLFiqld4/fscNvhSnlF0c0IFOmB3g11oqZWTisGbwRBCWKGwWVGxATaexFnen05JK+AEs6Hf1Fz5Q/N6Vw3Btk8r6VX+0MDa+q9K7JhFkncOKR5yerR+CB0fqfqNcRBYMRum6yMH+RsCzHzjav/ZMmF+g0hfaQAzjicLa+H0szAeOcAkAXslVp6qXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(9576002)(7416002)(54906003)(186003)(9686003)(55016002)(44832011)(83380400001)(4326008)(26005)(33716001)(5660300002)(33656002)(38350700002)(316002)(508600001)(66476007)(2906002)(66556008)(66946007)(1076003)(38100700002)(52116002)(4744005)(956004)(86362001)(8676002)(6496006)(6916009)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkffLgjEKigmf+iJ/6ds4Zo7oBbpKQ1hNhzOHTpobwMtKm7VwFG8Ji3mYhTO?=
 =?us-ascii?Q?ckGiBeeipyLzcSY6vaVykHt2qBGxA10MFTpbJ7w9eIbJmFCYf8jbybqQmh6y?=
 =?us-ascii?Q?nf1rUGHCJKZfwqqY+TKgaztu59zrYmh74w0zbetAId5uxyEDsyBPsseoBPQz?=
 =?us-ascii?Q?6tlpTT/V7MYCa8bp1PnAy49ApPQgRroIcbXRxlsiaVJI8dmyY9dW5Un/qllI?=
 =?us-ascii?Q?rshVLsRZPdvPV2ySyy+LUy+qyD9PxZvp45O1g5wZPsuYwgOvP43IsiZHzftt?=
 =?us-ascii?Q?5kZnGpxGzope2mBoiTKO/YasovwwlAL11p403xYBf5G+9JOYoUXUD0P8i+0P?=
 =?us-ascii?Q?xk+trNR8wVrB8Hn4R0eYIIxMIrjK9S2NykiACtuVlw5a6aBLpWuO0GdIy4M8?=
 =?us-ascii?Q?FbCEClvZ/V3A0Wcu9jNNAp3+Lilneq0zh0M5l83+33jPdYhxY/nwqO+NJI8R?=
 =?us-ascii?Q?0sYw/MCSR3eUm35NFhwOoOH0hR0eiSpmB6NR6qx576uTyu9LDBKGWoFZtHgQ?=
 =?us-ascii?Q?BocwtD0tLJKznR49r+D0tLBi5Tfw6GSMKfCE3e8CbRYMRZlo4LGORrQEzOTD?=
 =?us-ascii?Q?/Cu/EHhoPCaJdSllIamNheLaMdLoscyCIvhsWMBNe3Toqg/BpksQZOR4i15M?=
 =?us-ascii?Q?ZYCfCW2F0GusHPVTUns9N4shKtSsHdTsmPf5zgTlA+fKVtf5r9ca2zmQfqSK?=
 =?us-ascii?Q?LcWn70xK0nQLTAPi5xSA3P2tprSVHfvlIFjgSiB47S0WJ1G4taSgcN7h/8DU?=
 =?us-ascii?Q?8gsEjULVpfCq2QgRe6NPeWy8M/LZs87OJ8SdOXl86bxdviZfizzq3U5P2PcL?=
 =?us-ascii?Q?ia6VfmYSwKa47t3sFwCMhdD/ID+Z3TGrm8wa4mpboh8FPjN50SqPsnjWFKgr?=
 =?us-ascii?Q?SNWGzIzjKJYb1USTQGxVyUz0KzbAjQUMCKfRyO73oe8U6yXDprEPMGXFbXmq?=
 =?us-ascii?Q?57JRi5Uv5htf6cYwzw+ZNHu9SRgHoEufnWsmNP9szf4LxmTXFEFXlAiU8xo/?=
 =?us-ascii?Q?uosbQC/OfvwZ46cHnpvGf2SQ//QZxsFEUhqHUBC+2TPdPLApmNSAnap3HVTJ?=
 =?us-ascii?Q?ww+QKWmpgnM8+kaol/4XAH5PGZhP4aY/85WBSb4LpPGBbTBq7f+WLOICyYcQ?=
 =?us-ascii?Q?YUtVg+aVqEu95XtLtL7IqDYCzKVmIkKNovFipyviF/yU70sIsuZ/F39YmzYe?=
 =?us-ascii?Q?r0jeHFKtESgaiIxZCKQjCVY7ir5UqmXTqSf3oN2saD07A8Kz6fqRKaPqNg7z?=
 =?us-ascii?Q?C98DbfCN11FClGO/CBp/j4K3NjQF6w7cfnkScbcC2n5QwSdGdviytKiMHs2u?=
 =?us-ascii?Q?sJuapDn1cDNfQw1s4tKe/aLm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bc677a-1214-440a-f325-08d98cb3ccc5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:36:51.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95ordyweOEB4g3AsM/kPm9tj2ya/rRXqDfIZMY1JgtoyhRzF0vLggaJlMhoOIZOWTPbcjfzEpfbPmlyiqztmoO1q/Ig0iwGfLjzI52RZd/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1822
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110072
X-Proofpoint-GUID: rwsD7UHnFrOVhRh6e7MIsaf_1eFHBFnE
X-Proofpoint-ORIG-GUID: rwsD7UHnFrOVhRh6e7MIsaf_1eFHBFnE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The > comparison should be >= to prevent reading one element beyond the
end of the array.  The onecell_data->domains[] array is allocated in
imx8m_blk_ctrl_probe() and it has "onecell_data->num_domains" elements.

Fixes: 5b340e7813d4 ("soc: imx: add i.MX8M blk-ctrl driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index e172d295c441..519b3651d1d9 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -139,7 +139,7 @@ imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
 	unsigned int index = args->args[0];
 
 	if (args->args_count != 1 ||
-	    index > onecell_data->num_domains)
+	    index >= onecell_data->num_domains)
 		return ERR_PTR(-EINVAL);
 
 	return onecell_data->domains[index];
-- 
2.20.1

