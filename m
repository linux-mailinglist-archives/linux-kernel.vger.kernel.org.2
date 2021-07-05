Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B57C3BB5FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGEDzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 23:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGEDzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:55:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298EDC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 20:53:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i13so9498994plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wh6fSPpm3oNA6Rdpj7F6yBoenikgqbJzM4BLnsqOaTo=;
        b=TmBQmuvyENG/N+R8sqzWlEbg8WWTU/eMX8c+V7lF7V016KDi9at6XHA+nda9HcCFpJ
         netnSjRpWj+BnoN577G8Glmg3g4nGjcvyCXBj4y+VFz+/IZAbKIMNCLaYko6qzwLhX9s
         GAABjuChvFLYzkJ0clPsMh95QiHc5wqtjkFZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wh6fSPpm3oNA6Rdpj7F6yBoenikgqbJzM4BLnsqOaTo=;
        b=rl4cYH1TWrfGRsDAa0kukF9oUBr/Kzbh+ZGsuS85tbm+ImRzPBCKc8TE958lq+abQ+
         SwrBTsMrr8K1t86AAGq0/tzjKduHzo9xsVUkqa2Xv5/wOQPC92V1ychTe+5cAL/qbv5+
         Ewiw1hArspTz5MYZ7Y7DT1XuRGOJIPzVZxcH/G9MhBPOst6lO5yGWWpYLRVMgDsChMEx
         OgRsAbJ2dUK0fYKhEMZuNQRJdIQntoA30C4YGsDFsqnbiz+FZcscwLXvGI/t661cfcuW
         qVRQaXyzEQztmcV5ZPZI4OvhH2Ug1ocajwGzySggiI8JJ14HyZo9yNGZHwdRf9cna53L
         NtkA==
X-Gm-Message-State: AOAM533Vmsrx587q4VSTXDEb6nuzA2eL5AGneg0rv7gSyD7LBDMZ20jB
        5+5XFYVARmbHsevuI5qKiOxlAA==
X-Google-Smtp-Source: ABdhPJxMYZMKLUd1BwMaWH0crcvPJ1PeGBWJ65grg52ZlIbXqnL+rqeopnA2EbYh7l7HLmPcJxbe3Q==
X-Received: by 2002:a17:902:e5c1:b029:129:3c05:cea3 with SMTP id u1-20020a170902e5c1b02901293c05cea3mr10712847plf.61.1625457186692;
        Sun, 04 Jul 2021 20:53:06 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:7a3a:c0d1:8813:add3])
        by smtp.gmail.com with ESMTPSA id j3sm11137821pfe.98.2021.07.04.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 20:53:06 -0700 (PDT)
Date:   Mon, 5 Jul 2021 12:53:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] printk/console: Check consistent sequence number when
 handling race in console_unlock()
Message-ID: <YOKCHciF3PrD1Q1c@google.com>
References: <20210629143341.19284-1-pmladek@suse.com>
 <YNs/Vbi2Yt0s10Ye@google.com>
 <YNwkD3bTikepZr+k@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwkD3bTikepZr+k@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/30 09:58), Petr Mladek wrote:
[..]
> > `retry` can be falsely set, console_trylock() does not spin on owner,
> > so the context that just released the lock can grab it again only if
> > it's unlocked. For the context that just has released the console_sem
> > and then acquired it again, because of the race, - console_seq will be
> > valid after it acquires the lock, then it'll jump to `retry` and
> > re-validated the console_seq - prb_read_valid(). If it's valid, it'll
> > print the message; and should another CPU printk that CPU will spin on
> > owner and then the current console_sem owner will yield to it via
> > console_lock_spinning branch.
> 
> I am not sure that I follow it correctly. IMHO, there are two possible
> races. I believe that you are talking about the 2nd scenario:

I guess I was thinking about two scenarios simultaneously, but you
certainly did a much better job describing them.

Thanks a lot for spending time on this!

> 1st scenario: console_unlock() retries but the message has been proceed
>    in the meantime:
[..]
> Result: CPU0 retired just to realize that the message
> 	has already been procceed.

Ack.

> 2nd scenario: printk() caller spins when other process is already
> 	processing it's message
[..]
> Result: CPU1 was spinning just to realize that the message has already
> 	been proceed.

Ack.

> It is not ideal. But the result is always correct.
>
> The races have been there already before. Only the race window in 1st
> scenario was a bit smaller.

Yeah, this was my assertion as well, but I wanted to double check.
