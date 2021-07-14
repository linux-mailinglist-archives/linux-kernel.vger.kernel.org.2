Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F53C853B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhGNN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:26:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57944 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231478AbhGNNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:25:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EDHZkS031821;
        Wed, 14 Jul 2021 13:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=XpnZYuPvy3lRupmb+CZmOS80rqN3M72+IOm5GtHdM7Q=;
 b=E0KziOjU5TPR5uqwzU8ybJ576PUDJGHhLV67MfFt/6CRapEwlkp40xPl9hawCPIWEcJg
 V5QR2/cQoG+IUbEiJse0s79XBUicrp57Up+6+eAxR9wUu8aiAdn3SFjNZ0ThWJEGpd9N
 Dk/WNgH7VipBvywid73DjwqvozAITrHBaqOKHYM2wLMHazMkPkMdXKKfyALnrCJBUGlG
 BcjsCPPB4OP6T8YoRNtyrWVCN4a/3qdMUBWz2lMK+N2E+ZVR2rWn9goRbmts3RkBw2wD
 Uu99LAQuQtxh22XWrAC9zZE0Q8qvIW0QvOz0G5V8NtPiQLzcE0DUphOKFujFF03EguMW Cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rnxdmwb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 13:22:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16EDF0V3145537;
        Wed, 14 Jul 2021 13:22:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 39qnb38u09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 13:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDMC8ux0oZK/iO5866AbvSBLmfM24JlYHjaehQsOpsN7koL5ZxB0nzCuxI/nGsKX89hVCZxWBQT4TCAAdbLqOQ/kHdjpPdTsr/NLxOukQtFNbTfTDlLD9Xyj+YDWsXp5fMgQEkMS9vRD2GzPv3MVXNRSuHa59VmPsmXjBwbmIRat/rOENt/g5t1XLqeLuW8UIUzMn4F0k/KgSTkKLKUV3bRO0AAfV4fj+v7f1cjhamUTQXht93qKOPeALt6wfxZgOgNY0n9Chht32owlZobWY/44Fj/+kYrb7/pbCP5fySv3XlJBuWtB+kJAIAs8BKN1zoaSHzWF64Vw0QiJ61G6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpnZYuPvy3lRupmb+CZmOS80rqN3M72+IOm5GtHdM7Q=;
 b=DFKG3L0Ogx0xIFgRwqdj+vhuvmPtM+/hiPt+o7y9Fc11wOw8wQ4rmf8IDyP4IwzRENLD8/Nad6gtb/dIznbPggzrOrUO0vCgOYDjWlqHXJoCAci0apRlpdPYEyg/vwnAIXKeJ8iovdSLKjF7abgYcquclS+J/5QNKsa6VdFs+X4GMDm4+nEXROHukPcBYzxJx6ranJW5AtTwgRKoKg2pYEfeIaBrIxl0fu9sKMCqx5867X+YxzzjR+RFL9S3xUy/XeG9p5kAo66z7JYKMgZaAAHt9b7Pey+8PLRhnJlTkXTWHqq4u/5squL8npdslh0g8MdjpFo2ozjwdHAp4LnOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpnZYuPvy3lRupmb+CZmOS80rqN3M72+IOm5GtHdM7Q=;
 b=j4ppSY2eOu3E+dQW9rVLy6+Wj627InUGwUFO8OVy068m9cjalG7iMYlA8PAU2/SWxpYMqoLNJGZaEMXyOE50ZayUim7Mz/vfjiwf5MiTB4tSIdQpj0ZtK8Zdo9jmpaUiYMbiDM7UzS0QhbK51EcQ6+6Er0ic2HI6KPudflY04dg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB2758.namprd10.prod.outlook.com (2603:10b6:a02:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 13:22:39 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 13:22:38 +0000
Date:   Wed, 14 Jul 2021 09:22:33 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     20210712162655.w3j6uczwbfkzazvt@oracle.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        vincent.guittot@linaro.org, zhangqiao22@huawei.com
Subject: Re: [PATCH -next] sched: Dec __cfs_bandwith_used in
 destroy_cfs_bandwidth()
Message-ID: <20210714132233.o4zvgdiiugxf6yxk@oracle.com>
References: <3b2eb2c6-20d5-9f13-09f9-77f87f333b8d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2eb2c6-20d5-9f13-09f9-77f87f333b8d@huawei.com>
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.14 via Frontend Transport; Wed, 14 Jul 2021 13:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2968610-f947-45bc-ac22-08d946ca7394
X-MS-TrafficTypeDiagnostic: BYAPR10MB2758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2758F3F11650A8B4DE4232B9D9139@BYAPR10MB2758.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pp90olfDUnOpgSCe39guLRLIk+252D2OlrGgHDbmVodbRPsGzONrGFe/cxvSPufBow0TkEt5/87Q+wINlHsfoKMRV3jxe7GDOgzoOKx53Q0EDYa1U9rfPPK4DyU8cXgS3kzZ9oQJYIqqYZCFZBzvlhWKQ+2I1GBcfg/5zWtL8nCQ7VeM+c+k4m1+QodPbzQuOgNaesx6zZReiOcRZSqCsPzKgWr+l5rWrkKTyR4sNcAO9/L+k1aRe/iY1ONFrjdorx9kLdhUZFcOnCmyBFhqCpVUWdO38lfMzlETpPML8AGBz3czrcaSSn6b+OnGFKIZuNq9EVbmMzg0/whXCca20lLNGti0nOeVu8/fIjtJB9Skp7kf8A9UkHjyaObzvLL3jXRohg+5chlJ9es+LoSLQKTJGiBg7xfjnPWaw6rzDikuzAQt0bPpaVWgvem6LRpypEj8VS6INk5RrK7mAoNlOJGXNMCpq+pQd2A3ofLVtEueZUQnOO3XuDBWg3wtRq7XOa0m6FVlVonWBPqaHfdmA5KbiEgZn1ORnQqx1OXXGEqO7Ox05kRFMOkgnzyw9OPWvlPkCz7csL/14CMiADGoFuZPaqTPf0/U/dG2uMen74mGxSucCrFWwj2yD8JknpfKOJwwC1VZLTc5v7qv7tizvi01dZ1Z5GgD+BSnQ2oFNTqxFqAxwAGtHdzeGttfpEgGxpGoq/an/z7NlpazDEzPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(37006003)(83380400001)(34206002)(5660300002)(6636002)(36756003)(1076003)(4744005)(52116002)(7696005)(38350700002)(6666004)(26005)(38100700002)(8936002)(478600001)(2616005)(316002)(66946007)(186003)(55016002)(8676002)(66556008)(66476007)(8886007)(2906002)(86362001)(956004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJtnutNWB7r8l0fHzTKOMRoj718bUjoSNRjq2zpwB1sX/PiVqhAS6Bs9aC75?=
 =?us-ascii?Q?xlYTC08GtH/jkZRrTbQE73jb0lcY5M4zAWe3SCtK6Ta27szmhgE4eNbS1gpO?=
 =?us-ascii?Q?WVfVwJWhMVw4ZCfX08WNtrXKyyUNVXQV2H4n+52h26sD0TngQTTnb5+BzkLA?=
 =?us-ascii?Q?Nn2pAeof6j+Ksa3fwzIk2fIbuN/cJtFiKMRaJGm5dc4nPR1mkiClZBraRj71?=
 =?us-ascii?Q?hpaNO101SHZD3yxN3G9Qa3hVOlQRIBv7oyVz1YhXJfYGal3qwNgXlLRcj2Dy?=
 =?us-ascii?Q?v/jVJWDPnzvGedeKH9dSBOo74gA5fOq0/paD6HazpiWPELoyE+ytTMun31Nc?=
 =?us-ascii?Q?j4Z78ujMHW9BsZW6YkjYyiFFwRXxmRoS2lTv4+QMNRMyt2IWoZ+3HQFTH2jX?=
 =?us-ascii?Q?X5WWFHStor15skhK4ZuDK/oizucg7nk2NFjd87vZZ/pz4cb+Z+CT5u4noDxT?=
 =?us-ascii?Q?g/PsBr1CtRnvc9W4YSM08lA2Rt/n+XuYA260HNznB8+TYZcGt1VpDYhtNe+f?=
 =?us-ascii?Q?u+ey2aLTTpyXD0CGoJPLFSDv5l8nWjvmN+AlbiC8vdj97fp8w/2WiVJZ+t5V?=
 =?us-ascii?Q?Ljigwba9QxDBKuIGsH3B2bFF/PBZRrr25JwIu3FmUhg7PilcXlV4ICIm0Haj?=
 =?us-ascii?Q?s7wcSChgH04RqVNC3e+wuxB4Xur/vZHOz5reaXHbQjLgeWDylD3vno78d7FW?=
 =?us-ascii?Q?Xa3MUScr1TnyBBrIgKEH+85FPZrnBdutuLycCVhH7GfVGWs4sUpjr8VRpprq?=
 =?us-ascii?Q?rxsk8sFkBZ4JfFH6oVZ0u4r4DzWB5RVktS9TMe2/uCC9EritF1e9auxlA4QV?=
 =?us-ascii?Q?DjPLJtNvjtYULfo30yMMKBzKHt8oYUR49A7Hj8DBBLj8grmjl1ebZWXJaVVs?=
 =?us-ascii?Q?0CvtwhX3iaQjTV5XX22KfVUWBiSZP2kd1nh1MkcOhwh+q/dpWRAVcZECOYKx?=
 =?us-ascii?Q?/NukuQvavYaCLjUOkfA9jc+rrbgUp/lt4tBMOLc48m4IbgdP8ZMINeN8SK8I?=
 =?us-ascii?Q?eIdtoMu0SzVH2pVDLmRf166sltkLjQwwrLPa0h3KLTEy1+qzoWnt/784G3QF?=
 =?us-ascii?Q?1J0PtWAno09P63i7eWsDGi5Pyrzih8goazvOtmEUhr7m+OrVUhmgddnDScqx?=
 =?us-ascii?Q?4iuLOr3lINb5Yfjm9xZpUs3r4HVo/cwaRSjnb79bZBVjGuZvlcKoZnknLuJD?=
 =?us-ascii?Q?CkaUK/oKHbR09FG+teFq6T9e5MXSTxKMcZuNM4Jo+9DYOf0zUgKY3xuS8fMF?=
 =?us-ascii?Q?YyrGCmyvgkjCBuCj5ee820NMfJPRiV3XAtPFN7Zf0pAS4RN7eTDkMKMXKvLo?=
 =?us-ascii?Q?rZ06Lxh5Lwemo7sA55IMeH1K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2968610-f947-45bc-ac22-08d946ca7394
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 13:22:38.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WwbWN33R4Tah+I5nla/bU3ytQoeAWVm5eQJsGHLX27FQwMVKNDmON6UTVSCLrf8TTfmEWkvLVhzEdqoz3V18D2ZQNTNLqLsJT3DJ0tVDno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2758
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=676 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140083
X-Proofpoint-GUID: IBrhh4_ICKEBv1ceQjerkONG_PfUhUCJ
X-Proofpoint-ORIG-GUID: IBrhh4_ICKEBv1ceQjerkONG_PfUhUCJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 07:20:39PM +0800, Zhang Qiao wrote:
> And i have another thought is that we can hold the
> hotplug lock before calling cfs_bandwidth_usage_dec().
> This way, fewer modifications are involved.
> What do you think about it?

It is fewer lines, but then hotplug lock is taken pointlessly for
!JUMP_LABEL.  Not a huge deal in a slow path like this, just a bit lame.
Adding a new variant seems cleaner if more verbose.
