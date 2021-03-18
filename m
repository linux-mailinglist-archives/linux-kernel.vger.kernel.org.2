Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE96D34012A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhCRIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhCRIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:47:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0HLE3E6fVh9BNhE3TbOCTew4ksGOWaGBmHt6RDduki0=; b=UaTiObV0x/rC3E451IvY+l2oR6
        LHyBNZ858myi4pLTt92ueiI4DozoxHyGzpn6yTsQJDaHmoQ+UhVCOWq3CRL6dKIynib4XfhVr2clR
        zwDVaZCgzD4PxyTadZMopls78L5BcM8FsUZcDYMAHHKpfgtjHLN4zuXpN4vi/k9UUNFM8Vy+Bss28
        ZP7uO6naVbYd5+eAIuiYfDboXHB4Ds/iY/qWOnngsAbkxNTqU0hRX2xhwrW/Z758LDgVMyEQAmbGs
        lFdhYqeShycTSijp8xuC0sbhWJujnb/vk9XSD8WpF4aks25FHJCcPivpwvX88zFpFjgReQIChLCoa
        CRzMlPYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMoJW-004pzn-Hn; Thu, 18 Mar 2021 08:47:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8127305C10;
        Thu, 18 Mar 2021 09:47:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD54B29A61CC6; Thu, 18 Mar 2021 09:47:29 +0100 (CET)
Date:   Thu, 18 Mar 2021 09:47:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Oliver Sang <oliver.sang@intel.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for
 .exit.text
Message-ID: <YFMToXI/3qjlMur4@hirez.programming.kicks-ass.net>
References: <20210317030101.GB22345@xsang-OptiPlex-9020>
 <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net>
 <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net>
 <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
 <20210318000212.l2fdz5vjhuq64yh6@treble>
 <YFMIcWIbk0aN30NY@hirez.programming.kicks-ass.net>
 <YFMPmkMoae5cRzh+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMPmkMoae5cRzh+@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:30:18AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 18, 2021 at 08:59:45AM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 17, 2021 at 07:02:12PM -0500, Josh Poimboeuf wrote:
> > > On Wed, Mar 17, 2021 at 01:45:57PM +0100, Peter Zijlstra wrote:
> > > > arguably it simply isn't a good idea to use static_call() in __exit
> > > > code anyway, since module unload is never a performance critical path.
> > > 
> > > Couldn't you make the same argument about __init functions, which are
> > > allowed to do static calls?
> > 
> > I suppose we could indeed make that argument. Much of that code was
> > copied from jump_label without much consideration. And I now I suppose
> > I'll have to consider jump_label in __exit too :/
> > 
> > > We might consider a STATIC_CALL_SITE_EXIT flag, but I suppose we've run
> > > out of flag space.
> > 
> > Yeah, we're definitely short on flags. Let me try and figure out when
> > exactly it's all discarded.
> 
> Ha!, x86 stuffs .exit.text in [__init_begin, __init_end) and it is
> discarded right along with initmem.
> 
> But that means it should match init and be tagged init and all *should*
> work, but somehow it doesn't... clearly I'm missing something again
> ARGH!

I found a race, look at this:

kernel_init()
	...
	free_initmem();
	...
	system_state = SYSTEM_RUNNING;

vs

__static_call_update()
	...
	if (static_call_is_init()) {
		if (system_state >= SYSTEM_RUNNING)
			continue;
	}


And this is *after* SMP bringup. Somehow I don't think you hit this
race, it is extremely unlikely

(jump_label has the exact same issue fwiw)
