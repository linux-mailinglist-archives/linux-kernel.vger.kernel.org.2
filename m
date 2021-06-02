Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BB3993AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFBTjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:39:24 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41736 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBTjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:39:22 -0400
Received: by mail-oi1-f173.google.com with SMTP id c3so3774498oic.8;
        Wed, 02 Jun 2021 12:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4be1Co2ahpvEywks2bnabgr4bPBIPKkuO9TmCoOL1S8=;
        b=Vb2Zep+x4Wf2VrhbDqucBT1Qh7IwjGfuIUXAKL4fAgguEGrkBzWoK0MsjjhlUxQ5Ow
         liPxrFjFVXF8mTu7Jd6+v8aPFZw+txcDdTLi90KgJsiFMVHAD5V2+E3NS7wlYEIk9tjM
         G7iyBdxS4LAHaMqMkoBXjo/zv6qgEytFDwm4OwLcPZYKnTBIiSt3X222+nm7wr9p8oAG
         rrKkH63ETrtasxJ8wG22hSQnlCV6/I3EYoD1QbSTqjc2lOmRWEOtroQq2FU/gpVen5mw
         MGrIui9U57NrnXzVYuoDDLjBjg92Lv4OLjspktygXfPRaYadpVoVp22cGbrM2MNIr6Di
         Hlzw==
X-Gm-Message-State: AOAM533zeqA0iyrZ7BQusUB+WJ/fMoY2e0QJBMZTWIfk90FCy9Ro/FKR
        2L6DVj92vaekh6TgCP94tw==
X-Google-Smtp-Source: ABdhPJx159EyoXWDiSbqQ/Ss9z4HG3rc1+6orGi+OaCxdEJqK7iHQx1rTPfn/vFZtAJ2y/NZCL8uuA==
X-Received: by 2002:a05:6808:1284:: with SMTP id a4mr15953775oiw.125.1622662644050;
        Wed, 02 Jun 2021 12:37:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm189830otm.1.2021.06.02.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:37:23 -0700 (PDT)
Received: (nullmailer pid 3848773 invoked by uid 1000);
        Wed, 02 Jun 2021 19:37:22 -0000
Date:   Wed, 2 Jun 2021 14:37:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/3] dt-bindings: extcon: sm5502: Document
 siliconmitus,sm5504-muic
Message-ID: <20210602193722.GA3848708@robh.at.kernel.org>
References: <20210601200007.218802-1-stephan@gerhold.net>
 <20210601200007.218802-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601200007.218802-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021 22:00:05 +0200, Stephan Gerhold wrote:
> Document support for SM5504 with the new siliconmitus,sm5504-muic
> compatible.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/extcon/siliconmitus,sm5502-muic.yaml           | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
