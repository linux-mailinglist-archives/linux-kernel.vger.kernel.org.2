Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54774169FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhIXCYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhIXCYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:24:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A33B26103D;
        Fri, 24 Sep 2021 02:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632450192;
        bh=ctCfw8qHq/1/s2IJwPV0nP8KA/ZQAL0nkypcKWxNDPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTPBfEd4jaMCiY2JfK5xgsf6d7mKAiIuNZVVFHP90JdFtrFt1QREhmFXntTzLbmun
         ME3VSaJG+IsZ1+NqRMz/MUnNVeOuagRUydHNvr4IVmwoEcCmFJ9b4J2HiUDsTYYWeN
         zCeLNKJ+pk5ziE7b4/z1iYbuTNSb29sRjZmFFdRo=
Date:   Thu, 23 Sep 2021 19:23:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <mhocko@suse.com>, <rui.xiang@huawei.com>
Subject: Re: [PATCH v3 1/1] mm: Fix the uninitialized use in
 overcommit_policy_handler
Message-Id: <20210923192312.53dbe65db0375038c99defaa@linux-foundation.org>
In-Reply-To: <20210923020524.13289-1-chenjun102@huawei.com>
References: <20210923020524.13289-1-chenjun102@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 02:05:24 +0000 Chen Jun <chenjun102@huawei.com> wrote:

> An unexpected value of /proc/sys/vm/overcommit_memory we will get,
> after running the following program.
> 
> int main()
> {
>     int fd = open("/proc/sys/vm/overcommit_memory", O_RDWR)
>     write(fd, "1", 1);
>     write(fd, "2", 1);
>     close(fd);
> }
> 
> write(fd, "2", 1) will pass *ppos = 1 to proc_dointvec_minmax.
> proc_dointvec_minmax will return 0 without setting new_policy.
> 
> t.data = &new_policy;
> ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos)
>       -->do_proc_dointvec
>          -->__do_proc_dointvec
>               if (write) {
>                 if (proc_first_pos_non_zero_ignore(ppos, table))
>                   goto out;
> 
> sysctl_overcommit_memory = new_policy;
> 
> so sysctl_overcommit_memory will be set to an uninitialized value.
> 
> Check whether new_policy has been changed by proc_dointvec_minmax.
> 

Thanks.  I added a cc:stable to this, so the fix will be backported
into earlier kernels.

