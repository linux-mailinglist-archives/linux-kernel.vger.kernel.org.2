Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D38F363C29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhDSHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:09:54 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:17120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229952AbhDSHJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe2kgjoZxTZTcxtiFqyRF3nex8sXPQCue4ISDj+u+ZnBf3F4j5lXNb3jEemlckH3G+vM3wQihT/tEqzt5yCL2WueVsz03SPdJxjd0hQE0EEPFpccbnJOsqe2TFrwLjdUI3jPXFbQQY6Oj2bjfZ6y9MetKyZDH5wrhRTA0CnDmiZg3obfEAYxrhoMOOvEUL9uWP/G4FZX/JBrSCmpRYFBOXpq8SkeW0gs9YbHnfY9xfzPzEi4hYcZwFV7onCvoQexaGIuili+xtKe9B1GiTPA7gEXX0JGItuUOWhbV7J94RPQCzYNnw8uVxV4WbJmXfVzyApU4AHnUMqHAo9oHs6/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HQ1YTvUfzAYd5y3j7aql+rzALuy4NrbxjW5HaUZ3TI=;
 b=I9ha1iIZxvyaaP53IdobIfcGhRFw7D1Mu/JMLV9dQb2anu5yDtZtn24lUZ+ocT1lGiEsDGZYXQzdRjfEvssvS8/F69NkkIVBeU+/OEM2r3+wt/lATNu945sRlfWhh71PCUQHRcG/3Avgx6fhu7X1A4FI58s4LPAIkbZ095QEBwWZ/dUlIPiRQuy2I1QdcRhs+zRKCRzS7pKxeSfGflC9+mzty66Rmw8jpjtUmH8SDoLrgHJHqzto53c8VTiuVPzir3Nzbaz6v23VaAjsahRk70wAZZePz3HLAvI24krwMHhtN70FFld27fvEu7T8t8afvbwrq9lFAx0F4TGLO4WMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HQ1YTvUfzAYd5y3j7aql+rzALuy4NrbxjW5HaUZ3TI=;
 b=LOlTSJM2gdomx29su10YLqV6/wwUsWAI+2+kvjHSqxOPHf1ie89NX4AcMq7tJMqAkuL0Ei/d/3VzciOvH81QKCAvy9t3QMpCYo5eXYWhFJvU8lqLKHT3Un0EgiOKe97q2fDoYDMvbJCT9pvQBkz0yJvIMyNVKKehh3lcPb84vOR/kwoSkXWL3q1UgkNxQr3+UpY/xB4XVmJwajDRq+LGTpVcKrCWYnQ4Abc9k1kMg3pad7dtJuUxe9/bfjLw0IRpDqN5iq31XMgt5wJU02QxYpxVugpBCEykw896+tS3HnrsDvIB/LduG6lsAsLj6b75Of1T8eSKgjhgUwREnSRlPQ==
Received: from MWHPR17CA0054.namprd17.prod.outlook.com (2603:10b6:300:93::16)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:09:23 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::16) by MWHPR17CA0054.outlook.office365.com
 (2603:10b6:300:93::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:09:22 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:09:19 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v4] kernel/resource: Fix locking in request_free_mem_region
Date:   Mon, 19 Apr 2021 17:09:17 +1000
Message-ID: <2293351.fO05fxkiDZ@nvdebian>
In-Reply-To: <CAPcyv4grDqR09QWv68sJY=AXMDom5MSj40nOHaE+nKP9d9qc+g@mail.gmail.com>
References: <20210416025745.8698-1-apopple@nvidia.com> <CAPcyv4grDqR09QWv68sJY=AXMDom5MSj40nOHaE+nKP9d9qc+g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d633c053-7262-4330-4271-08d903020ee2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52057B013A5B68977EC4C4CCDF499@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /f1iDABhSKX/h1Sq2UALBEQBax/yy9uYaDfB1hJUYyXQGWD0Pbs2TnnFRM0TtX/r3Ka2iIyl4Z8IULhPChNTJVn/eniA9Vd+mXSuYEmYyoADnDdayuHFYQiM/UV4rrSQnYmUIisEhdTAOi+bj/WeHbau/AbGenIFEel4VtKRp8/kgV9+hTkb5PddQi7IbDLxsWd+PjamG2nZ0QlqVBDbVSO2xtJCBmCXwJyxb6OylsHc3Z0V5L+Rnj+bqjoiL5qaTh2M5jA4o5gJKJsx/P9SA0xdJrU4Z0rX/EvlikVIv5VOXT1qdWmBhE8L0csROsAmkcJ/O7ojrPN4Pto4XmTUZ/yizq5PXA8M97LVC9UcF17STQ0WzsMUOxN/0EGinu10SBRMO2xRm1dxD6S29bHt5zw6VgbvEbttQQXklp+dvLEQtuTSbhJs5H/FYap8NZ+L2JWR4Z85Xshas9KMBtO+V2CaBOkj2E8NL4d8HWSEZ/uKxYSlqNRBaVWHzz52v1za9nSshZDw28Pb1lKA99XsIC5Ctv7ii5nflpKf0McKKkCfffh9pwxUcpa993b2fREiTfNBURwPvJJ4VhvY2KnmA4A/y8aJ7F6o9ZJhADPr0EjFR3I173LN8idgiuJ5/wqPRZcurHTt1s+DACJ7MD9WLhUnbICvf3onrTUGM2OPJ3VAYSZSWdfDHaZTUh1xnWpz
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(33716001)(8676002)(7416002)(5660300002)(4744005)(82310400003)(47076005)(9576002)(82740400003)(4326008)(316002)(26005)(7636003)(36860700001)(83380400001)(16526019)(86362001)(9686003)(478600001)(6916009)(70206006)(2906002)(70586007)(426003)(54906003)(186003)(356005)(8936002)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:09:22.3113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d633c053-7262-4330-4271-08d903020ee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 16 April 2021 2:19:18 PM AEST Dan Williams wrote:
> The revoke_iomem() change seems like something that should be moved
> into a leaf helper and not called by __request_free_mem_region()
> directly.

Ok. I have split this up but left the call to revoke_iomem() in 
__request_free_mem_region(). Perhaps I am missing something but I wasn't sure 
how moving it into a helper would be any better/different as it has to be 
called after dropping the lock.

 - Alistair



