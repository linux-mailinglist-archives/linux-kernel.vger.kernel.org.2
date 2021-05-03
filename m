Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F7371379
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhECKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhECKOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:14:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9093611F0;
        Mon,  3 May 2021 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620036818;
        bh=VH21PufZUwDIyYfTud1amFvN2W+xniGX/jhz9rO7xmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYxuIT2anto6IHJA0jnTYsxUtzipm0TjAFYvthLhpLqX804tTBBS952Er6bgHOqRl
         U95PgvVzsq6TeUGLV9+0lROGeOqztAyQyE+xdxLjNsbOo1yD5rLKnfCJcn/OxVMjrA
         EcpkRACl3KZm3pZxxD4Z0EOPjvccELFZREM51cC4S6hnTjQlPYeowuqgGGD5tKIXgL
         XVPKa3qhhxHvm5aiAmdf5DeNEfbYZ6b5mwVP1b1hUE+8XEsKEv79R6jGF3054BE3Bx
         IB4m1cC+Tgxp0Ib9uv5KHki1ZCXMSxB5hA7yMae80GT/Q4sXTE69d8vksk7z2fotxT
         1pBbFsK6ja1sQ==
Date:   Mon, 3 May 2021 12:13:34 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.13
Message-ID: <YI/MzgHgDW6ka7B0@gunter>
References: <YIlcBHhuR9LvKZ7q@gunter>
 <CAHk-=wgoC=9tJZg391exBryFYK04e_BSpKwCmJLMwDntar4x_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoC=9tJZg391exBryFYK04e_BSpKwCmJLMwDntar4x_w@mail.gmail.com>
X-OS:   Linux gunter 5.11.16-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Linus Torvalds [30/04/21 12:37 -0700]:
>On Wed, Apr 28, 2021 at 5:58 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>>    Therefore, load the __exit sections even when
>>    CONFIG_MODULE_UNLOAD=n, and discard them after init.

Hi Linus,

>So I've pulled this, but I have two questions based on reading the patch..
>
> (a) Where's that "discard them after init" logic?

So the idea is for the exit sections to additionally identify as init
sections via module_init_section() when CONFIG_MODULE_UNLOAD=n, so
that the existing logic in layout_sections() picks this up and puts
the exit sections into the init area of the module (mod->init_layout.base).

Then, since we've placed the exit sections in the init region of the
module, they will automatically get freed at the end of
do_init_module() with the rest of the init sections. Peter has also
mentioned that jump_label and static_call want the exit sections to
also identify as init via within_module_init(), so this change should
satisfy their requirement as well. I should have explained this more
in the changelog and apologize that it wasn't clear.

> (b) ARM has its own module_init/exit_section() functions, and now
>seems to have different logic than everybody else as a result..

No, you are right, I had forgotten that ARM is a special case :-( I
will add a similar hunk for ARM and submit that for the next -rc so
that all arches are on the same page here.


Jessica
