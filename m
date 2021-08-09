Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF83E4898
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhHIPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:24:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32158 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhHIPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:24:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179FCP4j008365;
        Mon, 9 Aug 2021 15:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=o7yNlDuhWgz+XPuqZS8xaQO4BnOTwGaVE9SeiREHIvc=;
 b=uY6z43ujr161MJC/3QccVOvrdIS3gE/lt1C2ICU2o7FniAHFz3i0TD+1glO9dtShhavu
 uhCYoLguC4ZD85H2PSq2CYd7OSGUEZQSrnLBzuJXVTML/iiOQG+KcOS1IYro4xV5aXD+
 DoBWTYD+BKyW0GMNcAKyL2J2/ni+439QUXUlZtKtYH8QioKAdbWjgX6z3DEqbqvVlLc2
 klTezC9noeqGyqRMLkhsUe/y2enQz2Ebtr5QfzqumdcI/u6vTZOiRfd9rKd6ryoRbLaf
 NnEkTDXU7dBOVv1TEDolsTa/20tAZtSu40gXvV7U88ZfRQXelY9RS8UCBvNfrUaVYkVo mQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=o7yNlDuhWgz+XPuqZS8xaQO4BnOTwGaVE9SeiREHIvc=;
 b=OQE7AQWNz6/wk0fU/HEEPl0OJI8ga1HxBy6gAajVqdPWI68C0h7k8uNGZeu96GNhndp8
 rfcMLqreMSnZ7ykkkI0X09+JIXKuuasBvhkI2j1dt+HLxvCUJXkgI5OUEUZ8SplHYvH4
 ftgYEQb4obE8z5siKXETd2Qa+CBrHWSk00VIzSSX4pEGLracFu9fGTl/9Ho9WiQAl3bt
 Ou5FdHqQ1BirZZigNsUvcn8LZcYhKZjgkOmE+0E7OX+Pt0UocYPcfZKfmq/ZQ+1kP1y6
 G50e7hU1XKejnKNIO/V+9Z9RnYfi0MT1WcB7bPkDP6o/5wM09tQzA0iqT1Rme8P/+i3/ TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaq8a9kdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 15:23:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179FATwG096134;
        Mon, 9 Aug 2021 15:23:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by aserp3030.oracle.com with ESMTP id 3aa8qrh72a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 15:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqXY1IL4tV0MaL77AbsRfmxJrxlbAY7Dlyv4yvDa3vpk5oczfDFiklY/0ZonbQfGiCfMUgmNKY6aGXGhauBrjhs5SQuCfgFr2iCoYg5vGTqzww+h05IXJo0odrIwP3g5aSHj5B6UwuoOdh16IjqyduYNbPMHIhdv3t0TxAenr/SSAYPsNtVkCozqQBTGBQBPx2dVQMs/s/Ya3BwAsd3Fre30BuUM/pk0XwYF9BQMjrOW4tyixvIgQf1wOKWOhQW+ztskPyfAnLL0ukYUy2XRHpkDi4SIWzyw0kIwKOOc6S6IPaX7YdSXI8o1+M98sI+r/CXcjADD18z06xWlZF0qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7yNlDuhWgz+XPuqZS8xaQO4BnOTwGaVE9SeiREHIvc=;
 b=jq8rm2CCxOGc7k4fjIkRg0DCUNipGoADIO0Fs/WhdoikEYvnAjOPnYUwalALJKl/0b6je39B6XTYd5TcuMewU9LzD8ReK5yk+bWe1cXti4WOgZ46Wit9Ouyvxoyw1k3riqhp4MvD/4LClXg3UsXoMlWz/6RA479UY77rXw8Vkqm6+LIHCr+X00eNQS9kpKP9S0hwPTXjUSVxtipXtFH9bISPvKbnm0e+MolNnctlQ/CmBPH2OJyKU1nGQNHu1lB78D01fC0QssGW65cMJmaJdE67PGy7F5OUGzeeRwxf4ye8npHEVAvvw1Dox5fdylG5JDn/gFG/sxH4J3iFxt0O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7yNlDuhWgz+XPuqZS8xaQO4BnOTwGaVE9SeiREHIvc=;
 b=IIgNlszHDt/+b5t9mZ4lRW8DW9Fwjoi0GtSFJTdigzLEByn3MBMY/9JyqUGOER6+l4cVeex7y3nk88mcSupN2WOP05IXzxB7+Fwytfc/OaAZrlDXVGWyh6lnOlAjsRbFEi4j0SVQY9VE/ePOikPQ03G170b1gJVSD6gZv+GN+J4=
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 15:23:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 15:23:35 +0000
Date:   Mon, 9 Aug 2021 18:23:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove the dependency on ipx network
 layer
