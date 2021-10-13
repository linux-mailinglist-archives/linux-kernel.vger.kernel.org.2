Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E8B42B24D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 03:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhJMBiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 21:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhJMBiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 21:38:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDD6860F21;
        Wed, 13 Oct 2021 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634088982;
        bh=ffNeVVT7MmQtCBKwP9CXNH+1zDuf7urK1ZbuwrqwlTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFyFhnwVvrTRnV8BtudZ1rp9Fx3NAKYDgkoa8M//JVNSVFH4qBuNZbMbdSfyLUb6P
         OD1K8CWXddERdGZeb8L0vm0IT8m9N5KqdIaYd8Cb7+Xp9znx1HBDq8XyhhoFRX9zpK
         ca42FTsmlgcz2kQTXWIQhGCN72Nt/24dN/ZAv/L2xyEObRmDXPnWRnfvara05pHUc1
         z/VEgSYuikc2dGh3xQ8ZJf61/KvkVJGTd+4wvGS92AycF2EWZ1LvdUAixkJX8zUeac
         aPrxTPlb+kcuxCQ2+E7CmNRxHwdBW0cKOk8HhZ59k1LQGnZ5jkS7QDxk+AWmVcBxoR
         9qgZxS4lRNcdQ==
Date:   Tue, 12 Oct 2021 20:40:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211013014042.GA1089693@embeddedor>
References: <20211005053922.GA702049@embeddedor>
 <20211005111714.18ebea2b@gandalf.local.home>
 <20211005161812.GA768055@embeddedor>
 <20211005123522.244281e6@gandalf.local.home>
 <20211005165027.GA797862@embeddedor>
 <20211005150807.03da5e54@gandalf.local.home>
 <20211005193557.GA881195@embeddedor>
 <20211005200935.2429ec2c@rorschach.local.home>
 <20211006211426.GA916113@embeddedor>
 <20211006171443.4faecbe9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006171443.4faecbe9@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

On Wed, Oct 06, 2021 at 05:14:43PM -0400, Steven Rostedt wrote:
> On Wed, 6 Oct 2021 16:14:26 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > > Which I guess leaves us with either the linker trick, or having all
> > > the archs get updated to support the latest ftrace features, and we can
> > > remove the current #ifdefs.  
> > 
> > OK. Are you going to apply your patch any time soon? So, I can go and
> > enable -Wcast-function-type in my -next tree. :)
> 
> Sure. I only did not add it because of the issue Jann brought up. But if it
> is needed, and I do not want more #ifdef all over the code, I'll add it,
> and perhaps even mark it for stable.
> 
> I'm working on some other fixes now anyway.

Do you mind if, in the meantime, I add your patch to my -next tree?
So, I can enable -Wcast-function-type in linux-next --I want to get
ready for the next merge window.

Thanks
--
Gustavo
