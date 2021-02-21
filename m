Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C59320BE4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBUQ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 11:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhBUQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 11:58:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DCAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 08:57:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so8580720pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B9cs96qNn/BeukNEOSHYwqQI5Bj2awUMTvneDxh78vM=;
        b=RIJBhiNzg9f0xT4DSNmlxIQgvreGmdXvKswmbFltyAnWrrdd6cGcdaJEqtP8TJk78Q
         o76k9/bbe8lldi2Wg3Zz+sLbp4AbAxCTInkhydh81RjkCVvKLA11CDWMAacSeCX6PcLQ
         mw1lC+p7tuZet02I15TF7yuEmv+AQKrFyaeqPltP6XKVO7w/GRssM9cC5GWdzTj0cFf4
         922aGSnTYtzH2NsQRYGHCoC/IzKbaX11LN2Uq4LD0Gz3oJbv+vQUtfOATlqm7IAUsfHC
         yniZ/Yynt8Vl+/0ZAN+PVeVarHCrtpZg1VIidLtCN7dlAC5xu4YMZaeqP5PFFfzONiHU
         sSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9cs96qNn/BeukNEOSHYwqQI5Bj2awUMTvneDxh78vM=;
        b=gfproRgBELN+cI/KkNU+15kkOJA8/oMSQpau4f/pvUb/Ayip7xGN+Pm0KhI3HemLc5
         Y32A2mLfGOzPtSVdM/K9Ns7xwJkJBiuakO215qmMyEzKIXD46rWb6F6pL1gtft25zmky
         /pmCWjV5PYHwIRbe8k637XJlAlQDk66w+0tJdNQLB/QwhWn9Cox94miWPJ3SZVdVCqXE
         NG6RsaxvjHgJ5clk+gX4AKpWtu5X/oNg5Zzvid53OkL6enVHOVIAx3OLaKOa4e7Hv1w+
         sgTI0XA8lUrsTAlKrC/MHXRxnHBPTYhR3ZwuGlt1IJDmuHiYC5CmquIbvSDbHVZmSit3
         hWyg==
X-Gm-Message-State: AOAM533iT1LTAZ0pH3oPRe3JwYk38luzhfrKlHpXUFPZfuAFLk98u1ti
        K90oGLQ0BMDw/cAvFDvhsjs=
X-Google-Smtp-Source: ABdhPJyiDqocVAb33lqs+xYHkZf2tI/kwEbn303at+l8JlJYnJpj9iVx20WqlM6nqmSDt59dLpJ6Xg==
X-Received: by 2002:aa7:9d9b:0:b029:1ed:6c08:b93c with SMTP id f27-20020aa79d9b0000b02901ed6c08b93cmr6544126pfq.37.1613926648929;
        Sun, 21 Feb 2021 08:57:28 -0800 (PST)
Received: from atulu-nitro ([2401:4900:3155:5620:9c4f:6a05:4186:f552])
        by smtp.gmail.com with ESMTPSA id v16sm15310543pfu.76.2021.02.21.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 08:57:28 -0800 (PST)
Date:   Sun, 21 Feb 2021 22:27:21 +0530
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH 2/2] staging: rtl8192e: Change state information from u16
 to u8
Message-ID: <20210221165721.GA10040@atulu-nitro>
References: <20210220182154.9457-1-atulgopinathan@gmail.com>
 <20210220182154.9457-2-atulgopinathan@gmail.com>
 <YDJbSgqTpBpIsbVB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDJbSgqTpBpIsbVB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 02:08:26PM +0100, Greg KH wrote:
> On Sat, Feb 20, 2021 at 11:51:55PM +0530, Atul Gopinathan wrote:
> > The "CcxRmState" field in struct "rtllib_network" is defined
> > as a u16 array of size 2 (so, 4 bytes in total).
> > 
> > But the operations performed on this array throughout the code
> > base (in rtl8192e/) are all in byte size 2 indicating that this
> > array's type was defined wrongly.
> > 
> > There are two situation were u16 type of this field could yield
> > incorrect behaviour:
> > 
> > 1. In rtllib_rx.c:1970:
> > memcpy(network->CcxRmState, &info_element->data[4], 2);
> > 
> > Here last 2 bytes (index 4 and 5) from the info_element->data[]
> > array are meant to be copied into CcxRmState[].
> > Note that "data" array here is an array of type u8.
> > 
> > 2. In function "update_network()" in staging/rtl8192e/rtllib_rx.c:
> > memcpy(dst->CcxRmState, src->CcxRmState, 2);
> > 
> > Here again, only 2 bytes are copied from the source state to
> > destination state.
> > 
> > There are no instances of "CcxRmState" requiring u16 data type.
> > Here is the output of "grep -IRn 'CcxRmState'" on the rtl8192e/
> > directory for reviewing:
> > 
> > rtllib_rx.c:1970:			memcpy(network->CcxRmState, &info_element->data[4], 2);
> > rtllib_rx.c:1971:			if (network->CcxRmState[0] != 0)
> > rtllib_rx.c:1975:			network->MBssidMask = network->CcxRmState[1] & 0x07;
> > rtllib_rx.c:2520:	memcpy(dst->CcxRmState, src->CcxRmState, 2);
> > rtllib.h:1108:	u8	CcxRmState[2];
> 
> You just changed the logic in line 1975 in that file, right?  Are you
> _SURE_ that is ok?  Do you have a device to test this on?

I'm sorry, I didn't quite get you. By line 1975 in rtllib_rx.c, did you mean
the following line?:

network->MBssidMask = network->CcxRmState[1] & 0x07;

network->CcxRmState is being fed with 2 bytes of u8 data, in line 1970 (as
seen above). I believe my patch doesn't change the logic of an "&" operation
being performed on it with 0x07, right?

(I'm sorry if I'm missing something quite obvious, could kindly elaborate
the change in logic that you are referring to?)

Many thanks for the reviewing it during this time!
Atul
