Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DAB357082
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353656AbhDGPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353625AbhDGPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:37:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095FBC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QylIfigSaFHbypENLSDV3Pz1fEDQV/gGjtYiJoxXbio=; b=MYS9LdrfpVyllUTfNbmURNNMe0
        n1dYuKQWhrkfeEoQ6tQ0yNM8fOeWZXZGmEcZkJ+JKEA4Bu9dhAf2ov55wMQAihKCw5arj/MwgFYWH
        /TZt4EWMs23WsX1oMoHIGh/skSg6fb4EKnImmBlDEbxsXXNgx4saosrq08rHDLp1N8M0u2S26VLU7
        SCAezEIMhjbeXXLiLoTEaBYUAegG+W5RQ0+FwkSmtGbng4YhMVMpnOtv2JjpM8eOq1vXwCNI0+45V
        yPVAHwtAwjAaKhDPUL1yFb835bTcvSIF61RaDmq2g+oXbYwVfXqdzUSBEbUePp/Cam+tAHVP7nBZy
        MTG/ZQXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUADI-00EgWR-Sc; Wed, 07 Apr 2021 15:35:48 +0000
Date:   Wed, 7 Apr 2021 16:35:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 11/37] x86/mm: attempt speculative mm faults first
Message-ID: <20210407153528.GF2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-12-michel@lespinasse.org>
 <YG3GTI8j1ohk4NhS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3GTI8j1ohk4NhS@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:48:44PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 06, 2021 at 06:44:36PM -0700, Michel Lespinasse wrote:
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1219,6 +1219,8 @@ void do_user_addr_fault(struct pt_regs *regs,
> >  	struct mm_struct *mm;
> >  	vm_fault_t fault;
> >  	unsigned int flags = FAULT_FLAG_DEFAULT;
> > +	struct vm_area_struct pvma;
> 
> That's 200 bytes on-stack... I suppose that's just about acceptible, but
> perhaps we need a comment in struct vm_area_struct to make people aware
> this things lives on-stack and size really is an issue now.

Michel's gone off and done his own thing here.

The rest of us (Laurent, Liam & I) are working on top of the maple tree
which shrinks vm_area_struct by five pointers, so just 160 bytes.

Also, our approach doesn't involve copying VMAs in order to handle a fault.

