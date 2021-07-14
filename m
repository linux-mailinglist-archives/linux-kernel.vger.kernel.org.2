Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A123C8761
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbhGNP3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:29:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25972 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239602AbhGNP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:29:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EFHtC8026381;
        Wed, 14 Jul 2021 15:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xJ7NzFWsl2Yq0jRDafwVzWUsJWSLiZj1QJBrntHbg0Y=;
 b=zJbp7nc5Ju3E8ovTbBKBpyzwbhflLqCdircY38ypTgbeYioHLtld4OWZXvBTYN4h750j
 iK5GQeOnQEx28/SNvh93Db+X1Mii2bRymYEYoT/dxvjQ09dgODp/c+indeO9C2CHrU9T
 x0iD4Ampkj2WpTPMC7r5LSZ0J03B6HThIzrgWpKzAJzUc3YESkkpYpWmsH0aj++7XqeC
 whZhm4dqEIe//56+DeDUMmENQ5TpbE0rv2WOiUUWRZP9DFEwZIrs5f+mQztEPVbo8ISo
 dJh7gRwr1NJ2dAvilp7xyVft2EbVgnZzq7ViDMJqf6nP5xTe+hM8T437Xx71dkCmJMJi gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=xJ7NzFWsl2Yq0jRDafwVzWUsJWSLiZj1QJBrntHbg0Y=;
 b=n0eKurHbHfrULOkONpMYOVhKBNgeCAm4JB1Jybd7zABVENnKjXEdR/BTT3z7WzcDhgrO
 jouDNYfS76pr3pGgDKouEiuRvd7vWLTDt31Ipn/t/iXnDWmLGrX6jdzNBfQF/juMwfW9
 VJjlWWQrXVZ+CelpmYvu477khrY+f1ftWvacHzXBWpRJJ+IZNHBpNXsoP/CEMFF3cBPG
 SEEEO36sLfInOo++XMlXUZV/kGzKearUS4MdN7TyuuTQ31QRsCoZQAKyc6+WtG2Pb/Ys
 Kdikke9rKLNA44VN2b4qz2q8hU83JPT5P5Z+v6K6aZsUQw8glZ4s0qF2q0zCXiFEegWq kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39sbtujqp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 15:26:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16EFF0Q2168034;
        Wed, 14 Jul 2021 15:26:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 39qyd0vp4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 15:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNB1IaLwLHG7pGmz3MbWlpvcto0xhAH/YHhibw5NXRnBtCnLtu9xI5O0BnZ1P8gWGQFUZNV/FAKGsMG9O0H4b5FjCryRGkocPFeaox43ASFFEsp35U/FbWqReE/H15mXSXVP/eJRVZcG20HDKZn80gTcgAnNMzGze6OKLojcX5PCEdiNNIxSrYF2XwwuQjJ+lkBldQoPzVO1X1R1X/KgxmNnQK78z5kFrDjsRO/azxyRgEqxChcLtDZU3uElL+wodBkZVWxA61s91CRb27blvltqbOxb74awZoauNYC39Yo7JbcLYQrIpjimHhutx7sraA6L/b4IOQbBeCRD7BD4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ7NzFWsl2Yq0jRDafwVzWUsJWSLiZj1QJBrntHbg0Y=;
 b=UXxg8DulDJxC9ZGnVI643WzBukxinNmk3gjiI7N4m9IL/eYNnNm2Ww6a0uKjIgY/ciqsdOAj1V6Kr50egxijlt8RkOXVuUaBtS1soeDU4RVDKhj78GuGORik2Lx2zRVxnewJ1ZExf7DtoVifL8fvct6hRBrph+0lE7mo0btTbsUpMv4ALBiMrDyTM7Ujw8xyGobcEs/aVbPm11WrBkEVP79lU/oAsMSczG5MME0T/ag5PF5b/m8jo3iSu+lsIqcVKDEL7yHrgMjpmkpMNVl5hs/spgVMNGM2urXhKrV2IVvVEIvVYF8UA5IkY49Gbn4dSN+npSwsm9Ws+nxfokPDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ7NzFWsl2Yq0jRDafwVzWUsJWSLiZj1QJBrntHbg0Y=;
 b=y6fzVqVmPVrx47QMBRN60/Kt2+nWKtiEPVCZ7tClx+KTlm7SQ49Va+h8E3XRxKLOiUO3FemFOo1VzgWOEXMsOA7rudKIPz7NCOvQ0ZaXH9HyQKAVtgWnpBrTFoLaqScUBGc9Opaopqb2dFtbqGPiRlF2WXd8a4gZHKGrLCxdvic=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 15:26:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:26:23 +0000
