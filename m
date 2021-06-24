Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F193B383A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhFXVAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:00:01 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:33770 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXU77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:59:59 -0400
Received: by mail-io1-f43.google.com with SMTP id a6so10040017ioe.0;
        Thu, 24 Jun 2021 13:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0G//iXfmLjHJhdeWozxCE+pBIDu3xsRQjXHcxBVgZT4=;
        b=o4JKFmJso+EM0OOs47qWt2Iul5tz1m1h/yZfdi3qcwvt40iNS8IjcR0WftwdL/Fsxn
         SZL92ZUrcJwRhWg6zbNlYiMhVjsrR8U0gIAoCF7yXzxEQNUyV52q2GexKoCtE3xP/O3/
         BMDp01tBvgbjIQ+/RRijvVneX5QeacRkqrc9XhTnYQ3tOs3fenOlom+3IflVSCGKCL+J
         eIkgC/us+2un1fMRqYGfPOkkBqksm/xESrj3V60/cnlE0DRu9M3AKUqoAjdNGmIHU+lA
         /JTBwv5dyQ480EgFEsJws3MM4/JnivRzVdmjIsN3Eryo/H48BassPv8nIR33hkii+wzv
         IvRg==
X-Gm-Message-State: AOAM531YhwDLOrgEmVbGeaqVKK1fWbWPskb5Mdc6AEmJMRVHsy2GeaZd
        /SGDvTpswWJEfeTBCd0GDQ==
X-Google-Smtp-Source: ABdhPJw2ZAUafe7foiqb04xU050uSi3YrSk7ZfH4ImmNIn0Puw0JTpem16JMUE5HpUpQPQgQyLWxhA==
X-Received: by 2002:a6b:b74a:: with SMTP id h71mr4092370iof.58.1624568259321;
        Thu, 24 Jun 2021 13:57:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u14sm2404901iln.43.2021.06.24.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:57:38 -0700 (PDT)
Received: (nullmailer pid 1975209 invoked by uid 1000);
        Thu, 24 Jun 2021 20:57:35 -0000
Date:   Thu, 24 Jun 2021 14:57:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/4] dt-bindings: power: Add MT8195 power
 domains
Message-ID: <20210624205735.GA1975175@robh.at.kernel.org>
References: <20210616000659.28347-1-chun-jie.chen@mediatek.com>
 <20210616000659.28347-3-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616000659.28347-3-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 08:06:56 +0800, Chun-Jie Chen wrote:
> Add power domains dt-bindings for MT8195.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      |  2 +
>  include/dt-bindings/power/mt8195-power.h      | 51 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8195-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
