Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82DD3A7CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFOLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFOLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:17:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9DC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:15:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h12so8290872plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i84JjlRo2D2f/v7VuRGvpKj9m4FZoDnu564HcAYYGaY=;
        b=VTHFnc+4SnsSRV0D5jDxumRtE49WlOQLlikQFoE39XX8Wb5j25weHyQksV4/4Bn/f/
         2BlH2QShf5TXe7zDKdkjS+Gs3tE+RPTxzPeLwN6/cgZpqkATlyaJxVgB4UH0wPf327ZK
         3sg02GpQY+QtWBfJzL0HKJd0UvY+5w37Y3noV/Tr0+AqPol3BIvomuMAHNODERgZAoqL
         i/Vs7+tAbxxbfDyLn0N9FCKTiBr4s+0yLA7s9wxgR5BNyxKwXe1WIRfmXQ9vO7+XwMz+
         fRkr+bY9h/tbHmcW6rwAiRQ/L8eR4C2H9AUb+8oXl5chJm9EhUjEwS6TWkLgYkE2AW3p
         2uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i84JjlRo2D2f/v7VuRGvpKj9m4FZoDnu564HcAYYGaY=;
        b=kVQNbHkOIGoLLyTwPziN9ruupJranPQGD6y8SY7Y1m76hYkgk0yOZBsm+rXWNStNog
         JJ6IvygKeGJ87YspdjCVPg+7CBPqrR3bC6rJ++NdjqZtIbZ9i+X2cMURqgu8qsNRdNPK
         ciAL7DF8JzRhUpwSBoiFTyNNu/ni8HUJ+u/1wg10GPJXhhQzjXg2bnkJHHBJQRVZyhqt
         J3QNrBSUBLXc2b4ESu9LiJaH3OkLD2jOFmIwks9Vco25cISqMhFacCFvFclKpK3eDxpc
         SGiNzetzl74RN12cvddHl46ykbBxaDkLrhlY6PCpYUzy90Ig0mXYnmJbk1+na79Rhy5h
         Lu2Q==
X-Gm-Message-State: AOAM531x38e400uCzrulXlntc582nuNgPNPW3VMDf0bJ0bMyXm2vG7yG
        y3VrGphdV7KG+4TerTyg2JFk7Q==
X-Google-Smtp-Source: ABdhPJyprFGOjuuA6oVBkx5SM8o2ljPT3jBLG+8fzP8YN3F1g2qb2jzWJ2heaZFu4ovB1sQ+xoLJ2A==
X-Received: by 2002:a17:90b:2504:: with SMTP id ns4mr4466637pjb.39.1623755754669;
        Tue, 15 Jun 2021 04:15:54 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id g8sm15949343pgo.10.2021.06.15.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:15:53 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:45:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-21, 10:22, Geert Uytterhoeven wrote:
> The same reasoning can apply to your backend daemon, so when using
> the GPIO aggregator, you can just control a full gpiochip, without
> having to implement access control on individual GPIO lines.

I tried to look at it and it surely looks very temping and may fit
well and reduce size of my backend :)

I am now wondering how interrupts can be made to work here. Do you
have anything in mind for that ?

GPIO sysfs already supports interrupts, just that you need to register
irq for the specific GPIO pins inside the aggregator ?

-- 
viresh
