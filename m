Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C283538B1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhDDPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 11:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhDDPx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 11:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A98A6137B;
        Sun,  4 Apr 2021 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617551634;
        bh=yqUA8RTq36lWl0AnBFKVNcM7kQEDtUb9H/sehA8uhWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cumZycPcIFZmAd7OskLRiDMQl0PQhobODNr+xtAenR5jy1NghCLM+hodLr7Bf5s5N
         CjwJLoKgG1O6FHtN/MOQI+c2OIhV8mIMoT4iN0dgv7s6RzvUMXOz5zuSL4FKsaphy5
         7Rji+7zA7+8s8LQByXV5zx1HYQuGCEQcwY/9AxhXlrs5QgQkxQzdVXRNv03ORgqPNp
         5pNDXIEKQ/l23+Z+HPfioUdyJr4c2uRAEvnMhlH5q0IVvdj4H227R0lOy5rGCUXUtI
         VB0ulQY6d5pE8jHaGXbPyDSFf6wNV/3H+hrI7CH9+oFsCqZOJ3jTZaEUidPPje7VBw
         DClCqeAjAZpZw==
Date:   Sun, 4 Apr 2021 18:53:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/sgx: Add sgx_nr_{all, free}_pages to the debugfs
Message-ID: <YGnhEEwMD4qAtPaK@kernel.org>
References: <20210401052114.697432-1-jarkko@kernel.org>
 <20210401052114.697432-2-jarkko@kernel.org>
 <57c18e08-3e36-b5b3-aaba-9a21b75a1613@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c18e08-3e36-b5b3-aaba-9a21b75a1613@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:32:58PM -0700, Dave Hansen wrote:
> On 3/31/21 10:21 PM, Jarkko Sakkinen wrote:
> > +#ifdef CONFIG_DEBUG_FS
> > +	debugfs_create_file("sgx_nr_all_pages", 0400, arch_debugfs_dir, NULL,
> > +			    &sgx_nr_all_pages_fops);
> > +	debugfs_create_file("sgx_nr_free_pages", 0400, arch_debugfs_dir, NULL,
> > +			    &sgx_nr_free_pages_fops);
> > +#endif /* CONFIG_DEBUG_FS */
> 
> 
> Why not make the types u64's and use debugfs_create_u64()?  That would
> save a ton of code.  There's also debugfs_create_ulong().

Because I was not aware of that. For sure can be used.

/Jarkko
