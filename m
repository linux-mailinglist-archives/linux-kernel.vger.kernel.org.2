Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3D3FB487
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhH3L0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:26:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235387AbhH3L0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:26:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UBNmvK002253;
        Mon, 30 Aug 2021 11:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Flc6z1gi4V/jO04EcCi62CZ9cUJfdg2lH0kTh4L0g5k=;
 b=fx2iSGVS4U9NgRqY8EUm++cvFdi6l4UvhsCE2DSue2m3Es52FCskKEviB+m5EUJICXVK
 u0nKVdl+4448kqwyPMZdxm5+CT15oK9kk19da6/yg69N+CtacPRK5cOVBF9KBbUW7s7c
 TfVtYdGIC4nkhsv6bC+3ri468NZeC8GET64gcPm1lLqtDRb4gAGNuqxfRjVFolt9lhO7
 5a24ButEHB8L9GnuvD8SsU358COH2AQoqMeMWpYz86RgkYKirBYdlwQHSHuYs7G7u7CY
 E5ycNvFIC+WZ8yl5n2vjPUIWAbIxeYZEVu5Vh7HdeiOjsCWq6UvTK+gWruQIPcwlxTdp Zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Flc6z1gi4V/jO04EcCi62CZ9cUJfdg2lH0kTh4L0g5k=;
 b=IltBmj5r3AH2QAIacj8+qMxJMfzDNUn8NhIenTzw3zv3R5o2CJqU2jKC0EwBiWRtLiy3
 KuX+t2i5cwVL4q397ctuL4fckgOSVuVSPJm1bserqj/pmvzbvEbg9dGwjfDEFhKcTEPY
 gcg6i/A109AlgpJVKjoDaZsSKkk/GBIQe3SG3cHK93uhhob+IbiLyKvhMkbnYqACZTIZ
 uV6ibvWEyxvziD5RWunkodLv3bCBdt2qYdgH4MvUQn20KG8Yl+LesPTtd1sXTgNSHrwF
 E0YGGlKG16zOx+pblvp4laq7sVDvKo4gg5wagEcOA/Bp3ehB9j7AGopaiNeFR9h97ePq FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a19th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 11:25:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UB9lYi044384;
        Mon, 30 Aug 2021 11:25:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176] (may be forged))
        by userp3020.oracle.com with ESMTP id 3aqxwr8nkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 11:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF7bxYho5jyFrJmJnve0Yk6OVV86TM+STsVTLoKSaocSOOs4zdmI+0KKNZqeJcsMGDusJLdQlUl1FUbKiFHyXtxDchld4iZp087EmDzEODsl3Pti5XtIUZ8QYttwoBnLbHW5GNQ4S9Ipoxq10I6qNHTU4J1SS3wTMdN0QHlgZfXXX/ENfz+71ulLVu/2ytITGeYFYhVSf7Lw8myYW0jnm/BiWZ2Vv9rmrk7vi8uAoqZYoegh1+TRMKrFKfLgUhYoJGOmV5e+V0uaMM6Zx+bRVnuoWnEbbsd/guQ8NrZtkgZqupQU60ZPn1Qd2DZmr1ps12GbXJyUWfx4U5zNwEILCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flc6z1gi4V/jO04EcCi62CZ9cUJfdg2lH0kTh4L0g5k=;
 b=jy+M4HJ8Tyez/ocE6/TFF1sNxm5D8KpteQaxkXLq68V5iTpVpCZXRPYimJUhdYbsyK/IguLm6+bCpiZTtgYccv/bS0TvB+RyWQ/LcpSeKVli6AiptNvcUZ9SyRS6slXufUeCYhtHgoJIEzMvuavgVKCYXjtMSjt5e3bY1ofRPxCBsmKopKT9QxthlMXJKtGn6+gHy3azIZDiSDyKtLM6CjFzOe3KyOvAjel89Ve+qci84nHQXOo28nvno8ceL8aYZ+QMrkPZLTVliz5S54X/TZx0pROvcFBoSOC/JZVx1QxhIiD9TMBYWxmPWA6ZsDbd0576TgOYfpWjKs73kSMI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Flc6z1gi4V/jO04EcCi62CZ9cUJfdg2lH0kTh4L0g5k=;
 b=YzXqNSE0G9OkAkq5IVDgaH0afwqKvhmALAmMoz3920COvkxiWLn9nhPnkn85W/3SUBmlmzqgZB//788FspjsiYsk/4Z9n0ud9S4wxyRdrlpxccLgCJfgJkTAGYnCv9lPb7qoKMhxsH2vKEadOK4zLEmb4lrJOzZaXGrZxyFglF0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 11:25:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 11:25:43 +0000
