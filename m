Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9128F44D316
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhKKIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhKKIX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:23:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EAB161177;
        Thu, 11 Nov 2021 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636618839;
        bh=LYmAHq44d36uGm8O5OwzSOPuFUQOFDcOWK1YCWwHIfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=G4cKhAvz4FVXbN7eaDGfQDKN5lSDnYJZJmr2kWVZJQ8PSGpdMagOb0zTmVbTCgkLp
         69XJ1wp9EI0ebJhwU4tQh/UeGRRwkZwXlsqmYS468jUxSWMyEH9WtIseO8W8LRsnwb
         T1e9rYxamiPF5thiS2W8SanUPlFw7uZW+9R+NMmSKbuGJsuIEpkyZsWLSqkRGd49Mx
         pym8NXHtuY561aIvw1ZpY9LQf5369BB24Vl/RKy23tr6xi5FK7+iNH1liOEOMr9eNZ
         ZP6SAomUz6hFWEJ0NyTGdXcPOvFEw21ryyl+hkyc61+AZxD7C1tWF5RMbW0ulMBRmE
         kmM2obF6oo5mA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, sjpark@amazon.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon: Add 'age' of region tracepoint support
Date:   Thu, 11 Nov 2021 08:20:34 +0000
Message-Id: <20211111082034.13323-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <d7edb182-7d49-712e-2d21-7b9f7ae2e4f1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 10:04:38 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 8070 bytes --]
> 
> Hi Park:
> 
> On 2021/11/10 下午9:16, SeongJae Park wrote:
> > On Wed, 10 Nov 2021 20:13:14 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> In patch "mm/damon: add a tracepoint", it adds a
> >> tracepoint for DAMON, it can monitor each region
> >> for each aggregation interval, Now the region add
> >> a new 'age' variable, some primitive would calculate
> >> the priority of each region as a weight, there put it
> >> into tracepoint, so we can easily track the change of
> >> its value through perf or damon-tools.
> > DAMON calculates the age using the address range and nr_accesses of the region,
> > which are already in the tracepoint.  In other words, user space can calculate
> > the age on their own.  Therefore I thought putting age in the tracepoint as
> > adding unnecessary information, at the moment of the implementation.
> >
> > Of course, I would missing some use cases that need this information in the
> > tracepoint.  Furthermore, adding just one more value in the tracepoint wouldn't
> > incur a real issue.  But, I'd like to know why this is necessary and how much
> > benefit it provides.  Xin, could you please share that?
> 
> I think these two variables nr_access &  age have different meanings, 
> the nr_access only reflect the
> 
> period of  sample_interval,  We may be able to get the change of age 
> through continuous long-term sampling,
> 
> But I think this is not very convenient.
> 
> We only need to observe the change of age value a small number of times 
> to replace the continue sampling of the region.
> 
> For example, age has been increasing to 141, but nr_access shows a value 
> of 0 at a certain time. Through this，we can
> 
> conclude that the region has a very low nr_access value for a long time.

I understand that you don't want to record all the traces and then process the
huge trace data in user space in order to get the age information, because you
want to save disk space and CPU cycles.  Is that correct?  If so, I think that
makes sense, and it would be better to put that in the commit message.


Thanks,
SJ

[...]
