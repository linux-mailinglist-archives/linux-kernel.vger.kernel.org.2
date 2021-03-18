Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8D34008C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCRH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:59:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D356C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uqzMzdvTx+DuxUMHyhI1UTiOm9unFzAEnAtm4QPn3Gg=; b=PPHsTOkJH7GvPPt1KDLckd4xkp
        TtleZv+UNWYYnf4Mttg6/Xh/qzdfmljgFDBP3blqO0+mTr7yWMFiLRq0zh6v+VfAbWUYNJY4Kr2Pn
        xtZcYeKbBa7zSdpVFfd7ouEn+Ln4T997Du/aA4+hXxu4Hf4GabApWaSP2rHbtq7ngJt2SiarZINVB
        PPq2cUT6kTcIpJndn4vQIpmkDq2gjMLzCJXRoZwg0Xe4HekTeWaAzToQD1gmGx4bUuSntF2LRwZ6y
        ojrbS1N7yNbp0lXbBOhXXzR4OlA7fvniYSa9/fXqxCHUXstvv2j2sKmPDQf7ntBqsDq7h4OC6m4+F
        6XNm/ZOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMnZK-004iBM-NA; Thu, 18 Mar 2021 07:59:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFFBA3006E0;
        Thu, 18 Mar 2021 08:59:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9356429A61CC4; Thu, 18 Mar 2021 08:59:45 +0100 (CET)
Date:   Thu, 18 Mar 2021 08:59:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Oliver Sang <oliver.sang@intel.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for
 .exit.text
Message-ID: <YFMIcWIbk0aN30NY@hirez.programming.kicks-ass.net>
References: <20210315142345.GB4401@xsang-OptiPlex-9020>
 <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020>
 <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net>
 <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net>
 <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
 <20210318000212.l2fdz5vjhuq64yh6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318000212.l2fdz5vjhuq64yh6@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:02:12PM -0500, Josh Poimboeuf wrote:
> On Wed, Mar 17, 2021 at 01:45:57PM +0100, Peter Zijlstra wrote:
> > arguably it simply isn't a good idea to use static_call() in __exit
> > code anyway, since module unload is never a performance critical path.
> 
> Couldn't you make the same argument about __init functions, which are
> allowed to do static calls?

I suppose we could indeed make that argument. Much of that code was
copied from jump_label without much consideration. And I now I suppose
I'll have to consider jump_label in __exit too :/

> We might consider a STATIC_CALL_SITE_EXIT flag, but I suppose we've run
> out of flag space.

Yeah, we're definitely short on flags. Let me try and figure out when
exactly it's all discarded.
