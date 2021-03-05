Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BB32F3FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCETdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:33:45 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38303 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhCETdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:33:38 -0500
Received: by mail-oi1-f173.google.com with SMTP id q203so3735077oih.5;
        Fri, 05 Mar 2021 11:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yiPot607vuWf4m+kfe9y16lhwqmXYMaMTARcfyoU9vM=;
        b=igG0eaXfCfuEnD6nAiPAthZg9Lus0jxwdKUg/DyMMo2ULfcUOrqn9n/0cQNqvRhcTU
         npuXdfobb01zU5KD+bz5m+VdwoJ8cwaswiq3uSwO3TzOvlSDkDbwv0LnS1V2/4x/guKB
         afq8pWaCN77LT4J6TPp/J4LWQndXuGhPmaV+prY9MN0y0K7osrDnlQFIMeGYh+DDNQ9T
         wXt49RVWPyKfBKtzRnTgrCWpbo2y4fcdnpIWl+fQGk3VvXVAM78oegfXyuSlzQARd9gF
         F+0tcmgB4ehHwk6/sMeO7UpxGI5v8GkcKMMEXoP9q9YlwZ9L3QBrhRRKagAvMhPj5nlg
         RfVA==
X-Gm-Message-State: AOAM5338Jh9P1qe+vwfbLEBcabnrUDZxK4FvG2lksWiAvcWg9G3Mq15y
        6YPsC1H8j+u1A0GfO7H8+g==
X-Google-Smtp-Source: ABdhPJwFBw9li8HJt1Kwy55PM7umQYAvITJRcWhdRZ2rzXKwKP/iJeeWO2A0KprIqMN/MA9ES2oJDA==
X-Received: by 2002:a54:4184:: with SMTP id 4mr8327607oiy.72.1614972818030;
        Fri, 05 Mar 2021 11:33:38 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q16sm807760otm.14.2021.03.05.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:33:37 -0800 (PST)
Received: (nullmailer pid 520870 invoked by uid 1000);
        Fri, 05 Mar 2021 19:33:36 -0000
Date:   Fri, 5 Mar 2021 13:33:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Le Jin <le.jin@siemens.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add Siemens vendor prefix
Message-ID: <20210305193336.GA520824@robh.at.kernel.org>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <4726d7ad39d40916a02b5e79fc17e15934e97f5d.1613071976.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4726d7ad39d40916a02b5e79fc17e15934e97f5d.1613071976.git.jan.kiszka@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 20:32:53 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add prefix for Siemens AG.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
