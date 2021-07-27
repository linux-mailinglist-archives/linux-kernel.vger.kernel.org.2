Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986643D78D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhG0Ot2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232493AbhG0Osl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46BFF61A61;
        Tue, 27 Jul 2021 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627397280;
        bh=pH8HPs5Id8eNg6CEW6PPAa2BFa+aZ4ncvKGJDSa/884=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Utt8P40S1hcPFRlXnLFarXrqL4ToLrHW9eoBa1mbYyNSr/1XAoibD8smG1pa3R+A5
         lOeg16zvClG/KIrMcF7DlV99bqFicrxoofGaBCBVKKnbpDaaPq+6H0/oO8BXRSW91/
         lHA21BhdJHDDaYRUimibXA2IXoxtUgnsOC/Mn0nU=
Date:   Tue, 27 Jul 2021 16:47:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, Shuo Liu <shuo.a.liu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, yu1.wang@intel.com
Subject: Re: [PATCH] virt: acrn: Do hcall_destroy_vm() before resource release
Message-ID: <YQAcnpQcO8h8/l8V@kroah.com>
References: <20210722062736.15050-1-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722062736.15050-1-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 02:27:36PM +0800, Fei Li wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The ACRN hypervisor has scenarios which could run a real-time guest VM.
> The real-time guest VM occupies dedicated CPU cores, be assigned with
> dedicated PCI devices. It can run without the Service VM after boot up.
> hcall_destroy_vm() returns failure when a real-time guest VM refuses.
> The clearing of flag ACRN_VM_FLAG_DESTROYED causes some kernel resource
> double-freed in a later acrn_vm_destroy().
> 
> Do hcall_destroy_vm() before resource release to drop this chance to
> destroy the VM if hypercall fails.
> 
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Signed-off-by: Fei Li <fei1.li@intel.com>
> ---

Do you also want this backported to older kernels?  If so, you need to
put a cc: stable in here, right?  I'll go add it myself, but be more
careful next time please.

greg k-h
