Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4032F622
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCEWxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:53:44 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34368 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhCEWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:53:28 -0500
Received: by mail-ot1-f46.google.com with SMTP id h10so3418482otm.1;
        Fri, 05 Mar 2021 14:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SESkgwxE34Ue5+G0A5styguJRyIcPh+9gdfTTFKIFHY=;
        b=aG2heN0V1l1WhtrEVL744RcKDBA8PXSeEqBdtR4HpWj6pyuxASpIYicNr6g6uA/Tdt
         ZqZEN+0K1mShavbcrHWAQWjiuvyKfPfgE2QO+gsIyiQ5+qMeyoaSo08C8bSrrNw1i4zT
         xwTgxtxHvbFRbkv9hBkoy66EApLlTxjtV+g1lxBERvbImCmERrwqUsEEVd+ElzvwxadF
         DNayluB2mKbUwdarhmprAqH7CaNCt0ZEzF+5MZXaFTDpPaq6sZInwQYdGHkwyaoLR0JB
         EQTEz+ix6Sq0cGlk6T6Rlf2bY5Lj9UeMiJEJktwud3JywIfD/g/fuVf4q5xsgtmg51K3
         Pb2g==
X-Gm-Message-State: AOAM531mi1IMBOFTtPtNz+mtqUlCNXH7TdkF0bdgrzj/EvtT2JXtfIZY
        n5kMLm+4ywvsgIjb7sfLmg==
X-Google-Smtp-Source: ABdhPJyVykejdFl6XfYolY739GKlcY0uorRLymeoLSfVK9GC0j1KIWN7PP+gUB7F7XRgTDNwEWD3yA==
X-Received: by 2002:a9d:6381:: with SMTP id w1mr9858830otk.236.1614984806984;
        Fri, 05 Mar 2021 14:53:26 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r22sm884761otg.4.2021.03.05.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:53:26 -0800 (PST)
Received: (nullmailer pid 791447 invoked by uid 1000);
        Fri, 05 Mar 2021 22:53:25 -0000
Date:   Fri, 5 Mar 2021 16:53:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, Sam Ravnborg <sam@ravnborg.org>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: display/panel: add Jenson JT60248-01
Message-ID: <20210305225325.GA791397@robh.at.kernel.org>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
 <20210218225458.823773-3-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218225458.823773-3-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 23:54:50 +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Add DT binding for "jenson,jt60248-01".
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
