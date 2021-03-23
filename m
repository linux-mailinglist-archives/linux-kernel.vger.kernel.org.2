Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08B346D81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhCWWq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:46:28 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:42867 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbhCWWqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:46:21 -0400
Received: by mail-il1-f177.google.com with SMTP id l5so19681153ilv.9;
        Tue, 23 Mar 2021 15:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/wR0YgOktInMZuZoZR56NBPkknGa+dooOPGBNWO9aVg=;
        b=JdHbV5p+6RetdEly46qkRFonfD8k/BIfV/GoxgY6BqcPOfqAc7ZemMTS6cL6gkHpws
         ahGoHHHoSvEe0wvC2HuqV3y9KxISg93HlidM9BMOkrjfpIvRlY6eD4L+iwRgQqImdiYL
         SuFkwRYgai4azXmfFh0TEyYiTTkBZ9NDSzh1pI72QfmserfeaqBNwOZQRonfM3zLnga2
         XbO/537lwY6bh9fL63oFf/Ifxlz6bZQU6g+fZ2X/BpzaYfbTydEryXoKeJUAcficqIV3
         pYKFWcylB/a2ZPA2cFxn7nJaIOqFgeQHzKIyeDRMqxvTRrJrztdFUjhYbTvYa+SH91Ww
         bYdw==
X-Gm-Message-State: AOAM533Jlq9m9vcqD+WYP1DRqK2DqVuF0ZJZ/uNcaGgUfpAUf4JOwpog
        qVFrcbjxyPigDtowrxZ4G3SKnJddLw==
X-Google-Smtp-Source: ABdhPJwGUdvYAubFEadv/LIEVgcEiGjjG3eq6vdtBuJIomuWBdYeHvNSXUOJMkEj84DxNQFQ3QBcUw==
X-Received: by 2002:a92:dc83:: with SMTP id c3mr376598iln.167.1616539581110;
        Tue, 23 Mar 2021 15:46:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g16sm128361iln.29.2021.03.23.15.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:46:20 -0700 (PDT)
Received: (nullmailer pid 1489100 invoked by uid 1000);
        Tue, 23 Mar 2021 22:46:18 -0000
Date:   Tue, 23 Mar 2021 16:46:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        leo.yan@linaro.org, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 13/19] dts: bindings: Document device tree bindings
 for ETE
Message-ID: <20210323224618.GA1489048@robh.at.kernel.org>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-14-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323120647.454211-14-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 12:06:41 +0000, Suzuki K Poulose wrote:
> Document the device tree bindings for Embedded Trace Extensions.
> ETE can be connected to legacy coresight components and thus
> could optionally contain a connection graph as described by
> the CoreSight bindings.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v4:
>  - Fix the out-ports definition (Rob Herring)
> ---
>  .../devicetree/bindings/arm/ete.yaml          | 75 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
