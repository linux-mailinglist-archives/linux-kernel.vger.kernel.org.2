Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA22371E04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhECRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234279AbhECQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:57:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D20561155;
        Mon,  3 May 2021 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620060956;
        bh=48R4guCtmFRYjBJPQlc+uVeGjKcxBvE1ijucVcv5Mso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJWIviI8Raf+3VzPkOnr7Ubjv7AiKKwq4R5T7VZnLZC57HrDbJ+slhyXVDI4Aa62E
         kvIyk8qkekKlWebMUsymZKi8imwk9bHBABaSZMnw5gMdMMtbEffltyRIz4aKxG5NW/
         JUcFi2MTIxMPJI3yDGzT2KADu80ayAuI0CH6NW5c=
Date:   Mon, 3 May 2021 18:55:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Kurt Manucredo <fuzzybritches0@gmail.com>
Subject: Re: [PATCH 33/69] ALSA: gus: properly handle snd_ctl_add() error
Message-ID: <YJArGpmTYXvqlkMd@kroah.com>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-34-gregkh@linuxfoundation.org>
 <s5h7dkgrogm.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7dkgrogm.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 02:28:25PM +0200, Takashi Iwai wrote:
> On Mon, 03 May 2021 13:57:00 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > From: Kurt Manucredo <fuzzybritches0@gmail.com>
> > 
> > snd_gus_init_control() does not properly return any possible error that
> > might have happened in a call to snd_ctl_add() so resolve this by
> > propagating the error back up the call change correctly.
> > 
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Kurt Manucredo <fuzzybritches0@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This change doesn't look good, either.
> It results in the bogus error message "version check failed".
> 
> If we really want to fix this, it's better to call
> snd_gus_init_control() from snd_gus_initialize() itself while changing
> snd_gus_init_control() to return an error code.
> 
> However, this error is really not what we should be bothered too
> much.  Even if a creation of control element failed, it's no fatal
> error and nothing really wrong would happen by itself.  And, under
> such a situation, the system memory is already too tight and the OS
> would hang up sooner or later (or OOM killer starts genocide).

Thanks for the review, I'll just drop this change as it's not worth it
for this type of "impossible to hit" issue.

thanks,

greg k-h
