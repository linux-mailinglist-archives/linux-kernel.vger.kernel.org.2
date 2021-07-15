Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86A73CADE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhGOUcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:32:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47118 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhGOUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:32:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FJjcW7017179;
        Thu, 15 Jul 2021 20:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=V/DFzErbutXm3rhwhJGaoWjeCnnifSWF46h4SodnzOE=;
 b=U0WUSXXQmMPKMz0l6ocqr5ZhekTT8wiJ6AKPe0Z0b4NU52oTh4HtL71kicxbDxhwhK0g
 VmkalQoQJckY+xXNueaHE8tl1BgAfyWi1u7apOGDDCXhZtgcAjgv2tX7Yw/fff69rtMR
 8OZPfVogS7/ETPxcd6iyxmoG1uwW8kwF5psFFYOo2nsuHXLV7spaJpq7dfF9iLGfwPna
 qEGpNAk909XEw2RULTWzg0qGFx72pm1AyrN1KIqSl0B7mPfDrc5VJTpcx9/v59mKXhRe
 eGAe/uEvIi6YVGWUvSzqdETYDw391d3SEcs5G3cA9YOB6ev7NqmRopRj4g7AI96U6lfF RQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=V/DFzErbutXm3rhwhJGaoWjeCnnifSWF46h4SodnzOE=;
 b=q5aXMcXfRj+ChNNhEwrWQmJ4+jyxXskUjkVZuDRT9kowszKMoI8ANph9DoaXcn3Ejqm0
 AYSWWfQcMn0uiGdql2Na1VHwLsmoy3XnLsUKOPw/6dEpLAj9qqWc4iWQutUwHRLj4nGw
 J/FO5+gb9EX2HiLimdpsbwuTabCBnSDhpCR6g/91DFrelqHMpQ6DnWAHAoUVgQzJIRsJ
 si5OJYp00IIHRdaJp7Es+7eJYknJ283AHx2sEu5d/mSzZ62rv5EVKMOiAK1oheizYBkj
 Y7g/pqdvYrSpOZPWFOl0VFhnBWxccl/fPZdl3vOGRUSWSt62F9wZZ6vIYlxKJgsYRT/n +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39t77utd81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 20:29:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16FJj3jk128164;
        Thu, 15 Jul 2021 20:29:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 39qyd3x18a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 20:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJURlCEEFHPF0kk8sv6cpd7e0GgGs5o8O8t6BVPz+76hO1rAq8/+OiJAzaBaR3+nNLr6u7uSoBE6cP/prPqyG2PvSj/wrfoeZuaiRgU18ruEZ2Ly6FiAgFH/GND2ZilHK8FsLtGdq28MrcUaOTzYD1CK8sXjGz0IRotdGFPOqnprD00gnvW9HsFnSTOCq2qXVVxazaZ3z3Zq/iH7tO01UWSQpTu3w/aZ5/7RMrblirm1oBxsJla0RsD/896Vw5dW7eh+NV5dk3EMIh5WNnE61sgBi+slZKfSngrUBg54oEZ5a4Hf8gMfCm3rLGY5GrtMmxRZ569HFII+zgUNAQ12HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/DFzErbutXm3rhwhJGaoWjeCnnifSWF46h4SodnzOE=;
 b=kun7eEm1nqty3P2lZQiXuIx4sfuMjPhjnlz5f2l8yILXFyzVHwesOQrgKtgH9MMZbeGeg8Tmumz2jZsVMka/P7TxQJFusQMhPxRALS/nLaq75MD1wZG+da7+Wn32f58fgB0rKi0RHVkqfb2Vzc4JOG92emiAiY3TIHENhioa+WG8dPxjutcrrqSTo+Mxwje1oOV41relQBJHNHy9lzEy1iplx/pc6KOiaRw8roP9qzHSqRogSb/+qWX6CQb7S8pXCY+bx3aa6LQ/c5f0X6pbDaV0iGwshv0jcHvzNOumO7HJSRmk1GogJtOTZevlD7MvtiTt6hkiVEP/BIcWScwB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/DFzErbutXm3rhwhJGaoWjeCnnifSWF46h4SodnzOE=;
 b=TZD8/C0SxBFrLv4TEuGkWZd/pu6ci9KH2fP/ic20QuSCrw8+zlcXX9zm1YFZqRfOQpssilnfhXiAC0LAx3ih9FdmL/eWeEPbDk9q1PTWdC6wXcxHYhHQtRGHTvsv71BPW/Ka5Fgtf5uMLYfRuoC8A83mTMGRQesyZLhlfQcD5zU=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 20:28:58 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 20:28:58 +0000
