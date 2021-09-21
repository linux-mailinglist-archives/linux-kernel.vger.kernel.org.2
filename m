Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1495D413D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhIUWH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:07:26 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41652 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhIUWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:07:23 -0400
Received: by mail-ot1-f54.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso566061ota.8;
        Tue, 21 Sep 2021 15:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+0BIaFq4Mufw+X4fwjiZnjy2FpSNbaPobDYC/KM1Is=;
        b=w21f7JDctkCRAQxB32HtlS+1fK3vvG3aFIJnpqezJnOy5RZDTOtnLvs/I8oLcMlj+5
         HG1AwbFyQjiw5h17iUAPrIUXfVv/mveeUSWHeKuts8nEida5vd/Q7kLffCLEHPEa/gbk
         djEKxx3pUjNIiNbk+DfqrtFZyEtxWlno9Ktx0uoV60v9xX+aD2rv1jl80cQ/1mh8UymA
         FOEqDw78/6EDm4wQkinCwdrK+Zd6fpQoOkffeEppbixcCE5ESLy7kU9KJQBQmfZvM+Ig
         lAlTpk05g46dByHLORbLjvkbZVvO+6Hkc7FY7ZrsVigSPVkEaV961NDZgjgtFNI/QQg6
         DUUA==
X-Gm-Message-State: AOAM530YBv4/d6OlvHoPjF8gEnU0GPYnnZO5d8hsIXyBSGL91hr3e7Sv
        hQ8fytXamt9Celj0Rqkr81hx9Qj2JA==
X-Google-Smtp-Source: ABdhPJwKDcKaJILJ1PXGaD/2XKWWnaSZ32BAg/HfHXwC6LLJTAk4Ytxo36oo6DoC3Fp/YcwgJr7jRg==
X-Received: by 2002:a05:6830:788:: with SMTP id w8mr29151985ots.235.1632261954474;
        Tue, 21 Sep 2021 15:05:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q31sm57076otv.57.2021.09.21.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:05:53 -0700 (PDT)
Received: (nullmailer pid 3381606 invoked by uid 1000);
        Tue, 21 Sep 2021 22:05:51 -0000
Date:   Tue, 21 Sep 2021 17:05:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     kenchappa.demakkanavar@intel.com
Cc:     furong.zhou@intel.com, dinguyen@kernel.org,
        kris.pan@linux.intel.com, mgross@linux.intel.com, will@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        kris.pan@intel.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.gross@intel.com
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: Add Thunder Bay bindings
Message-ID: <YUpXP3vdxHwaMIX9@robh.at.kernel.org>
References: <1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com>
 <1631771898-18702-3-git-send-email-kenchappa.demakkanavar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631771898-18702-3-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 11:28:17 +0530, kenchappa.demakkanavar@intel.com wrote:
> From: "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>
> 
> Document Intel Movidius SoC code-named Thunder Bay, along with the
> Thunder Bay Full and Prime configuration board.
> 
> Add maintainers for the new Intel Movidius SoC code-named Thunder Bay.
> 
> Signed-off-by: Kris, Pan <kris.pan@intel.com>
> Signed-off-by: Kenchappa, Demakkanavar <kenchappa.demakkanavar@intel.com>
> ---
>  .../devicetree/bindings/arm/intel,thunderbay.yaml  | 27 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
