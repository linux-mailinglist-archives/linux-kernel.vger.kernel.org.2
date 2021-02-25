Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED21325540
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBYSKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:10:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232787AbhBYSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:07:33 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PHvh5C028071;
        Thu, 25 Feb 2021 10:06:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=su8xcQDcdok4JEF20Pr6YMsqNR1hpcHhtMhvCVd1FHk=;
 b=AyYFB8DdZjXaB4kkDSB2rv1idUAIIyQZA1VOok1iR5Np20mhk18dJqAJILi/C4U9L6PZ
 cllyVU5lMano1r7T4WzpC3Do59WaEa1w5Krsxy7xWcnJXiIdwn+DQzVG7smn5GcS7Zro
 j6uf1rrpOuMZeOhfz9PDZDW0Cu2YDh0lYD4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36x96btq1w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 10:06:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 10:06:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkm6MlczohpIP91RcBxB/oPTbBVNeU9mwqH+2Xnm0LBCsh2X113zu8LUJUKMx/MxJ9W2FX6EjH3nDGnVUs0KyA0PMhrwoQH4ymq1HUAROCt62e3Yy6sJ9kmFSmtXOoGnWL1RYkwWyaUputXkt4sOpyGqth5ZFsq7iOiA21X2EgBg08UhbkkFaOh5WEq86lhFbKyCEh8qqiwUIVqRKPWjQ5kdjTwLQOcQpzACQVVkYvvW/GIiP474dzHVvMtL3gdE7SuJXNhFkZs3lNq4HTfZ3d0f5E37VcJ1l6jJiNj8/aNYmyOuwcbuqg5m2K0SelJ0wR7+pUUORBnxcL0LMPxEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su8xcQDcdok4JEF20Pr6YMsqNR1hpcHhtMhvCVd1FHk=;
 b=XN8QmvjgNdCWfOImjXvpT6oePu5NGFW+2001ldvwVYK7CnFd4Fy/rfPJ481zC+ky2skNlBtZGysXyMemZd+JpfQlqWIUb4FzNyBfZHsDKs7Mli2iK3OQn4dbddXXN+ylART4PXB8a3NgMhNQKbnwDtJ1S6yWIBYq0FGV4+glPJPCgzia/mhEHcLroRB9wW+Ru4tdJKuR+4yQVpm2PD3lpi8SxqXHVbkguruiyGnl2iP1icmNpPcDVMSgHsyZ7yyz8U490prSdxWMOf5k5W874UTQGQ8r7Y91AMYrt5uj5KXh9zSAGi0OMs3k9rMRdkTOB9UFHrYwfLRnEs/F9pTfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4308.namprd15.prod.outlook.com (2603:10b6:a03:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 18:06:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 18:06:29 +0000
Date:   Thu, 25 Feb 2021 10:06:23 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <YDfnHyzKzZRU53e4@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
 <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
 <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2008051913580.8184@eggly.anvils>
 <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
 <20200806182555.d7a7fc9853b5a239ffe9f846@linux-foundation.org>
 <alpine.LSU.2.11.2102232210130.9202@eggly.anvils>
 <YDcDAOxKXSopVe3b@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2102250905350.11720@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102250905350.11720@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:45bd]
