Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E442166E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbhJDSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:30:05 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40634 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbhJDSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:30:04 -0400
Received: by mail-ot1-f41.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so22752589otq.7;
        Mon, 04 Oct 2021 11:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vNjiYkRNjz5lXd1Q8xBRkNIS/zy9kwynR0rykuEziC8=;
        b=AdQqNMAWBqklWao7Lt9+L0Zi3PLHpMhohje8QganTwVjng5UYA8Kv5shiBmqTEZaOb
         Uj1qYPib++q5P6tuYDQegTCEeb79UU55FUqBDdTIXhD6Hg6/9ZBN0p/WgEyV/tJCEmVW
         1yYLGst8FdcEfP9R0sRxeh6kjC+XGYPZaMDf/0vepcTnCFyKIPiYH5Vdc1SEdXJH3rGG
         qPbCP20yEgvWqdLCp/ioSS9Jwpg1Yux9Mfl9s3Q7fayy22FoqWd+NWsy9etT23oP9sTf
         +txrwsRRZcANLw02cktdIZpUjWxRo99mgxf1SotEWjXPPhSTkCuJXh/T5Bal/+1PMJOI
         H0XA==
X-Gm-Message-State: AOAM532NmRmCrHL3uk/EbKgNNJ72A/m/bwmyGCeTeeuKe/7/IhcWYyut
        5g5Hd7yfg1NjY79bErJ1V+VSetQjSg==
X-Google-Smtp-Source: ABdhPJwApm4fnizB89yUK3e7WkldXIJbmmT7gNDLc5Ra8hwvImTtl9c+pjlvaQxqIYs5aWXNwxGXgg==
X-Received: by 2002:a9d:764c:: with SMTP id o12mr11205729otl.129.1633372094994;
        Mon, 04 Oct 2021 11:28:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a6sm3145341otj.42.2021.10.04.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:28:14 -0700 (PDT)
Received: (nullmailer pid 1611586 invoked by uid 1000);
        Mon, 04 Oct 2021 18:28:13 -0000
Date:   Mon, 4 Oct 2021 13:28:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 8/8] dt-bindings: hwmon/pmbus: Add ti,lm25066
 power-management IC
Message-ID: <YVtHvZZd0JdLT9rV@robh.at.kernel.org>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-9-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-9-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 02:22:42 -0700, Zev Weiss wrote:
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/hwmon/pmbus/ti,lm25066.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
