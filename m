Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF932FD59
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCFVJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:09:58 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:40400 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhCFVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:09:43 -0500
Received: by mail-pf1-f171.google.com with SMTP id x7so1188346pfi.7;
        Sat, 06 Mar 2021 13:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1NFomRzi4xgjHlzifXEdAJagWvD2oXKyv02N+cpRX0s=;
        b=rQDehLatn+1uhaGsewYCcFvKHPbkhLE9sphMqYIff4qmTJCp+XaCC1qkN1xZuo3cjW
         12GIyr7vf+wEMbgqDj7KKuaLbvyTLQgw/lxQtFtX1h9BFhAqIWaINDoFePqlcXANsRAh
         y5a9kDVK0HoKUZp7hEM1DJSlkDvEoY2kZ0UWxA1mE80ymziEMtozmMxzz5w+dfsbIcDY
         tbMhLEtzaIifLJhsY8ms1dzw1qAmGre0q4+6q6x2kQSe1OO/gwIBzWrvL6/H+wiC3y6L
         ZxeMku9QgwWRzmp/nU9XhVVqQ0W9yg+gmNmmyPPZi5a/HicjDLYiVzTSDyS96XaSsdV9
         BZ7A==
X-Gm-Message-State: AOAM530SXSEgeCYKkSeuPPe2GZf7nQvLsnRpnO3ZM4FxBC4zg4IkhPqm
        iSy2rsh3LeJl4IxJCeNkPQ==
X-Google-Smtp-Source: ABdhPJxjdjj9u38fIN3Momyu/WLXQ5qzFlXPV8oF+wZYsDGIcuXMUWGgE3MOfQ1J0YG7hfxmNR4SHw==
X-Received: by 2002:a63:1524:: with SMTP id v36mr13979377pgl.221.1615064982615;
        Sat, 06 Mar 2021 13:09:42 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id v185sm6201829pfb.125.2021.03.06.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 13:09:41 -0800 (PST)
Received: (nullmailer pid 1217154 invoked by uid 1000);
        Sat, 06 Mar 2021 21:09:37 -0000
Date:   Sat, 6 Mar 2021 14:09:37 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>, jonas.gorski@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] mips: bmips: add BCM63268 timer clock definitions
Message-ID: <20210306210937.GA1217101@robh.at.kernel.org>
References: <20210225194201.17001-1-noltari@gmail.com>
 <20210225194201.17001-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225194201.17001-2-noltari@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 20:41:58 +0100, Álvaro Fernández Rojas wrote:
> Add missing timer clock definitions for BCM63268.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  include/dt-bindings/clock/bcm63268-clock.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
