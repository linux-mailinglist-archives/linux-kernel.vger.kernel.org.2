Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45363D5515
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhGZHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:32:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53718 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232979AbhGZHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q85fMv024703;
        Mon, 26 Jul 2021 08:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HZ1KYuWz/C13hbHYJxr7ZNZTTP3HsFnpNtcllfxKnVE=;
 b=egajK49D6lMd7gmecYcyQh4BTMmfq0oOxOTP/5XDnmhWX4oo9NttSOnduq0KN7xmYD8g
 ydAhwrFxfLbGTJDVGZwzQ5wKTlHNeEy6r7ITkImFTf7UeahAaQXNcriU/u25AT9MjTx4
 Eh0+HxEvVUnG//7dGHXUC49UB0JSHEzRpZ/B5cfyjgwdqL/wHpVEvpFqr+5qjbqq+sGB
 RzH3wbVCCgL8DJd7TX6v5+5dzKDNja+TwSFCV6lvyXO/Mcv/b3hTVDKpPEi5+7G0acv1
 juJmGa5iIaf6VBir7ENjMa+VB/66p9a0W5zq5mpkLdXwVj8zKg7J/ZGMFZRIcf0asYRY Dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=HZ1KYuWz/C13hbHYJxr7ZNZTTP3HsFnpNtcllfxKnVE=;
 b=RfA+MllQBHJLnOYnEXxvovaktQMopZFM0v/sLYY+tmOlFkn0mqUjGSQkyf8jdtTH85iC
 XXDyepMsW5w7tE0JmO8ppJkl/WFn/hM1JdUpF94QqMqqQ6GexlM6gp+IqPrysAVnnRB+
 Gb5tGwkPHDIbP8w+1KtKjayuH+T+fRhtn/c432FTbVkrHRKNTB40UqtrIvcGoKHc4+Lc
 ACVz1bLJv3w+AfCF5fHksebTZsQza2BybymG8Ywezzdqcm9xZpZfl1yeCkPKSldApwc4
 o6e9qacexHGT8ZKV5a0HqIoKAbDpF/CfcZPjP9LUJfECjGieraIupA1E1MTA5XK5tDHw Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a18nfrx7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 08:12:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16Q85Vsv066889;
        Mon, 26 Jul 2021 08:12:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3a0n2fgrc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 08:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7BNdEBQh+kgodFZL2agl8hgbbLrJZTYocX4+agR9KXzTVBKlhlegAcNKxU1CWkd4RFFkNddWjrSOssGc8IvrY+/MgFfXAeDWokroPAsC8OD/VCUOfCBICdMXmpLyFx9BUP0+3Wp91awtab9o/pZSMrz4y8f5x1rssgwB1QSXflOGkWnSqkV2C8Oo7H12PgN4f41IYwd6XJaRN0hhYhmEmRwgTRIu6mEO40WpS+HJL3zUAHmaT27UjPHXuco9rZg+0JUMoVc75UfhHNoT2wE842issnW3iMMYGar23Dr+C2mLFpnf8YDzVDIuTlaBU8LQdG2fB8kgq8DPuV5tUZshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ1KYuWz/C13hbHYJxr7ZNZTTP3HsFnpNtcllfxKnVE=;
 b=R2KsXwVMNlgRrt7iOkTFP4Q60tXtXZQNuLa1b7YZWu3nxoFnbOUGNaAXpNWe7cC0bBd4S0NxeGN5rvpqHQjZ2c1q156tvtAFeVIZxV3GOWri4o5rfjQTJCEVF3XXcHnOCoPOLAKB7ud/HV2DSaYWck1DAh5HFiFtcNs6hJ39cJELOXh/JvGLRrxa9b77QWWNUzJ+UOfHL0P3Hni/MF/v1K26Uo2oPS0FR9BfITdNgOstTd9ozEsjqhmFjs2QuPwpfkgfuXfy5ecuy5mKpT3X8ZmVq+KeNhmM0KdWgX4F2KrTus/WvZ1XixsKDzHuFfim3hDz3ifAUVe8a98YLdVuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ1KYuWz/C13hbHYJxr7ZNZTTP3HsFnpNtcllfxKnVE=;
 b=NU3nlJPE/1+6nFnuy5Gsp3rZv5xZdGAx3WiVbro3687K4IantukWJD5JM0/91D41fi0wvps1q5OuMYWv6yvipVTHFOmeHR7X4hS8uZAlmcIrAnT7ib4jQzNHbHL6eQmrg3o20qjh7abVtWltU0Cre1eA4CGjYZOo7igmgCrhbHg=
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1295.namprd10.prod.outlook.com
 (2603:10b6:300:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Mon, 26 Jul
 2021 08:12:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 08:12:08 +0000
Date:   Mon, 26 Jul 2021 11:11:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210726081148.GF1931@kadam>
References: <20210717155145.15041-1-len.baker@gmx.com>
 <20210719053747.GN1931@kadam>
 <de94438319a84e0985b3ba0f5c00807b@AcuMS.aculab.com>
 <20210721080624.GV1931@kadam>
 <20210723151510.GB2612@titan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723151510.GB2612@titan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 08:12:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52cb9f3d-9e3a-4dc8-c8dc-08d9500d0f92
X-MS-TrafficTypeDiagnostic: MWHPR10MB1295:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1295BF0344205050568551278EE89@MWHPR10MB1295.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmXeMhaciWYwU+p6Jeakhe6rlFKr39Q7BOEaNO70qNnG2kMnti71RvP8Y7KzxyYvTMGP2PAR6yswgdDPMyYMOZ85mK/y/7JxbHkrtEBm2PbA44kl/010OGxopHkcB8pZHWTmTUAnH4vJQ3FTAZD+82rP/c7vu7iED9fq8o3Zk8rro7F13cn2ucE92gl71Oyp+WL27Fvxv/h+BpwJSU7MP1pahaWtSc8eDRTRoSQQo8EOl3q+aTuaXk0eHTl/xUrIPcpODqmV2OQminqT3QMe2yj/P5+GVZdOdl1iEdNl5ou902wwUny6GxzycJNHLQ+xba+ewSmFhTUTmDDpU+QpGsO2d3mITq4A9MHLWQRgH72Mql8oOTBVotOIZj/DVsfEazq2bA4A9UN/+BvgUTRDzN9sSpI37JTzt0JN7HlzfUo0Zkz8GZubgkBeQDoVzfXt2iFkHhJCd1tKmCyTDnI5NFOpet7gWGALadO+UmpcLKB/lwv1+ExQSVvsGe7eIhlhFtXMwhwZvWfY/yFF3FgoLzfrAsoF1rMQPi1XB273T1xazYqkStg574QXFMPItg/JIYN1FOWr+IbtSV3EYTWXx1C1zz168Yxkvnw3IHQlaKInnqw9WCq/406+5gzQAhd6BAc+QkDLwNBdojeUsBIKS8YBP1Iy22jbj4nihNVv03syflYX3+U6UtMkxA7ZPCpkSb1bQivbhLHuFcX8cfuIJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(5660300002)(9576002)(66946007)(86362001)(33656002)(66476007)(26005)(55016002)(8936002)(186003)(8676002)(9686003)(316002)(6496006)(54906003)(6666004)(52116002)(508600001)(38100700002)(83380400001)(4326008)(1076003)(44832011)(6916009)(66556008)(2906002)(38350700002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyeqO0IXIBTFjRBBUXTmqaX0Uew1Y/ARcZBrvSkLikxtWSsO9gIPyJgq2K2l?=
 =?us-ascii?Q?76Aju5hX3Cy4tnaUtPJiz3xNqypBz8AMSt/QgoC0mKV4y7mb/mshmWHebtlt?=
 =?us-ascii?Q?GQOSu3GJLeKJ7l967hoa7wREmu8hOo+CgA5m0czve9vStdVlcgK88muYCak6?=
 =?us-ascii?Q?UYOTqB+PzPguIkOITLWJZv7FsklcsLl3t9qp1YaBkWiCXdAnbTk86bChcG9H?=
 =?us-ascii?Q?Qxbwvj1J4cHeX+m3uSrg8vDN2LUODehBTwRA7PJH57tU6v06otps5EMHrjBX?=
 =?us-ascii?Q?R2ZHGX6Cx4IV7jH2y+D1K1U1bexnhl39G8L+fNEDVq4XheakhZckQPV+2R4C?=
 =?us-ascii?Q?HVMQTm1bmS8m25y7Bu60bfe1eX5tGKzJoh4LNkryCk3HgkUHljtCocsvjGWZ?=
 =?us-ascii?Q?JYHHJYngaR8XnDDYkeDmjrtKzlqfV6VW6yot+NdauN45yXe1C7a0BrY0bwcZ?=
 =?us-ascii?Q?dENocWP39ph9+fxkiDXE6l3TGjh6BnLyBCScz1g6F+LlOVVZHrwuRGjL3G+z?=
 =?us-ascii?Q?1Zd+WR6rf59VB140bPMcMQELcBFN3vC5+Ki4KxA6kC9HpCq+f7lPPvZYFC9g?=
 =?us-ascii?Q?UClPtmO+eINl8cidH6+cmCufWO/3Ne5z4l5ZeOyu9bExCFrwH6EVuDgXFHwH?=
 =?us-ascii?Q?sc31zYovz2zMYFL1S4/JJRd8ya6kikF8h4qZP9y50mqVmXRi524xIZBcyWwZ?=
 =?us-ascii?Q?y195ecyKH7MQz02cRs3sawfqTABEEeRvAQV5Mzbn0sLLB28VQdARsJ9BnfbX?=
 =?us-ascii?Q?vNBOWI3o6bOk0PW7h2VC2kJXP8HVzzxtEnnN1fzPkPf88svjGgcXKs+QQSoJ?=
 =?us-ascii?Q?2AdeyDkSHnMNA9pGqjDH9DmLdNZGbxYMToC7/ODRGVxSokyeis76jZwZHlPJ?=
 =?us-ascii?Q?jsuZtXZgec+QFjIQjN6SMHnQqB6cxs+F6rpIcPSivmlXYNZvjPkhtbvukwMy?=
 =?us-ascii?Q?C7E0+TAZUvdcMhuZjrjTdOGN/I9lb+o9sk2e9QMkOpgWo82CAh9gRqnxmaJ/?=
 =?us-ascii?Q?6JvxS8KTx8NlPyEFUXd/UOIdPBGxYGigg3fdLQR/Cq2ZM3Mq3UoxdbnrOGzU?=
 =?us-ascii?Q?2JfpOxY89P3OLK7ylncmIBpbL9q5/Qi6f2hLtxQqz+gvFuv29nkxeI7pCFSf?=
 =?us-ascii?Q?fMGVrLwiWWqFjPIM3vJG3fZ2HcurP6gjOux4d6kkWeEvwBGIOxONu8baWdG+?=
 =?us-ascii?Q?2SnlR9nYQtXIXC7CAOnlAOa1WDZiM4ksVumxdstl2cyG4spzisbYdgu4t66F?=
 =?us-ascii?Q?8egJUgojJQp7TRHsQ3CQP/ds4lkAyJv4soS7ssUMWLpN1bRXy0QJlaJ9b/40?=
 =?us-ascii?Q?pRZ8wErQ4j0sbu2Sq80qCh6s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cb9f3d-9e3a-4dc8-c8dc-08d9500d0f92
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 08:12:08.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AawfJ+axNDlrAXHbxgF6S+LpkjVcfSC/3un5nsP1JYz3l2eJl39+wutg0ubo7dEG1SHhd+2cd9uSCoguOlk9JmUfTHI3igp0/XD7Hwd4VJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1295
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260048
X-Proofpoint-GUID: D5fkhmWAS1ULxRe2F_RrVXxHXlMXhflP
X-Proofpoint-ORIG-GUID: D5fkhmWAS1ULxRe2F_RrVXxHXlMXhflP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 05:15:10PM +0200, Len Baker wrote:
> Hi,
> 
> On Wed, Jul 21, 2021 at 11:06:24AM +0300, Dan Carpenter wrote:
> > On Mon, Jul 19, 2021 at 03:24:38PM +0000, David Laight wrote:
> > > From: Dan Carpenter
> > > > Sent: 19 July 2021 06:38
> > > ...
> > > > Not related to your patch but this code is bad.  What it does is the
> > > > "ifname" can be set as a module parameter.  So instead of testing if it
> > > > has been set, it uses the checking inside dev_alloc_name() to see if we
> > > > can allocate what the user requested.  If not then set it to "wlan%d".
> > > > If we cannot allocate what the user wants then we should return an
> > > > error.
> > > >
> > > > It should do:
> > > >
> > > > 	if (ifname[0] == '\0')
> > > > 		strscpy(ifname, "wlan%d", sizeof(ifname));
> > > >
> > > > 	ret = dev_alloc_name(pnetdev, ifname);
> > > > 	if (ret < 0) {
> > > > 		dev_err(pnetdev, "allocating device name failed.\n");
> > > > 		return NULL;
> > > > 	}
> > >
> > > I know only root can set module parameters, but having one
> > > that contains a string used as a printf format seems
> > > dangerous at best.
> > >
> > > Isn't it best to let userspace rename the interfaces later on?
> >
> > Yeah.  I think you're right.
> 
> Sorry, but I don't understand if the code needs to be improved or not.
> Is the code shown by Dan not correct?

We should remove the ifname[] array and the module option completely.

regards,
dan carpenter

