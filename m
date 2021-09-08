Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85940403A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbhIHUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:40:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15952 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhIHUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:40:32 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxOcq028121;
        Wed, 8 Sep 2021 20:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HKovClExkXq7bARcWpxfUdFO5iIhLLC7jf/bPdUgOR8=;
 b=XRAw5Zndi2asOsXP1ptMgL+f3/lNXemlAB0SZDO88UlZzLiNf6RIRdcY5YYhTRh+xkbU
 kidh4sN8VCZdUW9FRJaAP4pM9vCrUryt7wEMlM3Hp/lOMPewyEaPx3FeugFq70hpzREz
 DF3kGU0grPtvc1SwS/vutWWpEpvA6Yz9Ax8u+WYI2QEXsg8KCX1JR94j+AXZ2ZQacdOr
 eCO6PsakAZhyiQkbSPnqxy5F7z2BN7ANErHqC2TYEMNWUh0PXThLl1t5q3JncxLqOBtk
 sNh9Zpr8hJNMObKCwUvKAhSczY7D8BFkO+owLuxf3yA/tyYwDNkv5s8RhsmKdhx5L0tz Fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=HKovClExkXq7bARcWpxfUdFO5iIhLLC7jf/bPdUgOR8=;
 b=FOSN10SNiS3hQTrDrWafxjSC8Cn+rHJnlyJQQUbWPQr7eWCd5J3KtdhfK8B8/5q48+fz
 UWsQtSIPND/gegnX1/R6JRytKIgt7JuKTrQPws/ZFIHInu3fv/RMjRxBt7z7dq4Non28
 K7yNXkQYJkFlhn2CxfOfM/zQAcrOxaVe2S5MmFg5jM3gxhJ/dMsjr8h/mYFhvH+CfXrY
 k7m8oo9lbiKuKNsD7Ihpx+oqw5aw4bFJoi2oXXlr0XCUnoiy4iFmU5oIVBPV7YLxFz1M
 Gfd+yrjJloVYg5/JuoQc+76MSa+IougFdWYL/oPn7/GTRs1eKVDNrkNBZEqcqOHIkV2C Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q432f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 20:38:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188Ka4q3116396;
        Wed, 8 Sep 2021 20:38:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3axcpmscnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 20:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ6ppkq84JRwnCTz2mfCyrediOWIYAv2C61c69HuqLLHS5zPQ++rMbwnpBZvioYomfi65vYiis8n4veulhE9FeWdHAghBz3xgY0dfPs6Fw3MVco/5O6ukaK48v15Y63EI3O/yoXvE12qL3rhl6+SKVjTT+sv2PzfVnEUaljT2K+zyOtUdFmYz0E0qOttllyMq/0+FmL4B7gjC9xLuPO1VrcCuImcRws65HcfW7PFY1ICSZtXnChjqOCT+Gq7rb/A2wYanwZA2yoaQrO0pci+nd4j+uHtGv9wXEI8iOr4DjRdHNM1BEIHDe8j0IcEMdIurW+k39HkeCcn+m172M3tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HKovClExkXq7bARcWpxfUdFO5iIhLLC7jf/bPdUgOR8=;
 b=CuePmIoJMqZ5AvIDJZ7svsd00WvigjhuL/5IvvrBC/pfp97jecEIkTBbstaKyXkPyEjYwI7qwOMKXx7prWSUi18MsQVokndrLbCEFMcVqWCjFo3Fm2to+J5MFGjunk0bI6arOcJ4qaq0fgEhmr/LLiBr50XUMt6OpP6lJ3VGjhRrRDDcpQMyk2mQJpgAqdduK6QVe8fItlyp49xj9pV4dW2FsyY1+agWFXwlaFNxJuSRmtLwZH2CUDJxZve0qidrjMcL3My+c3zkPsA57N/p35hasy/riAkRyByZyO2XdmzX19cxFmtwhlm+mscGp/Hj661Gijj5VWx1+/GUic7ZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKovClExkXq7bARcWpxfUdFO5iIhLLC7jf/bPdUgOR8=;
 b=ern+f4JZwFUzoxVvzVB+fiKUYxPSWMbuMoWfl23FLk2Q8Es51kEAHeX4AXtEiPafZUKFd1vuQ1/hPrNs0Y0f0yO59fcFpemh8Lsw8aBr0f7rRKe0BreoW8YtDgQFEqn19Mk4bTflniiRU+NQ43lTObpP8N431qaCDvRm95EGSU4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by SJ0PR10MB5470.namprd10.prod.outlook.com (2603:10b6:a03:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 20:38:33 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810%7]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 20:38:33 +0000
