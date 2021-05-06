Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B41375C42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhEFUc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:32:27 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40657 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhEFUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:32:26 -0400
Received: by mail-ot1-f50.google.com with SMTP id c28-20020a9d615c0000b02902dde7c8833eso1093315otk.7;
        Thu, 06 May 2021 13:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUvqv8wXTvOxaH/qGGyIwECUCA5kcL3mhfS8xu2uPHk=;
        b=ru+UgilFUd4jf5JILoRlHiotfpuVbcR83SHvsZUuMJL5M4mb+Ak+jN9eUyH7Spqw8f
         Y4R8Z4JwpXw6S4EakE+mKbRXLe8o9RbS5c3cKJYpT4pGcFTNp9qo7UHm066fwKRuSUcl
         3ozfuqXT3yotaCSKcHyB39HOH1aMIDpYHwHhMNJ9po8psTW0rVtes1fl/HFugxBJlnTZ
         HDzXCYRs90i9xP+elHPnRwiXoDUVXM4tt9dwH2g3n7eHI0fiPaDMYuK6/ypcxOi/cedO
         hqL5ABVCvfi5xvrWAQWvv7dTYJIFjDI+eqIOOpUo9e6GtgenJdWgyKzeg2pPayQwUj+u
         hRhA==
X-Gm-Message-State: AOAM532AXbqjnLSdm/fAd0pqJ1DuYr1iUTBfw9hjZwX9ssr/JS4Tqa3K
        DlIPC6S86hiZFnaDyGVvEw==
X-Google-Smtp-Source: ABdhPJz8lMGGpHHpxe8oPwoIyPVl8lU7WK/RGmlZ6n9ATJy0QvSseGQje+V/PuhA52UcWZiIbXhI8g==
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr5272913otq.146.1620333087184;
        Thu, 06 May 2021 13:31:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i9sm771288otr.19.2021.05.06.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:31:25 -0700 (PDT)
Received: (nullmailer pid 753794 invoked by uid 1000);
        Thu, 06 May 2021 20:31:24 -0000
Date:   Thu, 6 May 2021 15:31:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mediatek: Add optional mediatek,
 gce-events property
Message-ID: <20210506203124.GA753747@robh.at.kernel.org>
References: <20210504054612.3585017-1-hsinyi@chromium.org>
 <20210504054612.3585017-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504054612.3585017-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 May 2021 13:46:12 +0800, Hsin-Yi Wang wrote:
> This property is used by gce clients.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2->v3: move definition to Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
