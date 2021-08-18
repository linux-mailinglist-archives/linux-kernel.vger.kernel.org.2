Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA83EF72C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhHRBIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:08:50 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:11873
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234706AbhHRBIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSjSx+eWymgchiks/D67YIPOEHr6qV5WYF3/NCSvAiMhxrGVoY2j2Ex8Rw3leXHtogjQ698Emdkb5o9IoTpdCDimpxrsD9Llisw8eS8ZNr7wH2XZtFHY2urfnRKk7iPXu9M8BlrnFytzT+iEihyGeorOWpnguD7RSwcpRleCA9/+IRybtzz2QBXnWEPAr0FlHLadh8NjnjGNsieJQcuqH6FYl0BQWfcGFo7DEE6tcILV+TBcTU7jioT3YJFIYwmfwHQIxEUg5DGuZ7BCMPLFho0AzhTS1ExMsDQSaP2TZS1E1/vcV3dBgps/iM4h20htawy9jSf0vmcy5jzPkUKRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44J6goVMv4C/iEr1/J/IrcU6E14eAEnJrzoD8E3Qz4E=;
 b=Q9TNiQEgnl+jl5MrjnauGif/rF57o2N4usGRCDff9i3017CSPxTc3tHjH3+4A24kSHkN12wD4PfNO0pnRIPkyfIW81vlg2uEk6PhOZfhsDMz22mYiV2IpfVTTgSYNZdPyt8hHtFe/6Mq+Qr3E0Mza2g3tod6W1Z7WazQKsWKufjWyciNC+GdNPCxmeBMVtt1xNDX4yLtGolyXE6ap2QpiIr9BJRUE4w4oghzN2UNyvfrXK5iVNLWfVGHkfvMUsCmMzZ48hSqCCSSnjDWwRwfnvtfBIt6rCg+Lx5W4VDryixTj7Ocn4wdU+ttxJxkN4tmIHFDHvKJZiWDb4AWgbZf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44J6goVMv4C/iEr1/J/IrcU6E14eAEnJrzoD8E3Qz4E=;
 b=YnYYazgWeyR1Qh5CfnTxjt4L5DYNz66T/3k6xlMGhzGFfmk/rjSX23AvUr1skUKSU2W/IjBsmnBZsHqEUVajO+DcA+71Ho93pxZZPLGfXPFfebu9cfZr71cRsgCyrId3lEeqxQCIxe4+JCeS5PwBLbgFQCp8Z8FsAWF/3w1K2O0=
Received: from BN6PR14CA0035.namprd14.prod.outlook.com (2603:10b6:404:13f::21)
 by CH0PR02MB8028.namprd02.prod.outlook.com (2603:10b6:610:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 01:08:13 +0000
Received: from BN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::6c) by BN6PR14CA0035.outlook.office365.com
 (2603:10b6:404:13f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 01:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT059.mail.protection.outlook.com (10.13.2.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 18 Aug 2021 01:08:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 17 Aug 2021 18:08:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 17 Aug 2021 18:08:12 -0700
Envelope-to: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.34] (port=48952 helo=xsjdsteger51.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <daniel.steger@xilinx.com>)
        id 1mGA3w-0006E4-60; Tue, 17 Aug 2021 18:08:12 -0700
From:   Daniel Steger <daniel.steger@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Steger <daniel.steger@xilinx.com>
Subject: [PATCH] fs: sysfs: do not remove files if group is null
Date:   Tue, 17 Aug 2021 18:07:57 -0700
Message-ID: <20210818010756.3300864-1-daniel.steger@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6615bb5f-6dea-4e90-4ffc-08d961e4a701
X-MS-TrafficTypeDiagnostic: CH0PR02MB8028:
X-Microsoft-Antispam-PRVS: <CH0PR02MB802827B8CFC5423F0A0EAE80C1FF9@CH0PR02MB8028.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFvuSNoCK795jTdFIquNtWVjDU/BEKoFuZmCrgV+ZI90ePvIOpAiHEWYFnwWcrCuNRRlXd1X3L2rXvo/PoE+HOAVVMwQvEjAU02jYiTdM7AOYa1+TFvE9hSZlBNe7FSOp16Jz7u8x/d3h4ZyITas2DKI6o569Lp+jFtP2KqGwg9Fbh6EESn2JruvygzxmVyn9Lcn56TsqOfbmgKcTzetARLcWO7SqXDkekDfWQCh9jA3fW1qCSlvBuk2nqcSgD8QUgJVbiSQKXmuJAAzOhq7mRWq5rRqroBOXPQoce1BxsL/EI2dhDAnVczLBVywg9tmphwx85QBmUDzSp5TkDJ8lPrUICv4xGnbqzbYWyQJ2wjF2/Ik7pwlJm3w9cddCwxSKE0x39iQrbfJoh3SxFcA7qZCINljTK/IcHJM1D2179s56JoQcEkod/G3MJk1rDuU/VglsbcA3riOQIF73fcMItoWmIwNSjYIiwxmpS1PfZEVQuKalb3bCOiRi35BKx1WBD3SAAbVCEwK+Xp9db5wjI31mgBQ8c9oV3Jp3aT4RvXUuhy6W3VqOc3GZO0nBg0WbvmFuX89fpr/TLa1fx6jUkdY5Uzwj2VatODN0ucTzDP5iHrW1gAKWpjuQIGS4Ifvu9HO1mUmjDtyIFxTKZNQiTlSkSQSG4XevGUsNEbwGVui7e89/98U1F6LlQJmiteYeBHSk1LdRim0qXyl5hKyf4J7iQ43xHuxb4A4cMPbgvU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(54906003)(44832011)(26005)(2906002)(2616005)(478600001)(5660300002)(8676002)(36906005)(110136005)(336012)(426003)(316002)(7636003)(356005)(70586007)(7696005)(47076005)(107886003)(70206006)(8936002)(6666004)(36756003)(9786002)(82740400003)(83380400001)(186003)(4326008)(82310400003)(1076003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 01:08:13.0625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6615bb5f-6dea-4e90-4ffc-08d961e4a701
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation allows the remove_files() API to be
called without checking if the grp->name is null. Ensure that
the group name is valid prior to removing files.

This patch fixes a race condition where device_del() will cleanup
sysfs entries prior to device managed sysfs entries. This results
in a NULL group->name and a system error during device cleanup.

To reproduce the issue, simply create a new child device in a
platform driver of your choice. Add a sysfs file group using
devm API. On driver exist ensure to unregister your child device.
Do not call devm_device_remove_group() and leave it up to the
implementation to automatically clean up the files. Here is where
you will see a kernel error complaining that the files have already
been removed.

Signed-off-by: Daniel Steger <daniel.steger@xilinx.com>
---
 fs/sysfs/group.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 64e6a6698935..023b40840f36 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -286,9 +286,10 @@ void sysfs_remove_group(struct kobject *kobj,
                kernfs_get(kn);
        }

-       remove_files(kn, grp);
-       if (grp->name)
+       if (grp->name) {
+               remove_files(kn, grp);
                kernfs_remove(kn);
+       }

        kernfs_put(kn);
 }
--
2.25.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
