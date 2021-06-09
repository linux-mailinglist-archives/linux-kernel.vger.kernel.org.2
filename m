Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C596E3A0BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhFIFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhFIFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:53:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724CEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 22:51:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u30so22615117qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q8sTBTD7rqUBliLRHrxCmEIR6SotTCZJtXQ0xNJl0ps=;
        b=jc8qOTt8Oip/8bbn8zI7lQ382Nv/JjOqm0/85z3jXtEs02APBXJte68vjIBeLPaAgr
         8thN6vFm7LY859Yzo4JhsA0RXTv849sULwn2NTBgRVFZvWQ7bW5S4wV+bqbn8jACftVM
         PadCgvjVGYYCQ294hAV+xd3LCnTD+wDTnxBZugD8CAUXZ7Mk6ClNUXsscIob/debc9Yb
         ++TTO539UY5TfFdbjsHQENMRryzxavGBVGwlc42EF21Kbp2x5gXqwBzKa3jedwGOzcNb
         WpRGbRa7ISr2BUaTX+p05ClXCyPc75YaA+r5EhhCjf7rG59SHYoz/9GzyyHLJ9l5DncY
         1BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Q8sTBTD7rqUBliLRHrxCmEIR6SotTCZJtXQ0xNJl0ps=;
        b=h+CtDYim1BfBVGlTYZSfLQS76A3wtfor7t70CrIkrwEboEG7A/MUltdJhmp9OWneQh
         jI9G0heBxh/I0ASfWDJQnGsHn14t2BWJB1Blq1RqloU081VGKZAn1ANLSad8cDbMf+Dm
         5Chf0F7z7dJS5V62U287tXwtpAh4KZY6usQdk+TT2pDmQ/NS8EJX+rr59AKR+dkSX0O9
         Gnsh0BFHupNwwVMp2ATp7sI2y4JsyaeDkVFtu8sBJb/z7n5jo0FgsDku7s8VC77clO/G
         +a4Gz3nkSPJOSyWa6vXBK3ILKhCSHczPUAh6WnHT/lL91JTrG3jRzirYoSQoQBVKY59u
         VY8w==
X-Gm-Message-State: AOAM533c9LuOaQbeqcLlyt/fnriig4c1LoGjEnLTeUqvD2xF5MNuC3pu
        4bjT41aQbxh4D6J7o3nBtrM=
X-Google-Smtp-Source: ABdhPJxxA8J8MOBhkHg6pxRDuQxesUSikSLI8O9AegUX7qOIzZD2LHX5Ab14oRo0m7F/p9XkLgjFEQ==
X-Received: by 2002:a05:620a:228b:: with SMTP id o11mr9373599qkh.426.1623217878471;
        Tue, 08 Jun 2021 22:51:18 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:87bb::1000? ([2804:14c:482:87bb::1000])
        by smtp.gmail.com with ESMTPSA id g2sm7003048qtb.63.2021.06.08.22.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 22:51:18 -0700 (PDT)
Message-ID: <a69f18159b90c5ede95e6d3769e224b883cc974f.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc/mm/hash: Avoid resizing-down HPT on
 first memory hotplug
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jun 2021 02:51:49 -0300
In-Reply-To: <YMBGW3RQOzoQxBqy@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
         <20210430143607.135005-2-leobras.c@gmail.com> <YL2obsnp4rWbW6CV@yekko>
         <648b382159009c5f4277d9b9c3f896142ea75d6c.camel@gmail.com>
         <YMBGW3RQOzoQxBqy@yekko>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 14:40 +1000, David Gibson wrote:
> On Tue, Jun 08, 2021 at 09:52:10PM -0300, Leonardo Brás wrote:
> > On Mon, 2021-06-07 at 15:02 +1000, David Gibson wrote:
> > > On Fri, Apr 30, 2021 at 11:36:06AM -0300, Leonardo Bras wrote:
> > > > Because hypervisors may need to create HPTs without knowing the
> > > > guest
> > > > page size, the smallest used page-size (4k) may be chosen,
> > > > resulting in
> > > > a HPT that is possibly bigger than needed.
> > > > 
> > > > On a guest with bigger page-sizes, the amount of entries for
> > > > HTP
> > > > may be
> > > > too high, causing the guest to ask for a HPT resize-down on the
> > > > first
> > > > hotplug.
> > > > 
> > > > This becomes a problem when HPT resize-down fails, and causes
> > > > the
> > > > HPT resize to be performed on every LMB added, until HPT size
> > > > is
> > > > compatible to guest memory size, causing a major slowdown.
> > > > 
> > > > So, avoiding HPT resizing-down on hot-add significantly
> > > > improves
> > > > memory
> > > > hotplug times.
> > > > 
> > > > As an example, hotplugging 256GB on a 129GB guest took 710s
> > > > without
> > > > this
> > > > patch, and 21s after applied.
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > 
> > > Sorry it's taken me so long to look at these
> > > 
> > > I don't love the extra statefulness that the 'shrinking'
> > > parameter
> > > adds, but I can't see an elegant way to avoid it, so:
> > > 
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> > np, thanks for reviewing!
> 
> Actually... I take that back.  With the subsequent patches my
> discomfort with the complexity of implementing the batching grew.
> 
> I think I can see a simpler way - although it wasn't as clear as I
> thought it might be, without some deep history on this feature.
> 
> What's going on here is pretty hard to follow, because it starts in
> arch-specific code (arch/powerpc/platforms/pseries/hotplug-memory.c)
> where it processes the add/remove requests, then goes into generic
> code __add_memory() which eventually emerges back in arch specific
> code (hash__create_section_mapping()).
> 
> The HPT resizing calls are in the "inner" arch specific section,
> whereas it's only the outer arch section that has the information to
> batch properly.  The mutex and 'shrinking' parameter in Leonardo's
> code are all about conveying information from the outer to inner
> section.
> 
> Now, I think the reason I had the resize calls in the inner section
> was to accomodate the notion that a) pHyp might support resizing in
> future, and it could come in through a different path with its drmgr
> thingy and/or b) bare metal hash architectures might want to
> implement
> hash resizing, and this would make at least part of the path common.
> 
> Given the decreasing relevance of hash MMUs, I think we can now
> safely
> say neither of these is ever going to happen.
> 
> Therefore, we can simplify things by moving the HPT resize calls into
> the pseries LMB code, instead of create/remove_section_mapping.  Then
> to do batching without extra complications we just need this logic
> for
> all resizes (both add and remove):
> 
>         let new_hpt_order = expected HPT size for new mem size;
> 
>         if (new_hpt_order > current_hpt_order)
>                 resize to new_hpt_order
> 
>         add/remove memory
> 
>         if (new_hpt_order < current_hpt_order - 1)
>                 resize to new_hpt_order
> 
> 


Ok, that really does seem to simplify a lot the batching.

Question:
by LMB code, you mean dlpar_memory_{add,remove}_by_* ?
(dealing only with dlpar_{add,remove}_lmb() would not be enough to deal
with batching)

In my 3/3 repĺy I sent you some other examples of functions that
currently end up calling resize_hpt_for_hotplug() without comming from 
hotplug-memory.c. Is that ok that they do not call it anymore?


Best regards,
Leonardo Bras

