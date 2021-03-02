Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA00032ADEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360192AbhCBWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1837100AbhCBUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:39:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 122KbMi0016031;
        Tue, 2 Mar 2021 12:38:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rANSTFAf1tR9b2Y1s8Le/uJdqwBrF082IUH1gH4S59Y=;
 b=e4KVr0rpzH9FaZSlcgT56mpXHzaenU1Rm474UGL0l8fynrRB+KkASWsKGfJi0rxJ9+oz
 wZSjkmEMdpM/nMQ9Ep4tOyJ9RBL8aEPkF84VbeqOuhhbwz6Q9eNiAXNkoaP4qlbgTvTY
 U5rHUy3bzAcqhf6uSrmfUxOsg+8PkJJvEc4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 371uu3g9hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 12:38:07 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Mar 2021 12:38:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePMV4JdLWIKIvv4KolBg0NLH7ccrkuVDgLOoyXEhcwlwOs7E8vz5mfq0ZRz5t2SqJG6+u6A+Fz/WcNj1JGkH0GvFP/3QDSrw9g1GBD5IAkhbF4rOmNuTAHs5OQ/9uU7+UxGWr4WreByrQA8icw1z6sIkVOSWJ1wDt6FDB4NTHfuClyN0njBOvCBl8Fk02R9lYwMW5SN4VHeX3azIhMJ40jcWkAMmQpuP2ThKnWK4BWcm8X90GQ/smlu5pfEuED7s1nD/+Mw+li7rwIhT7OGZG9x+KdAdHjruGYhoycvL8WBngG8jzdHtZyyaLjmxNag2yPzO0wnB+Ew2nDsg1J0POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rANSTFAf1tR9b2Y1s8Le/uJdqwBrF082IUH1gH4S59Y=;
 b=fL/h+8tPM+YmD8p2QRfQuDhAmHTM7G3zBybtss04ThhwuPLRIyZv8MjVG9Dh4NMCuYgP82W8Wgw5OJEVQvA2OEifkjZzXgGApfPQfLZZhqi6zfnxafJfsMisxBLxywYggoNF0/ejT5gJL/HLlPKbuwNkmEuQumPqvKf59IZ1Vj7JfWHWQe3x/mdv7nPAjikDxviS6qNADvLC4RCa+It0wgqwNOQHBX7DF8bKNSqVGWCtY4K3CKpuneD6VpYF2GLslM2jpxcRSEUvKp0Yto2NSFekeqwY9S7vyErpyAIQlfyZfdnaWCr3FWS82H5zj/cNJI82lpbSJgEIoV08G7Z1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4327.namprd15.prod.outlook.com (2603:10b6:a03:358::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 20:38:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 20:38:04 +0000
Date:   Tue, 2 Mar 2021 12:37:59 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>, <hannes@cmpxchg.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: memcontrol: fix kernel stack account
Message-ID: <YD6iJxEDzLInH4tD@carbon.dhcp.thefacebook.com>
References: <20210302073733.8928-1-songmuchun@bytedance.com>
 <YD6I+DLH0SLnSgo8@carbon.dhcp.thefacebook.com>
 <YD6TAMSafzrnl+Qj@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YD6TAMSafzrnl+Qj@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:f532]
