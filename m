Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA045986B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhKVXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:32:13 -0500
Received: from mail-dm6nam08on2059.outbound.protection.outlook.com ([40.107.102.59]:30688
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229575AbhKVXcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:32:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXu+E1ot8/sAuZMoH3s64q6BCY6SA77mum0tkDPoFgE2YU6UeiLPQId3IAi4r+mAWxXSsXh8mQ6RhG0bP2Q2ITE4QZOx1wM2Yiyj2wtODo5IjLHalu5AAoIAWyJEojsD90fKlhd4e1eiBWWr9Tzpy/qWHnpfoJoIkwhkGA9eZA3OHkJHDLKYd9ttLbbtlJeTGgar5zV9ppuKPnd/QdVi+4rcPzHGyURE0MKDdQed9KdbLL4T4KF/KeGc+sXcO8oOLJJbZVigcHVP306o0M/Op/Anz2hj5jtpB6WfbKM5/eiHSy2+Ew8qDf6NyvdoJRU+wW6pnzQxAtZcFBg/1ucvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qwXQOTsIP4ATxk7oCznQWA3EXkBFjDkh/AFs6uTG+8=;
 b=krVjLE3rgTSGeKoxs7SGrGCAGBpgJYJGxBiMVK1WwA8PpjsmcXuLG7zJlsL/J24yJWNMqxfp4QkSTlRuTo282+NlWk9EPGHKNxdeXN71kzLN+QnmE9arua8M7G/IMX1W4+oDcCEJZTIoW+J0HKedzAGKOj8UFnVOioeGjBV0FnAS1/3aSVl2+E7F1ffBzvzOu9Db53o+MGi2S8MJ4gfe4yBi9TEL1ZT7uhpQFvi4MVnZvziEZBORmLP0hUoSGcvqI7/aKAinUE54xX+DLSdvRS9OlNtBilrc/ZjukD44Y+RdfxEMVA3B+9oUfEji9w1bHMiJJnyi2ucNJmrZ0nS5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.112.34) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=nvidia.com; dmarc=temperror action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qwXQOTsIP4ATxk7oCznQWA3EXkBFjDkh/AFs6uTG+8=;
 b=IYhR/isw23L8tGKRHpn9ZvSxIK79BuJaWGdSbiyeE79jR94cf9eJNsjnLU6lklTNsRZ+SVk4fswJcvKs2N8KE68J8NZ/0vp336H3UV4kuOOg07limR5hApz7Gxp+qxbzIDEHbVqji+yeuQM6B7HUxCbqYo8c7U92L25Us7F2hgvbG1W4cuY70EZpMkyDhQkmO0lOKdgKLwARD4Q6unzAlrYtxlt+rsPzZfUdWU0YZsG/WWZc+oJv+3cv1H/s5jMm/LqC98hJflls0aMEb5ZNhxWVeefzwhIB/lMdkNLkdksCHWZj1ZOKJcvLOA2l9FL4N54lBNv1wU7QSg5JnkmyIg==
Received: from BN1PR10CA0023.namprd10.prod.outlook.com (2603:10b6:408:e0::28)
 by MN2PR12MB3709.namprd12.prod.outlook.com (2603:10b6:208:167::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 23:29:02 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::71) by BN1PR10CA0023.outlook.office365.com
 (2603:10b6:408:e0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Mon, 22 Nov 2021 23:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.112.34) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 23:28:59 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 22 Nov
 2021 23:28:56 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>
CC:     <willy@infradead.org>, <dhowells@redhat.com>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <jglisse@redhat.com>, <jgg@nvidia.com>, <rcampbell@nvidia.com>,
        <jhubbard@nvidia.com>
