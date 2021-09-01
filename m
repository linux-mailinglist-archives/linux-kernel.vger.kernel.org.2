Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD69E3FD336
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhIAFs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:48:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:8840 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhIAFs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:48:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="215505852"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="215505852"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 22:47:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="690423555"
Received: from rortega-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.25.13])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 22:47:07 -0700
Date:   Wed, 1 Sep 2021 17:47:05 +1200
From:   Kai Huang <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/sgx: Add SGX_MemTotal to /proc/meminfo
Message-Id: <20210901174705.3b1a943ef8c4bb09323c6d76@intel.com>
In-Reply-To: <6a9fccdb6a458960e43a63afcce87cc62184adf9.camel@kernel.org>
References: <20210825235234.153013-1-jarkko@kernel.org>
        <20210825235234.153013-2-jarkko@kernel.org>
        <20210826141959.5f13ff3c9c560c23b58443b1@intel.com>
        <54923ac01fc303e5105cadca06b7c5cbd322d815.camel@kernel.org>
        <20210828000335.1d40dfff0f408b2d91467491@intel.com>
        <04b90a702328712204430db604b2a92ddfe8f990.camel@kernel.org>
        <20210901173322.78f94b694b4be6b1225bee98@intel.com>
        <6a9fccdb6a458960e43a63afcce87cc62184adf9.camel@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021 08:41:12 +0300 Jarkko Sakkinen wrote:
> On Wed, 2021-09-01 at 17:33 +1200, Kai Huang wrote:
> > On Wed, 01 Sep 2021 05:02:45 +0300 Jarkko Sakkinen wrote:
> > > On Sat, 2021-08-28 at 00:03 +1200, Kai Huang wrote:
> > > > > > > -/* The free page list lock protected variables prepend the lock. */
> > > > > > > +/* The number of usable EPC pages in the system. */
> > > > > > > +unsigned long sgx_nr_all_pages;
> > > > > > > +
> > > > > > > +/* The number of free EPC pages in all nodes. */
> > > > > > >  static unsigned long sgx_nr_free_pages;
> > > > > > >  
> > > > > > >  /* Nodes with one or more EPC sections. */
> > > > > > > @@ -656,6 +659,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
> > > > > > >  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
> > > > > > >  	}
> > > > > > >  
> > > > > > > +	sgx_nr_all_pages += nr_pages;
> > > > > > > +
> > > > > > 
> > > > > > EPC sections can be freed again in sgx_init() after they are successfully
> > > > > > initialized, when any further initialization fails (i.e. when fails to create
> > > > > > ksgxd, or fails to register /dev/sgx_provision).  In which case, I think
> > > > > > sgx_nr_all_pages should also be cleared.  But current sgx_init() seems doesn't
> > > > > > reset it.  Do you need to fix that too?
> > > > > 
> > > > > sgx_nr_all_pages tells just the total pages in the system, i.e. it's a constant.
> > > > > 
> > > > > Maybe a rename to "sgx_nr_total_pages" would be a good idea? Would match with
> > > > > the meminfo field better too.
> > > > 
> > > > I don't have preference on name.  I just think if there's no actual user of
> > > > EPC (when both driver and KVM SGX cannot be enabled), it's pointless to print
> > > > number of EPC pages.
> > > 
> > > I'd presume that you refer to the code, which prints the number of *bytes* in
> > > the system because code printing the number of pages does not exist in this
> > > patch set.
> > > 
> > > I have troubles the decipher your statement.
> > > 
> > > You think that only if both the driver and KVM are *both* enabled, only then
> > > it makes sense to have this information available for sysadmin?
> > 
> > Only if at least one of them is enabled.
> 
> OK, thank you, that does make sense.
> 
> What would happen if neither is enabled is that SGX_MemTotal would
> state that there is zero bytes of EPC. 

This is the problem I pointed out at the beginning, that (if I read code
correctly), it seems your current patch doesn't clear sgx_nr_all_pages when
neither is enabled (in sgx_init() in sgx/main.c).

