Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7203951F4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhE3Q1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 12:27:23 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:49272 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhE3Q1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 12:27:19 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14UGPEmB026430;
        Sun, 30 May 2021 16:25:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 38v7a6g549-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 16:25:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua//E5oKqvJucHGlvSTQXzkaZmeCtZrZiGZgVEh1aJKP10ASsP0hCr04RpUIOsR4texJIF1+bvE3z+fFf88VUuZPLeFTQnTyKjI5f/ewV4SSllQ4qkorNJ/p3DV8Ihi/2rAY6tJJr+e1AuE8/ClzG8dfGN0VkwYfDyEWpEVw2eU7FxgQ2jYoNL3OlhbK5f1KWi6d9WeSTFjEjxieN4gMOmNv/yJTnlBFmb6dkTl2FKSO94nJWkVCLlX4eY18jktu5hPdZxmqb7NrtMc68q1qkYtK4jAuH7rr3s2UH+4HcJwLuQ36MKPituIYVa3UEunMzJKwR2rN1U9TQSTi1ekcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13YPp6MiXFCH74e3LqmkA+u2bT7UBK0JjywSVP16HcY=;
 b=oZA2FL21CYInR/tblk70Avbse02zedV5xUKCb+RzXB5jnp/Y3KA6GQlyuklnE2bhQDPTgZnLyoxzyZ7ljeyxDdUVcLp9WFw+Vqx5XKbsvYCY2xsy5xrBHXbe821Ny48BGTBJQ5eWEE8PkM46bziXXQpdOj4ADsHY2YmVT3H+NBLp5BCNbeK14t2LyrDDftdrwyhrqA6jWxpuRrsdRfY4+vMvFVgHhwfalkGP/Rs8dXKUdKxWxfkNGL+R1AFo5eKr2pYPTkc6XiuVyNHIM35/ZiTJ8LWi/Le8ZwqBRl6s4mfA9+l5CdB8241Xfb0l4uZUeHodaSGdmHmNj6/zv4jIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13YPp6MiXFCH74e3LqmkA+u2bT7UBK0JjywSVP16HcY=;
 b=Ptod7Jr6xsJ7jTIuXY7k7VbAmWryS3HAVIlgacNhoFAOc5+jzhOK9wRuQRh3ad+82azQVmJRWXWIU6qIekgV72hiGAviBphGQUm+dKEbROCixsXpsqKeGsq07AhtsP576JJPdhYywd1D+nSdYZFSWmvRqc3Ss4Rlyvz/V67i/AE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2633.namprd11.prod.outlook.com (2603:10b6:5:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Sun, 30 May
 2021 16:25:12 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%4]) with mapi id 15.20.4173.030; Sun, 30 May 2021
 16:25:12 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Garrett <mjg@redhat.com>,
        Michael D Labriola <michael.d.labriola@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Renninger <trenn@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] x86/reboot: document the "reboot=pci" option
