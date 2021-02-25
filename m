Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07C13248AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 02:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhBYByI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:54:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235198AbhBYByH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:54:07 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P1js4V012648;
        Wed, 24 Feb 2021 17:53:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vE+vjfDycg9TNdqMQf5/CFO8ssPomQNKxjpWsBrwrAk=;
 b=RpdWld+wLqC5qaOpliG7ZOsoii3qJwGoeUEQW03QeCXeuAzry8e0FjLLb8hnSBEYAhaN
 oJoFBc0Lfwfador/Qrc0D1XquLw31W6vBs75Ll0/33ApFs8ImNfRziJS9R2qSpVA3JIF
 PCuH3/ejKGr8MpM7HhIFJiAj9UozrSsKvmM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36wbu3q313-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 17:53:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 17:53:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs01mvdJxvUg8FZHv6npqCsjqs9o1crHvnFQ+2Mji1OMWoVycDwvmy51tGiXFWxzHKI047hHUVDUItmetjrKTiUsCuxeb8jccVRCKrWYIgQr7+nikqxdhVd/4CSfSCTk6uoWaZwzPSLdA/Gbbr8gHnpYqqj1BL0EEz+T/Wpq0AgsmLIJV07fO+jsCTSHvmcU6LvTKRb94lNawaGAwMK02sYqxtyQ6WZWAoJ25PJmWF1juu5ognENLiUEDRfJKoupnXVfpuf+GHX+Vi1o/2SoJX0hT15LbLMTx2dPI/KLeth2lDTc0ekuq7kXsLzSFIGDW+bCQFqIIuohJrhwLLE30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE+vjfDycg9TNdqMQf5/CFO8ssPomQNKxjpWsBrwrAk=;
 b=hlffrNzXYWk7u5mwRG46rA8xIujTkOxqfEgROE1/JM+ZPbSqV+P2PSDiLWPf/SYcpxOtY7VFl/M3dLOk5iV4iXZOsYwRdFeDx8Q4FSVsNODX1zVIJvarBL0u6EthdLcChGMowM5k5YScFk2uJ88e5U9Cemqw069WoWx54Dq94LPGePmwLbBg0sh8R0zqty8h76Wg0zzb6Ff9uIV6oFXxHwcfqeKbabM75ZslOMuxmT4QZyy20i31ARVtUMK1BOZWAge9WWD7SoGmJwAsh5BAD8y0erSwQ6WqqJtsT9I/SkWwxqdLus/A558C2c4ISIh2OlmdrQIaJoHfH+x9t6ZwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4133.namprd15.prod.outlook.com (2603:10b6:a03:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 25 Feb
 2021 01:53:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 01:53:09 +0000
Date:   Wed, 24 Feb 2021 17:53:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <YDcDAOxKXSopVe3b@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
 <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
 <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
 <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2008051913580.8184@eggly.anvils>
 <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
 <20200806182555.d7a7fc9853b5a239ffe9f846@linux-foundation.org>
 <alpine.LSU.2.11.2102232210130.9202@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102232210130.9202@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:45f6]
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:45f6) by MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 01:53:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d41fe2-21eb-491f-0919-08d8d9301a2a
X-MS-TrafficTypeDiagnostic: BYAPR15MB4133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB413336E0517FAB24DBBF4650BE9E9@BYAPR15MB4133.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijQa3N5kEip9Vu7zKXaC5Zvzd3GZ7kPlCmgtU0nKEHuDUG6npPjY0OtYz4qty+9p1NbTqubxUSNwG3BPcLT0lbA2/P4gRlGDTERcsAWvmC3WY9C7+HJShThn77Uc1Zqz9WluhoXwQhdj71StASBlDrhQN2vnXZp8fINJvcRlChbjwmBNimDk6o3BdgCCcul5oM6S7t24kSRk9/ggYV9FpapZokzNv7701lpgxR38GpsxtDH6/7/GAcIpsSJpZAhaJFSK6omsFRbaRkPb2z5hrnBm5BWyCMQUvLIaWtLVhWLAxUyjbmfs9X0YqZu81py8lstSTKi3cXimWxSN2ZRnZYRf8SsZlE6x+FKFAdgllILGJqbyLNVMqZdNf4hyLOdSgi/oBOAALJqIbUgMwhUCZgQQEweBUhCcrfkVaobUmOAxjoIMfzTDZRrKJfNY9ix6ug7aikglir+L38wgfGdgEr/RX/nGdSuTJJxQ71INuBVWw+iEop+RCzaYLpGl14BiFYD81Jo7tweLn78rxq21OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(9686003)(86362001)(83380400001)(5660300002)(8676002)(2906002)(55016002)(316002)(8936002)(7696005)(6916009)(66556008)(186003)(478600001)(16526019)(66476007)(52116002)(66946007)(4326008)(6506007)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X8dO6JA7xJ4TyX5f74EXXrDSzlDtbF9FZGCTq+IK+wuFy8TevzZQxXGgCaPa?=
 =?us-ascii?Q?jICv20hGzLqU/BwD2ymeEfoil3v644iLp4iCBlSLx8pH5VuYebHs+1W8sPrb?=
 =?us-ascii?Q?Eoc48YDgDug8mY0NvKrp3wfkbch/f795eVhS1zNT4X9h2t8KE68e2bm//X6n?=
 =?us-ascii?Q?GFY1F5k96gCdEGf4iudGGKMBhDJz2YGJMrIixWGaxqhU6jwiMW65gU/pm+81?=
 =?us-ascii?Q?pQwElpXNKqVxSRU5QnRRu/HijO4sAXtl7FA20db36XqzkGAqbDAInOqhEKWW?=
 =?us-ascii?Q?jL+/QSRI0Ok0gpRJd/U9NfUBrzqszHcZCSbAyVtUuLOyqCwt07JICy2W00ko?=
 =?us-ascii?Q?WkmPGCgV7NlQ5pPscu6jVdlg3V8FTENZ9xKBHbzYicKMQFH1u2xiQ/7wM1cb?=
 =?us-ascii?Q?dfUIKVei6aVQ9ZDNXsrcoc4wm+839bTO5FETKiqlttVUTa9tAV2oKlKL86ts?=
 =?us-ascii?Q?bzDSFt1Ptwn0zBXkeszBWU95qU0T2QBLm6pIDX5XkuvVeoOrYSkKrX9nerXj?=
 =?us-ascii?Q?z6/XWSCNLdb8CrJr7niT2olAD+r6w8Xo4IBiRvZy9G9SczMRkqhikDpUn9y9?=
 =?us-ascii?Q?d7j72S1iD1cTytmUc0VR22sCDVVJpZ1mqO76z07MO8rdFCi9NugA+QMxjGJr?=
 =?us-ascii?Q?8k4/5S9zODvopgQwzd6HJwvirO4KOWK17Cg38sJgoeHOH0Jzzx8FlDCSnf8b?=
 =?us-ascii?Q?aMkt6uMvF8dpFMsBW/xO7/bQFDn50hwuP4GuW3Z4eCTdAh12jvDobWsJVN4O?=
 =?us-ascii?Q?c3rli1wCE15tdT0NY9qe8Y+mXVs2c+y0W+1RUkxPR3obSdkvjSqB183TvA1q?=
 =?us-ascii?Q?jUTIYHColVNG2DHB9zZ0HmSZIrSqiOnP6pHhYfOMN4YGwhtvLHz1FcspEdys?=
 =?us-ascii?Q?PSP8XbFSDCg8UtB7hclNQH8BCCPVXxhmFu8D/wEaQovmjdKb5NpIEKNr1Y6y?=
 =?us-ascii?Q?9uKHW5pA+Cy/M7waiu27aHf9LWqKk2XIzn3LyA5jMnBvGJpgGM+sLyrEYJGB?=
 =?us-ascii?Q?KZbxg6erjarRUqFl6WKf9N1jZtSF66bDxcut7E8xPTerwVbkp1WIrqmXhZzl?=
 =?us-ascii?Q?1CiAqLuZbBbksfpsA6I0b5irYzgcaqg0gDalaXzrxCLnZa4l9OI0B4nIHsPS?=
 =?us-ascii?Q?DZz+bHlUakANw1sEPCRinYsDQc91J9v+uAh4BadkVwF1/aamjYvKRQIh5Zte?=
 =?us-ascii?Q?lR9mzHbwDbuxRXcWqAN2WVxuZnCEbDcisGsELmmZOwgnowZYNc3CMvY2p6Nd?=
 =?us-ascii?Q?uLzOfTYPUCemHFyimVh0XOaBB+8Z1z03MOuq+aroeuWlUNk+5EYxSOGOI09m?=
 =?us-ascii?Q?gF79+vFc3mqBj0NhW82dcdcSDX/Gppu1hQ8lSKevhCqTaQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d41fe2-21eb-491f-0919-08d8d9301a2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 01:53:09.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfZlABupa6SmKxW01AzZY1x4+vuV57aDlmrUvG1HwlKJJbP7U3rcehlaCyeepuQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4133
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=986
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:24:23PM -0800, Hugh Dickins wrote:
> On Thu, 6 Aug 2020, Andrew Morton wrote:
> > On Thu, 6 Aug 2020 16:38:04 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> August, yikes, I thought it was much more recent.
> 
> > 
> > > it seems that Hugh and me haven't reached a consensus here.
> > > Can, you, please, not merge this patch into 5.9, so we would have
> > > more time to find a solution, acceptable for all?
> > 
> > No probs.  I already had a big red asterisk on it ;)
> 
> I've a suspicion that Andrew might be tiring of his big red asterisk,
> and wanting to unload
> mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
> mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
> mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
> into 5.12.
> 
> I would prefer not, and reiterate my Nack: but no great harm will
> befall the cosmos if he overrules that, and it does go through to
> 5.12 - I'll just want to revert it again later.  And I do think a
> more straightforward way of suppressing those warnings would be just
> to delete the code that issues them, rather than brushing them under
> a carpet of overtuning.

I'm actually fine with either option. My only concern is that if somebody
will try to use the hugetlb_cma boot option AND /proc/sys/vm/stat_refresh
together, they will get a false warning and report them to mm@ or will
waste their time trying to debug a non-existing problem. It's not the end
of the world.
We can also make the warning conditional on CONFIG_DEBUG_VM, for example.

Please, let me know what's your preferred way to go forward.

Thanks!
