Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9842EEBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbhJOKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhJOKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:30:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A25C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ECzu2faGnuHJG6VmsGBxJOPcYgJEWa/TZh12xWNBgw=; b=BWGXXHKRTb7jLq+E9bMCVPOqSs
        i+RChDnIsrhRxiEaOqoKfgrIDhiDJYQoGzJXLLJdoIKgpVTpNFVqxaM8WZBn3Ivu6C2d8bgXtLWfk
        0ZR7+I/MMxxcTVm1zR33IIPmDq0xnjos6RpRY01zNl6TF2u93awtUcNDgiaQrbqZcMmVze29Ggv+2
        s0D9QQ3nSG6CVChCQtYHEhMWgC1jtYNSqXx3VOmz3rFYSW4ctIiX1ljaj0HCO1fhI07YFrsk//FH6
        AOsRmDc5cQNiHtUkypqnK+rUKGAFSzJDI7VoIWyO9P321yyzAZFBeAzcQFgG0S5PCvq+ymUqOooAR
        0SNVp5cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbKRT-009zBU-5F; Fri, 15 Oct 2021 10:27:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6900B300288;
        Fri, 15 Oct 2021 12:27:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4386E20AC5B6B; Fri, 15 Oct 2021 12:27:58 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:27:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com,
        ak@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: fix ICL/SPR INST_RETIRED.PREC_DIST
 encodings
Message-ID: <YWlXrgxWeTsZ4g3w@hirez.programming.kicks-ass.net>
References: <20211014001214.2680534-1-eranian@google.com>
 <YWgBzFf31lR6oGVA@hirez.programming.kicks-ass.net>
 <CABPqkBRWQ4cm3gmQf6AmoGKjPwjG9hVDXyt6L4CEUk6dkHTvDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRWQ4cm3gmQf6AmoGKjPwjG9hVDXyt6L4CEUk6dkHTvDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:01:15AM -0700, Stephane Eranian wrote:
> On Thu, Oct 14, 2021 at 3:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 13, 2021 at 05:12:14PM -0700, Stephane Eranian wrote:
> > > This patch fixes the encoding for INST_RETIRED.PREC_DIST as published by Intel
> > > (download.01.org/perfmon/) for Icelake. The official encoding
> > > is event code 0x00 umask 0x1, a change from Skylake where it was code 0xc0
> > > umask 0x1.
> > >
> > > With this patch applied it is possible to run:
> > > $ perf record -a -e cpu/event=0x00,umask=0x1/pp .....
> > >
> > > Whereas before this would fail.
> > >
> > > To avoid problems with tools which may use the old code, we maintain the old
> > > encoding for Icelake.
> >
> > Uuuuhhhhh.. but we 'stole' event=0x00 for the fake events. There must
> > not be actual hardware events there or we're in trouble. I thought Intel
> > knew that, I'm sure I told them that.
> 
> Yes, this is a pseudo event code. INST_RETIRED.PREC_DIST 0x0100 only
> works on fixed counter 0
> to deliver the better sample distribution.

Ah, okay. Thanks!