Date:   Sun, 30 May 2021 12:24:45 -0400
Message-Id: <20210530162447.996461-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530162447.996461-1-paul.gortmaker@windriver.com>
References: <20210530162447.996461-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26 via Frontend Transport; Sun, 30 May 2021 16:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a11170-7a75-446b-5d8c-08d923878014
X-MS-TrafficTypeDiagnostic: DM6PR11MB2633:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2633C9FDAFB9774A7C18B38283209@DM6PR11MB2633.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDyK/K0PN/Bx0XaluCiPpR6FXvOIExxQLq05JdsU3fj8Jndy18/x5deTAMMKmxmXYnp5DjLeMLSJbB4npRWmOZgeadGBOOrgZvCIBxZKB2FphgYFeK9mUudhdk0HZf0bTaZvyupeyA3pvXyxXwAkKCY7s78NSlKhhOFPv8TW5e+5x6MSCMshC2Bs5n8TsO2OqrOuDJ8+SNGURleIC6ma5XU8NsuSZakrc7i8oJz+jnZ28uPuFkd6ScjxOq5Fnr/CNnp4LuGekUxpVXUxsxfN4t7c0eB+GhImewhi6Ain3DqCMb4JX61tY1dKsS3AASGJ4DXKQmlXOQX3fjEe0HWYH5FS/hytSaGvY0XW8Bh6HZveffGT/KMBzBcuKxl4lk+LxmE9e7AVMkXlttATGWc03kGTa15hvXdVbGAQvytx0eQnammYosf7l0PyTL/GePXfaYynTxoA1b1pkCDWEgknrg2Bn8C0Mds5qMZYYvygGB7cLzjNF8TiaP0FBrA5+Rbk1m2yK0dsnyXkNTqsg0NU3KtLZAacA1rZOw97twEzXq8DrV315D9OK6ZRUSoKV1dtL7rH17f8ujL7gfLP0gxQ7u7k7nVF4P20ht6TnDOm2wAIy1sEvw6CrESIU0YSonIdJFpFirNc3pzN7i3OynTBXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39830400003)(396003)(4326008)(8936002)(107886003)(7416002)(8676002)(6486002)(6666004)(478600001)(83380400001)(956004)(44832011)(2906002)(2616005)(1076003)(66946007)(66556008)(66476007)(16526019)(38350700002)(38100700002)(5660300002)(316002)(36756003)(54906003)(186003)(86362001)(6512007)(52116002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SZ5vEPtkcD+9zu7xj+zLR93rKJWWcdG62k2nPEj2RFzjZe+ZPEJVElRHUWtI?=
 =?us-ascii?Q?rRMAawpgWyhhtvEyF+LQptiuOpA8smDFKzxxg6aLEcn79uuziTLdPSXvoREm?=
 =?us-ascii?Q?xbdscT6obwLh3heKG26Xm9ChmWb0Jts2++2u9qhSJRJF4pJLBmqLY+cOvV/A?=
 =?us-ascii?Q?oe5h3rQA0t4P7NOO09YextvAQpQyrAZ9Xr47ZoMGi3IAp5NyHCFhuyWa4qo5?=
 =?us-ascii?Q?vwrwS9WSNZEP08o6v9wWvdjaiIlVG5T/by7HJEKDqLaoae8HJBITVoO+634X?=
 =?us-ascii?Q?hBNnrAuGqT4z+PoNIcKpaseWHLRpVLXvfuBqaeUIDluNd93CVpC7GpEnCjC5?=
 =?us-ascii?Q?xZ85R9HLlrnfwQWWekC1XH7bgcz7Vanz49aggZH30RLL2IwTAwKmNqS9sRdu?=
 =?us-ascii?Q?jzSmIkC6qM3Sg2v6nNkPHO5v3ogXsoPleBi/LcmhhGhpUykpht9MhMi5mqKf?=
 =?us-ascii?Q?34FAqQcjmGU4eKJYK2PSn4ak2PfbvRtDXTLqU80wzqLJj6CyhQvssj4z3+hl?=
 =?us-ascii?Q?/Hm5j44iEsdEoGngpHxGiRyfVETi+MH48B+5+KusVlrb4KcVUb2V1c3fETdW?=
 =?us-ascii?Q?v7aLL/7uZOgO9UnvXM1Y/p12epRGlEg36fWXA50OgWF82PYitY/48kciUg4z?=
 =?us-ascii?Q?oCjmbI/pyta+IBx5Kl2p6AImMazn09s9fxE/A4hngIkfAlgc6ghxdGWmVCZ6?=
 =?us-ascii?Q?25Yai5iiRDM0V3vWZY9BmTkQrxXXRYC4YcP/D0jEOusHyI3NXdaLirhyScFH?=
 =?us-ascii?Q?QtU1bmlMhIATc5xSsVUH0iZrCaZll+k9uIbcehZo1QfYt7gMkxCEwNnsPEmM?=
 =?us-ascii?Q?bAKEs9PScGTqzznCQlFsCJjuzxHpwoT8lbo+OfR11UF+s24DMw4MfR4cv2ME?=
 =?us-ascii?Q?hSFqWQ5IhtX+dRnlq7zNGaAb2/jPcyJNFK+G0PTL2NghSiNxRUBAQK+L1BNG?=
 =?us-ascii?Q?AJ0i7uYeLBfGhF84kCIPXMT7XTpgqZEjDXi9GK5dxoFcZxWncXqFJg8vr/4b?=
 =?us-ascii?Q?KG/ovGgs3nMHlqpqcZ9e1qdzDIVSGRTGdKCS6rydpZ73L9yHyaUXW++7VwWQ?=
 =?us-ascii?Q?hroYVwn2dyTc8f1Fc+gmOcGT0fu8jwl9FoYDC+6iPNWNwBrPaFLLCRqN1T9Z?=
 =?us-ascii?Q?H233Hzrw7TAJtVNzJwmhcu7hK0bxrQpFx6ksGgxdcHMYXSxW7vNcQqZWs7Ui?=
 =?us-ascii?Q?U9S/lNh2V5thgZCwl4MkMfAdHVvcJ9iOy3fDRXEKfTWiGqEWLvqYgZTayxgL?=
 =?us-ascii?Q?WQz74ngWK57SadNqOL/SA7ckn/vyqXgqTw1NWJE5AQZR/Pv7xOADIMzWfLFy?=
 =?us-ascii?Q?m/m9IJcqiafoHNvLanGKT/QI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a11170-7a75-446b-5d8c-08d923878014
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 16:25:12.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZG6JZImMoNe6yYSJ0mCnfVuJ8UqP4WntCh1KfLz1dB54s+Kh/vbfspO1Hi9g4FTnLj9JMUhSjY2KS7oaqyI8uqXTvVMN3Amm0JXuCoQHVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2633
X-Proofpoint-ORIG-GUID: 9DeurDpGMLOg9aWVs3NPXHwNQ5GB3X9c
X-Proofpoint-GUID: 9DeurDpGMLOg9aWVs3NPXHwNQ5GB3X9c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-30_09:2021-05-27,2021-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=943 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105300128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is mentioned in the top level non-arch specific file but it was
overlooked here for x86.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/x86/x86_64/boot-options.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 324cefff92e7..2d2810409cc8 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -126,7 +126,7 @@ Idle loop
 Rebooting
 =========
 
-   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
+   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] | p[ci] [, [w]arm | [c]old]
       bios
         Use the CPU reboot vector for warm reset
       warm
@@ -145,6 +145,8 @@ Rebooting
         Use efi reset_system runtime service. If EFI is not configured or
         the EFI reset does not work, the reboot path attempts the reset using
         the keyboard controller.
+      pci
+        Use a write to the PCI config space register 0xcf9 to trigger reboot.
 
    Using warm reset will be much faster especially on big memory
    systems because the BIOS will not go through the memory check.
-- 
2.25.1

