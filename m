Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077693F75D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhHYNXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:23:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53340 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240040AbhHYNXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:23:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17PCH6Mn015024;
        Wed, 25 Aug 2021 13:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qxNLrmKKS2OZ6WutCkHUjBZ3qi8b4kQcYpBqD7CO5oo=;
 b=osyVLoK+fCoB+Ih7rRLGjnJm3V28ZZHqH3Ik0cHlf4/B0+liig17+Cu6Pidm44E+2ODT
 W3Jp+4GtbWMQ/kx1iwMNUyV9oRf5ewGyqISL0EuMhq6SbNSgVJh4sGlcYsZQfJ6LZ2mY
 q0IdiMsNS09ygHMZZCRmp8L2LfKiOMgGLDzEnXyvk1F4InvK0536+qiD75o+Y8lHg1pP
 G8oljSSxEVsHu2Z/ezOR3pkQTYsPeY6AJp1gnzRtNLZEBNUH3gJIEe4RY0QqRho7SOMc
 DPSJkftUfTzmPYMdEwNGjSsIJGCVOwzp71lk25qCNNu1wMgpIROxB5onTnBnP6BFqRtX nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=qxNLrmKKS2OZ6WutCkHUjBZ3qi8b4kQcYpBqD7CO5oo=;
 b=c+KSxNMCinUJmxTmL3cWHplv3UEW7ggr+D5hN0SdsF72sYQRinCJEsxTBFOY+pgQA3mT
 TxQml7SvrL5oYyFAsKQLyx2/kG/H4JIW97s3tPD2yfqZw6ouFaYGVMzWKpbZdNP+1NRP
 a/YgmviEBxnPtj3lQPWEixU8hwncnxSbVds5rNSzVZM3AIuIxdtrHcSqQvKLR6YB5DwW
 uKOu8wUaI9JD6uRNbxoR8Tl9U8QoH6u9fBLC2/b4t0nbLS43qNYPeEEhZWLtM6piNVYr
 ncEa8p5td2rBJIivmaITFVLfLjX+y1JC78qGWLkbkBP23v/hlrWS4P1efUJPngR6uVVs bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6kej9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 13:22:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PDBHkE026136;
        Wed, 25 Aug 2021 13:22:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 3ajsa79x05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 13:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLNw9DmnBY/GZmOKz0pCs1hsGfU4e3AruNp7cpS1Kx2F3pYGcST3LsFE2B1/v9tp67S51LfVF+B9gkG7tj6pEQ/RpHDwwiMgjgA64b+m5QlaSbA/Ck8IBB246cQcHESksMCu4t1uDzRrcd6MNqwSwFrL1U+e4+Q7u2XdLBrrUmPpVyetzEpJWXnouGv3cqZjWpcrJfEefpRSWoJvdt5R0LKKEcxA3PcucPKrlAn42nasB+QNOxPWOY/7A4zPNmn4gMAuT22pKiCCuDAhBlZlqp0yoqn9nucVjkBFfjLna/jni2y330rLWAYl8HXNzIQcgQ2esmEWfb18BuUFSJ4Ndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxNLrmKKS2OZ6WutCkHUjBZ3qi8b4kQcYpBqD7CO5oo=;
 b=RY+3ceGJeJnt8L0Hh96soKWjOgqv4p8KURDI9gDkgEkQXlW+pci8XDwkWq89KRhoWl6EAWdSw6UTh9/If3Wukdw5cB3qQjWMHbq6Dj6Zy2Z57JU9v8NZDgO2/YthhF+mh2DfNPUjAOzOJ/i5hl5WfvnHDu9jaQTC8oybSHcH5+f8d61G6CgATyfn9GehB2gyWxBdBzslQL3RCJazlw5jG6i9taGLe3T5VfydDGd61xdKXqmJ7RvF1xWgkjnljZfceIyX5ZjzICRMSoOAKcVUcneotLEDhGUIEF7T5sgpmyYPuNdxjWWlvbBfA+Aivt3x+WT1KoIrARzgsMOcyhUZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxNLrmKKS2OZ6WutCkHUjBZ3qi8b4kQcYpBqD7CO5oo=;
 b=MN7ugySrdWZDZ/aB2zS+KxcdJ1N3TM/VwZNTeeBlqPX8xrKNPvt/lyeX7C4h6ihDiqUw57bUpgu2MUiRcfotEBjI/j8bO7W1VuVo8u+9nEpl/nYODs8dr3ntWNdU1Rbn1S+nS5365zaH5CuCLeVscD36H0QPuSFl1YOl6r8PAgk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 13:22:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Wed, 25 Aug 2021
 13:22:42 +0000
