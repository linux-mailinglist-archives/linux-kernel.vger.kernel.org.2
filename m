Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD4451C17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbhKPAMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349053AbhKOVTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 16:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF09161B3F;
        Mon, 15 Nov 2021 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637010996;
        bh=yJnT71RrqUI1R/Zlv2dp3VyuSlK7F9VY+3cz3B1YfBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P67gNDW8zZLZYAPzwAZz2rpG4qd2SR8VtXoKSz1MJGuSXZT6S0QTtcM7MNRxxeH57
         /odAc1QdoS/eDF9kbIr061lq39bU6wBW4762tN4TE89EcYJ7Ekrjxl/CGp3UM3WyeV
         mLJCeFEanuCn23gzic1mU7vsgwr3ZoNHJspbmPlY=
Date:   Mon, 15 Nov 2021 13:16:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] hugetlb: fix hugetlb cgroup refcounting during mremap
Message-Id: <20211115131633.81e1879e36aed4a0290e6f0c@linux-foundation.org>
In-Reply-To: <20211113154412.91134-1-minhquangbui99@gmail.com>
References: <20211113154412.91134-1-minhquangbui99@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 22:44:10 +0700 Bui Quang Minh <minhquangbui99@gmail.com> wrote:

> When hugetlb_vm_op_open() is called during copy_vma(), we may take the
> reference to resv_map->css. Later, when clearing the reservation pointer
> of old_vma after transferring it to new_vma, we forget to drop the
> reference to resv_map->css. This leads to a reference leak of css.
> 
> Fixes this by adding a check to drop reservation css  reference in
> clear_vma_resv_huge_pages()

Thanks.  I added cc:stable to this (550a7d60bd5e35a was merged a year
ago) and I've queued it for 5.16-rc2, pending suitable reviewer feedback.

