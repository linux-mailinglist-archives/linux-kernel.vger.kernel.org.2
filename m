Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D034B38032A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhENE4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:56:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34266 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhENE4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:56:50 -0400
Date:   Fri, 14 May 2021 06:55:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620968139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDYBAnUNVds5/OtpkhwNFKlve4qytkO6+gA4HAqZDTs=;
        b=EO4taY8WAUQepkIPrbKdufIr8KJwcrhs39A5L57J0vWwteB+JghYgyCYOtc2giQXdvF9O5
        dyUREJ2GzCaT/YDVRLJE0ymYeq6WwBBafaf2fuoDZAw/rjVFB+tbKQlhNfddXH2d+q6pgX
        /78oq9NkGJXgLNiKSp3dl2m4ccM+JJrl3AhftCNeVHUw81aAysqmtMiIRcQLkeI9e8FU/g
        nh8LVZ8srYI08HfDbtczbax0YXhE3+i4kks9DnaR158l3W0YFuofDKmWVvk3m/XaM3nZwx
        IY6quqxqRHxd+1lFdKM5EJskWk5IX69hdpkj/jgycM2pl0hlOBk5LPMP5A2/5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620968139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDYBAnUNVds5/OtpkhwNFKlve4qytkO6+gA4HAqZDTs=;
        b=Tym0xYGDi0Fe4s9N/qSGAYWA91XxDnFqsm4dbXDd3rxZKFQgXrqrjZoOiN6uKo7xIzIj7s
        tXkni8Ls23/ykQCQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de,
        tglx@linutronix.de, shung-hsi.yu@suse.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2] seqlock,lockdep: Only check for preemption_disabled
 in non-rt
Message-ID: <YJ4CydK5NiSkpkSO@lx-t490>
References: <20210507233951.78950-1-dave@stgolabs.net>
 <20210507234713.86097-1-dave@stgolabs.net>
 <YJuVhR9C6pUmZBOs@hirez.programming.kicks-ass.net>
 <20210513195357.xq57b2t26hhhmdn4@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513195357.xq57b2t26hhhmdn4@offworld>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021, Davidlohr Bueso wrote:
>
> And therefore converting it to an associated spinlock would avoid the
> preemption check, which is exactly what Ahmed has already done:
>
> bc8e0adff34 (net: xfrm: Use sequence counter with associated spinlock)
> e88add19f68 (net: xfrm: Localize sequence counter per network namespace)
>
> Sorry for the noise.
>

Exactly, so it seems everything is good on your side :)

(The pending patch queue I mentioned is much larger and gets rid of the
 main packet scheduling sequence counter Qdisc::running, but I'm
 brushing it up, then sending it for an internal review round, first.
 There are already some workarounds in the RT tree for that one until
 the correct fix is merged mainline.)

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
