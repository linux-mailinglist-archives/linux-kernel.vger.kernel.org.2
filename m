Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C8344E48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCVSSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:18:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61658 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhCVSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:17:41 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MI9Ssj012327;
        Mon, 22 Mar 2021 11:17:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EQJU6NQVFCi+VZp0wcOhUUaRvPGonVVKjDxrYyCsVEQ=;
 b=hSnRU0X/oHoa6oRJcGRkXCnvG3raP2MwWYqjJCjxcfpIRG2eZ8QR6l86uKzQrr+pwdLg
 9EHaoPZA02IfRGrdCDkqi8KzRI4sFDQtPaZLwcpi7ElSoMWAAVUwUtIwzR8blguoy3wm
 d4vulspg8myyf+3/AccRurijsGMNneFXQR8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37e0sxq2wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 11:17:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 11:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxfqeU2d2oQmgpkpr01P1a9sUhMvCAHLHCvfWW3OjvACSony51pGxGw+Wp2Z1TlV8oPhV53Pfu49CdgobOvsDEjSY1mmeer/Iwp4rFVdCv1wG+utrjwJlFnqnyR3nox4jOIy17la3scUtvUFir9R83k1U0baAvZBqmY01/N1SbBVkrAAMpN9rKFOwqQtQybrNQk6InpjBpUYk5mYG0/9q9V8iIpO4UFbLydoxh1ag7iKFPy9Vr2SuVLPly/Gc9ODsRdj8KEQKwonKC1xVvuH4wgsUk6yElm5lXCJ8Mw2TfO3epp9VlzG7r+hyEP+4JhG7ijv2wHSW9O9p5yY4TVxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQJU6NQVFCi+VZp0wcOhUUaRvPGonVVKjDxrYyCsVEQ=;
 b=PYyESgnbOogCl7fmKLdeTeOGjXa53AMH01FGTKaGZfVTx0wPM+flNKIIMhwbp/MEXG1S8shqTtC6fXLzXY5Xx2EMWkPA8wJwugo1eNTMV8igFNMyOG43giQwvK3BNzwDEMhvEVwPqnqF1T7QnjSYHvHzezoru6MDOvD5IPF1ieSp72aPOUMGvu712VnSFXQsv4Y+c2Mp2/PRhYS369CujKOGTCXt4jO/4PMd2n5l08VrZMTwBIXHVCs7i/WDC1uCSKVghEUOSThWrHO4h+/JmtbErmDKsfXRqcLTgoxAMhNsGMnHMd2PpE2PlkrCPnWwS6yRrsGW4ON0FgSZ08b2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4153.namprd15.prod.outlook.com (2603:10b6:a03:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:17:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:17:21 +0000
Date:   Mon, 22 Mar 2021 11:17:15 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v5 1/7] mm: memcontrol: slab: fix obtain a reference to a
 freeing memcg
Message-ID: <YFjfK+F3dVgOABUl@carbon.dhcp.thefacebook.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
 <20210319163821.20704-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210319163821.20704-2-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:cbc1]