Date:   Mon, 30 Aug 2021 14:25:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v4] staging: r8188eu: core: remove null check before vfree
Message-ID: <20210830112525.GG12231@kadam>
References: <YSu9GQa1A3s6FYQx@user>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSu9GQa1A3s6FYQx@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Mon, 30 Aug 2021 11:25:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ed5594b-058f-4974-b237-08d96ba8e73e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595058657B87A032131D0DA8ECB9@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xen02BZbRHeHWNJXyZBQjAgVHwJxqBENS/0TCV1gLzUWputx8MNNW3KPw/wRj93dO0oeBGjhzxNTxEwXdghku6EHV63n1PQnDb1BS3nR69XzozNi+ia5YSVaes7+0m0JRqgj0fVRvWJvXMxEHoV1xN6Nw64Ac4nY3W11mw13YDB/dpr//ge7ldVBct1emTWoP/hP+rUY4TNqQ2R3EXx7tz2bL0mmaVoEVkQmymWrT6aLxJUlb2VqJyytGf38DNw7bH+Nzh2H18ApZPQLAdU3BKnBBxRZnr8lzvao8n8Qxozpc4B9Mj0w+3Exojz/HFZ9AzYGpiQRX39VdnsIRqRB9ut7dhrKlqgh7ejzmdMhpIer/YMJeIb3lWD+oo/4OGGByfOm0USJq0PC3JBLaMyDPTLT72Mx04FALpze2nLyiDO7coslDTAsanKmLaygHyspI1rGixIkc/SIlO1uVicPZ1pn9yYr6f/BZD/dTudCstKN602+RmbTM+BA7Jek9DXR0pmsp1nomcnI+wbxOdrRTaFwRBkub+D+7usKoKzZiue4SFCxqUPLTR51mdC9oZAy/w2yGZCjGbh25X5jwm+Zhg7O9ckFfxtzbfHN72gOP0UhdHZvM79Up+P99DSMlppYMYgy/T5Sjld+TVB4lxTo1H2m6mAUeg3vC1r2OdZ18ssY79PvlTXky/eZyOyZk4WAwCvF5bFkZZxC7twm5JjHhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39860400002)(136003)(346002)(86362001)(7416002)(55016002)(6496006)(316002)(4744005)(8936002)(9686003)(478600001)(5660300002)(52116002)(4326008)(9576002)(66476007)(8676002)(186003)(6666004)(956004)(1076003)(66556008)(38100700002)(38350700002)(2906002)(66946007)(6916009)(33656002)(26005)(33716001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?532yXZDRSHFEooGR6ai72/UiVHbOwZBXPakmZkHOCO55ZM9QqeXo30ArCF2O?=
 =?us-ascii?Q?mKfMfCGSEV5U5MtTIDf9Ce4uGtMH/yx0sGKzY0a90sG4g39ro4aTf53BM72J?=
 =?us-ascii?Q?Yxte8NWjkjqIVq0TmVkIuKULgqx0dD57sZaR7Y446BdoLkQgA2Ie08OUzIzq?=
 =?us-ascii?Q?RFCO/v+QF5FfeLYQJzQZ2bt0TaHg1RO5kbCvARIIi45WTuJL3qj1cLI2B4tX?=
 =?us-ascii?Q?+SXsDOJ34GJ2KJ8aT6cVYn18oOhhrFKrcfDchQNKwiiamG/4T+VbLz7DXgP8?=
 =?us-ascii?Q?PMEnZG6mvsb1xmvRDYnaaGKDkML0cO5k4PDPd1VzjHHBvu4xyye2EcCaBtJS?=
 =?us-ascii?Q?mv8mjkxip4W3zbvj+56d7RQwfMBz0C5K2LWyp7fa9OpZtAZH6uH2CMonevvI?=
 =?us-ascii?Q?hBB1Ynppsazsv9AfFUErby9W/edLD/CtuDAuavdPfQZ+N9Qsq+wanuyExuh2?=
 =?us-ascii?Q?X5xwS9eS+Y5V9iPDSBUfJY42EjWgqLZH/tF6N96rljAGu8sqmjcYzOjmMJzw?=
 =?us-ascii?Q?yLB+PdtvvVIkooUqOCoZBJpsZ8HlTmyxQHxOEGvXBLynZ/g+PpfNHo+N46qo?=
 =?us-ascii?Q?3C2bgxImMTwZ8RjE3E05phnFxz/R7jwpoRpnY+veirv0NpH0zC0WpPEQLNTI?=
 =?us-ascii?Q?2f2CX3u/L19epcbt1BRV2afdvPCqZaVfPZfS6OVHcnx7r1xICE8Hy4wX2nJZ?=
 =?us-ascii?Q?Ku4BECFcD8/D3cQRL+E1dN0yO4UDApqipdMq/6odOdcYsLf+FxHDHXRgeHwK?=
 =?us-ascii?Q?a28yVlQZKncS0UW9iKkHX0vkk613dQ5UGouQBvZqPvAtdYUm/9MtuUPdTMw7?=
 =?us-ascii?Q?4UxOfnL5FUCc9hrAWXWZGVnq6DrR+K/BVeZCI9t2yM9dpLv3tz1xQjXRED01?=
 =?us-ascii?Q?ThSmCG2OdBxBMnv87v9QQ1JtgOZhUZRKebY/KvSukcPyGV8G/a2it7LdHRUA?=
 =?us-ascii?Q?DrTd+UG/Z0NkRFF0Lt7Q3vjXaXCc0uW6Js8OeX8w3U2A4b9DJ5gRRPh3Mnbf?=
 =?us-ascii?Q?ezshSDei0faq6JUB2fUtj/mZZ6RfkSKfrOvd9hLyYAm4CPhxMpiK0Ogogmxd?=
 =?us-ascii?Q?bHzkfsvM7opPsk4ZjyIXBL+p3N6MpWWNQsdy4IPLsw3VA9fgmMJmuuAsI4yB?=
 =?us-ascii?Q?iawFI/NaEx0yCE9JGq1LqwOWce/RNI50pO4hlqtB86yI3dCAmnbQjfeFTSl+?=
 =?us-ascii?Q?C6FUwxxcvj7iMIP493Cj1miwCx5v9+VfvcHBQx5DkQdxldPyLOtQ2MDkGjmh?=
 =?us-ascii?Q?1YYCiPaGngIWIFyuWofDvmw7zRCKrFDGNjNem4gXJQZFkQVDAk2hhpaGx6F5?=
 =?us-ascii?Q?SPSfQdBPMJVgq5b6XSf35oVv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed5594b-058f-4974-b237-08d96ba8e73e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 11:25:42.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKoEOVbTWjIF3nMY0u3Qe+Fdqf3kLULWPc7JSRtc5raC+0IKXxtUMIaRDatZRttkk4axU8aBayvrwhag+8HZNkRvU8uWoUwFX7q8hGXJm5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300082
X-Proofpoint-GUID: z3_3LefVM5MsHO1YfgPUiZj0ykh26RcN
X-Proofpoint-ORIG-GUID: z3_3LefVM5MsHO1YfgPUiZj0ykh26RcN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 10:30:09PM +0530, Saurav Girepunje wrote:
> Remove NULL check. NULL check before freeing function is not needed.
> Correct the indentation.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

