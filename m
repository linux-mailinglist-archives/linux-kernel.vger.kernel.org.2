Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7335C345C73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCWLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:07:49 -0400
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:63841
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229639AbhCWLHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhJ7m7YeHyQPXkhFgGTFL0cA9VnSpsKoF9Sx7Ijmotpaeodz22v775/3quJa+xNgnc73B+n7+sBnyvNCIdxQNjXWGiKeTn3DHZD0NWNhBTHEIdMvtCVYb6ZvWe6s0xqWO38eEJl+R6mbiBP2ZTPq/yRo/m3WWCldgnXlYyMv1WEpU0txQQvafhuNsTorqEjkNZhHLGv3a7NZiLZm04LCOg38rZPUDVlHvI/rGsPNBk1ZLaOyrJW1+ofveHRN5jMwznjU1u/6jEW9Rwb7R7EE52R+I8YADNF2v7txPkm9e/8GoD19BWE7gLZkW3gqufMIedsmNrEPnTLyfVjZyD1b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1tyotLYDKFTIR1ZfWSvECsNi9rba1cF/BYjH2Kw820=;
 b=gh2YtWuN1t6Bex+mxinhUlN9dZ+PDvpbksWl1TkuctFUtvRjZv9N9loMMAroTPtYHPr80cVT/pOX5ac1vCvq4KXiBL25N0nBL/ZuY+grgC/DUYEBw04ovUJT3RZA0xSyc8eiuuDjTQYnFFoQ+/rqbALq0a2NuetIn286MzWC2uhTnYbQ6CkzJbCZ66nFC+Mvi1eYN6sZeKgyhA2PIYzulUAuw6M8+fh9ftqN6JxFRJ9+9hZNJZTg3dadSgq8tFcj1/OT/cGaj8oKPuFJY9zTybhsJlc4ruZlmFVoLJa2RCLRhuTflDqxLPEdQXV5WQSbl7i3yzIMbY5Id15ifVgB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1tyotLYDKFTIR1ZfWSvECsNi9rba1cF/BYjH2Kw820=;
 b=HX7RW9zTKJghZ+mZ8kA6xx7t9A2dWFGE2pj/Sa0jmYR2O+Xw5VIO28wyg20om3uhPh6mZiju/LueAHWrblmKaR/6t551jmbaXsAJ4ffXnhVovg0j3Ds3PsHcXHe5VXOA+s0+MGon5pAIr6BTqPGPeTLEAqpZyT8z+gOZsNUNRln9TUVmAw7qAmo2UD/9JuBWfUv3UtrXH6kZUvrVNMkYsIUk0wTmDVn1qCZ+EtKhZCdWdtVoNbo9s8hos2hydYu0KQuQ6YgyUDNL4D55xERCf3d/+XzmJrBF2A2AJ26UnEG/cZDD10KjpxAS+2Q2YG4YrDWOhqORYsXhuqSGEcVM/g==
Received: from DM6PR07CA0037.namprd07.prod.outlook.com (2603:10b6:5:74::14) by
 BN8PR12MB3267.namprd12.prod.outlook.com (2603:10b6:408:9e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Tue, 23 Mar 2021 11:07:28 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::ae) by DM6PR07CA0037.outlook.office365.com
 (2603:10b6:5:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 23 Mar 2021 11:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 11:07:28 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Mar
 2021 11:07:25 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <jglisse@redhat.com>, <shy828301@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] mm/migrate.c: fix potential indeterminate pte entry in migrate_vma_insert_page()
