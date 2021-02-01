Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9730A486
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhBAJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhBAJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:40:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEFEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:39:45 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bl23so23271341ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ml9CmCDCZ1A5+J5cabQlM6Ecws0N9gFakvuKWo4Lb00=;
        b=IKl/edvjf2zb+DRSP798cSaBU6+K2ELIcQnGaw1eH+EGM+ajUyX53X+JZq0Dsty674
         09oDixqXZW/vyTTn1KyDU9nMwOyCXsBKc3ZQd+Cbcdldp4ZDN1CqSxYmedRIUu5nFNsh
         qZzAwP5XuPnlPK6qnXJrOLPvYAzkLIFIjf7wy4pzF9c3tVL6QFDEknybCQQ5lEpH7Y/+
         2QHkRF1WJeP/GCwRKxmcIEj6ldtRL1eTpCM8DnUEuMBaedJEbIrI5ZT4GFpdTvA4OVr9
         gXNo8l67ZXNXnnJg0iCeHOgxW2opwBkD8t1RmK0XRuHQRb6Gfc+Wy8AI0gl/+VZfnsXk
         areg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ml9CmCDCZ1A5+J5cabQlM6Ecws0N9gFakvuKWo4Lb00=;
        b=uWFjgSr11niMr1MQ5WZ8fSyQNyvqekvwLVworGuPjjWiwDcEFsPlS8XTSPLqXdZdOy
         ZTBBtj+i4tywFoxaYfoiLAOOSjmZGNYsferYTUmSDuPWO9joKhVKfXc1NewcanG+NRtD
         WtgICHzYO61KOX+jXcRUqZnCWv2irhlJsnumUlCayBpSCX5clH97NAxyn7DauRtqhSZW
         4ymvoJ/PZeNClAco+uAmME4KbYc/nwDe5vgftlWyXRBT7VuYi4lYzwFBKseACew+oo9F
         6c7mpTockEnoSEtkbRfPLl0aUwBYL62RXxRxVBV0zGi0praebJ4bz3TlcsyYcllB3csG
         Za7g==
X-Gm-Message-State: AOAM53142x+E2POMk/nYncYDUitn8qZjiWOZ+nfvAlA5mqhNFYvH6gAk
        XEpx72JJMjoLTCDD5zcELB+HLnlUYY/zvsAE
X-Google-Smtp-Source: ABdhPJytXHJHx14eIbmDgU7+Vf7pdCKDBOXecwQpgq5mCOZRz0eeiXBpGmuEvQkr0cgtFb71W1CAAg==
X-Received: by 2002:a17:906:a082:: with SMTP id q2mr16935292ejy.483.1612172384255;
        Mon, 01 Feb 2021 01:39:44 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z13sm8391563edc.73.2021.02.01.01.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 01:39:43 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: arm: Fix typo in zcu111 board
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <13d064fc4850f96904a04e330cea5295d3751e46.1611226560.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <135ea840-6b7c-ac34-4c99-3b946c87171f@monstr.eu>
Date:   Mon, 1 Feb 2021 10:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <13d064fc4850f96904a04e330cea5295d3751e46.1611226560.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 11:56 AM, Michal Simek wrote:
> Trivial fix.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/xilinx.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
> index ae0ef1bf7965..97e77b4e077c 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
> @@ -108,7 +108,7 @@ properties:
>          items:
>            - enum:
>                - xlnx,zynqmp-zcu111-revA
> -              - xlnx,zynqmp-zcu11-rev1.0
> +              - xlnx,zynqmp-zcu111-rev1.0
>            - const: xlnx,zynqmp-zcu111
>            - const: xlnx,zynqmp
>  
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

