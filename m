Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865FD40ACC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhINLvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhINLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:51:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3BC061574;
        Tue, 14 Sep 2021 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sOiknpjgebMSxy2rtFAmjlZL6dFw6P6xeEwKRmQVXg0=; b=lHcgxOs9L6fdd3/+naCd5qQGlF
        pBVcAvJFdwbcipUDn3MAungQE/UDwwcjdE4P26PJBdFwImkfE8A7ZJPKZxLEVHx/eWrW8eJ1h5uPF
        0C0tB/ICoezZgM599DPveVdneMoc2UXuTSLf07nbskrkBr0PfZqNaHN4XlXfcPl7yPyFC8obu513a
        RbBhUaTjm5UMorLyaZHEIXU4yHjti7VOV/wDTXqAvnNaa1vLi2M4emPfSSZBPvll4MWTqvgnr/ZlF
        5PTC8s6cNUxV/d5nmo6ssLaCjR6xRyZkIfKsJCd8PjU8HCdHtvBncErwY50T81RTOvhsYT8qsTxlx
        yKDbMtgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ6wV-0038BB-9f; Tue, 14 Sep 2021 11:49:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74ED8300129;
        Tue, 14 Sep 2021 13:49:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CF822D1FEA0A; Tue, 14 Sep 2021 13:49:37 +0200 (CEST)
Date:   Tue, 14 Sep 2021 13:49:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
Message-ID: <YUCMUZbchMjD54eY@hirez.programming.kicks-ass.net>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
 <87ilzbmt7i.fsf@mpe.ellerman.id.au>
 <YTiBqbxe7ieqY2OE@hirez.programming.kicks-ass.net>
 <87czphnchp.fsf@mpe.ellerman.id.au>
 <YTob/xfn1gt901K4@hirez.programming.kicks-ass.net>
 <87k0jjl9sp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0jjl9sp.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:40:38PM +1000, Michael Ellerman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:

> > I'm thinking we ought to keep hops as steps along the NUMA fabric, with
> > 0 hops being the local node. That only gets us:
> >
> >  L2, remote=0, hops=HOPS_0 -- our L2
> >  L2, remote=1, hops=HOPS_0 -- L2 on the local node but not ours
> >  L2, remote=1, hops!=HOPS_0 -- L2 on a remote node
> 
> Hmm. I'm not sure about tying it directly to NUMA hops. I worry we're
> going to see more and more systems where there's a hierarchy within the
> chip/package, in addition to the traditional NUMA hierarchy.
> 
> Although then I guess it becomes a question of what exactly is a NUMA
> hop, maybe the answer is that on those future systems those
> intra-chip/package hops should be represented as NUMA hops.
> 
> It's not like we have a hard definition of what a NUMA hop is?

Not really, typically whatever the BIOS/DT/whatever tables tell us. I
think in case of Power you're mostly making things up in software :-)

But yeah, I think we have plenty wriggle room there.
