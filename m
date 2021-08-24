Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031573F5A46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhHXJAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:00:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7584 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhHXJAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:00:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O8q2oL021196;
        Tue, 24 Aug 2021 08:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lureI3QsJXeowJR8n4AojQxeOYEE/8BPuq2cpBI9JD8=;
 b=KiVIIhgWGq+RowotD6qoYHiVao9aSIS1uo4sOrxqUq7CS+YVDbDDg50vJY9FsklGqRlV
 0E9pfAFOv7Ceqv8WKqyp7tAtnhNByfLzDDtN8rELYEamcnVeKI9FBzdfUPWbMYUpgysu
 DRKhukyOvQo426ndWGYPKhzHZjJel4RWSgHCa1qk/oVDwh+mz2yM94sRe8unus9RazUJ
 tq1l4SKOkJM00N7HZ66abc6Rd2y309M6C8JdVa+5k3hW0TFSc7CSV3o8iAd1sLL/oike
 BtMmjqXWdNMIOAz+o1+GDXo/goGGE2uosamGUe7fziXLm138otytaRKvm1YWfiKZaap9 1g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=lureI3QsJXeowJR8n4AojQxeOYEE/8BPuq2cpBI9JD8=;
 b=QB8XwOliUAj8+AJ3vZV+53Xodj1MjOU/KOtmspXBT8MB428d0tX58wUJeX0bnm4k1lFi
 svnMLtebcW6bJl6grcweHMYllmUqxj0NR0JvmZGaMV2QrGjPiAYegtkFf5S1M7tP5+KU
 dX5giSrh8vjb+Gy9+CuZ6+24KsLeE20Yzg6hju1OB8sQ8NgPqf3jRevI80t/tiYd3ibV
 d4L7DfvizmRNxwYhs0/Iewm4WS5LqzfnUQBJYDDCcxBbR07GJvwDEy8KIW0YjL3nyrKQ
 f9cfoQSjDrZoe7laRmFCb3Fcha33Dv2t8QRDUl4H4b3+EKIDypNavqqRVFL981m/fgSA Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwmv814s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 08:59:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O8pQPV173630;
        Tue, 24 Aug 2021 08:59:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3020.oracle.com with ESMTP id 3akb8ucbbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 08:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpRe3IptRKyeCVU/+GVr9nA98lGEzJykVPzS+/eZOXYtBwLhVlc1v9bjlDkMfvuLweqCqNtvwc1mGv6dTsc5PNIP5Rz0zWRh+Soz3+uFaFYSq5lhKCMMfNdRUzApIJr5GjLiSsucmqa3NFraKe8fSsMIKncJ6P5BdDMrtVx6wxzCrdVeCuDKkl0CDzd48V9vMwQkwZ66je1TH4IjwkT8f6b+ZExG7+VR/GcJC44RvTHALtFM3UIy1J7+bH4NzCn692ONvAQ/m3VXGr+znj9/0dkcSR5SunWwuZn+x7o26kpL799Q1ZvHlVAufvwCFF7FMB6j8LchW3sgQ7msHgz3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lureI3QsJXeowJR8n4AojQxeOYEE/8BPuq2cpBI9JD8=;
 b=gtCXcmJDwu/lqHIPXX23dr2HNGHWETySNzICsekaNyCHzfP4oHdzLQkuAjehZdfaftgzmQQBl84OXKaTXWxmP+wp9k6SlynGH2neOSE9Iorj7esSKIvFYgtNr9JezDRjXDiMc9JqeXI4P4mzmRnvCxfpzVfUEuIZPY02TcU4ZyHfSeA8NCjOJUQgHJurtu8NPGu49eJOOP+FsTuTa/EiX1swGXPM7Y7PBdkCzb8ZJnnezZJLLpBCbWueO8owukMvtwAIqIKs55lAIoCf6rN/XPzRd7aBH4xtC4M48JGtaiz4LXj8opdGIHvkMPgMqoGIN/+PN+ST8YgWSoEOdBzc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lureI3QsJXeowJR8n4AojQxeOYEE/8BPuq2cpBI9JD8=;
 b=bXgvxgINO1jnuxEum4IK1nMhYz7xtS33UwYxblFzM0r1QIdXukC7+RS8RV7yHXDK8ptoYGyak5dL8rbJrARVPhSNidqtOxSe+vkyEELHhqeoTmwt1PpnFlwUEeEVO01Ip4kNzJoyCFAZ5RNXMGGtEBRtVjWqDPEQI3g+7iJuQlw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2094.namprd10.prod.outlook.com
 (2603:10b6:301:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 08:59:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 08:59:09 +0000
Date:   Tue, 24 Aug 2021 11:58:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] staging: r8188eu: clean up spacing style issues in
 core dir
