Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E2458C40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhKVKdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:33:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36826 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238979AbhKVKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:33:09 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM9lBMb029278;
        Mon, 22 Nov 2021 10:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=W3bO2hVjQDX9DLewPZEINzjWtdhF+AAV5eVkav6fC0o=;
 b=uAdX7qXtE22o57O0Wb8VmmWFeRW+0pX+yedNY+Z90A7EVejDCGm99NvyYyX6HFA1679b
 0YoZCvQ1RaHyeHI1XyTu5PtKS8UkhlD18lbh5e86LllKgs88yBE7WEYZLGaAWtZ5h7nN
 JAWcmGZzN4F6cTB57amkkrkKFxzAs/lh9BodytrJCAcrYycLabh2AgsYImOUYtvFNyjZ
 dykhyeAx+P6EZyD5sBoeBETB28dbZbBonKrsXpKkAJyTsJa1olH1XM5pj69fs9km85Bu
 6ByhVn6MGnGCToKSR3cVRvI8JglVhStlpjlB/fCkmdwmDMRAPJkaVhDN03d08DoBAPZP /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gj13my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:29:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMAGjvb047933;
        Mon, 22 Nov 2021 10:29:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ceq2ccnva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:29:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCXjs9DMw5H5Smih15vQutojM2XpXUzCxFXayO/6XP9FhH1mu6IyFjzbIWliSdJFVur3Whm3YdHfgjE6FJNk4j7PX0jvAJRsewCkTvfuR8O7AToCamk18RGOTKOH3zPoSRCAR/3kctg0tE+aiDWsDFeL2IH8A9xgX5XqhZdztFl2xCD0nl83NpUKTG8c6yj8AhVbw7kreldUc47ITlvbIf7BpgMf4VVW28Jqd1Oeq1XiSe+618qtT4lYxYdgwhZJvYoAvVWbFwAODNCO/LNs2jtKH4D9P0cHBCkOqJ9rwthHeU0itHNoaSYRsHZYcGjxaCgTU9ByTsSqM434rcNn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3bO2hVjQDX9DLewPZEINzjWtdhF+AAV5eVkav6fC0o=;
 b=bcGoqY+jR6ELgZsN+hyo38l407W1JnaAaHR7pzsKX/ihAEuJ8/7T7KOVRtRS3c//eUzHBt0U2Ez3KYR9yE1L0gnN7KP9brDW3W9HewNVa/ZIcHKfrP5m2RL/b5m5s1qfL4LE2AsrZ3su3FvT3huHdvYDWOy1GlIe8F+OBuwxCgUGXVxNV6cSLqlgdbgMf5R/mF2dTA15jNuRDtPa4stnvWI+EQJBtPeq7RKrS9fWSjmJTjz+WobckTKBds7lVJnqLErehQqCJi0ojONgnIoB3jyZdKdY1F/qQTMOvhsWj1J/rc19qtogAyS4lYj4/PaMtW2qsMO4Kd3SLXNZmN4nGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3bO2hVjQDX9DLewPZEINzjWtdhF+AAV5eVkav6fC0o=;
 b=xyiHgb7NJDA+Pmqs+QCFc84cHjn+zZJldfKG919KHDCkUXQq/drFVm0TPjB/iCtbKd3+hQuF0BcFUtucB3VaCgceBSsubG8rN+WS+H0LtM+SJUt6dlpsKMDZDUqNeegdEGNAq7LoeMovG0xoXukVtDDLBK5w5b5/zufxaSUAJe0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Mon, 22 Nov
 2021 10:29:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 10:29:43 +0000
Date:   Mon, 22 Nov 2021 13:29:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Wayne Lin <Wayne.Lin@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2721
 crc_win_update_set() error: we previously assumed 'crc_rd_wrk' could be null
 (see line 2700)
