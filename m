Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D583B38BB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhEUBYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:24:36 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:45929 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbhEUBYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:24:34 -0400
Received: by mail-oo1-f42.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so4225117oop.12;
        Thu, 20 May 2021 18:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekiZGcLed8B4gTX2pb+xiPeN7uCqCplJV8t+ebNDowY=;
        b=B3bxVADVLAD/qEZxHTZBNKfpWECkKMo26sn4HiSRKKnecUSUidUXhzE0cJ/xg3MgI4
         Vbc0rGuaCfTkXgRRqdxXTvjbLLFQB9p1Yi88d9NzER7lUzgBj//FIqAxmm+RSiTDK+cD
         +I7Y6OKYigIi8eu9xHTu4ThPtSeKwkEyylXLts7zY9VBvW2O4GGz0NjNz3GRbKAOcwj4
         wcy6cr9e28fmZWn8m5waKNSA0f9TgSJoxWvCAiZblgUgUg0w0nFVGxsSwbVgJe/xhS81
         cDtywKXXY6AFQcr6pf/FOejyMlc19BNK8PTbLZbOCk8I9jWc5Lnz0SdD1AvxUKXzIV/f
         i4Eg==
X-Gm-Message-State: AOAM5329U4pZ6VdlJVYgmjivL4Gf8rHtaRaVldoQPhlK3jhD7ObkSS62
        QNZbKPBZu3LBoPht1yV57GFz683yow==
X-Google-Smtp-Source: ABdhPJwl3EcJA1xRqel2NqsJoORpmfrt6ZJ4oObPLOuahNm83i4cpPG+n0QVNV8VUNUGJroPY1395A==
X-Received: by 2002:a4a:8e04:: with SMTP id q4mr5930808ook.28.1621560191370;
        Thu, 20 May 2021 18:23:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm1020806otm.1.2021.05.20.18.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:23:10 -0700 (PDT)
Received: (nullmailer pid 2429966 invoked by uid 1000);
        Fri, 21 May 2021 01:23:09 -0000
Date:   Thu, 20 May 2021 20:23:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, cy_huang@richtek.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] regulator: rt6160: Add DT binding document for
 Richtek RT6160
Message-ID: <20210521012309.GA2429905@robh.at.kernel.org>
References: <1621406639-29911-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621406639-29911-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 14:43:58 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add DT binding document for Richtek RT6160 voltage regulator.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v3
> - Move all regulator related properties to the upper node.
> 
> since v2
> - Move buckboost node from patternProperties to Properties.
> ---
>  .../regulator/richtek,rt6160-regulator.yaml        | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6160-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
