Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73643310C37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhBENxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhBENuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:50:10 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E15CC0617AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:49:29 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t63so6900389qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ClyUAOZa7OFCglp1bjgNnlXnosYgcrxy4Bo5DWX5whw=;
        b=FOINqIGCcM6JC0NsYY3CkXaBU8OT/mQFC438dCVwpji4LrPutJxYQeJ7dTf+VxP+u3
         zInvInYh4EnxysFRQPofCeynn87IIMYWshQArmOWHQVoho53rCFN8ZNfUIeEupDBX+PD
         pgDEPCsXI96sUaCb5FMllexsveMKMs7AqZTr11a4OIP70iyu6so8/OTmMbtio430oAvG
         tSFKvPfhAParBvpOoMO6PT7wC9iJ2g5mw1TTV0/WT3fo8g2DLlqvBo0Cae7ra6/RaWI1
         7J8MMdZ6ubw/VUkzXWw2Mx0E6GC1AYgATNJyIANBUnP1MSd3GOaVgE/ukYuk8ken0dhF
         nrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ClyUAOZa7OFCglp1bjgNnlXnosYgcrxy4Bo5DWX5whw=;
        b=taSSYqV9I0iSeZgL/19G+pQfB64xp9yY5SCHO+IUR4tG1N1313UOkWAc3MRSa58QPb
         1PqbjjFXI1efIC4YCHcTDBXFuooFe/Sv8ou2tosQ5ygDtAd+AJQuPP84zB5YVn+HcZwf
         T9zIX/Je4cLP6xGGkbNGjQi7ZK5KZ981KRqsrBPvRj/6wSGLUAdRghIbxaoF/6ytoymE
         vGuIp1VlNTEgsDW1bfMFHqoTmJHblGt70LBL/U+6p9wl8snl1qU5O3KXSMSqx/YboTWw
         WJeBTxjoCFh3iSy206l3IhoGn40giBqi2Cm7NAm0BObXO3yLE0q1UqANUE43zGGq7igb
         v7mA==
X-Gm-Message-State: AOAM530uYQXyLdldJExi97a9/bKsVy79eFDjKxKczRw3n/zO05tj3vV5
        /2p7qtN+dgBd52lEPxj9IvDAww==
X-Google-Smtp-Source: ABdhPJyedZWbZ/VF4fBY6l7VFipJ5IDXzjqxEPVTrm3E52U13xSe3YTO2VmNXl+IpGlsoUFUyN3YCA==
X-Received: by 2002:a37:a50e:: with SMTP id o14mr4388187qke.250.1612532968204;
        Fri, 05 Feb 2021 05:49:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id c5sm9349747qkg.99.2021.02.05.05.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:49:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l81UF-003qUb-5e; Fri, 05 Feb 2021 09:49:27 -0400
Date:   Fri, 5 Feb 2021 09:49:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] mm: provide a sane PTE walking API for modules
Message-ID: <20210205134927.GL4718@ziepe.ca>
References: <20210205103259.42866-1-pbonzini@redhat.com>
 <20210205103259.42866-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205103259.42866-2-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:32:58AM -0500, Paolo Bonzini wrote:
> Currently, the follow_pfn function is exported for modules but
> follow_pte is not.  However, follow_pfn is very easy to misuse,
> because it does not provide protections (so most of its callers
> assume the page is writable!) and because it returns after having
> already unlocked the page table lock.
> 
> Provide instead a simplified version of follow_pte that does
> not have the pmdpp and range arguments.  The older version
> survives as follow_invalidate_pte() for use by fs/dax.c.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/s390/pci/pci_mmio.c |  2 +-
>  fs/dax.c                 |  5 +++--
>  include/linux/mm.h       |  6 ++++--
>  mm/memory.c              | 35 ++++++++++++++++++++++++++++++-----
>  4 files changed, 38 insertions(+), 10 deletions(-)

Looks good to me, thanks

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
