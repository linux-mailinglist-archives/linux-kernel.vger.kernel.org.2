Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07DA429F36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhJLIFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:05:48 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38106
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234605AbhJLICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:02:05 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 69DD94000F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634025603;
        bh=hBrz3d48tADwfYA1612WiB9zqVKpvctbB3dnSpc4Xb0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=M1m5YH2PHDss0EolpAvX5VNt3pOB4qqQrqSViCRfOiyRE569tOP15L7nXEMvVAHXT
         i2Op9S37RITsj7T0+vTTmUE4pe7PsVh9krH1cxS5w4ra0CL0EpWuEokkfD7U13hk7D
         toMxdrt/Fon8KuwU1sEI4HJN3z1kXyCRDXyhLr+yh6BOJM8U+p/owJlkPlfWBAF1HX
         4akQH9NUMJJ8MhnvoME95+Z7s9h8G4Wr50X0LZdH9LUysiHTvSHZPhczXgKOKIEwsi
         V2hOxh4SwGuhg4NN1s6T23Lgr2bfIukkgwdxvTu84K7ao5oQJv24yOloNOulGwDdGd
         bdMHvnrF+Cn9g==
Received: by mail-lf1-f70.google.com with SMTP id z29-20020a195e5d000000b003fd437f0e07so11631698lfi.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hBrz3d48tADwfYA1612WiB9zqVKpvctbB3dnSpc4Xb0=;
        b=R4CRsnTu/BwkSDlSKXN9xifzve6pNPK7IW/faxijkW9sj/Wuv0JM6HgMbFtTZLy+8N
         6ylqPUhrEMtL8V+Pbg9v02nikl9hJ5diGup6qmhMYYkY+/2cuGAXWsWSkCL9doaIkRtI
         NFqL+1K+SJXrO/LYcgHD7utJCL+ykXdopSFhAX2VIug1BPveKDczkjIO2GFdb1DVEy0M
         mZKA6fuWgD9iJKZb/423BYzhQdZwt+6V4L9t4FdzzIlGclkoYczOjy8J+EWAEJMTDfY/
         /gC5GV7m323xJ+crUvGypMJ0W44IQ9tw9uwJBXS4you8V31X3Nqa8DwQO9dzVv6OYWH0
         lSdQ==
X-Gm-Message-State: AOAM532rS/C5k4OROzDoQUuy48YZjAUal2vefrnqpbn4OfP/y+nV3ky/
        fI7PN1Z1RTlMJ/lHnzZKE19uwalRIYZ5tt5fqHrD+aoeEfYdX0PEw5HgUo+TL2IIn1Nm+HWX6Hr
        Vx+7XXi4xNG/YgUI5qLuBJJ5rMgQu/yqY0ThIkfJQlQ==
X-Received: by 2002:a05:651c:2107:: with SMTP id a7mr4289777ljq.435.1634025602655;
        Tue, 12 Oct 2021 01:00:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPWuB7xZejGvGoSHNc+pR0sgYDO4D/b6k6sRsaN/JCW3ZD61V1rHVy6Fm0FnYRBX+eqjpQhw==
X-Received: by 2002:a05:651c:2107:: with SMTP id a7mr4289717ljq.435.1634025602121;
        Tue, 12 Oct 2021 01:00:02 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h25sm92122ljg.24.2021.10.12.01.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:00:01 -0700 (PDT)
Subject: Re: [PATCH 1/8] mfd: max77686: Correct tab-based alignment of
 register addresses
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
References: <20211011155615.257529-1-luca@lucaceresoli.net>
 <20211011155615.257529-2-luca@lucaceresoli.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <025684b7-fc91-65f7-c50a-44ed7ad81cfc@canonical.com>
Date:   Tue, 12 Oct 2021 10:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011155615.257529-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 17:56, Luca Ceresoli wrote:
> Some lines have an extra tab, remove them for proper visual alignment as
> present on the rest of this file.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  include/linux/mfd/max77686-private.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
