Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3188542F9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbhJORPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242068AbhJORPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:15:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 188F4610E8;
        Fri, 15 Oct 2021 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634317990;
        bh=VRvCgVl+c//XzNBQ2V8OIkV7ggBQcxC5gMCr8ztLdFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BD8Jd/d9u6v7/jMJ5e5lFdrL4ElC2BTL/Uwx3emFlTdYpFT6ufTCCcmSiNBkg+iuL
         uk4bFKHBY+DufTQ7kh5RgPEhLAbzn+jl3TnLFtIHkAu938jjvVXstGbuE0vp4djR/b
         Ce6l7O0B3bcpHD3hle1Q/ZKd6mhYnHkl1A1JwBcZiLFKhuLzF8FSAJyovS3gzi2Smp
         VoeqrbHXVq+L7uW5lWIyyzJuo/LIPPgX2ID700bqeOgoS5fq1cb4hIsKlYo1m2v3Fn
         t5TscUJ1KLnlv7CssbVOZ3QDRzLqVskQ/3DMBWvfpL1yxjvjVKgQ8TpI+t/p5o5lbZ
         P22JEfqV6kWjg==
Date:   Fri, 15 Oct 2021 10:13:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in
 hfa384x_usb_throttlefn()
Message-ID: <YWm2oVk9YKzjhYYi@archlinux-ax161>
References: <20211014215703.3705371-1-nathan@kernel.org>
 <20211015094344.GQ8429@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015094344.GQ8429@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:43:44PM +0300, Dan Carpenter wrote:
> On Thu, Oct 14, 2021 at 02:57:03PM -0700, Nathan Chancellor wrote:
> > A new warning in clang points out a place in this file where a bitwise
> > OR is being used with boolean expressions:
> > 
> > In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
> >             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> >             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
> > 1 warning generated.
> 
> Both sides of this bitwise OR are bool, so | and || are equivalent
> logically.  Clang should not warn about it.

I do not disagree. The original motivation for the warning was code like

if (a() & b())

where a '&&' was intended to short circuit the call to b() if a() was
false but then it expanded to encompass bitwise OR as well. The clang
developers felt that warning on bitwise OR was worthwhile because most
of the time, '||' was intended. Feel free to comment on the Phabricator
thread if you feel strongly, there are not too many instances of this
warning and I think the '&' vs '&&' aspect of the warning is useful.

https://reviews.llvm.org/D108003

Cheers,
Nathan
