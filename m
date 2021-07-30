Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172D53DB0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhG3BlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 21:41:16 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:43430 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhG3BlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 21:41:16 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9HWN-00540v-3i; Fri, 30 Jul 2021 01:41:07 +0000
Date:   Fri, 30 Jul 2021 01:41:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     John Cotton Ericson <mail@johnericson.me>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Subject: Re: Leveraging pidfs for process creation without fork
Message-ID: <YQNYs+BKenJHBMSP@zeniv-ca.linux.org.uk>
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
 <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
 <cf07f0732eb94dbfa67c9d56ceba738e@AcuMS.aculab.com>
 <f8457e20-c3cc-6e56-96a4-3090d7da0cb6@JohnEricson.me>
 <20210729142415.qovpzky537zkg3dp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729142415.qovpzky537zkg3dp@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:24:15PM +0200, Christian Brauner wrote:
> On Wed, Jul 28, 2021 at 12:37:57PM -0400, John Cotton Ericson wrote:
> > Hi,
> > 
> > I was excited to learn about about pidfds the other day, precisely in hopes
> > that it would open the door to such a "sane process creation API". I
> > searched the LKML, found this thread, and now hope to rekindle the
> > discussion; my apologies if there has been more discussion since that I
> 
> Yeah, I haven't forgotten this discussion. A proposal is on my todo list
> for this year. So far I've scheduled some time to work on this in the
> fall.

Keep in mind that quite a few places in kernel/exit.c very much rely upon the
lack of anything outside of thread group adding threads into it.  Same for
fs/exec.c.
