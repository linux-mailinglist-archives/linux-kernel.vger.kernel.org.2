Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D623A3DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFKH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhFKH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:58:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96841C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:56:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r16so8527400ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vTcxauL5jl+18iQ2FlJa+h0e7Ha9Fv75p607nBeKKsw=;
        b=E3knXo+RDhL3HQVz3DuFOl8UGg3FVSXFrSjorrXK+JN1Uyi02NncUEcRjMU9QjcdVE
         BJhzK/au1SG6nK/O2bWr7PFDSpU9ZTKTB0XjhjmLucIezX56CpdBlh2VZWXXcCaGzLVL
         JfgFQsaBNhQ8N/EcXVNtRR9bJU6fORt0GO2KRFUEP7kNws4gzy77oh7ITSc+VA3HNT91
         YjJztKF/N5/h3u8Omok1fgROr0DYmFI+1SdXDQlwPnYm/pzO/ePwH9ZpU2agX6+M/QCQ
         wSjxBLMcITyt/Qz/+4ud2MTZrHVRrtO71109yVQLY1WghI4hhltwYZ86wS26qK/n0mPS
         qR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vTcxauL5jl+18iQ2FlJa+h0e7Ha9Fv75p607nBeKKsw=;
        b=ogwDsHjoXb28npps56iDD82SLOtHR9KwGNgeA5ikQFJC9QUl4sc8ns6K321HghL9fg
         8g6wZuVlG1XyWpd7p6u2R3+FypQs+LPutOGbjoEjseM213hmgBit52ZD4WMJK/yAW2KC
         4CIgmiWAjVSgVNxEeQaFbSJJc+r2nr8nl7xE2fk7fxyPqm4lmx7UIPKPjcxtGTPna4G5
         m5a60y1wQHYoFp6juYiyq1GCTy/2euFIatZ/horIzRWG7aVOU8kn1Wu1D3EvY6qnHHsd
         cH51VvEEuJ9EiwcRevB5djwD+pazsO/2sYn2o1G+oZZhPg3Sc6FVavJbRTGbzbSSzQX1
         m5ag==
X-Gm-Message-State: AOAM530ts3j8Pyh5LUY3HYGWoumPa+EN9BPyahSlInpPxnV3tNM+yNFB
        SKlG9lpH/u1sOebpBQ24BviQYXh3r4y5Cw==
X-Google-Smtp-Source: ABdhPJyBisS/kC9406e3SVe1NmqKtN1v3aVbLucdGmpyN1Zq4bSMbwJE/cKr8pBZ5IDdYPivM+wGXQ==
X-Received: by 2002:a2e:9d09:: with SMTP id t9mr2034766lji.213.1623398184938;
        Fri, 11 Jun 2021 00:56:24 -0700 (PDT)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id w18sm517239lft.166.2021.06.11.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:56:23 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:56:23 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Phong Hoang <phong.hoang.wz@renesas.com>
Subject: Re: [PATCH] clocksource: sh_cmt: Fix wrong setting if don't request
 IRQ for clock source channel
Message-ID: <YMMXJz4IwFJU4vEF@oden.dyn.berto.se>
References: <20210422123443.73334-1-niklas.soderlund+renesas@ragnatech.se>
 <7cf6444a-1dc4-a2bb-8fef-696e0b2b6f23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cf6444a-1dc4-a2bb-8fef-696e0b2b6f23@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2021-06-10 14:45:05 +0200, Daniel Lezcano wrote:
> On 22/04/2021 14:34, Niklas Söderlund wrote:
> > From: Phong Hoang <phong.hoang.wz@renesas.com>
> > 
> > If CMT instance has at least two channels, one channel will be used
> > as a clock source and another one used as a clock event device.
> > In that case, IRQ is not requested for clock source channel so
> > sh_cmt_clock_event_program_verify() might work incorrectly.
> > Besides, when a channel is only used for clock source, don't need to
> > re-set the next match_value since it should be maximum timeout as
> > it still is.
> > 
> > On the other hand, due to no IRQ, total_cycles is not counted up
> > when reaches compare match time (timer counter resets to zero),
> > so sh_cmt_clocksource_read() returns unexpected value.
> > Therefore, use 64-bit clocksoure's mask for 32-bit or 16-bit variants
> > will also lead to wrong delta calculation. Hence, this mask should
> > correspond to timer counter width, and above function just returns
> > the raw value of timer counter register.
> 
> I'm not getting the 'ch->cmt->num_channels == 1' change, can you explain?

