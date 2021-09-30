Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0B41D80A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbhI3Ks2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:48:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44496 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350027AbhI3Ks1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:48:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 406152244D;
        Thu, 30 Sep 2021 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632998804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNpEAPfqLAT1sidWYZ6xZ12IH1z9JTW4BAwDBqrqY1M=;
        b=uho8J6OpexOUbOsojbEXfHP1SySqKDqXzfXn0+V7jn1Aju7vwb0NXIJIUouFeDj2PP7fEG
        cwNVk/U8fS9VnlQpOnpnZV1rtjwvwj7Cc6mz8gZocMjmtU4T888uMJWaSSHyiD/A0slolD
        ulsYnsnszM/w5eM7VbdYgllGX6Gl9EU=
Received: from suse.cz (mhocko.udp.ovpn2.prg.suse.de [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BCD67A3B9E;
        Thu, 30 Sep 2021 10:46:40 +0000 (UTC)
Date:   Thu, 30 Sep 2021 12:46:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Support hugetlb charge moving at task migration
Message-ID: <YVWVk559nm2xZ98R@dhcp22.suse.cz>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-09-21 18:19:26, Baolin Wang wrote:
> Hi,
> 
> Now in the hugetlb cgroup, charges associated with a task aren't moved
> to the new hugetlb cgroup at task migration, which is odd for hugetlb
> cgroup usage.

Could you elaborate some more about the usecase and/or problems you see
with the existing semantic?

> This patch set adds hugetlb cgroup charge moving when
> migrate tasks among cgroups, which are based on the memcg charge moving.

Memcg charge moving has shown some problems over time and hence this is
not part of cgroup v2 interface anymore. Even for cgroup v1 this has
been an opt-in. I do not see anything like that in this patch series.
Why should all existing workloads follow a different semantic during
task migration now?

> Please help to review. Thanks.
> 
> Baolin Wang (2):
>   hugetlb_cgroup: Add interfaces to move hugetlb charge at task
>     migration
>   hugetlb_cgroup: Add post_attach interface for tasks migration
> 
>  mm/hugetlb_cgroup.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
> 
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