X-ClientProxiedBy: MWHPR21CA0069.namprd21.prod.outlook.com
 (2603:10b6:300:db::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f532) by MWHPR21CA0069.namprd21.prod.outlook.com (2603:10b6:300:db::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.9 via Frontend Transport; Tue, 2 Mar 2021 20:38:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27fc3ac7-0fc3-4d99-6eb8-08d8ddbb1416
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4327:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB432724E9F98B92C0EFCC0F16BE999@SJ0PR15MB4327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: De0yn3amRccmnRAuhBhKglMEvQnwqZDrlZzTCN79zlcBorWXRNZ+iddl90DPOHwvlIkHcM+8xc0FtwEzDX5vPdz5TzCMRnqsQSfaVISraVg1kfqjMHxakI6ZAXcJXWm7DLww3ptxO4UxkGVTQClD3qrQ6ENPd7ekEUhA9jQRoHymtGsDHtNijX2MtfseBwTc7njHQ3cplIBz4V0j3SeV4s7wbtNHkKr2YprHsxtiL+ryxXpMP722tJHH4jiYExWnKIFcAkapKkBiiqFiN64McxWvqYipql13hiDpn97gQR2P1gtjnKbmtucZVTTUIEOH/kPTg3OaJfwSW8uZDtmnyem/MFef2Gtq+tWbfo9vC5j/GHXH9wkehoWCtWtEvgzPYslxuM+/t/2iKonsZhpTytIgIq05pNGA1qE3/F5/diTLO69YBp8CsUjSJTFRnDSsQTuYMolrvy+PvgSD/LvYm3RgT+/YkGGMqlQIe4891hCrz0QTxxO0XtgUfmQFbajnIpo0e1EnAr7/iCq29suJ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(66556008)(86362001)(66946007)(66476007)(8936002)(316002)(8676002)(15650500001)(16526019)(4744005)(6506007)(52116002)(478600001)(7696005)(2906002)(83380400001)(4326008)(5660300002)(186003)(55016002)(9686003)(6916009)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I3tT6kuA3s46DI3vqCaAIx3oYkVWgEoC1O9TsXJnYamVPXcgeafnbsUiMFkL?=
 =?us-ascii?Q?bovN0wU2Xd3FFvk9Cq3sSS1yuURuwzcRcRKpXRgw/ZP795aOCP/Pn7hoKUFs?=
 =?us-ascii?Q?Yp5fX3A5h3tdhpRwyEBg/USlGxcXT+MDlsIJgR/baG2lrIL22ln9SASu0IV2?=
 =?us-ascii?Q?xDKNxaV3ictrTIy6eYYa91OZNp67iHNRB/fQ0IkQxrGAmwcP7fhHcdmGfHts?=
 =?us-ascii?Q?4cAz0CBIDFLQOdxB9WeKwtHE3o3FA05osUChNcZ0gG5S+QGwiMDwBVFg+9KU?=
 =?us-ascii?Q?QsOSE5YB3bi2Q5WoQJc4sl0ziZPjYmZN1F1pGgFHzXhfj3Fw0iFZpWv4veN7?=
 =?us-ascii?Q?Tnip8R3VFFgQO4RoewWQ1evJhBzAwNfBLVDmKNDkjHOugp+vSCGgp6fseowk?=
 =?us-ascii?Q?TNwurfrAhs/Z9l0+YmnFtPPsBPr4db50KF/90M6zgbuRtQxt93A2LSeEpV9F?=
 =?us-ascii?Q?pavtLmpbKkU9kvQmCRM/QPbL+lfUMHnuM11lQXgG5eatgp/BXVkt4ZdzrEYU?=
 =?us-ascii?Q?rZzpmahhIcBPCJUyWfwYGnvbsG8GswH2oj86KoMa8SLjD0Agd59FECcG86vP?=
 =?us-ascii?Q?vbeBhC+IBerPIKUQKPRUVsa8J6IPfhe/YBsXaT91gm7r/uxcGhLiARZiWIpu?=
 =?us-ascii?Q?rmFHU2z1UAKU8s4TIQGv1clVqMnLIF+gK1zy2D6Oga/kp2Pa1AQ5Zo8sxcsi?=
 =?us-ascii?Q?l8VlnImC06Z0maF2b0ckMK8QV60UbFckcyMPBdy54Q2r+ab9QaItbZUGzzNS?=
 =?us-ascii?Q?D4ai1cLVjnlxMN7sxoT0QuILXFqxQTArYH55pfX5pYVE84zDOhi12X9rc8vj?=
 =?us-ascii?Q?0jcAKjidxALtYR28sHOcoSs2tkVbSGYKgzNMBng2sIUzRKYDErQb2Z5ch7Mp?=
 =?us-ascii?Q?fvRF/PJcLwKKZ7kuGX7IlxxuQNxlWOErP4gaV72BCx04IwzM/y0pl06RhjAJ?=
 =?us-ascii?Q?wwWgoBeyPjX1hBRip2L1mbvYbjcPyk+41hR0bSulU4Rpek/FRBBOavLM1nE3?=
 =?us-ascii?Q?4lHOPIo7N9wZNhTGZ6j574vhFLoUwC5Be+FqjiNU/ZjC7t+f4yy27pVnTye9?=
 =?us-ascii?Q?5PEtuc/JruhjSqJqtL330cRD8WraeL//X3lov69GKS3o8/EPQfBzB0jdp4OL?=
 =?us-ascii?Q?iGfBDsBGJ8iTrv86+3HAjg4y9V+/kyuLRepz7y2VrsRNsNXm9zIV+vBlHF7D?=
 =?us-ascii?Q?MxvXtTfxSHeXkVdIlbVM8tpUT8WjlgIYhBnwBJRZRON2AnUKWghhBFwUM/1c?=
 =?us-ascii?Q?mm25JNeGijD2mIdjJ52fx/NeFlEPfjuU+ZIODC6uCntAhQm2iso5eIUdb+8Y?=
 =?us-ascii?Q?K8o88Iwy8YdmplBl2NL1xJUDJnTwueLU3LlFKRFOCW45sZkXlaOWW0REzZgH?=
 =?us-ascii?Q?9j2L1kY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc3ac7-0fc3-4d99-6eb8-08d8ddbb1416
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 20:38:04.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdNCyQWFsy0TmYEproKJglopcDnmWox1Thh3QCWAObOPxdp5DPyal6k2BofMQf3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=838
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 08:33:20PM +0100, Michal Hocko wrote:
> On Tue 02-03-21 10:50:32, Roman Gushchin wrote:
> > On Tue, Mar 02, 2021 at 03:37:33PM +0800, Muchun Song wrote:
> > > The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> > > are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> > > __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> > > mod_lruvec_page_state() for each page one by one.
> > 
> > Hm, I actually wonder if it makes any sense to split the stack over multiple
> > nodes? Maybe we should fix this instead?
> 
> While this is not really ideal I am not really sure it is an actual
> problem worth complicating the code. I am pretty sure this would grow
> into more tricky problem quite quickly (e.g. proper memory policy
> handling).

I'd agree and IMO accounting a couple of pages to a different node
is even a smaller problem.
