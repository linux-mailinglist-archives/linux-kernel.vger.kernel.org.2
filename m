Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD3412697
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbhITTFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345367AbhITTDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:03:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0BDA60F13;
        Mon, 20 Sep 2021 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632164495;
        bh=NO2F9HR7O7kJFrikzeMb7rjB1b4yniu4hHZLpR4Tuoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RL3+v9IxzAGgTgx7Ae2++45li0XAbiwxwgt3CS0Wa3CHotfCjifCmK4MHjHz+SCZA
         5iFIYHb+KW73/X9RL1jHuHWmTNjpbUzTHVC/1NC4SzOEOMVzTtqB95CH2brQgKz/DL
         lZ5UUdBN303pN1qYljMb2sD/8eFqV00XC1sTNt3w=
Date:   Mon, 20 Sep 2021 21:01:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove mp, a.k.a. manufacturing
 process, code
Message-ID: <YUjajceLMTbrkx9Q@kroah.com>
References: <20210920185437.15652-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920185437.15652-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:54:37PM -0500, Larry Finger wrote:
> The standard driver contains code used by the factory to evaluate chips
> that have just been manufactured. Such code is indicated by "mp" in
> the variable names, the routine names, and in file names. All of these
> can be deleted.
> 
> In addition to removing nearly 7,000 lines of code, the size of the driver
> is reduced by 63 KB:
>           text    data     bss     dec     hex
> Before  573959   48582   14660  637201   9b911
> After   513530   45894   14660  574084   8c284
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> Greg: This patch is based on staging-testing. If you want
>       me to break it up, I will do so.

No need at all, thanks for this work!

now queued up.

greg k-h
