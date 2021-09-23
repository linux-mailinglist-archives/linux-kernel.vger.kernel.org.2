Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C29416743
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbhIWVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:15:34 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34727 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbhIWVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:15:33 -0400
Received: by mail-ot1-f46.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so4705427otb.1;
        Thu, 23 Sep 2021 14:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kbi5k+hCR33pq4czUKvnN/c+ugsujAK/U/x8PpVPl7U=;
        b=A/5lqOxgAaD2sj7GgdqSIn2xUzSlJiNWc00hvs34w6XEKf97PXwxCfxde1AgefPDo1
         DAe1TxvZ6kZICYO073A3d5eIO+vHPEO+rVOYoGrW8CSnw6KBlq77rrMcAuOBG19Sen0l
         b++vKORnJ7TwvJ9wLm4hNFs2hp8d6PEpgdMJkc+rJ4yo/sZTktFCZXtOhXIwyoGyu83S
         TlzU49N3C8r69XILhFoKl4OmOAouBJrnFloCGmmdpVTDPtxuUyOpogG6A1PXgUQzEPDS
         tWEdOytDyIggwNVze/bLj3aoec8MCHU5XPpgOw0GDlgKY2SG6cqRo62nrvoumqZGiKGt
         WJow==
X-Gm-Message-State: AOAM531QxvQsMvxMfmrFQobEPGf/Wpsh1Twrk77VLoFeEO4XkOLBu9jg
        JpdGNr7T7xo0qmMRJSHx1g==
X-Google-Smtp-Source: ABdhPJxXb/QuUT+++jtIgY8DPfRqXYYTHoW9BZH8sYazb9NZYS+R4C1Yy6GC7ZMW6x13wlN9i3PgCg==
X-Received: by 2002:a05:6830:25d1:: with SMTP id d17mr725034otu.253.1632431641378;
        Thu, 23 Sep 2021 14:14:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z18sm1671173oib.27.2021.09.23.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:14:00 -0700 (PDT)
Received: (nullmailer pid 3534757 invoked by uid 1000);
        Thu, 23 Sep 2021 21:14:00 -0000
Date:   Thu, 23 Sep 2021 16:14:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jiri Kosina <trivial@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: hwmon: dps650ab: move to trivial devices
Message-ID: <YUzuGDUhK9VS6QaK@robh.at.kernel.org>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:21:11 +0200, Krzysztof Kozlowski wrote:
> The dps650ab bindings are trivial, so it can be integrated into trivial
> devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/hwmon/dps650ab.txt  | 11 -----------
>  .../devicetree/bindings/trivial-devices.yaml          |  2 ++
>  2 files changed, 2 insertions(+), 11 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/dps650ab.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
