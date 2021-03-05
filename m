Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E1132F672
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCEXK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:10:56 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38455 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhCEXK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:10:29 -0500
Received: by mail-oi1-f180.google.com with SMTP id q203so4338831oih.5;
        Fri, 05 Mar 2021 15:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qwx/lahU6C6mQtmf70dfF7d8Nl+xThqYqme8HF212Hk=;
        b=JH/2rN56Ao7JU+nvz5WOVhCQwFesSJKw8FbXEjBXryhq4PocWJNXDGB2+/4KhuZPOl
         tlMrKDReJ1hIcrZE9pmTm6eSqfQY5lKTAt4MkR2oWwJwPEJEbVYT6OJwnfKNmiJHW4pp
         M9GLCc/5Rk+2YgF4n+5jJzBg0Q1+QyQDE3NkS1IDvJPNEamM9mQcY7aY4jXI7jqILtv5
         iiwTFY4fzF0SnAIQWS/MSP+wsc6KySt6sNMboRCap97WhShek/OPSAzzFCDmhRIiqPz+
         70DW072grfAlZaY9T0o87T5E4DnMb7PaAINLkC2ah9KahQQ+8hTXzF+Bhl+zEjnOHfOl
         FR8Q==
X-Gm-Message-State: AOAM531bHhbYvcTZEpOVOtoubIcIlJ8oIELNuLE2HkdY87sYrNniVfvX
        HgpMA5jkR5b+ImfNUKrA7g==
X-Google-Smtp-Source: ABdhPJyiY3zuSXP+XPB+MNCejavIyEyX+k7RYCnvsME89Efwvpyn9848KWc7gA1bozqcYndRTpYVeA==
X-Received: by 2002:aca:5f83:: with SMTP id t125mr9010781oib.114.1614985828782;
        Fri, 05 Mar 2021 15:10:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k21sm892029otl.27.2021.03.05.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:10:27 -0800 (PST)
Received: (nullmailer pid 814164 invoked by uid 1000);
        Fri, 05 Mar 2021 23:10:26 -0000
Date:   Fri, 5 Mar 2021 17:10:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Georgi Djakov <djakov@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC 02/19] dt-bindings: interconnect: imx8mq: Add missing pl301
 and SAI ids
Message-ID: <20210305231026.GA814130@robh.at.kernel.org>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <1613750416-11901-3-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613750416-11901-3-git-send-email-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021 17:59:59 +0200, Abel Vesa wrote:
> According to the bus diagram, there are two more pl301s that need to
> be added here. The pl301_per_m which is an intermediary node between
> pl301_main and its masters: usdhc1, usdhc2 and sdma. The pl301_wakeup
> is an intermediary node between pl301_main and its masters, in this case
> all the SAIs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/interconnect/imx8mq.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