X-ClientProxiedBy: CO2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:102:2::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:45bd) by CO2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:102:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 18:06:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d417654c-3711-4a80-f5cb-08d8d9b812f1
X-MS-TrafficTypeDiagnostic: BY5PR15MB4308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB4308EC941DCC1B833C13E8FBBE9E9@BY5PR15MB4308.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ibzWd0+as3dwlQ9XZtJNCZ8GixeEcJRIgadZRonqovlheAXN3fwOpCKKWDSPu22bEbmdBsDA8hCG03cCqkg6ca3QfCC+LPPiM8w4FFtiJp0NN09M8l62Xanymp1f01YAoyYoWgrwbsBVsL+1oZ3loh5AvFSbEUT+t4Sr0LvUydJtwfD9YBAifNo1spy1kBkkC0ZZzGT65XfKnZ+LA2FonxMJl1t56R59y2TAp4Ew8BZ71+88hPT0oXP2zrsJxc/Zue6qSaOQ0D6tb7JLSyfU0cSYucLEMqJ5SMKXMlcvXi7n99oiDXBmbY/ZCbgvrx8X6YZSyISP9H/LpJTpDe+GAe10D40xl/aiGInHjmUg7eJ8u5loOsodan3XCf8znT649W/6wJSdIyqvJNd7GZn4LTSVC8CE5IzGzc4/uR7gGX2b01ECI+TliNnoImwF2hyYyCy57NubIY845pZ59jzG4UHE3Hv4VAGyw0xhjyx8AsqOiFRbBqYwNPbpjghiNzFT2j7FvdFvIrqPHnZXvOHLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(6916009)(6666004)(2906002)(83380400001)(5660300002)(478600001)(4326008)(8676002)(6506007)(55016002)(316002)(66556008)(9686003)(86362001)(54906003)(66946007)(16526019)(66476007)(186003)(8936002)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0jCakFYbqn3Ahv4rl/UGZkAzs2PSkoogLuLVmlmsWHcee57UtqKChjbP6RGD?=
 =?us-ascii?Q?MW6aawVfIcMIo6Eu+nXxkuB2ammVi76IEFWF9P3LVI+ZXlzrHuKm3GDGUmPe?=
 =?us-ascii?Q?KllwmQaIYOdoPyM/+xLfzd58U7iBGTi/r27UKZ0ykO/FWIKTrEsNdTx9vQHc?=
 =?us-ascii?Q?ckQP4A9lqEpCkeT3eIsQ+NZBMx0sLgY21GR3M0P+zPH+fkE+jOKnRIsqRJvM?=
 =?us-ascii?Q?SXkQ8ksG65pQdE/Ue96W0R54iIGxFYm1o/H3khLMRBjSHIsj21fEXPMpvM35?=
 =?us-ascii?Q?REr/0nHWZqIp3zrvIcok/TbclBNKkCOu7sOiytq4qPQgT5hc+lmC4obnE0By?=
 =?us-ascii?Q?F7OsWTdhqHfaO+EYNztQVgtVNbN2YjSLjUGGrJ0QudJjayXsYKD8Q3OIJe1i?=
 =?us-ascii?Q?LeI9RuuHtBT1If95SCoaCqi32rR9oPSs17PJi+k9wszWVuEMZTpTaYAy8qqW?=
 =?us-ascii?Q?yduEWOtCIKtJdNjugwAhNdV+DS5vTH8bcNovVjOf7bBK7WfQBuV4LLfYPciC?=
 =?us-ascii?Q?UHKFnqhxPGWzxJOyTET8HPPcgymP8M/eU/D57ead/bcGv3Ii8HePRz0+4GjL?=
 =?us-ascii?Q?ugxPLQP/diE15TTzO7P+wGFx5pCsnISBvW28cGfgcvQrkSGU4DaUnH+wuXsg?=
 =?us-ascii?Q?p85wqspNOnaqHALm+5us88NXX5w3654kv06F714Ul8AxArMzrvbkuQJEfWJ3?=
 =?us-ascii?Q?vVWoqJD9FrIRDO3JM/013MPcZujfpi/B0N3LiDAQRmbEKxlBzz1lm4OeiNl5?=
 =?us-ascii?Q?mOhUeiGDCda/5ZxI3Up6tjtO59OqXDdsXQGtwRFbYp6CIq4A74lHY2LjI8vt?=
 =?us-ascii?Q?a8C3tr0IfBeGsRnPBGyrEYIC5zOY3tLts8i5mw7jbss9rtYspIkZz86rkF+m?=
 =?us-ascii?Q?MzFy9NalLZICtYN+/yjMID6k3HBvQPXzULvbF261GwpthSKSPJR/BuSTey8u?=
 =?us-ascii?Q?5hBgIsNbJB0qrAajZFKsH7IEKMtBBKLUwaemxrM7m8d6R2F18Nbzxvy5dgJR?=
 =?us-ascii?Q?ep0jVABs+fpV3JxH/obotln6vwN1i2N6eawTpufOxvG3OsoHVtdIaVU7R6tI?=
 =?us-ascii?Q?bSmUHuOqNtQ1pPYj2vBs5aS0q++sb9HZ3X7GQigjLy00K7YU/JhdjgccarfM?=
 =?us-ascii?Q?XVz5uKrgytnJJPsS16jShiBwii2nliesOBih4Y3dcojAIdz4EfiWdOgj4VTY?=
 =?us-ascii?Q?q1JljECE6rrxi3IRngmU/dGPKJTAXyCV710ffn1nCOHhVr0/ewtEDhZ6oL54?=
 =?us-ascii?Q?x1aE9Jp7+pqIZReN3OLnot/pQ3najzgUGSh94S/NMOTrmEBmDaZ7WZGVZAnq?=
 =?us-ascii?Q?dAPqjyQL1+hgxLZE/SM2CLcCXhyFrHsxVpSqKNE8DNDXbQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d417654c-3711-4a80-f5cb-08d8d9b812f1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:06:29.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9szg5vvtgKbHFBBvdHjA6f/CV5E/yQncJbSNgAkroorUwMwt4Qj+vOVcdE+7TNRU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4308
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_10:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102250138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:21:04AM -0800, Hugh Dickins wrote:
> On Wed, 24 Feb 2021, Roman Gushchin wrote:
> > On Tue, Feb 23, 2021 at 11:24:23PM -0800, Hugh Dickins wrote:
> > > On Thu, 6 Aug 2020, Andrew Morton wrote:
> > > > On Thu, 6 Aug 2020 16:38:04 -0700 Roman Gushchin <guro@fb.com> wrote:
> > > 
> > > August, yikes, I thought it was much more recent.
> > > 
> > > > 
> > > > > it seems that Hugh and me haven't reached a consensus here.
> > > > > Can, you, please, not merge this patch into 5.9, so we would have
> > > > > more time to find a solution, acceptable for all?
> > > > 
> > > > No probs.  I already had a big red asterisk on it ;)
> > > 
> > > I've a suspicion that Andrew might be tiring of his big red asterisk,
> > > and wanting to unload
> > > mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
> > > mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
> > > mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
> > > into 5.12.
> > > 
> > > I would prefer not, and reiterate my Nack: but no great harm will
> > > befall the cosmos if he overrules that, and it does go through to
> > > 5.12 - I'll just want to revert it again later.  And I do think a
> > > more straightforward way of suppressing those warnings would be just
> > > to delete the code that issues them, rather than brushing them under
> > > a carpet of overtuning.
> > 
> > I'm actually fine with either option. My only concern is that if somebody
> > will try to use the hugetlb_cma boot option AND /proc/sys/vm/stat_refresh
> > together, they will get a false warning and report them to mm@ or will
> > waste their time trying to debug a non-existing problem. It's not the end
> > of the world.
> > We can also make the warning conditional on CONFIG_DEBUG_VM, for example.
> > 
> > Please, let me know what's your preferred way to go forward.
> 
> My preferred way forward (for now: since we're all too busy to fix
> the misbehaving stats) is for Andrew to drop your patch, and I'll post
> three patches against current 5.12 in a few hours: one to restore the
> check on the missing NR_VM_NODE_STAT_ITEMS, one to remove the -EINVAL
> (which upsets test scripts at our end), one to suppress the warning on
> nr_zone_write_pending, nr_writeback and nr_free_cma.

I'd totally support it!

Please, cc me and I'll be happy to review/ack your patches.

Thanks!
