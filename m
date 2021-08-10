Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D123DA644
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhG2OYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237350AbhG2OYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:24:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F90460560;
        Thu, 29 Jul 2021 14:24:18 +0000 (UTC)
Date:   Thu, 29 Jul 2021 16:24:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     John Cotton Ericson <mail@JohnEricson.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Subject: Re: Leveraging pidfs for process creation without fork
Message-ID: <20210729142415.qovpzky537zkg3dp@wittgenstein>
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
 <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
 <cf07f0732eb94dbfa67c9d56ceba738e@AcuMS.aculab.com>
 <f8457e20-c3cc-6e56-96a4-3090d7da0cb6@JohnEricson.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8457e20-c3cc-6e56-96a4-3090d7da0cb6@JohnEricson.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 12:37:57PM -0400, John Cotton Ericson wrote:
> Hi,
> 
> I was excited to learn about about pidfds the other day, precisely in hopes
> that it would open the door to such a "sane process creation API". I
> searched the LKML, found this thread, and now hope to rekindle the
> discussion; my apologies if there has been more discussion since that I

Yeah, I haven't forgotten this discussion. A proposal is on my todo list
for this year. So far I've scheduled some time to work on this in the
fall.

Thanks!
Christian
