Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAA3A9470
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhFPHxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:53:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFPHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:53:18 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623829872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9OvmcE8cxuB518UC5c2AX2Kp2gCfP1qGrf/1t9snII=;
        b=SoD2TIzs0MMuq+fFOLvMWVYnRKXbcdWDmvIGtRcKd2UuqJvut2ucob5Hc+CxpjcgTK6VNE
        Sho3XpOqz3hTnm197xTNoQ8sOZX7YXiygxj7wrgYCvG626WIlNTK2/sFu9YPBExr5os4cM
        W00kO/WznJQzK4zms+KdpzO6OhKHooeQ7rqwzOHkpCmwaiBuBc2TUuclHwYXuhpVeUJbej
        C4tTKyDYJgQmhO9zFh6/dvxWnJOhOJiO2MQvGqjVuwCzPxQqwBhxwL9kqM8sV9Erto2WlS
        LcJlKmT9zKc64dbI4kK9TbRWIrJPRYU0LyIF1Xa3cTqhugyngZCBpxk/63CI3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623829872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9OvmcE8cxuB518UC5c2AX2Kp2gCfP1qGrf/1t9snII=;
        b=CNboph5JWoTqydo8mCuohEYnTe1IO6Eewlg8FpsE8QsTbqz9aU7rsEIU1mXIQ4kXiBYQqc
        Xf5wxQ1cJ8iXfTAg==
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
In-Reply-To: <YMmmhDQSX7gLmnN9@alley>
References: <20210614235635.887365-1-punitagrawal@gmail.com> <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk> <YMmggRL/htxFK2VY@alley> <YMmmhDQSX7gLmnN9@alley>
Date:   Wed, 16 Jun 2021 09:57:11 +0206
Message-ID: <87im2ent74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-16, Petr Mladek <pmladek@suse.com> wrote:
>>> Petr, as this is causing trouble for the -rt patchset, please
>>> consider if this could make it to Linus before v5.13 release.
>
> Punit, John, would you mind when I queue this change for-5.14?  It
> seems that, you, RT-guys already handled this, so it will not help
> much if I sent it now. It does not look appropriate to send just a
> single cosmetic fix few days before rc7.

Since this cosmetic problem was introduced during the 5.13 merge window,
it would help if it is fixed before the 5.13 release. Obviously this is
not a reason to have an rc7. But if there is going to be an rc7, I think
this fix should be included.

John Ogness
