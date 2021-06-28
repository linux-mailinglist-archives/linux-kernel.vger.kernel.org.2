Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338A83B656A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhF1P1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhF1PDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:03:19 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624892452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJNMj9jH56nxGMNEkc58ec6mbIbhOSkZ93/TnpzDysE=;
        b=km9sefFVa457kBxz9e+IXdXr8go+ygc3AxCRAxA3I7pWztO/WCsrnHFy+7NHMGG4tBtaiU
        fUgE8xa8wlT6fHENp4/U21bwwdv462oJlXlF8BolbKnXftwVq3Xl60nk6KJjHriidDc4eN
        K/oObeI0lJ62ypaq3mFLHQNtgTuTLdwFRuq5dque+b0wteb6D5QBW87pJYsb0HY7AeszDY
        wNbOts9VgJ6a/MotdzmyeY/Y4tndo7bl/O3AfGmDB6pv+dGDm2kpPLgQPRelmHYKkdbKml
        3qj9wYRcsUenHrUtNO1nuaqxKW0I0hk5Nb9viBiX/DMoZuTSasgYvpEE4gGMCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624892452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJNMj9jH56nxGMNEkc58ec6mbIbhOSkZ93/TnpzDysE=;
        b=xFy7ufxYK5ZNsHtcL/NLPFhYB8DxrC04q72NweteV+mU1zJ4Vy5PzSWS1gTVfNG04605xm
        WSb2UfawU7uNeLDg==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait and read
In-Reply-To: <20210628105240.4fc1be2e@oasis.local.home>
References: <20210624111148.5190-1-john.ogness@linutronix.de> <20210624111148.5190-7-john.ogness@linutronix.de> <20210625093354.12384711@oasis.local.home> <YNneRIEIa7pHahTu@alley> <20210628105240.4fc1be2e@oasis.local.home>
Date:   Mon, 28 Jun 2021 17:06:51 +0206
Message-ID: <87o8bqava4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-28, Steven Rostedt <rostedt@goodmis.org> wrote:
> Petr Mladek <pmladek@suse.com> wrote:
>> I was double checking the code and the locking is really hard to
>> follow. I would if the following approach make it easier. The main
>> trick is that the lock is taken at the beginnig and release at
>> the end. It is only temporary released around a single line
>> when needed.
>
> That's a much more common approach to locking, that may not be as
> efficient, but is much easier to keep straight, and less error prone.

OK. I will use this approach for v4. Thank you.

John
