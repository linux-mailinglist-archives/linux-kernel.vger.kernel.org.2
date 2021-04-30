Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03DD36FD9E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhD3PWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:22:20 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:37845 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhD3PWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:22:19 -0400
Received: by mail-oo1-f42.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so15574057oot.4;
        Fri, 30 Apr 2021 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMrBb+tonK4C7ZQJJhThBMIvVmtzwjHeZsvtLG9/Lns=;
        b=DuaYrRL9BmLeh6OcNWLOZXKujL8YnBy6pDSWwzbFtRx2L5pd92SFp0SowR/eE5Y02C
         2Lg/kQD+PDNmbulJ2qvBjk8rfdyDYMxv5Qkx7lwse5QKDGvJqIQQoHb/2DEbt/cZioD+
         HjdL39Nrf4CaxtVAwtfT/AAaMQ5NRKqrpuV0qpzSIZ/ZdshAw+HJyc6+utQbfQFMjO5O
         NgwqVLjRZXa9ntq4/UqkfxcxlbxzXxrDQl7rNs0j6rAJ1mKGN2IO84qwuWxw24zbYQJl
         TsRbAsHbi1/8rMGjI7JjPPkNLETEemxTbSGfCu3IQjt7BEAAo9MGcfExQCuEFlNDfoZV
         DMVQ==
X-Gm-Message-State: AOAM530S7GPzDfsaOM3fnD1sY/4Y1PN7lsp9X69EYvFApsoxNuPFhEoH
        OUiN0OR3B0/pSLUMbWtTNQ==
X-Google-Smtp-Source: ABdhPJz38Dif49kTy37ORLjuv1xqCNKcn2lg+G6Yye7xxuKfDvQRKsHgOQ2l0uv7/lVqzEUkgmnzoQ==
X-Received: by 2002:a4a:e386:: with SMTP id l6mr4859797oov.81.1619796090477;
        Fri, 30 Apr 2021 08:21:30 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v14sm767013oto.48.2021.04.30.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:21:29 -0700 (PDT)
Received: (nullmailer pid 3348575 invoked by uid 1000);
        Fri, 30 Apr 2021 15:21:28 -0000
Date:   Fri, 30 Apr 2021 10:21:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: serial: Add label property in
 serial.yaml
Message-ID: <20210430152128.GA3348522@robh.at.kernel.org>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
 <20210422085837.513-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422085837.513-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 16:58:37 +0800, Zhen Lei wrote:
> When there is more than one serial port present, the property 'label'
> allows a custom name to be used for briefly describe the usage or position
> of each serial port.
> 
> Without this "label" property, many dtbs_check warnings similar to the
> following are reported:
> arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
> serial@ffd74000: Additional properties are not allowed ('label' was unexpected)
>         From schema: Documentation/devicetree/bindings/serial/pl011.yaml
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
