Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8785456406
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhKRU1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbhKRU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:27:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:24:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so7374044pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CEafYW8MRPioqBfCFfvnxWXpVAk39JOdxhJVb0fOQkY=;
        b=Sw62I7t1cdcpXan5SayiXVjr/5iY+VKSj2lYRGp/j6eQqGrOxw6a+EU5F+IKg0kz8+
         JrUUjTzQ2Isahb3AaCCt15ecvJa+4HldPbAg6wOyLD2uGupXwoJu18jChqklHGYc6jNk
         v35yp61ICOlp9N5XKOWdgEzQcSepkDOcblwFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEafYW8MRPioqBfCFfvnxWXpVAk39JOdxhJVb0fOQkY=;
        b=SU/mkFnkh6lMfQ/h0+otRuD/2d2ERFvEdE1yX75n9+309vxFwp7gDMffx4eHSk/CIU
         PnSItgolPEpcmd+5orjPSm3DYwr2Zp6c1f6esUWJdWKc0tZeecaqlSpre1KMmqau6liA
         Mw13R7cKhvpgXQ83xDYPsFOMjtmYlocgS3Vh+N5eoTSiBGRIa4AqugQMIATMC5H69EPg
         7gHAwiptBi4+r0APsTjvpKrRqz7zmfIS9lQnUXZK6HACpXainF5kKlm36JRd6YObaZZw
         Dv3zebyn/gizSp3EriQWWe69y8J6h1UbD3TLSCJkhnPNhYcDpe/W2QI53UD+b5wNLcwT
         wuOw==
X-Gm-Message-State: AOAM532mab7Mj92BowISmMWJkzjsGATV8oaSZETWNaUi/u+3Lje3uOGZ
        zM69J7N+bL+dymZNU3BkUVvZQw==
X-Google-Smtp-Source: ABdhPJx+qW3BdCcTIQ2RRhn4T6dCDiRVxu5WiBUgQ5rCtldmeKk2WVhbYUniT3Al+20iaaxV4a/97A==
X-Received: by 2002:a17:90a:9bc1:: with SMTP id b1mr13821277pjw.49.1637267086584;
        Thu, 18 Nov 2021 12:24:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm433163pfi.149.2021.11.18.12.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:24:46 -0800 (PST)
Date:   Thu, 18 Nov 2021 12:24:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        wengjianfeng <wengjianfeng@yulong.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Allen Pais <allen.lkml@gmail.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mwl8k: Use struct_group() for memcpy() region
Message-ID: <202111181224.21692AAF@keescook>
References: <20211118183700.1282181-1-keescook@chromium.org>
 <147e31ef85dbbdf87d6785b6a28229de81f8af6c.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147e31ef85dbbdf87d6785b6a28229de81f8af6c.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:45:22PM +0100, Johannes Berg wrote:
> On Thu, 2021-11-18 at 10:37 -0800, Kees Cook wrote:
> > 
> > -	__u8 key_material[MAX_ENCR_KEY_LENGTH];
> > -	__u8 tkip_tx_mic_key[MIC_KEY_LENGTH];
> > -	__u8 tkip_rx_mic_key[MIC_KEY_LENGTH];
> > +	struct {
> > +			__u8 key_material[MAX_ENCR_KEY_LENGTH];
> > 
> 
> That got one tab too many?

Whoops! Thanks, I will adjust. :)

-- 
Kees Cook
