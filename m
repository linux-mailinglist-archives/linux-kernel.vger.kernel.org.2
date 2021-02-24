Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA103243AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhBXSVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhBXSVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:21:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6DE264E6B;
        Wed, 24 Feb 2021 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614190854;
        bh=nhrXWqf/AsZdXUVa95Ly9pNufse5xw4fS1fpiI0sHQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k0nC12vpQ3NmalV1GbiJlabOxL0csR6ual+AQzwNCHPpCQPRPJWwaMdMs2vUgwPOP
         hSwp2QGp54C1h3QeSX93YExdRaH8errHdu3z4mrhb/RW4/6tQ6GTBtELzho/WIVeym
         c5yN5JBhS1LeOZANDm/h/9ZwfP6s5kaLcQ2xeNjM=
Date:   Wed, 24 Feb 2021 10:20:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
Message-Id: <20210224102052.009aaa27dd5b530d7e7ef599@linux-foundation.org>
In-Reply-To: <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com>
References: <20210224081652.587785-1-sumit.garg@linaro.org>
        <CAD=FV=VOdf1TyXWQOyP=y2xaLxY6_c+xm-VSSUkFasJD1Cbgpw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 10:09:25 -0800 Doug Anderson <dianders@chromium.org> wrote:

> On Wed, Feb 24, 2021 at 12:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Currently breakpoints in kernel .init.text section are not handled
> > correctly while allowing to remove them even after corresponding pages
> > have been freed.
> >
> > Fix it via killing .init.text section breakpoints just prior to initmem
> > pages being freed.
> 
> It might be worth it to mention that HW breakpoints aren't handled by
> this patch but it's probably not such a big deal.

I added that to the changelog, thanks.

I'll take your response to be the coveted acked-by :)
