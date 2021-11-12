Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856BF44ED81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhKLTsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 14:48:35 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41748 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhKLTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:48:33 -0500
Received: by mail-oi1-f175.google.com with SMTP id u74so19823137oie.8;
        Fri, 12 Nov 2021 11:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j7/MNFvu3pWpHHh4C0yhpRtrsmK6UyzpTCQ5CFCyv9s=;
        b=Oaa3VmvJl+mnAyq/b8vicZSejviNcOSzC6lRs4UoDMdUyVzjyxsQ1WhcmkEPtmAzcE
         CCuLqJ6ekUw0o9iqMSlg95BqhW4HbvUZObpTtP8fzCSxt5d21scXemVAgPwPex60Q+8z
         G14XHlZkAOv3ZLeSqQfXLP8CJvyU1/9Yk3sC2NfxgYSORYQbzTmgi59DvEL58losKT8h
         yn7S3zEDL1Os1dE4ZrKfZiK8cHzxhTcxgLaEZ5qn1mn2lKK8tMqnw1XK5ttjnw0dxYwz
         b3On7r2WS+Q5zngyr51caq09UIhpj1HoRKq+rblgmsXUSyLvxLfYrdrCBbljkx0nQNKY
         RnbA==
X-Gm-Message-State: AOAM530CgrT8P+m14ObIPLYGWKlVp/Yyx3hcre5tXoRq3plDC3xeBBqU
        6ThiQKQytDD//xVN85Sj/w==
X-Google-Smtp-Source: ABdhPJwIgDK32rwDVLbWBmyqAfVHdA77NWwWOZvzfvwJ16466RwO/aEXsqBx3mbXsLShMgAAZom83Q==
X-Received: by 2002:a05:6808:4d9:: with SMTP id a25mr14955508oie.52.1636746342204;
        Fri, 12 Nov 2021 11:45:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 93sm1428362oty.11.2021.11.12.11.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 11:45:41 -0800 (PST)
Received: (nullmailer pid 3250136 invoked by uid 1000);
        Fri, 12 Nov 2021 19:45:40 -0000
Date:   Fri, 12 Nov 2021 13:45:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org,
        kavyasree.kotagiri@microchip.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Subject: Re: [RFC PATCH v4 2/4] dt-bindings: clock: lan966x: Extend for clock
 gate support
Message-ID: <YY7EZPX4Uoqwofe5@robh.at.kernel.org>
References: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
 <20211103085102.1656081-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103085102.1656081-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021 09:51:00 +0100, Horatiu Vultur wrote:
> Allow to add an optional resource to be able to access the clock gate
> registers.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../devicetree/bindings/clock/microchip,lan966x-gck.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
