Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563B5344E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCVSOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:14:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20854 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhCVSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:14:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MI4m2m031689;
        Mon, 22 Mar 2021 11:14:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=J1+IRGIGcn0UhPO+S8paq0R8h57iytlReVSlG2O1T58=;
 b=Jog76P5AKZviO3mJETP1tdwUaINMrL5CTcNX7WilDdwy48NcYomben7PCbj7W0u7mYOQ
 z2tKR/kLJ3i7734xhvZxOzc4slv4nDx3LBGx1Hw7eYqDf/uSK4EBo9frmghPI0AQFjLV
 ZWYAfCi79LLLJYFPOvDt7z1qI9Ez1vfgsas= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37e14q6qyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 11:14:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 11:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGN01QLMCt5YdlHbq5DDDgHROvbrEOxRAMQ6Us8r3VmPo3HLhFXfRkX7DrjWxkeGznGdes0k6sLnh6jZiC8mT0PCcBvaBgzhRSC2XEb+5zHZ6tfkwMywdWkrheF28oNUjxBcu1KWsr2NDV6eDe3OuhYyQkLhMBJ0sAIMOaXfHryq6zmCUPu+Tx6iGeBbGwBAkDFHq0+/MgvRDuycCNNfvRAs5UFJcknEuGW9WBslYhqp/mDDBFpzJ8vi0rZzyieu+p95LFTIr0xVvxN9wcAIarh5lNDu9YIpdqmmuYGwUxbZ9uVv/QC2rWgXTUJEBalkRC18ZMLc1HKj0+X5mR0K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1+IRGIGcn0UhPO+S8paq0R8h57iytlReVSlG2O1T58=;
 b=DcrFGuUra10wwGprl4NuRr89IRQZ0/3A4R+G97+mPW+7qhNQJQyzXP7LnlvMVIK38wcjSoWZnCru0L3xl0o0olKsSSUFa/mAFgME7QPVJZ3pqZ3GPrdFbUOtPp5RmCYYFluBkVGeDtFSi8CStPLrmwvzDSru4COkjNYvQIFL9rQuZKfYvqHd93HjUHR0c3kRFNazXseDQpU5xqSnEeBrJD0nkuxDzfiLDrSfWGzLPVTLlLPV+JMhSN+WfaEdVen8C0I4I+3O1sSdnRjeuGBYZdo2MIkGf2e7C3z7V1LBGZTy3g5Z3vp0rWsE0lYi9t77sQtybVCX1Ag2JBZwEVOoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4504.namprd15.prod.outlook.com (2603:10b6:a03:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:14:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:14:07 +0000
Date:   Mon, 22 Mar 2021 11:14:03 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v5 6/7] mm: memcontrol: inline __memcg_kmem_{un}charge()
 into obj_cgroup_{un}charge_pages()
Message-ID: <YFjea5Z7iW2bWs3w@carbon.dhcp.thefacebook.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
 <20210319163821.20704-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210319163821.20704-7-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:cbc1]