Subject: Re: [PATCH v4] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Tue, 23 Nov 2021 10:28:54 +1100
Message-ID: <2895271.4lBpGFk6aU@nvdebian>
In-Reply-To: <d2697d9e-92b7-649f-5afa-313350578286@redhat.com>
References: <20211118020754.954425-1-apopple@nvidia.com> <d2697d9e-92b7-649f-5afa-313350578286@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eb66bfe-d247-45d6-0525-08d9ae0fdca3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3709:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3709D31A29FF31282F7981B7DF9F9@MN2PR12MB3709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHTBSKnKxzAtizNWVq3T5jVLa71JE22v+nHVN1T9bfMwjGzdwdwqi0QZ1q8qD+kflrzMhYeWgjgVMeX4zW39IHFf3a9xeOIZOk6/rCdRsSDRPqNSFyPtnw8/fT5NcvM/L5vbzefSeQvltdjR/MhvUe2q1KwfxUJqvzytuDd7o2QlafTglsD7JUdEowf5Ds4WtFsglIDCEwB1OHgBEEmJJsHSfZjbQXP4RWWAXA0KyDKYkWJkZyW1HeXvEAWSsGKkKScVtxS8vpVJM66xez2xf74XCimPV8+x+g8rcYVmuqilT80W2y36VaUOOavbnFwLeJC5aDkZ4qNpdnbasv3fsq96EvwzeiwNG2WpW+Chw5l6MgrUgAcRVCK9wDSuMF0x7tP3c7+eOfBacRApC9/fXUThWFRVELR9fHQz72jzB8bLxuONx+gtKtGzrZUhMOlXdh+ZwD5FJDTstkOOwUPUmPC3yJX6Nb267qQYRi6jBcYWDH6inICaB7nnldTP1sMbHUMlVy/ebohMggmOtv2pXhKTidbJacGEcOTfKqIluiupH+x85x7W7tRis2kVIXUq+59Hoo1R1JFwYsZEyHNyN+ydJS0f38xvfXDLsgwgZyavnFC6Q8D1zxHpFE6LKmN3uQ9APAkR8QM7YACWZbsrKCwVXmJuY1GWEw0uaEdtkhTo6ct/F2tvnskSrxTQCskJaC9lJmUCA3LxMRHBvT9Q0qPstoDxTQST9hejc66rswo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(33716001)(9686003)(82310400003)(4326008)(36860700001)(426003)(508600001)(70206006)(63350400001)(83380400001)(47076005)(316002)(7636003)(356005)(54906003)(63370400001)(16526019)(26005)(9576002)(186003)(8676002)(86362001)(107886003)(5660300002)(70586007)(8936002)(110136005)(2906002)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 23:28:59.7410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb66bfe-d247-45d6-0525-08d9ae0fdca3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3709
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 23 November 2021 5:15:27 AM AEDT David Hildenbrand wrote:

[...]

> > +#ifdef CONFIG_MIGRATION
> > +/**
> > + * migration_entry_wait_on_locked - Wait for a migration entry to be removed
> > + * @folio: folio referenced by the migration entry.
> > + * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
> > + * @ptl: already locked ptl. This function will drop the lock.
> > + *
> > + * Wait for a migration entry referencing the given page to be removed. This is
> > + * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
> > + * this can be called without taking a reference on the page. Instead this
> > + * should be called while holding the ptl for the migration entry referencing
> > + * the page.
> > + *
> > + * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
> 
> You could maybe make it clear that callers have to pass the ptep only
> for PTE migration entries. For a PMD migration entry, pass NULL.

Will do.
 
> > + *
> > + * This follows the same logic as wait_on_page_bit_common() so see the comments
> 
> s/wait_on_page_bit_common/folio_wait_bit_common/ ?

Evidently this escaped my s// when rebasing on top of folio's. Will fix.

> > + * there.
> > + */
> > +void migration_entry_wait_on_locked(struct folio *folio, pte_t *ptep,
> > +				spinlock_t *ptl)
> > +{
> > +	struct wait_page_queue wait_page;
> > +	wait_queue_entry_t *wait = &wait_page.wait;
> > +	bool thrashing = false;
> > +	bool delayacct = false;
> > +	unsigned long pflags;
> > +	wait_queue_head_t *q;
> > +
> > +	q = folio_waitqueue(folio);
> > +	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
> > +		if (!folio_test_swapbacked(folio)) {
> > +			delayacct_thrashing_start();
> > +			delayacct = true;
> > +		}
> > +		psi_memstall_enter(&pflags);
> > +		thrashing = true;
> > +	}
> > +
> > +	init_wait(wait);
> > +	wait->func = wake_page_function;
> > +	wait_page.folio = folio;
> > +	wait_page.bit_nr = PG_locked;
> > +	wait->flags = 0;
> > +
> > +	spin_lock_irq(&q->lock);
> > +	folio_set_waiters(folio);
> > +	if (!folio_trylock_flag(folio, PG_locked, wait))
> > +		__add_wait_queue_entry_tail(q, wait);
> > +	spin_unlock_irq(&q->lock);
> > +
> > +	/*
> > +	 * If a migration entry exists for the page the migration path must hold
> > +	 * a valid reference to the page, and it must take the ptl to remove the
> > +	 * migration entry. So the page is valid until the ptl is dropped.
> > +	 */
> > +	if (ptep)
> > +		pte_unmap_unlock(ptep, ptl);
> > +	else
> > +		spin_unlock(ptl);
> > +
> > +	for (;;) {
> > +		unsigned int flags;
> > +
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +
> > +		/* Loop until we've been woken or interrupted */
> > +		flags = smp_load_acquire(&wait->flags);
> > +		if (!(flags & WQ_FLAG_WOKEN)) {
> > +			if (signal_pending_state(TASK_UNINTERRUPTIBLE, current))
> > +				break;
> > +
> > +			io_schedule();
> > +			continue;
> > +		}
> > +		break;
> > +	}
> > +
> > +	finish_wait(q, wait);
> > +
> > +	if (thrashing) {
> > +		if (delayacct)
> > +			delayacct_thrashing_end();
> > +		psi_memstall_leave(&pflags);
> > +	}
> > +}
> > +#endif
> > +
> 
> I'm fairly new to the glory details of core migration entry and page bit
> waiting code, but it makes sense to me and removing the temporary extra
> references is very nice! Feel free to add my
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for taking a look, really appreciate it!

 - Alistair



