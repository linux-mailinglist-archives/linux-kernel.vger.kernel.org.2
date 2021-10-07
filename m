Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883CD424B6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbhJGA7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhJGA7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:59:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84C3461130;
        Thu,  7 Oct 2021 00:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633568274;
        bh=komW+5NE27C9leEh8nNx5UfbYZzM+0OjLi9wkZGsyDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fG/4KRD2P5RVUleYJLQlACxIwvaPWzlLD+g2IRS2Hq0/RbBGfBDT3IJlo5AAts512
         zAHuv14SxXX/v13yLZmyAkZXLZfBpxm7zVS7NZaFgcRJpQ2UaZiCAsTuZPzQu/vRF8
         pYgyWKl6Qn03jmrMsg8WICZ1ST80NcjM8duwo0ck=
Date:   Wed, 6 Oct 2021 17:57:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] elfcore: um: Fix CONFIG_UM typo in linux/elfcore.h
Message-Id: <20211006175754.038332e2c358e85ea4e184ed@linux-foundation.org>
In-Reply-To: <CAKwvOdk2tj0bzTajd6F4bPvwXComJSnS+8Jwj3t7EEP5gGoK+A@mail.gmail.com>
References: <20211006181119.2851441-1-catalin.marinas@arm.com>
        <CAKwvOdk2tj0bzTajd6F4bPvwXComJSnS+8Jwj3t7EEP5gGoK+A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 14:57:56 -0700 Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Wed, Oct 6, 2021 at 11:11 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > There is no CONFIG_UM, only UML. In addition, the arch/x86/um/elfcore.c
> > file is only compiled if CONFIG_X86_32. Fix the #if conditions in the
> > linux/elfcore.h header accordingly.
> >
> > Fixes: 6e7b64b9dd6d ("elfcore: fix building with clang")
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Lukas noticed and sent a patch coincidentally just before you:
> https://lore.kernel.org/lkml/20211006082209.417-1-lukas.bulwahn@gmail.com/
> 
> Let me cc' you and Arnd into that thread.

I grabbed Lukas's version, as it seemed more complete.

Also I added cc:stable.
