Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC633EBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:48:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2056C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:48:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so928527wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/t+R9cq9ajr2u6pALNn2rQL4JuQkhnbxPr0NJiaTOiA=;
        b=YHjaVIdLqno62nLAh21RKe+DG0N+Nz5GF+oG6sTivpb2W6fmr0ynjrDd5VwWJvFOcc
         HbZnJRsV6thHfw+7iQRDfqoD2r4qReoAhTRTdLD8zvixYn7SDTDODaJ6nhDruoL4DEfF
         wJkCuCfhOiGk6wjsbmK/VXLOEUh9x5BcJSlzUP/qx1iBJrIFF/LPcCMBZZ7+Ehi3xOYN
         jDPjEuV/qT72IPddkwC9iF2aNy5Qc94hsSiOOSVNMPe3lKkHgFKFFk6NOazhY1qDOrMn
         lbgihMG6WH3DB9PVU2fk9mR/b04n7IEd8CTCjK1goYXOSPx7k458Z3TFDkqOXXQu+feY
         96dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/t+R9cq9ajr2u6pALNn2rQL4JuQkhnbxPr0NJiaTOiA=;
        b=MNODkW6j/PvPc2gcOGZAaEOEIa3xXy9zWRHak3cLHd6wywU4zbQYY4dCBOkYcq/6mT
         3mxrX+fHLMo0+Z2nltUbMp4ygqYYysb3BL/n4q7WxCctRtTke7wQN9JCYY6Fu0oCLg7j
         dVr7aCKq9MKmXAjMGYKH5Tka/5N6gJmY6Kz8F6dF0OP6N14ftyx9ICc2Y4fw17g30uEv
         UMv5Rf1maqptevDbHWJq4b06QhWTTbW+jrGRiXYJtUNMpXUctRvn04NIKTkw5reUr54Z
         Nr44wKlwblDPAhhkPdJNG9Nq6/lsQq6CuHzLT+FPtKeOMEcewQrWlmWG08WBzHaRbbDd
         VkMg==
X-Gm-Message-State: AOAM5316c80jm9ilymKzG1sAZKOEXMX2iCls7A+HdoPVpu0wxUqX2/Yw
        EXwe9Qcv9r8drHWDj+nBzI8=
X-Google-Smtp-Source: ABdhPJyxK9S92xnZ+fiDV0O5ZPR8kJ7n5I+sJwdgSsEjzwQfeNgAhB2Mo8M9Pay3vfU/r7Jg1COshA==
X-Received: by 2002:adf:ee8f:: with SMTP id b15mr3164954wro.314.1615970911741;
        Wed, 17 Mar 2021 01:48:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c26sm26048905wrb.87.2021.03.17.01.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:48:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 09:48:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com
Subject: Re: unknown NMI on AMD Rome
Message-ID: <20210317084829.GA474581@gmail.com>
References: <YFDSSxftYw9tCGC6@krava>
 <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net>
 <36397980-f897-147f-df55-f37805d869c9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36397980-f897-147f-df55-f37805d869c9@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kim Phillips <kim.phillips@amd.com> wrote:

> On 3/16/21 2:53 PM, Peter Zijlstra wrote:
> > On Tue, Mar 16, 2021 at 04:45:02PM +0100, Jiri Olsa wrote:
> >> hi,
> >> when running 'perf top' on AMD Rome (/proc/cpuinfo below)
> >> with fedora 33 kernel 5.10.22-200.fc33.x86_64
> >>
> >> we got unknown NMI messages:
> >>
> >> [  226.700160] Uhhuh. NMI received for unknown reason 3d on CPU 90.
> >> [  226.700162] Do you have a strange power saving mode enabled?
> >> [  226.700163] Dazed and confused, but trying to continue
> >> [  226.769565] Uhhuh. NMI received for unknown reason 3d on CPU 84.
> >> [  226.769566] Do you have a strange power saving mode enabled?
> >> [  226.769567] Dazed and confused, but trying to continue
> >> [  226.769771] Uhhuh. NMI received for unknown reason 2d on CPU 24.
> >> [  226.769773] Do you have a strange power saving mode enabled?
> >> [  226.769774] Dazed and confused, but trying to continue
> >> [  226.812844] Uhhuh. NMI received for unknown reason 2d on CPU 23.
> >> [  226.812846] Do you have a strange power saving mode enabled?
> >> [  226.812847] Dazed and confused, but trying to continue
> >> [  226.893783] Uhhuh. NMI received for unknown reason 2d on CPU 27.
> >> [  226.893785] Do you have a strange power saving mode enabled?
> >> [  226.893786] Dazed and confused, but trying to continue
> >> [  226.900139] Uhhuh. NMI received for unknown reason 2d on CPU 40.
> >> [  226.900141] Do you have a strange power saving mode enabled?
> >> [  226.900143] Dazed and confused, but trying to continue
> >> [  226.908763] Uhhuh. NMI received for unknown reason 3d on CPU 120.
> >> [  226.908765] Do you have a strange power saving mode enabled?
> >> [  226.908766] Dazed and confused, but trying to continue
> >> [  227.751296] Uhhuh. NMI received for unknown reason 2d on CPU 83.
> >> [  227.751298] Do you have a strange power saving mode enabled?
> >> [  227.751299] Dazed and confused, but trying to continue
> >> [  227.752937] Uhhuh. NMI received for unknown reason 3d on CPU 23.
> >>
> >> also when discussing ths with Borislav, he managed to reproduce easily
> >> on his AMD Rome machine
> >>
> >> any idea?
> > 
> > Kim is the AMD point person for this I think..
> 
> Since perf top invokes precision and therefore IBS,
> this looks like it's hitting erratum #1215:
> 
> https://developer.amd.com/wp-content/resources/56323-PUB_0.78.pdf

So:


  1215 IBS (Instruction Based Sampling) Counter Valid Value
  May be Incorrect After Exit From Core C6 (CC6) State

  Description

  If a core's IBS feature is enabled and configured to generate an interrupt, including NMI (Non-Maskable
  Interrupt), and the IBS counter overflows during the entry into the Core C6 (CC6) state, the interrupt may be
  issued, but an invalid value of the valid bit may be restored when the core exits CC6.
  Potential Effect on System

  The operating system may receive interrupts due to an IBS counter event, including NMI, and not observe an
  valid IBS register. Console messages indicating "NMI received for unknown reason" have been observed on
  Linux systems.

  Suggested Workaround: None
  Fix Planned: No fix planned

lovely.

Thanks,

	Ingo
