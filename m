Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6275743E779
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJ1RrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:47:02 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:9944 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhJ1Rq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:46:59 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SDKtEt024303;
        Thu, 28 Oct 2021 17:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=9WA/hbqpCT//XDLkxOoTQeVP2CzD80s5uIsQ+5jocE8=;
 b=JaC3gcvUsyKHs2uT8EyhdRQpX5fJt9Lvj0hWlMS5Oz1iyKVSrxHCrTKPS4357JFreMEx
 KSW+/6mAjdc1WwtYdauxm9OB9WytY8vwURDGZaPu8F0mTCzRc+9pWdfcmOXe+yMsZsal
 l4tBVkk4e4gM9CJX2XfirFuGR3M51AJ6AdBl0HeCktVuIYvU+XZVKiio3JHifWKjDLTt
 mXHVZJ0Tq0ksX8PIhRgC0VYHh+iZDW0/tbKg0UqXN8PE/e9oIifJplIZ5rcj7vdxS765
 n/O+2MxFM7aTFIAApKwLtPI7Sn2pn2Zmwrss8s6pl3ZpETOzTTKMdd6UzBXViKyQT4Hz qw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0064b401.pphosted.com with ESMTP id 3by93x15aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 17:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN6xc0t1rfKOKHTfh3F014AX0UKFMwanuOSO2tMMhNMpaziOx/msyLfqR1FuPeJ0bgrK+9l0G8fF30JsRsV5QbsEG0i8qgDUKbxbjXNnSMweddmRbn8sRzLGbYr1OrYIGuuNfKfYqNRec3E46hVUuy2hEmAht9MW9jgRDqz/e1Z0mDmAaGUyfWv2VoaQkcct5LbliWMIhX04ZCWtD1MizJnAtshKh7TH0L6xhtH4HwB2T6a37/iAWdXcNyK1cSagj0y13bPQgq4sWzk66m6ESkHdHWJCTWbENfFjCa7tkdp6IJ3YkMHVRZUKQX4PmcjjdQ3TP6bdmC5KaefbvNakhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WA/hbqpCT//XDLkxOoTQeVP2CzD80s5uIsQ+5jocE8=;
 b=KGc4iqABweyT25uA0QCYAaSgwCPgqDdmj2Y8UXVfQmrHbbsA30FaJ07uwY0zB25DNVbVO15lq9Qdhsj4HeOE7FlEqTrFf8z1Qgw1o304r8VsA1npo80VPpsmN1NfO3voPYhyeprRRUg8uvqBtcJEbzQYn1dx6SesOetKTyIygFm/xV/TegODUK9WISxmRCmHHZn8P+NlG3q2oWG1DLxqP2BwxVaSvztwFtRQoxqENorSrJVsb+6Mz/Nvx2SFW1i8gsxJhIMSMllpLPkNkcRAsQUxsPvwNn525on2OSxpB99ITBepXcAND++5zXA05v8rObRo0etPH2/dxq4AgwQXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DM6PR11MB3449.namprd11.prod.outlook.com (2603:10b6:5:d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 17:44:21 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3d20:a9f3:70c4:f286]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3d20:a9f3:70c4:f286%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 17:44:21 +0000
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     edumazet@google.com, davem@davemloft.net, kman001@ucr.edu,
        weiwan@google.com
