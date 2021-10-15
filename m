Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2042ECDC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJOIzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhJOIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:54:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E8C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kAEEo2bMo6/W8jfykUA5d09Ap+RguoOMMLVNz+7/o4o=; b=qvoIa/BfsX2Ay4vRwY1vzpwBJe
        RoAsHNxUPycxn1csWxDtG4n0RKTV5kDmiZD3KuHaJu1zxxkzTrnxxTUsuQlEdbzasoTizeC7EbAOd
        LHm8DGPaTiO0/L8E1yoVFh9V+tg2ea74SoIWBq7HRQN5WZRnykJCGaQfwSdoaM7a1IytsoxDSgtDK
        PtHCftnH9dYsJtvj8E4fmACtH7UiDxcBQ0dg1HtRo29EYPOupf6GkXbtc/EixRha6oE3JaQEKS1z/
        61qc682ZOpiEofUqZP7xKt5lOTtVyUk1FpVPAMemJyRfTBXwq2hAatmOX8LDDwneIIkMbgnmBnZaq
        hJgP0LbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbIx9-009yU0-Fg; Fri, 15 Oct 2021 08:52:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D285030031A;
        Fri, 15 Oct 2021 10:52:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B964420125B2E; Fri, 15 Oct 2021 10:52:33 +0200 (CEST)
Date:   Fri, 15 Oct 2021 10:52:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Norbert <nbrtt01@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Performance regression: thread wakeup time (latency) increased
 up to 3x
Message-ID: <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
> Performance regression: thread wakeup time (latency) increased up to 3x.
> 
> Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.

Could you git-bisect this?
