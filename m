Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB95432718
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhJRTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:09:03 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40851 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhJRTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:09:02 -0400
Received: by mail-oi1-f169.google.com with SMTP id n63so1152884oif.7;
        Mon, 18 Oct 2021 12:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=49SMLI2EfcSIIHBo/pZf8JUrstQjUQ4o89khtSTgLmQ=;
        b=3TOegyYLWLJXobV0Q2Q4r/MJ8HqNPgnOpr6sQvfTnTW83dLuscv2E0kFm34P1cihCb
         8Ur0C3lplMVnJixsj9f5gbwin1kO1g14dwg9bQ+G/QwhDtei8jdRjec/RnSJtTcAyBHq
         xwg3Hn1xuRlKCCb4aVlj2wp9y017Hh8FE4yevkbY2qbWa1VF0HeGw4uEOrAKKwVLoSmv
         6lNGOOSvT3rzUIi8iwxqydg0suAZY1Bb5qDtY80b/HguSxxcsMaJXwtUf9vdKxCIne38
         ReswKfluAFJIlUFzioBV5V6/bavK2Xa4ASAxh+eLY9E0s0Tlxoqvvu5Iff202bBTa12l
         rd+g==
X-Gm-Message-State: AOAM531ME2R0rHrcu0n3gT6Eo6IvtHHn1cEtpQ8VIboaGo+bisM4mRSm
        rly09AUrLinDCcbuEdpK6A==
X-Google-Smtp-Source: ABdhPJxmkPWje3+Z7w9ARfxBxTnx7/aJ0lYuSxFW/pvIp+fzwpJ6iKcT4Cd0MeKNCREIMFx6RbFkXQ==
X-Received: by 2002:aca:5cd4:: with SMTP id q203mr548649oib.179.1634584010752;
        Mon, 18 Oct 2021 12:06:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x62sm3173707oig.24.2021.10.18.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:06:50 -0700 (PDT)
Received: (nullmailer pid 2768871 invoked by uid 1000);
        Mon, 18 Oct 2021 19:06:49 -0000
Date:   Mon, 18 Oct 2021 14:06:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: uniphier: Add clock binding
 for SoC-glue
Message-ID: <YW3FyW4Ee1dCYM1s@robh.at.kernel.org>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1634000035-3114-5-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634000035-3114-5-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 09:53:54 +0900, Kunihiko Hayashi wrote:
> Update binding document for clocks implemented in SoC-glue.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