Subject: [PATCH 5.4 0/2] ipv4/ipv6: backport fixes for CVE-2021-20322
Date:   Thu, 28 Oct 2021 20:42:28 +0300
Message-Id: <20211028174230.1800007-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
Received: from otp-linux03.wrs.com (46.97.150.20) by VI1PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:803:f0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:44:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7afb0bcd-7bde-4c43-1d02-08d99a3a92e9
X-MS-TrafficTypeDiagnostic: DM6PR11MB3449:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3449956492CCA8D44ECC2A89FE869@DM6PR11MB3449.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3wydu/TYggFRLDUu9jDLlkPWnEBfnyf78frBAaF0XwU3uxR5Y4kb1CRGbGOigyNV+xYmpIzcywNaxBNzQZ7fXO3ipMNr5f5GD8Q1rECxgomVX4Dr8/iZQ6fEjFCeRknMN7P5vk+CQOR51iy7S18Gaei7Wv3MhXO2PodFTJ+WHTZt0w+DGFVp2m9ITAJ2VCwmmABYRuV+9FvJpDFmfF+4cNC8FeeRAKd5+cvDC34paefhGE3s7G03wILAQWYyH2sgA7v2CnePn1hG63f9rFVxfIXQLkTpk1LiPIPyRWmQt8Z525NATO6Fggby+Tx+DtoT79Lgq6iSea6DbL5Dybs99wdLE1PF9/MfJktVEZks4zUeQvhbFvDUWC9whRvVkymDj9vBMJG98OH/7MoHSUc+8eB20ILj5hYnVOgVykdjvEBPRgEJfPBsofVLAkeeAehW/G8ndD27XeXYAdKHAhXeCFBMVkEo4U7WD2eo+ThNHs8g/codkbzR9KGfkhJH22KP0Yv9GkrfoywymWuCqAv96j9bO8Jg6CyEvVtIH38L6LvMHcp8rcZkiecYif+08zp8zUNapkEf3NFTIdk6q0tQ0zqtt561nzT9vbO6+9zzTClB1haQ87UKPhmFZzC8UunbSSvS7eH+z/wFGzDRKSqCvpqI94VeL0vFHual+xJiKOLFSHf9cgNtW9kAZCnFzfUrZ4KTKh2GhYOeW+buG3/Y/e6PCgivtuanD+sw3/9FQ1H8HrRcPWOLoQk0u3475kPrkQA5KW2ZNABB2EF2VAe0/vrftrK1dToRlGiltuhqwJlqkQMf4rjRU285bWBXpyrwD6mZ0GBunrQCam44TRKbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(6486002)(86362001)(2906002)(2616005)(6506007)(83380400001)(316002)(5660300002)(36756003)(956004)(66476007)(38100700002)(44832011)(66556008)(6916009)(66946007)(508600001)(186003)(4326008)(8676002)(38350700002)(1076003)(26005)(8936002)(966005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTiGfI59gLHocUCGUljwxdLeBgmpK9Z5Olc9T4iF7/kAYkCrFbtYV+s8XBAr?=
 =?us-ascii?Q?WlKykbwIeQg3YLw3n1cryaz3/xSvwUfbRxcNLUpHGVptj21VZ+z95z/jsQYj?=
 =?us-ascii?Q?EJ8ej3ixlg+ykNmO+FwtVoSzuAgIWfcqGLNDaRosbXmFxd/UGUFaNGIQ3/Vq?=
 =?us-ascii?Q?HQsZ7LVq8D3iQTTBegsOnHYJ4MjvDm1YReP+CeRAs4FPVxRR1hDExAJ3aPxH?=
 =?us-ascii?Q?zl+sb+HXDmun8vyLgDnMcTSHO40cjOefZu/pmx+vBysdU6W2P+bpzmS1W3nj?=
 =?us-ascii?Q?cN6OmX5ezys0lvyWshSOE+jApg1QUmKSgKWKcg0Wg1YuLvzO8eCBeHD1AAPf?=
 =?us-ascii?Q?9IsJblvk79nIpG0B6hurWpLHv/mfviYi6Gq3UyOneYR6pd7PvFRbbOp2cxuI?=
 =?us-ascii?Q?qnpUZYGsXG+77KTk5mNrymNlto7JCZ8/FsFdh0yDVwdD2KbBHjrrGJIxmRTw?=
 =?us-ascii?Q?ybbJCENbR0D3jO+tiRGOPmMP2WbkrQS5kQtULz8q8Ge3i6J3Az/2KtYfy59A?=
 =?us-ascii?Q?EqnjpGiD/foOgr23TKKwI/WZXYqteBA6slEXBVxffqYSv994zZtxXpVRu3Nh?=
 =?us-ascii?Q?Rn2mLDRRbbrYgPovfD5fCF0czNnhBcxMgn0ENCpLwCZKxG4OzszURkGEawar?=
 =?us-ascii?Q?vx59DU9XcpoCHLke+UkG5gmF4EAS5lzdVa+27ip7WkrQgmAdWGuaBkoVoSmL?=
 =?us-ascii?Q?v5zWEHDgCsfZ5/3AlIEi75B33sTUOHQLXB9Awdz7GXnVGXHtoc6Iq/iKMjeQ?=
 =?us-ascii?Q?N1/VpyYyBLbaYyiAEogKn6LsoCrQgLKqqKlnuNoRHOw3NJaXdEBaqOiImEhB?=
 =?us-ascii?Q?0T+15nxh+k9bcJUBxdUIlx2fwd52bdWgeqA5j+CwD1oc3NmwNIiO0DCGTUPW?=
 =?us-ascii?Q?QZbV7anWaPsg8HNJBj6i7kDge4sKpOnJtGeaLPTTADooMtOkx2kQSx5ov0uc?=
 =?us-ascii?Q?m0shnZFab69yJJcotLs06Pebap5hJcYVyJoGO8DuWMnTV329fjDMUjnzEdLr?=
 =?us-ascii?Q?epXDwYvVHaTbJcQyshK5Z0Y1GrMTevw9zvQSyn3JHj+sIpFFg3a3Z/A/4V6s?=
 =?us-ascii?Q?J2KqB0ztoRJVNMHLmmcgJ08HID3qGSnKSw/JanEvhujVvPqQVhtwLwXezsmw?=
 =?us-ascii?Q?eHRqN0x/S8myK6x2rcFtUZGcMWvuXxhjdDu1JxSoOWQr+J03CHXnvLyvSkBr?=
 =?us-ascii?Q?2W6hvtRY2qE3xvWDjNTOBDU6ZcVJrA+9rp4wlpRHKdLH3olMo4YjQB2qnEW/?=
 =?us-ascii?Q?bzEe5VqQvXpxgJ9Cz2dC0/Iz2Cx/yVc2xzb55Whx7waaeqHDh3mLvvxHdXEQ?=
 =?us-ascii?Q?jMWtTkgFO2dgge+o9L7omHM5GACcjI3OUv2XkzSjDVwI0XKuHu2ShDry3/sN?=
 =?us-ascii?Q?DZXmq73wAIhtJZlbXRzfvBSitqtEQnlysN3lWsRZOxM71nKtVGLir7Aqmin9?=
 =?us-ascii?Q?b9UiaU0xW9BwW2JwL4iPjJ63AMdWcAmm83X6098xgAkrF4lzhMZhtc9/Zdsa?=
 =?us-ascii?Q?xqVPpfzwogJu9TCLQx4onu0ai3ICvc3qDSrdwFYr8745QzaFw+4Na01VFgau?=
 =?us-ascii?Q?EonXJ35v67GMqUDepzaoNGn/qFkEkMMlzGUHNsZQUSkLMwZidZkNdEEr/tqQ?=
 =?us-ascii?Q?ho+TKGBf6ahBOBwGMjMQjl7aKkZZWMTZXhvnQTLEkGTd5l1pfZM+CyIRS4Li?=
 =?us-ascii?Q?lLCLyA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afb0bcd-7bde-4c43-1d02-08d99a3a92e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:44:21.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDA7X0QZHVTVXV3nuCJ4aZD7HXRAYO/KumfkRl2NxKcG61jkauhoQvCgtpOi8pWkJONfikYO6UMRggC7Xf8v5yFj/ywocp8qqM7x3s3GENg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3449
X-Proofpoint-GUID: 8BDwEUCU1uoVi1Jyriu7_vScXdIHXMu5
X-Proofpoint-ORIG-GUID: 8BDwEUCU1uoVi1Jyriu7_vScXdIHXMu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_04,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=495 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commits are needed to fix CVE-2021-20322:
ipv4:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6457378fe796815c973f631a1904e147d6ee33b1
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=67d6d681e15b578c1725bad8ad079e05d1c48a8e

ipv6:
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4785305c05b25a242e5314cc821f54ade4c18810
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a00df2caffed3883c341d5685f830434312e4a43

Commits [2] and [4] are already present in 5.4 stable, so backport the
remaining two fixes with minor context adjustments.

Eric Dumazet (2):
  ipv6: use siphash in rt6_exception_hash()
  ipv4: use siphash instead of Jenkins in fnhe_hashfun()

 net/ipv4/route.c | 12 ++++++------
 net/ipv6/route.c | 20 ++++++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.25.1

