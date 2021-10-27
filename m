Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2673343CE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbhJ0QAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbhJ0QAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:00:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6B6C061570;
        Wed, 27 Oct 2021 08:57:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id g125so4028495oif.9;
        Wed, 27 Oct 2021 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dxynhEMbGhH8bakXHN2eBc3v6f3eXpZp1CSVWQj8nQ=;
        b=Vc0OyPsiHmvKoSTAbp4h57bwIVjz7VQnleqWPoRwEjmnXq97GuUrhsF2DU9VcU0SBc
         rks+coc6hZe8TYiDg/cPyp8tuJP+Xu2nRlUmPkW2MfY5eKic/6dL+hHL4XrdDejeNp7p
         q6YgCjUHvOlJH2iFAOv/NZN7pSx5k3cJrw2KyIqZcAYkpqehGBRsztDeIVXlEmqN7Wz1
         EgMYkv6G+9fMDLkrNGbdlO53M7qC8svpbYK2B+LZG7QdeGWrKQJyXiF9KaehYFUST3yI
         xSehO5AkoTJZqWfv3A6yR238vrJT7PorqXTJQOgPHZs2QFraaRcOr8/hSyJCslzdjYz0
         W7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dxynhEMbGhH8bakXHN2eBc3v6f3eXpZp1CSVWQj8nQ=;
        b=1Mqki2TYX0pnDCOQzwwnap4ej6RgQMk9BkS6RiEiCBVfag3GuHDZMdjHRD74tCq4tu
         7UPzsuc+fnxe6USSl9GXKRiTfzk6g3ihIUVyxtObmoRa/IvLIPg5N/MRrCf3KgK2lvxF
         MfOAn5nZutmpN5fgHAoDJjh9L7kLPrkWJs2+edjO6wVyafdX/XIv1vVBsa0wNRTvwYKd
         qpN2n6ZM7chiOPuFqnYBGJptKFEu9sg630FnDpH5nag2cWk8ftqJ79IsOpUJW4+3hmzd
         xiBp9wUDxkSFbI9GARcCNxBJgekvsNpW86QO6aGmXfJGxkiy3GFutzZZAhecvWdvQo/s
         oJow==
X-Gm-Message-State: AOAM531KMfaDlgkDPsw6K6sxcr2WSR5ojze0wq6ej/9vTU12tFdTY6hY
        EXfUnZaARcRWFTyI34fUbvc=
X-Google-Smtp-Source: ABdhPJz0qdGn99PZv7zT0ySOHhnU/ZzokPfz57cDqDpYqJgqsbE4udzDHr0lIhEicE32Xz+aKGFR1w==
X-Received: by 2002:aca:f20a:: with SMTP id q10mr4262257oih.176.1635350273848;
        Wed, 27 Oct 2021 08:57:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k7sm84026oiw.58.2021.10.27.08.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 08:57:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 0/3] Driver for TI INA238 I2C Power Monitor
To:     Nathan Rossi <nathan@nathanrossi.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211025025805.618566-0-nathan@nathanrossi.com>
 <20211027074212.690611-0-nathan@nathanrossi.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1bdae73-79ee-de4f-963f-b238d953a6ce@roeck-us.net>
Date:   Wed, 27 Oct 2021 08:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027074212.690611-0-nathan@nathanrossi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 12:42 AM, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Changes in v2:
> - Added device tree binding for ti,shunt-gain to specify the target
>    ADCRANGE for the ina238
> - Reworked ina238 driver to use hwmon_chip_info API, and addressed
>    various review comments
> 
> Nathan Rossi (3):
>    dt-bindings: hwmon: ti,ina2xx: Document ti,ina238 compatible string
>    dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain property
>    hwmon: Driver for Texas Instruments INA238
> 
>   .../devicetree/bindings/hwmon/ti,ina2xx.yaml  |   7 +
>   Documentation/hwmon/ina238.rst                |  56 ++
>   Documentation/hwmon/index.rst                 |   1 +
>   drivers/hwmon/Kconfig                         |  12 +
>   drivers/hwmon/Makefile                        |   1 +
>   drivers/hwmon/ina238.c                        | 672 ++++++++++++++++++
>   6 files changed, 749 insertions(+)
>   create mode 100644 Documentation/hwmon/ina238.rst
>   create mode 100644 drivers/hwmon/ina238.c
> ---
> 2.33.0
> 
General comment: Please never send a patch series as reply to a previous one.

Guenter
