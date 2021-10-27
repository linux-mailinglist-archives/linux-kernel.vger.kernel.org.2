Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1843D2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhJ0UbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbhJ0UbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:31:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7FC061570;
        Wed, 27 Oct 2021 13:28:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u21so8705670lff.8;
        Wed, 27 Oct 2021 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=+Tm+JRBtA+6iGY9mamwWy8jFcnaR0g3Jdp4nqWpW8Tg=;
        b=jmry35JIhA2X1OrQCyY8v/cpooPwSe8y6IUkuxsGaO6EexlwQ8S3UA1ZZv0IQOdRIo
         uydwO3iyk95Bg7mejbMljjSWxGtRa4NClWV5pGVdpTcRXofRFqNxdsx85fVcT2k47zbo
         eo1ckvP7d0fTb8f4Av/BMuf5PMpe2ePbmsmI8Fs+6YmYXmWtr5d6AG/qv874VAGtVOSP
         4QStRvqu4WzMPAliYVEgO7hu/lvRUMrmtGpD3D7w2G8dChf2Xq46eGlv04LhV0/ERYPm
         VNexs2A3wAEZGzmbnd4zQusfbe35lnMW++wqAEEo/rORqMmELj41+TDnujLyWfSGJ2nf
         lTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+Tm+JRBtA+6iGY9mamwWy8jFcnaR0g3Jdp4nqWpW8Tg=;
        b=47yVLgDNDjaVcvRdOe4Zn+vggkASeHfpiyaBpgH7bBe5BhUcQjd5+y4UqWYB+Ze+2C
         ibdEDaxkz/G6AnvIsyawZnrWePaavRJPDZJAmNIe+gEK2/VzoPGXjnA6OnMiZFyV8mv3
         AgB1I8vSQ7kutjT/KLwpw8f64rSfWuwjDFtOyZoNwClR82kw3raNE7SqzhVqjYtLRGMc
         1JxkAtry9rmHHRktJl2I4S7B0sH61C0PY8uqipNp7Qjiz//7HzROr3IKybodRr4HPZ/T
         JF4xIPaoL0/dBMezi2yYH00Ujh7nucM4fJVHks3+QO6V3dYg0h9KCWAOSttTMPQg3NhM
         GJPw==
X-Gm-Message-State: AOAM530jWEPNcMYMfsaaL9feE7OjihTRnXo2G4xeMdT5RF67oMfWYP1p
        ekrRuTZsbqNo5ZS+e7HFiiY=
X-Google-Smtp-Source: ABdhPJxTdlfb7OTESzXsPyYRJ1jrji0RcpcYc9WCcEORD8h/pt8juakCXT7Ap+kDfTS5/bwei8/ISg==
X-Received: by 2002:a05:6512:1591:: with SMTP id bp17mr24653796lfb.362.1635366515659;
        Wed, 27 Oct 2021 13:28:35 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id e8sm93439lfr.215.2021.10.27.13.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 13:28:35 -0700 (PDT)
Message-ID: <f18b283f-67b2-6847-036b-e27cc5a327db@gmail.com>
Date:   Wed, 27 Oct 2021 22:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:94.0) Gecko/20100101
 Thunderbird/94.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix I2C controller interrupt
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     chunkeey@gmail.com, mnhagan88@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211027193730.3941945-1-f.fainelli@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20211027193730.3941945-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2021 21:37, Florian Fainelli wrote:
> The I2C interrupt controller line is off by 32 because the datasheet
> describes interrupt inputs into the GIC which are for Shared Peripheral
> Interrupts and are starting at offset 32. The ARM GIC binding expects
> the SPI interrupts to be numbered from 0 relative to the SPI base.
> 
> Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for fixing that. I don't have any device utilzing I2C and so
never notice that issue.
