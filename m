Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042D63A93AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFPHXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:23:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhFPHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:23:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 362F71FD49;
        Wed, 16 Jun 2021 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623828101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=veRTD9h84H0WsOtXc4c2S/LiXXAxmeLdNq8GB7spHaw=;
        b=jZPLS6/+tU1FD/9Wlk+87Ow5YB+ayISZd2OcL3Q6Z63u8udJKyqxEb/ZNmXZnt92Vdq+36
        eCF5T1heemXXnZ5nDaC0rH10RaNfHAErusjnylLclkkMgQksIpHV2OxVkAhCp96IZoXh3i
        R1hwrANTvZExP38yMYmDKQbeWSsD80w=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE470A3BA1;
        Wed, 16 Jun 2021 07:21:40 +0000 (UTC)
Date:   Wed, 16 Jun 2021 09:21:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
Message-ID: <YMmmhDQSX7gLmnN9@alley>
References: <20210614235635.887365-1-punitagrawal@gmail.com>
 <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
 <YMmggRL/htxFK2VY@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmggRL/htxFK2VY@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-06-16 08:56:01, Petr Mladek wrote:
> On Tue 2021-06-15 08:50:45, Rasmus Villemoes wrote:
> > On 15/06/2021 01.56, Punit Agrawal wrote:
> > > Commit 28e1745b9fa2 ("printk: rename vprintk_func to vprintk") while
> > > improving readability by removing vprintk indirection, inadvertently
> > > placed the EXPORT_SYMBOL() for the newly renamed function at the end
> > > of the file.
> > > 
> > > For reader sanity, and as is convention move the EXPORT_SYMBOL()
> > > declaration just after the end of the function.
> > > 
> > > Fixes: 28e1745b9fa2 ("printk: rename vprintk_func to vprintk")
> > > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > > --
> > > Hi,
> > > 
> > > The out-of-place EXPORT_SYMBOL() caused an unexpected conflict while
> > > attempting to rebase the RT patches onto newer kernels.

Ah, this is the explanation. I am sorry for the noise.

> > > Generally I avoid sending trivial changes on their own but this one is
> > > a little hard to overlook. Also it felt like an obvious oversight in
> > > the original patch.
> > 
> > Petr, as this is causing trouble for the -rt patchset, please consider
> > if this could make it to Linus before v5.13 release.

Punit, John, would you mind when I queue this change for-5.14?
It seems that, you, RT-guys already handled this, so it will not help
much if I sent it now. It does not look appropriate to send just a single
cosmetic fix few days before rc7.

Best Regards,
Petr
