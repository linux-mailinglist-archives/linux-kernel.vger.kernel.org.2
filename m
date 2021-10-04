Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A688420970
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhJDKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:45:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9400 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhJDKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:45:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1949kcHM026324;
        Mon, 4 Oct 2021 10:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=BB33HoucCahLNtCetzcRSAwMDKZ5gXq9UEMqikdoxUg=;
 b=CKQty0RmBvyieUF0xwCqOC1tQKj0Ph1qTvOQk/1UObs9aiyhymAH01taI+ViS7izPyR4
 2hykTo2a/aJW9sY2V2jn0Qx86+CO4o2ERfzYKMkKxN8Zk9sR8iuHzVNrVmaP/1REmBMk
 6Y6KRClKnCsXY72jYVe3+1Nkq93WySF2oKo3trsWRrOUwqF7eKYmS0Yrtt10AJNrPwWB
 GNXK9LU21UEEv+yri3y/S/sViLHzmXy/wXFVE66tNAK+8d5W6IrWp8WADN6h/xkezsfQ
 e3VZ0TBRKuA0RVp9J8LVZAvf1I0znqXyom7bPmySX9NZ3IyovVxahruakMaVfUEbGNHh hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfbb1348t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:43:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194Aec7s134804;
        Mon, 4 Oct 2021 10:43:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 3bf16r7fk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGjqnRdIwbN5yY/yfn94luy/Uc2q0Pd6E10dv08sD9XfFT1UGvXKRSj8gyR3SXLWEvbFVJVWYxBcagTYgtjC10ex0MK0T57rbbH9e9xE8pAL7SNwsoB2i38vOHifGfdRhRDFanx2bvwrzsJMoumzvClyo68zAG/DdaIVFKNT0rJSB9PPU9nLXQJ5SMKJVvxMlgRxDmwV1fj1zZzi7RU35FKl7iHeuvWGYTL3rtqajlIUjYdW1yyiHvVmPx7PxK9USy9yudY4rY0YImqa+FofWUHQ7I2b2BwqEy5HjpPlQixUsQ7tW/LwSnC96Zn65SMTMTUNPy05HQT1o5BtbzHu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB33HoucCahLNtCetzcRSAwMDKZ5gXq9UEMqikdoxUg=;
 b=lTci8s+Rq3kH72U6AzTD82U+16/aNM4wrLF6pSJXnwi59g0eaFIl6DrOZTNxfQtplTTNM5Oevyf/epN7tXa4lYg4zxovSVrH4aJudchbic5NggyiHz2I9Xqkpk+EvT18sglODIYn2Sx95TH8KdjfSUAH+8bdJBS9RX8M9SLz/T5DNlEA1MAfayi/Jf1Gv5/FAnSBSNypkgs3sEM2BINfZ+OBw4zkvOAfgr8MlYiPNCSAF8eNoEXpj0b8SPHob++JoPX4CIfpFbiwyEe/zvfzxiKHd69aVe71aehGlRvHteIri6chvPuXtZzxokXwNTyBQ+DEfvYggvT7uozfP3u+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB33HoucCahLNtCetzcRSAwMDKZ5gXq9UEMqikdoxUg=;
 b=NkmuRQ1zVgvKQrdP1xKP8MtAB0oTheubPodSKI/RJN/08RS/3xaWgxzyfIM7/0GsZmQLfgeNaOH4bQ7ugDT/qVqMWo/dVEnkeGvZsRvv+VclQ49Z05k3Uf6kx7d7hRQtCboYX2A0QYq/DFlRbnZsFBk7oAIhd6BYt0x2x4J0sOc=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1776.namprd10.prod.outlook.com
 (2603:10b6:301:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 10:43:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:43:54 +0000
Date:   Mon, 4 Oct 2021 13:43:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tty: n_gsm: clean up indenting in gsm_queue()
Message-ID: <20211004104343.GF25015@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM5PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:203:91::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by AM5PR0502CA0022.eurprd05.prod.outlook.com (2603:10a6:203:91::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Mon, 4 Oct 2021 10:43:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b00f9cc-7282-4b38-0cdd-08d98723dc99
X-MS-TrafficTypeDiagnostic: MWHPR10MB1776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17764E561C61575FADEF068D8EAE9@MWHPR10MB1776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raHaAg9vPrmbh+XX4CcB/YryVBVGSNEd3kh+K1PSrSo5bHdBHIr8hZHEqNEp/8JkR9UZGsp5OLoO1i4MJYIFtg/lZzdqfE+1SWAydiqCaeAXp4+fVtQzuSNZ4kV2LZeXd32IoHNvC07yb5DUUFwdDcW887RVQex5h6c/xImXAIynSBDmZp3CcVzDtrCfVcFXLt8Apsqtt7DQ9d9ci10kPdAVTfz2tdDjap5T8uNfcFOQYo9VTuIMENM0e6mK53Fqb39TYrdPq/F1nBRckBg1qboetQdp4vzI+CaNfqLX6xfnyurIM2o5LwWe8VXYTvROvx/tA8sp6sJ8l0jkw46VMBtIicRdCht9MNgVAPNgIiqN44BxuwwAoBy3plp0OfZyJ0ZgAhub+1iUWc1HWHyEEPfZNzjxc8oh+vxIsp6VIDCg8vcRY4xFD0P60e7LIefMJNsSsWX4r2ngXeaTmVBm5g8RK/KpH0HokH3QFJC5kc97t6/Y7e3zh146HV2fOc+7wC8zw1I271p/tHqVn7Opwg1c2FYkwTEcwuPg/qn+0C++8JYOj9HDL+EUWaOuwr2kVocu4JNk9LkdC0TpZ24U89fKsBM1rzzM5hqDr4SsXo7I0LXHnmIXt84iL8rlADUZUjXmufHRJkOuZEx2cxh6OOesN43LWmFy74s8OxVXgxV2IF+Ge1ayVXFx15jsvcjNRK6kBwlCRnIyt6iq9cBkIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(316002)(4744005)(83380400001)(66476007)(33656002)(2906002)(86362001)(508600001)(38350700002)(38100700002)(186003)(1076003)(66946007)(110136005)(26005)(956004)(55016002)(8676002)(8936002)(6666004)(6496006)(33716001)(9686003)(52116002)(5660300002)(9576002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTcsHRHVaS8+hQMS1wDDIQABgyRm2inF8GwQD8BT8q0ZHiiGkTrxF88p0BDt?=
 =?us-ascii?Q?45Vvpsz3tB1NtLEJZ/2hfgq89uJqNetavpu6793rjjrO3OnlpbnfpQvckPfi?=
 =?us-ascii?Q?JQMrDuifnk9XVAMlzRgbl4HB9P3UGFQhcTKaXgjg0Dqv7JZ6Yh/k0lDSZRWf?=
 =?us-ascii?Q?95sXIC/2szeEcQqBfMMM/2WsasnPVpyWloyqAhM1WYQNzFlO3wRaTpoDsaLx?=
 =?us-ascii?Q?ioiE9dokrhCG1rs1JoJVLnHCndNQOBUBfvLWtad1YvWrzfX7bReLikZhJbAi?=
 =?us-ascii?Q?dCfKEwmF2iAfRAQEtTCtXPXEzrlf3pnE19kw//TNYYSqRIyu/8EyfGe2ikPw?=
 =?us-ascii?Q?V5rNeXSwyPLuF3dw5WDTAcwz5SY15iBNgKpuOMNbAW/lznPbcD40eNb6BBqv?=
 =?us-ascii?Q?SRs12wjyPyRhXpMUzyisDpmzQhDRhgM+ezrts/awNmXZAR4RouX3Qv+a0jJL?=
 =?us-ascii?Q?OxJCp4wwbC0qPaFdADg6NOO5wUHz0te3N13/W15bGuWZIh7Q5eiWpb4VGhEN?=
 =?us-ascii?Q?Rktx3eNdHU/eIifBF9cUxtcE2VaJGldcsaYFdIsoTo1kqEPxMjIiUYuhxCf/?=
 =?us-ascii?Q?tCxQRBn6kGPyLmadfFHFfH/+YkBq5XUncOEh9jUO96upiVYMTqeO0978R7Er?=
 =?us-ascii?Q?HFHhn9BSd2qkUk/QRbBUYhHW+N5rEbbz7+tsvk30v/g96GU+sa8spUobIgf1?=
 =?us-ascii?Q?Rwg4K3UTITiwYRCCwSh7rYAmswz0Cl8kZ1pfBCqfB6k3/ylY3WAg2J/oRtLk?=
 =?us-ascii?Q?RtoWh9yRVcuTH4cs6uRoaxrHrR4HvUEbTic6qg2MAWWKg1jYaxH1H9tKsPtT?=
 =?us-ascii?Q?LLRT25Cus25uKXSkiO3G2sa8UHjdzSIrge5lVw24anfAluQT3Yf0cTzb8qWQ?=
 =?us-ascii?Q?4nnQakNFVBitDtHETiFAy28E3TrbQXuJZsEAR01mjPb0kIYaqKUNe7MhpdbQ?=
 =?us-ascii?Q?nIglSOkChZfsf8/553tEsIZRpNnX+Qq+B5TiUip0Upyrf8SD0NHxEILMXGNe?=
 =?us-ascii?Q?7PttIf3Pvq/mORZcgjzulHvoPMGK8WT7nvwSsn/+50yXh1v1WtCjhp2Z90du?=
 =?us-ascii?Q?mW5V06Y4hQ+ObiolRUx26PYGMrzlf9CXG2inC7vT98dCJjSZZNdbvJWk1ktn?=
 =?us-ascii?Q?kfCPari18yxBti+CIdjlwR+HCx4FafZvFH5vXCtdhVniuhuoBFfMKJd1wzLG?=
 =?us-ascii?Q?Ehwin1gmIonvEo02rBNmwBLkNQkYCcm2ok76C2mw/VSMNxi9ETgXOavcd2/4?=
 =?us-ascii?Q?IMkEnoDXoHU4E44NDG5S0PjU3rulHWnV+MxtekfAzssmzoLVsLaC5wZP3/+u?=
 =?us-ascii?Q?Yb7uexoRLvxv/rq29I1xN+Mz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00f9cc-7282-4b38-0cdd-08d98723dc99
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:43:54.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0k67Q+UoFR/lzLyz5XAF+tPubdO6afCzOmyykKP2J1CHj52pYxCAJ7nqxmDCGDGPvwtnH3pdbFLcn5c3Pp45uR7dviVvhe1GLSkgmAFX1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1776
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040073
X-Proofpoint-GUID: 269UuOpulHHaxEX6_Yh_kC_0ruTtQfSG
X-Proofpoint-ORIG-GUID: 269UuOpulHHaxEX6_Yh_kC_0ruTtQfSG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two lines need to be indented one more tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 157b51ce9cc0..3bbfcccd79d3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1854,8 +1854,8 @@ static void gsm_queue(struct gsm_mux *gsm)
 				if (address_tmp == address) {
 					for (k = j; k < addr_cnt; k++)
 						addr_open[k] = addr_open[k+1];
-				addr_cnt--;
-				break;
+					addr_cnt--;
+					break;
 				}
 			}
 		}
-- 
2.20.1