X-ClientProxiedBy: MWHPR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:300:6c::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cbc1) by MWHPR04CA0057.namprd04.prod.outlook.com (2603:10b6:300:6c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:14:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce50482-4926-47ff-1b7a-08d8ed5e48bd
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4504:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4504256B800F17505368F95FBE659@SJ0PR15MB4504.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdOZANAyFO4KDeozdTMjoAazSJWLNswmmIc4rDYekV6kOm/DkvdqWWkAYj0vJuvslSvLs/duGu+N3X5Z8mDkkqOf9bkZ1vluX5SDSvafgcVxKRtfLoFt0HdiODHN1wH5u1UfeC7qpEYuSXXI5g0pCI/LMNhmhKYHA5fvXGaPgO2y82t8IHfvmojffFq9TUaAThaxwJJWbIRHHCZRZYHxXfirMxqkn4PDRLqZC2lMci8XsSuOfEVheUA4KVKH8YtyrRRXozQz19nM6wt/vwcmCMHK/NHhqbqevWXjzJFLULG272Ui6w8ABHO6EOMNfqM/ioZAWGW+dxaivUP7ONTUjlFouq2NwJwReW/S5/2b2ycCGcNQ8eezb4a4Oyavb27nkIyvMxqbOM4j7ELLrwmytxmp1OqlXX8zb0Q7wMJm25yjc8Na8gqmX3YxKJddX+BHS8Be8AfyNnRSRn/W8ZtD/9OhIztAB7ZC1SM0jnytIWgV1wTF5asrQF5LRhR1NCY6rRbxfWGLBWNNEu+hdZldCwLLzIhdZ9djUHvq2dp/pAoEFhM9PEQ708i6W0YQsDkjdfaBZo8bWOivgHRIx0+jla43ilCC+BhlFt9Up2qPLIrojxificSpBcSD+BiYYlpsgKo7IoMlEXSUBcZtwCpQrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(6916009)(186003)(16526019)(66946007)(66556008)(6506007)(66476007)(5660300002)(52116002)(7696005)(316002)(478600001)(4744005)(8936002)(4326008)(9686003)(38100700001)(55016002)(2906002)(86362001)(8676002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q4OX4t5WHMT44wzRPuShvVhR9h1ktkibr9LqaqUd+r+Or6pNOOtAeGi38aPJ?=
 =?us-ascii?Q?gjjMAN45SJzFUIbhZuNcTac1in9pyatKrSYrEOi0wOlaXOzJp9YE2qUUiW6G?=
 =?us-ascii?Q?+LuFFybl+LPxtP0qP5TQOtLxLS5wbcMM+MDKBkAC+Y6f5BWc9ykILn2TJdvE?=
 =?us-ascii?Q?eQVREUj1dMiTVFmCAKJPLxJJKCW1T4LPunbfChnFZJGzEs8Vblg9pF2h3D+b?=
 =?us-ascii?Q?h4QQ/PoRt6BVXEdjFa7LKDD9JiFHJ1dnogPJSqfxKT/gjgm/xQZY4J/4vh4V?=
 =?us-ascii?Q?KZtfZwtAnR/wPo26OWldX9GIeks1VurUzjDut5YYjDvShrzUcKJ/BPEZROrT?=
 =?us-ascii?Q?wJl96+677dT2GorL7/7npL/+5RyK594bBa3ICg470Yzdd96sN59cAr9eDnu6?=
 =?us-ascii?Q?AXpV7RrCVF+pZk79kRWarmtlxgYo6OKNX1OUK2/xS1pGDXixcOSYnxHrUZwJ?=
 =?us-ascii?Q?kOFVv1SnbxtIlOYizONfbF/eIegyRt22V41d8ijIF7TZbt8VrPPol0WFt2R8?=
 =?us-ascii?Q?Ew0fswAkOCa4i7zVGrf6t7hf8enjMm17zcJj+pmqmY6if38xyFoVfeHrOVem?=
 =?us-ascii?Q?v+6sVR48PKDA5T59+n/Jyk9aytKn+OfsZeb0IWNElXB/b+1oRGK7Ks7ZzDgI?=
 =?us-ascii?Q?Y8h4k0x43ENcctSJ/kpDUaU50EXgNn0auzdqxfytRyXZodVIh0N718bZpcSJ?=
 =?us-ascii?Q?WSUNFUIbbwvnZ8w/PtAcoqYoPnDj1LRAtlsEzrrIyWDG5f0+1kXCdifkeFsh?=
 =?us-ascii?Q?wyPBFeQ/ZBZQ+J1H1KM56wKo6x4lMG6tROnQAGoMfPx/9gKvQLGZzjUEGnqs?=
 =?us-ascii?Q?97PDuAk2yf9JtsY5MH/MOhu6PMGy0wAXFmiXePU05kcTGVlb1FuvT/zKhYRl?=
 =?us-ascii?Q?4ULBQTCuBGsoOy5i3+u3zN+9qjI+2fLXy017WragBTi+e8VH184gI6EyneU2?=
 =?us-ascii?Q?fRGSFOWPDF+G6tFvPhdeyekWS5UI4D/st0xMaP9cB3p3whHuSR2lMJK1mg3d?=
 =?us-ascii?Q?6azuZ29B47PPp5srLvpJAzKW7dfWE9H5mf0EYZ3YKnfp3hooA+qY4yJrwJq1?=
 =?us-ascii?Q?Bx6vWn7zpqPzURBTXpc1H0hbycIRyAys5YanmuZdBnBX1edfOr9Jwm0gIWzT?=
 =?us-ascii?Q?z/P+iX/EXbkV2hdxRzHWR4CspA6ddfB06552QGi3wUifF7KBXrVX9mYnWME0?=
 =?us-ascii?Q?oLOYPAdpasbyKE/GI0EGD0IvJU4miquF5tDuEf7KHtqZYT6cYc8j2tJwGPfx?=
 =?us-ascii?Q?gbsTGgGQBDf+MBAKwgNAAkhxTnt9vKhXVYw1zPtlYHQjJufESKPX1sRPBGvt?=
 =?us-ascii?Q?iHsaDYrKj0B4CxgVnE2DjCn6zGIIvZ5TPnz6+t9lMPy2IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cce50482-4926-47ff-1b7a-08d8ed5e48bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:14:07.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJEtQc1vb9QcqRgCMjVplbuRY+mloN7PgZdd/q6LogWtcKcZOtZBq6tF94wf+keS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_10:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=593
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:38:19AM +0800, Muchun Song wrote:
> There is only one user of __memcg_kmem_charge(), so manually inline
> __memcg_kmem_charge() to obj_cgroup_charge_pages(). Similarly manually
> inline __memcg_kmem_uncharge() into obj_cgroup_uncharge_pages() and
> call obj_cgroup_uncharge_pages() in obj_cgroup_release().
> 
> This is just code cleanup without any functionality changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>
