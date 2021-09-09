Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE54047A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhIIJV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhIIJV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:21:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD792C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IyaHxbHrWHESvHEgCgnS7Dg++IJnYpRzFIhVsk07plM=; b=kQCev6k9EudyOuQUg40ymmqsPM
        61OHyrfzV8y/acWXLARd6ZfHFHOSnezuzqF405IrKoeHePEmOlxBLlLiA0r2EtlRhhm67+l+ZoA7i
        lp3fOpeb4BpA5UdJgsofTvs8idE9erc6ZPd1PFYxlz8sYenKpn6A5tSCIeMHGTUNhj2+wOgyZIDmH
        WDFYgJi7geDCVrrWORAfx94hfjy5TGxjwPDGxSyXVsc+Iuos0JU370R6ktVj8USFg0MyZMj1EzzBR
        VyXfOXaO7/W34O2DdvEFS+Rt9P/CGdhvwYHOpcdkRkqpQ5DqIt2AmbXN/gfiG3qgI+Iwd0I/ptseO
        pQWXQWAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOGE4-001pv3-ST; Thu, 09 Sep 2021 09:20:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BF9F300094;
        Thu,  9 Sep 2021 11:20:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 658742C625917; Thu,  9 Sep 2021 11:20:08 +0200 (CEST)
Date:   Thu, 9 Sep 2021 11:20:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 09/13] perf/x86/amd: add idle hooks for branch sampling
Message-ID: <YTnRyDT5iIlpk8Af@hirez.programming.kicks-ass.net>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-10-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909075700.4025355-10-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:56:56AM -0700, Stephane Eranian wrote:
> On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled before entering low power
> and re-enabled (if was active) when returning from low power. Otherwise, the NMI interrupt may
> be held up for too long and cause problems. Stopping BRS will cause the NMI to be delivered if it
> was held up.

What you sent me ^^^, vs reflow at 72 chars vvv:

On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled
before entering low power and re-enabled (if was active) when returning
from low power. Otherwise, the NMI interrupt may be held up for too long
and cause problems. Stopping BRS will cause the NMI to be delivered if
it was held up.

(because git show has that stupid extra indentation for Changelogs)

