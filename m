Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD20B3FE71A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhIBBXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:23:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26526 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhIBBXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:23:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181MWNnu025879;
        Thu, 2 Sep 2021 01:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ph7egFKRw5+FsfAGwzguwkD9paU58ekBgSiLAx88VC8=;
 b=a3Mq4ydBQd/0s2aOJX3OoUqp7ZNeVtwyrb6w2xTwAcoHf0FH++n1ylnisUgSPmcMx53k
 MYA3o+hR3ivkU+j/DnF5HhKaYW6z7Fz2b6KosAJdlFwhCUUB1p/FOnAtKSED4k1Djf+W
 U7v0sI4Od7xKI74i+kfZ1wLOCYBQv+otOfBYYv+9IwszGNzsqunWDOIRl+PQTUyiQGXh
 4a5mf5M23QxLZ2JR9ZE8lM7nvnrutrckB8Z8m6scdT06qy40WuzZvtcPKESjAzdz/mpY
 /eCPJ/3/iqgCgamaZheO14aQv9GFkRsWMQ/mPud/xFw7sBmPrxHyZCMayiAEOkCVHsgh Bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ph7egFKRw5+FsfAGwzguwkD9paU58ekBgSiLAx88VC8=;
 b=iCyb8LDLSe6ZjwrxbmkLFqwuqOGoV7gdOA4NOluXieH/44O0BimikfYhgavsA/YNVgAF
 gKMRc7g0olG3DCU9qjDrZgbZy4uB7OAK7B8LNHaVx9c05HIoCOw4loYNcAnwivFsngMv
 sLSlJmRebu2fya8YXg7g6oBeq3/vrpkhbaaap3pk3cL6/hLBkSzxnHySbznMnh4omVSE
 sRRQvfBgEmCNmKFG5h66jjqf9mBtug2BeN7Ea1ali6fsiWD3ChVVuuQwHPlH2Ds3cJMg
 hg52UriFbhHqU/qt5AE1UzzI4Ugci+IVZYYjrta2bFtr5kxEPNS7EY8j8alBPwiuRWUG LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw58y7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 01:22:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1821BnZS134504;
        Thu, 2 Sep 2021 01:22:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3atdyw7s56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 01:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKcOaDg8yossWEfnmTQ9AzpGnyK2WmzciZ3HIYhnR0t+VGSUt5LqvuDvlG3xwuV6r2A+c+PWdIhfnNDZorlGHWvHZIGYKvovn7Gfi/Qkmt5oAU78+VUk8GG7jDJXJ0t/WdeXGlDSFGDvkG3b1AGHL9pepVxtnKCGYbJtdetZ6Cy56TvYRoljYrb31MLilVthz/9S3i40Wa8QBI6BX4eRZaXGxhWvWGpTs/GCVYkXoqE0DUWKHzewjb/gm/KV+JNZ7aRzTyXDBhR1CR4g/vCC6stIJqyMbg2M5FpNY8rH2UcjSwCRuS0sUIUdo3atXfMP7F0hOx4BXJrRaTS2IT//4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph7egFKRw5+FsfAGwzguwkD9paU58ekBgSiLAx88VC8=;
 b=di8Gog2PdrevVSU6hJnMvKkeHuEgAEOKklXELEiVKTAbq2RjpAPsCZUVhwMfI0S01bWNpOFQz5+SOmGlaMcEGsKcynSLmRXdm1X0V9bIxI34qjH8ZFbDZOzgxWRyweOm/uyqY/4Cq5W88zf+eOEByh034vX3UNad/apFY2oLDya3ZcC0MHs2Q0yNGw9+2YBULHYZPZFa+CRnsBQqfnqRmqlVBoXFqVlZFL45T50PdSsGoImRCEAm3U/xBZnq2iwSFnxFY+QHjXy8LpbTjbvuv+wswXqVsRgukurOywNutcnX3iJzzel6rnTUaNj7mV1INvDpxYXDhxkV/3Dzh8inbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph7egFKRw5+FsfAGwzguwkD9paU58ekBgSiLAx88VC8=;
 b=VfYlDb2dsklnilUMwmoWqkIqN4Vyv4sWjSRLXh1wnjP7ZoiKvmzt+ka2VCBNXMviQw+s23wJos2M1uZEkq2TObXJmVbKaQGgAi7Ak4YKYLS35mNUHe7aYstialNDAD9sLQUPpZxaCGM+0bxnasTufwj/qLQlsW3/Uk782AYccGQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3192.namprd10.prod.outlook.com (2603:10b6:a03:151::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 2 Sep
 2021 01:22:11 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810%7]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 01:22:11 +0000
