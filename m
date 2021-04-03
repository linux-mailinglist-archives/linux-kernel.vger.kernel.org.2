Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7FC3531D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDCBMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:12:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234488AbhDCBMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:12:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1331AEvw001392;
        Fri, 2 Apr 2021 18:12:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FrhiRex82Ywa11j9opu96FR3U5QmibqcJFJTPwPLx6A=;
 b=kGgRVU4rkOn54qvu3HfxCF10OFWa+ZhXery/zrkktLMTjb+EEaqvGahnijWNth6/ddMF
 v9zoyuikzLyThhkVYB3dSbJ2gugDGIIm07PHLKPIQy8O3gs2WL+dGw6W7FFf4I6WvBUv
 IsnBQhBGzcOiMiVrnlbTJi2Zzag2j97pqas= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37p026d8ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Apr 2021 18:12:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 18:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiN75h30loIpHdzIBB3ZB4uxiRHPw4yhnCecf0dQoaUpeTbco2Nj0LqaT+HAa3g2eEGIQQfHSpwIctnlxuhj/l9qLDrnefkTOQ081pB8/q5p1zjh3qrazxwyZMUS4CGtB/+hf9iApKQwiDWiIfrPdzyLs9swNz5EW8Xcr2rgoap2Ynyf5N5AJcv2lB1jKiHJLqI/v1Icw05bb1EsNv57tp6qdUngRViwUixCIiUmOdfsTdZAPCinZTQ/7m6SbE1lP3OL3f9cjbn3nZTPRNHqpHQXbjXOQP0rveR5yyC4MPCTyuLSXH97+Rl+kLUHi42ZSiL/VoN+slJ0pfEXSvKQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrhiRex82Ywa11j9opu96FR3U5QmibqcJFJTPwPLx6A=;
 b=cNg2k00uhXadJpZKQL26QdoA1v31umnRNVY22CfOPohMupziJuI2LC+VM3rcoKOJkFbHnTXXjPVafUpLxcDlXCa8aFweHB+d4qtR7X591Ms65sX4I6rf92h69HGhR3aJK5wo9wsV0jvxpyjVAJRmL2qFAjvdwgq1WT9ZWTizuTpXxmUfasX12C+tIpBAhNxZJCGEjE+fAvtXXY1OBzHYdsf+a9PyRALhcmVafXR709+Ioy7DRd0zbVnBgW9NLAgPGTiSZpmhR+IA6Z+4oTg6kgxy5n4dCQyVJhe5qmUzzu0z1Zl+rAsnfFJPB2WlCDDMtVEyLS+xiSLlF8jHQDDA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR15MB2463.namprd15.prod.outlook.com
 (2603:10b6:805:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sat, 3 Apr
 2021 01:12:25 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb%7]) with mapi id 15.20.3999.029; Sat, 3 Apr 2021
 01:12:25 +0000
Date:   Fri, 2 Apr 2021 18:12:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in
 split_page_memcg
Message-ID: <YGfA9BpZ4KepzAFA@carbon.dhcp.thefacebook.com>
References: <20210401030141.37061-1-songmuchun@bytedance.com>
 <5c183fe6-637f-151c-67f0-fe19a0ce3356@huawei.com>
 <YGU/ZojpKXXK9AnU@carbon.DHCP.thefacebook.com>
 <20210402180454.c28395d38396b58659c15fcc@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210402180454.c28395d38396b58659c15fcc@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:5d24]
