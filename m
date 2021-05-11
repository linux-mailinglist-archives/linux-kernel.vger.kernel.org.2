Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7532A379BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEKBOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:14:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229934AbhEKBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:14:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14B19smX004925;
        Mon, 10 May 2021 18:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fhQ8I+JsGruvj3V5rzSQpjXHr3O/X9fQJIlVvGEnKzI=;
 b=eCDYcF/IUnUsApvODA2sDcU0ovLoZyCDIhLqzQX0KR5y5zYHVM6Fjxp0siO34XOwnz+Y
 qHvpeVXI0VqsJdhmt62uB0+UQ+8vVBqNFzCeaTu5tEgAm1sR75mVwKeOUet0fq5/8rRr
 D9z5om1k2hZdhijZux4W13wGZsnnHaaUqQE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 38fadda1bb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 May 2021 18:13:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 18:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK2VnuOGBB2JBaoAnz6WD64saitRGpD+Qg6PdECbN0D7BEigpWwF5yotq3IUGNkuOXTzHCmz3Eo4zGpRXm18N2X+VD8lMAvfV3mzqACzDphG7w6FIi2atLiP3S+QGZQ4UNYSiIslBntq11swDcJ5nC5AbVBaSJNbFwW/WtO/m6iYt4YS8rbOjsNpUpNePEk54ufGmi/D34KwJ0bu8x9DvNCDSzWWJUqt/NfXng4WgpDt6NTprodCy/WTUkWZ5u3ArYDSSbbEu9WKV0jIRxLycEvVMdUNKNnHIPoASzQRbhV29wfNErVU3o2jWvDt5Zx88Jz/DOJubMJzrfiwarDmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhQ8I+JsGruvj3V5rzSQpjXHr3O/X9fQJIlVvGEnKzI=;
 b=bLTy1JasRO0lfrP41q5NC/f+GM5/RGborJ9BuyglM38dBiMUd+/Yd5scTq0BfxMPofbMxISJlinlsHq4pbodWn+KMuCE4JBT0910WM1eB7T1PZ9YDlN08rWnuN5jNUzBIXUmjANK02ZcBZha80lwfJi6UMrerQG5E44u8gCFJrUjpgl82fi/ffgfNZ2kdZ6nbjHdpdaFDRhwmaDouSznbc2PEk71cYqBiY7SSY/0ahQkqUzCAy/cLNi9KX5vUhIJWhFBMPoBlOrFvMvFUiJ9JWRB4JYg2zaT6S4ETqnyNdWRWnCzx/TW16pNygzduTZwhTM7kjjEuWozqZhSvJkfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3479.namprd15.prod.outlook.com (2603:10b6:a03:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Tue, 11 May
 2021 01:13:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:13:40 +0000
Date:   Mon, 10 May 2021 18:13:37 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Oliver Sang <oliver.sang@intel.com>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YJnaQcgZaC8qJhOB@carbon.DHCP.thefacebook.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
 <YJWQE8AFjyYpsLYA@google.com>
 <YJnRHhK+2AVTMOfh@carbon.DHCP.thefacebook.com>
 <YJnTYicu2TaVqVmi@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJnTYicu2TaVqVmi@google.com>
X-Originating-IP: [2620:10d:c090:400::5:5c]
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5c) by BY3PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:217::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 01:13:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b75186c-88f2-4452-a217-08d9141a0308
X-MS-TrafficTypeDiagnostic: BYAPR15MB3479:
X-Microsoft-Antispam-PRVS: <BYAPR15MB347956D417A253E6BC11AE0DBE539@BYAPR15MB3479.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InsYy1HHB3BQReH2/FIZIDM5IJQXW2B3UdobSkQLYbohhsFHUNUHpX1Hq4zJYqwK4m0UafRFKZCqN2kyNOVUh8epD1VTyJHHiR1bD8THnrI0e9HQ9z4ORW5c0Gf+G2J7kzU8tm0xxOUNT6pFfmK54M1/4LxCAwolSuzfCIQsBBD0IUmDdmUs/YbbrlkriZIr30uRnZ6V/DDqZlF9AQUoZJ7AF0wsG9GirP5ZL84kudkm+v2rnjlYgoc4ItIkZ6bZXMpTqQtBpIX3k6ixjml45AB93zCmwXH0+HnxmsdxCGVqV8opN/7F69E07Z+VH1sM7Xk94wgY6hd47k/3/83Eh+NpVyUyM2R37g1qRCGcBsmgq+kfFFUBygWOt8cg8D0FbJDJ3U3NDZbEklStrKI6ZJ0LJ8Ca/zQJ72QBm6VjlhY52+/Woiz9O8ilBZRRUoPwP0ulPYaKG5cqnxkPtXVFY0o2J6crT0bPeUPwCZ60KxzXcfrVrNP4M9Jm+MNCr3nGGIa2gwhoEFcV0SRMjD741t5N5WeT1CQenJrkljtpfbDb97y1qscR25Eo5OV3L9dd2CfMWZikH4hd1dt185HmbDYfKV9n+4rn39y6bulXOr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(16526019)(186003)(478600001)(8676002)(5660300002)(4326008)(38100700002)(55016002)(7696005)(9686003)(316002)(6916009)(66476007)(66556008)(83380400001)(54906003)(6506007)(6666004)(66946007)(86362001)(8936002)(2906002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aGWyI6E3Rwkn2PQxjxTKNteavUuKszZXktTIAWaaX3ya6MQpMO5Ehxf/jklu?=
 =?us-ascii?Q?PCw5qfETUbLsDP3JJwkjdCxQgpYw5sQAE3P5D8KkRAOQe2ej3eiLLNbSwpkJ?=
 =?us-ascii?Q?6lgVjF+KsDDYBfnXqu17nl0Lf+Afh9Bj3XJSjzys2jyRrnIyLmuUdb6b2ldo?=
 =?us-ascii?Q?VdeCnNzKnx1R2FItkdmObwWUZ2rLxchz/EckO09EE22BOlvNlxjrOxw3nTLs?=
 =?us-ascii?Q?pUCgoo3HIPOmUl+84wbONPtjbVwWY3RaBbTeoxBA23Wx7hAnWxdg/+Jzm8u5?=
 =?us-ascii?Q?xYGtZSup8FoKAEj8Lvffv5UjvA5sr5B3zereZ2LjW67/zdqfODLISVJ4IfP6?=
 =?us-ascii?Q?vOSp/g0ecy5sv0r2aafnBcyCKtyAvb/9ltzsvyfhymMMnCC6q8ZPeGrzU4vw?=
 =?us-ascii?Q?KbClY1eZUc5VkZHCFncnqgRacuptdD2NRaNA2Kj5amDj5nfokz9xUzeUoh3h?=
 =?us-ascii?Q?8j7leqQq7T4BckPvhlnR4unNT/6EpM2ZRs72LMZ1Dy/7Yvtki+Jltb2fbLrj?=
 =?us-ascii?Q?INHUVtrP2kOmZkT7PpW7Xb2z87DhJIpYk8AMUV1u8M6MfkIyaQXxTceM/Olx?=
 =?us-ascii?Q?0ZNIXe2NWaXPDFw46Nc4M92Ol/Un4hqegnmiWyAFeIKJiTn82kRwR6jvdWpn?=
 =?us-ascii?Q?s8e237vSEVY9DQ/lUUKQBibJjuqi9Fh8EyaVOTaY9CJ0Icd7JtzzMbA247zI?=
 =?us-ascii?Q?/7bfYPCBPfjh4zLvBXdeCjAP8VhSvb8eHGz9Lm2cwmGLzZ5OpcJjFlV5tlbX?=
 =?us-ascii?Q?vnlUG0DPMZ/nakxoFoZVmu4Bg6jxQR7d689la3WZ1oMQbJmQKdA27I3hbuGd?=
 =?us-ascii?Q?JPkSC14PJqeXIOHU/zpFDjToE9dtmQbb7B2p3+s1/B6ZpQ8dncG0ZCoHcmF3?=
 =?us-ascii?Q?vBneS9gsUx4YFJltEbs4oJk0lrK8o8YdajW00JPrqfwdA+Fzzx6lnM5y3YeV?=
 =?us-ascii?Q?UZY546ZZ6B4rqDZWygAjykra6P480XsqZ07h1+PsQtpDIoFMcSYRnngIWE8J?=
 =?us-ascii?Q?6udKbnNnbLqS26IoLT11UteTA6LRNhnee7EV4E3KOCMOLXh19hYx37+J1vdm?=
 =?us-ascii?Q?rDwkz1px15KfrhvxvQKDy/NoOyR6FUCa6czdgmEIsxN7cl5/UPcT2+l5gdUw?=
 =?us-ascii?Q?lj3n2j6lLaMQh2VjFM4Gc/KDOdmDF8a/1k1GP7xFUTb4UvMUw6Bs5nEfnZhB?=
 =?us-ascii?Q?sochwiA1GK/6IjVYRp1ZLQKaRiFsFeHalWaVDnaUNZBy/ijMgRQC4oWU1+Oz?=
 =?us-ascii?Q?Ne++8nBN3bSd7MfmQ//9ibitdPW/PpSsrNqr6TTTfPLBRTqoj60Ieceo4C61?=
 =?us-ascii?Q?owEZOL0kPJve02sFaLI6MYOsbhNGOps1yREXaOxb9c1cMg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b75186c-88f2-4452-a217-08d9141a0308
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 01:13:40.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG0Wr5YKuIEMjoFFEtOP+716VLQVsk2FRrnd1qFG+79zen3pdedQv065dZXPzfKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3479
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: rtasceFvH4nnK8mls8oX1cYnAZaBt8cg
X-Proofpoint-GUID: rtasceFvH4nnK8mls8oX1cYnAZaBt8cg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_14:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:44:18AM +0000, Dennis Zhou wrote:
> On Mon, May 10, 2021 at 05:34:38PM -0700, Roman Gushchin wrote:
> > On Fri, May 07, 2021 at 07:08:03PM +0000, Dennis Zhou wrote:
> > > On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> > > > On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > > > > hi Roman,
> > > > >  
> > > > > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > > > > Ping
> > > > > 
> > > > > sorry for late.
> > > > > 
> > > > > the new patch makes the performance a little better but still has
> > > > > 1.9% regression comparing to
> > > > > f183324133 ("percpu: implement partial chunk depopulation")
> > > > 
> > > > Hi Oliver!
> > > > 
> > > > Thank you for testing it!
> > > > 
> > > > Btw, can you, please, confirm that the regression is coming specifically
> > > > from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> > > > I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> > > > I can confirm it.
> > > > 
> > > > Thanks!
> > > 
> > > Thanks Oliver and Roman. If this is the case, I'll drop the final patch
> > > and just merge up to f183324133 ("percpu: implement partial chunk
> > > depopulation") into for-next as this is v5.14 anyway.
> > 
> > I doubt it's a good idea. I reran the test with some debug added and it looks
> > like it doesn't  trigger any depopulation at all. Everything else looked sane
> > too.
> > 
> 
> Well that's awkward...
> 
> > Dropping a reasonable patch doing a good thing without any understandinding how
> > it affects (or even can affect in theory) some benchmark sounds like a bad idea.
> > We'll never learn this. It could be that the regression is caused my some
> > tiny alignment difference or something like this, so any other change can
> > trigger it too (I can be totally wrong here, but I don't have any better
> > explanation either).
> > 
> 
> So I'm not 100% thrilled with the final patch anyway. Particularly the
> lock dancing I'd rather figure something out a little cleaner. I'm going
> to take some time later this week and sort it out. If I can't think of
> anthing better I'll just reapply the final patch.
> 
> I've currently merged everything up into the last patch for-5.14. Should
> at least give us some very preliminary testing.

Sounds good to me!

But if under final you mean the batching, I'd include my locking optimization
patch or something similar to it. We shouldn't grab and release the pcpu_lock
many times for no reason.

Thanks!
