Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BA633FD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCRCon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:44:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:63958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCRCoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:44:20 -0400
IronPort-SDR: pCCmbqAB35mHGfS0lLS+kvcwFe8rDg2Yf59HvfqkDRQd+HtE/39BAkei4x1TjHG5sj2POdJrdD
 3pSCRooejvlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="186232236"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="186232236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 19:44:20 -0700
IronPort-SDR: FbkhzGsVEg6f0l7pM2QQBIjpDFVw/Cyn3rjWSHO1xLXN8PdCpvEhUntE8+92VloM0PObRHOikv
 6ZckVjbfs0wQ==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="406170075"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 19:44:20 -0700
Date:   Wed, 17 Mar 2021 19:44:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: kmap_local semantics
Message-ID: <20210318024418.GX3014244@iweiny-DESK2.sc.intel.com>
References: <20210312065413.GA29805@lst.de>
 <20210312153646.GE3014244@iweiny-DESK2.sc.intel.com>
 <878s6lzxsq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s6lzxsq.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:59:01PM +0100, Thomas Gleixner wrote:
> On Fri, Mar 12 2021 at 07:36, Ira Weiny wrote:
> > On Fri, Mar 12, 2021 at 07:54:13AM +0100, Christoph Hellwig wrote:
> >> So with the new kmap_local interface is it possible / advisable to
> >> use local kmaps over code that might schedule(), e.g. to wait for I/O?
> >
> > It is possible yes.  "Advisable" I think so.  Thomas knows better than I what
> > performance would be.
> 
> The performance impact is only relevant for 32bit machines with HIGHMEM
> enabled. On 64bit kmap_local is a NOOP except when you enable
> CONFIG_DEBUG_KMAP_LOCAL there which then actually does the mapping (on
> x86 only for now) with guard maps between and that will do the 'drop
> map' on schedule out and restore on schedule in dance. But for regular
> 64bit there is absolutely _NO_ overhead.

Thanks for clarification.

> 
> > FWIW I have been working on converting kmaps to kmap_local.  Most of the
> > instances don't schedule AFAICT.
> 
> The whole point of kmap_local is to be preemptible and does not have the
> nasty side effects of kmap_atomic, except for the 1 page per map and map
> nesting ordering requirements.
> 
> > What I really don't want to see is any kmap'ings handed to another thread.  I
> > am working hard to eliminate the use of kmap for that use.  Is that going to be
> > a problem?
> 
> kmap != kmap_local
> 
> kmap_local mappings are thread local and can't be handed anywhere. It's
> documented.

Agreed.  I'm Sorry, I did not word the above clearly enough.  Let me rephrase
that.

Christoph, do you anticipate additional need to call kmap and hand the mappings
to other threads?  If not then kmap_local is what you should use.  If so, I'd
like to know why.

Ira

> 
> Thanks,
> 
>         tglx
