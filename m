Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD93E3D39
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhHHXuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 19:50:44 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:62327
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229903AbhHHXum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 19:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPVQ+OybM+HmaHYp0+YkqWkibzfBuub4Ti0g5rrSuAC/00XynUKTAt4t6Uh2TRzC3A+zkKzgadiwYomG3bUcLglRQdEZ0QyUFQSihM7M/pILjYn21VNv9xLWdo5H4j8Q/IwwD/buRnV1nq2stwzLZdcqETXVH20dWvCQpAVafIdGuH4fz3HZ/sJLw6+ukQltvf//7qWLY/PQKR1J1P6Gkg/aYGyfReQloZfdS5yUXOfGo/UxzHL8SgPNbw1XBY8LE6rJyDk03hOpazW6LkyL9I3Nr82cs4B9RY84VehxoQ1VycChmRsHUKRjyzIRF1b7QKTpI12uxl7NkfQBoSBM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8sQJBdoFZ7CpJbQvccslFvnnJyWhD0DeuCX5yG17SQ=;
 b=jDtOHKPg/c1VO0EY1wC8Ibs70AmyRVRNdgpzxbOPutREoCmBBfb2nmx9e1BOSBikXquTCEbx8Cs1ncmYF1xTtwiBQvxC4iVNSC3ql27awO3XfFiNcubzjK0oyxawZIp9YHdphqbP5lFuTAiVgqnswIU6yl0jvK9ib8wTFULHhCXDVHvVVdFagmV8aQZIV7gxH4FI4Cj15ZmlZ/4lxwR3/P+y4BaCDMxUxlSKnjSTzTBWNE0rwM4DeJQuqNWeGk+Phbo87VnQBspF5YcFoQBREeOLgp7hCTehcv+BUuCQSqdjXYY11UEWjYhaIkXoPZ+Ch9JPXWjREum7Au4vAsGwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8sQJBdoFZ7CpJbQvccslFvnnJyWhD0DeuCX5yG17SQ=;
 b=i0jK7S7HuxdinvQJDVhpMn+MvJqcNbAYyOr+8LoynbMob0lwerlxNu+UARIAGdWj25Erkry0RgPFmsRXsJ1l179URYki8TWR6/pLARYMnh428AtIEyGfu5U73HxvjZ4+eJF6Yi7Tm8MJkNSegfQ5L/L5kK21AgqC9LQtTr2k59vbeuKHJ/r9mXcRw8L/Xx4tDbqZZnS6VJCu2P7YUMX99grKBY4QQCq2S7MHKlIeqKvxYLCgv2HcLSzX8e7ETWlGMLEANVyDeKDHGi1XKKRR3O6XGRPaHq1+jRkntBi+g300kI3v8XvQ5MZpfmac4kQ4ZThBnOR1dkO02iYARWFDuQ==
Received: from DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31)
 by BN8PR12MB3458.namprd12.prod.outlook.com (2603:10b6:408:44::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Sun, 8 Aug
 2021 23:50:21 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::e1) by DM5PR1101CA0021.outlook.office365.com
 (2603:10b6:4:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 23:50:20 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 23:50:19 +0000
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 8 Aug 2021 23:50:19 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/3] A few gup refactorings and documentation updates
Date:   Sun, 8 Aug 2021 16:50:15 -0700
Message-ID: <20210808235018.1924918-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaef1b11-1c6e-4b6f-925f-08d95ac74859
X-MS-TrafficTypeDiagnostic: BN8PR12MB3458:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3458147961102D6FD60B8D5CA8F59@BN8PR12MB3458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3IcGH7rFq8LDlLjehNt1u7gieonrpX+WbxA22+MfhHUe8nDOGPcT7B+RKAyGQDvnC28/8EOXZ6wMjbzAAXdMHSh7KZmqoUMJkt6Y2dr3I+PYW4TabJWyLwOLhnK9uFJvkzqpSRPgn4i9J8G4Hd1TWVSXly4u3aA6+EQXeQP8O2VoVkj0ZW5WA7QG3XNplqHhYuPDZFxVRYs+PtDMDeEa0kaX8fEAQjGoDBYI4ShVwwJ+2Jsf2pYQC514dShaGraXJVWZJhafXanzMAVs+wyVMb5hUzhM056GWSKer/zqVVEKAKP3H9DJzUWeCy3yXVUq/lGcTYGd8G9EJNjujtWo7wvhy7YM6+TPvWpFHYWYz4vxjHxmiDWuPvJdYT+mfd9BJnnagI781ZShHfFqjuVfP0B/maqf7QKAmyIXPLuHiCFfddfo1kbV3qmKzbfl5TNBAUaLHihlGyxyxJb+smvz3oGcI5IxbSbE6u+7FUVtjH6Duwh8MFHe/Hea1VAELqNJloBpLbHaEflmdL6J7wyBhBsWrKpxa2vfQMeTFRbcGbWSGMa5M1E+Y77tGEDKeVjPFB4pe4uKOe6aYniBNv/gadqaqVogkc5Huhc1GSUy4d3I9odrJmIXHJM/VCPMjnozhbOlAd8I7sdZsKxlCrxiJl9vsP+BI5ZVRAst9MZzbf6Ju4wYlQq7h73loYkBhWhqRFB2IWwF3DopLHtazhYTA==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(6666004)(5660300002)(47076005)(83380400001)(336012)(26005)(86362001)(36860700001)(82310400003)(70206006)(356005)(186003)(70586007)(2616005)(478600001)(2906002)(82740400003)(54906003)(8936002)(4326008)(426003)(110136005)(15650500001)(36756003)(8676002)(1076003)(316002)(36906005)(107886003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 23:50:20.7367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaef1b11-1c6e-4b6f-925f-08d95ac74859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing some of the other things going on around gup.c, I
noticed that the documentation was wrong for a few of the routines that
I wrote. And then I noticed that there was some significant code
duplication too. So this fixes those issues.

This is not entirely risk-free, but after looking closely at this, I
think it's actually a useful improvement, getting rid of the code
duplication here. The try_get_page() in particular seems better now,
even if there are a few more "if" branches in there.

However, it is possible I've overlooked something. I did some local LTP
and other testing on an x86 test machine but failed to find any problems
yet.

Also, this is based on today's linux-next (next-20210806), in order to
stay reasonably close to mmotm. So I know that this short series doesn't
conflict with the folio-so-far patches in linux-next, anyway.


John Hubbard (3):
  mm/gup: documentation corrections for gup/pup
  mm/gup: small refactoring: simplify try_grab_page()
  mm/gup: refactor and simplify try_get_page()

 include/linux/mm.h | 11 ++++++-----
 mm/gup.c           | 49 ++++++++++++++--------------------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

-- 
2.32.0

