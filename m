Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CF33DCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhCPSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCPSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:50:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5871C06174A;
        Tue, 16 Mar 2021 11:50:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jt13so73980821ejb.0;
        Tue, 16 Mar 2021 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JIDWJVCtqVTctPuvCcddfFP45PGJhsx7ii6usu9k8kI=;
        b=r0s92RsLYdx+MT4mzPcDqJIf7njkm7DryrHjr8C8yN5Nr2/DxAd9tzVM6Jg3fk9oEw
         oNP1xa32uW7a0zKLb+owgbLGCrngGZEwU/Oh+NCtn7hAql3tC9s0tB83soABU5Labjq1
         OrhZMwqvQSyvCUf79h+gGK+gU3G/bFpmqydafAKuhe/JE1kA02SZnK5a0bFK1Biy9AXt
         JDanZJmKzPrrIOxMTO2ncU0mpXFFkdl1tBgtSLnqu2sUQlfd+F5tY2taf2WawqIXysGN
         0A64WFshUOge4vG/+68k1ODWKayXFi6kBuvM0lY13AFuuhLjcqkGVSThBMD8f4eC9fat
         X1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JIDWJVCtqVTctPuvCcddfFP45PGJhsx7ii6usu9k8kI=;
        b=pAwFbzsVH7osOE13y8+8ntLItBdb59rWHKuFs7K/W29nfjHUEu5YrLMyJS5NeW4H8M
         drA8ftT1tpLuSIySYKwa7h2K3lX5q5Cow5daZtqjnD4xO3/RD+45ptAUTzhxmKGngab4
         X+UrZuAWw3sLDgOoZErdgmrhlOw+1xG3N5KfrXzsXHqR34S7Wdls6FgBFfUTIQzI23P2
         pozHGOlKMn9riSYgiSsHXl6oBrEj6oBCkMYALy8tmspg66EpH0B24iemxifuWMmyKk5+
         f746dKhh3n5LcFwRSDvVrFQDUszpLwzGz5MT69Rw6JypyAxs7i8dgDBYfIDQ6249jTsd
         Xycw==
X-Gm-Message-State: AOAM531KeRWyUdVkKj5lsUzD3qtPkMFAEC5tEKb1ZiFgU8KZ5vJfJk2O
        Q0WeKNQjT6Z6PL8yUXP5Pj8=
X-Google-Smtp-Source: ABdhPJxcsp8sHhglDnHjuUw4lQyDPqrEFmSQ6145fz7Iaf0s+0BRl7H7zTp9dHnVJ8Gik7sBF16ulw==
X-Received: by 2002:a17:906:6c93:: with SMTP id s19mr30978725ejr.151.1615920617571;
        Tue, 16 Mar 2021 11:50:17 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id y20sm2023626ejj.43.2021.03.16.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:50:16 -0700 (PDT)
Date:   Tue, 16 Mar 2021 20:50:14 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl
 S500 SoC
Message-ID: <20210316185014.GD1111731@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <58225ced4893018792d581c0476a0f1c70e08907.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316054547.GD1798@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316054547.GD1798@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:15:47AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 08, 2021 at 07:18:29PM +0200, Cristian Ciocaltea wrote:
> > There are a few issues with the setup of the Actions Semi Owl S500 SoC's
> > clock chain involving AHPPREDIV, H and AHB clocks:
> > 
> > * AHBPREDIV clock is defined as a muxer only, although it also acts as
> >   a divider.
> > * H clock is defined as a standard divider, although the raw value zero
> >   is not supported.
> 
> What do you mean by not supported? The datasheet lists "0" as the valid divisor
> value for divide by 1.

Unfortunately CMU_BUSCLK1 is not documented in my S500 Datasheet
(Version: 1.6, 2016-03-07). Do you have a newer (or a more official)
one?

The reference xapp-le code snipped is:

static struct owl_div divider_H_CLK = {
    .type = DIV_T_NATURE,
    .range_from = 1,  /* reserve H_CLK divsor 1 */
    .range_to = 3,
    .reg = &divbit_H_CLK,
};

Not sure why divisor 1 has been reserved..

Thanks,
Cristi

> Rest looks good to me.
> 
> Thanks,
> Mani
> 
[...]