Date:   Tue, 23 Mar 2021 22:07:23 +1100
Message-ID: <5999334.9xz1uWCbsP@nvdebian>
In-Reply-To: <0bee2243-5771-4969-7b92-aaca67abc90c@redhat.com>
References: <20210320093701.12829-1-linmiaohe@huawei.com> <20210320093701.12829-4-linmiaohe@huawei.com> <0bee2243-5771-4969-7b92-aaca67abc90c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392122c8-7b54-49a3-fdfc-08d8edebd8d8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3267:
X-Microsoft-Antispam-PRVS: <BN8PR12MB32679E27AEAF2B7ACE7CA6E9DF649@BN8PR12MB3267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQMEoYT3q6YZu1lOpnWd16oUe23q9JaKD1F1uAyaQupvF+uHrm++ydW5NdgX0zan66BCe50fZGejgOBsEOCodZkrKOMSwDF6JCIL785hk1h9fEWjaYWMMsbwPA0Lq5wRvEHxgHt58kY30TAbWacadZTWryu2/PhMqlLVNcfULNrzKebN1ZSE/C0tirl5AN95esoiIdoHTkFLB1Uj7lAJJt5hVH0MgYSkKrHcdfr/TqNNY3p2RXXemYrjJIOI/ZsMMSLwfPfB/Za9BtSr+MTNDT/FjcyGm60B0H3SAGHNrWpyOimGU+CzWuj/4oWdc6kRAQxhNhTnPHfl9cbYnmiopR0Kvew1Ug5R6LVty6U2qcpdU61GZlkxnSxSoeVJLJnGeKdfFXI4spgcdvFFs/uI7nBUq/Xfa9I+HiBmP+NdvLFFsp8i+ga1GT6zbOc/Gxee6bSIMoz6FTutO3/qGmoEY3IGWv6ALj+L5Lr86Cq7i0xzG/P8GI30o70EbdSX9scs2CJHPM7meNJGNzXnNthYF4RKzoratjStInM52J8Rig0Vx6lsdRAEVVAGfN41uAerdq7p4jmPkgFX9n6kuxcV1lbDxdx1dmU1hD2vgzZXXAammCimaUwi2QShVg/w7NpBDRaCm/WmwlJH9P4Rq/+SfIWGmgHxZsOpe1QzwR2YdS9xrnDe6Pu1M9+6GcRT9Ze+
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(36906005)(478600001)(53546011)(47076005)(54906003)(9576002)(33716001)(6916009)(5660300002)(36860700001)(86362001)(316002)(82310400003)(356005)(2906002)(16526019)(186003)(8676002)(70586007)(4326008)(26005)(9686003)(8936002)(336012)(70206006)(7636003)(82740400003)(426003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 11:07:28.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392122c8-7b54-49a3-fdfc-08d8edebd8d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 23 March 2021 9:26:43 PM AEDT David Hildenbrand wrote:
> On 20.03.21 10:36, Miaohe Lin wrote:
> > If the zone device page does not belong to un-addressable device memory,
> > the variable entry will be uninitialized and lead to indeterminate pte
> > entry ultimately. Fix this unexpectant case and warn about it.
> 
> s/unexpectant/unexpected/
> 
> > 
> > Fixes: df6ad69838fc ("mm/device-public-memory: device memory cache 
coherent with CPU")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >   mm/migrate.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 20a3bf75270a..271081b014cb 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2972,6 +2972,13 @@ static void migrate_vma_insert_page(struct 
migrate_vma *migrate,
> >   
> >   			swp_entry = make_device_private_entry(page, vma->vm_flags & 
VM_WRITE);
> >   			entry = swp_entry_to_pte(swp_entry);
> > +		} else {
> > +			/*
> > +			 * For now we only support migrating to un-addressable
> > +			 * device memory.
> > +			 */
> > +			WARN_ON(1);
> > +			goto abort;
> 
> Fix it by crashing the kernel with panic_on_warn? :)
> 
> If this case can actual happen, than no WARN_ON() - rather a 
> pr_warn_once(). If this case cannot happen, why do we even care (it's 
> not a fix then)?

There is also already a check for this case in migrate_vma_pages(). The 
problem is it happens after the call to migrate_vma_insert_page(). I wonder if 
instead it would be better just to move the existing check to before that 
call?



