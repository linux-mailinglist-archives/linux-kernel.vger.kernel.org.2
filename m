Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6123E7DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhHJQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhHJQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:41:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C50C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:40:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628613648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjuSVz6QX3gPZe0/YUhh/KoKRLi5gbcY3wcPk69tkVg=;
        b=V8KTwRQsUlYISp+Zp/wPa7tYpnkmyIc4lyVRts//+JoUseq78Kpq1IEcFVuIHAL9PC195r
        isoU0g+fSRgIt0dCQUvmVy8USVkVF6yr44YiBwsaekyt18+xU69+hFYDr+eThvsrTENdGE
        M60OMRVj5Ls6sngEE8fvgHwQEL9oh/MKBZDphcgvcd0yfD0KjEI+jhznQBYGBzD/3cKZqA
        bIiK6oQVrBGl8/ZZSJvvRzAbytYhmHN6VE4ZR/46TGZ51GyNf7K5CbSuW0JGM0nZIvUpwF
        /W6eeMIxZ7OSpNWR58duhYeBjBGVXBX3hVECCzhuRfEcPMb4jT84MHpZADfr7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628613648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjuSVz6QX3gPZe0/YUhh/KoKRLi5gbcY3wcPk69tkVg=;
        b=iiDKh7RneDZe6BRbA9d8co1/o4WYj4Z1n+D4dPL/dDxH+nuqml4NM+5dRTRxFVwmUt/rdk
        VwYfx0xcrhATLOAg==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/4] extensible prctl task isolation interface and
 vmstat sync (v2)
In-Reply-To: <20210730201827.269106165@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
Date:   Tue, 10 Aug 2021 18:40:48 +0200
Message-ID: <87czqlqmlr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On Fri, Jul 30 2021 at 17:18, Marcelo Tosatti wrote:

can you pretty please:

 1) Add a version number to your patch series right where it belongs:

    [patch V2 N/M]

    Just having a (v2) at the end of the subject line of 0/M is sloppy
    at best.

 2) Provide a lore link to the previous version

Thanks,

        tglx
