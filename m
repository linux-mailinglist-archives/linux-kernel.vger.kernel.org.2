Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C769361432
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhDOVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:35:31 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41836 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhDOVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:35:27 -0400
Received: by mail-oi1-f177.google.com with SMTP id x77so16385797oix.8;
        Thu, 15 Apr 2021 14:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Asvzb0ia0dGBFg5FN7dkJb6ITWlVzfHX4herAcXmiN0=;
        b=UI6KhScERwY3adScsFRXyrGIvxVwwQY0DEzXLwyjpSBL3i7710VP/jeQ9yZ9IO6G3Z
         YjjDioN3rVdNVLt79kBX0CmAcXMS5DmwQJ4mbrUrP1FV87blwWR4Q36c7Z/8dKtK6GDV
         B4h4x+XiB+IMTI6olRFhwc7tOi9jCbGqOFkoPL1vG+0fXzPFSo6xR901TpxC32eKA+o4
         Ux0XHIxNVPbZFQaWaIwgz06Z4H5unSN9AGh9QCRSCvz1IfMCjElcZ+o3t60PDtIhkcDN
         PjGCm9YZ7FA1eNKbDcPvBxqwAKz8Tj0oRbC2BiCM8kZt5Ies2LxZQbF6Sz6kJD2fNvtL
         vyVw==
X-Gm-Message-State: AOAM530xsVhVhUi21pegJLLWYRnp482LFtalC1ttcRENgt8z+7AoSQEI
        zZBqoaYKuw+TO8H2SJFnqQ==
X-Google-Smtp-Source: ABdhPJySpPVmPa7OMbCSsc8k8IgXoTck3ue2WMssm95d0TcMlmT1x68Zjwv+DiFVIuR+2RggSeEnsw==
X-Received: by 2002:aca:fc54:: with SMTP id a81mr4017423oii.80.1618522503378;
        Thu, 15 Apr 2021 14:35:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h25sm783202oou.44.2021.04.15.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:35:02 -0700 (PDT)
Received: (nullmailer pid 1921204 invoked by uid 1000);
        Thu, 15 Apr 2021 21:35:02 -0000
Date:   Thu, 15 Apr 2021 16:35:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, lokeshvutla@ti.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2] dt-bindings: mailbox: ti, message-manager: Convert to
 json schema
Message-ID: <20210415213502.GA1921174@robh.at.kernel.org>
References: <20210415141909.3013-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415141909.3013-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 09:19:09 -0500, Nishanth Menon wrote:
> Convert the ti,message-manager to yaml for better checks and documentation.
> Differences being mostly in the examples:
> - I've dropped the example usage of mailbox client, it is better done in
>   tisci node definition
> - included header in example for buildable example
> 
> NOTE: The following checkpatch warning is generated since we do include
> the header in the example, but this is a false positive warning.
>   WARNING: DT binding docs and includes should be a separate patch. See:
>   Documentation/devicetree/bindings/submitting-patches.rst
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since v1:
>  - Fixed title in yaml (not driver)
>  - Commit message update to fix up a copy paste error (not secure-proxy).
>  - Subject line rewording to indicate json schema rather than yaml -
>    more inline with patches elsewhere.
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20210414002721.23638-1-nm@ti.com/
>  .../bindings/mailbox/ti,message-manager.txt   | 50 -------------
>  .../bindings/mailbox/ti,message-manager.yaml  | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
