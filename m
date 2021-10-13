Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF542B2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhJMChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhJMChC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:37:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E6A960041;
        Wed, 13 Oct 2021 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634092499;
        bh=EXf5VvAbLwoS5hUyeUcsBU81FhX5kJoUL5RET7XJEkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eq70JzgCxF6JLFqtSYpeO1u8PM/SZwz4YSWfXMfxCurXw7u7NaRESEUJZyU3KBgjB
         pkyuCjc4d29CUCKJCU8jVsUWPbTZyTN+x2XDwXSfBJTbqsys/aZkYry4HKixXIKX2Y
         miRtHuVGdUFDIsQxnqKH1hhvSpeeA6ZuTR0mo/tBYKq3DvZlCp89V6U+nFeEfezoAe
         FdDUUL7W1o/EutzQPNf7Wid4zu2bbMcIr+O7UCzXIlmkhqE0nmrgJ0K/I+sVOuvpMo
         cX78WhZfqSCmXMhOrey3horiTIcrEXvLfJxWk0l9iKmoFnHiIaCK9pnizgh4O2OjoH
         sZHBtnRmJ1sWw==
Date:   Tue, 12 Oct 2021 21:39:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211013023920.GA1090530@embeddedor>
References: <20211005161812.GA768055@embeddedor>
 <20211005123522.244281e6@gandalf.local.home>
 <20211005165027.GA797862@embeddedor>
 <20211005150807.03da5e54@gandalf.local.home>
 <20211005193557.GA881195@embeddedor>
 <20211005200935.2429ec2c@rorschach.local.home>
 <20211006211426.GA916113@embeddedor>
 <20211006171443.4faecbe9@gandalf.local.home>
 <20211013014042.GA1089693@embeddedor>
 <20211012222340.4f5789d7@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012222340.4f5789d7@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:23:40PM -0400, Steven Rostedt wrote:
> On Tue, 12 Oct 2021 20:40:42 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > Do you mind if, in the meantime, I add your patch to my -next tree?
> > So, I can enable -Wcast-function-type in linux-next --I want to get
> > ready for the next merge window.
> 
> You mean to push it to Linus as well? I'm not sure that's the best way.

No. Just add it to my -next tree, temporarily. So, I can enable the
compiler option and it can be tested in linux-next (and no more of
these issues are introduced). The only part I'll send to Linus would
be the Makefile patch.

> I'm still working on some bugs that are going to go into this rc
> release, and then I plan on pushing my for-next queue (which includes
> this change).

Once you have it ready, I would remove it from my tree.

--
Gustavo


