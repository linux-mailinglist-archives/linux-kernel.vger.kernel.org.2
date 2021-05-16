Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D802A381D67
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhEPIcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 04:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 04:32:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E0CC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 01:31:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l70so2602942pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kpe9vtoQX82iVpEE/u5ousHl/Rp3lITdfSymEOwo3JM=;
        b=iXKRG4CT+6rGBrHjnLZ8o7QPoZkvq3uqDfOfP3kWL13zRY9wSJ7uW0AIcAydYLN8sM
         gvrxHC9RuOy1OU23LGAQy+CTfugV/dIxehHZOzE5RaRf+NF44/9ja0sMkrIsQV9Ctuk3
         9c/EARrz3ayNbGDksBWs7UXpw4hXPQ6WqkzKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpe9vtoQX82iVpEE/u5ousHl/Rp3lITdfSymEOwo3JM=;
        b=dadXoJFIyTYe/jTRk5KWpkRZcNBWzJSOgWVwQKYN/d7L1iXzGjRkHrtJPq152SlSgi
         m7HK9J3nMuPJIkG7c0SvCICPYwBGdhvAlurKzXjpV5Nk2ulMSfWKvn0KdZ/Uc1jHsZUo
         OWs4/L2e/EzlZQ/wYoiTX+l5a66l+TmnlxbMXVKTwhpaYlddkY32/9/x2WTAqaDpeIk6
         Wo+9g4oZdPfb6ebu18eqoOfqNgOoTk4zWRUr8UnmggwmqdO0EbvLusDCxAdjQT02AoPM
         OlABJd2/fVX+DjejCLNspDZaZJhh83LwXNWcm/27sFhNbmZkrXP752Nc6M4NBDdgYR0j
         YIvQ==
X-Gm-Message-State: AOAM531tgsMLBMmgMuEAdHrcPA0cp167xoDnLfa1q2KcimQGlMA1vp6i
        jz0pf27slSYcU0lRxymmGGEPQYH0MT5ZjA==
X-Google-Smtp-Source: ABdhPJwLDDhgviSBNY7z/RfSjXkpjVVCR629Bd8qWCqCppmwG9HN35CkI6iLOCJ66JIlYATFLFGuNg==
X-Received: by 2002:a63:5456:: with SMTP id e22mr48817378pgm.15.1621153862982;
        Sun, 16 May 2021 01:31:02 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id x27sm7717276pfo.216.2021.05.16.01.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 01:31:02 -0700 (PDT)
Date:   Sun, 16 May 2021 17:30:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YKDYQfDf7GiMfGCN@google.com>
References: <YJ4yBmIV6RJCo42U@google.com>
 <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ5cHdv6MVmAKD3b@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/14 20:16), Sergey Senozhatsky wrote:
> > --- a/sound/pci/intel8x0.c
> > +++ b/sound/pci/intel8x0.c
> > @@ -691,6 +691,9 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
> >  	int status, civ, i, step;
> >  	int ack = 0;
> >  
> > +	if (!ichdev->substream || ichdev->suspended)
> > +		return;
> > +
> >  	spin_lock_irqsave(&chip->reg_lock, flags);
> >  	status = igetbyte(chip, port + ichdev->roff_sr);
> >  	civ = igetbyte(chip, port + ICH_REG_OFF_CIV);

This does the problem for me.
