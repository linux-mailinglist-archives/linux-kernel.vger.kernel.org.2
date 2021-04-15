Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415F8361394
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhDOUgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:36:55 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39828 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhDOUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:36:53 -0400
Received: by mail-ot1-f43.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso19052753otv.6;
        Thu, 15 Apr 2021 13:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVWoOZSHf10Y+tHRIXNRspTGFjz0DsA6m8OWQyKDUOI=;
        b=c581PitjC3SYE6biCqSD7B1uxI0wR4JiA8ePOCQgEdA62rQibQob31QinVJ1amm3dv
         B+CTb38gknYXxcIOzGnfbQhU/eBTjx4HOOCdSTo3/e1dLewt6jujI5x8LuZpv0JF5TbS
         VfP+q+DAX0TmttM+lw3tgNLgKnnh+6sFD824ocYRATPRZjUEx3DdojsaE92TyUlxKG5K
         YGObKw0amMgQWYxifGZJYVciWIlyBiO5it2mZWqXWVYmha07Z5VXmiQm6tRtMO+AOxEv
         mzgx9LHtas2T+nfXNE37PS894ZyoVr2bPwons9CNiSngTU+M7GtBnXLdOKZnNTyTSXta
         to4g==
X-Gm-Message-State: AOAM531gd1RoSFvRn5ZapStn29na0KHgad9MQjWp/YkYb9V95sqdGb6H
        lU5duVNckgXf0clwUKxeDA==
X-Google-Smtp-Source: ABdhPJyD2gFCR2X0gACDKiW5lZzJttoGCo7WmNjMCtGp8RuwEVLfYupRV5at1oHQGVdJGFD11C4gLw==
X-Received: by 2002:a05:6830:1e10:: with SMTP id s16mr867100otr.28.1618518988676;
        Thu, 15 Apr 2021 13:36:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h25sm754218oou.44.2021.04.15.13.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:36:28 -0700 (PDT)
Received: (nullmailer pid 1840238 invoked by uid 1000);
        Thu, 15 Apr 2021 20:36:27 -0000
Date:   Thu, 15 Apr 2021 15:36:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
Message-ID: <20210415203627.GA1840177@robh.at.kernel.org>
References: <20210412100638.3349-1-thunder.leizhen@huawei.com>
 <20210412100638.3349-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412100638.3349-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 18:06:38 +0800, Zhen Lei wrote:
> Currently, if there are more than two ports, or if there is only one port
> but other properties(such as "#address-cells") is required, these ports
> are placed under the "ports" node. So add the schema of property "ports".
> 
> Otherwise, warnings similar to the following will be reported:
> arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
> sound@ec500000: 'ports' does not match any of the regexes: \
> '^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...
> 
> A given binding should just use 'ports' or 'port' depending on it's need.
> Both are not allowed at the same time. The check is done in "allOf".
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../devicetree/bindings/sound/renesas,rsnd.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
