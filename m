Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7793E00BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhHDMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:01:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56486 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234815AbhHDMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:01:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174BpvZm008018;
        Wed, 4 Aug 2021 12:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qwmzcx9FPkeIwOAkRUrsqki2JdXDuZHpkt4HKgUocGQ=;
 b=lSiRvmd16agfSrL5IOcfjXV5lSGNLHH1mlxR6HXZgFSyd4LB1xtDZJT/o+7ohZift2tR
 BN9le1QLD5T2XW5XaQj3NrfuNPTdRLxPD8OyPZHFI7pqqCIx+RQeAFje4WaLbj0Tm50n
 YcYpIQf6rJACk99YigTC5NhEca36kV7wA8ykTKDQg6y1FM3SG0rFU9c1KBK2oO+R6ewe
 w2YRyyI8NAfCqOuj3YsffkaqEbe3/KkCwE4TuPrGmagzYZx/acydxHvNgxvdBXmpbugq
 K3YdEazl+RxB22TjC58Luzb6QWKkKBEwRAWr5z5sVWDqb1pAnvWfci/ibX/68gbwEah9 FA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=qwmzcx9FPkeIwOAkRUrsqki2JdXDuZHpkt4HKgUocGQ=;
 b=uhnnR8XKRexk+kePS8lnV39XWijfwaMmL2jlDXTi5cE40Qqzwl4N3TVM7eu9xwBnO26W
 zh4mLpgjw0i53JutihhGTnaJ5m/wz84Ss351ergWupXzRg6Ao0NVpsPUvZDAxNmJg6Nz
 D3grSvi9GUrlGIhAPwLGHxT8MHYe030W+inviol6dbiS7cyGEwZmEijUDaKD37ID1yNe
 e5t8fCbZkBWCk5KJaj3mKPQKtTnR4hVYoBrupuYOob1QbhNVUoi57TiBlCzX70Yr7XfH
 i0FXn+w0pXguWZLrkrZGKjJhTzNwucOs+aMEI5JZRWoiX4r4ccYaE2oGXYnm+w+nFQK5 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntp6du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 12:01:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174BxvnE028446;
        Wed, 4 Aug 2021 12:01:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3a7r47pug2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 12:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBOmVGxzOfE5wqFJDgXxo/YpbeJ/8OyOzlqnrlIUmobeMpxaqChkMdigo0CVb6lh1c2NuXL7bgnzvSmEMkH0+TY/bDbc8K8wOBzc79jfKpTgGLe4sGyihZTwPhCs2h3C1utl37eRgbm+GHlvLpsRdOfBxKjwhDGw/bNIiBs0KXls1vhR9JC/89/nnxqeIuJKjHiYfQby0UKetN3bls9+Nt6hJN/YxL7oEkhhuEPJf6q5LKT633gZVgqBPpZBM+1gu31bgWadR+7lt+v6gy0BmIOsQtZuxwRp58teOcVOgEpaUG1tW+Ypoono3lw93QP0ofAK36dHkznNisQ5UNYTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwmzcx9FPkeIwOAkRUrsqki2JdXDuZHpkt4HKgUocGQ=;
 b=bmxBi65j18eWaTCb/KbTTM1BqNGC3ZoQ15Lh2EPX1BqThSYUYFwbyyIaKC53QgTmot57ss7RBIobLxYlMi3z6MTxXGw8e+k5DtVeV4KmgpWa8ntDK/90eBHq8H5NwXNIYjO781BFzixufMQgfqYr8hhkRpF9PDbK8mPuhbRjC5e0TVawwwx8gKbISW9KWhOBuS3X0hYhMXl9SGUmKSXdWPcLkpp8rZUxqNhIsCP+0N9uKTImf9WDm/bkiuwmN8ZAfywYtkx+VrCPq9E0jyMaIdfGgHqOEIjgntu60NsvEF8TeBpRlxDbxa83NVA1sD2bdqv9S7cCtlTb8jOHJTuhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwmzcx9FPkeIwOAkRUrsqki2JdXDuZHpkt4HKgUocGQ=;
 b=XcNrvd0bq/k3JR2BFdktsU0Y3itfNaw/bs2uzaDDho0w2rrxX28dYCZxs8ki073t0Tv/WRPyB/Zk5t5PgI7tRTkr71tUsPGwoFgrwmRXTGW8rUHZbvYWNL40+Wos44gTgUPT7j8+KTSNlmvkQu4Zpzk5r+GlsTTnJIuuDBHXK/A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1488.namprd10.prod.outlook.com
 (2603:10b6:300:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Wed, 4 Aug
 2021 12:01:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 12:01:15 +0000
Date:   Wed, 4 Aug 2021 15:00:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in
 assignments and parameters
Message-ID: <20210804120057.GE22532@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com>
 <4550286.edLFIWPnRF@localhost.localdomain>
 <20210804095839.GC22532@kadam>
 <6010274.OVh6iHOyDd@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6010274.OVh6iHOyDd@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 12:01:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e07b81-14a1-4ee0-0911-08d9573f8fd1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1488A199B4B5870484145D5D8EF19@MWHPR10MB1488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Vwojn/4HhriHDIZKIdm9311T4Jenve83r79VL7JiHdJZosbVXALDY7jkXxfAlV+J+QwQw61PsMUUGLfCtow+4b03eTZwSNk5gJhdwE976QJikL7l8KDzVMDSZjaKcCoLtFGFnggdxTHwtrG6YkHBvtI4+IDd7eNNJdhTgW5JnFlKGJ2dVWrwIKSDoLNeqHqjVKCEvCn2ijFyggDZ2qcOYTTo1z11MU/3J3LaEQIN2IeI8XUKa5btYqmLDTu+hapxhBW1ASrtru09fM557tB3TY4bx2aIdZO2lEixDIoeEc1C8s9LLD9ha6fD5WOKi93WqVpC57/c7e3Zy7f+LCPvi8SXEkLg8Du7GFfYJGVFMmOXn59mc9+R4KfLlhTUoM6Y+eQuBLl3WwImeoKGbK2IDJ4p4Mgq0LY8Rtp6qlEIhWjZnvKVmlYxQWKemuu1W/GnhyIW3Qi76Z3rjx48SogHcxhYDzvthTyyzzbKw7cFU4cUhQhxQ6aw7Q0nOmW8RwrtkIAkBg0tr6WN4O3Wo872yKLAwoBNPs4+Z93LP/IDXf1XrNrWTYgmvj9PANKaV7k7No+s9+neA4sjIv8KkSpqrmeru2fSOmHc08XDthvnVYMCkb4vYOQPVohZDzB8nQORmES9QRvVCvlrQz9vEk1ToXDkivrE9NYyX9ev4GHyi6AAE7oWMG5IVuQUTBp3uQGPFm5bkMIFOJkcRiXJ5XvWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39860400002)(346002)(33716001)(4326008)(6496006)(52116002)(6666004)(26005)(66946007)(66476007)(66556008)(186003)(33656002)(86362001)(6916009)(8936002)(1076003)(558084003)(956004)(8676002)(5660300002)(44832011)(316002)(55016002)(478600001)(9686003)(54906003)(2906002)(38350700002)(38100700002)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLoA5fwSvYSy+FU2jKhuV1OJBVAzL1J+bwTUKDEKNoI7YBZUUZ9IaSqv+EmA?=
 =?us-ascii?Q?zAiLX1HWDLBKKEjN+a5k/WNzvwE1Gy0niWnBUTdw4dkwIUc/7+3Mlz6UeXp9?=
 =?us-ascii?Q?/TF0ySkMnY7yIZI+jOE2EEg1toaebea7mpgStz4Gp6MHMPckWc+/ddFsgDz3?=
 =?us-ascii?Q?DYeX4kZ/Hl2K4enhB5IfA5qQMn+jKsClzq6k8UOhRrND4zkjm5nKsvjVKA3H?=
 =?us-ascii?Q?a4EARNIHD5oGKYpITnY3NHs834tS17jO4DF/bo5z6iABcUqTUJ+EIrqga/XB?=
 =?us-ascii?Q?CVhQgxaq4hpmz0LBS8hFxzQJWu/m7Mpcz0j18MJAuYgEXLsj5zOWXt0ZWVVN?=
 =?us-ascii?Q?mYoJDPFwvGfM8+9SMWrTVvZilTLcmftCz7PScStk0UzXfaccHLgnffd2ybtQ?=
 =?us-ascii?Q?+Aqp0eWjZYBQ4RAOUF59kr3q5mxRc3gTyLs2GEQjFP0aLkTufT6d509HIKoQ?=
 =?us-ascii?Q?VOqPcEOakMiBja2XtBZyzgNfX930tNQTnH43EOSdQzNilfMMXD0zmLa3oX0h?=
 =?us-ascii?Q?8zJ3IkR/t1ly1yJGzgR9pobe6xd8M9lS2y7tX29nkZLyyODM8PjdXFCEMnq5?=
 =?us-ascii?Q?XKD5oIjzxfGEM8ezvRFkIsokqwagjiPco+zKkZJIC9qFn2PeIfI0Qj/RGH2V?=
 =?us-ascii?Q?wp+6igScqUaDY5+yV4TX5sHDWluOKD8SHGu02lpvhkem09uI+umKvG5Lj9D5?=
 =?us-ascii?Q?pVXyLxlXIh2RRteyF7MRXgbNjqOknLARU+N8AjDvxITKASLvk4H8qqEP6DOR?=
 =?us-ascii?Q?Xj1NPM6bsku6PEHPbZjcVR4lbUBU/+fBjfTwxIypsHWVU50Y+GCQc36iRltl?=
 =?us-ascii?Q?fBPHp01SNPPlpe0KMHEV0Fh9847rxZAC6z3ogBCSqFTfeClRMV6ILbmb1fzy?=
 =?us-ascii?Q?Nlafia5RhQGfnTcz4If3CRVW+SxtPwofcm6peoOgP/HLn7yUhidWUARtiYPo?=
 =?us-ascii?Q?sfUml8ZF5g+WrXxGGkGhFxqiVL4SgIKZXZ5U6IX61PpXwYSXqIieFInfG0By?=
 =?us-ascii?Q?J9Sj0Nc1f/pOxgID/u+PjS4ksTfAaxy7jutDbeePNHVzyXdutnnRmT3VVPTk?=
 =?us-ascii?Q?hcok7PuTH9Gbk8haxfb/Zw+m6jy7orEt63ZGi5L56LBbIQIBkH7/mGrWAEoE?=
 =?us-ascii?Q?fn7P0+k/ySmvEnqZhMKpjLt/OlMeatiEr8yPWQyBifgcNgrlHXbxVykfELS5?=
 =?us-ascii?Q?WUjuPVFVIwHRKFDHC7eaWjZu+U/8l6CMBa/MTB0xiWmbgPTfldQfmZVb0lSK?=
 =?us-ascii?Q?SWDGU2SnATYIhSXAPaaVuOWqfk4fjB226YNpZzN2VJ2dL5lVVq7HS56+QofN?=
 =?us-ascii?Q?lljZsXIQq+K5ozpqsvwnSkf/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e07b81-14a1-4ee0-0911-08d9573f8fd1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 12:01:15.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTTbNet2s7oCFbK5HuojKvM+o4cKc629a/Sdry4YjrQ6XmZ93fTGK9F1NjS4fpuDw5QQSkp/Zn6wk+Y9A0IU+Na/SMBr4r2VO/eGkZh8djc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1488
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=950 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040063
X-Proofpoint-ORIG-GUID: oAIuLey1AuzJexfj15MRe6tBC0Q1mchh
X-Proofpoint-GUID: oAIuLey1AuzJexfj15MRe6tBC0Q1mchh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to assume that the Sparse annotations are correct or
complete.

I'm sorry, but you're going to have to figure this one out on your own.
I showed 100% that your patch introduced bugs.  That's the extent of my
job.  I'm not going to answer any more questions.

regards,
dan carpenter