Date:   Thu, 15 Jul 2021 16:28:53 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        vincent.guittot@linaro.org, daniel.m.jordan@oracle.com
Subject: Re: [PATCH -next v2] sched: Dec cfs_bandwith_used in
 destroy_cfs_bandwidth()
Message-ID: <20210715202853.no4f7zylvwc5etfu@oracle.com>
References: <20210706083820.41358-1-zhangqiao22@huawei.com>
 <20210715112433.32419-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715112433.32419-1-zhangqiao22@huawei.com>
X-ClientProxiedBy: MN2PR20CA0047.namprd20.prod.outlook.com
 (2603:10b6:208:235::16) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 20:28:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f93930b2-d60c-4cf3-c756-08d947cf2c92
X-MS-TrafficTypeDiagnostic: BY5PR10MB4210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4210B145119B25672A7E0E10D9129@BY5PR10MB4210.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YR83Efl8ARYMDfCiaFXJhMiMbIihyC0Fd3CdMTT/Ml3nikeo8hhpYbZKAgIrORwnKMr5xxqwF4479rsK5dn4m0KuvJZBgjI9Xs3XDGnlCpTDlJ4yEjGD80i6IV6Lmjly/r8iMMv1FbJZknq/kOdfCJ9Hjd83vJYXYRtJCcQgfwaWekLGGOnl8jIvVR98oaH2lbrBDPz6ZtvOz9OGba9/Uce0oZAb+S/LFQXe6odyh8Vh7YXYePEigtHVqF1pOWKh1d1T4hmYq6oaxUWmhHBrCOftYK/AlzorGXBv+i35qqWuLxPyEWxHvnMjBWUFCVgsyuyld1BX2KMY34O3ek0tEVH0QsXbpfoseyaBTYVPmSrGvNJzoHde1FIqqBDMll4VovdHnQR1HKE5oDyuWPxpV8ZpSJJEa6ju29CJ7OGTcdx6WMbPj8YRtC6/y90t1DMN28xG99XT+XGIA/37YEPmIqCA6YddmW1l/sGx6xipinZrJG6AVyqMo67un31fMTpm86eX6yrxNKDLHkdgLF5qFJgR3PvlVA2LL6x11nVCk3qxpSHwIpmmPt41NxkLsToRMlZCmJlfwY3yCyKMFEyYEMu+Ev37KHy5rEXWaobnPGEDSAAbtqS1/mlqq9an99kLHDbUV1nF5KLcRoIZgh3GVz/5fz7gZh1blL2QFoC6Me32+BZTGn3jWsoFzPaH+BhTM1bAmskF5sVAUfGDEixeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(186003)(38350700002)(2616005)(5660300002)(956004)(38100700002)(26005)(4744005)(8886007)(1076003)(66946007)(6666004)(107886003)(86362001)(478600001)(2906002)(52116002)(7696005)(6916009)(4326008)(36756003)(8936002)(55016002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ObgzJpvDvgdlHpMg/WkOj5LahNs36BLWdHGD1KemcEiGgjRodF5SumObxv+Q?=
 =?us-ascii?Q?4ZlyPfnu4fGVQ/N6dxPhbqd8x43iHyW00BspLt4IZFkBbdN3OiK9UPM95P1U?=
 =?us-ascii?Q?VBXUwQH08U+UKS6/5c2c+9KgS+JwzaE+fWCtE/N2dmx1EEoflUA0VlMxFSzp?=
 =?us-ascii?Q?DBdc/tZlY8s/zMdG4il52nnSDXxzriaIgyEqL7C4VoYXhSbE3j0GBBXlyyFZ?=
 =?us-ascii?Q?jYOFCGVPtu/oWs2dqBCT3ea6Aet5dW9PzvCzVfdodpr544HximjPjIu9NSQ1?=
 =?us-ascii?Q?XBwXxY3heDDVN6zw93ImdYUwVp6FGCq9rkSZbSVk4R8LxIKoKoZcPE578wp5?=
 =?us-ascii?Q?z1l7O7j4nPzj5vGe6nxKRozIzwTEYfgYhMxxRIuEiSFv/hosY2ACu+kDM5zB?=
 =?us-ascii?Q?oXQ8tYkNQ9j5WHZFpxvoelBzwQC6stdy4oa0FM6wgz02+lGqYOQYeB9ZTDW7?=
 =?us-ascii?Q?VmmHpUi3WQzwWuO3W9Q7S9rRD5/EsrtYYXPhS11GwKvXyYwmpYso4Ae7nb1D?=
 =?us-ascii?Q?6UNq0OD0UFSCwAM6aMQBTggmBEoXJ66xTy5hrY7cbZbnKCL0gdJJIcN9TMzU?=
 =?us-ascii?Q?xMZtmgLxz7ApgJYWtXZixbuxGuu3q3JxUz2Guh5ISEG6x3ugXg6JjDsaCuES?=
 =?us-ascii?Q?NZeWqJjUt5+VlI5bTAoA13as0OWc7BGfUr3Iu5vc3Xd7qt6L05/9x3ZjDpMP?=
 =?us-ascii?Q?5w0563HUG1yimPEQaa0TzW1DCku1kZChwQ2q57ScGStBmubxU7SO8dvibm0I?=
 =?us-ascii?Q?SrHlUOHAY40WcWznSD5yISL/xjtQ9ih97J/OEqkmYDDUQB+SugHJv12v887s?=
 =?us-ascii?Q?2Mq//kV0HLUFVqXNFuxVTPI/EJtadimblgg8HsWBAapx/2WpG3oMysFumktG?=
 =?us-ascii?Q?G8wvvr/1qk+hxrn4dcl+fT3F942e7FNLpGxmMaQ55y/w9KFScdmSV8XXQDPR?=
 =?us-ascii?Q?XjZcWInNX8c2iFdZRBhztgdEeNAJYwpbadqkGSQi4JpxR7pfcJQONcGOdi6C?=
 =?us-ascii?Q?KfVwmgpmjmevb5aCGecZdWNPXHwDS2FORXNWkkhav/ONAL2zLZMoSxSMUPQa?=
 =?us-ascii?Q?ts73VHo2QA5oxg9B19Hv9RBMHRcJJ7AI7YKslkd149afL5SvvvBREO7v7UEp?=
 =?us-ascii?Q?ZK/zSKDHkE6cNQ7OpD7bg8+oqv0/akKogHkKNIgQQeC+gdcHiZ1ltSk8QOdK?=
 =?us-ascii?Q?oVUVs1u5Xim9j8NQWrJg5S6GYXYJ9qqBIWwtHFBV2Cj/edqucFbZZcJazJwG?=
 =?us-ascii?Q?HlwtdBppn7TWXKUiLrhWrhcPUNQk/tZpqTGiBUuitJ0TLIZh7HXMycDonHkl?=
 =?us-ascii?Q?ciZFxCAIrKIpYlN7HVYDjrCR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93930b2-d60c-4cf3-c756-08d947cf2c92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 20:28:58.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CPBvfxhQVod3TvhBGB2ar5cInbTcg/RIBdt031Zn5C0gYgrqgS6rIZ/EtA7IMmhas53oqOKz+ezSZQyeZljUJrsFJIGRiyohxFcybeAFXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10046 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150134
X-Proofpoint-GUID: 0cpzaLMf5KlOP0RQs3txcMfaaMkYKaEk
X-Proofpoint-ORIG-GUID: 0cpzaLMf5KlOP0RQs3txcMfaaMkYKaEk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only nits left from my side anyway.  Looks fine otherwise!

There are a couple typos in the subject and changelog, cfs_bandwith_used
and cfs_bandwith_uesd.

On Thu, Jul 15, 2021 at 07:24:33PM +0800, Zhang Qiao wrote:
> +
> +void cfs_bandwidth_usage_inc(void)
> +{
> +	static_key_slow_inc(&__cfs_bandwidth_used);
> +}

Nothing calls this, and getting rid of it would potentially avoid a
janitorial patch later.

> +void cfs_bandwidth_usage_dec(void)

   static void cfs_bandwidth_usage_dec(void)

>  void cfs_bandwidth_usage_inc(void) {}
>  void cfs_bandwidth_usage_dec(void) {}

   static void cfs_bandwidth_usage_dec(void) {}

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>  extern void cfs_bandwidth_usage_inc(void);
>  extern void cfs_bandwidth_usage_dec(void);

These would then go away.
