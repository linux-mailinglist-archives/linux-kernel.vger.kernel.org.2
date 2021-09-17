Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5976340F5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbhIQK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:27:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50824
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242513AbhIQK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:27:27 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 67E2E40292
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631874365;
        bh=8xFjOQjsybxTtmGMn0wgUVOa+AmiVWfySpCKVPXRktU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Yd5aJu6UzChdCGpgDNtEjK4QJcUOTfYaB9TaHCZC1LYVrmueBDi/t5J4nDkEZHTwS
         hiYrlrlPgD1dNZe0iK6OSqvE3BkGhxCLEE+wUoqQ50/GidoOjVPsY3RrLChxYy96Rh
         ntr+Etsv5jivzIyF6tLMnKqLyphwTuGJ/y5hoGKz1vEPtynXCbtSHtfnZYlvbr02Se
         9ZORR+d9kEWCNGRxALDPrZvfbeI+XqmLeRskK5W1IUl4XYHjI/L7hZkhMb62fQpj9e
         s/0LNcYBrgfGJWcQneNI1Sqih3RYHUzmwJgPc4HY5fLlw82ZjotfAGIIJg+0EpLkRC
         M1MJD4aPas7bg==
Received: by mail-wr1-f69.google.com with SMTP id x7-20020a5d6507000000b0015dada209b1so3540919wru.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xFjOQjsybxTtmGMn0wgUVOa+AmiVWfySpCKVPXRktU=;
        b=nAXH90s4AjuBl8NdcYwp9BWZPi4ZsPuhRPdenFnzE+lp+YUJL+HYEJDTZv64i11Hcb
         /coFectc0LVW/FDvcG4DEmi9HcMgNASFTL3qbLY1UKFSFeEjtdw8C898nC7aWQ6cPg5Q
         GvU8CWv7MLixPdNzPp55Mr6g3X+VkyiHR2QvLx/7OARKqBEdMrcq3f9Em6K1JlAStp2f
         tgfaIXSl08t4VoPqfD2i4Lzj886bGcdmE3YD6DmW9jk88gvY8VBmYv78MifZSStUsGS/
         iPK4Ad5StrlT2VhGAceCYAXGEOFI0WAZGnwQL51VZI6YTS+GSHYCSuQoDCrxb94/7PW3
         joXA==
X-Gm-Message-State: AOAM532cwKKVuA7z7O8GD3RRTDX6Eb9a2ugvSVSrRtPWnppYKD+17TBN
        JHlt+FKF/xiXp1HRw23IJR6x7lNGRJyz1z5cfSTlFVy0MPU6bB0YZp1+gSSjKtJV6Q5DxYS6CB0
        p8k0+pX3nzQMje2lj9mEjkazsh/STOymY7rq6PclcjQ==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr10871343wrn.365.1631874364840;
        Fri, 17 Sep 2021 03:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfepug51avkiz4OhQdZPN9jvxt8XC8Q+2K9BJb+3BCNRVYF19wNVMcgPMNLNeAEZYbGrzI2A==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr10871321wrn.365.1631874364663;
        Fri, 17 Sep 2021 03:26:04 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id j14sm6301457wrp.21.2021.09.17.03.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 03:26:04 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: zd1211rw: Move Daniel Drake to credits
To:     Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, zd1211-devs@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Drake <drake@endlessos.org>, Daniel Drake <dsd@laptop.org>
References: <20210917093236.21424-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <67ba3a01-e327-c4ba-1a3b-46aba7ccb2b4@canonical.com>
Date:   Fri, 17 Sep 2021 12:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917093236.21424-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2021 11:32, Krzysztof Kozlowski wrote:
> Daniel Drake's @gentoo.org email bounces (is listed as retired Gentoo
> developer) and there was no activity from him regarding zd1211rw driver.
> 
> Cc: Daniel Drake <drake@endlessos.org>
> Cc: Daniel Drake <dsd@laptop.org>

This email also does not work and it is in MAINTAINERS, so I'll send a v2.


Best regards,
Krzysztof
