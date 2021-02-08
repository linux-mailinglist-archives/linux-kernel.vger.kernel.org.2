Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2D312D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhBHJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:38:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhBHJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:22:01 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612776078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Jbn6Q+0ScNBjrHfL1qvjxYdd5KQZKNqxUXvPMZpt8g=;
        b=yp1ksBW/rImosc2bD1nooKi/cr6fJPmmD01MSwi4dkef5VnlS8Vx3AEH3wvne7n/YQEI3u
        067zhnaZ9sAHVzBpyaiKmswG8fPq7PvR8agIrod406ua3jBPv+Qa6bJeLCeIUfyL0svz3/
        0XmWC1PLt83ol1vAq15umaDeqWLCbWTxMcp7rOAprItjm4KUi27laBWMG5B/QGPsHZ3X2w
        BdK5tp39BbvobRsBDY6Ml4UZA9vh/pETmN+lNnMchUoSuiwduUmhW/xZwaoW0xhMAkrhAK
        g+ul3efsSx/RkRfBF3cY1LttDhAly5kUN8CyWjGPYhWC3kVd7cr8oXs00aVzWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612776078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Jbn6Q+0ScNBjrHfL1qvjxYdd5KQZKNqxUXvPMZpt8g=;
        b=BZXpSeahX88Z1YlnH7g5cZTcaiNsBQOa6qwLTN8X8X0+zFgUB3PcejZ21xrrXG3pQUUgrP
        PGaXnydXp9riRSAA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
In-Reply-To: <YCDdwY8mMb9JZkXn@jagdpanzerIV.localdomain>
References: <20210205141728.18117-1-john.ogness@linutronix.de> <YCDdwY8mMb9JZkXn@jagdpanzerIV.localdomain>
Date:   Mon, 08 Feb 2021 10:27:17 +0106
Message-ID: <87ft26oqya.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-08, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> Can we please also ask the kernel test robot to test this patch?

LKP is an automated service. The problem was reported for an older
commit. The new patch will not apply.

I will try to contact the LKP team and see how we can get some sort of
verification.

@Avila: Can you also verify that this patch fixes your issue [0]?

John Ogness

[0] https://lkml.kernel.org/r/20210122235238.655049-1-elavila@google.com