My understanding is that if more then one channel is available the 
channel used as clocksource is used without an interrupt. This was not 
addressed in the patches listed as fixes. This patch fixes this multi 
channel use-case while still retaining the old behavior for for the case 
where only one channel is available (ch->cmt->num_channels == 
1).

> 
> > Fixes: bfa76bb12f23 ("clocksource: sh_cmt: Request IRQ for clock event device only")
> > Fixes: 37e7742c55ba ("clocksource/drivers/sh_cmt: Fix clocksource width for 32-bit machines")
> > Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  drivers/clocksource/sh_cmt.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> > index c98f8851fd680454..cadd09ad1a0946b9 100644
> > --- a/drivers/clocksource/sh_cmt.c
> > +++ b/drivers/clocksource/sh_cmt.c
> > @@ -578,7 +578,8 @@ static int sh_cmt_start(struct sh_cmt_channel *ch, unsigned long flag)
> >  	ch->flags |= flag;
> >  
> >  	/* setup timeout if no clockevent */
> > -	if ((flag == FLAG_CLOCKSOURCE) && (!(ch->flags & FLAG_CLOCKEVENT)))
> > +	if (ch->cmt->num_channels == 1 &&
> > +	    flag == FLAG_CLOCKSOURCE && (!(ch->flags & FLAG_CLOCKEVENT)))
> >  		__sh_cmt_set_next(ch, ch->max_match_value);
> >   out:
> >  	raw_spin_unlock_irqrestore(&ch->lock, flags);
> > @@ -620,20 +621,25 @@ static struct sh_cmt_channel *cs_to_sh_cmt(struct clocksource *cs)
> >  static u64 sh_cmt_clocksource_read(struct clocksource *cs)
> >  {
> >  	struct sh_cmt_channel *ch = cs_to_sh_cmt(cs);
> > -	unsigned long flags;
> >  	u32 has_wrapped;
> > -	u64 value;
> > -	u32 raw;
> >  
> > -	raw_spin_lock_irqsave(&ch->lock, flags);
> > -	value = ch->total_cycles;
> > -	raw = sh_cmt_get_counter(ch, &has_wrapped);
> > +	if (ch->cmt->num_channels == 1) {
> 
> 
> 
> > +		unsigned long flags;
> > +		u64 value;
> > +		u32 raw;
> >  
> > -	if (unlikely(has_wrapped))
> > -		raw += ch->match_value + 1;
> > -	raw_spin_unlock_irqrestore(&ch->lock, flags);
> > +		raw_spin_lock_irqsave(&ch->lock, flags);
> > +		value = ch->total_cycles;
> > +		raw = sh_cmt_get_counter(ch, &has_wrapped);
> >  
> > -	return value + raw;
> > +		if (unlikely(has_wrapped))
> > +			raw += ch->match_value + 1;
> > +		raw_spin_unlock_irqrestore(&ch->lock, flags);
> > +
> > +		return value + raw;
> > +	}
> > +
> > +	return sh_cmt_get_counter(ch, &has_wrapped);
> >  }
> >  
> >  static int sh_cmt_clocksource_enable(struct clocksource *cs)
> > @@ -696,7 +702,7 @@ static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
> >  	cs->disable = sh_cmt_clocksource_disable;
> >  	cs->suspend = sh_cmt_clocksource_suspend;
> >  	cs->resume = sh_cmt_clocksource_resume;
> > -	cs->mask = CLOCKSOURCE_MASK(sizeof(u64) * 8);
> > +	cs->mask = CLOCKSOURCE_MASK(ch->cmt->info->width);
> >  	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
> >  
> >  	dev_info(&ch->cmt->pdev->dev, "ch%u: used as clock source\n",
> > 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

-- 
Regards,
Niklas Söderlund
