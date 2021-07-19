Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DBA3CCD94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhGSFr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:47:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41362 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhGSFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:47:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J5cVIT032313;
        Mon, 19 Jul 2021 05:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=B3IgYkEz+BcosoRTnHCMQDKFfWtsCwf+44zLX2ljPKs=;
 b=f0PTac2iC59zixy2ioLCMSwJq++/lj2m3D8BNYLFvCi5QrrFKW+Na4wNBumDSlerk1+C
 wLi34Z1xZNoDjSSM4KEy0a4qO7xg/yfa46zdoVwkzwxyskvNa5fzTG/Lc1jVI9ttB27u
 ddYP9E2jq2KiPjbGBAABQR0pg5klo6WHfKQRD3+4HROmrQvqLZeNJGX8Q4/cj6lfShzo
 EL9Ev6m2OvBTIbdWBzjQvXGcSEBxKUG2fVDt2KtQXjvW4YivI+PRsU2Z5ejEq9NAnN2O
 5mAbqly9hD4FWiDoKXcPmk3T5Bjh/e2VttjPbMfBw0OLf8bRhJIPdVQkOmrhJTVMoFzu mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=B3IgYkEz+BcosoRTnHCMQDKFfWtsCwf+44zLX2ljPKs=;
 b=bk0ZyNK7pgp4U2yZC9TK7CBKPUDQ9MnxE4VdQmDQAZk5F+FrlHOOYXLZZ//9UwPyo2xn
 j6PMxFQkNhSO8yyTL+tE3v8sroKLdQ1VQ7S/SUH7ksUArmz+nb5Tn2VLnvSILesXGcJY
 PlDRrDGLTM9wBYwf6UGrGR2zEep8kJRkEqEHTTPec0M8hwiiE7g1k/XG3SgN+ExNs/WV
 aDRZYbAcHW6lZYJE/ClHh90LBwKu4x3TYVssUGDTtLUnjmOhu5QWTx7CZYJFryQegLbq
 fFMWGjP6lqzV1ppb5P+/BiZtLoOPLBwX+Il+IUj9ZdN4ZvAsp1+wTWf2aAnphSLUyZXQ LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vqm98hjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 05:44:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J5ZCn0068947;
        Mon, 19 Jul 2021 05:44:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3030.oracle.com with ESMTP id 39upe7m4a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 05:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5GpBziDhiLi+ij6dVxF+6teHNYD4Lzml/N44Sm+TBX/1iZT/OvRPlIn66xmlgT31ENNT2WsivAT+TQVS51ouPeP1IpyUHuP0qvV7BRjKAQdnwQn89k8ge4Ps20Tr/MwoVW2weJqyiDSto6t0mQAdQx3VrA7FVDXnPW/5xUs5E36zn1rdKzizFyioFHq8E85U3TbTsIfWgOOrAff9vzH7EcsCNf5gAESLta1XFH50Qk7arD60ZUME7YJWNBpjQTjtH4+paeMHNwBDypss0Fl3GafNLvYnMWivgEPWg1xKUu8b5jrcUK8cO4NrM03eXogFo26cr58mS+k3MM1Ws635Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3IgYkEz+BcosoRTnHCMQDKFfWtsCwf+44zLX2ljPKs=;
 b=nwc2nR6eFUEmRnwDm0kOfa56Z8EPASwighJmmoNcdescmkJmvMCU0O20OdaXz8sNR0/LD14bOA44hrnwPcPlTUIK/2RLHCjrssGFtLZKE5retKFt3wHwjCH8e23w6tPwOESSCqA1pq/bfYDcuYVMNlELg+jD0zPFu9HYdPM9nnJY6rlbYIdhd8l0wle9MNGf3HMwZtRwQ1eDxP/OM0qYkHAVZtfmqbTm9UbKAWOjJvFuaE4w+cw6yNEtxtohAEANfQPCC4TjHmlqn0z+Zsn668zr7+kH6yEtRmqayPR7OPQFu1IfOb8MGf7THWRlLJGVCAwOIITz5qI+b3oiJjc+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3IgYkEz+BcosoRTnHCMQDKFfWtsCwf+44zLX2ljPKs=;
 b=TUTr5RLcq1pbNu1b3kcsqP6/UFDilLxQSBeM/AkBl89OPGq45X1RqI2W3s9/7XmUhatWQAO3AGGFQaXcWT66qHJA3GGqHYaID21ZvAaW4cTw5pS0HCY/aRVfwQsLVaY57sVvglniKSCRgTW3c6S7rtnUHCCo7/rQNCxw+zju7n4=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2157.namprd10.prod.outlook.com
 (2603:10b6:301:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 05:44:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 05:44:09 +0000
Date:   Mon, 19 Jul 2021 08:43:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Kyx <knv418@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        William Durand <will+git@drnd.me>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        zhaoxiao <zhaoxiao@uniontech.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/rtl8192e: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210719054345.GO1931@kadam>
References: <20210718090636.7905-1-len.baker@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718090636.7905-1-len.baker@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 05:44:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97dca838-287b-4d34-9078-08d94a783a98
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2157D3E14E83C8D13B0E4D448EE19@MWHPR1001MB2157.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SphLYvY8nV+mgBTl8YZkYnn0ExgOyVfw5yPykc2307e1Xdo0hDYNTHg5MYvHI6GYNMMe9/bOZbPCRnSYiFvQWdznHAeFI6luAkSP3SP7MQ57D5tHsC8VKL9yeFLGHzrllDvZt6NLUzReh5rhKzARB2BoBpQXQ+BHKuxE7KuWUqUj4ifqvEtWsxw/BiLEFF5iHPHf8UVZWbIfV2HFUTRIaGbxmLsdDMGKjrMNsLknZ+p98dIyOtoOh0r85AJUmqtHu74YOV67q6K7/vNj+K/gFZC4lOSu78JrL9YZNrebZa/I1uuh3H4SUqfnW8coBikWSxtg7zhnF2BSdh24M2iif3E4AFp9DZ6LuNHq7aDTkVKeogXJ5ROkK4jfqT/2WrfWxaGjUr6MiTLMCLpXZuY++x6W/L3nfXCgXyo3DFzZYdIyygS2RELhvYdTlUcg+5bRGEb8I8AfFQ0b0M4IfQXhcHqJuQJDgvg7RUOMHN1gDIebqV0iCyP9QZEqPVOPT3Ng3weiKmf9ctc82KzVGvAvRD3KG4yEgVmFRveVq+FDAKE/Zqvr0eY64cCQdBGRJCDM/B4ADt2Mo+z5bUjylrBFJ8HBm7WY/ulhovJnrIVj0eMtBGHuSgb45nm9n4zEBZVkFrcFTSzkR7hUDWyoZYWFCQjmJ2L5+tg+AuJNNLZ/xOLFkgO2y9wzkD8gWverlYNz+CtmBrmtWGpiPk7EAjvOBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(7416002)(1076003)(52116002)(2906002)(33716001)(8676002)(4326008)(83380400001)(6496006)(186003)(26005)(316002)(44832011)(33656002)(6666004)(66556008)(66946007)(9576002)(6916009)(9686003)(54906003)(956004)(55016002)(478600001)(66476007)(4744005)(5660300002)(8936002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vnW+EUolr9FQ3wgLrjt8Tic0QI61qdnhP+a68pHybMX1uikaMohtdNpN0EuA?=
 =?us-ascii?Q?K37vFz5NkaOwCpEOnXQqTYX2zUwFo0PeSLXSifUcGG3Ov2wsiiZWGfwuE8uU?=
 =?us-ascii?Q?YgAN/6VHptVMmNZ+ODepcL9KIcc7cr0i+Fbj5+ETXfEczmqz2Uwfsd/dQ0kE?=
 =?us-ascii?Q?5S2b0pOuTAHSe/0eEgE87OiY43KeF4kmgJriUQ+875aJDKZ7SOCHC+A4z0mT?=
 =?us-ascii?Q?UOqNYqwxNZvL24yS/d/xjahuNKolznLi4ZWKkFWaLlx2qOynhA4ppWaI+W5C?=
 =?us-ascii?Q?nJ0G2OpWnt6zlSkSRmTmz40BMqr2uY39rXPGNMeL34107XDzTqkiOWOHIzNp?=
 =?us-ascii?Q?KiVeNu27qwGMPfv39W6uYxfY+v+5E88XProZ5my6gVS1zutNXbW43EAGB5gs?=
 =?us-ascii?Q?X/Ckva7BXbXWvecBr/QEoKsDRVIqMgxo9y0M8VTT6/7p3O3AbjwKHP2w2oQ5?=
 =?us-ascii?Q?p3SgRjaQ/Ehw1TZHynNO4jIZZHxGglPmlGaHWf49G6TKHnA6zcPQDHqL004B?=
 =?us-ascii?Q?juO9Ya1JY+JN7geZDpLpLtft7Jf3GB15eDQYISvus4WA6M9LkIjG3oRp5O1G?=
 =?us-ascii?Q?KM2SnQb9seO0dIOHKr5xZV0UDZmXcF63wsWV8WZNF+tcedM9KCFGR7gkYkxP?=
 =?us-ascii?Q?R3yfOoZWYilIcpG2lbPp1AYvTYlARA3OilPzz7vG3ZQGudghIGNKLWwbGHCJ?=
 =?us-ascii?Q?6kr65nUghOSqCuMy4MKAx03ek+FVAp9hiS4Zm6CSdqmSS+wlT7l+lTd0imJt?=
 =?us-ascii?Q?HiDQ0stl5+cINAzHfYxyR+bEDrnr0u4pqdOcVX1BSq8VBU0r1sGARlo83IP1?=
 =?us-ascii?Q?6O3SHNyj//kAUbFvf+1jzeUtvWWa7F5sV9GPo8cTk0S00ww+vfzDFBCy9D/t?=
 =?us-ascii?Q?SIVRXQ5WzEA7hXirM8geoa4uwaUxtxWPIWpNZ3r/EhfTe1EPCsk7rffFKZ3B?=
 =?us-ascii?Q?mOYhAYBINsMx3UlbgxxW/CsuxLb9YL2HUQn4rYUNiLHlveAF90Ydj9fIp/WK?=
 =?us-ascii?Q?ozKcNFMNaw+/oT9WpfY0/vjOABKI0vgEZnnCo7kRlYf2WVM6F3tmKfJhqrgL?=
 =?us-ascii?Q?Vccbk1+AUUr6RcFIzfT4cMKM/je3larhqEWaXvb4snpcj3FuLgLCup4K6P7D?=
 =?us-ascii?Q?qxSXDXGJONlfdgd/wHHfjbeEJix21LD1uDlALuaHsLCwyLv9hhWnMWJHYAwD?=
 =?us-ascii?Q?/a8iJbBZRoY890GcQv5dge1ETZgkValRRIOKaVJORvnGrnrA18TXioxmJj/R?=
 =?us-ascii?Q?EBuak1v6mTpiKEng5H7gJ5yvDlZHfGZMpXC509rdb/xDWQJ/nqNKDkT4HyiZ?=
 =?us-ascii?Q?rNnO9htHaGf48qoCc+iEg0iH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dca838-287b-4d34-9078-08d94a783a98
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 05:44:09.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJ/HDxC7VLWG6eRISb243MMS/rNor2qcFPv+Gclor3OIYpoCLwBRxhi9Tba7Uh1No8xaxWetQ/jsAMOBV+KD4BHtIN6L/QyGsdHfbWJ2Jcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2157
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190032
X-Proofpoint-GUID: UR7KEY2DBtYKXAdXUJSrzejia-_ghhhA
X-Proofpoint-ORIG-GUID: UR7KEY2DBtYKXAdXUJSrzejia-_ghhhA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 11:06:36AM +0200, Len Baker wrote:
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f89799d43b1b..5968407c646d 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -543,7 +543,7 @@ int rtllib_wx_get_name(struct rtllib_device *ieee,
>  			     struct iw_request_info *info,
>  			     union iwreq_data *wrqu, char *extra)
>  {
> -	strcpy(wrqu->name, "802.11");
> +	strscpy(wrqu->name, "802.11", sizeof(wrqu->name));
> 
>  	if (ieee->modulation & RTLLIB_CCK_MODULATION)
>  		strcat(wrqu->name, "b");

This patch is just about silencing inferior static analysis tools,
right?  Most checkers can figure out the size of the array and verify
that it has space for "802.11".  Probably it's only raw grep which
can't.

It doesn't make sense to me that we have strscpy() followed by strcat.
So let's fix both.

regards,
dan carpenter
