Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29536285B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhDPTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:10:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235715AbhDPTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:10:05 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GJ3w6V022553;
        Fri, 16 Apr 2021 12:09:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=OtWVNQM566Vj/GK89EHAdlbgZDCSHEgzkR2Hk+hbjnI=;
 b=CyTBB8X6p9JofHYjJ2/bVA6WCuPZfdsiJma1NwQJDZNSU2BbnvW+IHWlMeUE9EswrA+g
 k70dwENZh+XNYn5F5voDvddoNNsOoYOyzvZch3dsLX2tEWOQE1+HfK9+BuMevrYCW0Vf
 Ut6Vv4t+aHmbxuNMTk0Nxv21bTu7ikGNu44= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37ydj4s5xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 12:09:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 12:09:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft03HBsU9vRrvdsN/tjWmCnsnAR5zKbny0u7n39Vs53CmEcrwCyYrzAmWCuioejhVhXTIoFiIc0HY8H4pImuRulW3D7+9UiPHMOnxj7MXF0hZ2f1uQKJU9bMDEV3ep7m1CJZ2qbPpenE4whc4HwS290k4jWkFM/T4K9e+L9hfF43X9Zjcd+5IIQEkmvTkiDw6m1ejYzZyicX5ag2iNbPRRAjcmheV0cf7b7unnaQrvTpzDcpihjgYFb38nmlOqCUfDX0Fj8yvRXKYzUnfqD8vmq4e/E8QVjyDUdNlmORrpvZFGLQRiLMv0rsEBd3Io/Ci18gm0YOaLsQW/nBJZhn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiJVxWNz8icZzgzXQeJfOJz5+i/FYoPmo6cBjWC4vmM=;
 b=HNQlxSeKmLIPQWtquv4BZULE2IixP/GWlOjFvskQvO6Hy1KsmSfYxopqkXTLm6kW3p2PJzWpYhUyVH1QYXNJAVTXpGnuxK1nJhjq2b2wZc6Z6fh7PmL2AWWNF4pt3ZF/MOxTnfutBVvdeOf6Uj+02iUPOffnTGTvIyoNAizjaD7c+uPsq2lR8qcDBD6r8OjDoFZTKR4hdRH5yV7/hnD0sq4XVpyAWs3qFGtTRgWncYdQ1+jo8ow+LW6bWqbqi6XSKKcQbBrYsQg0Y0NPe9WQ6JhORyQeQW87lVzrIedvpni7h0yrgbYZSvc9y0NNavYHcGpq7E9NkUunGTK4cpZTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4645.namprd15.prod.outlook.com (2603:10b6:a03:37a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 19:09:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 19:09:31 +0000
Date:   Fri, 16 Apr 2021 12:09:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Pratik Sampat <psampat@linux.ibm.com>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pratik.r.sampat@gmail.com>
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHng5nAPSLJHnRY9@carbon.dhcp.thefacebook.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
 <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
 <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
 <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
 <YHnYqMdyYtIdab6n@carbon.dhcp.thefacebook.com>
 <09a8d1eb-280d-9ee9-3d68-d065db47a516@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09a8d1eb-280d-9ee9-3d68-d065db47a516@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:3149]
