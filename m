Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2593CCD68
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhGSFaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:30:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27108 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhGSF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:29:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J5Fiic030313;
        Mon, 19 Jul 2021 05:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NNYCOyvHXctoGcCdpynz8vNMcuSDun8MVYKKagZewPU=;
 b=yvktnaA8fSeSHYdNlsg/DqRXQCBjaVCzWXUuromsaQZv/M4UrCmOWR5EZ9l558MUOd1K
 kumJJ51TTn1Hd2eRcu4zvKo/e4Eg724RWaTdtNCJohJO4yufqhizqcKK1kILAL+F2nqz
 hg824qWtVDdPM9MtUhQTHwuE+qmQeTiq3YRgTP0EfoKbu4ig6qiNh2780+K43DPPDpzZ
 39qnaGD3MJUtsY5jB8jm3xys0KCiblJL2Tk0W1rWwPCeOpIwJOrdInB0ZDcOxm/wNPD6
 rcOwTlJaaM3kHyBXD9ocWiviNJTnejuZfLTHITkvHw59SgNsUVe5BJCsRbSniNTie/+/ gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=NNYCOyvHXctoGcCdpynz8vNMcuSDun8MVYKKagZewPU=;
 b=R/fTtIddpXXtvGjzDHBkHxMKUI9nLm8mrfFiHYZK+VUZxbFZqCyZiPIFwi2R/wsWEYpO
 zuhNPZ2YLyFkY7OtO+coDK7IFoGikIMGockTDF5e9XYWfN+K+VWxrz48n2ondRz0BNof
 QxvcDdpF9ORnVUfSye/EKrAK2jKZlqzWls1cHGFSZWA+D9qA5zAxpd5EIP/HSZ/0E8VO
 ERmCA7sWKbG/Ei8umkQMtbRMNYAewls6xS0TYbLqfntGIqBOfgUW3J2VntyK6jOe3gxy
 JYwcxXgwpnT8v8aGCwPDDrKNlyr5hCZqfUjl0M4EHsCjs6Nv7u+3faqMjSR8sbzVO0xd +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39up032483-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 05:26:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J5FCV3019608;
        Mon, 19 Jul 2021 05:26:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 39upe7kgrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 05:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdnMwMBm3ZSi7KMpKhbMRsmAtTCHC5DA7OPMyFbx7TdiB8ULQ5zKawAtENEscykBXvQE17VnwuflVLmrmoCEwbSBhtxzJDHk8DGMknyouECaQyc1QIvLhKaWIsIOIfjzKXOMoEopCuqC6dUZLFV15gWhoR2JKqubR6xxAxYYEBWc2kgM2fe1E+hHOLqUttvxTV7dRkZARbBMoEw9CpC4mhCQZVmntRBzuYt5/okJWhVy6ivC7uVQofl67ZdU2hd3wZGeoE1Xg8rDb6TeIz3hPZ4ELdiA4b9b2Et436N8EPYshFgNzE1Qdou+v3WlDfnPrF0ZsEjclLGOdl/p1kpw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNYCOyvHXctoGcCdpynz8vNMcuSDun8MVYKKagZewPU=;
 b=oEt3BUYjekMdk8xe7/HT5DpAmf+/vCs94w27nSoiR/2yq52Q1nwbSnGn4CRX1LiWZQNbuoIusxlvHNCPBFgiZUXo8bsG8gPEbDHgX0rCclEQ3SSCOtsdjiTKzDoTqv2ZfY0PyC9EOARYFzX2elBOp7nBrah92o9JEtWJhTV8gxRo56IKupFkG7LWS+Iyrrt3Ac9CrTm2O0lVCXU8NvWpi4p/xaCx9PAt1xzdEDb0M583WpP0ujqI+SdrWAKSdyYucOleRzl17zPKG49k/yB8xUFPutENagjKjT77a7RYYwQ6sr1WimRXVZrRlKIGxdm5/jaKUxVXsMecQLJ+Ck7rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNYCOyvHXctoGcCdpynz8vNMcuSDun8MVYKKagZewPU=;
 b=bczxih4KKO3VUfPeYT4LTHJPXVNAhqXshWqYHvjTw1pgopwr5+uhWoTsumLt2lgdQFWVE4CXahdelVqWQeDg90cx0sECQAFhOjUyVn4l7wHb+QWcqmce1tRpmp5vWel57EKIRd2LXoMQ0/XCfvTPUbdIS6CB7eaDHvNrZfMqnzo=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1728.namprd10.prod.outlook.com
 (2603:10b6:301:9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 05:26:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 05:26:45 +0000
Date:   Mon, 19 Jul 2021 08:26:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/ks7010: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210719052623.GW25548@kadam>
References: <20210717153759.13468-1-len.baker@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717153759.13468-1-len.baker@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 05:26:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70ea2994-1c65-4596-9135-08d94a75cc77
X-MS-TrafficTypeDiagnostic: MWHPR10MB1728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17288107E873CE59C0A5C4058EE19@MWHPR10MB1728.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSC8bJil/CG7Q+BJ6WtP9y+MkdUn/ek7TfkXBOuB8jcUho8guc5FlYy/osl/lf922E9Wqm6Naz+iav86EVTy2T7KehO9cRuICi31X8cbaTw4gBRwPavujGWGoMyIby7/58b3XNci0z42pBNxbkPK7POSsPBEXejeKIQfY/OWUh1xEQhR8FcNEgfYa1uvC1DL0JqkO4wtccg5myeB5Phwi4KJmSRvDVvB/nrSgo6BZ110eOKwUahTctIIc1qEGGuG7hXMoz00409F+pgiX/WpbY/r5R0UBqxO8MCXz26bf8LxI22x33QAcTcX3X7wGc224EJ40tBhCJcO1bEBWvAcyGRmF5GmeUJ6OaP1KUU5CcFrKk653Van77wky+jvJwKfJtq9+AT4hma4t7LlIr21OJBGmLh808PSZTSV7u5SoydgIHnafYmArCNqSkWCGNIjFvsMfzpeKSiSaYGyJGhQO2b0LABBId2JUxWYLEZuoiV2eLBS6W44GAwubUdQnyK3AN5imtACK0Y9Vgaw7wQnA6jhvb2FrUMicmepYXLGQTgKSF7cSI8I4URhaLghP4uU1yeGXQVFU9yCwkgL8uM+1/zIliup8FKh7qph9SGyr9MkQylh/0nqxXIfTrIf0F/1q5KeYixyivbHYBrgawWCkxTte8Q2iorsQC24xLl6bSueqKUAymf5+cD7cp2aM9qjFR4OfgBw2n61RNbMVwZAsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(396003)(346002)(478600001)(4744005)(6496006)(8936002)(956004)(8676002)(86362001)(66946007)(26005)(33716001)(6666004)(4326008)(9576002)(44832011)(38350700002)(1076003)(186003)(52116002)(33656002)(66556008)(6916009)(66476007)(2906002)(38100700002)(54906003)(316002)(5660300002)(55016002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LusLfhyYZ1fg9JqEc1xB1SPG8Pi0IGtRbmh19meuEsJo04D7VqdT4cpEWAzr?=
 =?us-ascii?Q?O98RKw1r8ylEz6k1Le2KIU595ay1I/K/8VLYyS1ds1WE3O3pnhkl6/pljECy?=
 =?us-ascii?Q?8wHNMUKCGl1C39YI+uFu1zbruW36ENFE+pS1kJBoCciz9fhhSCwWj7D8J+dn?=
 =?us-ascii?Q?i4MMkbYOdQSsyNmPjZqjAUFSeT5ZT2SsR+DjV6N9vs4Ij2J3asKV4XOh9fT8?=
 =?us-ascii?Q?Hi819S+b+Eh+j+5tM5NGp5L7PYMezqhpl6eXScO+Yjp5YUOhJyJFK2jjXgnR?=
 =?us-ascii?Q?xwxvvpsPrzvwtOtFDnUpyjdqNfqWqNasxoqzOjg5Azd5Bl5P8V2gVRn3yNmg?=
 =?us-ascii?Q?yADxdeDHvBty3HgZqRei8EjCJI8GLJECdmbqhV9spGj37hIZ4DYarw6fjX3+?=
 =?us-ascii?Q?YHs+RjMcrpD8TIKHcOK2Lu04F8KriVi0Xv1cjGrM/5zHpGTY+XOpdofG2Jg9?=
 =?us-ascii?Q?7lS6EaT8R/VcVvMj0VR9OIh82umGmzUaTJViHKI5ZqGpwA6oSDGfv50eY+yp?=
 =?us-ascii?Q?ULgKaCTIuKX2q8gMej7QXmNnsGRcrfRjtbsTtXt9GVtY0wV5b4WsW/f7cdf4?=
 =?us-ascii?Q?Vvkf409HQ6nZcKcCiWaD7x6DRvdbFbrRIOEAlQo2djVrf29PoXJ4LIBpLJrZ?=
 =?us-ascii?Q?zdO9ak12myTWf9y5XGmBLnvHDQPx3+hpa4mxVjm1H4JvTF5RI6gBxiDLWp9m?=
 =?us-ascii?Q?Rg0uHxaqcBlJ5d5lMzamJyMTMdyl49VSPZBWGjrn91iH4hYR+N1gkG8O8Cqc?=
 =?us-ascii?Q?vVaOgNgnpr92Sgb9N5+t8M7FzuNkuktIhaU5WINDRJ/6uEmBHtzOnf+9nJ6C?=
 =?us-ascii?Q?ExqGkcYKfAk2rlo79BDOOrqO9HOuw116bWD6LKqBKdLqGss5wBSeKloZaqPM?=
 =?us-ascii?Q?+1rPKk6WfjU5d3lc/EbFKdDm/LBbHm0ed7gryVH/e9iXCA07vMgu5nCSTrBS?=
 =?us-ascii?Q?h6wKWqdZygETXgGKvNeLSECL52FmlknXc0oFYCpfWIE4aB+I0YaJJHNJ32N5?=
 =?us-ascii?Q?y6HaKeiebX4HGJcrrIbDTRi4WJYBv1uUHad/CxmPCUzUbemeCUZp4GjrfaAz?=
 =?us-ascii?Q?RBLrxBl7zNsTTxJDXV63iQl0DtA5BkQjhIMp5u0kxOae9BN+kZc0SwYkJAPO?=
 =?us-ascii?Q?XREIiirPaK1r8R1HGCqImy76ptckzAQ5NMPu/25L8VwzgFdnFp61sVscgewx?=
 =?us-ascii?Q?5ck7BatUSu5cuJUoJLGHOUGYKf+DzHYPnNTwyugubfqGqyXornuuR2Ppdd6+?=
 =?us-ascii?Q?fHwtt6A0n2nfyUseH7WKTCgt64xL3LG6TYj8mPTyIHjkNtGMS124CHCp6Gvd?=
 =?us-ascii?Q?9JDgH74fyhM1AwZDYOihQYnA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ea2994-1c65-4596-9135-08d94a75cc77
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 05:26:45.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDG7gq1G+Sue6eIWTvjE8bbIs/vMhlcdLS4Tm/jtmGsL35QtO8Yq6bZR6N+WtE7QZ7Bblp1DG6C4DsYmeUBOfa8OA4FdSwuMgq9dNUpJw8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1728
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190031
X-Proofpoint-GUID: e3Xo2GhNDFPwjh_WIkahmPcChjYyrjqB
X-Proofpoint-ORIG-GUID: e3Xo2GhNDFPwjh_WIkahmPcChjYyrjqB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 05:37:59PM +0200, Len Baker wrote:
> @@ -1808,7 +1808,7 @@ static int ks_wlan_get_firmware_version(struct net_device *dev,
>  {
>  	struct ks_wlan_private *priv = netdev_priv(dev);
> 
> -	strcpy(extra, priv->firmware_version);
> +	strscpy(extra, priv->firmware_version, sizeof(extra));

Extra is a pointer and not an array so this doesn't work.

regards,
dan carpenter