Date:   Wed, 1 Sep 2021 21:22:06 -0400
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
Message-ID: <20210902012206.cm6flytlp63c2h5v@oracle.com>
References: <20210820010403.946838-1-joshdon@google.com>
 <20210820010403.946838-2-joshdon@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820010403.946838-2-joshdon@google.com>
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 01:22:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840d10cf-9bfb-48e3-cfee-08d96db01695
X-MS-TrafficTypeDiagnostic: BYAPR10MB3192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB31922526426EE3F2A4E8D898D9CE9@BYAPR10MB3192.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oJJO+gi2o8dM/TqosEXsUQerTyr1H9PNTJjbhY6KQXvH3p0dEQQNvX6n6Xc6RQTdPmS3QIy1vQstwRDXrVEuZKT2eg1DVVInhJHdAs75D0sqelEwNcO0ynHxq1XsDdCMKv7pPjMtecTU5Y9a03tAR+Zjn5pOsspVCHZBmd/wDSEsMRYv4C/ShB0/mFiEEu23tnzS6oYC496l+AuJY4lHpwuj2KlhRzNOVorpGKOIKTcuT8+V7ipiupUViV6pVkPVKw9UqTg4i3dZzdA7L6H+uo9t63Db6CJKkPxjqp3gqOKCRCh+9VGhrO65FabTXl6GRfpgwTvJLsYCeI9hkfiN5cumGfMl/AufQ4paryn+l2yDTmjaE0NgTHmcsxW6JfevADgcf97GUeshBeFlPF01whWBpVZKbYduHVIA8gKOAkPk2NFV9hneMme6xYC4O7k/NI7Y0TFXeA6v3dipGkMuYazz9F8KfT5Ms9H8Zdc5/aG/CwBri3gjbkNjqVuHqIA2NtYfy3qXkPFyN5R0GtyCAeOhromGXHg0FTNm71VvUVPC4nxdo8Fuktv0XVNRlncjQx2CtvnMV/I9obe75E3050kRXhNnIdaEJWlk6Ax6bkvKO3D3Y2mOdWOyIRZ4CnApLa/8KaIA6501ilY4XEay6pfGvNJjkGIDxMd27WuPX+VuaDtf3QCVb4kQwN7k1/Ix0okBdwp+6z/HaexEu73qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(478600001)(52116002)(4744005)(316002)(66946007)(66556008)(2906002)(8936002)(5660300002)(6666004)(66476007)(1076003)(8676002)(55016002)(7416002)(86362001)(54906003)(6916009)(8886007)(2616005)(956004)(7696005)(186003)(38100700002)(26005)(4326008)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxAEwdGpbGGq6jmP+V8cwpW8E9N9GIUZIQUT9XS2s5Ehn6yd//sM+AYyWCxC?=
 =?us-ascii?Q?Tk3RL3cXY0ZGbZvgMx2RKnrunnb9hjdBOkTOkcnmkY4EOrulQELbyljYwMZ5?=
 =?us-ascii?Q?anxRImEnW9MR41SurQqzzb0/7h2PKTVwvOu2lsNgyxKUSkLWWelqyVG/ldOk?=
 =?us-ascii?Q?GaRDUlx/cXzsLpRQk1sD075rKXYrzg1+5ZElx86TBcsh9ThJSfg+hQV/XdKw?=
 =?us-ascii?Q?zIPPzjHX2FJzTfa3S9owULW71s+nrgM0Gvqb9+eWHnwT1iKbXcPqjw91W6Qx?=
 =?us-ascii?Q?Cc8OYUQ+zVf2+giDfqSAwwDRkXkt730jchODaVbEZEYPTjlhOC5qKGEW87Z+?=
 =?us-ascii?Q?ES2RsGuI7Kf86ZPXGwp36EwvHC4CrD60V8YA2rNmQBdP/ZGiT0Pv2pM4nwZE?=
 =?us-ascii?Q?DWb+WQ6ZlQLFuZ4A5e24IzQrNzQOO1DzrR9RX2XQAfXsjhQplEeA00QMXuQr?=
 =?us-ascii?Q?Tl/4f476wO6gJCs/DAXK1huqDd8jkR0e1aMPFUboYOZDNOSnKWdFh5+oomx4?=
 =?us-ascii?Q?wplD/gmVwwlwzYFIjw66dDKFP2jR8hTASJCBLv0Ct1mIm+SqWL32+NElsD13?=
 =?us-ascii?Q?FhyqLeFNoIsGUYIkkEbExc1kR56VzqtMCtoBjvRhdd2SBQP8ipZexU8W3qJm?=
 =?us-ascii?Q?THTs2AZHsxBTRyYa1V1Lq8F0J3VC3rHKJtYx0AH5pcLfe8bQWDuZg88AuQIf?=
 =?us-ascii?Q?lxsqohII9nzF6JAUsjzgMcIJVVQ/EYAJmJOLeV4sm/IrUbER2fj+jfuOcq2b?=
 =?us-ascii?Q?qQTkCHo6BXX2VLE602qFLfgohC9drNLWb+1deQ8BODieRQa4ueihukSVcuAR?=
 =?us-ascii?Q?f12rZWzIyO8szpCskZDNkqS3Fr5QPlFVNEfTHh07PRtKjmb86YDsd406Kj3N?=
 =?us-ascii?Q?haa/GnrfPB0HQ3OUCvUl2GztEkttOwt7b3YVEN3XkkTECLJ39+MBAZI5aZ/w?=
 =?us-ascii?Q?qnMzIVZ5macFQEIO+MY1h7UU2FnhMUG/VA0TFyZpvPrL4/wKd7IfM/PKqhv0?=
 =?us-ascii?Q?OW0VVwLgsRFucmX2XuFKt13HN4QoH2rx6JJVdR76ToxYw9r4wr3daXIzrNSd?=
 =?us-ascii?Q?FC0SvomUDHurPhNJMyP+u0k5uGQL4I82w3Aw5eqwKkoH7vb2MrqjOqSkK5go?=
 =?us-ascii?Q?F1ULK1ia/2Ga+6b8YijbSQztTPbuU4QZ9WHodBpkCpvAnuhJcPQ9wm6e0eJA?=
 =?us-ascii?Q?eyU0VZ3QWkDIWUBIduBci6pZNSlGUqsx9FAzb6s1tOwfp4Xui0uWcLc5lRIF?=
 =?us-ascii?Q?3i+odB8ZuJHZCYFyoZc7YvFtu68v+2xVhAfQYStSCxWkYGF1ncCrWPcFoIFI?=
 =?us-ascii?Q?uxlRt4Naz0HCMcx4CwwzhLG6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840d10cf-9bfb-48e3-cfee-08d96db01695
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 01:22:11.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmtu6Ddp7QvqZUPjm3jFBjXCB5BaeNhZPMg6D5ZKxDVuh/+AD0gBOv9VT6Y0UhjaOJ2scinCkifhCn8N1xBObGUhX1T2fX/iVCx5vDjynQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3192
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=917 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020006
X-Proofpoint-GUID: u21DTU6KNPYQTp-So-591rtJhIabaTq2
X-Proofpoint-ORIG-GUID: u21DTU6KNPYQTp-So-591rtJhIabaTq2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 06:04:00PM -0700, Josh Don wrote:
> +static int se_is_idle(struct sched_entity *se)
> +{
> +	return 0;
> +}

I'm thinking !FAIR_GROUP_SCHED is a rare thing to behold?  So not a big
deal, but I think this wants to be

        return task_has_idle_policy(task_of(se));

so buddies aren't set for SCHED_IDLE.

>  static void set_last_buddy(struct sched_entity *se)
>  {
> -	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
> -		return;
> -
>  	for_each_sched_entity(se) {
>  		if (SCHED_WARN_ON(!se->on_rq))
>  			return;
> +		if (se_is_idle(se))
> +			return;
>  		cfs_rq_of(se)->last = se;
>  	}
>  }
>  
>  static void set_next_buddy(struct sched_entity *se)
>  {
> -	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
> -		return;
> -
>  	for_each_sched_entity(se) {
>  		if (SCHED_WARN_ON(!se->on_rq))
>  			return;
> +		if (se_is_idle(se))
> +			return;
>  		cfs_rq_of(se)->next = se;
>  	}
>  }
