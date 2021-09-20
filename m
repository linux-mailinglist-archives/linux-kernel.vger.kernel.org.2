Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25554129B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 02:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbhIUACO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 20:02:14 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44561 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243065AbhIUAAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:00:13 -0400
Received: by mail-ot1-f44.google.com with SMTP id y63-20020a9d22c5000000b005453f95356cso19012479ota.11;
        Mon, 20 Sep 2021 16:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2qRVnruSB2TFCSYAMmGjsNtaIJ1bkDf12KbnNYANX3Y=;
        b=Opi5es/ovFRZmMrEie1DT1276nd5pTr4WkWD0Ie9rJXyb9e5oKaz/lXIkAPUYDYGaX
         HTLGv0oh5hJf6Hw+LHvub7rFXrxk0389/gPyfh+bxhBN/QA6mtPp5rf/DOWcR71g0vAL
         Q2OP5Poh7g4Tge9uFaKGBIRkNMDxWOaw9WMxrOqcPxOReBSZqUcvwxBvQ2pNDzRxhs6Y
         eaJBaEsYcOJ9NdTGt99yl8tlo6rEHaSNB/u9PCpY5CX4dICSHP06q/fyzpjNiWP2Daxt
         dcLwzqrh9Az4HvpvLGd69aUxHct4vlKqKNXMQiBM+4fRTd37QpDcqy7HCeFJQrWhWsLj
         Ju0g==
X-Gm-Message-State: AOAM533kbtFDb9r3QXPl14+w0mPL91dakENaSCIob+4lytNkY8zxD8Mc
        GYOI2l5QcY9IpH4vmOHIhtwB2GU4Ow==
X-Google-Smtp-Source: ABdhPJycjqZyHv1rMFoY1v7ri33VuwBNWPPh79EAwqf46g1yab1Sfb0my5pQS1W1hildjrG+ThgymA==
X-Received: by 2002:a9d:6c08:: with SMTP id f8mr22430777otq.368.1632182325628;
        Mon, 20 Sep 2021 16:58:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o8sm3423848oiw.55.2021.09.20.16.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:58:45 -0700 (PDT)
Received: (nullmailer pid 1073419 invoked by uid 1000);
        Mon, 20 Sep 2021 23:58:44 -0000
Date:   Mon, 20 Sep 2021 18:58:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>,
        Daniel Palmer <daniel@0x0f.com>, Joel Stanley <joel@jms.id.au>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: Add vendor prefix for Airoha
Message-ID: <YUkgNFyK66BQiSJh@robh.at.kernel.org>
References: <20210908141606.136792-1-bert@biot.com>
 <20210908141606.136792-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908141606.136792-2-bert@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 16:16:02 +0200, Bert Vermeulen wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add vendor prefix "airoha" for Airoha.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
