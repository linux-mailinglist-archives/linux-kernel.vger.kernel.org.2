Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480037939A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEJQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:20:50 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38840 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhEJQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:20:47 -0400
Received: by mail-oi1-f173.google.com with SMTP id z3so15057565oib.5;
        Mon, 10 May 2021 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4t1R0KmHitYAs5f+VUeABy4ZnvxXkDUY0nqkTvRZkOE=;
        b=glMa27jhJtRwVbXDt231RjBytEivdzDmYq8UUgXKi1Vyqjr/t6WFohRQrvfnuyYwiH
         2fCf/CIA5Lks4OCpjBU0Cyyxc60/Fzmes2w/QKFDCuNn/0phKP/E06eem+XBLaacMqmd
         ZSQwZe/Z05RI4RAY/4yyOjmrI/MsilBgY5SiPVo9lbjpltAIqOEjM3kO4yUVGg+Yr7eN
         GayuWwjYDxwqtyqAwI8PgPSG9xpttpUVNRFUNXvpF1nmTcPtCTfGh8bv8hspNrxBW60a
         YQlc+aSX5JpuYWV0OFcXKFl7Gd0q/cZ+8DDSl25qTdl+rUVV6qBek1aEaBkn1tDqGSCO
         0Daw==
X-Gm-Message-State: AOAM533+nJNUGVmWPaINbRH1vbATE7Emkni69WPnatjW6zxGF4rI1fOQ
        f5auZTHmPOYdM76Fo6pDlA==
X-Google-Smtp-Source: ABdhPJyZ9aP77OpdmtNmaf9CzY2DZQFqnf8aZEZBRlGgIzYH5QdDmu3qqrbzvgEs0bvilHCaThSrjA==
X-Received: by 2002:aca:120c:: with SMTP id 12mr11424394ois.42.1620663580896;
        Mon, 10 May 2021 09:19:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 186sm2717765oof.14.2021.05.10.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:19:40 -0700 (PDT)
Received: (nullmailer pid 226845 invoked by uid 1000);
        Mon, 10 May 2021 16:19:38 -0000
Date:   Mon, 10 May 2021 11:19:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, marex@denx.de,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        aford173@gmail.com, linux-imx@nxp.com, festevam@gmail.com,
        ping.bai@nxp.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, agx@sigxcpu.org, frieder.schrempf@kontron.de,
        abel.vesa@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 1/4] dt-bindings: power: Add defines for i.MX8MM
 BLK-CTL power domains
Message-ID: <20210510161938.GA226814@robh.at.kernel.org>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
 <20210510040704.14997-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510040704.14997-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 12:07:01 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Adding the defines for i.MX8MM BLK-CTL power domains.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/power/imx8mm-power.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