Message-ID: <20210824085845.GN1931@kadam>
References: <20210816155818.24005-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 08:59:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6a9bb5-0d76-4982-fea6-08d966dd6f2a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2094B2441E55E7B73053805A8EC59@MWHPR1001MB2094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cspHSYd96rUthvU2CCnG7rNG7Zv6CRXMf+7g+f0m/xCDYr/9SnWum0U9qwYO6UuTdMDOtHLIg+T9+sEAGAlGqivSpHFDRvAkknZkpWPGnP1+EN9EX02W2In8EQi7aI5rNEgCpdVWagl46KsBnAfc7qHPXK816HyYJKymTfRx8RP3vUk3Q/nPshvznNa8AuYuZrKoqjKdJ0v4ZmGo4amvWWfABKZZlgjvBpB3LcwvOFYlhgeW67W8LbqRdrydRHIzJc+GbvIBkTHyE0yaYayICV3XypAvbaKpw2Ca0pS2ri3R3wXYxrZamjKlEzszs4eRQHlLIhYU2cUvmihL9OoVvhCuAIhorzjLrXmuB1xFOmgGpvOYpiSryF6pHnswNsUyk6ctTvWdMySf/CL+8wSLtgBP0Xvf8F6DRcwpHKoDp6XgSXo/8G4afFVOYPJtKudvNVNHycVrGdPKroYpi25ADj8dipWDy8vJcUVN/OiOpNq7WrSlJ+GnvbbQBpDDPfdQ/AQgTIYDeaw5Ct8SNzDDee10DjeSL4PF8Noz3k9xm11+jV4RHLQ82Y+OSGdV1IkUIfI8JFzoFd1JO4Qi+t0H40TcekSRJPigzm5kKTV02aOLSHvmis0t0urOqV6Jn42RF1Kb65iYnOGOzFxqs8If9T7JNfbo6ZBfoRei3LywiNQAZ+hhzWJw4+ah++wvCl1eGtOlaQDoHQpyzCJdasSVUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(55016002)(66476007)(66556008)(44832011)(33716001)(478600001)(6666004)(2906002)(9686003)(186003)(66946007)(316002)(38350700002)(38100700002)(9576002)(956004)(8676002)(8936002)(1076003)(4326008)(5660300002)(6496006)(6916009)(52116002)(558084003)(33656002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xly181tYXvnwD7/6KlXp8BK2Tb0tX/I++G5Cst8pISQ4OvduLdRO/Oiay+Fl?=
 =?us-ascii?Q?axEOnnN3s9O245h1Vrdky0jI5UoZ/hN2wt2zCSoBQtlbQLZaBWv70h6+LxJT?=
 =?us-ascii?Q?rhCEiX7bzbw9x5pM41lBIF8biG0HSasLOkx0qptGTae9z5jU4czYsrympfS0?=
 =?us-ascii?Q?MFpwUuWXY2IX26S8ioeC5fNkhToyDBNhm+RmrDqC5syu+iXS97f/u5k3WXtp?=
 =?us-ascii?Q?QQrlPDvC6u9inH7GV4GNfHslCTTwb606EVdY8ffEqGIhcxPZ2nr6MVYhANRk?=
 =?us-ascii?Q?xdQlr60c+2mxY1YnLaS1GzlplKZ22utMWp14g8uSrVbzbGdl0CMur6o1K97v?=
 =?us-ascii?Q?1eXwmHw8IWljElPw2L1Qi2SzpW0n9n3uxiwC4zA9lFB0GErGUtl46Xl+1qdS?=
 =?us-ascii?Q?MWxVFVqQbnyMA1IXIR+JqSQlR1pjnNGgiEVORPP4haIPyBmhCTMNTSqvzxW0?=
 =?us-ascii?Q?jRTn7B1SdKqKYipKEed0TNLrJ7/yRRQ2tFRSlfqN7OWQDLqI6Q0Ee+yuD4Ap?=
 =?us-ascii?Q?970AKGiIszgR/IBWHHYBkcigK0x/lbPYMcqw+36Z8ILd0Hs3QsKdZbAT0q3A?=
 =?us-ascii?Q?KDFAJ/065gZQLFsDlClEiZCusxBcZCi9WWqCNNBqtKr3ljaYUgLVnLuiHzso?=
 =?us-ascii?Q?8Y5LhHY4VUjllqI3Gb1i5360D9rDfYyh6cNT/Imi+LAmZ3W+aZ0gmHGfUIHe?=
 =?us-ascii?Q?qEaGR/qftQ+5e7uyZ1bKM04WjbjpIA0aGXTkWVrvx/3Ug7WUWcOzO8dOUsX7?=
 =?us-ascii?Q?pks+depY2CdHfOLUniaKIrKQhI2BuYodoRSs8PJialldkylk3xOcG87SQBYK?=
 =?us-ascii?Q?qQbq3ZQKD3GWuo6GffQ6IQ/Zljuc9xczXK9TFfDkFsVnciFqceHzsY4o5qk6?=
 =?us-ascii?Q?LF78+pQiPNk9gZpGLJODTNULdNGQYOd2LFyrHZO7fXXu3ro4RqNT95tAdDt1?=
 =?us-ascii?Q?38baLqUOoGsxSRhWtMhcoPd8b+HG31DHtYvDYSu3kmXy9cKyOTgNeUCrs64z?=
 =?us-ascii?Q?HYVpLaWmaxhnfRexI2hZy4N/Pl23l8rYw3xpD4HN8iTkCyXLrm1r4xdIt5Rd?=
 =?us-ascii?Q?sOVVA8M/YKL/utHA6jgm3C4CBQ2uSHtRVcImitgolwZpyx8tYjnurLEFYV/h?=
 =?us-ascii?Q?dgHRYhLjzYyPKTMabZ5fkxQHMccXiyskHh67FZGIrLvUyamtUYX3Ss3SO3DB?=
 =?us-ascii?Q?Pohw9BVRH7qFjCXyNrtmxRkE7TjM03e8+2RAcP0HHUGjuWClGSeWgC2GBtAg?=
 =?us-ascii?Q?ckmgFI/fL9oh6NSAlczADEnw6bnJkyIQnVtgrccpgQ/PjbeK7IlAdIfEt6od?=
 =?us-ascii?Q?kEow5zVZNVc0c2/PdrvZVR87?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a9bb5-0d76-4982-fea6-08d966dd6f2a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 08:59:09.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/h+QlTzUg8ohW2zgEg+zgNausexPhY7TE3DaxZtmyDUFNRqFvyHPgW/f4AYs+d/XNTgur/DamYg/p/Wr3gFHnFHNsRMXmt3bI0zWGXQpG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240058
X-Proofpoint-GUID: CIMzvyu7lsMLFX-0xhkrOyaDb8WJL6eG
X-Proofpoint-ORIG-GUID: CIMzvyu7lsMLFX-0xhkrOyaDb8WJL6eG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!  This was very nicely broken up so it was easy to review.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

