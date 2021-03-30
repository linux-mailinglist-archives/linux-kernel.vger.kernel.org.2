Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11A34F484
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhC3WqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:46:17 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43589 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhC3Wpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:45:54 -0400
Received: by mail-oi1-f182.google.com with SMTP id n8so18067732oie.10;
        Tue, 30 Mar 2021 15:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLGY/U77bjaTReaj2IIARZWRCCbRNc7FTLFruMbM/vg=;
        b=XekdCQ8KlZQi7e/+9+/AtwCxZR/TdIcQ64FuX/Fd7DXWAaPtGJql14+5JZDUxZir8J
         CE+RCNwQMQxpza5wjtn9j6NsijImZwD2SEYAWRVnXKzvDA24rpWU6SDDGlFyqVclWbzt
         /26WKC8LErHribyMgGfad9YJtIMG7qTi49FEzJywANi3H+R9gEs53sk8/zWOYfGxYhXx
         4V1uq6JCqLPcUC+CGU92zfObC7BYX/xEsRg33EKHQ5GB6cB+ZJ5/+mdnIBshLDbEQX8t
         VM8bkK1+M64X/u5BE11AYv+MZU6Zqhn96jl1vj/UL7cBw/TxOEoC+0bIOkTlgLfb5UJO
         XCgA==
X-Gm-Message-State: AOAM533ht2nkVCL3OJrM6aJjyb+eQq/UIYDiLwA+jtot7MUp6M6igSQO
        SAEDOyOIojzcK17CBACdqg==
X-Google-Smtp-Source: ABdhPJwEBrY+z1c9H+Ydo5wbfdprtBqSKqvER/L2vbgFu9N7KHmRm7qB+S0Adse53LXloREJLLHdAw==
X-Received: by 2002:a54:4492:: with SMTP id v18mr141539oiv.49.1617144353522;
        Tue, 30 Mar 2021 15:45:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s193sm79142oih.52.2021.03.30.15.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:45:52 -0700 (PDT)
Received: (nullmailer pid 850891 invoked by uid 1000);
        Tue, 30 Mar 2021 22:45:51 -0000
Date:   Tue, 30 Mar 2021 17:45:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'dais' is a required property
Message-ID: <20210330224551.GA842101@robh.at.kernel.org>
References: <20210330030631.2253-1-thunder.leizhen@huawei.com>
 <20210330030631.2253-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330030631.2253-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:06:30AM +0800, Zhen Lei wrote:
> When I do dt_binding_check, below warning is reported:
> Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: \
> sound@ec500000: 'dais' is a required property
> 
> I looked at all the dts files in the "arch/arm64/boot/dts/renesas/"
> directory, I found that all nodes that contain the "dais" property have
> compatible string: "audio-graph-card". So I can be sure that the
> "$ref: audio-graph.yaml#" should be corrected to
> "$ref: audio-graph-card.yaml#".
> 
> In addition, not all nodes have compatible string "audio-graph-card", so
> the "$ref: audio-graph-card.yaml#" should be described as "anyOf". To
> ensure the validation of "anyOf" always passes, group it with the "if"
> statement, because the result of the "if" statement is always not empty.

'anyOf' is probably not right here.

In any case, the is going to conflict with my series[1].

Rob

[1] https://lore.kernel.org/r/20210323163634.877511-1-robh@kernel.org/
