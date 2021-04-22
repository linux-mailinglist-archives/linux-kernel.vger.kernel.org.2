Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD423676DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhDVBeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231128AbhDVBeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:34:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765B9613ED;
        Thu, 22 Apr 2021 01:33:32 +0000 (UTC)
Date:   Wed, 21 Apr 2021 21:33:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Fix unused variable warning
Message-ID: <20210421213330.0faabfc6@oasis.local.home>
In-Reply-To: <6cccb650-9aef-f16c-7ec5-53d3042af292@roeck-us.net>
References: <20210422003334.139452-1-linux@roeck-us.net>
        <20210421204139.669f5c22@oasis.local.home>
        <6cccb650-9aef-f16c-7ec5-53d3042af292@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 18:24:15 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 4/21/21 5:41 PM, Steven Rostedt wrote:
> > 
> > Second patch with the exact same update. Perhaps we should take one
> > before we get more of them ;-)
> > 
> > https://lore.kernel.org/lkml/20210416194300.3952208-1-cmllamas@google.com/
> >   
> 
> Sorry, I missed the other one.
> 


That's OK, I just thought you might have been doing some "research" on us.

What? Too soon?

-- Steve
