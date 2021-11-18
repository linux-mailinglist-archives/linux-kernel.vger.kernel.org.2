Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1BA4561C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhKRRxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:53:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231787AbhKRRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:45 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHmixr020976;
        Thu, 18 Nov 2021 17:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ryTyoEm1TPHUh3nUYVWD+53Q8xF9hrTlAVEjAvJ26G8=;
 b=FyiL8KaCowf6yZYYK/Eu/UmLWo6U0lsAnU5nlCM8uMr0xvdGdW44X5JcaqnVxDJ0aM23
 hd2cDrig4FWcXE/sRqOkhu28bQUzp840+fgfYM/9wEpZxQTLp6APD1sBlQH8GpR7QE8v
 2EAuRHUhi7B6NWszAv7hvRt68gOznzUImFqdQ3VD8u2ImPIcoKqil1nTXQRUG2quESyW
 IJwLKm+B0QzYqGman+Ym1NfjDpI15fEZ0QO+mS7FQPFL5r+r0OQF39dc7mj0vp+2/ZgU
 6bA9tMRw/3kNu7u2CP5rI5+xnBfTG5FIhGMar7FqcgdV2yaNg+ag3b+Os+1XVwEsmaIb gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd4qyr969-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHkJ1r102670;
        Thu, 18 Nov 2021 17:50:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3ca2g0vm7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f83P1wcQl/SPvWKXSox9Q4ahsxaEkfEj9fp20aIswVFxAvcLtN2RMByP0bxhoROW0Aj8u/ytcSpUiYG6HauLF1sA7YcQNn3JZHFc+6W9/qXT9zdaM9siX6SwY0hZol3Gpk/jAe3CIWvu6rsSbxsy6Y+EYJN3n30FHKQBDTUbtl8RjmXUFMNjlxQ08AzPb/z6wNWget9vLs3359myYc/xnBiN9WzFrE8zfzo/5P2emFra1w0YxJeFcVILWPi+z+Qk3IFEanIIBMKp/Fym4CJhQJuTWwRC+MWMHfw2ciXQuTUGIajXTRbq2FIqNom759j89A28CmYaOZZJqOX8hA6krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryTyoEm1TPHUh3nUYVWD+53Q8xF9hrTlAVEjAvJ26G8=;
 b=BO087grEtnQp1yEPmMyADuj6cn9NAL8NICYcPrRYUR9ivFIdQxHIQVlf/Ax6BOQEBHbtBrLAZBFZ+i80o0fsge3kaSexrZDOVvBUxJ3wbhz032mpwwUkqd7DIwmb5S9hszxJk+isR08Ov5ygI+SzmS/GLEYrIrNj5pKRIcKsmlgiIugOK5boDC5WVn59EuHglDO/ayMX9O4apTOTw3K9ZuzIj/OqvhYJPxMInMnuM+6K3XPCuvKssBn1D9xhXA6NW//ZEyArtL/ycoFmlwC4uGYVSp5vHT9O2llk3xXMFtF8mGwym8bSpNzgVLxaTvMc1UJgDfwm/x7AqMPaHVpOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryTyoEm1TPHUh3nUYVWD+53Q8xF9hrTlAVEjAvJ26G8=;
 b=WaaSOW4QbEyI6zRORRwe7/6RkXEE8f0ROphk1I+lT9gmh2l32RMkEx2B7a0ogy1CziKcn9y4Jv7QcNoIIXRWIWuMNUlYTavAujuInKsKJxpYlz5bH7RpY1HW7+yTsT+bLDbj+L3TJUvlTkUfEAVO7FSYNph7vYaycLkLxJjVXeM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 17:50:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:07 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [RFC v1 1/8] crash: fix minor typo/bug in debug message
