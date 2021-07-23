Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89583D34AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhGWFrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 01:47:14 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:52438
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234059AbhGWFrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 01:47:09 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 006183F343
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 06:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627021663;
        bh=ScM5eUXjBnVPe8LbBTYSW47mZlMEZMzsEaWNVZaNkWQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=jtwpKgCHgeeIwVDNX0/2tHKzGo3qN1ydck+/aEU3kBG7b4d1W9/f2NpamD2MeLH2f
         HOdZq8uvkaI29zJ8IvlmGblL4sZ0CTmrKnjcwbk6oKp4u61oqxWdB4idDx/3NTSqCy
         kFh31fua1tb64882x5MfyjA5ewOzUM6E0YUPLhCDWFzRBqyvHSzJsFkq9tei7ZP3hV
         M7X+CPm86aoiOHR3PyZnqpWwJnzQTuoYa2hTqQyZk/cSTxwl94G4QGhOXvTZM4kRmW
         jqGsnS/nhasHPRVvL2QUYOvsuRKIWfVCJYlPKgpM1PrcBmxGlYrZZgsvR6UEQF2TQ5
         AjqcsAa1K7QIA==
Received: by mail-ed1-f72.google.com with SMTP id p7-20020aa7c8870000b02903a1187e547cso252280eds.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 23:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ScM5eUXjBnVPe8LbBTYSW47mZlMEZMzsEaWNVZaNkWQ=;
        b=GuhD4CHgBKr55k8WxtGVCXTGvCaRfXJ+B2294EsDkuORDbogg0E6yCBRBzPMhzVm+Z
         iVWyXsXVju8oHNXvoDMXgiKP4F+TjkFmpBHdE7WbPirFF9zXd5+GRR0CWO+KfC6omhE0
         RrYp6Mn1pTUJSoh0IE+fT2CgUTHhsLlVJVUGYKj/EzzOVXMkGEVXKwNxXLWuTKGvdi8q
         9q7OCWNOwEDrhjhkyuSaL+QvRNLI0lL0OQCH0jOvsR5kGjO62DZbvHS6PSRDMXdxlIqy
         JVmVgtZPvRST6v5ru8NAdQzlFMgpSauRlraHbeStTD6puD72m2ym/I4UrtCQ9UBCRFm0
         +cOA==
X-Gm-Message-State: AOAM533bo5lpIHWysVI0yHOAOhNhYp2q+lPHjceyDj2zv9uPuC9b9lYw
        blc4XDJ7qYvc7zrRE9PmrM0eoBrzgvYA+rSlCecOTn8exM9B3b9+cIDvM2xT3LLkZwrhl3umBCZ
        fiZcyZ65ZiYg4bJHN1kcH/iCn/9ePUJ/F346JjEUYuA==
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr3313194eji.501.1627021662758;
        Thu, 22 Jul 2021 23:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ+nyDEENcrVRLwr6YxB1sHYJA1zCxcGsDlpGPB37Ly4NJOfWs4Dn45abWgrRNkKKGjwgnGw==
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr3313181eji.501.1627021662625;
        Thu, 22 Jul 2021 23:27:42 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id u5sm13449844edv.64.2021.07.22.23.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 23:27:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 00/15] Fix some DT binding references at next-20210722
Date:   Fri, 23 Jul 2021 08:27:18 +0200
Message-Id: <162702163038.6229.12663832282139727924.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 11:59:57 +0200, Mauro Carvalho Chehab wrote:
> Due to DT schema conversion to yaml, several references to dt-bindings got
> broken.
> 
> Update them.
> 
> Mauro Carvalho Chehab (15):
>   dt-bindings: mtd: update mtd-physmap.yaml reference
>   dt-bindings: firmware: update arm,scpi.yaml reference
>   dt-bindings: net: dsa: sja1105: update nxp,sja1105.yaml reference
>   MAINTAINERS: update mtd-physmap.yaml reference
>   MAINTAINERS: update arm,vic.yaml reference
>   MAINTAINERS: update aspeed,i2c.yaml reference
>   MAINTAINERS: update faraday,ftrtc010.yaml reference
>   MAINTAINERS: update fsl,fec.yaml reference
>   MAINTAINERS: update mtd-physmap.yaml reference
>   MAINTAINERS: update ti,am654-hbmc.yaml reference
>   MAINTAINERS: update ti,sci.yaml reference
>   MAINTAINERS: update gpio-zynq.yaml reference
>   MAINTAINERS: update arm,pl353-smc.yaml reference
>   MAINTAINERS: update intel,ixp46x-rng.yaml reference
>   MAINTAINERS: update nxp,imx8-jpeg.yaml reference
> 
> [...]

Applied, thanks!

[13/15] MAINTAINERS: update arm,pl353-smc.yaml reference
        commit: e460a86aab669e00c5952a7643665f3096fbfe27

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
