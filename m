Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974B232D06A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhCDKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:09:35 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52678 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhCDKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614852548; x=1646388548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=zjvvgWC6kbPk4Ox8xKpCrUziEcj1fMQtGf+j9LYto/E=;
  b=E7zI3vDmLDsaTZF8VxAfh1LFh+yZ0fddahfxj6KOOF5I7mrmC7yFGa0p
   xfTkXWD6IzPw9Wxq/0dSkPt59SQIQNC+K8F01CqLUzpvEBdgAv3TcfhVh
   X2qFGxwKjQUFSJsKl2v139VZCvDUgsQB3VP3d5pb+vZ/YGJfcWA3BqcJK
   M=;
X-IronPort-AV: E=Sophos;i="5.81,222,1610409600"; 
   d="scan'208";a="91330729"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 04 Mar 2021 10:08:21 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id 1A29CC0680;
        Thu,  4 Mar 2021 10:08:07 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.39) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Mar 2021 10:07:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <greg@kroah.com>
Subject: Re: [PATCH v24 00/14] Subject: Introduce Data Access MONitor (DAMON)
Date:   Thu, 4 Mar 2021 11:07:32 +0100
Message-ID: <20210304100732.7844-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204153150.15948-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.39]
X-ClientProxiedBy: EX13D29UWC001.ant.amazon.com (10.43.162.143) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 16:31:36 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
[...]
> 
> Introduction
> ============
> 
> DAMON is a data access monitoring framework for the Linux kernel.  The core
> mechanisms of DAMON called 'region based sampling' and 'adaptive regions
> adjustment' (refer to 'mechanisms.rst' in the 11th patch of this patchset for
> the detail) make it
> 
>  - accurate (The monitored information is useful for DRAM level memory
>    management. It might not appropriate for Cache-level accuracy, though.),
>  - light-weight (The monitoring overhead is low enough to be applied online
>    while making no impact on the performance of the target workloads.), and
>  - scalable (the upper-bound of the instrumentation overhead is controllable
>    regardless of the size of target workloads.).
> 
> Using this framework, therefore, several memory management mechanisms such as
> reclamation and THP can be optimized to aware real data access patterns.
> Experimental access pattern aware memory management optimization works that
> incurring high instrumentation overhead will be able to have another try.
> 
> Though DAMON is for kernel subsystems, it can be easily exposed to the user
> space by writing a DAMON-wrapper kernel subsystem.  Then, user space users who
> have some special workloads will be able to write personalized tools or
> applications for deeper understanding and specialized optimizations of their
> systems.
>
[...]
> 
> Baseline and Complete Git Trees
> ===============================
> 
> The patches are based on the v5.10.  You can also clone the complete git
> tree:
> 
>     $ git clone git://github.com/sjp38/linux -b damon/patches/v24
> 
> The web is also available:
> https://github.com/sjp38/linux/releases/tag/damon/patches/v24
> 
> There are a couple of trees for entire DAMON patchset series.  It includes
> future features.  The first one[1] contains the changes for latest release,
> while the other one[2] contains the changes for next release.
> 
> [1] https://github.com/sjp38/linux/tree/damon/master
> [2] https://github.com/sjp38/linux/tree/damon/next

For people who prefer LTS kernels, I decided to maintain two more trees that
repectively based on latest two LTS kernels and contains backports of the
latest 'damon/master' tree, as below.  Please use those if you want to test
DAMON but using LTS.

- For v5.4.y: https://github.com/sjp38/linux/tree/damon/for-v5.4.y
- For v5.10.y: https://github.com/sjp38/linux/tree/damon/for-v5.10.y


Thanks,
SeongJae Park
