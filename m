Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA8359F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhDINKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDINKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:10:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 620DB61105;
        Fri,  9 Apr 2021 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617973793;
        bh=iSxuNZd0oELMkAXw8fnWyOjEVFUvCW/GZcyHdjsL7m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyNxkzJdsuUEOMLDnrbSJJoNL0Bv8hQrZApP6EfnnmkpuMyMH6Bnf3LcTrpT6o+8H
         q0LaR1ULCh9XvI9YDulxI8Nwfv4X0mwedWdoz8UWYPiI+ptUPxiSuooexI5XmAopwg
         bygq7scdHyX2U930EkCzw9olMlDrOYR9lSY/5ceM=
Date:   Fri, 9 Apr 2021 15:09:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs: reporting-issues: make people CC the
 regressions list
Message-ID: <YHBSHjzy2nP97Fb2@kroah.com>
References: <cover.1617967127.git.linux@leemhuis.info>
 <ac28089d710d5d41f295221bc726555ba32f4984.1617967127.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac28089d710d5d41f295221bc726555ba32f4984.1617967127.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:47:24PM +0200, Thorsten Leemhuis wrote:
> Make people CC the recently created mailing list dedicated to Linux
> kernel regressions when reporting one. Some paragraphs had to be
> reshuffled and slightly rewritten during the process, as the text
> otherwise would have gotten unnecessarily hard to follow.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> ---
> v1->v2
> * drop the bits that a would help a automatic tracking solution
> 
> FWIW, a quick reminder about something I wrote in v1, but nobody said
> anything about it: now that we have a mailing list for regressions I was
> inclined to remove the "Make the report's subject start with
> '[REGRESSION]'" part from the text. But in the end I left it, to make it
> obvious on other lists that the mail is about a regression.
> Nevertheless, I'm still wondering if it should be toned down a bit, as
> it might be enough if the subject starts with "regression:" or contains
> the word somewhere.

Let's see if anyone notices about [REGRESSION] or not, it can evolve
over time :)

thanks,

greg k-h
