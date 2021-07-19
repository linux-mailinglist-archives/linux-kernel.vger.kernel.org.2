Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAB3CCD76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhGSFlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:41:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13342 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhGSFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:41:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J5bwMa020923;
        Mon, 19 Jul 2021 05:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZVonYOriVy7F8dfqDCuO4fgiPGRWttkj/gb/IZW5kIY=;
 b=BaML2FFG2ARqQoDEyjucRZUe9rbXE1NC9Ba5Wfi1qCLl3B6CshWCKwDO5pUy9B4JSgwb
 vqJk8fBkPqF08UCp1T8nZ+f0ifMDbrggBcp65qQUaMXbmZg1d6Nuy6Hgd+38LPBVmKWC
 M+mA9+AoS+8aJJxvXjrJg2VZHEB1FYWwnAvHN1iQ+c5EIZBy4MPfARmabv5gp6OAlu3n
 paqQDb2SuCCt+S1v1Gt0rewxkPHWjgCBI5JvUtayZ1I2a2bk1cQ7+dP0vxxUURp88WkV
 rurLgx5G/fMXfhMVUAJr2kXUHRUNTBL/k0cwY3D+KypQ7K1Qi3P43yramxjPJcH/R+2N dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ZVonYOriVy7F8dfqDCuO4fgiPGRWttkj/gb/IZW5kIY=;
 b=crPBvoJevvAYy2YY05Qswhjp4s0p1n7u9t7Idk6SBgwVkA8dVGJv1hIDXxo/+sLQNMEO
 /s/f1lzxwk+b7Xdf8DU7OFRyGfwqL0Ca0Brzs79QC/BkCu8JLSYfccRJJpuE56iKb1iw
 pMeeM6QPzZtucuHcqF7xg2KzNG1fhrBr46MIApcQigr20klwtuTwc8Mnmq4Bc3oFl0Yo
 UUFXA86kcANH0ewLln2bOcyKFUWNVFTpp407IvKRBVPMcA3R2pRpp1o6tNXvbkwjjS6h
 2Mz05l/wl+wxjmphIm/Qi1AHZEGmbQEjZ9obLcPOmW95HVfruaMnb9OOkJylNKXn+YS0 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39uqrtj2mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 05:38:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J5Z0wK176597;
        Mon, 19 Jul 2021 05:38:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by aserp3020.oracle.com with ESMTP id 39uq142jx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 05:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Jm5VnXbMqTs3hHob9nIItsl8D9DeiHvhj430KNBv0A0l2H7v1pLZZ1lzQnDJEMbGza60IekHxr1fyvxaKsv3u5AE64/E1WeYKR3FMt97y/kXaRdmoKfGMDCTmffkt3gcf8tZD7whRbWfwEJVY8wt3t1CBW9kFdmucrMl7dUqRhYALhc9FSXGrBj7X0h1mw9PNbS1ZDHrYtkomYBx/53WZQyEB66jGxp6w6A1E2S6KLiRj15ZYM5cOWDq54FMCoO/pU1Mp96e+HIBBAmq/xf9NJnzi1AL59np5UXufgHVuEzgea+YGAJjGk9tVa270bxtaCz2E1i1via15eW7w16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVonYOriVy7F8dfqDCuO4fgiPGRWttkj/gb/IZW5kIY=;
 b=gf63QKoR/pnqBHOjWstbgyHULX3rhh62lmsVTt3gWRiypZwkGamoKaQd7PcH1oz69NaWTus4bgg/NJOVQHJn5nmzCM++XWp/JoGLI5x8Na6zW20eohYTzMHC+vlILfu50bqNRH7iwY3fY6ZpYtt+QWbOYYGiR5NKxyzR+erkxJrL/hvKB9zMe3MIQOsuCyIgi1ogKJBGMdVH847BStNdRyelFgjeyNeHsAWtkAmAMLZXyRW29oOMQpz+YUnJG0upScnm0xky+KgFiLsigMd0kKn97BlwN72M/K9wTc0vNuSYfwhsaT2h7MDBcczTNHt/riWwl8Rr7u/CJvgF5ZamIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVonYOriVy7F8dfqDCuO4fgiPGRWttkj/gb/IZW5kIY=;
 b=d32za+1ND5dqCFvt/fwAmLfUlcTNRtzNayfNJBXq4TJVvpnYEWBXoR7AbFfAuQ+EPC7J00Cg+nyoNE6DFkKj7Ke8N+JvYnejSeaW+JsZ6jKY0ZOjkQ6Tnil8TKiO3GoTBUriwE9xb40mqLAyOwgNWS5irLjjUHOXJdMapEH9RfU=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2397.namprd10.prod.outlook.com
 (2603:10b6:301:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Mon, 19 Jul
 2021 05:38:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 05:38:09 +0000
Date:   Mon, 19 Jul 2021 08:37:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210719053747.GN1931@kadam>
References: <20210717155145.15041-1-len.baker@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717155145.15041-1-len.baker@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 05:38:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c77fe7-b5d7-4dab-f345-08d94a77640e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2397569E48FA02AD4D27DE1C8EE19@MWHPR1001MB2397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yt6P/vV1KWjzpLExoytEXIMuzo6yt6skLaWdvBuIiMiJiiP+AtADIASbziSliuzHalOKib6FFqOm2q8N+n1e8qnPWs/Ocv96RsSsqGelCijO8X5VdltW3fzR7pBaSr1hjzp2sAloI9Mvy4SHley6LFAc+ebaDqqaivP+rFdOGrp84nJAnUxNsTCKoA0PMVzc+eFFxiJpylj7FZ56ZmnZhrZFj6bbCzYI3p9Nz8tnis76Yq7RwhK5QuKLmbasP5jckrvzWYK0k0jlwWEawJGzZYA76OJA4FQUx70Bn1X3GEeoyVzYrCAlmX7UDp/o6skLntP9G3FByX3PotTEzahSWutbIGghVyz8KaNBAfPcFV4+Mkgm0yj/CaXEtx9jS6BE3jpfeuFhCwq6+chlSJ2LDxOHPRojmeQWYCuXnTroxiMLAePaOgfX+n/nMdO3wH8XhBvJccnX26stJFmcYM8Y51z4NHB8IjfKGNFClopa9edG8ObJQOwd/qAqha22HT3f8Cx7Sa0HWzRlFbVz5+uUS1NpY4RWuglS9xLI6P4ZFgdUPqmgs18c2eObxaFk8zBXEWz2WOP8ctJEJYSeC+xgSHRJin97V2i7qtI0fBDoeCsaV94+D3cSBlLo0IN7vecJX+0JcLX43epetPiJJ2tZyrO5h/oKMFW0cBxE6x6vNlWI6vTOe47v9uybiYheT/uA+gq5WcX4wCVrCKL/suzNgme49e+jqyEdnNtQa9VW2fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(5660300002)(9576002)(478600001)(52116002)(316002)(4326008)(6916009)(83380400001)(8936002)(9686003)(2906002)(66946007)(66476007)(55016002)(6666004)(86362001)(33656002)(8676002)(33716001)(26005)(1076003)(956004)(66556008)(44832011)(54906003)(186003)(38100700002)(6496006)(38350700002)(518174003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tx+0wdzpouWuz/QSkVa7dMxtNcwKWpD19zpZ3byec5UGBQxn6YdBiPMws49J?=
 =?us-ascii?Q?8cz+SJCV29yYV7ZQpJSjojxVvWI4jK37K3wY/xEPpgR+PfmSy7AFby9pNIbI?=
 =?us-ascii?Q?LfrRsBrOFlLlo54wb4qZ7ar1zt7w9rE6QTm6THvtbKAEwxd6KMqtgcD1a6sC?=
 =?us-ascii?Q?bxLrxaHDn+O6OcE8jLRtq5fsGKw1+OigtAqWLZ/sGMwEMQ4ggypnEGrEuUuq?=
 =?us-ascii?Q?1pk+/VoYlRvPlPJpuDgxUz6FHwNarw0QzPe10hEauPACo18cPyDNdgKu43tG?=
 =?us-ascii?Q?sONPo7P8jd989RLjhu3WenntucEutIjAylJxysVy0czlYLrZ0pzM3IejlJ88?=
 =?us-ascii?Q?XbDwvapyJGisN5gQ4/tOlUYbq9GTsM2UrElfx9LwmCiaIkt7Fw4GFDnkEdtm?=
 =?us-ascii?Q?3RNx3BXsYbAWofOeszAKeq6OskdElcd6GkqcQOTQCpouFjaOEuIh0N2R5ch6?=
 =?us-ascii?Q?NuQebLLp0VAE0WvzbmDn0kQprrZaw7kFUs29zAqd2qsk16hKc0gk9pfUYjr5?=
 =?us-ascii?Q?VQPFX7NOqM35EruriVYVOGEdhHR6okHH6rCAfuyk8JR41IMjwqbGhcg+wmWk?=
 =?us-ascii?Q?XXnXVOSfEDKrbzASFteBuQ1OD+FrsyKrSv/64yoqw3FUcmYae2g2Fj5fWTfY?=
 =?us-ascii?Q?neSx0jp3uZb4qMH+hAtPnwEN9icCHN4CzOMwJLzDKp64Rj+TKw/nDFDoLpTA?=
 =?us-ascii?Q?+PJJkBuZz/8dd4QHO63LgwBJvH9CGci/8FlDgTg9PBGwLhxxuxRKztTFvwDX?=
 =?us-ascii?Q?M5C33VXbfpCr49j30nYgFyhzcfHjRUIoThXk9WOn/kPrU+GaUuNZSNYHrIDx?=
 =?us-ascii?Q?HWPQquV87EGsML/LIjB2Hrh8ow+6QZidCO3volLE0mYp6wSq6tHeXuW3cm+z?=
 =?us-ascii?Q?/Do7qX02C76HfUkZawMueafJxY8iX2hM2K1bk5KXBOwXFrYNt4RrCx1szHBm?=
 =?us-ascii?Q?bkoTf3qV5dpf9Sw5avW43ZFDAhqrM2lO0NSndZxO7KNLPARvRcgRMae76ti6?=
 =?us-ascii?Q?z4JJu5aHqdoeuoli/Y7nVS/t1DWxxjncPpLsyoSPgVDZUwriN0hjXn7rHKAN?=
 =?us-ascii?Q?MGzw7T3Lv0gtj3ZBKHEjUMWHVKDeWBtPtInHlOUCPFbAdXJuaU8XSRwArn5c?=
 =?us-ascii?Q?lbF3iCUPsKPnczjytnHQsz9SZ/a3XwZ2b4MhuprGQ9ySL+W3NXWom+/ZRfnb?=
 =?us-ascii?Q?skvEWQH/eX67neQ9BLY71xC8R36VZ4d9sJEWaLasbX+G/X2a8QsuhNM2QkWx?=
 =?us-ascii?Q?T+RUIQ8TEagFQcuH6cMJkLfNcfITl4/CHjFo0143zcuMCNImj3MWLbNQNOkA?=
 =?us-ascii?Q?0rEykI24g0httAXM7jFiQ9Ce?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c77fe7-b5d7-4dab-f345-08d94a77640e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 05:38:09.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SE2O81vTtpOtJBIeVDzeHEOlKJejmya/Xj2h2aU2Uh7/4i32zJKlaTtcX/Q9yqDHI9Bj/vf6YJRq5mdMt4MVQA+oFOrdxpTTXTI9fijFXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190032
X-Proofpoint-ORIG-GUID: QwQoNHk696k_X9Ln3JY-lO-9QO5HSxZy
X-Proofpoint-GUID: QwQoNHk696k_X9Ln3JY-lO-9QO5HSxZy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 05:51:45PM +0200, Len Baker wrote:
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/staging/rtl8712/os_intfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> index 2214aca09730..9502f6aa5306 100644
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ b/drivers/staging/rtl8712/os_intfs.c
> @@ -203,7 +203,7 @@ struct net_device *r8712_init_netdev(void)
>  	if (!pnetdev)
>  		return NULL;
>  	if (dev_alloc_name(pnetdev, ifname) < 0) {
> -		strcpy(ifname, "wlan%d");
> +		strscpy(ifname, "wlan%d", sizeof(ifname));
>  		dev_alloc_name(pnetdev, ifname);

Not related to your patch but this code is bad.  What it does is the
"ifname" can be set as a module parameter.  So instead of testing if it
has been set, it uses the checking inside dev_alloc_name() to see if we
can allocate what the user requested.  If not then set it to "wlan%d".
If we cannot allocate what the user wants then we should return an
error.

It should do:

	if (ifname[0] == '\0')
		strscpy(ifname, "wlan%d", sizeof(ifname));

	ret = dev_alloc_name(pnetdev, ifname);
	if (ret < 0) {
		dev_err(pnetdev, "allocating device name failed.\n");
		return NULL;
	}

regards,
dan carpenter
