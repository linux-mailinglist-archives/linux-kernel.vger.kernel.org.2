Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE81A43CCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbhJ0Ov5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhJ0Ovy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:51:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF41C60EDF;
        Wed, 27 Oct 2021 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635346168;
        bh=rkdpGsPtgaMRwYC4OAq4kL/RZZMCGxrm7Vs+XCO5Lh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gmx96FEVG67Xaiv2oOjpavozw0grFh07hy4GDJJeOernma3rTQSmGmafUpc2fnbSW
         r+EQtKT1wa7AO47NJusMOvK7DAFkJykCGuNgm73UuO46pXm9QSoS4hD3DIqLGNdhc2
         6Ec5MAfUqqzX8TTL6SHQ2cwzK2WUQ6UBFs4RuIttgF46qUpawlHOoLj5EGNMLIFAvu
         T0ZqpKe9cgWXtTASNSH35uQE2zrmibuHcPv/MIYMZ9nsx1iH3GwbatW1Vxn/AWA9wV
         KWrFa9+iOjx389yCWDMwzd7NBtgf+1DruqMVsIc6Z0h9Pmja/B+uAnQKpXs1JrIwWU
         LIgJoUpJ14Ydw==
Date:   Wed, 27 Oct 2021 23:49:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix to initialize 'ret' local variable
Message-Id: <20211027234926.c5660ecfb09dd0958c3f60d0@kernel.org>
In-Reply-To: <20211027101909.7dde903e@gandalf.local.home>
References: <163534286875.793799.13298849524607405594.stgit@devnote2>
        <20211027100126.58769bf9@gandalf.local.home>
        <20211027231646.cf5333aa08f70fe7f167e4d5@kernel.org>
        <20211027101909.7dde903e@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 10:19:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 27 Oct 2021 23:16:46 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > 
> > > I'm fine taking yours instead. But I'd like to update the text explaining
> > > how the ret can be uninitialized and what happens if we set it to zero.  
> > 
> > Yeah, I'm also good for both, but the Fixes tag must be updated.
> 
> OK, I'll take mine then and update the fixes tag. Care to reply with a
> Reviewed-by tag?

Yes, sure, I sent it:)

> 
> Thanks,
> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
