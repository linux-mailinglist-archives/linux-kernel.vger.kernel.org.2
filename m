Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224B3B3844
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhFXVDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:03:46 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:33613 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFXVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:03:45 -0400
Received: by mail-il1-f177.google.com with SMTP id z1so7776222ils.0;
        Thu, 24 Jun 2021 14:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQ7uaZQ1CuEH+wcbbfLnBEPTLgmcis4Imz619rAGh+U=;
        b=LpsuYOjc/nRsb7SDXA59N2e74fMe4EN9w720TAUi8ak+WY+rxhFizYwwpSk2njh1+b
         TUexjo/g+dhJ/z7QEkSA0y6sNePKLi0sBqbFk5Jg8FETjAAVVFdFhOBTyjdsbERj1Z+h
         RKjNtQ2mQOlop6qP/Y7TYTRwTJKznYQBmFiL2Bi52Ixa5vBItBIRuJZaE8fv0gKafCQL
         dkAoCaIvU3z0JG/8N7fLz0AZm5OjVeOKS7hQ0TwHC1cWqG0xJnZw1wN04fsy2+qqGssu
         9v1RelG8oQovXNzONMXk8MkkND23/m5d6B82PAVTq6279xjdEmi6cSQ13JE/DDrZPPoJ
         yAMw==
X-Gm-Message-State: AOAM530JLac6+omttc2HqnEhPUGjcF+gKb1G7QHn/Lk69645pTpwpMPH
        2QZfJF1BIKLzJiT8yqG0/w==
X-Google-Smtp-Source: ABdhPJy/E/soZkybMhfvYG1VhBDqLMlJoworQ0f3mJTvVh9S617pX6cxt26fqxIqiUumU5/DJHdLXg==
X-Received: by 2002:a05:6e02:1b04:: with SMTP id i4mr2775962ilv.263.1624568485538;
        Thu, 24 Jun 2021 14:01:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q19sm1965224ios.11.2021.06.24.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:01:24 -0700 (PDT)
Received: (nullmailer pid 1980287 invoked by uid 1000);
        Thu, 24 Jun 2021 21:01:21 -0000
Date:   Thu, 24 Jun 2021 15:01:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, srv_heupstream@mediatek.com,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/19] clk: mediatek: Add dt-bindings of MT8192 clocks
Message-ID: <20210624210121.GA1980225@robh.at.kernel.org>
References: <20210616003643.28648-1-chun-jie.chen@mediatek.com>
 <20210616003643.28648-3-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616003643.28648-3-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 08:36:26 +0800, Chun-Jie Chen wrote:
> Add MT8192 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, pericfg and subsystem clocks.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8192-clk.h | 585 +++++++++++++++++++++++++
>  1 file changed, 585 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8192-clk.h
> 

Acked-by: Rob Herring <robh@kernel.org>
