Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9985431478C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhBIEcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhBIEBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 23:01:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE5AB64E8C;
        Tue,  9 Feb 2021 03:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612843200;
        bh=BT5G6hDydO7Z4cLz9dvfPbU6nwbCCY0Hm+9TTgwZdaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTTl5RaqXBiJ020DI3KFCN2+QG9oo9nEBzkeDfRuQHKvjUO/W2lG8+SQE1dNlQWb0
         UIw94m9cO4W8LMyCBkKVwOdTkeeMzVSUEJh4tj8oh30gWyXwni1q2baI5UAc7aQvme
         4kPiGtSwxa09L41Im7SncLXgoAY/hJtjgfNO1/Uuy1awmqQiAIf69IRCzO0QgBKxab
         bZojKVteJ2XmE7qTNygj18149E7GZXFGS8ErnSraGDcdTMN8hXDLJfOxlMo90hOgJn
         StuNodUbLqD6OLBl01LDQjSu36Nq685UOp5XqV8diNruDs8w72+EZiUew5goALK6Zl
         rIgjdx70cWgaw==
Date:   Mon, 8 Feb 2021 20:59:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicolas Pitre <npitre@baylibre.com>,
        clang-built-linux@googlegroups.com, linux-i3c@lists.infradead.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Fix position of __maybe_unused
 in i3c_hci_of_match
Message-ID: <20210209035958.GA2059815@ubuntu-m3-large-x86>
References: <20201222025931.3043480-1-natechancellor@gmail.com>
 <160943653614.132002.12499200411415721355.b4-ty@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160943653614.132002.12499200411415721355.b4-ty@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:42:23PM +0100, Alexandre Belloni wrote:
> On Mon, 21 Dec 2020 19:59:31 -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> >  ../drivers/i3c/master/mipi-i3c-hci/core.c:780:21: warning: attribute
> >  declaration must precede definition [-Wignored-attributes]
> >  static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
> >                      ^
> >  ../include/linux/compiler_attributes.h:267:56: note: expanded from macro
> >  '__maybe_unused'
> >  #define __maybe_unused                  __attribute__((__unused__))
> >                                                         ^
> >  ../include/linux/mod_devicetable.h:262:8: note: previous definition is
> >  here
> >  struct of_device_id {
> >         ^
> > 1 warning generated.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in i3c_hci_of_match
>       commit: 291b5c9870fc546376d69cf792b7885cd0c9c1b3
> 
> Best regards,
> -- 
> Alexandre Belloni <alexandre.belloni@bootlin.com>
> 

Hi Alexandre,

I see as of v5.11-rc7 that this is still an issue even though it has
been applied to the fixes branch. Is it possible for this to make it in
to 5.11 final?

Cheers,
Nathan
