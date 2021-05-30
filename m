Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB033951F5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhE3Q1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 12:27:25 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:49276 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhE3Q1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 12:27:19 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14UGPEmA026430;
        Sun, 30 May 2021 16:25:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 38v7a6g549-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 16:25:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blrCPocS/n4KCJN37HEtq3+QZifiXOyO0xjaOvd00nYn2qOCjyW40f7YspxZpY6HXapp7ZDSiq4SNlyUhsXls+kWx6OcX4ow/ZBO3VaoDiOBmGSPwtQzX/qBCyWKzlQRCT9B3odbotcGRbaVobNidrCNCroFo/tT/5QI0OG/Sp0pJcn/cPYiEzTdGgVV5ANnnFJFf2N5E8/OjwxulcXlJoEOClIZ7o70I3kjFyJgeEX6Xwns8mVfrMuceyRyXjosvb0ThNGiUvq+7IQC7RVeKltKp+dVg8letuUPob19S8pgWZhDnAF7ehcgZohL94a/HuZBVU2J53vXCYE5qYHJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBvRWlbhfGJj09c6h9jpjYxlwN8snOHMQxsFN2Ipwc0=;
 b=hSdm5vPgV+/K7qBoTUWGGazv/nPYUP7XH+oQC1/WEEYEU+2N136o4MU0kcUgYXtvm4wdDYq6+GQ1PnTShpCXx/NSu2ktk+BBFZihGnvPL+H4sqLZWw6ZtLQp/BFPojmk6p7ueDnYrdg498bWQych+hRrTomIgHvwJr4p5Hw7R4foYNeNInXCMwuNeau462anX6sCWLS4nrCACOPj3+Gqg7+piclgmBLayeO3oS29aye2xB6slsftWd6+KgL6tTti2IfGM7g36AZKxmk9AxTH5JrkLO8KkkMrTSKqJAP7PcJKHao9f5pfaJTOYWwi4/erYkXtQ2ZnYE7WBQSvLC4Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBvRWlbhfGJj09c6h9jpjYxlwN8snOHMQxsFN2Ipwc0=;
 b=BvZ0JzIq3FPp9Kte6bwIndJ/62qoZhBa0qEfI2wJPNl5vCLRiHk6XSEFuUDIOh/JDts1IMKrig5tS6yRJDQOZw6R6zbCGj5qrd6taPjBMuMpuEHCMjbcypNPV/AOvTUTLifBzKk6EYuVoQF3bgyz9yyBbs1G2KuoF8dEYRgugSg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2633.namprd11.prod.outlook.com (2603:10b6:5:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Sun, 30 May
 2021 16:25:11 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%4]) with mapi id 15.20.4173.030; Sun, 30 May 2021
 16:25:11 +0000
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
Subject: [PATCH 0/3] x86/reboot: update docs and limit O990 quirk scope.
Date:   Sun, 30 May 2021 12:24:44 -0400
Message-Id: <20210530162447.996461-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26 via Frontend Transport; Sun, 30 May 2021 16:25:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3228e9a-2f7f-41ec-1d11-08d923877f72
X-MS-TrafficTypeDiagnostic: DM6PR11MB2633:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2633E842218EBBAA5B69EF2C83209@DM6PR11MB2633.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crbPVf3+vpK13UVIlslrIIrgO7Add9noekuqRCLhOiwWBqgK8FNC1M15+R2HKZeZlNb3vdtwTByCzlcgxCNXsG0H+6nE2eZLJNkdPKA8SOA8u7WPczMMLwUKZK0oZM1F/+IyrnVFTVYY1j3bOACSwLZ5sB2sJwnEkuPmxWR8KfkBjT7/jl6FKmChZlRHFH77ZZFMFSdze6BinUCE1DQfj32wgEbo9VKZfVNNWEBykRwGfvna77saJobqcZjFvjCFigl+/dzVqyyzoHZEDoHh7p5WxumLZIGI4qctI+DKsxkQBwGj7Lqf1hd9ojPYuQyiZEVF3l/qRiy2SpVEw7eguoVkGELMxpw46MSmK32+9y0enqmEs5uUv7HL1hzQgQy10IzA0HJBDImESo5FNYokEoTfRfMjUxK503HV4gp1ciSyGGJxBZCRCy9HJtroOU+qo43tcDAnjIY986iPP7vDawqAhMNF3jbmO8sFnWN5ZsMLK/RO0VBZKqOTAp2tifrjS55p7CBm+Cw5LO2DTAMf5FBwiix4bi1kyg/4sGPhYOfDojyGQHkG4m/l95hakxuntHOtsJRyZsznNMGArqe0+i3SRZP/qqFTaBLdle4cUnN2emLC3Y9uu2Rz0AYKnVwCY3sENOLelhBpWJHsFc2v+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39830400003)(396003)(4326008)(8936002)(107886003)(7416002)(8676002)(6486002)(6666004)(478600001)(83380400001)(956004)(44832011)(2906002)(2616005)(15650500001)(1076003)(66946007)(66556008)(66476007)(16526019)(38350700002)(38100700002)(5660300002)(316002)(36756003)(54906003)(186003)(86362001)(6512007)(52116002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6RpdR0jBxA9VtwyVBanvT/9r+ncZD+a3RbAQX2uGwGfApE/DSqnWgwswB/J+?=
 =?us-ascii?Q?2IMqMj2JNmVrMiL+jhqaQVU96Ra4tpg9Ch7hgAZcwlUnP1WpmPsdApa6XhW0?=
 =?us-ascii?Q?nZ2nKdrQCzA8wi3AYlbfJRMpsbH9cCqF1eDZNjcQDHL99IdOeoSwLkJqkmVr?=
 =?us-ascii?Q?Kvl0GT5BoktDRUwcPFOmOr5A+WRmroIWYtx4nlE90YEKI3QT5ImPAoWoo4Lz?=
 =?us-ascii?Q?1TX+lsjbV9Xcx6dxSABlUBLNieHuy1tssDKQgzWd1c7FE1jgubquGRJKO7DM?=
 =?us-ascii?Q?DABDE2S/rGXFfYh7ZJeuBLxXJdSIRahs3AlNCXRnGnGntgifrN3rvnwJlAEz?=
 =?us-ascii?Q?2daLm7HxIiPSh+3dUojxOJ7LAd0Lh2ZzYdfCqcFLJ/DtEMViygjt9FVU+GVJ?=
 =?us-ascii?Q?v41fT1fsAQANEt8zxxQOFXTvm1uqla64J2EMmAVtBZfnygqA7160B/Hr1gsb?=
 =?us-ascii?Q?KE/rUW99McHAf1K0FU5cVEqHGorfYBAxNAZRIuUoau52OQ7h8TXTKTO2cGJu?=
 =?us-ascii?Q?8gDnpcFnIaRUN4zyneL+0+GNH1Y3zvFeL578VJPgxU6BXIe0+460j/vMmBui?=
 =?us-ascii?Q?R3FwejxXSd7QcQQnNS/HK/zb8lxGt5LSFECApB7UnRNmxQvnEVKo0Jvg7kDx?=
 =?us-ascii?Q?UMmZ7MHzo2I9U0v4FpTVcmE08YbdvnytTZbVm9dHyaADREwYfUmvLD2gnh3r?=
 =?us-ascii?Q?A/+ws/uFxR7kOkdDEJ/qIWvyds9vlJAT/7Cf62L8jCgUsL9cvoBqQqjRmV/0?=
 =?us-ascii?Q?jAZXcdFqjbjBBhhnE855jAMPT2u+af87spwMArNWtQO9rOEizWd+gwZSeeHx?=
 =?us-ascii?Q?y7rYLEGOJ6cfzxpjs4FebxHCuhQJc1EtIC3Dztsf44j5fIRrgqv4G2dKeMrC?=
 =?us-ascii?Q?p08LYFGYyClnmt1KhBqxcF1R87a1MDSt/Lz/qdQbE7QWNl8/M2x/XQEYSbes?=
 =?us-ascii?Q?Md9Dnw4Kho+bxt7MDcjbTszjzep58K6J+vqrvjP3eJG0+GhHYCy/A0wkfb55?=
 =?us-ascii?Q?d8owabYYm4gpeQkAqyJDNZg4dSRDnyj8c2W+QIx+kdqqoLwwYD7YEipkN79r?=
 =?us-ascii?Q?PDyhJ99ZTKZMV7ekqkTpwiH52/xlPndSavW6rMJd+rziuKAEGGjZ17YvqrhD?=
 =?us-ascii?Q?SG83QAWs2Fc0BhTS2I5yTpdj9nKuf9vlYEFD+U49UeldEU3sZKdZFvxAFXYM?=
 =?us-ascii?Q?cFA41nUd/7RoBv+truZEHtDv+Ddpuose0avmBXJFNlGOPp4B/L5X6HXqs/LE?=
 =?us-ascii?Q?kN/3ER+uuox2P9zbhXheO7EPlF9JIdP/NBW5OjchzCKyM3vqmqfUCswlrkHq?=
 =?us-ascii?Q?63zGskV76o7gG3aRaQnZDbE2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3228e9a-2f7f-41ec-1d11-08d923877f72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 16:25:11.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+8Bk24ox70y24qiPwYWo4nBw9equVdAQGgJjytv/m9A4Z5V44ee7mjSAabwsVxgSVhNOp2a0s8PC9zCoMxop4PkPdoUFF6ND8XUSPBPYJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2633
X-Proofpoint-ORIG-GUID: fTryrxjMSoA3mGbDxGu_QDHTC2OcWrPW
X-Proofpoint-GUID: fTryrxjMSoA3mGbDxGu_QDHTC2OcWrPW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-30_09:2021-05-27,2021-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105300128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using an older Dell Optiplex 990 for boot testing, I found it quite
annoying that the stupid thing would power right down and then turn on
again a second or two later on every "normal" reboot.

After a bit of investigation, I found that it wasn't the machine that
was at fault, but that we had put in a reboot quirk about 10y ago when
the platform was new, and never bothered to check back if it was
required after the vendor did the first year worth of BIOS updates.

Along the way I found that we never properly documented how to avoid
using the reboot quirks, or the reboot=pci option so I fixed that too.

---

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Michael D Labriola <michael.d.labriola@gmail.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org

Paul Gortmaker (3):
  x86/reboot: document the "reboot=pci" option
  x86/reboot: document how to override DMI platform quirks
  x86/reboot: Limit Dell Optiplex 990 quirk to early BIOS versions

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 Documentation/x86/x86_64/boot-options.rst       | 11 ++++++++++-
 arch/x86/kernel/reboot.c                        |  3 ++-
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.25.1

