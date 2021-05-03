Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8990B371FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:57:31 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44680 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:57:30 -0400
Received: by mail-oi1-f170.google.com with SMTP id d21so4293896oic.11;
        Mon, 03 May 2021 11:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAmi3yu7iN8x9wHQ1W+DfMb4hWuQ7Nqu4KrAIFsRcJw=;
        b=qu5Uw/qeSyPeJuw2s0pRphf5y94y9t/RUKIQLgMLqzmFPQFzw3M3VZubxFQFGXcV2R
         AVXDQH7SEI3KC96f6E4tnLHh8M9NLjeH0T65itqgfzBj/bUCFOpQI93d3M4eQ+B7jCqn
         DGvRoXZckDhvpfazYi346EUG02ecaUXd7nQNUVQfVlYKRSQjm8eHNeQXUi1EfMFd2hNb
         dKL9hB7Za4kbfJz6c8DCuwzZjWZodYJu66NvTkKLSJdms+ZFHmUrdREDwiC4h0XPui2r
         315Pc1KlkSQnEFEbbJvBWcQXDYN7bIcVRqc5JXcbiygtYX/d3LzoWeWHEg2uiRpKGxHj
         9J/A==
X-Gm-Message-State: AOAM532Ymqvhd9KTpxZwAfKjXdkX/Fubl4f6JIvWRBXfbP0PHGz5rVpQ
        PaVStNZw0qsMcIgWqPQywg==
X-Google-Smtp-Source: ABdhPJwzQdY+6BT+qgyIG5QB4U6xDrMPhVmHd/CCaQDtNBP1xWtbQRTFooAHvGujV0I5nUHTB2vM3w==
X-Received: by 2002:aca:2813:: with SMTP id 19mr15070039oix.80.1620068196545;
        Mon, 03 May 2021 11:56:36 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r20sm162938otd.70.2021.05.03.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:56:35 -0700 (PDT)
Received: (nullmailer pid 2189800 invoked by uid 1000);
        Mon, 03 May 2021 18:56:33 -0000
Date:   Mon, 3 May 2021 13:56:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 3/3] dts: eeprom-93xx46: Add support for 93C46, 93C56
 and 93C66
Message-ID: <20210503185633.GA2189748@robh.at.kernel.org>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-4-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424212543.13929-4-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2021 23:25:43 +0200, Emmanuel Gil Peyrot wrote:
> These devices differ by the size of their storage, which is why they
> have different compatible strings.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
