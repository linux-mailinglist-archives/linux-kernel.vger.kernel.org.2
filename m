Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6BC30E4AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhBCVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:09:19 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35467 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhBCVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:09:17 -0500
Received: by mail-ot1-f42.google.com with SMTP id 36so1288967otp.2;
        Wed, 03 Feb 2021 13:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvoHcHkCk93ZEer9cwtNPDbnksZwvyPINiCKRNMusH0=;
        b=czH5QdVayf1H4463CCE3ubKr837udMyNswOADH6Uc3jKmtnczL0cnuiK1sg0e3kt3r
         KKnJ3pR4wOkhDEnre3LqjFaKMi6VLV6b+nPxOAFAlBpsBr2MJ2+h1PX9oKOMIxOtdC3i
         tn8AypxNp/fB1bd6ojRhW2FV6kiDi7woyvldkqNwQbB3BLiYB9WcCvtd9506YSP1vB9Z
         adnxydeIfrhMDC6UOAd5aSeATa1op4LWzcwk+p5e7gBuVDBcV3zxupTJFg/1lT8FJb3j
         XouKlaM/4v/zIFyg3fHsNT4ID+Xa3Hvii+1N8EsLh8T1MT9/L5EMrBs2RSjP4VaXQaMQ
         I8Lg==
X-Gm-Message-State: AOAM533Ki86uQySdUZNQKQ9BGsrUBq1C9LFNF/vqGS/qzE2dTjd2nzYu
        rzVDmE6RYNKnCMlzXYeKcXtXat6eXw==
X-Google-Smtp-Source: ABdhPJx5OhbJx5YGnt91NiV22Delq1k29Az9wFuKJQ2EtGzv+VDJvA6FK5ECLdI9pD0A8GVoacvMhQ==
X-Received: by 2002:a9d:73c9:: with SMTP id m9mr1770312otk.75.1612386516510;
        Wed, 03 Feb 2021 13:08:36 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g14sm653139oon.23.2021.02.03.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:08:35 -0800 (PST)
Received: (nullmailer pid 2449721 invoked by uid 1000);
        Wed, 03 Feb 2021 21:08:34 -0000
Date:   Wed, 3 Feb 2021 15:08:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: generic-ohci: Add missing
 compatible strings
Message-ID: <20210203210834.GD3706951@robh.at.kernel.org>
References: <20210202175439.3904060-1-robh@kernel.org>
 <20210202175439.3904060-2-robh@kernel.org>
 <YBpn4zqGk6mV0aII@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBpn4zqGk6mV0aII@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 10:07:47AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 02, 2021 at 11:54:39AM -0600, Rob Herring wrote:
> > The generic OHCI binding needs to document all the specific compatible
> > strings so we can track undocumented compatible strings. Add all the
> > compatible strings from in tree users.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/usb/generic-ohci.yaml | 34 +++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> Both look fine to me, do you want me to take this through my trees or
> will you take them?

You'd better take them. I don't think they conflict with any of the 
other USB binding changes, but there have been a few this cycle IIRC.

Rob
