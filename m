Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8C3E01BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhHDNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:16:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51012 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236335AbhHDNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:16:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174D7xFs011833;
        Wed, 4 Aug 2021 13:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fbIIImcrcUnvBOga41kVqdHoL3/g/h3L3oUPDS1GdYE=;
 b=v+Z8sTlge9KrllTTBBCLX+D7RJNGy+i16WRnl6CQ0fItvHedCQPgq4xexd3wyGRfc6Rd
 h6IxFPMPjiqGx2CmqhLKj7j9v/HHYKHD3IvTPTPkYXv/U5mE7Qt7KGXt9P14KZpKwByu
 fHDusMLMxIglvZG6r9nsJB3TG5moARlyurVNrO7On7elFhDNY136OwkFiD0SFRzTViRV
 6+GL4B+7W6XQf2wHgQNohaVvfXwZScoXtxNKNaO3i+vo0BU4HyT6trVIuCYOh62nYNkD
 X5EGuYiZ20o1nfuvxbQdsFaDFTIHPkzD2WbDXOCFS/412Agruht6Zs8zvpgDZJSvkLK8 ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=fbIIImcrcUnvBOga41kVqdHoL3/g/h3L3oUPDS1GdYE=;
 b=xMgdoaGUtxt94ZR5QSL+fCQV0bk+mKrpr2nERiT3FGnXMUe5wPdysQZWL8bcaExgweLu
 zeK3Er7rwrTPJysok66f6D7BJa/Sso3exwySj2Ze2+EY2XE/2P7Y2qMizQ07mWthhTi8
 gSd92A2zVWf5VokZeLq8QW63ecbVPqBX+kU7H5/u8mKhmLtacxYCWUe7iR/3cHdNONT1
 M6LOmhkMc9rRq9vVF9Cmd0r69qRvCedbY4gAxZCgM5OiLd2OzJjyoAVkU8fbeec4As9A
 Sk0Kvf2UuveacDWxeBmPkYbzIE50Edv5g89abaul9O0wJNUkh/N6dFIGny3JcXMYV3Iw 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxhdwrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 13:16:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174DFU7j007428;
        Wed, 4 Aug 2021 13:16:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3030.oracle.com with ESMTP id 3a4un1pn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 13:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb07Hf+GCvMdMGMKqFV0R6uVPtGc/jMLUTwr7GxuLFn9NNFVoI98DHupWuuH6l7DaxR/vB0cgUgaena1e9dHG3BZ/tDNSI1qDfflSNZVvV5TDQmuBxAQlF+q7Hgm/D8G9qsQcraMj1Xwus/BebEuG9YHvgys0tuC4uPTcpmmBDDp+PEPF1V5E9Ro/rfrnmDsGjOpgiVnSCcKbNYojU7g5X/4YnuT0rVbzlgYFzJZz955zQllseJXXO7SBxo4zJsV/o0U0MYM4dRYz+fPhuWeoGDuj8POfZWgRFinv+RF77RLJDKvnKu3589x/aHVCwn/slMzYq+pymdWFLRy+QFQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbIIImcrcUnvBOga41kVqdHoL3/g/h3L3oUPDS1GdYE=;
 b=WV36LMG2Vm1b+hsTCZQM2TTAnDWonpEJI0HtikGS5QUjDRp43ITd4kU4FzSp1t2ylJZxPiHzSb+gRKE83lVVxrViKPf1raKqswLyf+KTT6CMN6W/zx/v51Qpb7948In1CuNnMFbYK+vF9blM3u5yCG1tpfoH1ibYoyN0RahyfK0+pcZVBQ0VaUfHLg5tCIhMMZEvn/zMyHKDsSjnvotl5Zyg5jULNOV3rHnEp0X22RrvFf/S7jZPQZODQfIEKXB3BuBSARXue7hb7X/ZI7OGwjf+eImyv8MCAEYl5SJb969dAdkEz7/pLPwVWKb6Fk3cwi9oRINO/vzal4UAR0KT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbIIImcrcUnvBOga41kVqdHoL3/g/h3L3oUPDS1GdYE=;
 b=BJ1FGFlBBClHdeH4TKquwkc8xxtZGGwI40j/h3W6A2DYEdw+VvV2r98JJG/bGvUuXwLWcO84AZpAYNFH9Z9/D/d3P5RZSHBmLMrnl4KMSNUZ+ekK0vXn5ltBDGTgdBbD1gG+LXv/+5xhpJ/sETVguoSrzg9tvLPwhc2HwPaNdo0=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 13:16:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 13:16:12 +0000
