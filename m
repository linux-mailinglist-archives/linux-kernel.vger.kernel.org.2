Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196A41D6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349565AbhI3Juk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349519AbhI3Juj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:50:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A223C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:48:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so8996167wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=llOBBt4Gg+T9pqqsZvZwGFvS5VWM4PKtaHhvHx5cDu4=;
        b=cq3rnTHpiJLC7u1rp+dTA4Tkn8YnC/Uxbx4zk7KGYupPqBxF2H6F4mM09fWB4D+zFc
         +XAyfUPNGzah5S2uhYBiABCnXIm2DpXiY524KFwd8XMgW8u/0MMKWXjqPMMscNfyV7lG
         ucb9J69p5dJtHiRrmEbTjDuveAejBZsNWLFKIuEhOKNwufDQB7BeW5/BHvCRudRMFn8t
         Gw5Ifhz5DSsGzxMXC48iw+2b/gRnzNxOTtXzcxFfM/3+lbPsfRXH3EXKNTknsSo0iLQr
         6oYgOsjqTI0pwxkePg2Bl0J/n+KObkv+mL42GFG2G06imwu2sRtZha4zGObnzN5yNCal
         4jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=llOBBt4Gg+T9pqqsZvZwGFvS5VWM4PKtaHhvHx5cDu4=;
        b=WAA1hi9j1wG3MviSVE9EKKv0TZT4n/qGVro/JL5FPiZHIalFC0H6zKKLFAqSiizJkx
         i2WePH/DvHiKvSz9bDveGumR1PnBpbwmPsBRnK4aULzJigZjo8LhHZ6MZ3SOscxguLZT
         mp2U/DrzRVec0z3Ttxkx0Gox7jy1kd7T9NU5Eud7aOmt28dXogi0L8CpXcXb4dqATAI4
         iZtFtwjkBttF7c5EdP5GAcNwgFGBLYP+HR34y+kvWkI/lHWufkjYRHbkP0ZpkTVyghEd
         JTQ+dTh75lgzRyDNsV5J6jo56pYRVALceYWDoMBKpLRYkj/H7qV9PopOuUTok8OJdhEb
         sEDQ==
X-Gm-Message-State: AOAM531tp5Bj2mjf8bx+bHziOk6Cc3U5T8y5LWGKjkfmo6wCpcyJkGwo
        lPU6Eerqp9vukHmDI8Rgr+K+xg==
X-Google-Smtp-Source: ABdhPJyt8cvU9G9LKfhdgUEJfpJ+vPB6W8X7llmrHiV/Xto7jNbE0aL8sJgPNIQ+nPVS7QZyOgnOzw==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr5092711wri.89.1632995335610;
        Thu, 30 Sep 2021 02:48:55 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id s13sm887561wrv.97.2021.09.30.02.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 02:48:55 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:48:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, andrew@aj.id.au,
        linux-aspeed@lists.ozlabs.org, osk@google.com,
        linux-kernel@vger.kernel.org, joel@jms.id.au
Subject: Re: [PATCH v7 2/5] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
Message-ID: <YVWIBQFZaGXbeg28@google.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-3-chiawei_wang@aspeedtech.com>
 <YVTik08lNtDRGn0L@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVTik08lNtDRGn0L@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021, Rob Herring wrote:

> On Mon, 27 Sep 2021 10:30:50 +0800, Chia-Wei Wang wrote:
> > Convert the bindings of Aspeed LPC from text file into YAML schema.
> > 
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 188 ++++++++++++++++++
> >  2 files changed, 188 insertions(+), 157 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> > 
> 
> Applied, thanks!

Are you taking these now?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
