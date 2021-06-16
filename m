Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CA3A9C06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhFPNcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhFPNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:32:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B0B61166;
        Wed, 16 Jun 2021 13:30:44 +0000 (UTC)
Date:   Wed, 16 Jun 2021 09:30:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 1/5] string_helpers: Escape double quotes in
 escape_special
Message-ID: <20210616093042.2036ef2c@gandalf.local.home>
In-Reply-To: <YMmxcjeEHHzCLKtX@smile.fi.intel.com>
References: <cover.1623775748.git.chris@chrisdown.name>
        <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
        <CAHp75Vc-edpD5kz0EPsO7Q=zOPHWFckZzc17imO85dQy-PpOgg@mail.gmail.com>
        <YMk/IKA4okfYSh57@chrisdown.name>
        <796701ff-18f9-a637-fca4-808ae36b336f@infradead.org>
        <YMmxcjeEHHzCLKtX@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 11:08:18 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 15, 2021 at 07:05:25PM -0700, Randy Dunlap wrote:
> > On 6/15/21 5:00 PM, Chris Down wrote:  
> > > Andy Shevchenko writes:  
> > >>> I've checked uses of ESCAPE_SPECIAL and %pE across the codebase, and I'm  
> > >>
> > >> checked the uses  
> > > 
> > > Hmm, what's wrong with using the zero article for "checked uses"? I mean, I don't have any strong resistance, but I don't see anything wrong with it either, and it matches how I'd naturally speak.
> > > 
> > > Agreed on the others, though, hopefully they can be massaged in :-)  
> > 
> > Ack, I don't see anything wrong with it either.  
> 
> I guess you know better than me :-)
> 
> I'm just a mere non-native speaker here to whom it's stylistically harder to
> parse without the article.

English is weird. It sounds fine to me with and without the "the" article,
but I'll say having "the" does make it a little smoother, and probably
better for the non-native speaking folks.

Technically, I'm a native speaker, but I prefer to say my mother tongue is C. ;-)

-- Steve
