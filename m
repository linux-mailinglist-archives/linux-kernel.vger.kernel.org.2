Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F167945A261
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhKWMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:23:01 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:44815
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236987AbhKWMWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:22:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoDtKpH1lnacTmdIUSr9o3jdRclhp5Fxj+Ul0omMJFBMhvqxicuHVN+YJ+OuWl0W6nRztlyKueT9McxsFVHgnkAZI5FT04903pFQUzhhRi+VVVOfFg8J1rVzxPoBCnOSOE/g91tERaKEwfj3qQp9W4XhqvdSp+elN4N0s8ayqK9JN815T1D5NeUI5pM0y7cbkRDv58OXb1U4qKZp8lvh+pdsuBDimbbq4wiXcoe8fVS+5puJ8knXp0guZDAbhEZCatcywUR0+5ZhCjIGuv9KYm2v7LgDVnlAho5Kachh8qBi9b56u1VNetcspVxT8hhXp+aSCM+IMCZAdIF+WQAa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3LyXZV6RtQOodkJlgyJdXTtsO7SFPRZ4ji62WXAtc4=;
 b=dBUrkN37lM/FooOZnNPTe80e+1nJEEXUlLaV/AhQYeFynUhSopH/S7+cM3OSC5iOhQuGzURlEwrMf1ZLI45i48BA36OXk6Rs7Pc+PmSyB0rvwzpEJ4VBVVnEkEe0+ZAls3+ZEo07aRRb3TxaTNt1zCDF60QeZVv1a3zwuv8buCv7jtzSn4asHqqU6PGK4BOXYV8J/tG0Xd1LNjetzt4K+cRJEisEny2LdKXv8V6hrAC3bpLW/EGebrSBNgD+uDC6XckXH6BcNDEa4nzBCtqYwjkfzJ2g3DdRNJmXLlEf1ZhmxZhJBb7pVo+n2lDVY9hcRpsHhAjoDIMYnq5bFd9KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3LyXZV6RtQOodkJlgyJdXTtsO7SFPRZ4ji62WXAtc4=;
 b=e+aRg5f7JkxN9aB96MXsyxz/MroB+a1KeZ5S+bE5TMaP3qdl8xXhJy6tLfeWRaLlSBbIWWhOhPGGSSrx0v9BsiRzInBQXRDL/wBbjztDvCXvtxQ3uoWFVa8IWcOCP1zcuZ2KPo0/tSpRh9z9GQSO31h3Xz4NFdSSvNa2tYhBeRo=
Received: from AS9PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:20b:462::14)
 by PA4PR10MB4528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 12:19:42 +0000
Received: from AM5EUR02FT029.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::79) by AS9PR06CA0022.outlook.office365.com
 (2603:10a6:20b:462::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 12:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT029.mail.protection.outlook.com (10.152.8.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 12:19:41 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Nov 2021 13:19:28 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Nov 2021 13:19:26 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id D302680007F; Tue, 23 Nov 2021 12:19:26 +0000 (UTC)
Message-ID: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 12:19:26 +0000
Subject: [PATCH 0/2] regulator: da9121: add DA914x support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a66bfe6-6a39-4a27-cb97-08d9ae7b86f2
X-MS-TrafficTypeDiagnostic: PA4PR10MB4528:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4528422B1D9E1875FAF1A785CB609@PA4PR10MB4528.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HW3BCxJf9KDBMfXtgh4481ULTaGPYyBQvW1UoAHNyO+rXQNCO5qldAHOltt8Hvo4PF7pIKKkZHnYZ3/ef59GqMCQJsAa7xxKlxGsIqosNiYEnnSh4fzX3luZbDP9xBlFZ7hZtGqb1MNTFFn9ClHNqLPYuaFfaGbY+KkGkRZ5kvr87o6u0TlBQrOw77einMVKx4VthD2KpcmTHsYWjLN+nNYnWEoahFkMBhW8nBS808/FdqAm9T5+gl2x45yr8TCbtU1N0zC4OK+Rx1KPwaW7G65ahho8Pl08E47RUOg7PXUDbOrEtFxRzs+b9JlknCGWHVDH04F0zVz9jKA+9xn+o+eK5c6hGNh/4EdoHis47LIO8e2bqbP+GbbhQkiMTiap9OHwuEas2XtwQFV1424dUEDX4xmdeT/MUbNUzmmElgc5+vCsLcm8/Y9ARLp2mOD5EOHSVN3ob5LixTKYm+zD7TtX29W46jehrWSOOmsLfoUyccbPzZRbXBHTx++n6eySdhdTppe11fP7qLoVJLQBfQ6x2n8wil9fDOeX95W9tCX6PyjC5LkTh8UPUhlUeaTkxhv2MtnanEzAR6FKYlcr16YI+jGd5QbiLu6tCoCkSLDoslraXHkgvzxWfo81/e6awbynAqSp27ByuNji7Xqmb65z+DvNamKL/gVNlIDT1nW/Wo5GpesoWVq4UkHvHa2/8jpDlYfXLyRsN1ddKcYGKvVhT4wKrLVHxDx9iNeXJ/Y=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(107886003)(47076005)(70206006)(8676002)(81166007)(508600001)(8936002)(356005)(6266002)(70586007)(426003)(4744005)(336012)(316002)(26005)(36860700001)(36756003)(186003)(2616005)(83380400001)(2906002)(42186006)(4326008)(54906003)(110136005)(5660300002)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:19:41.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a66bfe6-6a39-4a27-cb97-08d9ae7b86f2
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT029.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the DA9121 driver to add support for related products:

  DA9141, 40A, Quad-Phase
  DA9142, 20A, Dual-Phase

The changing of current limit when active is now prohibited, for the range,
due to possibility of undefined behaviour during transition


Adam Ward (2):
  DA9121: add DA914x binding info
  DA9121: add DA914x support

 .../bindings/regulator/dlg,da9121.yaml        |  85 ++++++++-----
 drivers/regulator/da9121-regulator.c          | 113 +++++++++++++++++-
 drivers/regulator/da9121-regulator.h          |  21 +++-
 3 files changed, 182 insertions(+), 37 deletions(-)

-- 
2.25.1

