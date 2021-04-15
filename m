Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34708361392
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhDOUgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:36:45 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44726 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbhDOUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:36:42 -0400
Received: by mail-ot1-f46.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so12561273otl.11;
        Thu, 15 Apr 2021 13:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBqkXVNW6CoLFV8AmAx2h6U2I9QrN9OCJEmOA2YWE58=;
        b=BV48K1hF94Bw3Y+JZrZHtkt+q45yAOT4wskYIJ0evv+u436+JN+LTxQc1Uv/QKRAdm
         3d1gYUTEMYlCBth/dy5YRZINwqg7HjXarB692gZVsxgREydK/dWkVQM1GldZ3Pty41sX
         1DJSpzcvxgRCE+Zbs7YdglZz1eSCKH6i8IZNwn3gvCQsXj0n0/o2loRE2MMm7sZO1MXg
         KhkYNZRvvEQraC8Zd3hoUqH1aWGg31evYcEFi9oGnjlhKQ9vBRqnUbU9SBVE3NSMP2Dx
         990GAGJwj0I592NiinGV1xWEjamg6+Wa8bByGna0NZm6u34DarGZHeZ9BRV9frEaH/uj
         C+2Q==
X-Gm-Message-State: AOAM5307nMwgvvGdLBMGV1SKj4mrBuv492pnIr5uXHGpHkCOsOB+9LNs
        NFUnDpLFZo5PoVce0gxmQ9LVwA6gMA==
X-Google-Smtp-Source: ABdhPJzGRkx0I4NexqDCsyAQVdMKCnbMFjeh4brrvgu53QoNLi1Wn7PvSBRXYW9pkDQM95za1ZX0Bw==
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr819824otl.307.1618518977819;
        Thu, 15 Apr 2021 13:36:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m133sm853920oia.22.2021.04.15.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:36:16 -0700 (PDT)
Received: (nullmailer pid 1839871 invoked by uid 1000);
        Thu, 15 Apr 2021 20:36:15 -0000
Date:   Thu, 15 Apr 2021 15:36:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'dais' is a required property
Message-ID: <20210415203615.GA1839818@robh.at.kernel.org>
References: <20210412100638.3349-1-thunder.leizhen@huawei.com>
 <20210412100638.3349-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412100638.3349-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 18:06:37 +0800, Zhen Lei wrote:
> When I do dt_binding_check, below warning is reported:
> Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: \
> sound@ec500000: 'dais' is a required property
> 
> I looked at all the dts files in the "arch/arm64/boot/dts/renesas/"
> directory. However, the dts node of this driver does not reference any
> property in file audio-graph.yaml. This can be proved to be true, because
> after I deleted "$ref: audio-graph.yaml#", the old 'dais' warnings are
> cleared, and no new warning are generated.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
