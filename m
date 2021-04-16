Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3628336281F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhDPS4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:56:13 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39914 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhDPS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:56:07 -0400
Received: by mail-ot1-f53.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso21893090otv.6;
        Fri, 16 Apr 2021 11:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0XnIQb5diD8IPv4s6rwLLTY1KVewVry0xUSPPhi/S8=;
        b=OeBav5IPF57m6In1AqZT8t+Qjfpif7p049TBU5MsapN5DXvMqiSmCIf9kqfivbJkgH
         fEGj/PNzhTXNtMjacJhkL2JxSPRyPdD5/cQrTHDmsrSD91G1zfEU7OyIkdFY4XS7mnro
         VKgGd0zFicObK7qwqX1FPw4HOxsTkzZcxln1/YbzHlSiMxxwBojSlVve7PdkKQRGfpBW
         Cg0Jt1lk1uzsN+L3uIpvvKOg0fWSpNWeDGKTZVUqwJryrLcKOdoeEjDqI7kbWYo16OE2
         GBiibmCCmpogemUPM4tWzJL4lYbPu6Ra3lL/ZGq9xmvriBmzFwg1jzoO1D23aY4KrwWX
         vC3A==
X-Gm-Message-State: AOAM532pkN2c+W2gDyKKN3YdHb6fqIRd7G7sZTFQ9GXEE/gKPtzp3Umz
        OvGJPBnARtG4Q9lspZMa6zCO7vK4DA==
X-Google-Smtp-Source: ABdhPJxVd4dmTTWBaTQhaeWV5iEBuOJ5oUi07oM5z0AdLS/Wn6jqGGrjGDFsCB45thclYifOE/Ctuw==
X-Received: by 2002:a05:6830:1697:: with SMTP id k23mr5103598otr.132.1618599341453;
        Fri, 16 Apr 2021 11:55:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm1286587oou.26.2021.04.16.11.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:55:40 -0700 (PDT)
Received: (nullmailer pid 3751813 invoked by uid 1000);
        Fri, 16 Apr 2021 18:55:39 -0000
Date:   Fri, 16 Apr 2021 13:55:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, zhangqing@rock-chips.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        heiko@sntech.de
Subject: Re: [PATCH v8 11/15] dt-bindings: arm: rockchip: convert pmu.txt to
 YAML
Message-ID: <20210416185539.GA3751624@robh.at.kernel.org>
References: <20210416080342.18614-1-jbx6244@gmail.com>
 <20210416080342.18614-12-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416080342.18614-12-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 10:03:38 +0200, Johan Jonker wrote:
> Current dts files with 'pmu' nodes are manually verified.
> In order to automate this process pmu.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/arm/rockchip/pmu.txt       | 16 -------
>  .../devicetree/bindings/arm/rockchip/pmu.yaml      | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
