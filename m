Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2EF38BBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhEUBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:51:34 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39648 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhEUBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:51:32 -0400
Received: by mail-ot1-f54.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so16664446otc.6;
        Thu, 20 May 2021 18:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZu2oAAxpPszth+cdRs9YhSMHNjRhOXxb6YW8VoRug4=;
        b=jJRiFz8yBI8dhh3meo44u4n0mywDgw5Ah7dP7g789RCZwNStXUVpYGnFhNxyg8b3J5
         gNgP6wktZGWLIPaFFuWpaHE0zgyK7pLnmtj30GmEvMMCt+7nEu0G4q1xKiTjtvqHN3Gn
         5ifwJIkLnK/grAVBt1A2U1UFHen02bBvizmppN9XQ6aMR0dbWXVtOfF97cqSJctfmJVX
         LNOP9aujzu1l7qgA7wc9JZOCf5knNacHEHrJXBcW40vTOhp7C1eEhKtEJKJyN9qUxCEY
         umV4RrOajs4SZUraEFF3FKYPU20JaZ01w9nn4G8Gc+o5DbmE6E2jfOBPTzW6c7QqXe7J
         8rHA==
X-Gm-Message-State: AOAM532vHkgYXqxIuWBSfbR0kp4i7Z8eB6QWvQg5kgqXPC1MQxxiVdEN
        PfgKGP83EyS8/M11Laz/xg==
X-Google-Smtp-Source: ABdhPJx3UWsDTpRkWnxh8VgBc2KRjPGHgHRS1pKtUlFQSUh/thlOVZUpiOfXySl4QlVq4E/6EKqTPA==
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr6156037otf.343.1621561808976;
        Thu, 20 May 2021 18:50:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i18sm905395oot.48.2021.05.20.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:50:07 -0700 (PDT)
Received: (nullmailer pid 2480084 invoked by uid 1000);
        Fri, 21 May 2021 01:50:06 -0000
Date:   Thu, 20 May 2021 20:50:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, mkorpershoek@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: mmsys: add MT8365 SoC
 binding
Message-ID: <20210521015006.GA2479999@robh.at.kernel.org>
References: <20210519161847.3747352-1-fparent@baylibre.com>
 <20210519161847.3747352-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519161847.3747352-2-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 18:18:45 +0200, Fabien Parent wrote:
> Add the MMSYS binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