Date:   Wed, 8 Sep 2021 16:38:28 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
Message-ID: <20210908203828.5tljgqezi6nqywi2@oracle.com>
References: <20210820010403.946838-1-joshdon@google.com>
 <20210820010403.946838-2-joshdon@google.com>
 <20210902012206.cm6flytlp63c2h5v@oracle.com>
 <CABk29NuoNRu0SnEEqC8zhJROndCSRhfsE2xkhO98WP_wTTDuCA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuoNRu0SnEEqC8zhJROndCSRhfsE2xkhO98WP_wTTDuCA@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0136.namprd02.prod.outlook.com
 (2603:10b6:208:35::41) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 20:38:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a84f8841-884e-470f-6900-08d97308a023
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54701283B47FDCF8DCC61430D9D49@SJ0PR10MB5470.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slqfAM0sy/ArK5r/Q+zqzgTm6EK0IkLV4/2XDYWEs3w5i0bvPwvWbLMAWhF+3Rs1F97ouTMtHrfcZB6VOYTp37yF+lIWwLt4ZOAAtlEztXTBUltT87GNWR4XZHO+wATf+JmBj/kydZjMLM1g9XADxEfVJbzW7yePvbskG3ehWVwYz76yutlv6oMrBQR6ZKd9mqyvyZoA/eeOsubgPrO1YojmpriRE9kXF5BDodU4Pc2Qta5irdzhDXo4K9VidA/a4f9YoLPmReAgjUbWngxpxnGL8oA9XnIps/wLyJE76fdgDH7eGI6n9La4upjR3Pp91EGXNb6kTCNgSrVQSiQX9/ZJPqaaMtzAkgPu+cBBORZMjWUEgj3QFTkcb9qTbQwVFwf0w5V13x+9DpyCZhsJ1ynxg9ja3WUqZw6x+az0mrDleZp2BEODqgTdZn+Bna9qpr+/RgvjvrS/jDJRZlJVl40dk/jfOb3CCwiMJ6+9uiW+iN3ACjQ/ihrq0BZvvsc38Ctr2/0hT9VP8X8wKKOGh/gqv0EuZuF7t/vA9Gg61u05B+mvM/h5kgKs15zJg453YZX0VlkRWNhlOKLVNovw13JUUo6jv+/xJvsjJdUef22INpL3L7WkQRclB/E2vvrZaMMZSWqEJRVDgmveont1v1ZdVGgjuzCsA4yZy4h1pjZMhLcohSUzBPggvLcdqL/sgkf8ZNL2IB2rZKtkV8/J+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(5660300002)(55016002)(6666004)(26005)(4326008)(38350700002)(8886007)(38100700002)(8936002)(8676002)(4744005)(53546011)(1076003)(7696005)(52116002)(66946007)(6916009)(186003)(66556008)(478600001)(66476007)(2616005)(956004)(36756003)(316002)(54906003)(86362001)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dpPkQGEgzqknhqd67jxSn5cJQaqaQL+5czOl7RD8op2SNLTQL4/UGhkFj14?=
 =?us-ascii?Q?hysa7cqjtOSD4WYHZe+CwJpVk8gEA85IFtbVoUfc8chxT/lBnXA8+f7V5IVR?=
 =?us-ascii?Q?gEotna7LPFYvx4hMMf1uZXpE7HAXtT6NrX/W0f+w1h7omOaI2c3/DbkRhDyM?=
 =?us-ascii?Q?VOKpj7LRYPaFJmFXH5kbOdvywMez3QWVeZBbN5dgpss/2MatzpzLBayf8NCg?=
 =?us-ascii?Q?SVml+YZvXotG7mzUjJWd1vM5YnCJ6gErMxAWIEDtaJOs6+0jaNzD4P5dPHTW?=
 =?us-ascii?Q?3KddiwhB33kS/s2+koPZ5CRYXOmZHW4KPR7EvZPrRFZDlmJCCdSiDxMjCKWm?=
 =?us-ascii?Q?eXx0KiGo6X5cb/wfUgNvNBOzsqBtjRIfSORRMR5KfYpl0WyuFMVS8PVK1csj?=
 =?us-ascii?Q?zkA+akt8tQU4KumPzySnlOv9lGUYS8N+osn0ka4Oq3cN/+q8twQq0unHEiII?=
 =?us-ascii?Q?SfREANDZala+cr5fWnSQGPWny1tGDGkKziDH914I9jFHwKuCjTSHk7P3EqWs?=
 =?us-ascii?Q?UapK72mnN1j1mSwHBZ8RaM+has7SaxFzxilYv/KgJH8reo7qKnni+AqMBXFD?=
 =?us-ascii?Q?5hiTJf6qgW7Bj/o2NP8D22OKyDIEscJu4Zv16LYpYbwBuJSqV9Cas+EFYuIx?=
 =?us-ascii?Q?YlqN/hYrTUlRvq+eAWcRJFrJFNVDHTUHMf/3iQbIsZ+4289fqK/HChaRTTEu?=
 =?us-ascii?Q?58u+Yrx69uYLdi/jFf+7RJg4OhhzPNQb7SFDU3M8oUobMoLDJDLGH9LW3ZYm?=
 =?us-ascii?Q?xq4d1BttxxuBAlDesQadtiCXW4Ijn7JYm0uPrziRh40R6g4E69m3MolJYcjR?=
 =?us-ascii?Q?wM+szWRXQGS0f6YNCp+RRTjWF65CnA9UntEShS1C9u444fUmVz1LwRlYuPI8?=
 =?us-ascii?Q?FOSdWDI6fa2V9263nybkh7/CSyQnsAGf3a54ABBKkdH/bCP+ufQk6jJQ1Oy9?=
 =?us-ascii?Q?Laacdm9/k7Si8bQh2Ji9wObll53YcvpnGGNrJyZxrhzfqa3Em3leTbm89fjx?=
 =?us-ascii?Q?Os3eZZeQ0/DwymA7mMvhwu8raC4WRIv7u+I93jFt9EOUHG7qd1zYmJvDUTCR?=
 =?us-ascii?Q?+8ArUcx5ZNIZDeMkMd/+v/YR2VV3a/NeEbT9LVlRRP2WDyhZWrQfSpTrlc3x?=
 =?us-ascii?Q?8qFGQcbjaH7DhreRfKpqVzt1NyLOlWOUjviFrindkkmA0NFnw4//A9QG6zYS?=
 =?us-ascii?Q?GHfON81fLbmDkkL7SM+zopWx40vcqo8bgEIZN4BHmlaSf0yXwheib7SJYgBo?=
 =?us-ascii?Q?riEP5+ini7yxic5H8EyAJdqUBF9qizUfnoC0NoSjmUqFaBVWYSZpWXgyjJXb?=
 =?us-ascii?Q?0H/4J3+BJLE8GGoACnGjpHsL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84f8841-884e-470f-6900-08d97308a023
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 20:38:33.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGfamKah4CczurQ6KdY1EUTaxNuvlUuC47if0CG3zI8GmZ271R0D8IMzc/QhQNgRpcCfKd+mdHyiXTlpEoxmptVaFi5G4fhUY4hnq7CwnAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5470
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080129
X-Proofpoint-GUID: DsW_ZSJJgf-Lh1psie86yoZTHkRXBw_w
X-Proofpoint-ORIG-GUID: DsW_ZSJJgf-Lh1psie86yoZTHkRXBw_w
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 06:21:09PM -0700, Josh Don wrote:
> On Wed, Sep 1, 2021 at 6:22 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> >
> > On Thu, Aug 19, 2021 at 06:04:00PM -0700, Josh Don wrote:
> > > +static int se_is_idle(struct sched_entity *se)
> > > +{
> > > +     return 0;
> > > +}
> >
> > I'm thinking !FAIR_GROUP_SCHED is a rare thing to behold?  So not a big
> > deal, but I think this wants to be
> >
> >         return task_has_idle_policy(task_of(se));
> >
> > so buddies aren't set for SCHED_IDLE.
> 
> Good point. Peter has merged this one already, do you want to send a patch?

Sure, here it comes.
