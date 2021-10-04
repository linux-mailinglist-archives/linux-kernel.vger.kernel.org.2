Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9274213CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhJDQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:16:28 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33383 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhJDQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:16:26 -0400
Received: by mail-ot1-f50.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so22264998otu.0;
        Mon, 04 Oct 2021 09:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3A9kDO62df66o5V6wztLbMAFTyD6iLg3mg5kD8T/+U=;
        b=BpeiLB9Q6kRYnPsz0GMCdWeWK+NX8L3077RlgmY4c35oloKqurcgPvLGyc0K7yY2Bx
         FuQJMX2pR+1qrPOd+jo5zaSrdNn/4ZQRONRm1yzN0C/D6TtcfkJxEDsBelmdulRljXqK
         tBpv8nkADqxIfXi3nCBzK4D2MOANL/40yRua1hpzq5J+Xv6FnRg9HsBCt7k7uiRvOpVo
         j8rkL5HbOWWacsmqmKfLFBjug8vEtPb/7fXMT01FnUsqznKOYRcNBdXiZFBoLObXd0Vd
         pNF2O3S4It3b013MPReGd7F+TBfMA+iSn7baqdP3TG8IwTECBDcP9aRgNamGPPZrSYdT
         BYFA==
X-Gm-Message-State: AOAM532qv4+Sl4tbzBjvtluB5HQEPp7R54QZTPfciUxR7RcmDMihuRyR
        oh3dL7ZAkqsyX+neli2qJQ==
X-Google-Smtp-Source: ABdhPJzFCfw1cO30AAGISrklnvpVNV7BZbzXQJ+GR6IcdHbNIhE1dgcRofXa4lBZyhIxjPMGREtWOA==
X-Received: by 2002:a9d:a4d:: with SMTP id 71mr10225871otg.249.1633364077480;
        Mon, 04 Oct 2021 09:14:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s13sm1141697oou.11.2021.10.04.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:14:36 -0700 (PDT)
Received: (nullmailer pid 1399101 invoked by uid 1000);
        Mon, 04 Oct 2021 16:14:36 -0000
Date:   Mon, 4 Oct 2021 11:14:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8952: convert to
 dtschema
Message-ID: <YVsobH4PWaDWWWB9@robh.at.kernel.org>
References: <20210930140327.196232-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930140327.196232-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 16:03:27 +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim MAX8952 regulator to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/regulator/max8952.txt |  52 ---------
>  .../bindings/regulator/maxim,max8952.yaml     | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max8952.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8952.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