Date:   Wed, 4 Aug 2021 16:15:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: r8188eu: Remove wrappers for kalloc() and
 kzalloc()
Message-ID: <20210804131550.GL1931@kadam>
References: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
 <20210802151546.31797-2-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802151546.31797-2-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:16:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0ceb6cb-5310-4758-8a6a-08d9574a079c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB448342A4F6A1F32D046593048EF19@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhXA5tj+gRItxFxL3a+JtEDnjDA+g7shO/80lDqo06sPjWJ0GUXTLbgWBHNDd77PdV8HOiktufTev9CrEFQ7NoqUgsqBP4F+I2O7hHV2RwWz0piogEqR+yFwMa3O14vt+oN+zBbdysSj02BZSq6JlAwSOHuzKoY18GOYCni0gt6+GUYIPTBYdyAiRklKgHk3aSeOtZvvtW9y+t1IzqMb41+zhpvJcfXG6hO0uERWqLFffksmt54ccI3lCQ3AoqNk2KBr+LCWeeRfb99X6P3OtvIZn1OahD9JJUuO0MHHg1JOSePweLTitC4qfTXbx4oOv8gF/HHUUk3ptstlqDZGKwWPGi5p+++SnKF6aYf8E8Pgu6BD6F6vciPXLIB8hsHCSsAJvUy6ACfVoSZbXkcHhofJ+ifLu+m4n6exnuKHHMafZeSlqNmZvaKTdoC0ubenL/L1KeMFhNaF1nBSrhRGjiwX8M6jwNCWyVp8QenGrGBnjo58z1ZN53jw65JOH91ywtFPTM0gGcg5HooWxCLgxhkFBwD1c2MAVZ7fON4VAWRiy77mKxkLI2wwxouTqrneobi0ZA4cuvRatkaFXdteMPNT20ocWqfedZSUatBGrCEeD7kKbprI7rdKNg/uxsevqbwzV+RNzMb607MGdXKh/McHDt9JyoG+ZpSAA/H/FuBMC7IU1zDyVVK7G2zSEX0L5dv8e6tPV2cM0RyWw0OVcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(55016002)(66556008)(6916009)(4744005)(83380400001)(66476007)(33656002)(8676002)(6666004)(956004)(478600001)(26005)(316002)(66946007)(1076003)(86362001)(52116002)(4326008)(33716001)(44832011)(8936002)(38100700002)(5660300002)(186003)(9576002)(38350700002)(9686003)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iCc1qo6cSEZEoNew1nz8IUbbkiF+3kMaXb/TH9LsnC6rnnm1ow8spIKY1lIS?=
 =?us-ascii?Q?iTF7ECCtt29tqkhrygE3zb+AUx6UTMvmUVS34TvVjgH8O/YKKDCuZNgyOAxT?=
 =?us-ascii?Q?8CH/10JVUeToMK+B7B5Afl2Iv0Evy+ai9omH/DQTZX5LlNORP2qcEdI4jZHP?=
 =?us-ascii?Q?uU6z16xa3VQZW6Ha7lbOYwlrk3lapV8BrI7vUWTnN7UC/j72k5rX/J43+QIf?=
 =?us-ascii?Q?tDmYngFqCP6XtFCpRngPr670Ny+jk5zw4pX4LhQ+8JIhcMrnmXEiG9tbpobd?=
 =?us-ascii?Q?HIGjOQdjb7bUYz/xELyBhfH8FsfUqbb1kFhZZoNaMJcti9MyXv5a6v5EaiZM?=
 =?us-ascii?Q?s8oXbv3V6DdU9wKooT/M/Etr+67Wr/7Q/sQQ6lEMh52zHn0m/9UCF++Qhta9?=
 =?us-ascii?Q?GN4NQzm+sxL9+Jjv7sqEQO4I3Ta9Yu3xa58pDEVq0g6Lww5H9IzAHJuJ7zpO?=
 =?us-ascii?Q?PHastDwkTZdKhUk3hCyL5M+lS/BAlH/thT/lIKFI7j8L77X8wtzRdWZRP1hT?=
 =?us-ascii?Q?qJOIH8jxWTtE01EDmGtytp9z9mKSkR21zx2fxwt0/VQIuvrvOrkdvGwoUoqJ?=
 =?us-ascii?Q?vBtQLNl8A/tbFj5uDH44j+PsLmIMzL5CgkTU0C8E94Tq95TNPaoozDVWqKuU?=
 =?us-ascii?Q?iRYGOsDeinZv5s0N9CoV1wuS4Sq5BSJMVUrlZ7Bg0ZlrA5ponDa8agrGQXhN?=
 =?us-ascii?Q?vkeD+FpjAsodvrzjiW3yGZzOVPJUyHjghq6oQ7cBcoYvVhexrF4dS+9Ut2d1?=
 =?us-ascii?Q?9UOmYbbbXZfguIP0Dmv7n3HG75PiqArbmrg0Lov5q7AHkDzCoJVNTa3fb5a+?=
 =?us-ascii?Q?ZcD0gO9XbZHjol4/FJT53xt1zDDA0JQsiDgeGBdJzW4XmjQfs12LrY2D5a1k?=
 =?us-ascii?Q?ZPaCbYPZsdKqYqDBQ10l9YcrS6gNtOcJ9HE8iN2kee+2noQG7h443BDjaCrM?=
 =?us-ascii?Q?aaUbLYTsOqFhN/Ifq+JvYgLnV1tMP+5+OjUpQm1LalBjPcto4rc8xxAVxqoO?=
 =?us-ascii?Q?8ogdxFUyfvFYa7Vb6Q53EdepQoi/EJ3vdF44jXgp0yTkLWj+M3tzbCUCGX58?=
 =?us-ascii?Q?OLTqG0ZGkIXfGt1/mA6lg6WoPc1DydhNNpYMugsNiplCjei1D953S+wf+vEi?=
 =?us-ascii?Q?hzVb8caWQeGxo5yuJV0p0RgZeJowDjYAhfaOszG5mgPxb4kjJnGaXJZJATwq?=
 =?us-ascii?Q?EPDA6CIulwsSSDhrbzfPHgoQMJhQXUcwm/7kuM3fFegMxyS9VyjJP51eUk9c?=
 =?us-ascii?Q?vwHGzfDZYgTYO7EDUsJUeft81LiJmxYEkrs5pUzyrAsPJI76ddMfxey8GRNw?=
 =?us-ascii?Q?aa2EY51qRxKnU3XuLWqFEgf3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ceb6cb-5310-4758-8a6a-08d9574a079c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:16:12.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvVdrnv135l878YHJhkFAXVxQJC93W1L1J0AW4rfZjCDXwQ9jMABXqCTtarGZur06Ky5jAPM3+WFz6sQAxzX21Pjqi/yNahH0ty6T1f03/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040071
X-Proofpoint-GUID: QZbDr-jmSgqbrVgZtmM72giSkcx_-qzu
X-Proofpoint-ORIG-GUID: QZbDr-jmSgqbrVgZtmM72giSkcx_-qzu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:15:41AM -0500, Larry Finger wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c.rej b/drivers/staging/r8188eu/core/rtw_br_ext.c.rej
> new file mode 100644
> index 000000000000..18113389acce
> --- /dev/null
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c.rej
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

;)  Something went wrong.

(I'm not going to review the rest of this series.)

> @@ -0,0 +1,11 @@
> +--- drivers/staging/r8188eu/core/rtw_br_ext.c
> ++++ drivers/staging/r8188eu/core/rtw_br_ext.c
> +@@ -420,7 +420,7 @@ static void __nat25_db_network_insert(st
> + 		}
> + 		db = db->next_hash;
> + 	}
> +-	db = (struct nat25_network_db_entry *) rtw_malloc(sizeof(*db));
> ++	db = kmalloc(sizeof(*db), GFP_KERNEL);
> + 	if (db == NULL) {
> + 		spin_unlock_bh(&priv->br_ext_lock);
> + 		return;

regards,
dan carpenter


