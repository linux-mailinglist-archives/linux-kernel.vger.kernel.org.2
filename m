Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A693F8E99
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbhHZTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:16:48 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34926 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243360AbhHZTQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:16:47 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 9ABCEB00397; Thu, 26 Aug 2021 21:15:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 92245B00356;
        Thu, 26 Aug 2021 21:15:57 +0200 (CEST)
Date:   Thu, 26 Aug 2021 21:15:57 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
In-Reply-To: <20210826121131.GA152063@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2108262111200.358100@gentwo.de>
References: <20210824152423.300346181@fuller.cnet> <20210824152646.706875395@fuller.cnet> <20210826095958.GA908505@lothringen> <20210826121131.GA152063@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021, Marcelo Tosatti wrote:

> Decided on a separate prctl because the inheritance control
> is not a feature itself: it acts on all features (or how task isolation
> features are inherited across fork/clone).

I am having a hard time imagening use cases for such a feature since I
usally see special code sections optimized to run without OS jitter and
not whole processes. AFAICT You would not want to have any of these on
because they cause performance regression if you must do syscalls related
to process startup and termination.

Since we are adding docs: Could we have some sample use cases for
when these features are useful?
