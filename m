Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651D33E10B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCPWAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:00:53 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:36167 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCPWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:00:51 -0400
Received: by mail-il1-f176.google.com with SMTP id g9so14199277ilc.3;
        Tue, 16 Mar 2021 15:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqWjNc+e+7pVSRjuH47CWTburU+IekIrrOek0pTQW54=;
        b=jek1B6ZTSuqNYLTwNfpdIOKdDz/hPIKnIE3LOxbgbKjFiYMi1q8V1sFoi8iRAKy0z5
         6tEPKoexZAauiD9k8HooTwApmm7IPIMvjpX0k0MEHMJl0ut4gGzoZ61R/OJtaF1CpQkf
         PjWbDdeWduzj5jBnOxKuLdR0PtX63PQ6BY29PLdJUh+lLNL6vqtvaRKtiYrWBsjkYtS7
         DbxRo3Tt8CFzXG1dPOy1ygY0TzxZOzqjed/EW5KRMZuKtqRlzXrFiIDIR54aqS7BXMs+
         /ax4hO2v2HRoXItW8jvV1vQxOvaO0i20dFpeavG60OnbCcG4e+u3VnG1sdmJpDdLLL28
         podw==
X-Gm-Message-State: AOAM533Dc79wdbHu7RDbsymVd6yYC7UBg/4aF9EdlDT45A3YX9PKCwFl
        0oCbI7Qf1eG9ISLvNkINZw==
X-Google-Smtp-Source: ABdhPJyoUgSOBxZENuGIi2GsE47RTs4+bxmWNYK0Sfu0ldDpJetkChasC98ONnGGouYSKTAk1P50Qw==
X-Received: by 2002:a92:d6d2:: with SMTP id z18mr5568800ilp.30.1615932050820;
        Tue, 16 Mar 2021 15:00:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f3sm10023386ilk.74.2021.03.16.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:00:49 -0700 (PDT)
Received: (nullmailer pid 3754285 invoked by uid 1000);
        Tue, 16 Mar 2021 22:00:46 -0000
Date:   Tue, 16 Mar 2021 16:00:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: clock: Add NIC and ETHERNET bindings
 for Actions S500 SoC
Message-ID: <20210316220046.GA3754207@robh.at.kernel.org>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <fa6bcb2dc4309ca1972340694aebbcc5f55bd61c.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6bcb2dc4309ca1972340694aebbcc5f55bd61c.1615221459.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021 19:18:30 +0200, Cristian Ciocaltea wrote:
> Add the missing NIC and ETHERNET clock bindings constants for Actions
> Semi Owl S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  include/dt-bindings/clock/actions,s500-cmu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
