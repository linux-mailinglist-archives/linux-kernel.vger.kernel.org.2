Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A714A4353E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhJTThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhJTThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:37:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+HzjcuxqyVsmJgFn+EVWInJaG7vjfz29aTQSEDqxsg8=; b=VKCVqPdd1cV0Hhd+nCIn+9MQxL
        StX/YQ3kBHoR+24soHMuhu4Br9bpU/b/+s5iCYW6T1PwumsuY8ngQQtRLq/FUIiD1DoPExkCJ2qGf
        UxlnmsaaOFkgtm4nIFBsCPxoHQEvPxT02abga2autXm6hHYii1DQ2yqXsV0eOJcbDBaA7NuU9mG+Y
        jKBx+gTWuo3kbwXawQPXC+tP1rb3O+svOpLVDHH/qM3/o5ezAMqIAQoTri6BcPnfplAYbIfpk28mA
        OtgK0Tn+5dmi/i7kNe6XAP59n9SXXsbBan/ulsWRfZr/HoeC+S7tEpJFcIYTiTgWyxU6F4V0hu/gO
        CzkLHRVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdHMO-00B0tl-SY; Wed, 20 Oct 2021 19:34:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0196B986DD9; Wed, 20 Oct 2021 21:34:47 +0200 (CEST)
Date:   Wed, 20 Oct 2021 21:34:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
Message-ID: <20211020193447.GR174703@worktop.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.981215247@infradead.org>
 <20211020155750.3u74bkcp66leeyed@treble>
 <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 05:46:39PM +0100, Andrew Cooper wrote:
> On 20/10/2021 16:57, Josh Poimboeuf wrote:
> > On Wed, Oct 20, 2021 at 12:44:50PM +0200, Peter Zijlstra wrote:
> >> Stick all the retpolines in a single symbol and have the individual
> >> thunks as inner labels, this should guarantee thunk order and layout.
> > How so?
> >
> > Just wondering what the purpose of the array is.  It doesn't seem to be
> > referenced anywhere.
> 
> The array property is what makes:
> 
> > +	reg = (target - &__x86_indirect_thunk_rax) /
> > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> 
> safe in the next path.

Arguably I should probably write that like:

	(target - &__x86_indirect_thunk_array) / __x86_indirect_thunk_size;

or something, and also generate and expose that latter symbol from .S.