X-ClientProxiedBy: MWHPR21CA0048.namprd21.prod.outlook.com
 (2603:10b6:300:129::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3149) by MWHPR21CA0048.namprd21.prod.outlook.com (2603:10b6:300:129::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.2 via Frontend Transport; Fri, 16 Apr 2021 19:09:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82c800f-cd28-4a01-e84d-08d9010b2a26
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4645:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4645D15641BF9BC131626931BE4C9@SJ0PR15MB4645.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hy9eR77tYAM4dV7yDZTtDYlS2rjTxjgBW0V+D85V4tmtSw1tDxsFNId5LfuwKMn1+yhHXYo+n2/JnC4CwURO+yccXbjZsPi13yJ4gxYg/IajJ8zzld/k4seF0CFAMKHlNf53P7UH0WNQkoLm1X/Tr1G6+JqfSvac8TMgoRE3MyWFzXaHbIhR7YXiRmOeXUONZfLqmI9uMR2SobdQoeJV5Eua+mOXK6yBC93+gLUmOmP6osNS6iLpBXdoZg/1IUpmSqmOGiwhsSh/L+U4LweBaHHIA1Dx3Y+CrpOur+sbLlpVbuLkOf3Ek2uZSd6ANKaAnoXttYmh8HVm7WMAkx32vJ/p9MrAyF2XqjaSIFVtYpPkjlvB19MMjatarPrNNwMisP0ewJcFUXzude+UyfpZaAK152cnHyny8FPUqnV1U0jQkDkIZVCg+2yCVu1UreuBox564zFyU8Kr9WlCOYA+5mj8V77sB887EKyJUcHXO1AWEWGp/+VIcHRxnvPQFVjRxc+P6i7xpmNDZSJsfECb9DRNxEWtFLywJ1hUgUyWSZWztGuRdz6M+oxZn4xO2Y/u4ZRKuwXyRlU1b7SSggf89/hz0K6bLVBrFwvfhE/2ptA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(86362001)(54906003)(316002)(55016002)(478600001)(83380400001)(66946007)(52116002)(4326008)(8676002)(66476007)(66556008)(6506007)(38100700002)(8936002)(2906002)(186003)(16526019)(6666004)(6916009)(53546011)(9686003)(7696005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?UYJY9ind89JYs0k5T1JVHvDjO44l+zI2+QdW/gBcsxfpAOS2IroORZLN2Y?=
 =?iso-8859-1?Q?6hLSvidTl0DE5+LnB4h89kP+qaMZBxAWMauvOOqJwFT5THYtLp02mck3k8?=
 =?iso-8859-1?Q?AP/iM028hNmSp0K5JvbqCs9UkIbaLM/LftCEv8FQveeJbr7BgFizGwH04K?=
 =?iso-8859-1?Q?julQANp2hef5mJCmCgGrVoJzjascgUX0+152OX23E+FWWRGB/Qw1kXqM3r?=
 =?iso-8859-1?Q?rhkb3HSyaTFgZMwK0HMB3fDWJRZPXvQJ/fV2ANY4fvCSc7pi/j93gBwlUH?=
 =?iso-8859-1?Q?f2ZtdoPSOkGdqGGbUlGNQmwLwoqFGpJcmVXTNmaPkn0uLlZQq3xR4a4ZlL?=
 =?iso-8859-1?Q?a/8JGNjxcB8KFBUCFpAZJXQvoYGV3tUMCNqTsOaxmMCDcUgvc6yHFb3cUL?=
 =?iso-8859-1?Q?BVuOr8HPWSoLE9hZTpnac0JG0ei8OuJt+yU8k1DX6kdYtEY5aiWNx07rOd?=
 =?iso-8859-1?Q?7G3g0B3xwJUJ//yM5JtIFpI/vC+ids7HX8B7lF+uHzbuewdyOwrTJbe/zp?=
 =?iso-8859-1?Q?ffALMm333DBSQaV6Wh+w/VZcnPsxdyUlwYESOGaotb2K3zTxRPs1IpK+0g?=
 =?iso-8859-1?Q?3jOgaopu+iU9DcCKpxL4hObZe9bDDoXAVBdgsWDbIFE33R/a/N6j6VMjS5?=
 =?iso-8859-1?Q?tuM4RT3Qhqa6cEXD3gEQHdQBjxGr0ZuI/JksBTHQiZRy0/KQSrhNNdkLn9?=
 =?iso-8859-1?Q?NwXmMTGir7rerfRK8MJmxz9ErP9IspK8Ma+oY7b0UsNEysVs8Nn+w4zmXW?=
 =?iso-8859-1?Q?9LX0aHV+5R+fMHE2ZkX4IawlVOZXV+8DhTGl/qunBHSfyrUMiKzvtBxlTC?=
 =?iso-8859-1?Q?2p87L51zVeJpFPDDwBhosys+CZ8wf2DB+7c014S0zx7zCgO1biGw4jEfzW?=
 =?iso-8859-1?Q?ctCv15raEAWT8yEbcgCD8Mg9DR36+fVhaaz75/Bi2l8sQrfHmqK1Q+q6gM?=
 =?iso-8859-1?Q?w2rfDfow6PxbBMEj/aNTAlV9YRbs1c/WgRBY6E1jjbHzmwmtsP5S/3b4kd?=
 =?iso-8859-1?Q?Z0g6zRjIL6JpsaYjKwT0tSlFjlGvPDG3eOj5JgZGpUymxil2mo2PFa/913?=
 =?iso-8859-1?Q?HdMIqydaf4nIBOHq93oSfe0aPnQWYNquyklvPCVi6Kx1cQUogBGKjYiJ/y?=
 =?iso-8859-1?Q?BLhjLhP//bKkwJo8fDkDwlxSU0txd4pGgy+IpJ5QVdLF7yO3gHQPHFznUV?=
 =?iso-8859-1?Q?M/QGV3kim/a1321PPd28UwuvQYarjBBJuLA220i6GiC12lU0O5Qq+FU98d?=
 =?iso-8859-1?Q?shxF233KO5S3gLJcRLnFPouS/eJyTPfLozZbyh+EBbGd0bSNENsWljgPvt?=
 =?iso-8859-1?Q?/fc1aXX0cNvNT4hmpp4pxF+Qwxq/FuHSK9c+Ii+gRMjzHhBXLxc42qffj4?=
 =?iso-8859-1?Q?XukfYWXymJyBLMEzxTUqLtGTndUI1erg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e82c800f-cd28-4a01-e84d-08d9010b2a26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 19:09:31.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxujj7m51tmITU/OgqeKqz0OxF4SZyp/8U1xdmGtS/60AVPmD9YSy/Uqi8/Ddqjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4645
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1GWYCl3djMkiQqsaqPF_cRbU6DcPn8F-
X-Proofpoint-ORIG-GUID: 1GWYCl3djMkiQqsaqPF_cRbU6DcPn8F-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:11:37AM +0530, Pratik Sampat wrote:
> 
> 
> On 17/04/21 12:04 am, Roman Gushchin wrote:
> > On Fri, Apr 16, 2021 at 11:57:03PM +0530, Pratik Sampat wrote:
> > > 
> > > On 16/04/21 10:43 pm, Roman Gushchin wrote:
> > > > On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
> > > > > Hello Dennis,
> > > > > 
> > > > > I apologize for the clutter of logs before, I'm pasting the logs of before and
> > > > > after the percpu test in the case of the patchset being applied on 5.12-rc6 and
> > > > > the vanilla kernel 5.12-rc6.
> > > > > 
> > > > > On 16/04/21 7:48 pm, Dennis Zhou wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> > > > > > > Hello Roman,
> > > > > > > 
> > > > > > > I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> > > > > > > 
> > > > > > > My results of the percpu_test are as follows:
> > > > > > > Intel KVM 4CPU:4G
> > > > > > > Vanilla 5.12-rc6
> > > > > > > # ./percpu_test.sh
> > > > > > > Percpu:             1952 kB
> > > > > > > Percpu:           219648 kB
> > > > > > > Percpu:           219648 kB
> > > > > > > 
> > > > > > > 5.12-rc6 + with patchset applied
> > > > > > > # ./percpu_test.sh
> > > > > > > Percpu:             2080 kB
> > > > > > > Percpu:           219712 kB
> > > > > > > Percpu:            72672 kB
> > > > > > > 
> > > > > > > I'm able to see improvement comparable to that of what you're see too.
> > > > > > > 
> > > > > > > However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> > > > > > > 
> > > > > > > POWER9 KVM 4CPU:4G
> > > > > > > Vanilla 5.12-rc6
> > > > > > > # ./percpu_test.sh
> > > > > > > Percpu:             5888 kB
> > > > > > > Percpu:           118272 kB
> > > > > > > Percpu:           118272 kB
> > > > > > > 
> > > > > > > 5.12-rc6 + with patchset applied
> > > > > > > # ./percpu_test.sh
> > > > > > > Percpu:             6144 kB
> > > > > > > Percpu:           119040 kB
> > > > > > > Percpu:           119040 kB
> > > > > > > 
> > > > > > > I'm wondering if there's any architectural specific code that needs plumbing
> > > > > > > here?
> > > > > > > 
> > > > > > There shouldn't be. Can you send me the percpu_stats debug output before
> > > > > > and after?
> > > > > I'll paste the whole debug stats before and after here.
> > > > > 5.12-rc6 + patchset
> > > > > -----BEFORE-----
> > > > > Percpu Memory Statistics
> > > > > Allocation Info:
> > > > Hm, this looks highly suspicious. Here is your stats in a more compact form:
> > > > 
> > > > Vanilla
> > > > 
> > > > nr_alloc            :         9038         nr_alloc            :        97046
> > > > nr_dealloc          :         6992	   nr_dealloc          :        94237
> > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
> > > > nr_max_alloc        :         2178	   nr_max_alloc        :        90054
> > > > nr_chunks           :            3	   nr_chunks           :           11
> > > > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > empty_pop_pages     :            5	   empty_pop_pages     :           29
> > > > 
> > > > 
> > > > Patched
> > > > 
> > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > nr_dealloc          :         6994	   nr_dealloc          :        95002
> > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
> > > > nr_max_alloc        :         2208	   nr_max_alloc        :        90054
> > > > nr_chunks           :            3	   nr_chunks           :           48
> > > > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > empty_pop_pages     :           12	   empty_pop_pages     :           61
> > > > 
> > > > 
> > > > So it looks like the number of chunks got bigger, as well as the number of
> > > > empty_pop_pages? This contradicts to what you wrote, so can you, please, make
> > > > sure that the data is correct and we're not messing two cases?
> > > > 
> > > > So it looks like for some reason sidelined (depopulated) chunks are not getting
> > > > freed completely. But I struggle to explain why the initial empty_pop_pages is
> > > > bigger with the same amount of chunks.
> > > > 
> > > > So, can you, please, apply the following patch and provide an updated statistics?
> > > Unfortunately, I'm not completely well versed in this area, but yes the empty
> > > pop pages number doesn't make sense to me either.
> > > 
> > > I re-ran the numbers trying to make sure my experiment setup is sane but
> > > results remain the same.
> > > 
> > > Vanilla
> > > nr_alloc            :         9040         nr_alloc            :        97048
> > > nr_dealloc          :         6994	   nr_dealloc          :        94404
> > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
> > > nr_max_alloc        :         2169	   nr_max_alloc        :        90054
> > > nr_chunks           :            3	   nr_chunks           :           10
> > > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > empty_pop_pages     :            4	   empty_pop_pages     :           32
> > > 
> > > With the patchset + debug patch the results are as follows:
> > > Patched
> > > 
> > > nr_alloc            :         9040         nr_alloc            :        97048
> > > nr_dealloc          :         6994	   nr_dealloc          :        94349
> > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
> > > nr_max_alloc        :         2194	   nr_max_alloc        :        90054
> > > nr_chunks           :            3	   nr_chunks           :           48
> > > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > empty_pop_pages     :           12	   empty_pop_pages     :           54
> > > 
> > > With the extra tracing I can see 39 entries of "Chunk (sidelined)"
> > > after the test was run. I don't see any entries for "Chunk (to depopulate)"
> > > 
> > > I've snipped the results of slidelined chunks because they went on for ~600
> > > lines, if you need the full logs let me know.
> > Yes, please! That's the most interesting part!
> 
> Got it. Pasting the full logs of after the percpu experiment was completed

Thanks!

Would you mind to apply the following patch and test again?

--

diff --git a/mm/percpu.c b/mm/percpu.c
index ded3a7541cb2..532c6a7ebdfd 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2296,6 +2296,9 @@ void free_percpu(void __percpu *ptr)
                                need_balance = true;
                                break;
                        }
+
+               chunk->depopulated = false;
+               pcpu_chunk_relocate(chunk, -1);
        } else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
                   !chunk->isolated &&
                   (pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >

