Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42B03CB13E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 05:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhGPD5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 23:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhGPD5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:57:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E684761004;
        Fri, 16 Jul 2021 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626407656;
        bh=VBAtGkxB3dOHRQHcI5VzJSvvbYZ0fa3F1yO9d4nP2do=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ze0LJ/UDm85gnDzQFaXuz/qoXf+0ZHIRoCAvpAD3D0W5+RO5YeMRk/hmSnho6rvk0
         mxbVdoV9CSKIj2DavDIKhV07v3cr5JOjZm6pYffUFr5UP9V5n41RTpxtGYxE0v/7tv
         NvG1Q1crcKRBB/xiZ0AvkhvPIvZ/3BrtXACAiqE0=
Date:   Thu, 15 Jul 2021 20:54:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de,
        weixugc@google.com, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -V10 0/9] Migrate Pages in lieu of discard
Message-Id: <20210715205415.2d6842be57032fbdb2cd2a82@linux-foundation.org>
In-Reply-To: <87k0lrndc6.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
        <20210715123836.ad76b0a2e29c0bbd3cd67767@linux-foundation.org>
        <87k0lrndc6.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:32:09 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Thu, 15 Jul 2021 13:51:36 +0800 Huang Ying <ying.huang@intel.com> wrote:
> >
> > The [0/n] description talks a lot about PMEM, but the patches
> > themselves are all about NUMA nodes.  I assume that what ties this
> > together is that the PMEM tends to be organized as a NUMA node on its
> > own, and that by enabling migrate-to-remote-node-during-reclaim, we get
> > this PMEM behaviour as a desired side-effect?
> >
> > IOW, perhaps this [0/n] description could explain the linkage between
> > PMEM and NUMA nodes more explicitly.
> 
> Hi, Andrew,
> 
> I have added some words in the [0/9] description to link PMEM and NUMA
> nodes.  The updated description is as below.  Can you take a look at it?
> 
> ...
>
> With that, the DRAM and PMEM in each socket will be represented as 2
> separate NUMA nodes, with the CPUs sit in the DRAM node.  So the
> general inter-NUMA demotion mechanism introduced in the patchset can
> migrate the cold DRAM pages to the PMEM node.
> 

Bingo, thanks.
