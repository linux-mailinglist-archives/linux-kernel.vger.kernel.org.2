Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBE400302
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbhICQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:14:04 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36795 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349763AbhICQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:14:02 -0400
Received: by mail-ot1-f42.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso7140494otv.3;
        Fri, 03 Sep 2021 09:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyBG+O0faZILcpfc2Nap4pRYLyuKC1OS4QzlPAPNwe8=;
        b=jLZmH9+eYY08JYcsJT4978Qr9NAP5r8uPog+SzUxeMUvnb7ZjG4EYtuzSrZD6eOrW/
         dXVf5zCnpeUi7dfDQdZnFhMwyRsRjSkU+M8I1JEXlrJSo8DKXx8RQ5FFJjZAI+JdK3RU
         wOIuxOzYGbJMyMHrj8INtDRXaKHZOHdijIh+EHPD0bnINXuSp/H/R9QSGHRfzw8hVyEV
         eVz7VMZLxGvWV/g+4wTmhnbDKZ0nd97+uxVEVM2dFWnv+K/+872WA1xFtemR1RMhRWiY
         g0PO5WaHPlfKpLRgC+yHH6/px+8Ez+AlidHbvxgHwiwIWsqk2PEAjwLGTlr4M2FPLjfK
         QWbQ==
X-Gm-Message-State: AOAM532ZsZRGYkfUQIu74gTlOKbSzsacJqII+Biun3T0qr6KB0IwkiVE
        gIjv/oTf12PTwW7vJ3Ypzg==
X-Google-Smtp-Source: ABdhPJxywJtBMAHkLKamqXPUIuQW64oaBOckS+nVxGRrAEtS4vXg4CG3vx5b30edXeBm4+N5z0B7NQ==
X-Received: by 2002:a9d:7299:: with SMTP id t25mr3830425otj.232.1630685582363;
        Fri, 03 Sep 2021 09:13:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f25sm1036421otp.2.2021.09.03.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:13:01 -0700 (PDT)
Received: (nullmailer pid 3033358 invoked by uid 1000);
        Fri, 03 Sep 2021 16:13:00 -0000
Date:   Fri, 3 Sep 2021 11:13:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: amlogic: add bindings for
 Jethub D1/H1
Message-ID: <YTJJjAQkjYv1bKDX@robh.at.kernel.org>
References: <20210903060035.844758-1-adeep@lexina.in>
 <20210903060035.844758-2-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903060035.844758-2-adeep@lexina.in>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2021 09:00:33 +0300, Vyacheslav Bocharov wrote:
> Add bindings for JetHome JetHub D1/H1
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
