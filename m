Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7044C75A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 19:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhKJSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 13:50:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52060 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233139AbhKJSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 13:48:59 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAIfMEn032539;
        Wed, 10 Nov 2021 18:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zNUGer3EF2zU3Z+t5y+C7ede5mGT50Ai1huEdLm9m84=;
 b=XG9GnF0EJsO1O+O+VcD8ZSsDphw16LDpeo67d3g2vRlIsba+UrHMecYudBSdbrwjrarB
 FzD/A8CeKRIqtXQOllV7pqSgxDvajjC+xLc80MCgnzI/KlHUayTxaaosLyP6JmZg1fWs
 9CXnEfqwJbp8C5en0OO6SkRcNjdxOV3/2M0K9SljuSoT8wO+xFem1s1XebiI8xWVw3C0
 Q/LU72f/NH3pStqK2E/FMph6ksvSJ1KsgoYa2XLv8jWJE7a+VSxBK/419dsk3X106/eT
 tejC9AXH/u7R+/ki4A46C1+NZjAV9SKXOmxFFTgHAJNjasxqqvknupLKmcmIla++RtGP nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c82vgdk60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 18:45:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AAIfSeP032486;
        Wed, 10 Nov 2021 18:45:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by userp3030.oracle.com with ESMTP id 3c842cnn5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 18:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrGUELi5pANCa9ux0yG3dR1p6u40Eia5Dgi8ev8OguguHORORF8zCs6xdatjjR7sDdce9Z8puOxSiqg0qb+4gAJMCD6v/WkdpuEjf156tgjaSrDLwfUbSEOFcqeuAHbWcWgGkJnluv9FRuSg9zUD37yl1kCpEAT0dsOqNkYx2RkBoOorGKv4ZXp4H3GA+4ivkULzVpKhQyYl47Qr7m4FDFwVkeWAqG46sNpNscpFOjtuhtjmQkDoO6CLeO6eGCqqi5i+UGJ7aLD/0UtSGnjxX+tTbot3zHFWdPg3Urc8ecVmHxqoSRxPqAPtaxLrUN+dni94dycYPDO94ET+ks6Xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNUGer3EF2zU3Z+t5y+C7ede5mGT50Ai1huEdLm9m84=;
 b=FD5p/pJwNhdXRTslnem1Ahj+Ur60ZNwZfYvPUIsw+u6mcyb63ReXQF4p5XwpBrV75j3z3fj1+goguw+HL8jYkWsuL9/eua9EcGL0VTysYNH0WNXaPVnHULqxf8RgnKioNXZvpqMjwiiBfw2e7/xYPo5yE6nHFBV5KA/dhF3ay3xrf+6SrMNGNiNeRz8GNpyRIyIOM9NJNfkewxTqX5cdpV7oUUjFbLluWVjS26fvODgZMgYm/U/8wMt8xAJ6cNuZX++wrkgFbBstvjzFsTfCoQk5MGjoUC50si5eAtKIVoRaVYET3SGuz+NhPH+ky40keote7jiQxp4w3a+hLBWROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNUGer3EF2zU3Z+t5y+C7ede5mGT50Ai1huEdLm9m84=;
 b=BXI4Tj5cKSXxy/ELaEqjZ1817W+mhOun8sjfuyoUKFGOlcC5SsKl0xrBcHkbX7qS8bu6FSsn+Vxb8XbqkVjMZGhkPLce+rkOtg1svoAmaicaZt4HyWMfopfwHGnsVql54o7Kz33LXyMzMsn2flpg2Uv2ZN5esjgVWz0jaoH2New=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4628.namprd10.prod.outlook.com
 (2603:10b6:303:6c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 18:45:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 18:45:48 +0000
Date:   Wed, 10 Nov 2021 21:45:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove goto statement
Message-ID: <20211110184525.GM2001@kadam>
References: <YYwMq15pQYf7nvt9@Sauravs-MacBook-Air.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYwMq15pQYf7nvt9@Sauravs-MacBook-Air.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 18:45:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6391d0c-17c7-4ab2-20ba-08d9a47a4fbf
X-MS-TrafficTypeDiagnostic: CO1PR10MB4628:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4628FC1691C7CE44AD8640DA8E939@CO1PR10MB4628.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbU6IUEI/Rgm4mwuTiXgbRTqypqrpX46HakSce3rHWQyL5e8kIVGJVAQBPCKnPoaN5UsWtp656jaNoI9EM5GWNmiSdpLa0eWMpAk3rVh4SzCO6HjEUowDjTKgTX9mJ8cb/piCm7naRE+3J3ZSv/T6iEK9DcMjxNm9LfHWjmkzzMnwIwGLX036Uu9LMIffeCD01VaYx1B5e4SG/ONvepG/64yAnGfGu0NY09fIYWVkrYlJyjkBqptPmz6UhGCG1JaU6LnjdACH/IDvEUrFu1zZ+zm87ZtRElk3I2FZZpTOHkoTVrn7Z+3Y5qYPNYBaPUowb5KHJ77F+Y3QAeMusAABezA7MrmMZ1CFEC4TaCKinjane4FTK4RXuic5LuZbcoNPaBS3qN135tRvGvzayRS7V2863xZmYDsOsTdcROPJoQGPAZxbpfHagYMcgbuQrnnrJ/AA/Tfkfg44mvd5ArFYj9wq5mckU2+4i5/Cb2RRPKs6kCNIboNFS3tUnK5t99P36K4YAsWL1mjfIBXhI4+woPbkj5LdefPc7u2xyrNt5iMmtNMosEDPUSVUFtd9slI5pxf8Qhps5mOoYpKLNnZN4RnNm0sY+2S/vKVzKxEOlTzfB1txADP6WQkfT+rqqqPwZ4B56CKWCpxuvIOib06oeT0d7xvc2V4e2vw4BkcGUHuAptkngLy1w63QzL+0dx1epB4fb8oI4L5JdnILPhJkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(6666004)(86362001)(4326008)(9686003)(26005)(6496006)(66556008)(8676002)(66946007)(38350700002)(508600001)(186003)(316002)(38100700002)(66476007)(52116002)(33656002)(6916009)(44832011)(5660300002)(33716001)(55016002)(9576002)(2906002)(83380400001)(956004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHPFbt8ZaG9JDmpbEzpdj6XRmQu1y+9Jx5lJ3XHh1EnlbHckBaJtTYubJpZp?=
 =?us-ascii?Q?qEmta00t3N68kfxHlgIrqSaz2XsSYLbwoyihDng4ggDWWLzoIf3hlZhRO6b2?=
 =?us-ascii?Q?RYzngkbcaSKXylQk12sKXCjcgmq0STGw/NwLpyiDQ5+AOM2XsSN6LfckjPM1?=
 =?us-ascii?Q?E3ExV/9vpc5MoEFCZXJAWsoR4Ij6eS7P1PcgHXpqrWlHOxIfCcb2FwLCzJfl?=
 =?us-ascii?Q?21fXzhe97A+KPxuq18n7vgPD/lFmOuBCRj+eBzVcT+1pSKXCbvP2uCkHd2Ab?=
 =?us-ascii?Q?DmwVmT/ZX+aexFf5DKxMODxtEWSgY67C6ryXRZeUTDxHNIuwPRVSr6GN4NSI?=
 =?us-ascii?Q?zBD/hne1SZ/XDJPQnLRLu26+9rL+cRNowR0wsnKQOUZlgN8ol24EgAsZh+PQ?=
 =?us-ascii?Q?1sbND+jzY3EJWBIXIMQ4RUHCLbVeFGoLMmfiFq/BxDa0MfZ7pu64U8gTTEjl?=
 =?us-ascii?Q?LDcjRg9f5vmNLRkvb0BoH0EVx9yM/0/sil9kYqpeCevbtD0ydtEUmYSdLW+K?=
 =?us-ascii?Q?DW+WPv6yg4kHayS7kQsjJq++wSdzD/VdGKep6VFajiD+B14J24MS3zLfAkAk?=
 =?us-ascii?Q?eoGJTh0Lbo4CEpre6uEEoUvu5xopXJ4vRkwYyIO7wXU3WSuQN7SEDcFkOLIR?=
 =?us-ascii?Q?5GYUyZRqgB77SoDP/zH3RWgu+zNELVOKsm8ezJnB9bNJzYtiYpZOkixUBJR3?=
 =?us-ascii?Q?6BBSRpEzHVnJB+bqAIiP1ZAXBjoxK850OKcvjj0cPVpR4/azQB/z7MBIlGes?=
 =?us-ascii?Q?8lVMe/qFBxF+2xwwPjckYEKxO4Wor5Ft3t7uvhSYFLpr9lHJ7JUZRsM2HFgr?=
 =?us-ascii?Q?TasydEeMj3oO3uVjGFQrUbstGHwBwV+mZbnH1nBx742ZEYo2ydyMY/uzDl1f?=
 =?us-ascii?Q?9xA2HOeq4eLF4jEzxsmIILalt/DeXcEHiifrYK5XTeTD4aaVcUrkn5AaQkVe?=
 =?us-ascii?Q?2d2I7xeSh0dUWcEK9NpKQWvN5jyD54/FepWkAZ/XKZOuOk2Ujut5N+7YmQ5j?=
 =?us-ascii?Q?GBLtAelJ1Dm4KNlnxgwQVtDG5hDHF3u0MZMtQN5LB7PvJp1B7pm/uem+MtI1?=
 =?us-ascii?Q?St18EkX20syGHBVhjpG6sztuar/jTTwL+8vnqG5LLBI2Jq4VFu+3e6lIdEdS?=
 =?us-ascii?Q?HqovrNQx9GY3dFQ+5kYSS+Hdf6wO4RK3Vky6MFmRKyQlN4+Xfce8I4bYYXoc?=
 =?us-ascii?Q?NLGBxjKAFUf7szw6twG5b663sUK/4av7Ty5XPCqWiP2ECnu5oy1Wt3bENWmr?=
 =?us-ascii?Q?yiPJyn1uNVirOHBt0Z0ci6MA0C8MBUZa4DZRK2oasfWhHZvANYFRlfHQJJxc?=
 =?us-ascii?Q?Cd8b9/PW+0D+LQmPNxpSKwySApQi1ZiXNHwtMa2AxhP6mzhC3x1qqNA4njSk?=
 =?us-ascii?Q?tJDgSrm0L4VAuJphDJAzOjIXWwaXON+j9moO5ii7FgjNPMUozHBvCDEUq6kF?=
 =?us-ascii?Q?U/R5wi80AM3oGx5ildwrewUsh2nVsGwxFVQAX7q8gGQWMbOOK5U0G4/UMZDV?=
 =?us-ascii?Q?SWKsKuBbnxMIgkaH9c1tufJtdn+3ZgrhqHoRYZ36cBi1+CWh5u3f5/i3rmat?=
 =?us-ascii?Q?71D00nFub6ABA7g4mjKGOoWnL26jjexRpG4grTYPcg0U45KbgDsh733vOk2H?=
 =?us-ascii?Q?3Ap+Ooffzka+U7S8LcakQjWTXEHnjaCZWN0OenPKWHZZGCpqGuNErt3alNkX?=
 =?us-ascii?Q?qpsuML0deOLnIAxYszE+al3V3RE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6391d0c-17c7-4ab2-20ba-08d9a47a4fbf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 18:45:48.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RacyVv3GlMgHxfkwgnyGSssgan7U0GNGIqjrruLi0DfDY0cPZ8jPYy79ZuZKH7X4Q9SNfRvIoGZyyQVd6b07NGREppEfngPOi41e8wVo/Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100093
X-Proofpoint-ORIG-GUID: DloKM4kO9KEef6a0Wi8NnR3VJz_iiytp
X-Proofpoint-GUID: DloKM4kO9KEef6a0Wi8NnR3VJz_iiytp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:47:15PM +0530, Saurav Girepunje wrote:
> Remove the goto statement from _rtw_init_recv_priv(). In this function goto
> can be replace by return statement. As on goto label exit, function
> only return it is not performing any cleanup. Avoiding goto will
> improve the function readability.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 51a13262a226..b38af76f3a67 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -58,10 +58,8 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
> 
>  	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
> 
> -	if (!precvpriv->pallocated_frame_buf) {
> -		res = _FAIL;
> -		goto exit;
> -	}
> +	if (!precvpriv->pallocated_frame_buf)
> +		return _FAIL;


I hate pointless "goto exit;" labels, but there isn't a rule against
them and I feel like this is not a good enough patch on its own.  There
is so much other stuff wrong with this function.  It probably *should*
have some error handling for example.

I don't think this patch really adds enough value.  Take a look at the
function and almost every line can be improved...

regards,
dan carpenter
