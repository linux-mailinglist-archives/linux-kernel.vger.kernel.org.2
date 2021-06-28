Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC933B643C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhF1PG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236294AbhF1OrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:47:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4173661C97;
        Mon, 28 Jun 2021 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624890895;
        bh=IIKM66HZEL3w6GR8TvwHzssDP4N9mwevbz0ldCZCKSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJdbLLV9O2qM46YU3J3I/mUStMcGytbWkg5+8pti3xxMf4SIrLIzmtllm5olsVk7W
         FRdhhvtSkIYyneau1BUChD2NEpcsQ/V/MuZxyUlDL5zGmh0J/V/ymrrlg+iP9bpY9R
         6Carus1590XXWF8G3kI29/t8//lj3kGCM+pRlEM4=
Date:   Mon, 28 Jun 2021 16:34:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tools/relocs: Mark die() with the printf function
 attr format
Message-ID: <YNneDYWw4MtQh0WH@kroah.com>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
 <YNXG472lXPHlbuCF@kroah.com>
 <YNXkVBcmBvZL7khv@zn.tnic>
 <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
 <YNYJ9vVQPVWqCvVq@zn.tnic>
 <1EFF7FE1-D341-41DF-8681-D386A1BD6F7A@zytor.com>
 <YNZFkG/tuHkwpyug@zn.tnic>
 <YNiSyFNbAMVxN6wO@kroah.com>
 <YNnb6Q4QHtNYC049@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNnb6Q4QHtNYC049@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 04:25:45PM +0200, Borislav Petkov wrote:
> On Sun, Jun 27, 2021 at 05:01:28PM +0200, Greg Kroah-Hartman wrote:
> > This works for me!  It should fix the static checking tool that keeps
> > tripping over this pointless warning :)
> > 
> > Want to turn it into a real patch?
> 
> How's that?
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> Mark die() as a function which accepts printf-style arguments so that
> the compiler can typecheck them against the supplied format string.
> 
> Use the C99 inttypes.h format specifiers as relocs.c gets built for both
> 32- and 64-bit.
> 
> Original version of the patch by Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/tools/relocs.c | 37 ++++++++++++++++++++-----------------
>  arch/x86/tools/relocs.h |  1 +
>  2 files changed, 21 insertions(+), 17 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
