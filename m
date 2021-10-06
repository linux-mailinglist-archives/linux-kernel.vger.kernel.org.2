Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837E34248A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhJFVQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239488AbhJFVQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:16:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B63C61152;
        Wed,  6 Oct 2021 21:14:45 +0000 (UTC)
Date:   Wed, 6 Oct 2021 17:14:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211006171443.4faecbe9@gandalf.local.home>
In-Reply-To: <20211006211426.GA916113@embeddedor>
References: <20211005053922.GA702049@embeddedor>
        <20211005111714.18ebea2b@gandalf.local.home>
        <20211005161812.GA768055@embeddedor>
        <20211005123522.244281e6@gandalf.local.home>
        <20211005165027.GA797862@embeddedor>
        <20211005150807.03da5e54@gandalf.local.home>
        <20211005193557.GA881195@embeddedor>
        <20211005200935.2429ec2c@rorschach.local.home>
        <20211006211426.GA916113@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 16:14:26 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> > Which I guess leaves us with either the linker trick, or having all
> > the archs get updated to support the latest ftrace features, and we can
> > remove the current #ifdefs.  
> 
> OK. Are you going to apply your patch any time soon? So, I can go and
> enable -Wcast-function-type in my -next tree. :)

Sure. I only did not add it because of the issue Jann brought up. But if it
is needed, and I do not want more #ifdef all over the code, I'll add it,
and perhaps even mark it for stable.

I'm working on some other fixes now anyway.

-- Steve

