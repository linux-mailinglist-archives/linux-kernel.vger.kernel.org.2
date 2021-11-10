Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9D44C184
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhKJMtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhKJMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:49:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B26FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yH06orYt/0wvTnZYICw3iHP2obW2YzQPggzsvGVYVqQ=; b=J6xq3FizeDGPdm2oPsOzVOtv54
        yM6sv53l/zZV+Tsbn2ZClhKgAVM9ck3+u8vzK5N8fYGX4z4P8h9MTfEnCU72T8GSHFjYEUhN/HcsF
        VwisYqYoMS5fmIQol/UXU/f7Ha1tt5Ql7m2G8G9d+Md9Wae9SKi9Zcu4QKIB1vmjRXXEibp+hPbG5
        G3T05wpHx/hdaANuoYOAm1S5sYC37wkBmvkivSU4gYikjK57zkkwhSCOrrQFpy6vgy9r3wLSnN7lq
        NkUC9aVy1An3QoBXV1YcCKdo8MT0EcO0inVZowWt3Ye75zCWGczqy+Ljjb21/g3uFvamcB7aS8wI0
        8lm8ul/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkmzy-00FH79-En; Wed, 10 Nov 2021 12:46:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17B7D30003C;
        Wed, 10 Nov 2021 13:46:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 073D1212EB3B4; Wed, 10 Nov 2021 13:46:42 +0100 (CET)
Date:   Wed, 10 Nov 2021 13:46:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 11/23] x86,xen: Remove .fixup usage
Message-ID: <YYu/Mg8lSO9zX01z@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.545019822@infradead.org>
 <42933d6b-c6f4-7420-1d0f-7f5d6ec17d8e@suse.com>
 <YYumVx7qO3gY2tgD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYumVx7qO3gY2tgD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:00:39PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 10, 2021 at 11:35:37AM +0100, Juergen Gross wrote:

> > > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAUL_REG, %[ret])
> > 
> > I guess you didn't compile that? There is a typo: s/EFAUL/EFAULT/
> 
> Damn.. I figure that must've gotten lost in the robot spam telling me
> clang can't do __cold on labels :/

new patch at:

  https://lkml.kernel.org/r/YYu/AteC/Wamqn46@hirez.programming.kicks-ass.net
