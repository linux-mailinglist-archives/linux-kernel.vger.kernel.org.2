Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3971740BD49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhIOBrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhIOBrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E47260F6C;
        Wed, 15 Sep 2021 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631670353;
        bh=xMCS2nurSB8LZcGtKXwO1JEEW4Gr1XYO8f1Eg2h7Llo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eq7ZBiU+azjY2HTf8eCwJpXY8Lt51e/wJxrpxUJM4mxNP1LMnWqbZew2Nicbd0OG7
         5HV9KsfBbFaviO0slh0yuCd87SftqUNHruRkB3a8fAnwiZ1c+J9XjHHTrulZqNFfUP
         zCpsS1TRJuyGyovE+gFN+8bKwJbZfUl79Agq1XCBfJP1lQHKjvl1obQL0R6uRwkyJS
         KTwH3nnrB7RO1xVJVvJ31EvyMkTVLRQLJ1x6xG153ad6rFDJ/RvcEpPFzeguNwBR5f
         xdsThmNWN8SorWHcoV2XyCMquaytxvygaNmJttXtBGrIa9Zp506AASugD2I2NetwEw
         LhlQHH4raVqrQ==
Date:   Wed, 15 Sep 2021 10:45:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 4/5] bootconfig: Free copied bootconfig data after
 boot
Message-Id: <20210915104550.99a35ef0f1b0e944febf3293@kernel.org>
In-Reply-To: <CAHk-=wigVUWvHaJKZNW+VTKWLQxCvOpoysuXQTYjO6b7VZ3GJg@mail.gmail.com>
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
        <163166721027.510331.6820619440348067061.stgit@devnote2>
        <CAHk-=wigVUWvHaJKZNW+VTKWLQxCvOpoysuXQTYjO6b7VZ3GJg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 18:13:51 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Sep 14, 2021 at 5:53 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Free copied bootconfig data after booting kernel because that
> > data will not be used anymore.
> 
> Don't do this.
> 
> You have already passed in that 'copy' to the xbc code, and
> xbc_destroy_all() should just free it.
> 
> Don't add new pointless variables to keep track of state that somebody
> else already keeps track of.

Ah, OK. So when I pass the copy, the ownership should be passed too.

Thank you,

> 
>            Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