Message-ID: <20210809152314.GT1931@kadam>
References: <20210809141339.2593-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141339.2593-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 15:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b41624bd-df15-4aa1-e3dc-08d95b49a741
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB451350AE2E9A5013BE56E7C28EF69@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KI0AW7RlV5T3u3Cx+f8zlWT++m7YSjyNsT5ymN10wMqcEG+0VGPZEcsXb7BT+JG2X3Xu3z0FUVV2nXqigkiKaI69dt2EINNfi8nuF6CrP2CR7vumbHHDr1WpVI1KdkvY/+IoFFTI/Nj8sn9aUOZFc2salpRibk0ztGRcgRfBlkWPyLLqxVt43T6vncjLmVOQEDD9jQa1jhNPppuAHdELvu6pml5mjBcaCKlbui6eZ0ACc7KhlY5VQslaP48dYApXX1m0WEUsdbSxS2xTO8GI9dBB/pVO4bA+wS1GUKhxzcw5I7AnHjDF4pnMCItrMl4ex2QvZHoC5T0JB/I0LZ6/GUD2FaY9jNfrx6C99MTgiSqCQTNxPhm3W4qv950SkFz1zknRJL6acS4S1SigPXQFMZCad5IbMFYm9JOtWsCdS+hjhNF1MQzM0YzcQdLXTS8tqgwhhlE+EJq6TObOLUxbjDqClMILCt3/wSV6jJAxAo5IS4WSN8Q8IqpzbSaFPu52iWh66PuzaZ8yXNf+WutYIj8gFMBwnEDQERsNfwD6SQ6BUzyiRHki3H3GVW00KqGt9HnK3OWaq1PWwh2tSM5L/+3syfHcWPzaDe/WJMuJwdLLnMcCQxm+JtZ/QJMgg4ywVaVlmwdx6p8ECPfN0ltdAiaanlOrHvCnVELhrVB6guZu2GG6eHDv0j0NXeDulXilHTp12XAGV9j3Nnm3yIKHYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(346002)(396003)(38350700002)(9576002)(2906002)(1076003)(38100700002)(66476007)(26005)(52116002)(66556008)(66946007)(6496006)(186003)(478600001)(4326008)(5660300002)(316002)(4744005)(8936002)(83380400001)(6666004)(33716001)(8676002)(6916009)(86362001)(55016002)(9686003)(44832011)(33656002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7kcahZAE3p8mdzVjqMCGp1xagrY6Ud7OAhfMgLAU6cJvJU2i2iBtAhtzUsd?=
 =?us-ascii?Q?gpf1t3QaCH5p7+sqouGatPxr/QtH2sexpxriBnddGMzB/MhwOx5AGQh8p0vL?=
 =?us-ascii?Q?kzQ4yQSKHqqTYYmK2BrEjjiYPiRqRJl+nE879Zhlg2w5+PJ4n28c+Eu7fpaQ?=
 =?us-ascii?Q?b/solNdAMu7WyN0mS2HcIrSo7NZ9QFXVSvxwCxc7+HQYUQ8tp2eLUs4yQeVF?=
 =?us-ascii?Q?dXmz3czW2hfAXTQAaai46HP74xCWNGRUKxnP+isnPUJXxPWarKUApuvwZoeL?=
 =?us-ascii?Q?P3GL+OwFRljI49tgClShI4CnghqoIHkMT7sC992UVngrlKF0WUfg9gEtWTJd?=
 =?us-ascii?Q?wz73RzZgfY/h5CCCsz+jybdunq0KuJ6+MFXGp9vb6y3S54sdfjIb+zR4VNvk?=
 =?us-ascii?Q?suyykDYrPdFAVf3auT/djKmvrfw/zL6r+39pqZPoQRmqhZkJK8BJUh7wD78F?=
 =?us-ascii?Q?xLwlviPlaBrEDp9l0LqGI8bzVyEegXfh1SNU//5AScjd8XrXQU6WiLPJLtl+?=
 =?us-ascii?Q?JeM8SZWMLg5jpWjR1NYcb+Z4RUXR2xCkNnDgLhuwa4a/8VE29E3OF7/aCflU?=
 =?us-ascii?Q?cB06Oq5esoFGVj7LTbK3psOI3w7XSq6PkGKABNjS4GhUx8/CMTk6UvYOBFon?=
 =?us-ascii?Q?E9vLzNxp/04LQ4lsaP5dxn9Z9Bca7x0GX6iJ4WZo5CrCHZWEH/LKUseQePHg?=
 =?us-ascii?Q?lVW4zqTTEMatjb1L/NYDfAo4Rorx4XKxIeJR0NS3zbTA22ucfzB/ivK/kYs3?=
 =?us-ascii?Q?wtufpBNCxJnESMhHnYlM34gUc4a4XESD5bIYDuFNJs6VSVXjGlDBojvQnkoe?=
 =?us-ascii?Q?BASuFa6A1l3KisLCW1lOPc+vZATx+oekTUz3mOo+AbdMkP48W7+uEr/s8gV/?=
 =?us-ascii?Q?PPnOa7Aeq3a+bzQpBuQSo6c9OisHd8lmlfD4LncmWnSj5t3xfUh/uR9q6E+B?=
 =?us-ascii?Q?O/JykT9wbHh0lI19Hs9d9GN+3wQY7OROgZvXn1dY1++hhTCUXIKu+gkimlXX?=
 =?us-ascii?Q?aAAg2Q6FCzArXk3+p8LG1ESsHJdPddmg24iD+LUQEY8/YmWSOtuHmKGQIdnJ?=
 =?us-ascii?Q?ww82mMIvbEJESGOyQn+dq1Cf+srzB9B5hT3/+1BERxnIeKkoAUN5XJb2ZQvn?=
 =?us-ascii?Q?WSpXzRvJ2eRYBiXSR5RIyth4qIgKuksFGM77+6jdgrU9fWEcYCiA5kIYuqpA?=
 =?us-ascii?Q?jES5vxGTI7d4tByZTKjROvTobYByU2/48evT1pUXpQwQ2l8oFFqKPIfF3Ycs?=
 =?us-ascii?Q?EbcOSVCEBE787IezgbUKDYcA1LVVwZWdKBg+CfbZPY2oAyQheap+vEDobRCT?=
 =?us-ascii?Q?BrS+LbFrNTt7OXiDeLSfKdZg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41624bd-df15-4aa1-e3dc-08d95b49a741
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 15:23:35.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifOexLVc4pOUMLdzD3Sv28OTi95GNEj67pBL3tynkOVEn6RAvT72CUuU7/C8JEJmAJurglTJWAYSPhhAvmaRJ/eLCzS9c8z9MYTqRWc9NHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090112
X-Proofpoint-ORIG-GUID: 2egPT87N26MzvJazjl0UMMbi-etZCOfD
X-Proofpoint-GUID: 2egPT87N26MzvJazjl0UMMbi-etZCOfD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:13:39PM +0800, Cai Huoqing wrote:
> +			if (!memcmp(aarp_snap_id, framePtr, 5)) {
> +				framePtr += 5;	/*  eliminate the SNAP header */
>  
> -						DEBUG_INFO("NAT25: Protocol = IPX (Ethernet SNAP)\n");
> -						ipx = (struct ipxhdr *)framePtr;
> -					} else if (!memcmp(aarp_snap_id, framePtr, 5)) {
> -						framePtr += 5;	/*  eliminate the SNAP header */
> +				ea = (struct elapaarp *)framePtr;
> +			} else if (!memcmp(ddp_snap_id, framePtr, 5)) {
> +				framePtr += 5;	/*  eliminate the SNAP header */

To me this looks like we're still parsing an IPX header but we just
deleted the "ipx" variable and any debug output that mentions IPX.
What?

It doesn't look like nat25_handle_frame() is ever called so once you
delete that then you can delete the whole nat25_db_handle() function as
well.  I'd prefer to see that kind of function which deletes whole
functions and the compiler will complain if we delete something unused.

regards,
dan carpenter

