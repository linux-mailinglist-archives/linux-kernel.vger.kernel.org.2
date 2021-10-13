Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8F42B297
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhJMCZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233316AbhJMCZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:25:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC62160273;
        Wed, 13 Oct 2021 02:23:41 +0000 (UTC)
Date:   Tue, 12 Oct 2021 22:23:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211012222340.4f5789d7@oasis.local.home>
In-Reply-To: <20211013014042.GA1089693@embeddedor>
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
        <20211013014042.GA1089693@embeddedor>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 20:40:42 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Do you mind if, in the meantime, I add your patch to my -next tree?
> So, I can enable -Wcast-function-type in linux-next --I want to get
> ready for the next merge window.

You mean to push it to Linus as well? I'm not sure that's the best way.
I'm still working on some bugs that are going to go into this rc
release, and then I plan on pushing my for-next queue (which includes
this change).

-- Steve
