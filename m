Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5152145A640
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhKWPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:12:49 -0500
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:7045
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229606AbhKWPMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:12:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uen8YbnsoQDSf7OgT1UubwOhk620RGEoeoVJagkmf+47EdlTFj18lxIG8paHCCoX3lZ4GVmkGzeOY0ZT0ftvdiV8WhP8HGeOHo9l5JVkuHA/2+weDRjSLSk4nrMz5Pj6IvWQCg6iGp7DjFERfllx82L1JKWgqE9uaI1QPwFJfLYkU/3GLdV0MzGiyIKexEpLshMQDc98EUt0F1WVcAxCDnvRgRywzUMZU5or8pngo+xv8VUgGNt+P199KMzSJcz6qrxHGgY2tz+3orHELp9lHJ/OBQBiqeF9tz+chfrKQ5OvwutqH/vaFIXBOy73h7FGAbfAxpXsXkQLzCqcfS+BoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eICFyi9HUrhWSG54HRcqIfP28JZP5ewbc+OvTdHCy4E=;
 b=iVB7ouNDHWUDmbYs1KngBsIcUlr+7ECuw1MhEns9q/CXnRoFhLXS5r54/4tGXpSrdpqbl13VyB/x8RHpmyxn1UHCIa/osHOQRj5Wmy9xyW61zkHJ0w1NbwnCgDH84hzL3+b1BIVujuozfPs5cc8DwgPUGAaER2o85l9qS/0qQpJV8oeZOYdYVqCc2MgfOJGDtkgKjwYswwcDRzHOjTh6rbESmmx94dmSpGsWmyxItbqKeioNioYcpKFd4EO6vJlzowTYoGJr1TMbFaMRLQETJeID9ZHPbOWAGdz8RMbYKEKX2MnQ3tAPon99OsmyLQ82IZoqhJL8uy7govxCshi30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eICFyi9HUrhWSG54HRcqIfP28JZP5ewbc+OvTdHCy4E=;
 b=xm2GCfYAmKsrMyXQ/Dd6jCrmUoaGAMdBH3znygpN2hbQsNcngSlghXTiiU2nEPeqVIOKaos+bLhi5AjZLhBHv5pgI8MJ+H0vuf94v+HhBRl2hayQ1ZiL1Vo2gr76zd3Z9cF8WjUHliZ/a4z0LAAheWv20oYz33bcHGU5ioFwwz4=
Received: from AM6P193CA0128.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::33)
 by DB9PR10MB4877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 15:09:36 +0000
Received: from VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::e4) by AM6P193CA0128.outlook.office365.com
 (2603:10a6:209:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 15:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT013.mail.protection.outlook.com (10.152.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.23 via Frontend Transport; Tue, 23 Nov 2021 15:09:36 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Nov 2021 16:09:23 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Nov 2021 16:09:23 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 141F480007F; Tue, 23 Nov 2021 15:09:23 +0000 (UTC)
Message-ID: <cover.1637679551.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 15:09:23 +0000
Subject: [PATCH V2 0/3] regulator: da9121: add DA914x support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 285cde40-beef-4729-157d-08d9ae934349
X-MS-TrafficTypeDiagnostic: DB9PR10MB4877:
X-Microsoft-Antispam-PRVS: <DB9PR10MB4877E285A14164B4BDD58A88CB609@DB9PR10MB4877.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnC4Lm2fmhICZKLlC5Srt8Ue3SWHGDzSD3cPWZCMBpX00l1VTyFNa1CMPWRvnVcl3+8SMi6Z5RVJaiHiI1T6D5liq//JlTMMTOzi9jdN+/PU3x+fKxvhwASrel1oFxJ9LLbY7Lc/fEMgv9JmXBYYZ5wMA9N+elwotdyMyze1/jljwj+OeIpWb14gWUBSyApDV+Qtq0hS29FsYliCuGJPGOotOFmyxN0BN4vHNO95eS/ncs7uE+kKOTWqhSPzhAa+cg6hYUZal+gAyEfE7E1oa8V0hiFnvMBmrSDG2CrUDjt5Kpj/yp0yxt86HZHZU+wNRoTZbr/RlznCyMM8WCukdUrL4wctN3PPAPAjGFH+HgVGKtWI0vqo4ButRAhTZ2s+LudLa0/gk5AAjhGQy2pQ7kq3om2DmBHMHjjAn4msbm8M12V+FXnJo01ybOR7SbuPXmy8aLFulDAYbOOqMEanLxmofjFPETl6UF5hIGyyVDwan+TPhbwvZdBY8v3RN2JpCdoIwcPTSePEjZNqT4HOxdKqd0AudjD8Z7/7Kp8W4t31DL/LPwqCeVrUDxs1t1hekOlQDaIbR7Upn/TQc4QJuB/+5/0FkOORyV0muan6gj3t0/aRzgK23twLbH9JL3r/9/EuaC9UDv2TucL1XZ/E7pgrUugJvIo7xy1LdqQP6eMKrO9ge6NgKKym/Rjt3B1Ifa5H15PpgMT3+omVHLV8xQ2NFBqGdz1M6RmhkGtgOP8=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(8936002)(70206006)(8676002)(54906003)(26005)(6266002)(86362001)(70586007)(47076005)(83380400001)(508600001)(186003)(5660300002)(336012)(42186006)(316002)(110136005)(356005)(426003)(4326008)(107886003)(81166007)(36860700001)(2906002)(82310400004)(2616005)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:09:36.1280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 285cde40-beef-4729-157d-08d9ae934349
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4877
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the DA9121 driver to add support for related products:

  DA9141, 40A, Quad-Phase
  DA9142, 20A, Dual-Phase

The changing of current limit when active is now prohibited, for the range,
due to possibility of undefined behaviour during transition

V2:

 - Separate removal of obsolete/unused test compatible from binding


Adam Ward (3):
  DA9121: remove erroneous compatible from binding
  DA9121: add DA914x binding info
  DA9121: add DA914x support

 .../bindings/regulator/dlg,da9121.yaml        |  85 ++++++++-----
 drivers/regulator/da9121-regulator.c          | 113 +++++++++++++++++-
 drivers/regulator/da9121-regulator.h          |  21 +++-
 3 files changed, 182 insertions(+), 37 deletions(-)

-- 
2.25.1