X-ClientProxiedBy: MWHPR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:300:16::33) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5d24) by MWHPR13CA0023.namprd13.prod.outlook.com (2603:10b6:300:16::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Sat, 3 Apr 2021 01:12:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f21445-c265-4beb-e0aa-08d8f63d8acd
X-MS-TrafficTypeDiagnostic: SN6PR15MB2463:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2463EEA21BA27FEA7744407DBE799@SN6PR15MB2463.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 541z7nYp+NjIdqkRXLUSd7pv8QEluAlW8FBzeTF6X2+ELqX7W2XqHiqSssG50cJ0a6pJqDMlVpSumPJ4iQuOcvVmQbuMOAgPXZVarWy5sjZdH/vT43dKaUHscPaPo+kD5B/sHt+PVs0KesMEg7QlfHNbh+udvDqCM5JxB4Bqt9vSyKJ2YfK56c5lPqoiI0NaEblQG0tjLmCHnPQ9Zn6RxDIoebJnEOwe4V2WXe9eTFHCCGVbes4Ry2x5iKStOE4lFdh3OKdYUKZkHsT2dYMphGiz7/tqkGBY+CLfZm4J6Tah6rP07z9AXVCbFe5c+Ut/FV6ZlbLIoHCTVYHF21FZezI9YNjDxlAcOt+rpZqTGsI2zWceFkx9Vt9AY79/9KPgnrm1A5fgCvP9BtYS+/yEoV0FW1esbhyHT/B/MisyjmehL1lrA+i1a5qkTsvtssL0GZR6/w5csBMaIElB9lvK7RsMccLa5w+YLrgdgqM3z9+PJZ2OVVtVOZ3CJ9s6d/jshCQUhRnSiy5FADySQjDqblZjpha6HlqVJlG3DzUPA4H2YKatLYr4D1bTuvD/51744ZiG7Zbm7gGAaKWHv99A7NMO4J45jw65N4L2Jm1RT+eDCWymC1/qyCG/fWU4afQwONoOC+qkS5dpDR4VqJ1ehw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(39860400002)(376002)(8936002)(316002)(38100700001)(7416002)(4326008)(54906003)(2906002)(55016002)(66476007)(6916009)(66556008)(5660300002)(83380400001)(9686003)(4744005)(6506007)(478600001)(52116002)(7696005)(6666004)(53546011)(186003)(86362001)(8676002)(66946007)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZKHmxo71+KNXIKgXlGwboP7WfAXHJTIjNL5O40NAPKbJaTM0tlRLuKFJ0ltl?=
 =?us-ascii?Q?Ead7gD0gGVcfd4tVaxmgVxlupG+woafV3JhxK9bhirjMcAJNUZPq7ub2ENl/?=
 =?us-ascii?Q?ZX87iOmocjaTUWgVVJ/NPWmM0eBl1UVX4S+0MkWsd3SgYwb32mDcRcfho0qc?=
 =?us-ascii?Q?yRRqGe1pi3+0PHzWutw+KfeVfGYhprEjg8DV0dQoQ6kEUtADMM3DAoXNnZMa?=
 =?us-ascii?Q?afDMMxbFDYQkrU6H0M13EOU4EFF9KpLdKmikVAX1R1ejj8WB+JELIWCaw1Ey?=
 =?us-ascii?Q?+26jUoXdfeM+//KNfFHCavUCxSzOQKBJ0NxGTLbo/zLAs8wS9uAWeKRh9aRr?=
 =?us-ascii?Q?+qPNY8zGv/hShILjZn5GlpkVwpHIB2wrO5uqYVv0v7EWS2p+7Y2DPhLEwLxA?=
 =?us-ascii?Q?eSDSIQP6Du5ySaOwKgNOv2Bo87tq3gdRPCUyMtOl9p3qxc/bgC5LObneTpuq?=
 =?us-ascii?Q?4dGKbNPbg9/y+11EYhDloRo+ij2mOTDbOiDH+aRazVpogETS3Mlu+jY4aAVi?=
 =?us-ascii?Q?09tcD7f3M7n11uo+K+OAKg14FoB7VWtvyglfhx0Wk2eyoFS/Or+HPHqBFNYo?=
 =?us-ascii?Q?RRD/0/dxIl6OxjmV7YP9h4zfDZp5/U1WWrfmXnHoP/MlzlBfszVe9P+Zc7+C?=
 =?us-ascii?Q?/Y/T41PMu4WwqjngsWW/JjFAQKNNsOZCA9FGs4tBrgW8erb/h4Hblm67f52y?=
 =?us-ascii?Q?DfoPyFeOC4SLH0f62WfDvLvcac1Xu9BdGalfdblvPaByPbQHjGDCkP9mu/1N?=
 =?us-ascii?Q?kNjOobJyqWM66m43Tlnp5YryLSSk5OYDp4s7OBuVfhXXn+tF+mrvFw3jG32u?=
 =?us-ascii?Q?jpMDNKnWjIQSftKPGfUcWPcU6pK1Cq7GYiwe3epEgJRpxGnDTlRkHBvqYQiW?=
 =?us-ascii?Q?Xi5x1+W4XdnZznjfIevlJzwHysiRowQ7cZgbdsSED9h58IXyxSV7qvWTkf6J?=
 =?us-ascii?Q?SGjXcOYub9mkAPIJVi03n3gEC52BLeMAildlJPpCz5FByOl49GcGm2o0i0w9?=
 =?us-ascii?Q?ZP8pyqZ39BrHFyj6djwm+/EppTqejzUZNl1VfN3zZt0G2wHU41z2y6aVRJMo?=
 =?us-ascii?Q?LsJK8kDSyPfSLbPJLLHBbf5pmGVgTllmvojFn/NFodYpGqfqQ3og+hW3u3Ab?=
 =?us-ascii?Q?9G8zwoTHbRB8/mcD/HPX0r0+5rj0DMRpNQctpyhq/GrLHbqHRUK8JkaE8G4h?=
 =?us-ascii?Q?CC6WoTsROEJ2d4aihNTJ2jFmvxkLKgAcJTkQ70MKQjG6Enz/jEMQYG9EnCMf?=
 =?us-ascii?Q?WJxobzTm+zfJHjWEVauYHe576eavvBbReP6xLY+rsF30ENODJZedLFNWYNVr?=
 =?us-ascii?Q?pqF1qSmM8nOTJFO17gZj7hREe1RCfL3aDKe/DKgKOhaGCQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f21445-c265-4beb-e0aa-08d8f63d8acd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 01:12:25.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Vn+5uFQfz4Ep1kqB6gdZMVYYZTR7014L0zxSVereDQd83y0n8ILn2oSzPVmlcbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2463
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2QVRGmUEgBPS_AFSJXn_iJuL6r-A1-Z7
X-Proofpoint-ORIG-GUID: 2QVRGmUEgBPS_AFSJXn_iJuL6r-A1-Z7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_16:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 06:04:54PM -0700, Andrew Morton wrote:
> On Wed, 31 Mar 2021 20:35:02 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > On Thu, Apr 01, 2021 at 11:31:16AM +0800, Miaohe Lin wrote:
> > > On 2021/4/1 11:01, Muchun Song wrote:
> > > > Christian Borntraeger reported a warning about "percpu ref
> > > > (obj_cgroup_release) <= 0 (-1) after switching to atomic".
> > > > Because we forgot to obtain the reference to the objcg and
> > > > wrongly obtain the reference of memcg.
> > > > 
> > > > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > 
> > > Thanks for the patch.
> > > Is a Fixes tag needed?
> > 
> > No, as the original patch hasn't been merged into the Linus's tree yet.
> > So the fix can be simply squashed.
> 
> Help.  Which is "the original patch"?

"mm: memcontrol: use obj_cgroup APIs to charge kmem pages"