Date:   Wed, 14 Jul 2021 18:26:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8723bs: fix camel case issue
Message-ID: <20210714152605.GK1931@kadam>
References: <cover.1626275102.git.fabioaiuto83@gmail.com>
 <a708b2b9902bedf5bd0466b05516a4c5b4f43723.1626275102.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a708b2b9902bedf5bd0466b05516a4c5b4f43723.1626275102.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:26:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88aa33b9-e5bf-4689-6c4c-08d946dbbcf3
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4643B0B782BD93C42BA777508E139@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:123;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxIfqekDxhUIU2DULxlTCso1axaik7VkF9qnbVcXqhlurEPy4oxiCFkuShtNAvLuUdYuo/GIrKlCvrGyePMYt41cfoLifjky9qE3N+Q9YyDNSMUTuVlrv4a0pRGFDDQJMLpuxSQ8ypCQnCo94QoCsYhWyJww+BXBTIogG0I2oRGl0FUTzlBLl0nZsJLjGeNhCQhTYpKpmFYKjKNVp8Cc27b7k3vvfjjJFyTmmHeDwgRb7BuW4wBfQ28wyec0+tk1yBGCavl0edE/lhRNqtg/tarwJWt2Og7+cdykYJ08NFiZPnv64lhpi3PpGiVuN9vz0Fl9PK2UVvQh2wQ6+4feCARsjltU1CMaRVxw96UOCamjwSJunUmX3pbHmBIjtaK9L4Aj+C2qJ3iEaaXqP/AkKeygYL8Fn+w1xb6vB6+Wy582ts8z1sLU7mM1JRfg0ggIp3xZCX96KnyVjeZsmDAqd6MkTKcOibLLmZuWyECbMzCs0GhcIg6gqVEqom2AkxDEetEdhYS4h9NqUKdh/mgPgTy6GL4r4vLgkRE41XGIGUd1oJ3uTcEZ7aRG1UiH8rqSuYCYORXXhNuhbsUiHNvUomlz5tx4zS/t2VXW3K/uUgsw0nSYfsPqOeHvg5/ljQ/5d8lO2jTQNNItbbW8qQzmFcMUgcWybwbCPpWFRgRLHqZ5zqCYZmfF3UmGnNYKqlynxJvdJFmZM/hv8w3UPHtrnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(66946007)(33716001)(26005)(83380400001)(52116002)(478600001)(8936002)(9576002)(86362001)(8676002)(44832011)(6496006)(38100700002)(38350700002)(9686003)(956004)(4326008)(5660300002)(55016002)(6666004)(316002)(66476007)(66556008)(33656002)(6916009)(2906002)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dWPNufIeIn1QbNNVdhLE2ZN4LrBslox1jjvkDIwgRhBRnljYWRPtCI1zoZMZ?=
 =?us-ascii?Q?B8et9inV6i/imGn53TrmZRM7QO01yuEdFN3ElpQFed5TLdhPa7BAOgzKT/84?=
 =?us-ascii?Q?FRQ99OlgEalqHmK1jAoO29WyBB4mZpk5kmnqLEpUIzcTZoduh1rLSdUtjX8k?=
 =?us-ascii?Q?CQpeTvK4L8Fjd3xyB7yK4kDwsS5Qbjjk9mpapW24uVnPKDuZOZ7mZMkbTIHa?=
 =?us-ascii?Q?KkwtdrOUTsyoED5Kk5+045ubLXkgqCBow7ae+kj7h6/+yKALymQNItSNr767?=
 =?us-ascii?Q?ZCkPMuGgG+QtBURJWX8BqwXIiUbdj8j97s69hIpCZH4uxjNTss2dAEcbp1Jy?=
 =?us-ascii?Q?h7pKtPwT4wcSXUJhuyYEuB8R+j1165xWLNekd6zrvvTvrSzqG6qkKa/kz6Xx?=
 =?us-ascii?Q?YN4mmMkCr16D5Tyz0jtE+hQrtyJgKSm1ujg28UFTHbTWHODCw/XXS/vrfEil?=
 =?us-ascii?Q?4KxdjATSFMz/MyNtg+y7MuBfSefw5wDlIgrewfh6MkfYiw6FSr5v8v5sM106?=
 =?us-ascii?Q?LswW1gKjc9oM37yTjjgXxDsIMt4Y5SP68E4HtMOfYGHg7dQapuNu0rtyOWhl?=
 =?us-ascii?Q?Cl4oiJ5vBCj4Auz55GXak9klMsv+ZtJ6oeJV9zGj+3aIjiADSqy6ahB94vR3?=
 =?us-ascii?Q?RXW0T3xAaccX47YGO6B8EFcV0xvWMnskKtnkbTLCHhfomzTxcE4eh6/3Tz8N?=
 =?us-ascii?Q?b9BTtjjff+0l110aD39tohXIAr440uK4aFYpWo2q5BJ9TvWgXBFBIcO9ck42?=
 =?us-ascii?Q?qYEFx1/2pp3UKGvTub3Q5lN7I28yuZ0ovyxEy9J1Emfo7iNKda9einpJ0LLn?=
 =?us-ascii?Q?fePSW2jn3vhHRZxpcPyLCtUk4gzLfqWG4BRqsPyQlOJLdTEfArEtlVuPITyt?=
 =?us-ascii?Q?PJtdvlyJFSNuJVsC+voh8cQ+INu7d+B8+RtW3ZqjC+ctWcX87xPSmFCN6l9u?=
 =?us-ascii?Q?rzi1cWOtZD6aQs7zZMXxbP+PzZjqt+5iLvPm7HAr4f3UKhX1XDw9yANhmj7N?=
 =?us-ascii?Q?Ch9EaVAEgxWEBFR4gdR/Afv9UkxlHM2F1TfvvetRUKvVHTYHwgzKIaNtTSRg?=
 =?us-ascii?Q?6+GqlMMZg97f7xRI3rIsRdjDatCBDN+z2PHC1T7koqW1gft9F4p58uakBWaP?=
 =?us-ascii?Q?SWlExc/mCdYrT25OVMzYWXHDm17UQ7TQT2j+iuY/rGjb2iW6J72mjbWlOKiJ?=
 =?us-ascii?Q?iluuZa58e50uvhjpYjF5MwFzSFGefAsC6x4d2I8MhnuMDGa8Wtg+8k+O90EX?=
 =?us-ascii?Q?Zazw0Vnd0KQsLSDg6Q9TJE6tAtSN6tYrmBNnjWzjkUTqemrSYPO/idC1BaZz?=
 =?us-ascii?Q?uv5OXVSGcJIw69e10qlSCTcH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aa33b9-e5bf-4689-6c4c-08d946dbbcf3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:26:23.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+2rofw6Gj0Dfuu8IJi/7SkzyNU8xqLHDiD1ycRET5cci9Scd2yNTVcZ2uB0kMhd3TS3XpAk2kwbi8Z4E/+ebAC6TF7o/AK31OQx/TNxbi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140091
X-Proofpoint-GUID: OocT6c-N7fmzsz65MotE2iwhnpdBlrC3
X-Proofpoint-ORIG-GUID: OocT6c-N7fmzsz65MotE2iwhnpdBlrC3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:11:14PM +0200, Fabio Aiuto wrote:
> fix following post commit hook checkpatch issue:
> 
> CHECK: Avoid CamelCase: <NetType>
> 45: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:170:
> +#define is_supported_ht(NetType) (((NetType)
> 	& (WIRELESS_11_24N)) ? true : false)
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> index 8eb0557a077a..b2c1a7dafcee 100644
> --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> @@ -167,7 +167,7 @@ enum network_type {
>  
>  #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
>  #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)

These are the same.

> -#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
> +#define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
>  

regards,
dan carpenter
