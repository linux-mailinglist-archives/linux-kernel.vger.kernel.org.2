Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6541CEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbhI2WEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:04:52 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36479 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347035AbhI2WEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:43 -0400
Received: by mail-ot1-f44.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so4770015otx.3;
        Wed, 29 Sep 2021 15:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcUYa1rhgvpl8VdHADUZYNm6UstnV1HeTo+qppWEyug=;
        b=bfhdxLLJfkifOQ8ohDtPJ472npePhVKIxUSGauF5YlcCyUTBS0eOaYh/MvxEjknCRT
         mMhbmCxwXwhQG2EY2cadjcPNXyy392IM1hWTGNCTXufNnYcufy1WwjcstoKxliiQZ4LU
         SYHOCxFZw+oPuSicowhiddK1vvaSqL5pj0AUwuk07ZLbkN0sVFq38DECfjHSVdjpBPFQ
         C7NWhv//pu/vOxZbEgkvxZ6mjXBKIoI+AmMh4Tz+Zo98+pS69ybMzCptFDcgwlRutgPi
         bfRUGHLXzKVzegUIVH8oIaCAJepeCnqeHcItFVp8BZ9lFzWMR7tz/PywAH1QPUFVIdfc
         5FNw==
X-Gm-Message-State: AOAM531XtITbBQDgcWat+SJBI5t9eNVrfrlj9+Simm1shVTdrTW92JDz
        CDjZASVdJvLmhenOxamDeg==
X-Google-Smtp-Source: ABdhPJwQDOagZBRoi522zoziMq1VzMOqfIKxn1VI4w493zMZ5pqhJf7meCiZxSI/vfoTJIF3QFV01A==
X-Received: by 2002:a05:6830:1d3:: with SMTP id r19mr2092898ota.136.1632952981336;
        Wed, 29 Sep 2021 15:03:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q25sm210326oof.33.2021.09.29.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:03:00 -0700 (PDT)
Received: (nullmailer pid 298763 invoked by uid 1000);
        Wed, 29 Sep 2021 22:02:59 -0000
Date:   Wed, 29 Sep 2021 17:02:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, andrew@aj.id.au,
        linux-aspeed@lists.ozlabs.org, osk@google.com,
        linux-kernel@vger.kernel.org, joel@jms.id.au
Subject: Re: [PATCH v7 2/5] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
Message-ID: <YVTik08lNtDRGn0L@robh.at.kernel.org>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927023053.6728-3-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 10:30:50 +0800, Chia-Wei Wang wrote:
> Convert the bindings of Aspeed LPC from text file into YAML schema.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 188 ++++++++++++++++++
>  2 files changed, 188 insertions(+), 157 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 

Applied, thanks!
