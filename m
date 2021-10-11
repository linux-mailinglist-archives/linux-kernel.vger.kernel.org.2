Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE94288AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhJKIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:24:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45298 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234936AbhJKIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:24:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B7KjpB017576;
        Mon, 11 Oct 2021 08:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Hywp7iiJVQXbs/Sa+ZEXLthyOGhg+Kglnrihk67MlMw=;
 b=FJvwNA2CtfTEHLGcNQsUztH74XJVS8eI9YVzXbbp8F8S4Ty6wGUgIqWpH7kXSf9jHkf/
 H+hvgh38HQUVlzrdPwG6GjUYGUvtRp+B5ZRKxlj8cRcCuTOmRkMHs90Zh/LbGMuxlt9y
 8Lkuz6JN3rcNJ4FY9TDa2qziHhkctWlD+rn829Wi+/icjrZC4GRDR1kzxkgTjHOM4fF2
 MHlNWEkxiVUBLnGp1zSZpVN8jU37u29y5QykllNMSa/fXa9k21mBnl6qws9xvuqukrle
 pnuxFehTn4WLumWZFsby8PWBSip5V7KUUIxNDLm+9kOpxMyKNaPp9EO9wXbHVh6JdFW3 LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkvh9tump-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 08:22:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19B8F2jQ054839;
        Mon, 11 Oct 2021 08:21:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3bkyv6nj88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 08:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krJFL52e9zJwVZQ77IfKbmEBtnirGHWhtQB7/V5grmsgZSMrw/3LZ5jDnHyJym1z/lHIY4iFyjQ5rNHFUDeZXL4sGT/TkX2f579GIqF9pMeVFnBIQs2G1v5TeTKeukVd1pA6UpRC6fLwFQITJmkkbmGHip6GWT28hb6BhnQT5WMnG2ehW5EoEs3SixYO9dDU+pSRBn6sSEwLoCBjmCc/oj0ehdBj5gxhSxZaBrDheiQ5sHLxjz+WOUE3Zv88p2ameEWu8HrJFnDCnHfrVjb3LQetHk8l3hHRs5kiumKpgNH/1KOp4Sa3IA82e1fpj64FzWdKsML61QFUjQv7xEguJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hywp7iiJVQXbs/Sa+ZEXLthyOGhg+Kglnrihk67MlMw=;
 b=g7QqRRgECLvH7EE7J5Rwm4R6OqkXvaC2oI34QbF5IpA8J8aDIUHiAl2LvSAsQO4lMqUi8NFLCmLkq9+bTUGhVz6/3k+xQAZbqGGC2vEXL39XHWcqw6+5OpkLvqDYkvBEroRoLG1/zwREV6WaZYJFA6icPMfuUzUJCCnxdnTONinOb2VD8gxQujfLDE8ZX5/PWuV19WTQjM91Aro4yUkNp98YfB8xbGfLeXtXjJ2tkT7jOTG9k7Nsv3W9lHoxpNAD+GXUqlA993WNiCYY7thYA+xu6X6ApI5NSVZWolSX6/Qr4G5bc5RM7TH3uElYcVUizlsP0Omr/IiBqNgMzHiyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hywp7iiJVQXbs/Sa+ZEXLthyOGhg+Kglnrihk67MlMw=;
 b=kdwM1/CoqXe8nQFseL0455YIbkc+1JV1FUlOFwasLMHKxiD74F3u8xFdbCgtAvHnfVYSUXPfvdRy6VhlpsKmu1r526E4GL+U91CeLbtRM1wQMU9lZlWxpJj/06YQ41FuC1mMEyJR7Vqe+AXLYappPESKXzV+xurIsdzTRkSsdYU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5790.namprd10.prod.outlook.com
 (2603:10b6:303:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:21:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:21:56 +0000
Date:   Mon, 11 Oct 2021 11:21:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Message-ID: <20211011082134.GM2083@kadam>
References: <20210826130342.9552-1-fmdefrancesco@gmail.com>
 <20210826135413.GA1931@kadam>
 <6435467.SEsBC3EFVD@localhost.localdomain>
 <2664974.42EkL7omyK@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2664974.42EkL7omyK@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 11 Oct 2021 08:21:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d13a04-d375-4f88-3d46-08d98c903053
X-MS-TrafficTypeDiagnostic: CO6PR10MB5790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB57906E8EAF39F6FE39A227198EB59@CO6PR10MB5790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UfN8TYnYIQZCj/MWnOF7feSTg/fHt7pSf8yvSaDCtIsjzwVBL7soUFMYZ/okfucB5bdh9+nBPBuP0vKcvxuhNeb/W3DEhKvh81u2m8KpX8yTRcNPH2bV9Q6Efd4NuDKle2KQtSBHGqBe98KYsdYBOywtpdaRbxiVLgzEHBF1eZ+VDq9pu6mDKMZUFiLMtIs4po4LlmqOn9hr0OaA0PQlsvKmrwjVXOHRjdvnmYyFu4jrFpAe6qS5wbk3sv+qwThGCBTAY9UhyTsTqSFBF2sbyh3kqXTt/fJycOtmiJUUQ4xLeVvYd4GDXB8sYHqf+uc7T4WEtxZmHgwc1m/b+ArQVmuWRsID7UC0QG89w+bA89azf4l8kIJi8qqd99Mmrp50THOeLGxoWMmQVROZjNoKcY7kuleBSCVB8mGqOXez1JsDAMMn18OMMZNlm/ojJaot06yGuxGFrmEcAPnrycjiwfkTaiQ12Z1VHt8MWnZi5p8hqgrNhRQVgQZOVvEJXRFpchKquv+8hTNwimU9ZjH3eRSRIFzJr2EsNEnAZWhvCPu7+WRMC/SgDsO3E0rFli/i1gtVbk1T06u2QVfV1L2p5NIK87u4Xpqc1INdw77L2m77C6PlLEZINu3pu27hc9bdRu6lc746HFmx5aHAf5vj/c0Z9rWSzrMP3MmiXWPFIJC6zwTNQcYOROKyAPNBHoZW0eI3NhhVP4wpnC8izaiusJ30v3t7K70eXsf8uSk31N3jXfHgHVMezbP+7KUkT0k5ulkY0uH9C/WEMK7J//LytZP8iSzyE5W05at9MEkpu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(66946007)(8936002)(53546011)(38100700002)(186003)(26005)(5660300002)(86362001)(6666004)(83380400001)(33716001)(1076003)(8676002)(33656002)(55016002)(9686003)(52116002)(6916009)(66556008)(9576002)(316002)(66476007)(6496006)(2906002)(956004)(966005)(4326008)(44832011)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sA9g2lEZOzm2pREYRDxf2o5QnerLCKBcDDlEScQ7K41UYWnrwrgbzti92UE?=
 =?us-ascii?Q?zJ9/iUDgZwjECOULojjz59cefhlxYW85P1vTfgPhBuH037NY83YrLm4Aghfb?=
 =?us-ascii?Q?zcKOQs76bDD05K4YlLk1Gjcph+QtCJhyZVfZ5gdzeXS7qkIEnPeY6LKdkX4t?=
 =?us-ascii?Q?8ebQBOjbvBf1EI0tfNKulQOnuYXOLDdGRZdasFHjU70buLNgQzXALrcj9dN9?=
 =?us-ascii?Q?yhQt0ItcaxCKa+neLGOLjU2Hr+QUHISAnGLCJT1jruSFHJP/YrfyQv5irxj1?=
 =?us-ascii?Q?g1KANMFSj3vRD1DvsbmmT0OmfRK5/Io2GHVEWAD+tE0doI68PYUGUXWpCyIi?=
 =?us-ascii?Q?aT+9ZK9rCLwl9f34qCEPE19BoNraFjex6JbTwNo3bwtZwmTibvcB3R945P/4?=
 =?us-ascii?Q?GidRS3+G+aAG5YpyorR0Iu4K/xee3RB5o3xaKFUihtIxxo5wSujnDOObenTa?=
 =?us-ascii?Q?gizls97uh7KTcuJK31RWeg16pAtYLYjD/2uU4LQa67uXvnnN/ZZIOJUjKq5e?=
 =?us-ascii?Q?v6oqqGWkEhPDX12RNF/iIhFZXrj/OYm3WcgEyXUmglnAvWlLpwEtXw6f8tjY?=
 =?us-ascii?Q?CQ2IQ7CB00PuEalamDrqlPvK4zsGDGM3bylOkxcHWekni+qjTLJE4vP7HET3?=
 =?us-ascii?Q?bZsqIK8CzNt3QEo/Shg5mnOZ37d38EaAVOZxPr95t1w3GXAiuCUUx0Obyu8U?=
 =?us-ascii?Q?GDsaSU6mXrUx/c2bsb0HcdYlqALvYGhaulbOp6xX2uDPAP5Trk53wQ0UyAEG?=
 =?us-ascii?Q?hye42WuAtstT6dMiyxuSjFQpni8YtzEnAOVe3Q+H0hnK/IctcPJtc9zLj+mD?=
 =?us-ascii?Q?TvqbJ+pO0jEmUEdzjrszcMKgwcN2HvJIi6UKhgQ+FDTyG/aCRX37XYfWmKN8?=
 =?us-ascii?Q?pW5PWAD5fyzg6bblkj2e4lhFtQdi3uCAn3l8duOD52X99SsIcwLunuk0CfqG?=
 =?us-ascii?Q?zlPk31oNIAZT7lVjetJ31ddOSgHb1pIXEuE0Ms1pZl/D3q7djRwN8WdtLEQ8?=
 =?us-ascii?Q?g5Q5FQbP2ZFeu5TUsIfI5ufbOO0o+y3jhPOcRUyLGqHzfc9TshqANI8pV7/J?=
 =?us-ascii?Q?iQFl3Sew8YxIA05iBdLot1gFr0yLlRFhU7D636HgzEkw+x4wvde/k/h/LER3?=
 =?us-ascii?Q?4o8cTbXBJp/FZV8A9TJ7AJKH5f7ai/otofeKHLRzigQit4vv0DRD2HrrHTnN?=
 =?us-ascii?Q?4QrVLrkIl31kP2o9NutwViC9cwyBdQcx39Ogw3AyDnsDu7v/XipMnC1XQuUR?=
 =?us-ascii?Q?U53BX3CB/auSsNLYiArPH2RfuNBKdkuH0yAV02ToTxloOSoCqL/HvJjdSS+V?=
 =?us-ascii?Q?ejwMApOSjS1U0tPRn0gQ5UI1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d13a04-d375-4f88-3d46-08d98c903053
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:21:56.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocmXcYg6nn94e/dnd43DU+SRwiqMxvnQO14di/mOuB7nm0gbhrRupwJLrNbnE8pJ6RYuwZSt1EqwDZqSKNhAaS9pF6kf+xdDP2P6ibBCI3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110110048
X-Proofpoint-ORIG-GUID: 7KJNs07sNHwiuN1nrpyGIGNdVWrItPPy
X-Proofpoint-GUID: 7KJNs07sNHwiuN1nrpyGIGNdVWrItPPy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 11:21:49AM +0200, Fabio M. De Francesco wrote:
> On Saturday, October 9, 2021 6:31:12 PM CEST Fabio M. De Francesco wrote:
> > On Thursday, August 26, 2021 3:54:13 PM CEST Dan Carpenter wrote:
> > > Another thing to fix are some of the sleeping in atomic bugs.
> > > 
> > > drivers/staging/r8188eu/core/rtw_ap.c:139 update_BCNTIM() warn: sleeping
> > > in atomic context
> > > drivers/staging/r8188eu/core/rtw_ap.c:1296 update_bcn_wps_ie() warn: 
> > > sleeping in atomic context
> > >
> > > [...]
> > >
> > Hello Dan,
> > 
> > I'd like to address these kind of bugs, but I have a couple of questions 
> > about them.
> > 
> > 1) You've listed what looks like the output of a compiler or static
> > analyzer. 
> > How did you get the warnings you copy-pasted above?
> > 
> > 2) I know that both the execution of interrupt handlers (ISRs) as well as
> > any 
> > code blocks that are executed holding spinlocks are "atomic contexts". In 
> > these cases, "sleeping" is not allowed (for obvious reasons). Besides the
> > two 
> > mentioned above, are there any further cases of "atomic contexts" in the 
> > kernel?
> 
> After some research, I've found that Softirqs and Tasklets are also executed 
> in "atomic context", as hardware interrupt service routines are.
> 
> Furthermore, I've also found a .config option named DEBUG_ATOMIC_SLEEP
> that should warn if some code is sleeping in "atomic context". However, the 
> documentation of that option does not explain where the output of these 
> checks can be read.
> 
> I would appreciate any help on this matter.

These are a new Smatch warning.

https://lkml.org/lkml/2021/9/1/950

You would need to rebuild the Smatch database probably around five times
to see the warnings.  It takes a long time to build...  It's probably
not that hard to figure out just from looking at the code without the
generating the warning.

So spin locks can't sleep.  Mutexes can.  There are read/write locks,
built on both mutexes and spin locks.  Rcu_read/write cannot sleep.

regards,
dan carpenter