Date:   Thu, 18 Nov 2021 12:49:41 -0500
Message-Id: <20211118174948.37435-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb96391d-a165-4cd1-eac8-08d9aabbdbd1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1389:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1389872F8BB9454EA44B30E0979B9@MWHPR10MB1389.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isbrvecZjBX7UvYSlTINQsFYakNxqJVH8YwJ7SCwdTWtU2uF8+Hqz5o9KeCmV0DQf5cThVXvAcGNiR37HId1CbuoBgWvfNhpvOBIs0SP5HASaLeRHZvGKUaPVPVgTROglWbA4LAnzqwKWee9AALvefzQHG8d/+M0AyWXMk4m2lYPKLnl+loyFoW2xxyFconJVRS25vufsTD8gPshVO8rYZEstSubkqAOcTmeR5hznEM//STp5/4Nup21NZJkloKYDkUfoG6Ga5h9hk6X8dEKb/rK0E1yZN56GEQ5o5nC4ZIU3pvYMDVQCd/U0IcyuYGhk2/MB/4hi5qRCk9ym7PRQTDk+KB+MxHY/x35OZCHrsbyU4/MZtpDtYp/qo5dV834/7R7DozZy0K7DZJDDTghzK3apYyFx9hz2LV3zCjhn0rXGRYC7v5qz/i1ABDAYwyrkONURNVCcToOhMGiK6knpAGbv3zCpmRhDXdO9JbPukB+a/y8R2hZC6ejSFkkTzITiPYq7pJxELf/7jlymRR1yZQxEUTmdakxb6GboKCaz2+bzwm+zq4fxBl5vdvkXfDLurWcDhsMJyVNy3jHSdVa3aZFAMNAPJQBVqR24D8mlLdexGtjSPLvXigGXHNThiQAINW87g34vuV4xwmSh9PVVECkCMNE+nn28sx5vN/kHHECAcmZOCmN8HVNS6d59BYeVt4RjQ5y1SFkmsmgA+bB3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38350700002)(6512007)(8676002)(38100700002)(2616005)(8936002)(6486002)(52116002)(7416002)(36756003)(316002)(4744005)(26005)(6666004)(4326008)(5660300002)(956004)(86362001)(508600001)(186003)(66476007)(1076003)(6506007)(66946007)(2906002)(107886003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wBr1XF6cwlAR/rPbFBF9vFSvCQPymUEJjNilC8E0N4n/6JkXZ1WcadLwqbhI?=
 =?us-ascii?Q?y8wCKoC7h/Ac5x1YyppoX7SfxGhuWwHGpsMFNRp5n2gi8r/fm8BFGqLN7Mp7?=
 =?us-ascii?Q?KB4DDXAPDHU6kP+YaMb8y7Fvdsf/S+5tYDkvVMaAOQ5HXLnhcZ+r0ONouO9W?=
 =?us-ascii?Q?0b1w58Empq6JF/hm6YiXK2sWngYfRnY0nL/bIslQX3uHDX9EDo4fpDX8jlTI?=
 =?us-ascii?Q?e6SvTEUOYryTqH6+YPKj4DNuMIfVR6wJPCCyOAI5owp/xfuyGQv67IJILiXP?=
 =?us-ascii?Q?bTKuPvJhssLJT9iRKl/Pl5I7EbB6bURGngeNk7c7q1aBo5v/bp7PZUZEV8/M?=
 =?us-ascii?Q?vqijlPJDWY4D7dyMg6fqHC+vlfJ87ZRHPTy+2Wz1KN9HHD2tZ6L5Qe+Fb5Ji?=
 =?us-ascii?Q?kxZ2emKiVzgLQoS69jbHQyu7/8VFzpoCgfwsqlorc/LYm0o803IaFMyWTIVi?=
 =?us-ascii?Q?/xOUDWcrD/D+nz6SgbWnXtotJ1Lv9X24x0adBpyjAUncAa9L+VPDkwbRV8p8?=
 =?us-ascii?Q?VI9PP7/9dN5rGhgbToTMeW2psNV7Tn8I1j7e8blIJnAs039TOtNl/49qDhTc?=
 =?us-ascii?Q?fovqJggwQlWSH8t48CNjKiNFEQVn5YWoXmZi0eJHW/9/jrIT400qDo/JWM76?=
 =?us-ascii?Q?l6mYZe0IMB9FhJqYUDAYWF0JDZsSHW+zliBoXszxUsuRLLIYmUuZcx4J8Uwp?=
 =?us-ascii?Q?Kk7/h71i0H2SBfQpd/4SJpbEl64b/xsi9eMQDDz95p+e6dp5allEU1P6SysL?=
 =?us-ascii?Q?NJkzRQaatjPhjcpEARNfiygnWVIRe5I4c2V23lWrEi4oljscRkO66HaBQw81?=
 =?us-ascii?Q?wOWEvqZnKV76x5sKoQvOk1YXeb1ilHTscdzCXO1ETMeTYfpO8gbfQMh1O1zB?=
 =?us-ascii?Q?tinViJ9vVj3XI0Z2fh0BOBZBAKTnOi1Bbz3ylOAZl/vxd1mzfHJzo13sf4tm?=
 =?us-ascii?Q?wBhzhHPk0gLfdEN41EFhTGxIMcsqqRHxeIIgb7lwCJJYRmq5qGwoVYWgFAwg?=
 =?us-ascii?Q?nJ76PZP0ETs3UUEG1y0lIt1zqcKmZZqb3YVDaHIJCmJM1hc+rngH9N9oTIDt?=
 =?us-ascii?Q?M+zuSRrPkQmA3p/RlcCeCcgrAzKCiw83QAuEfBrxSqZMsZ/yABtUaqvidiOe?=
 =?us-ascii?Q?Dk8N9Oi+B67gl+BZkt0OCFOVLin5ZCY8bEALuj+TxWsH63f+ntMRT5UE3OvK?=
 =?us-ascii?Q?TgWrAxZQ59deWiYOZQaFzxQccQvJJI1BzwLE8e5Nbkco030fh15zr75CpcOK?=
 =?us-ascii?Q?rOu/klUBjH6B7yxITdaXDuKLhL54E4/Yr3gDuBgz5UCVGx7tC6+KY8EX4EZ2?=
 =?us-ascii?Q?PUtxll/fThkMaPOXTiMdEEm9WI4BJ52KBWc/XLdvF0WM7TgaLFC+jZe2Nmr+?=
 =?us-ascii?Q?9RhKwk7CJRoZJHSB61NDTpUOWDVvdH9dOpHhrwByHd/s7YdkRgBuSm9iVrwR?=
 =?us-ascii?Q?LRsHIhJYVULOtEiAS6CQ8YBLVOsoInpIE794eEoLInojCjg5aQpgaXMYsW1J?=
 =?us-ascii?Q?/nhIKVhJNS3iZCqKw2ta7IQvAjDccUYbFue87uiYPMmRuC7IlMUSbcAV7BmH?=
 =?us-ascii?Q?/tDDqnLy648DXfeSP+asIfGfInXuf8SbDWJ5qQspAnIvbLGJYiRLo8XuD1uE?=
 =?us-ascii?Q?bGV+8Vigu4sselFcBaqzouw827OaZQJ6j7P97bgsbtG5a4A/RikURg3PAld+?=
 =?us-ascii?Q?VNHDmQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb96391d-a165-4cd1-eac8-08d9aabbdbd1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:07.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoqLSwqATkLICzA4ppKuCTTszRMLVISRuR4XHSFvuY7t1tqnbTIx9yN7ZQVzvFexTa+8wEVIU8qARR9iiN833JxwUeQHQZ+GNk/2d4pZEJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1389
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: UpInB1Py8vaB-6tGu-BXkvi6yBH09wpl
X-Proofpoint-GUID: UpInB1Py8vaB-6tGu-BXkvi6yBH09wpl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..9730c88530fc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
-- 
2.27.0

