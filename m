Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE154016AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbhIFG6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 02:58:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45602 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239398AbhIFG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:58:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1864Yhgv003517;
        Mon, 6 Sep 2021 06:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0lxYkaTQx6D+YS2WZUkG6NImcWuWpLq4FSRkWd+viG4=;
 b=jL3+EBmL+CeRycswSDAkeU5XlaNAA9iq/zDArKADcUnqVAqo3O50a0uwpe6Sw2O28DD+
 lxiFCIzb+HwaQzHNQNGb8hbZSr9k/IdF7lu+DtRXjYiy3+WUdJ8qdDwGD/hzFjREsmrF
 Bj9yMScTe+PajKYM6h843arNhMO1jSXKf0oWqmoy97aqBc1WMOWacQTFQ4pSuD+wevKd
 A015S4MtAlNt3yD5FlGg2pemrefrmbIWquFf0I1IALRHcivOYNQWEu836Vvj/PVEPhUr
 bOvTaCTTWIrAKsPZGSma0NFW0gYMyAzEnU6kyf9p+/T3JPlueRDh6dGCkdXFjlrYsyeO Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=0lxYkaTQx6D+YS2WZUkG6NImcWuWpLq4FSRkWd+viG4=;
 b=z5M+w8+xxsc/87UEY4Igly7wNim0ABuWgYE/frtQNOBFPkVtllmtYtgSl5psZT9y/08/
 2FqEHZC9vVtzuZffYzmSvw+pjW5FHoVS79uLdNDAQ1NQm+PPL3djNsemiKZkAEGQzdPO
 J2Q1+3MmJGLJLko2nNa3YyVr6IJo0n5sPsHVZ/Rc5mM2LEesLjwLIypi4/NGEI5eim/A
 5rBiyo4YJy67qVfeEI8eo935KLP/qsqoa/epiFUPM7Xe4Nwa+dErWyCAGZ+oN4rnFPtJ
 PIO5Fm/jxn9JwyNoVmB92H+ohqOHgMZXCqP801mXHjrcdZWCVqEkWIj/krfgiPVzp+EC cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3avy77ha7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 06:57:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1866o8Xp159554;
        Mon, 6 Sep 2021 06:57:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3avqtbwe6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Sep 2021 06:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY8Akn04gMtgGYIjNGaadxgCcxr3TYUB/0qmM+FDb9ig3de9I1OLK7FhFICZVLiUb7L+F/fK/DEcC60LONKaERrntxHNiM0U07VYyKN3nzqFq58n5dl/R2FwNx4R8UBdA7ZqIjuMpqLlAgmi7yXXKBhZoZseNCBfOBDJ1JFYhqzifFU25j7ycTZaCj2s26jYWESADAfThx7sk54h30oU1S2FwMcYE0CpfBdCJ0qU5FRSXhkxCMzOuG08ImXSsQdhr3wk2JV2yLAABE62vCkMR84y42a7WC91l2fIh7eGWZ+Haf6oh/nSjv1lcUhKg2xUBm3tkEq1kZVvat4v6iGabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0lxYkaTQx6D+YS2WZUkG6NImcWuWpLq4FSRkWd+viG4=;
 b=RfXJYHqTEiM1VsIfGSsOUxfElX8mj9wa9pYOwkrgjNEWQS5SLp21T3bYewTzchzh71D7N/NIsm4Gr5hghMv7Fpuc2Pspk7rawONuG+R4xWwHMUlzF7SNOXpQqJN48O7JyhqkAj6emo70A+Fu6geEj6sTKxOdpggh2ihOuvPw2W/bD4pIeBiN9JenukkO9K7Wde4NW45CN0Xa3QLOshj/hnnAWiED7wRetwmi0+pvbHMSWlm2rf0uyrpwOkf+sqfgUM2PwU8dvPrHLK/h5ofOy6f4c7y2lDabVgfKAqGcrHhbNF8+TLxZ2D83UIOGwTGjQ1wRgCttrfAFKblpdBeGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lxYkaTQx6D+YS2WZUkG6NImcWuWpLq4FSRkWd+viG4=;
 b=XGw/vlXVptxfux3EsRdC0LkFjlhSEUri91BreAEudTNlmmbh/RotvkBbJu2UoP8BpszVbFrlT+I6OcL77LjDQc34Gp2Qa3rWvcbxSsy/lq9VCGDyJa1Pb8a6a3pe8NSFX+1Ev/+T8nv7fRsZrMMDXfnRKqFRicWyo0+OfiCMsSM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4433.namprd10.prod.outlook.com
 (2603:10b6:303:6e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 06:57:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 06:57:07 +0000
Date:   Mon, 6 Sep 2021 09:56:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix type mismacth
Message-ID: <20210906065650.GD1957@kadam>
References: <20210905205216.24831-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210905205216.24831-1-paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (41.210.143.41) by JNXP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 06:57:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ca14c5-1218-49b6-d75e-08d971038a9a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4433E9E21254F31A7EBE159B8ED29@CO1PR10MB4433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnEERVD5JBeyGK1GezD3vPd736de6b4pDOyAHxAExUu22FGisv0qc31OKGf5jBQ0QfnMhqFgq4L1Lt88yw1Lf7+9nZpYaxhrqSvWOM8A82L/DfJ0AnmpdaQZHDsl8NbTWi13MKhCEdB/hBwbWdM1IM3XouoRx8BSjg/c8vHc2G59SfaDyCbAciEwzlnDqcQFpu+C3rFMjc9w/h3j6fKQZPEKQ+wGlb3qoplVmqnqlegddA0SecEpqnmNaNHU2QZrHyGvQVPbupg5NEww4PS2QiscZkBCOGEWN84ufZWnAM64VKe/18F1sUNB/WeUUEMFP7rK3jqcMJOu0LJ/JE5RqO9EQyh20qeuqrB+r9m2WflPhjCKGUUBYTOvi60vm1GMmkHPEIYLnEolQ5NoUGSnjYfvMD5kdcGFdlF+OBJa27e1jncFo2E5shB3fAlVnrieV2iS4HZZmu33AQdFwZYQsgssTAI7w9DNuUXYxS9BPbpJhMVEJPuPshfQGtPn/4wHPNvfpu63t3o51nKVV9Vkbg7st8FMAfyRBKHC2aJCLw/NYDLCYThfPpxSe6fCRFXMhotw9BEVx3lZjO1IZpawiYpUVh4KdbDFtMw5ZfFVBYZXPaoupkUJKcYkfGNyoWGrPZbnVlmstWlfzzWYOrSj1APPvzW2+S0tCbYcU96A2aDVABySwvJNc1P+sg7y8jbww3icJYYYVlzbhtKVqPCZlpi7TCAA910JWc38pq0TVJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(38350700002)(8676002)(1076003)(52116002)(2906002)(5001810100001)(66946007)(38100700002)(316002)(6496006)(83380400001)(9576002)(8936002)(33716001)(956004)(4326008)(478600001)(33656002)(9686003)(44832011)(6666004)(26005)(66556008)(66476007)(86362001)(55016002)(5660300002)(6916009)(186003)(5716013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YVts+Nbd5NTlzAxCu3gQrnaOUwPnTjc6+dn6OzrokpGwko0dkgiIctkOmTbz?=
 =?us-ascii?Q?YMknp/fBVb8o6x28xOEYxyAupMYY0G32zm7D8neGlz8+iX2RZrSWTm8QTD6Q?=
 =?us-ascii?Q?O142IxWANc9vV0EQBtbk6gDyOrGoZiyl3scI23NIsL9eJkiJjiPPDzsEmYlL?=
 =?us-ascii?Q?9nXQ/gO9nVQB72OC5l0B6Zj2+pXCic/xfetOpy+Ko1huJU1a4GWlRu250DfM?=
 =?us-ascii?Q?0IqMc7RjygZVRJB8Lo9Jl6oNA4M7cI4G5z21Qwm2XqfjGBimJzh1ZirK4TRy?=
 =?us-ascii?Q?bDcttMM2XQ2jnG+TYcsmDDQ2+YcGptMiSb99d4xk/5+/clkCah27bWjr/G+a?=
 =?us-ascii?Q?RvEVnYA9bRfZAWLlKBHjkU3OVR/l3e+kIhxd3MiZVSEMSsDWguTPuoP+wz+5?=
 =?us-ascii?Q?AivLEWg/TDTNCXtDtdu/r45xHSO2C1Me/+UehK5HVmw9KiSQQUTjsiZhHmOd?=
 =?us-ascii?Q?RD4Xw8MIhL6VQGN9gE0y1+OGKDaatt/iHm/UTgB3KKqK7Do2Ol2mdYvMNoi6?=
 =?us-ascii?Q?v5OPZqJXnCl6rq2q2/HjtNa25vvDtDKcP67vDGx7aS94xR8Um4SLsngq5Ilp?=
 =?us-ascii?Q?B5iZ14TFQJeOvomTWJsVKIDBktz7iVBd1apYM9pce87zQM9HK3trgRHPjqgI?=
 =?us-ascii?Q?HRhPKYBuF+OMLSfeQDz7kfMBpqgOawVOvP/RvAHj9Df77g/sM9jxzcfB+3uy?=
 =?us-ascii?Q?yVEEPW2Cjy2d8LoEJ9Xta+qCDRjFOiNCWwr/Ua1GCZbFsD/7L/KrVeQloBfe?=
 =?us-ascii?Q?53clBEI07zNddS2DsPDBUxMX12BW/RbhjXH3UopPAfJvfDuSjJ/lF0o0BLpw?=
 =?us-ascii?Q?9wn9Z5bWJgG4rt6qrySzbooR0tSIWEJRfwynyfj2MJJaNupxWTBrEYTKYHI9?=
 =?us-ascii?Q?927brQmCF9BmRrpnDGJoeMcy0fDzS0W5TfmSehw9GSw54j49LND5zfAwbRIX?=
 =?us-ascii?Q?5sK6/rXdbm2QqwsB6XSPEZzIn/hxbmaEB18hwmMeJF4jM612EgHA8mzF8c5H?=
 =?us-ascii?Q?IeJpEI53A7y04uKQzpwjfVrU8Tvrjt758iON13lO2EjGPNRw1HSkJlZZa7qy?=
 =?us-ascii?Q?9CioWLYYhEjIStbQ1s5hnhI0hpkPLuJ3y163UNO71kRCDxJb1Bjj33uLW5fc?=
 =?us-ascii?Q?D1MqXhX2vwppE9C3c6wPE1DOU+3OabpjiopnaQRexrMZjMISeR9JmRfuVRbp?=
 =?us-ascii?Q?MnLqFsA+mDLxR6uUKQmzqyeMYz5qoIpKINzby5gn9g3L3pnL/PmEEjxrjBOK?=
 =?us-ascii?Q?EnX6XKDbDUeGCBUyHySyke+Tpk6cNx4kXlp7ZzFcUPrvELHBkrwmpoSteGRm?=
 =?us-ascii?Q?2+Vzckqro4vCOvs++wVMM1yM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ca14c5-1218-49b6-d75e-08d971038a9a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 06:57:07.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiThh38bo3blgXGbBeyKhmQWmeTRJTklIa1Npk0wNDF3Dn/fuKqDZIiZBnVKqSYb6PNdaJKX+igbvs3Fqct3hjMNp3KtUSuuHEnjSIFtwXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10098 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060043
X-Proofpoint-ORIG-GUID: FHba8utTGPghy4F9G9pU45UmRBhQX6cM
X-Proofpoint-GUID: FHba8utTGPghy4F9G9pU45UmRBhQX6cM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 11:52:16PM +0300, Pavel Skripkin wrote:
> smatch says:
> rtw_cmd.c:1165 rtw_setassocsta_cmd() warn: struct type mismatch 'set_stakey_rsp vs set_assocsta_rsp'
> 
> Since psetassocsta_rsp has struct set_stakey_rsp * type, it looks like
> copy-paste failure. This error didn't cause any bugs, because
> sizeof(struct set_assocsta_parm) > sizeof(struct set_stakey_rsp), but
> there is no reason for allocation extra unused memory
> 
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index fee4208dacba..afe6c7fa594d 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1162,7 +1162,7 @@ u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr)
>  		goto exit;
>  	}
>  
> -	psetassocsta_rsp = kzalloc(sizeof(struct set_assocsta_rsp), GFP_ATOMIC);
> +	psetassocsta_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_ATOMIC);
>  	if (!psetassocsta_rsp) {
>  		kfree(ph2c);
>  		kfree(psetassocsta_para);

I'm not sure this is correct.  Might be, might be not.  But we use
sizeof(struct set_assocsta_rsp) later in the function so it likely leads
to memory corruption.

        ph2c->rsp = (u8 *)psetassocsta_rsp;
        ph2c->rspsz = sizeof(struct set_assocsta_rsp);

regards,
dan carpenter