Message-ID: <202111200959.YVkh0GVj-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 10:29:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6daf05d8-2415-4629-7ab3-08d9ada2ff42
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1775ABCE2C1F616AB9DD0C5E8E9F9@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQobHs6BJXZVDfc52Dj3sm9m3U2ea/z0zupjValrasTWucO81sTcCA64x7TTLqA2JMZRfz7xHroiiFjDW/b0CZRtH/dG3/4+74tllma5sZZr3IS5B1DCLKUAA6e5BUwZWIvAHBh8mKt65MY5IXMteMYGZVr5LZgQ+6lGhQk93Wx0wCmVnXeAi2zZG1CnmuNF+YSuYfAR6nMu30EVZ3rmxs5sDgD7DterI7ia6Jppj1PUXBvJQ2t0nhEhcEFxaz3VzYm0ImviZ4z34Bp/W4/DXd7FPuZ1D+vLVy+5Cf4liEkW3+pNdGankiXB9oequU+k6qeMQ8TLx3LPYOe4Azsj0MW19tNofJsG+2zzP9gcdrVTQpTEXEiPSQM20/Jg93j+nrNeUvlfz81r7zbBi9ogytknonNav/PKKKbGM0b7ZW++nQRiahbrGoe9t/aqRIUsJ0LI9dftGRP7rVc2ljgaQlRoOlNFT4SxDdEsyiuHu2f6NZUDhuTQzh9hF+ZUhOBwD4qAe2JFwALMld7yvL8ZnYwrZGlOxNkWjD5u9U6w3eqJJHdPCU86IxdoGAp5BoTrKXBkCD4QbMZjvo3+aEs8VPnpdXN9jwGk8eooc4hu3/2qfRPdIYydmffO5LrLpqws0TpGrF3ePuhIqKT1D9FkGdoo+KBzAdei6AEqVEUkjsiTYS1nE0wdQgsU7ut5gCqZ+I5k6gakpjd4qh7h4o191AluEbuCUXzRBQvE8Cn7axXRH+lcHx42k6TMGsfHwEPtMIJH5R/wFI/vIXTsKKmEcJ8+jlAE+RifJp5JDlb0PiALr+IDFGfSTmo3FqWr6m87
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(38350700002)(38100700002)(508600001)(6486002)(54906003)(966005)(316002)(83380400001)(44832011)(8936002)(9686003)(86362001)(6666004)(26005)(6496006)(956004)(4326008)(52116002)(186003)(6916009)(5660300002)(2906002)(1076003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnLZ6WltwTHqjon2g2rBTSIasBJ4JJAJ53oHdokfm/tkW2q8GttJuIh7FTtF?=
 =?us-ascii?Q?z9gIWtWDENeGRWYRjuGWmil13VlgjaOOZ3cpQwymbf9n/spufyA+kkT8QwjQ?=
 =?us-ascii?Q?c7I0aVyS8iHy66RVqLTGfOGIa2z02en4u8JzTqvc1g8+r8y4f/xznQmfaOlO?=
 =?us-ascii?Q?g+ONvQUOqTXo+E32oPskjkoX2O1oT9Jhy70m/bdij+aVjI/oWNzLN+BCIcRr?=
 =?us-ascii?Q?crIzHSF4K9iBc74nbHpG9RL4ALk2YFu8YuGMnqb5FG3jyiG8AcalwkWspR02?=
 =?us-ascii?Q?o+5dNwww2biC3OdyVTIVhtkuhc4PwdL/0reGc6yML2WJgBo6Y8flhDr2vbW8?=
 =?us-ascii?Q?waYS4qzwViryLVDxxWAhW7MVkS2jSktAvnL7vHdSBFKrYF5dwE5O1iECkiKC?=
 =?us-ascii?Q?/YT68XkzHNibZjBAKosvDoqOPdD1fWdYEKnll4HwaqbO144StWtg4327ynvj?=
 =?us-ascii?Q?mpvMHEdOIuS8Y6+12A/mcinAGWEN4HQ8Eu9nBp9gHfPRB7bQH/6raHh/+Ask?=
 =?us-ascii?Q?OPX5OSw5X0sgx+QC0yOdBpcV4gniAXDEsKko8Nzz+TPe2B0ptwzzShk9Hbf/?=
 =?us-ascii?Q?Y5JyACbMdBlbpE1BuC5pMuAnEhvuUp/6eVkWLMy+K2Vpcojmb6wjcFN/QYg7?=
 =?us-ascii?Q?FNiIeTII+yX+oaccP4YfnMfbeeqx3kGyBIbolFJ2xxhA7OsOCLB2w4rAtWj4?=
 =?us-ascii?Q?NL9ktNtZJPhTJG5t537BPR/thQq9n7wR4BEBlZAHFhFLbP9IG8OKkV2E+QAM?=
 =?us-ascii?Q?2Dt5LkQe7FmNgj62vxbbIJe08LjZhCvqkmH4KBhlsUiR+VFis4O5VHPBqUMM?=
 =?us-ascii?Q?GGMqDJxsD6xpSHVuHG9o7/dO5lul6OINHozhcavyX9Tqv42c5kJMcfniDMCD?=
 =?us-ascii?Q?gjHHJMW+ePX7zhzfAbCPA/AJCC71Z+0oZPPo2LqaaDNcsZ2pQiH70ZEpeMS5?=
 =?us-ascii?Q?1dd4eSKboZYAPUvLFVQWJzWUzAVNDQZbnALxwGzS5wETJESB1oeBco/KyyBn?=
 =?us-ascii?Q?dMbw3mlz71Cp/sidhx1Zfv7kSXaQFRXy98+cRsgpn4mhhNub6VrvJHW7Jndz?=
 =?us-ascii?Q?7Dui+MgjjG/psjEgRZQYTsDq8vpemWPEseQ/OUuMwo8AngtRl7E2rBxeGTqU?=
 =?us-ascii?Q?srBxRFIwT38+JNmNganiZKuxgl/o5PlnqFSTbDNg2vtklPs/3ceyN2H8wm2Q?=
 =?us-ascii?Q?cXnjnYoaJA3jSxOzbtLpYe9H2H+JcJWlCfwd39eFKGpmeUu7wlgWf7QwM01e?=
 =?us-ascii?Q?YKZbKEkzNGrt1O/dAKheD8jXQMAGQ4her604ZZNE3bbpzZpKzSIBxhV6H+Re?=
 =?us-ascii?Q?pBwwEXi4/8U7dV6xdEovXszUmkJ0i6qQxVLLdyAdRFpLGoDrtiW2sVRql8cK?=
 =?us-ascii?Q?UbP2XC5ew08sb/+Z2XZtKLNcmEhzbBXn1iCEzTrt5OVFT8mjaXQHxW6VOJfY?=
 =?us-ascii?Q?P9f1wqOC8dImRawcxNiCociEsp6e8TadiWWydNYkQPGZhgfFNz9zSHbXVYtr?=
 =?us-ascii?Q?/0zOF3vi1DnoGFZY4xLvVhAA8BrZmqC8/a+nS/mYoaCITD55DyceMhN292CZ?=
 =?us-ascii?Q?7bWjN4g95V8K15hjTWDbm7J4hsukQthVQBDlLw00Mxol0MQE5iQ0Y2OSTk9z?=
 =?us-ascii?Q?nL7PZsbuIpFy/GBWP7LhPgvcp1U2u1o6W6LeSa5mZmJYJKUrEwfSR/EmHiVT?=
 =?us-ascii?Q?bJfrSz/e20ByxBOACiL3zwUPC40=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daf05d8-2415-4629-7ab3-08d9ada2ff42
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 10:29:43.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0v6HrZKXTwVNr2xLKZI2n3nzrNjPkyHz3M7r76HGyqK6uEeU9NfiOjkeYDfhQAd8PYbsWnbjpsNUeT92nrxux6csa1gezh63RlSQzdTSNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220054
X-Proofpoint-GUID: UedvA0aTE6L_a_XTncc0DQHZiLSD5mMs
X-Proofpoint-ORIG-GUID: UedvA0aTE6L_a_XTncc0DQHZiLSD5mMs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
commit: 9a65df19310859bbc185a4bb8ed45fe1479bd8f2 drm/amd/display: Use PSP TA to read out crc
config: x86_64-randconfig-m001-20211103 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2721 crc_win_update_set() error: we previously assumed 'crc_rd_wrk' could be null (see line 2700)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1190 dp_dsc_clock_en_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1204 dp_dsc_clock_en_read() error: snprintf() is printing too much 30 vs 10
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1292 dp_dsc_clock_en_write() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1377 dp_dsc_slice_width_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1477 dp_dsc_slice_width_write() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1562 dp_dsc_slice_height_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1662 dp_dsc_slice_height_write() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1743 dp_dsc_bits_per_pixel_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1840 dp_dsc_bits_per_pixel_write() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1919 dp_dsc_pic_width_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1976 dp_dsc_pic_height_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2048 dp_dsc_chunk_size_read() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:2120 dp_dsc_slice_bpg_offset_read() warn: inconsistent indenting

vim +/crc_rd_wrk +2721 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c

86bc221918925a Wayne Lin 2021-03-02  2689  static int crc_win_update_set(void *data, u64 val)
86bc221918925a Wayne Lin 2021-03-02  2690  {
9a65df19310859 Wayne Lin 2021-03-02  2691  	struct drm_crtc *new_crtc = data;
9a65df19310859 Wayne Lin 2021-03-02  2692  	struct drm_crtc *old_crtc = NULL;
9a65df19310859 Wayne Lin 2021-03-02  2693  	struct amdgpu_crtc *new_acrtc, *old_acrtc;
9a65df19310859 Wayne Lin 2021-03-02  2694  	struct amdgpu_device *adev = drm_to_adev(new_crtc->dev);
9a65df19310859 Wayne Lin 2021-03-02  2695  	struct crc_rd_work *crc_rd_wrk = adev->dm.crc_rd_wrk;
86bc221918925a Wayne Lin 2021-03-02  2696  
86bc221918925a Wayne Lin 2021-03-02  2697  	if (val) {
9a65df19310859 Wayne Lin 2021-03-02  2698  		spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
9a65df19310859 Wayne Lin 2021-03-02  2699  		spin_lock_irq(&adev_to_drm(adev)->event_lock);
9a65df19310859 Wayne Lin 2021-03-02 @2700  		if (crc_rd_wrk && crc_rd_wrk->crtc) {
                                                            ^^^^^^^^^^
This code assumes that "crc_rd_wrk" can be NULL

9a65df19310859 Wayne Lin 2021-03-02  2701  			old_crtc = crc_rd_wrk->crtc;
9a65df19310859 Wayne Lin 2021-03-02  2702  			old_acrtc = to_amdgpu_crtc(old_crtc);
9a65df19310859 Wayne Lin 2021-03-02  2703  			flush_work(&adev->dm.crc_rd_wrk->notify_ta_work);
9a65df19310859 Wayne Lin 2021-03-02  2704  		}
9a65df19310859 Wayne Lin 2021-03-02  2705  
9a65df19310859 Wayne Lin 2021-03-02  2706  		new_acrtc = to_amdgpu_crtc(new_crtc);
9a65df19310859 Wayne Lin 2021-03-02  2707  
9a65df19310859 Wayne Lin 2021-03-02  2708  		if (old_crtc && old_crtc != new_crtc) {
9a65df19310859 Wayne Lin 2021-03-02  2709  			old_acrtc->dm_irq_params.crc_window.activated = false;
9a65df19310859 Wayne Lin 2021-03-02  2710  			old_acrtc->dm_irq_params.crc_window.update_win = false;
9a65df19310859 Wayne Lin 2021-03-02  2711  			old_acrtc->dm_irq_params.crc_window.skip_frame_cnt = 0;
9a65df19310859 Wayne Lin 2021-03-02  2712  
9a65df19310859 Wayne Lin 2021-03-02  2713  			new_acrtc->dm_irq_params.crc_window.activated = true;
9a65df19310859 Wayne Lin 2021-03-02  2714  			new_acrtc->dm_irq_params.crc_window.update_win = true;
9a65df19310859 Wayne Lin 2021-03-02  2715  			new_acrtc->dm_irq_params.crc_window.skip_frame_cnt = 0;
9a65df19310859 Wayne Lin 2021-03-02  2716  			crc_rd_wrk->crtc = new_crtc;
                                                                ^^^^^^^^^^^^^^^^

9a65df19310859 Wayne Lin 2021-03-02  2717  		} else {
9a65df19310859 Wayne Lin 2021-03-02  2718  			new_acrtc->dm_irq_params.crc_window.activated = true;
9a65df19310859 Wayne Lin 2021-03-02  2719  			new_acrtc->dm_irq_params.crc_window.update_win = true;
9a65df19310859 Wayne Lin 2021-03-02  2720  			new_acrtc->dm_irq_params.crc_window.skip_frame_cnt = 0;
9a65df19310859 Wayne Lin 2021-03-02 @2721  			crc_rd_wrk->crtc = new_crtc;
                                                                ^^^^^^^^^^^^^^^^
But the rest of the function assumes it cannot.

9a65df19310859 Wayne Lin 2021-03-02  2722  		}
9a65df19310859 Wayne Lin 2021-03-02  2723  		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
9a65df19310859 Wayne Lin 2021-03-02  2724  		spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
86bc221918925a Wayne Lin 2021-03-02  2725  	}
86bc221918925a Wayne Lin 2021-03-02  2726  
86bc221918925a Wayne Lin 2021-03-02  2727  	return 0;
86bc221918925a Wayne Lin 2021-03-02  2728  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

