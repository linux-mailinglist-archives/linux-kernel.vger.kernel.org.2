Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31043E9805
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhHKSyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:54:21 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:44811 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhHKSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:54:20 -0400
Received: by mail-pj1-f41.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so6601183pjb.3;
        Wed, 11 Aug 2021 11:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1uZob/D+GwylCXdgRi3obUxS40Qeihru4aemoTLAUQ=;
        b=RQAqBoGxIRm1rwU9qIU5SbqrqvqxjaC4mdS43Jw1QDluVcYXrEohGmWjV7FvMy/PNJ
         Sw9LtcKEa6fB5ZTdiTSKfe5678gQ1YlwcybLwCe7mHnQ87MqkKxK5sdqObKh5epaNV6E
         0wMDsCMEt8WsiczQIKba06N7tdjUIIQuMf1jEnBGGBpX49G4Il6SElXMMF9hlaznrn/h
         UaL6A6vussnbhn5u9suoDROOYh33eSXtnWrsXI39qoaifIUSuvkp9kez/xAM5keSgKrv
         GJE4oZQB7lOBinpE+6bxLvy00vTQZRNORXQ3nDEqRGWi2/xoRCG2G2fEuOU1UpmMzcE0
         5dwQ==
X-Gm-Message-State: AOAM530UnvSDATHBkB6o2Zh0R1v/lh0hhVIh3fNhQNHgVt0M5GMU2D76
        X6Lya6jvYAWgbot+fRdCYQ==
X-Google-Smtp-Source: ABdhPJzwPWdzjp/BVTGo4S+qJUbIvZLtknvskDXcbQTrge6t+rdZVuqlnSego1aoSS8+I6dV0b0rbA==
X-Received: by 2002:a17:90a:d144:: with SMTP id t4mr64475pjw.113.1628708036070;
        Wed, 11 Aug 2021 11:53:56 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id x13sm188199pjh.30.2021.08.11.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:53:55 -0700 (PDT)
Received: (nullmailer pid 90561 invoked by uid 1000);
        Wed, 11 Aug 2021 18:53:52 -0000
Date:   Wed, 11 Aug 2021 12:53:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: clock: Add DT bindings for SMU of
 Toshiba Visconti TMPV770x SoC
Message-ID: <YRQcwD7771ncxtMT@robh.at.kernel.org>
References: <20210804092244.390376-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210804092244.390376-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804092244.390376-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 18:22:42 +0900, Nobuhiro Iwamatsu wrote:
> Add device tree bindings for SMU (System Management Unit) controller of
> Toshiba Visconti TMPV770x SoC series.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../clock/toshiba,tmpv770x-pismu.yaml         |  50 +++++
>  include/dt-bindings/clock/toshiba,tmpv770x.h  | 181 ++++++++++++++++++
>  include/dt-bindings/reset/toshiba,tmpv770x.h  |  41 ++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
>  create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
>  create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
