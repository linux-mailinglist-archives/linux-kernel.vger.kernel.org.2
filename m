Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619B73A3499
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFJUMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:12:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D1C061574;
        Thu, 10 Jun 2021 13:10:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso7318473wmh.4;
        Thu, 10 Jun 2021 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGhwbRzDJ+vGi7Ot+KWwVBsMmeXKl4MgFdcn1VLKhu4=;
        b=KK7Yi0BW7919kOgCjST7LGeMI5Ht7fQ6G+iTB444vZ3h9kTXMFwqhRJ9AyK0RKj5kO
         UIbwE9BedDIW0dGTtJUdQ0rQc1yyTgTNR/gyhrKdBCv85eitvYwj+Io4CUwTvp7IkSYi
         avcOSA/WAkWPtrwsXSXODeG0AquBbDSVfyVd+ImIcOQNBpfD2v6mD8T85Or5AYFL7qIt
         uQ++qYIIfxBcDV8iBfOr5MaDGL7bY5WqA/H1s4aoTrF4y2OzPuyU6aW7kKPiHmEhb+zn
         DhaXBAzFnjzM9Woj2r/y/hoXBF1XuFZ8QW20WzV1p9ZwGYLZ5uo3XlDdgJnAvQlmVXl2
         2WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lGhwbRzDJ+vGi7Ot+KWwVBsMmeXKl4MgFdcn1VLKhu4=;
        b=Op0L1cFPFsJsaxrYYvwOOH0wEoazBqq/jZ7e7Tk1Ajt40AGYH8lrMDjnnWTm9753AC
         YkpYJ841nHcUbNMVklOr5ff/FaQ7i8MTRncpX2+wd/LkUqw5bMNiYtvXxIRwEeGuSIOV
         xIX+wIfd9eatNZlAa7fdZ4wiKjoEGnH5YIAgRejH9KNBdrCpNRtED908viU7pIxBjEiF
         sM40RdDgl6x26NoyTzIdXFWWB8j2Yna58ADrmrAkuYvQUcFq5uv4uyJ+dsTcH4SPlobr
         F6xu5Nc+IzxTEiZ9+T7jofjoD4DM1vofAjHr+JhGVZ6RU8w5OT/Bt/PfDUDzX0W27XCT
         EtFA==
X-Gm-Message-State: AOAM532Kuy/FhrAdYOiy6H94Atlj1Qchg86/c4hYp9SkGdbAAwBaFrcX
        YXGsa8BnI8pysKfExxgfC0Y0IzHo/NE=
X-Google-Smtp-Source: ABdhPJwSbbI0f8rYfUdZeTHhH6+zg2pb5A+ySR5vIj18KhFz0KovyJaQYBG3DSUU4vvUaWKVC/kOLQ==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr592618wmb.60.1623355827750;
        Thu, 10 Jun 2021 13:10:27 -0700 (PDT)
Received: from BV030612LT ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id l13sm4883946wrz.34.2021.06.10.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:10:27 -0700 (PDT)
Date:   Thu, 10 Jun 2021 23:10:25 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on
 Owl S500 SoC
Message-ID: <20210610201025.GA1497285@BV030612LT>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
 <107776b4a4e752ef83b143114d2baf52bf8c4107.1622119892.git.cristian.ciocaltea@gmail.com>
 <20210610143413.GC315240@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610143413.GC315240@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 08:04:13PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 27, 2021 at 04:16:42PM +0300, Cristian Ciocaltea wrote:
> > There are a few issues with the setup of the Actions Semi Owl S500 SoC's
> > clock chain involving AHPPREDIV, H and AHB clocks:
> > 
> > * AHBPREDIV clock is defined as a muxer only, although it also acts as
> >   a divider.
> > * H clock is using a wrong divider register offset
> > * AHB is defined as a multi-rate factor clock, but it is actually just
> >   a fixed pass clock.
> > 
> > Let's provide the following fixes:
> > 
> > * Change AHBPREDIV clock to an ungated OWL_COMP_DIV definition.
> > * Use the correct register shift value in the OWL_DIVIDER definition
> >   for H clock
> > * Drop the unneeded 'ahb_factor_table[]' and change AHB clock to an
> >   ungated OWL_COMP_FIXED_FACTOR definition.

[...]

> >  /* composite clocks */
> > +static OWL_COMP_DIV(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p,
> > +			OWL_MUX_HW(CMU_BUSCLK1, 8, 3),
> > +			{ 0 },
> > +			OWL_DIVIDER_HW(CMU_BUSCLK1, 12, 2, 0, NULL),
> > +			0);
> > +
> > +static OWL_COMP_FIXED_FACTOR(ahb_clk, "ahb_clk", "h_clk",
> > +			{ 0 },
> > +			1, 1, CLK_SET_RATE_PARENT);
> 
> I think you swapped the flags between "ahbprediv_clk" and "ahb_clk"...

Thanks for noticing this, I fixed it in v3:
https://lore.kernel.org/lkml/cover.1623354574.git.cristian.ciocaltea@gmail.com/

> > +
> >  static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
> >  			OWL_MUX_HW(CMU_VCECLK, 4, 2),
> >  			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
> > -- 
> > 2.31.1
> > 
