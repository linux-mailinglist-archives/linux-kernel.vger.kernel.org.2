Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E85381D68
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhEPIdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 04:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 04:33:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A2C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 01:31:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so2106920pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvPi/up8/Q2jB6nmPheLInSV8cVD1xDyiACL39QHuIM=;
        b=mi1CkwraEzqq7EM0mHtQ8oepYHvCEEXP8ciKdlDvLqraGMF4pWHpbIIs3J3iS2jTQY
         lvaXlVy7Dtd13AVtl9UjTXZfdLGzcX1xj4U6U7yl0U/9DWOwau3qNICtxn/xhXAhK5fT
         2CGr44oH7N9qjbcQmLI/tSHzFPaW975IJ553s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvPi/up8/Q2jB6nmPheLInSV8cVD1xDyiACL39QHuIM=;
        b=Q++UZEWjobs080PxrhADcD9Dc90htuxi6x/BJVZnFFjtSSATdBIzq+QYaCTbQSuIJL
         GJRBbnc2qdL3ILJq5nvzId1cKSNYVELsamY6d0OHXeG060nt4hlzd3j0uFo4it0BcJm/
         T5F0ABnbzmdWENRwHNR6pzG2OXtueQ084RpAM0IQytaHfkZ4lx3QdmECNLoVS06jHMXJ
         WDpEdFfhF3f1txByF1m0EMCBdoBo2Ymtu/rP+k4YbB3cw7l+vI6qDKtOu862B0ALnCmx
         uZzO+hfitDsECXGhbLr+VNlwlf1HmPJJ4gINLjYeuBd4UC0lXr1az8azug1oTOpVfQl4
         y9wQ==
X-Gm-Message-State: AOAM532TcWIq13U+EM3MHgIr/wau0hp/wDKqae9UkceeK6ws6rSOBA2t
        Aue7uCfNucQRaMvPmKWaLOWq5w==
X-Google-Smtp-Source: ABdhPJw/afxurF3CFS9XitDbZWTdJj6qhpYvwmCjSbZfQdzJa9IROBfg2+2roWy11BdpOHVzJ6KBRA==
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr20761076pjj.19.1621153906716;
        Sun, 16 May 2021 01:31:46 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id a16sm7328843pfc.37.2021.05.16.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 01:31:46 -0700 (PDT)
Date:   Sun, 16 May 2021 17:31:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YKDYbaprE3K2QpCe@google.com>
References: <YJ4yBmIV6RJCo42U@google.com>
 <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com>
 <YKDYQfDf7GiMfGCN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKDYQfDf7GiMfGCN@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/16 17:30), Sergey Senozhatsky wrote:
> On (21/05/14 20:16), Sergey Senozhatsky wrote:
> > > --- a/sound/pci/intel8x0.c
> > > +++ b/sound/pci/intel8x0.c
> > > @@ -691,6 +691,9 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
> > >  	int status, civ, i, step;
> > >  	int ack = 0;
> > >  
> > > +	if (!ichdev->substream || ichdev->suspended)
> > > +		return;
> > > +
> > >  	spin_lock_irqsave(&chip->reg_lock, flags);
> > >  	status = igetbyte(chip, port + ichdev->roff_sr);
> > >  	civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
> 
> This does the problem for me.

       ^^^ does fix