Date:   Wed, 25 Aug 2021 16:22:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tty: moxa: use semi-colons instead of commas
Message-ID: <20210825132225.GV1931@kadam>
References: <20210825072405.GA13013@kili>
 <67c7047a-93eb-d5fe-514d-6545b5899991@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c7047a-93eb-d5fe-514d-6545b5899991@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 13:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3ee78c-1f81-40eb-6966-08d967cb6aeb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB166487330D82044E554D03BA8EC69@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOCt27c/MKCDO4WCAx6m7I/mG4Ro+A3NZ/kCY1t0ZySYUz752WzVRqpbvSeIrCyAQTn2WfshkOSm/syGitaGXN5RTdwm08r2dWVQUjaAAxAiKIUR3BUqaZKPsLsoSTZPUnblGZbnMyt8rvgRXRSryGzriO2DL8PK0KroWONDQk/Xv6Nc87WxImjr9D1Ba/k8AU5eE0a0S16ME4Swat/Q5/qoDLpX326ycidJGjORrxQ6zEYH4tQadv91h4JMkdsDO+Ts7QL2fA7/ScPh2rF1IwEFY5muUYiV8obGYy+zxqcPZ1IXOP6/192Y3maBZ94AhAdVm+LOsR4KyQ5eDbkZ1gZVF0R2W/nHZ9drj6pKNSBUDsaYxOnm0BzRSAZ0hrX9/geWJQl9YUs3XdjQlESQLoZU/7l1Dii7fZFx+78VBPXgS6g5CMnCYjEtvWnODbtmQhtNtS29o5fen/lIPvOt4E28SQZFaO48kWwCpK8OSWuVQz3iN28FTije0lPLWglW3jIqjvxvau87PG5O3Ao3gqTb/mZ+Jv84EpHN89cZ+snZoIOvdED71c4MeDFwtiu2OPuAeHovALKQ5Az5dTVyuJSK+Mo7wI+DoijxLsD9hcza6rtwMMUfEBQNPKu7r89bYwgXXh+JCgeV4WFuIxI4ZNNQjbLYKWTOq5GAujUUI+6/9Co6uj0WzDAR1t9C+vLS6VqpawnBv+dDCyamNEprLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(55016002)(4326008)(33656002)(6666004)(8936002)(44832011)(956004)(6496006)(1076003)(8676002)(6916009)(316002)(9576002)(52116002)(66946007)(66556008)(26005)(66476007)(86362001)(33716001)(186003)(2906002)(38100700002)(38350700002)(83380400001)(9686003)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bEcNXox0dGSApCwzb0jWWS6HBEkEUbpynGm8X/wIeyKmQrP1Fapq66bs7XZ?=
 =?us-ascii?Q?nbdO8giNttCPZjArOus/C+SFrqJ9b+UTpgFV0w2Z2aHoO2ianl8Dnn24+I9c?=
 =?us-ascii?Q?ISeV5ytlBgfNHxfirNiBdXLIDQlNRRe7DRUTS4wOEORDgHo5UpnLiECLIHky?=
 =?us-ascii?Q?sZ8h3Ve5Dnc3yV9ZV4KyWI/mVHWftFlT4Z7h15qK3Nysc3pTN6JWe8Wqz0uw?=
 =?us-ascii?Q?xyNPmUoI0Iqzgg/hgMcL692xiFDt3iHBHmSINugp5OXgqKRDLzNSUj59L8j+?=
 =?us-ascii?Q?DaYFqryzRaDJe7IX4V/wdllHtMWPGVGDLEImnyRkRA/YOQa65MQTNIwFe3aY?=
 =?us-ascii?Q?vo7ZeU3s5gwN2XvpG+Vg+JBllscV7QG7l/rj2zj0IACZhD2BvHwsH/2CRwcc?=
 =?us-ascii?Q?kCbz1JhCEFLjxM80MEMYOGgfhqC8LEvEaOydKF4Sx1q8vVLpVGTzAaLCWsDt?=
 =?us-ascii?Q?as8/tQNaaZf2hfo/E+ptMz+orsYKhv7R8cYMoxz9bNwLfPMiMnUCKEt/UDqp?=
 =?us-ascii?Q?eAXzfUQfBlEzDJckSg5JYu2Vu2r6cwTQIdbfrOpHYwBLYqEQlphISUnWjMrL?=
 =?us-ascii?Q?AIKFGhHWfKsGhHkg26YdQhaxwzr6WVh/4jco+KN6Lu1vakzLBfuZ98RCoQnB?=
 =?us-ascii?Q?Uohu+HB0RDrixZN+YTw+rvXTU6kZiQWSZELaHC1WwE7o8DP+ZZ7hh1ukzvpj?=
 =?us-ascii?Q?mQehoNKrLZzcJMIVtulNeYVFC7KxaaknyP+ZoqBjYtnsw0Rz2vH7dLmM/eza?=
 =?us-ascii?Q?IOT+FQh/Ou5wLEZneIuFlVjDJq1p31PTOHeR6a/2vTvRruejgjg5KC8yA+0s?=
 =?us-ascii?Q?C3mksAK9eXJ2bMoOpU999Bpw0L68iddsJCqU9Y3LWEuCVWV1zhSiXWVGV+Cn?=
 =?us-ascii?Q?JOZwGKZtyTGcr1i9ipg1Btn3Ca/u6MwB1bA1tM1b7QjxButpJfokxM5VqRh/?=
 =?us-ascii?Q?Ob9ArxYwn2SfL5q9OVJTMxxgLzqSlwvvdAjo+xMf+5XMVwe9rv2/+wmIFZIn?=
 =?us-ascii?Q?SVrT2CMN8RmScwTbMTh51jn32/0e9b3MdTL9eGTRITwmrwS8Nd81EW2uTUGT?=
 =?us-ascii?Q?nXMFrQmpnblAsk/vk0G/WPAcMJeY9lezuXXkCu9d4/rio9k4zisfmxtSeG0l?=
 =?us-ascii?Q?ecPv5FK2QS6jT4/dC2Cly0Eyn+3FFqIvO++c0K8gPL/FPXzsQVXCjSWQb/cr?=
 =?us-ascii?Q?TFbhLtDpV8oAhR5pzlF0qanGSoMI2YV+5zyJsDRmqXhsD3CmiGHk++K/XSdQ?=
 =?us-ascii?Q?9xt3r+4OiEZ5AsoktmQY5tCIc8wdbQz5TzGlUBwpwz5EtuIMSJCqUc0F+N2i?=
 =?us-ascii?Q?gz77MdupLVUcyShgc84ETY/g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3ee78c-1f81-40eb-6966-08d967cb6aeb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 13:22:42.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKeMP9GWZSZ1WMZqbF5GbuvPzbZi+R0gwPJ0SsLyTZ8kFjyqyvZwYDKpeK/9oRP5UaoXVdvfP7zEzr5gXCzdDptGD5f+EDNYNwq22usmM8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250080
