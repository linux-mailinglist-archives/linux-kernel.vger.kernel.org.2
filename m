Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438F23F6E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhHYEi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:38:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7466 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhHYEi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:38:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P4JU5d015024;
        Wed, 25 Aug 2021 04:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aHhykhEYw1536mf5CIRM2He8pck0RXQUGSJnNarhYg0=;
 b=CcFZxQt0lVn5/qa6jmq1DNrJWMIRrqN9dh3TW8/jKgi9FCSB9sZ77+TmF96DSbLh1uu2
 OU+8dzO34k3/Vs1KCDf1viUlCJhPf7QbZ5b9lNqe4nOOcbhyuaKj0bclPrpXl0A1N4or
 YmP/fSaVNq7A94qxxtLeQnHhXEzoIpV+VBq4NeO0oM4vbGn2uWd3jmAejAqCBtyfSo1X
 S7KKWpla1kFyMb+MKB4OhGyzH/FeBAM1or9CG4ElAQALcrnvt9cROBYmpnyEILtcLVKG
 zIbEwJYEeduAi7APOPtvp+gQoWHANerKhFLdhqGEwOkbFNJpysj7pYP5LGKud5OvKyuq oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=aHhykhEYw1536mf5CIRM2He8pck0RXQUGSJnNarhYg0=;
 b=f8bbge8N6CA1Z09tBR4Ei7kuf48Jl7dci6b8fUtTPEuN1M0ncjNVB/qCyNj9XUBc+gt6
 aobFwgKOrZk+Lx+BOV0ejpUh0bC2RHPkBQWqUCi1Q7Wf4voiTaMqS/vmobfBDwMsGNgj
 SzLUM8TDaCeXqoJtIQnaOe4YUendDkbnLmOr3O1pRiLieljpL9yHHLM7dwviNgiXuWqp
 zVjMUDoy991sp1WVP1hWmCQN/dIgzrQSDWY5Ym//S1RMuSAKFv1MPOXI2hnc5D4N75wH
 AmaS4fBun8Wg88Ccv3V/W+5izAnS8u6E5fKlrSSoHcrH3GkCNirkEYgXogsmKI/DWbUa 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6jbsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 04:37:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P4TZag104309;
        Wed, 25 Aug 2021 04:37:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 3ajpkyk8v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 04:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY7/iZphhBwnjBwyPdhYxEaYRTtABmaVniOuysvVljieiyavvsLvSIr+LQOa/9Hy/yhtdoArUx3QIk+nIIhFS86smNT2+TWIoFbsPL8hhlaFBdOLpWYd9wMRpp09dV6QRAHHge+1sgTEpD08DF1A3KzMXLH7FybLwUVFB+8ZvuxtLfK+Sse60699DIEZFzg8heub2dA8zT0UH8kkBSfKT2pIQXggv+SIuHm0YNGpweGhhWVSl1xXwrAiC/Rp59URzW/2SDd7wg7JPXs9s6V4HDksL5UlHlyKRk+EyT+LfDa2VK8z8X8uN0uJj+kNRsUtYjComM+MB2HggZbNkkBJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHhykhEYw1536mf5CIRM2He8pck0RXQUGSJnNarhYg0=;
 b=DqhtWIhtsKseg9Q9tBg2x5Lc9acodKQYESFl2NGw3pqMqEaLiEhZedwQ40sfEnY62VXlMgp0fbUTMA2dCO7FVlV3S19q6RGkkY8nu4H0KaB5dPbopHXAR27E0wXGzwu6oCjGs4RtRNAdb9I2lCkHBDg6/kTiDZqz11a+eg7CtEWOTv0GzkBaaAm5FkOjXU8gM8t5EV05KvjGNvKZTxg/c2YmNtX80T+9ik5prK8uJVtBRm57UfTwtJOgSoNUngezvtsojIvUp5statP9HmmtwGCjdejtNpZ8wIwyj/Ewtq8HaUHQJcW+Ru3vuOhswweqOaMYvMhPTmn8j063Q946bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHhykhEYw1536mf5CIRM2He8pck0RXQUGSJnNarhYg0=;
 b=XNBhFTh23klQ7nSOwDTkJC95x7mz4HN/OQowMj/K9A3Rml84sjhLPosOd6DGm2JUFZ+q3WMs/KKFBvJVVoSB5e0Ifixwtu+mErNitMY5TxY67u92Cm8AzntD5afXxfibwaAc1TASTsuN3im9r7Avv03IpJVrPrEVxdZD87caUPY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2399.namprd10.prod.outlook.com
 (2603:10b6:301:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 04:37:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 04:37:32 +0000
Date:   Wed, 25 Aug 2021 07:37:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Use kernel ALIGN macros over driver specific
Message-ID: <20210825043715.GP7722@kadam>
References: <20210824182059.1007387-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824182059.1007387-1-kari.argillander@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 04:37:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff0bead-0fea-4d70-6c57-08d967820d86
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2399EE19AB2C5AAAD3921C058EC69@MWHPR1001MB2399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhHpJefKlfRv15wO25QFPSAZrSLEoyXDNxIBSmjm8wrgO7ntyGCN3mQgEeK9QX8IaKvUYL2iRLCLMzObFZ/hFjZwUNLqWkwg3yD6cqn0/YV2Lhkp2GGYZ+VjL3zqgaqiKPxcddAQhLNbcQWYHXB8j+rDKTla6gkQrlHfT8L1HFm6/GoqFB+2MSf45gBAn5HxQ+DYuzVQZKPEM+RoPnbbAKbW2uJxaFFBcGb4P8dIVHn8/ufmUXMfb5t/rHGr9p4gA7PPNksxPbmd7qo63EMjPnSlsqGRvZzZ/84Fds24HYXgQa3wHe2YbQr1/pP00oHK+uTORCoVTmzEWy+mv8URGzjayDbH2uSwqE9YUsgUUYOKp/o2vsqCWoO/hlf9i0bg6WKlHmrBzQESJZSTtm53eF298I2Ju6EfE2gSyfRyBq4/04DCpJ5DeX3izKzcHL3H4Vtt4NP/dqFaTdz6hHTHEFsA7rvHVMh8z8o9ukI2gQdgGOWuIbnc8JgG4+EbnnzXJQnCJQGGJAX4A2lZO/fZ/29Gyv3eyJPWQeTxzdOBmGlsbubUfJ/ISFHda9xhV1xhUNOb2HVJGWqcoPg3bCNszz/xbt/pLyt5JasCPqhvJF/YVl6G9dU9jRXbZ95uklJfW8y8EQIq6tq4Kx8rBHWmFmuZFkhSpKupEGGbCNlI5/Zpj/pvnpbZMu8p8fnRHKmFm1xm2e+m7TRQJAuReRK+iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(186003)(2906002)(5660300002)(316002)(26005)(38100700002)(33656002)(6496006)(4326008)(33716001)(478600001)(38350700002)(4744005)(52116002)(1076003)(86362001)(66946007)(55016002)(6916009)(8936002)(44832011)(6666004)(83380400001)(9576002)(9686003)(956004)(8676002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCvOE6Mr/dt47lSNEAsANPsdZ0M3ZjE1bt3a9BrlU9Fa07YsSymF99qpcuEu?=
 =?us-ascii?Q?Pd5NrzFGIa/n5pw3vn7tj4FV5ood4PeFbxoj/0lLXbU2NPAngoMLV61nDh3b?=
 =?us-ascii?Q?J2K+dvk15hPXFfNJmTMWIp30RsdY0vMADWMO0cTBgmuymnN3Y0yBS67iZfIH?=
 =?us-ascii?Q?fXSkgWn/TktnW0761tzygISp5Vqiee/YAJF+u9OaRDHatGZlcSyiivYthzvQ?=
 =?us-ascii?Q?xlkqMUzH80wogan9C2iaN/i1tiAGixAEvdUeD8HT6h9TG0zlxF0SZG9mKERs?=
 =?us-ascii?Q?zq2/PhKWplFW2hCqnuzrc3hfITxnAAyANvT9RMxHrV4jQSklXVE9ai67BH8r?=
 =?us-ascii?Q?YO/b3+cHhT4cZlWQgjyDpJ9L5dscT7UqSFIn44l7BkxCzmx/JcRVWXLdrnAa?=
 =?us-ascii?Q?hNktcWDV+vlnlGMQOYC08tvubgfr9a7I0rJJ92nQIrylwZzsv3bbMeSz/sjt?=
 =?us-ascii?Q?hOdNbKb/510dTLoaIWEnoOnZh4r8QKpclQSDR+9jo8AV4WxclGBnlTmRllqa?=
 =?us-ascii?Q?9aGDzrWq0a8NWzMGH+GGP9OOIRLp+j8SXUMnrj9IXua2D9YF/Dy5DfdoZxCk?=
 =?us-ascii?Q?GxbOU8TziEzoNlu4Zhqi9zsBBL4Owvc61UQzXM+Fea/A84P4O+Dx/LovfWqI?=
 =?us-ascii?Q?S1iKKwHpX1b2s+wAsCzluNyYdrVwa4u8AcmLR8yMB/JpW1xbfqfe19PfHEZw?=
 =?us-ascii?Q?u3La8gSqdScB5UC5YJTzH8yB6quWZ92kfBLuDAOHwH3B15tC8pq0Y91Zrfnp?=
 =?us-ascii?Q?VMrqAyAmRNwZSMwTohyLbrVyVX7lqR6utl1X506303TNCBT6SPm9TLE93dQI?=
 =?us-ascii?Q?87RuBlkitNoE+RqD7GJUl6HePwaYYB123bL4SULfnB2vk9uDxfKXOmtbMWNG?=
 =?us-ascii?Q?SpeaVe4hk32r2i200kfw4qYFL5JI0arRhL64t628kfa1WZtqBkuFvHOwkqcO?=
 =?us-ascii?Q?KFIVQr4MYAevRrpXmHe1UrEzSC4t0IRdHIgfCr0ATnQPJ1nGwwaU/w6ECeNe?=
 =?us-ascii?Q?3grm1PY916Zgsv2pLGVpMxE4bDLDvawfZXTiU9KQXR6S98a0kvCcyjGoZ6Dt?=
 =?us-ascii?Q?vVDcPYQfLJjnkNOSo341/X3q/URtA7ZZIvVcDo6cvN9r6v+g5qdSQxg/jgG1?=
 =?us-ascii?Q?HyvURAD2v2imJTrN+rHkh9UT/UAWoYIqHqrDkCjXPwrnxOWxtwnXjItI7TYa?=
 =?us-ascii?Q?vqvsKf0wT8KJVGiPtVsPjOWPYrw9KoXzrQ3iKSWiVlaViBoFiDhzZzRZxEix?=
 =?us-ascii?Q?8krNKnTY0Uuwm+AF6EaUursA5A6IhXANPz+D1fnZ6mTaV/lVOTGpzuGgoi+l?=
 =?us-ascii?Q?F37yVycscpgITpCjqZcmAib0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff0bead-0fea-4d70-6c57-08d967820d86
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 04:37:32.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VC1cqctxyPF0Vvll7Q6q3YH/E4qq2k7mE6hchwq6+U3ny9x8BvRZsgqLv3XQbMuQr4St4T2XrUr2draUExmf/GQb2o3WZR+ZM0ZEqmkORc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250026
X-Proofpoint-ORIG-GUID: TsLcSpoErApg3LPcte0VMixDRiGcug6y
X-Proofpoint-GUID: TsLcSpoErApg3LPcte0VMixDRiGcug6y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:20:59PM +0300, Kari Argillander wrote:
> Prefer built in ALIGN macros over special made ones. This can be
> helpful for some static analyzing tools.
> 

The patch is fine but the commit message is not clear that this fixes
a runtime bug.

The static checkers (Smatch) were complaining because QuadAlign() was
buggy.  If you try to align something higher than UINT_MAX it got
truncated to a u32.

regards,
dan carpenter

