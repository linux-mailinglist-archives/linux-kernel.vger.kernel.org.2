Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B704A372BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEDOHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:07:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44996 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhEDOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:07:52 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldvhQ-0002oF-GS
        for linux-kernel@vger.kernel.org; Tue, 04 May 2021 14:06:56 +0000
Received: by mail-qt1-f200.google.com with SMTP id 69-20020aed304b0000b02901c6d87aed7fso3356644qte.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWRKnXNV3uSJXPmlESo2Co1jPOLNUzmS9oTXfFMPzXM=;
        b=PlC7588UfZvIjY59fLVhfVyPgpItHlZmCkWxv+58jRhZbf0jj6vXIjPgtFF5NCrwdK
         4q+sifj3M4wwtKkvRvlfmIKLgE8qD0+z9ekScrYhr6tD47mq+IW/qpkFcu6lz9OcOEBw
         /SOSmCnTiv8EZKC9BBo4+fbox0ZOjNR3FKlDB6eUmXMGVNBx1ACGOxycMs23fv3TDMhf
         3/Wx/U5f8FM41RLQ2kn8l9tBaGpQpPkuTol7ltS2CLkimygxteor06yvksCqyi3hJz7c
         5k2f3WTKvkjrdrvuzHPZIdHRFitcnMo0rWN5x5NDbddCA81d4PjL5Hq8GQzU88qD26Wc
         icoQ==
X-Gm-Message-State: AOAM530E0nswNHhmI0ocY93lPoj4jcccBdQSKHyzUc20CJgrYJh2WgcI
        BgQSEeo0mXkZ/ZsX/BQ0p7EvHNT7Zyj4Wei/lwBe8Pev7ruAvtAMdDIGfmqaHknmamXdB4Ysiq4
        TEvQmFX25uLq+cPdXeR9Ip9kPEGJIKn/P/S5gzZV5fw==
X-Received: by 2002:ac8:6909:: with SMTP id e9mr7938523qtr.338.1620137215670;
        Tue, 04 May 2021 07:06:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBl2lpQtJv39myBZ40HvWie+tqvi5BvCcJraN3Zh9gti5+dUGNf0zUyQrCLYwdSO1IMEJgOw==
X-Received: by 2002:ac8:6909:: with SMTP id e9mr7938507qtr.338.1620137215510;
        Tue, 04 May 2021 07:06:55 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.3])
        by smtp.gmail.com with ESMTPSA id u18sm10988533qku.39.2021.05.04.07.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:06:54 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Enable MediaTek DRAMC common
 driver
To:     Po-Kai Chi <pk.chi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        CC Hwang <cc.hwang@mediatek.com>
References: <1618565538-6972-1-git-send-email-pk.chi@mediatek.com>
 <1618565538-6972-5-git-send-email-pk.chi@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <73ba4443-c0b7-e6e1-0faa-a41d2f552146@canonical.com>
Date:   Tue, 4 May 2021 10:06:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618565538-6972-5-git-send-email-pk.chi@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 05:32, Po-Kai Chi wrote:
> This commit enables MediaTek DRAMC common driver to be built
> as a module by default for the ARM64 builds.

Don't write "This commit".
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L89

Please read entire doc above.

Best regards,
Krzysztof
