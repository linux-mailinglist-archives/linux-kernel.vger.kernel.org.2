Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A377935AD77
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhDJNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234376AbhDJNOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:14:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F138E610F7;
        Sat, 10 Apr 2021 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618060466;
        bh=aXasx+AstFoj3HDw0Zv75AyHIuHJ93VYSUn//nda9IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TC6c0r2xVx+5x8gxvGcVou3fB//TkwKUVuM9dbLn00CqT6NhQ6rDIeWlnoR4UW8+j
         DTV/aOSL0zdH3W5g8bNacV2yqvyEwkAuh1cmlIs0T6CvwKMinROFXPHgx1ctV3R64D
         Bsf95y6/1OvDMCxqjKxjygHiq7Z6KkTq4N3ZHeOA=
Date:   Sat, 10 Apr 2021 15:14:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2] staging: rtl8192e: fixed pointer error by adding '*'
Message-ID: <YHGksKltkkmaUeAk@kroah.com>
References: <YHGhdtldqAlRsPHT@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHGhdtldqAlRsPHT@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 06:30:38PM +0530, Mitali Borkar wrote:
> Fixed Comparison to NULL can be written as '!...' by replacing it with
> simpler form i.e. boolean expression. This makes code more readable
> alternative.
> Reported by checkpatch.

Checkpatch did not report this specific problem, Julia did :)

And this changelog text does not reflect the commit you made here.

> 
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>

We need a "Reported-by:" line here to reflect that someone reported the
problem as well.

Ideally it will have a "Fixes:" tag also, but I can add that if you
don't know how to do that just yet.

thanks,

greg k-h
