Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87A23D9C26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 05:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhG2DWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 23:22:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:18011 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233297AbhG2DWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 23:22:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="276576559"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="276576559"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 20:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="517969699"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2021 20:22:26 -0700
Date:   Thu, 29 Jul 2021 11:22:11 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuox.liu@gmail.com,
        reinette.chatre@intel.com, zhi.a.wang@intel.com, yu1.wang@intel.com
Subject: Re: [PATCH] virt: acrn: Do hcall_destroy_vm() before resource release
Message-ID: <20210729032211.GA10306@louislifei-OptiPlex-7050>
References: <20210722062736.15050-1-fei1.li@intel.com>
 <YQAcnpQcO8h8/l8V@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAcnpQcO8h8/l8V@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:47:58PM +0800, Greg Kroah-Hartman wrote:
> On Thu, Jul 22, 2021 at 02:27:36PM +0800, Fei Li wrote:
> > From: Shuo Liu <shuo.a.liu@intel.com>
> >
> > The ACRN hypervisor has scenarios which could run a real-time guest VM.
> > The real-time guest VM occupies dedicated CPU cores, be assigned with
> > dedicated PCI devices. It can run without the Service VM after boot up.
> > hcall_destroy_vm() returns failure when a real-time guest VM refuses.
> > The clearing of flag ACRN_VM_FLAG_DESTROYED causes some kernel resource
> > double-freed in a later acrn_vm_destroy().
> >
> > Do hcall_destroy_vm() before resource release to drop this chance to
> > destroy the VM if hypercall fails.
> >
> > Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> > ---
> 
> Do you also want this backported to older kernels?  If so, you need to
> put a cc: stable in here, right?  I'll go add it myself, but be more
> careful next time please.
yes, thanks for your kind reminder.
I will pay great attention next time.

> 
> greg k-h
