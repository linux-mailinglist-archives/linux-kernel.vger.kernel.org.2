Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F14372091
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhECTiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:38:04 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34317 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhECTh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:37:59 -0400
Received: by mail-ot1-f46.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso6163770ott.1;
        Mon, 03 May 2021 12:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVa0fUuOB94Lc2UIyCQjDIzOvyUXsFk+sUnwlSh+cfA=;
        b=V+cWfnr3TIhLOYh3EdkbzOWBcMxOynUavI9aVVy/BYoYUChxj+zvgSkQ9I66VhRvfX
         YcbHHjvFOzepjinhsB2YBpdZk+fZg2zNlrKiaMLdrgX61eEzlQ5jZ55T//fIuBLyfeik
         qRMsUkB1weKxX54r8q+R7iOp33Y32UzjCyzz3O+yKupuTJa4gEhEo/Z+vpR6c7vzfQyR
         imHIOg2PdxnaItrEad/tpUXezFOmeb76P8FxREmZlY7AzyWOUjKx3giJAcQOl/aB6DBs
         /RUJP635rw/gssx6vV98gEx7hP9kCk282AjjQIH56ybVNeGchu5Ggy4Vrg6zixoEyTF9
         uK3w==
X-Gm-Message-State: AOAM533DHQsSlIAyKQTGOvp+DRyv806NVDulx63G0d7Em5qu6wvnzOLR
        VBand19AjR4KDN4qaOa2Pg==
X-Google-Smtp-Source: ABdhPJzA1HCJL+A2dQXp2m00XSuOUFiKEAV5ng5KSLNkbEIzoooPFoMP1lqjAkcwJWmXTPRwVtSbNw==
X-Received: by 2002:a9d:4795:: with SMTP id b21mr16696049otf.197.1620070625384;
        Mon, 03 May 2021 12:37:05 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m13sm170497otp.71.2021.05.03.12.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:37:04 -0700 (PDT)
Received: (nullmailer pid 2256170 invoked by uid 1000);
        Mon, 03 May 2021 19:37:03 -0000
Date:   Mon, 3 May 2021 14:37:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        abel.vesa@nxp.com, kernel@pengutronix.de, marex@denx.de,
        andrew.smirnov@gmail.com, p.zabel@pengutronix.de,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com, agx@sigxcpu.org,
        robh+dt@kernel.org, aford173@gmail.com,
        frieder.schrempf@kontron.de, krzk@kernel.org, ping.bai@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH 10/16] dt-bindings: power: add defines for i.MX8MM power
 domains
Message-ID: <20210503193703.GA2256113@robh.at.kernel.org>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-11-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429073050.21039-11-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 15:30:44 +0800, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Adding defines for i.MX8MM GPC power domains.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../bindings/power/fsl,imx-gpcv2.yaml         |  2 ++
>  include/dt-bindings/power/imx8mm-power.h      | 22 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 include/dt-bindings/power/imx8mm-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
