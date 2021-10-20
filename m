Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B644353BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJTT0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhJTT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:26:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB27C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80kq77wLo4tISSEgSJEwjE/WA2Ew5k8rlteIWmD2+uM=; b=DgRUBxvMRdXzg7dP/aNv8Rz1Uy
        kAdAN9Vuznnf+PmTTfBBpJGg/X+z2AhB0JcPgnWPQAZGVLbh13nK2zDSR+VeRn2/R8bZj7AFrwGe1
        jugXfqKVH9hEHZw+QHreYlJxrUN7Ds3nkIP/B49C7pdEsjUmKT59/EXDmwgl6M85rAeJ4O1EPc+Fr
        IJ/xhL/tuHc6VyZQMAcFMJjs/moG3uDuogDRcN7zckvHnoifVuxvmdTF5T8ole3Y5xwLPhWeV22mw
        FuBO1IqRfCNn27zmWT9ojRi8VxzhmMzbK5bS2kKr3IB9hs9ra+IrmXJGH7WQveIs5evP67Y0nIsI/
        VtG4mdkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdHBd-00B0gk-JJ; Wed, 20 Oct 2021 19:23:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C98D986DD9; Wed, 20 Oct 2021 21:23:41 +0200 (CEST)
Date:   Wed, 20 Oct 2021 21:23:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211020192341.GQ174703@worktop.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211020165655.632slp4ujsajis4j@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020165655.632slp4ujsajis4j@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:56:55AM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 20, 2021 at 01:09:51PM +0200, Peter Zijlstra wrote:
> > Alexei; could the above not be further improved with something like the
> > below?
> > 
> > Despite several hours trying and Song helping, I can't seem to run
> > anything bpf, that stuff is cursed. So I've no idea if the below
> > actually works, but it seems reasonable.
> 
> The below fix gets it to run with test_verififer.

Argh, I;m fast running out of brown paper bags at this rate :/

> 
> I do like it, it does seem less fiddly and more robust against future
> changes, though it probably needs a comment for 'out_label' clarifying
> it only works because this function is always called at least twice for
> a given bpf_tail_call emission.

Right.
