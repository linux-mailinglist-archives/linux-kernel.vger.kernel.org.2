Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE26F4128E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhITWd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 18:33:56 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43700 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbhITWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:31:47 -0400
Received: by mail-ot1-f46.google.com with SMTP id x10-20020a056830408a00b004f26cead745so25700468ott.10;
        Mon, 20 Sep 2021 15:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FCmNHtt11QLhSvmcLvs+zJc97YSOXkXRIB2hIvlHIs=;
        b=61grYxdBjIGcUaFXEFBX4hDGXb8RLShFuIBTusuonc8zrPJTE9bEzKBx8edwyEXUfP
         5cFaNbyJ+viX3tXKOBHfHcM8uXtz3MtD4UaALMDk8ZflOIK5KUJkSqRWPmA4+lDVMOUD
         rhfN8n4VhCeUlYMUn9SpHWLn2d1RAU2zGGDctzOxzV78iHmKzBukuBRrOpcwNJzaZap9
         it9wNba2XYjY9KcmxRKW4dzbRMIf5MzVBRQS8LtAFoXVUALvUXzdQpQEzbEE8ZGqKaom
         Xn3/Jh6Gk0hFZMb7eqD/2oyxzDjdGVTUUpJ99yYPrEFy1hBUZrDI5MyxdSBM5Vt/8TaF
         inuA==
X-Gm-Message-State: AOAM530s+xNMZefU1/2B1v+tRWUc7BF8Fn4mwbghuFPBvX9Gvsm6gP49
        bgm0u+zCdWG2wWnIa56Y4qYJaJ61xw==
X-Google-Smtp-Source: ABdhPJycZrI/QFeDTsrcWnT2z08c9jZQ4XXTbR5wI4O9KMU9KzoF0bMQ1Q22QmcRRJGdaUkvVLXHnA==
X-Received: by 2002:a9d:601a:: with SMTP id h26mr3947732otj.326.1632177020062;
        Mon, 20 Sep 2021 15:30:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 186sm3719698ood.39.2021.09.20.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:30:19 -0700 (PDT)
Received: (nullmailer pid 916414 invoked by uid 1000);
        Mon, 20 Sep 2021 22:30:18 -0000
Date:   Mon, 20 Sep 2021 17:30:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: panel: ilitek,ili9341: Fix the
 warning-wrong indentation: expected 10 but found 8 (indentation)
Message-ID: <YUkLehSRd0eFlV2t@robh.at.kernel.org>
References: <20210908030215.112-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908030215.112-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 11:02:14AM +0800, Cai Huoqing wrote:
> Fix indentation for the warning-
> wrong indentation: expected 10 but found 8 (indentation)
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9341.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already have a similar patch queued up.

Rob
