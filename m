Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB638084B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhENLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhENLSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:18:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:16:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11so2475189pjm.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SuwelzwTekMBepy8x0XJ/IwbbsZYlWT91PPUwII5M50=;
        b=ifstVL82ZSKzlZqpNG38Wt+0Y07VjgZxJUsjfbnMeiyr4jDsjnwpo7XLrIJWhyJO4/
         8VvqwjvvdhkLc4cxMtwT+EHWnIDbKrpoy+5xg/tceb8hXqAUnjnZsnyw9Umde6qAh7zO
         TuS6pRljrbYOevJPYBonaK3M++/PotktqORN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuwelzwTekMBepy8x0XJ/IwbbsZYlWT91PPUwII5M50=;
        b=PTLz/nYBjjfeTf9MDogGMJ1RQvLHhGQwX6Y8aMYu87DFdrjeTWnc2MosfXioS4A7k4
         X3BwuxJyp2f6C1qbiw/0JDU2mrFVmQ5FvojrOR9fHaIitLbL4BEoeHC2uTg/9zrfqsFq
         AldHwm5GMY7c5XGhwcSxc7CFPld94mPNFOj2fopZrNNI9ytBSh8oB4PIPsJmouN0hjli
         0ncIkT1T+a5qZhQmReBJF2cJroGewEmsDZwmnlxhB/OtMjBtulcgTxMrh16v/cCbKJio
         mx/ypdhBU+q7NrSQLikuztX30fd5jvkObIqhsHcOccBl5HhmEU2r2F+hLef8v8F29/q7
         HSzg==
X-Gm-Message-State: AOAM531011HJM6wzXtyDhk5VlVO7mqYPOeLKCorbkVJ6wMpDvg5AXbZU
        GTOoOQcdZbAnN5mgGrTTiylnzg==
X-Google-Smtp-Source: ABdhPJx3oeYxBL00rDSPeMgixcF09Fv2kyqLOigDvsB87zU+JFFy1EdS3oj2DBGvF6XG5fNrXsj72Q==
X-Received: by 2002:a17:902:6a84:b029:ef:1342:20e7 with SMTP id n4-20020a1709026a84b02900ef134220e7mr36803896plk.36.1620991011137;
        Fri, 14 May 2021 04:16:51 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b4a8:8601:829d:26d5])
        by smtp.gmail.com with ESMTPSA id q2sm4014154pfk.71.2021.05.14.04.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:16:50 -0700 (PDT)
Date:   Fri, 14 May 2021 20:16:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YJ5cHdv6MVmAKD3b@google.com>
References: <YJ4yBmIV6RJCo42U@google.com>
 <s5hk0o18tio.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk0o18tio.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/14 13:05), Takashi Iwai wrote:
