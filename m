Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4333F7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCQSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhCQSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:08:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:08:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w195so36094172oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GcUhCfYNDJJjGJ8ohBHX1C0ch2jy4DUHssr3MoU+AWU=;
        b=eTIpubIUPvbN1WuH36RG/3paeJR1Sg/C8sf0rcDyhhU/ya9dRgqAhtAyyosAFXdlOl
         f6APtnanqw6EHUoI6LIOrZ5YIg6G4sUpb8Z5wsFGPdyej2BZxOLQM5WtW7+B/moYFKtN
         RXBeqzVbetGTq+rwkaXhzgYGHaCwfSi+mjzTIoVucRsE8BcuVRHXSaI1dClwhESxGFZB
         xY9exQiDak1Af7W9jX8HJ47k6I1+dmvByXGJ7wQbyvNYNIqvExX8OFgjVBNcRFSD7TIp
         02nc4dZeGWc/hrJrQxgWU9qZ4LWsU2JQdfgQsN9iG69UvfaBexYvrIa+q0CQe01gTNZf
         NgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcUhCfYNDJJjGJ8ohBHX1C0ch2jy4DUHssr3MoU+AWU=;
        b=ORTXQ9IWj7csUE7EQPgVnjrNGOZCaeXqJEmU0ndgAwRMG/Xs/8X3Jsa57AaL5cfE+e
         8/ybPgF/rE1l88xgamdl8pU7WsSmz1asIdrVrfj0dG6c51Z2EIP4X1Xt1bK93gcCK95X
         z1YnOo0EL6PPn61q7S+jSzxkkjZZYEDMhU79Z4L7CzoaWiOH4qlwIyz76yEGI+js5tWE
         nriHRtSQszgZ3J+b+Z8C3EYYGT75ozHtWfWpEr4SEdCrzCbQXH8h7dEAJWSckZF10w61
         JVqMtkk7PL9HaMH5RFIotl4fx9Nr8hiuTxiTihs+XcSbXoWOtqBiYYwdz70dmyjEs+QL
         ahGA==
X-Gm-Message-State: AOAM532jtf0TVg70HVBUCm12QvTQBvLUsS5uHT0dAl0V0yCDMKy7vdYE
        FnsH3/GEiY96x+kHm9rzgzo9jg==
X-Google-Smtp-Source: ABdhPJylmisE+8bmumR+vj5OdRXxasLNVpv/JgwNeVN6sXzYD7xEr2o0CHdpEfznl7Nv7EqJDJt5LA==
X-Received: by 2002:aca:5d82:: with SMTP id r124mr28532oib.59.1616004484509;
        Wed, 17 Mar 2021 11:08:04 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s193sm7966921oih.52.2021.03.17.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:08:04 -0700 (PDT)
Date:   Wed, 17 Mar 2021 13:08:02 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dianders@chromium.org, rnayak@codeaurora.org, lsrao@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8350: Remove second reg from pdc
Message-ID: <YFJFgvLQfr49EvWE@builder.lan>
References: <1615958996-31807-1-git-send-email-mkshah@codeaurora.org>
 <87k0q6i1g5.wl-maz@kernel.org>
 <bce03166-e65b-198c-8b93-39e0c218aaed@codeaurora.org>
 <87czvxj2t9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czvxj2t9.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17 Mar 09:02 CDT 2021, Marc Zyngier wrote:

> On Wed, 17 Mar 2021 09:48:09 +0000,
> Maulik Shah <mkshah@codeaurora.org> wrote:
> > 
> > Hi Marc,
> > 
> > On 3/17/2021 2:47 PM, Marc Zyngier wrote:
> > > On Wed, 17 Mar 2021 05:29:54 +0000,
> > > Maulik Shah <mkshah@codeaurora.org> wrote:
> > >> PDC interrupt controller driver do not use second reg. Remove it.
> > > This is a DT file, not a driver. What the driver does is irrelevant.
> > > 
> > > The real question is: what does this range do?
> > > 
> > > Thanks,
> > > 
> > > 	M.
> > 
> > This is to set interrupt type in SPI config for which there was a
> > change [1] but has not gone in for upstream PDC driver.
> > 
> > The second reg is not used in upstream PDC driver, probably when
> > posting downstream DT changes for sm8350/sm8250 it was carried in
> > device node as is.
> > 
> > As its not mentioned in bindigs as well, dtbs_check reports it as
> > additional reg when converted to yaml.
> 
> Then I'd rather you provide accurate documentation in the binding
> rather than changing the DT files. Other operating systems may use it,
> and it isn't unlikely that Linux could use the feature at some point.
> 

I agree. Maulik, please update the DT binding to document this region as
well.


It also seems relevant to pursue getting [1] into the upstream Linux
kernel. Is this something that you use downstream Maulik?

Regards,
Bjorn