X-Proofpoint-ORIG-GUID: WKIwsp9MsXUms-Odu8h2Aqg1eG5T_OMv
X-Proofpoint-GUID: WKIwsp9MsXUms-Odu8h2Aqg1eG5T_OMv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 02:58:19PM +0200, Jiri Slaby wrote:
> On 25. 08. 21, 9:24, Dan Carpenter wrote:
> > This code works but it's cleaner to use a semi-colon to end a statement
> > instead of a comma.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Jiri Slaby <jirislaby@kernel.org>
> 
> I just wonder why:
>   tty: moxa:
> vs
>   mxser:
> with no "tty: "
> ...

Now I'm confused.  There is a different mxser driver, but this is
modifying moxa?  I just copied from git log --oneline drivers/tty/moxa.c.

regards,
dan carpenter


> 
> > ---
> >   drivers/tty/moxa.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> > index 776f78de0f82..bf17e90858b8 100644
> > --- a/drivers/tty/moxa.c
> > +++ b/drivers/tty/moxa.c
> > @@ -2034,10 +2034,10 @@ static int moxa_get_serial_info(struct tty_struct *tty,
> >   	if (!info)
> >   		return -ENODEV;
> >   	mutex_lock(&info->port.mutex);
> > -	ss->type = info->type,
> > -	ss->line = info->port.tty->index,
> > -	ss->flags = info->port.flags,
> > -	ss->baud_base = 921600,
> > +	ss->type = info->type;
> > +	ss->line = info->port.tty->index;
> > +	ss->flags = info->port.flags;
> > +	ss->baud_base = 921600;
> >   	ss->close_delay = jiffies_to_msecs(info->port.close_delay) / 10;
> >   	mutex_unlock(&info->port.mutex);
> >   	return 0;
> > 
> 
> 
> -- 
> js
> suse labs
