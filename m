Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5B42F435
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhJONvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:51:35 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41638 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhJONv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:51:29 -0400
Received: by mail-ot1-f51.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so12895755ote.8;
        Fri, 15 Oct 2021 06:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Emypu18e0IXK8TFQk7ooPj168yx7xW+uYOA6VkCV8JE=;
        b=o8IjwzNbf6PeJNkfWKPvK54nZeK3FTte3f1DAnOmdcfKDHOixFO8+NG5TDl5cLPIPU
         XHIpLVm8Cfbb9AeGkfC+yry9WS4O5LOEhYGvb1vhx0y2E5T5ZztEOcu1IiZYRJEzaOyL
         kGLjLkLhs6CyqXHuF/iJSQ00ag9UU/XV9yNzz5xq559+lEju+GOyKe6lKzRq67KTmbcb
         nCZqidTwWZgXpGH947wbix3vfbxbICPG6jlXwX3jIz/j92YKvl4JfcuWmvt7LcJTV1ix
         EZahlR+KTj1qyGRJiWnF7thk/yQ+iP9OpWizmtDdFJXy3tPFMtjCKeVavr3LmB2Xjbsd
         jX3g==
X-Gm-Message-State: AOAM533rVlBAavSwc8skg+O/bRHRqgV/AaPmEu+Zd9h+AhuIDCo0wRlE
        neXro+C7wMgNh5MQF+cBMTwaAvO9og==
X-Google-Smtp-Source: ABdhPJxUclsuv2sYJlz+mVj3QUqsf0dR1i3duEqsYs1RlI/V8CQynEpT+T1LpMNFTS8H1xYbHJ7fjQ==
X-Received: by 2002:a9d:19e3:: with SMTP id k90mr7958187otk.99.1634305762209;
        Fri, 15 Oct 2021 06:49:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p14sm967286oov.0.2021.10.15.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:49:21 -0700 (PDT)
Received: (nullmailer pid 1423603 invoked by uid 1000);
        Fri, 15 Oct 2021 13:49:20 -0000
Date:   Fri, 15 Oct 2021 08:49:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@linux.ie, seanpaul@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: display/bridge: ptn3460: Convert to YAML
 binding
Message-ID: <YWmG4KddWr4lo6kY@robh.at.kernel.org>
References: <20211007075822.62411-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007075822.62411-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021 09:58:22 +0200, AngeloGioacchino Del Regno wrote:
> Convert the NXP PTN3460 eDP to LVDS bridge documentation to YAML.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/display/bridge/nxp,ptn3460.yaml  | 106 ++++++++++++++++++
>  .../bindings/display/bridge/ptn3460.txt       |  39 -------
>  2 files changed, 106 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/ptn3460.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