X-ClientProxiedBy: CO2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:100::19)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cbc1) by CO2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:100::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:17:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dfb1f56-770d-43f1-bc03-08d8ed5ebbcd
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4153:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4153044F7E8354FB1F98F871BE659@SJ0PR15MB4153.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+TmXgVNZxQffjxvmhGFZOSzA7J3jJTMMilF1NkCO8s9OKexdOs9pwUxomflCIOXrGZKq1nadMypW4kB4ietdwf+HURNXEJf9V8nuv780te3oSYv8mRStrMzk50uudI+TdROHjg7ky8WmDyYXGx2N5jGnEaL6ujiNtrWJ5JWFFvM6JqrcTbZ5TQVSHp7qkH2MsdhibjlMXOSt9OvR+z5Z8WD6x3ZPgbqXcaKgtXkq3WpsIUB0GZMGJpJK+MfWFTcLg/n+0c57e3Rw5F3xgZ7Zq6TqBH7FGgukrtCD+eXLFFwGO8nHiFUIoHd6P8PKFSvcvwm9T1okWK8BPoKuuDLwXQC+XEP175fQWN6CKyHzG0yGU24LXni23rukmnVGsi6nhwzbyOwOz5tXpnY7M4+s6E/+vMphnIpv8ba4FStdULZoam1CgzfEsMIQ8qVPoicpI3Rd7zXrwUFgfnzOu7lnKyYYiVFUztk7O6QTcOM8IqYnsVg6z3m9Ahv3rFOj+uboeRKWCiHrejPY5eabEUkYIrD+j8wOklSNC2Pxqmew1a8QKmQvGSKvW3K2jGeHTq0RFBxzhIWGFXKsP62Z4nqX91hoNc588EZ6nhDbIx3BEjlmEB/aYzUmYvbLxsqSz4YP5r5U1Hd+2YVdbF6yXDEd7q/AMaCpjdda/9nNvRp1KE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39860400002)(376002)(9686003)(6916009)(6666004)(86362001)(8936002)(55016002)(83380400001)(7696005)(38100700001)(52116002)(2906002)(8676002)(66946007)(6506007)(16526019)(186003)(4326008)(478600001)(66476007)(5660300002)(4744005)(66556008)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X2vUHiWAqIbGazF7urX7lPM3M/N1PMQqr4AkICuDNaK0dwK818vYM0aVwX/z?=
 =?us-ascii?Q?EOoTYinnBUE+820uPugpSNfF+5pMoHAjRc9dyA2LW+w/sLL4HD1lVERUP4gb?=
 =?us-ascii?Q?Jxjl4BvO6h6tctvvHBJFDSoYZu4PKTnyjhvk9uL9wkO0PE7i2iXK9eJTPHoL?=
 =?us-ascii?Q?bg+cAdYxXSI+1hxOHIvnI5cCKvxs8vsz3W/ENV+qX2LTEtCS/qMTcFS7qJKx?=
 =?us-ascii?Q?i9DIIMq6WDxXEMuP8JaME91n2vq6eIXED2pcgiyNyl9UKl8h8/JZyJMmNos8?=
 =?us-ascii?Q?lj/2oRFe1blWWwmtHqeAf7WkcaJXgmieqzVSaeYlFtfcFsoo9VBOQesS3d5Y?=
 =?us-ascii?Q?6jc/PEt5Lxn92vFQO8ORWTSh08Otl9ZvRvUSzD+mJZqyBumzr3/iprPaqa93?=
 =?us-ascii?Q?VcRNqf1mjvcGzItOZUnkP4UVgr6BqNA6Q1DQlX7KvQUIUqYD7fZcEORm7gEq?=
 =?us-ascii?Q?Q9SXkdPyIvoyg9avtwAatL79zS564ZG+BbaIoDEtixvZKbgdhhRDlz2F6bZ5?=
 =?us-ascii?Q?y4pCDC5adT+1bfO7CNWXy3tTbuKIN/jPwEJ8KR1mHBIE57r+qXW9CMcGv3Ng?=
 =?us-ascii?Q?PcUxuXva6xS5s1+VKa8Q9Xed9F68GoTrTPagwj649idNeUeW8pixeAUCzzkD?=
 =?us-ascii?Q?H7U5sg+V3pFRxW+etFHCQTO9Yg1gdLsLDCl87USIUPvvqnV7GalsFqfAN/sW?=
 =?us-ascii?Q?J5ElE2OhZU3l5XIP7PD1mVXLo00FPbzYmytq5JGWq+Iz3h+ICAZM2k6f7M4b?=
 =?us-ascii?Q?GUtESrqAHTcuNaX8/mwQac/t+gDzwf7o5nFS9OFCb/q0835uATgf7jjgBK7A?=
 =?us-ascii?Q?WXqbS5BB4nfP7+dgXwLeqRFgxcr5kaDkqgxebmprvAPvaoN1GcCMlAstoUlu?=
 =?us-ascii?Q?zAm1elLTi3nt7JPnO4z6i+PTTWo9a5ELFgndmtbDc5tNA5e8+6VlIRbQPCoz?=
 =?us-ascii?Q?biuEVF3AU+GShjP7+otMdZHaWhNvMR9pk9PN8iJoXn1HDZajoylkaNidxy7K?=
 =?us-ascii?Q?jRT2doAeLPAMo1kjjJcFj9P929NdG0KcICvdXq5N992ndq1lw9tdg1lUTsib?=
 =?us-ascii?Q?bRxd2YuEj2PVenQb2WNapOb946WVxlR0rmNPYyMQVp8/STB1P2HHna7Hyh3d?=
 =?us-ascii?Q?E5V5MVMz63THnCUz/KYg2VAM+cL2K8TqmzmRMfQTXTEFC+Tb59HflkQ7Y6Gu?=
 =?us-ascii?Q?FgBgAr2Qss+akT1T2jby3Q7VfCNl7jIySyMPzU+KcaS70pxy+HogMKfT2ss3?=
 =?us-ascii?Q?4nEyvAWBdMQckn/ydGtu78tzEz497QQVoMHgIYZ5luVm6kd/0smuhpXKjxXN?=
 =?us-ascii?Q?ar1ECbcDfZi8AVbm5+QsiRvsKJzzPgO6V5jxJDKAXoEnjw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfb1f56-770d-43f1-bc03-08d8ed5ebbcd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:17:20.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g6xAh7zcGAlJM7lhI9V+rb4+GyIzyG06PQ+7tXxZqwiQBTa0bancHOeZ75JQj2A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4153
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_10:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=652
 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:38:14AM +0800, Muchun Song wrote:
> The rcu_read_lock/unlock only can guarantee that the memcg will not be
> freed, but it cannot guarantee the success of css_get (which is in the
> refill_stock when cached memcg changed) to memcg.
> 
>   rcu_read_lock()
>   memcg = obj_cgroup_memcg(old)
>   __memcg_kmem_uncharge(memcg)
>       refill_stock(memcg)
>           if (stock->cached != memcg)
>               // css_get can change the ref counter from 0 back to 1.
>               css_get(&memcg->css)
>   rcu_read_unlock()
> 
> This fix is very like the commit:
> 
>   eefbfa7fd678 ("mm: memcg/slab: fix use after free in obj_cgroup_charge")
> 
> Fix this by holding a reference to the memcg which is passed to the
> __memcg_kmem_uncharge() before calling __memcg_kmem_uncharge().
> 
> Fixes: 3de7d4f25a74 ("mm: memcg/slab: optimize objcg stock draining")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
