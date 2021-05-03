Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7702372022
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhECTJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:09:22 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40669 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECTJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:09:21 -0400
Received: by mail-oi1-f177.google.com with SMTP id u16so6402232oiu.7;
        Mon, 03 May 2021 12:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJuQ2VLmX3/y05QCOllxuuVr7EUaJPmvVZttcxgWa84=;
        b=Lvaj2WnweV5CNy3IUl3i170QbDWZDkOmYxq1i+UspnGwVWH2JvLS8LpOjnBAH+55gq
         t8JjxNApBDDbiLfZLgBWbUX5/dqdZx3IQZCzwwm648ld2gUwdN/rLzl7ev+JTnfUDzqn
         aO+UnngLjnS1z2V2JsH3qGEPq3VFQylBK5RGzelqE3t/P90w9mYfbuGdlqh75mJv3J2q
         /QsdAQ62qN07V16YROS0Mr1p/QCdNq5c/fJegwWjSgvunxJtIyZDcz3+vGEfEXKLvVmh
         EzPowV23/8rqOA+mzIXBncPKxpSvuhowEUD7TZ7FLu+41bhgDN7Eyuup4AgD+7MEJpWE
         zVDA==
X-Gm-Message-State: AOAM531HhH+Gv8LSNf3KP9uHG4d6MsDdaTnNbJZn0GqG+JtcN3boNuVz
        YhhxmvBIhKOBmy8YYDfbHg==
X-Google-Smtp-Source: ABdhPJzE3Ta4pAuvGL96i+8mR402OCRrxAwg5WBg5i2n/L5T3x1GrnZL+kgHNXG5r2MgiNXRVgX94A==
X-Received: by 2002:aca:59c6:: with SMTP id n189mr43205oib.172.1620068906551;
        Mon, 03 May 2021 12:08:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i2sm189642ota.61.2021.05.03.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:08:25 -0700 (PDT)
Received: (nullmailer pid 2209176 invoked by uid 1000);
        Mon, 03 May 2021 19:08:24 -0000
Date:   Mon, 3 May 2021 14:08:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 0/4] dt-bindings: soc/arm: Convert pending ti, sci*
 bindings to json format
Message-ID: <20210503190824.GA2192378@robh.at.kernel.org>
References: <20210426155457.21221-1-nm@ti.com>
 <161957028464.177949.14790878722521589025@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161957028464.177949.14790878722521589025@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 05:38:04PM -0700, Stephen Boyd wrote:
> Quoting Nishanth Menon (2021-04-26 08:54:53)
> > Hi,
> > 
> > V2 of the series posted in [1] to convert the remaining ti,sci bindings
> > to json schema format. V2 is mostly review comments being incorporated -
> > details in each of the patches and in applicable patches, I have picked
> > up Rob's and Tero's reviewed bys.
> > 
> > There are also dts fixups that this series exposes, which is good, but
> > I chose to hold them back for now pending binding review at least. The
> > complete series is available in [2] if folks are curious - to be posted
> > once v5.13-rc1 is available for fixes.
> 
> Is Rob going to pick this up? If so

Okay, done.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
