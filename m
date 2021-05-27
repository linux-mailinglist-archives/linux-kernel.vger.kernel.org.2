Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5618392C66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhE0LPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhE0LPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:15:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49526C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dITh5ZbWywBWx2k0m7GmJN63/ZLOidUlHcmSE1OG9OE=; b=RXoehVm1FUf6iaNBZ8GuddK7kp
        +Q1OKs4mezvaCC826xYPJyrGtms+W9Z+o6Z9jJZxYrW4odPbuhqxCwhQST7nk3FWK0jsfgOLMu/T0
        3CwH3gIAZMcJelV/qkowKwAlwdiS8hpf1fxzTNvLgFNkvva5N/W6pu3n3bwcA1TKpJWnnE+MvvAEe
        30b6Zg9co0VNTk6bqgYPobi5t9e8C++D76hWoZWHfKBb9NM3JpwZjMlVA7Nz5/5YhNaIenDtUZXrz
        nfzbVIL3eL6em5iAkry+sA4xqWFMlB2T1iaxA3uqTX3AW0NO4YmDgx+LTfQm1hNjYLjjyNJ6ScMnW
        ZczDV4rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmDxb-000z93-SS; Thu, 27 May 2021 11:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62AF5300202;
        Thu, 27 May 2021 13:14:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19E48200D3A72; Thu, 27 May 2021 13:14:01 +0200 (CEST)
Date:   Thu, 27 May 2021 13:14:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, steve.wahl@hpe.com,
        john.p.donnelly@oracle.com, brian.maly@oracle.com,
        jack.vogel@oracle.com, ak@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix a kernel WARNING triggered by
 maxcpus=1
Message-ID: <YK9++al/J4Jm9W1J@hirez.programming.kicks-ass.net>
References: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 06:58:47AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A kernel WARNING may be triggered when setting maxcpus=1.
> 
> The uncore counters are Die-scope. When probing a PCI device, only the
> BUS information can be retrieved. The uncore driver has to maintain a
> mapping table used to calculate the logical Die ID from a given BUS#.
> 
> Before the patch ba9506be4e40, the mapping table stores the mapping
> information from the BUS# -> a Physical Socket ID. To calculate the
> logical die ID, perf does,
> - In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
>   from the UBOX PCI configure space.
> - Calculate the mapping information (a BUS# -> a Physical Socket ID) for
>   the other PCI BUS.
> - In the uncore_pci_probe(), get the physical Socket ID from a given BUS
>   and the mapping table.
> - Calculate the logical Die ID
> 
> Since only the logical Die ID is required, with the patch ba9506be4e40,
> the mapping table stores the mapping information from the BUS# -> a
> logical Die ID. Now perf does,
> - In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
>   from the UBOX PCI configure space.
> - Calculate the logical Die ID
> - Calculate the mapping information (a BUS# -> a logical Die ID) for the
>   other PCI BUS.
> - In the uncore_pci_probe(), get the logical die ID from a given BUS and
>   the mapping table.
> 
> When calculating the logical Die ID, -1 may be returned, especially when
> maxcpus=1. Here, -1 means the logical Die ID is not found. But when
> calculating the mapping information for the other PCI BUS, -1 indicates
> that it's the other PCI BUS that requires the calculation of the
> mapping. The driver will mistakenly do the calculation.
> 
> Uses the -ENODEV to indicate the case which the logical Die ID is not
> found. The driver will not mess up the mapping table anymore.
> 
> Fixes: ba9506be4e40 ("perf/x86/intel/uncore: Store the logical die id
> instead of the physical die id.")

(please don't wrap like that)

> Reported-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
