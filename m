Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0433FAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCQV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhCQV4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:56:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D83F64F17;
        Wed, 17 Mar 2021 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616018181;
        bh=LKtXIOp/a8yh3wmmlOrWfUAaMdE0+NwQfxFBBSNTRj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dw9Eagjt4sQMdDNYcYtYKOgRJsvQ6bqglxnUFS4NDZYqXxv12vrJb0mDmFClD1bvW
         vM8gKoGLAhVrmUKBU9SRX0E7yiEC0MGgMRMjGFeDOr3SZAPbhl1M0xuqVMa3O9qRBf
         m5/yJkNZ+ofox5QkZt6GupeQPG/W06lk5pbSKIZa99XBBPTKzpAy5Ga8bdYLd37PQ/
         qiaR37/JVlZUVumeo1BQkXax6+5pznEI4YlhZMBLXHQo9oMrnRN3oE1/Kps4MLPYf2
         MLLw2YwCoA8lz//Z2Tvv77k8y8RYEGTGx43nahNGLQBFEzCFPpntzf6PfvrilvHm8J
         Aw257WxmQD7pw==
Date:   Wed, 17 Mar 2021 23:55:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oliver Sang <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for
 .exit.text
Message-ID: <YFJ66nW0vabAgGqm@kernel.org>
References: <20210315142345.GB4401@xsang-OptiPlex-9020>
 <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020>
 <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net>
 <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net>
 <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
 <CAFA6WYNr8SR=20LKJD0+AyrVXLY2CqQPqRE_60EestYv9L5AcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNr8SR=20LKJD0+AyrVXLY2CqQPqRE_60EestYv9L5AcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:07:07PM +0530, Sumit Garg wrote:
> On Wed, 17 Mar 2021 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 17, 2021 at 05:25:48PM +0530, Sumit Garg wrote:
> > > Thanks Peter for this fix. It does work for me on qemu for x86. Can
> > > you turn this into a proper fix patch? BTW, feel free to add:
> >
> > Per the below, the original patch ought to be fixed as well, to not use
> > static_call() in __exit.
> 
> Okay, fair enough.
> 
> Jarkko,
> 
> Can you please incorporate the following change to the original patch as well?

Can you roll-out a proper patch of this?

/Jarkko