> >  divide error: 0000 [#1] PREEMPT SMP NOPTI
> >  RIP: 0010:snd_intel8x0_interrupt+0x121/0x279
> >  Code: 42 8b 44 35 34 41 0f af c5 42 03 44 35 38 42 89 44 35 38 48 8b 0c 24 80 b9 60 03 00 00 00 78 0f 49 8d 0c 2e 48 83 c1 38 31 d2 <f7> 71 f4 89 11 42 8b 7c 35 48 44 01 ef 83 e7 1f 42 89 7c 35 48 48
> >  RSP: 0000:ffff9a0a80108eb0 EFLAGS: 00010046
> >  RAX: 0000000000000000 RBX: 0000000000000019 RCX: ffff90d8c5efc198
> >  RDX: 0000000000000000 RSI: ffff9a0a80549016 RDI: ffff9a0a80549024
> >  RBP: ffff90d8c5efc060 R08: 000000000000197a R09: 00000f604ed00191
> >  R10: 00000000000001e0 R11: ffffffff9468e1d8 R12: 0000000000000020
> >  R13: 0000000000000040 R14: 0000000000000100 R15: 0000000000000002
> >  FS:  00007a75c397aff8(0000) GS:ffff90d912d80000(0000) knlGS:0000000000000000                                                               
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007a77945d1000 CR3: 000000015bf46002 CR4: 0000000000360ea0
> >  Call Trace:
> >   <IRQ>
> >   __handle_irq_event_percpu+0xa0/0x1c0
> >   handle_irq_event_percpu+0x2d/0x70
> >   handle_irq_event+0x2c/0x48
> >   handle_fasteoi_irq+0xa1/0x161
> >   do_IRQ+0x51/0xd6
> >   common_interrupt+0xf/0xf
> >   </IRQ>
> >  RIP: 0033:0x7a7856462c59
> >  Code: 89 ca 48 2b 57 20 48 83 c2 10 31 c0 48 3b 57 28 48 0f 46 c1 c3 cc cc cc cc cc cc cc cc cc cc cc cc 64 48 8b 0c 25 00 00 00 00 <b8> f8 02 00 00 48 03 41 08 c3 cc cc cc cc cc cc cc cc cc cc cc cc
> >  RSP: 002b:00007a75c39794e8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
> >  RAX: 02fa413b24209c6c RBX: 0000017f19e1cf9e RCX: 00007a75c397aff8
> >  RDX: 00007a7855792472 RSI: 00007a7855790aa0 RDI: 0000000000000005
> >  RBP: 0000000000000005 R08: 0000000000000012 R09: 000000000000000d
> >  R10: 00000000009f86d2 R11: 000000000000197a R12: 0000017f19e40e7d
> >  R13: 000005ee937ae557 R14: 00007a7855790aa0 R15: 00007a7855792472
> >  Modules linked in:
> >  ---[ end trace 2ef6d63d0e3d757c ]---
> >  RIP: 0010:snd_intel8x0_interrupt+0x121/0x279
> >  Code: 42 8b 44 35 34 41 0f af c5 42 03 44 35 38 42 89 44 35 38 48 8b 0c 24 80 b9 60 03 00 00 00 78 0f 49 8d 0c 2e 48 83 c1 38 31 d2 <f7> 71 f4 89 11 42 8b 7c 35 48 44 01 ef 83 e7 1f 42 89 7c 35 48 48
> >  RSP: 0000:ffff9a0a80108eb0 EFLAGS: 00010046
> >  RAX: 0000000000000000 RBX: 0000000000000019 RCX: ffff90d8c5efc198
> >  RDX: 0000000000000000 RSI: ffff9a0a80549016 RDI: ffff9a0a80549024
> >  RBP: ffff90d8c5efc060 R08: 000000000000197a R09: 00000f604ed00191
> >  R10: 00000000000001e0 R11: ffffffff9468e1d8 R12: 0000000000000020
> >  R13: 0000000000000040 R14: 0000000000000100 R15: 0000000000000002
> >  FS:  00007a75c397aff8(0000) GS:ffff90d912d80000(0000) knlGS:0000000000000000                                                               
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007a77945d1000 CR3: 000000015bf46002 CR4: 0000000000360ea0
> > 
> > This corresponds to
> > 
> > 	ichdev->position %= ichdev->size;
> > 
> > in snd_intel8x0_update().
> > 
> > A print out of that ichdev looks as follows
> > 
> > snd_intel8x0 0000:00:18.0: lvi_frag = 0, frags = 0, size = 0, period_size = 0x0, period_size1 = 0x0
> 
> This sounds like some spurious IRQ that casually hits during the
> resume.  It's strange that, even if it's a spurious IRQ, it contains
> the proper update bits for the stream.

Yes, I found this to be strange as well. That's why I started dumping
ichdev fields and so on.

> Is that on a real hardware or
> on a VM?

VM.

> In anyway, the patch like below might cover enough.

I'll give it a try.

> --- a/sound/pci/intel8x0.c
> +++ b/sound/pci/intel8x0.c
> @@ -691,6 +691,9 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
>  	int status, civ, i, step;
>  	int ack = 0;
>  
> +	if (!ichdev->substream || ichdev->suspended)
> +		return;
> +
>  	spin_lock_irqsave(&chip->reg_lock, flags);
>  	status = igetbyte(chip, port + ichdev->roff_sr);
>  	civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
