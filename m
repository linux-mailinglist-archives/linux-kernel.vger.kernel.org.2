Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACE532FCDE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhCFTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:46:57 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35718 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCFTqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:46:44 -0500
Received: by mail-qt1-f181.google.com with SMTP id w1so4611437qto.2;
        Sat, 06 Mar 2021 11:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dz08oUU8oV3VKa4xa4+vLLPEt2YVK+n5GIJg6+VztrU=;
        b=IENOuhgyQGK2Z5penWZx+KAZBPHE8NRNl0b4VtaQ2MESBpzboSFPJyv/1lmWTqli1u
         hu6sPGdtKujbeF3PAXrya5jqqv6DsIXkudkaoXcPy64cbMMTivfFzZ+zFczNyPU1ANJk
         zJWSptyVcdpjWss0x46SOXF4RR42IRbH3BECNASkSAsu/7w2SdJOAqBQIp7yYKPPMYpO
         8OeWgP+aMzPV3fOdjwtaIjwfm6BA1sEh1tWfBQUyv5dzhBK+UD+nocErkoQ5pe5o5Kgf
         F56sAsAXiPFF3YqGDjDbfnOXikpZ1+eoKifa88PPnP9CD8yw1hthcRT44Ja1TMGt8ZxD
         kXYA==
X-Gm-Message-State: AOAM531USUGb6F86QcTK71jxc99acWi8PnZr7N1AlySvCiAeiWpYf3Zb
        jicvjwHkw+ICuHGoWBbN5Q==
X-Google-Smtp-Source: ABdhPJxw0Btrw6trPcNehtOx4+8KCZP9E/IrnkXLe9elDIlJdWYYymfGa+R3yv9JHoNqamNl8qaesw==
X-Received: by 2002:ac8:580c:: with SMTP id g12mr14483948qtg.14.1615060003891;
        Sat, 06 Mar 2021 11:46:43 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id c186sm4470415qkb.107.2021.03.06.11.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:46:43 -0800 (PST)
Received: (nullmailer pid 1105712 invoked by uid 1000);
        Sat, 06 Mar 2021 19:46:37 -0000
Date:   Sat, 6 Mar 2021 11:46:37 -0800
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        allen <allen.chen@ite.com.tw>, Arnd Bergmann <arnd@arndb.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: Add Jenson Display vendor prefix
Message-ID: <20210306194637.GA1105512@robh.at.kernel.org>
References: <20210305225444.GA792026@robh.at.kernel.org>
 <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
 <20210305234427.572114-2-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305234427.572114-2-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Mar 2021 00:44:18 +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
> include "jenson" as a vendor prefix for "Jenson Display".
> Company website: http://www.jensondisplay.com/
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

