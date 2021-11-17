Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B84543C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhKQJfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:35:48 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52356
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232291AbhKQJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:35:47 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4E0833F190
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637141568;
        bh=U00dE3kWzKn8m2EQzfB0GTXUC3efymWP1c1TPkOf49E=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qq+X3VIV19ARalEahJyVoIRpgWXm7Nzccux6phk/JIYOaVZYXaLb8ui8K9r6y88AZ
         Lf9gxF0eznEYxRm4gZlf4orjVV2vy8Qk08al01PLElAxeBb8ffB82dct1Equ+fzUGi
         OY17ae0eUyJiyCSpMNOc6RB+iDEUug9GH5Mc2I+uHhvDY/kgtYr3aRFlwNvsOcaOOf
         njTVOtS+r4wg4SEWGnmxkeBI17bWn3fiHrw2JIjOuG610ptglhgo8d9jzq57Z68LAm
         vyPaRAjMPRd+tdM7UJ/fIob2gyrMgkHIJw0egTCEODuOpeEfSre+uR1QJzAQX1d27J
         hJDBgVWYxv5Uw==
Received: by mail-lf1-f70.google.com with SMTP id i1-20020a056512318100b003ffd4e89eb9so1064947lfe.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U00dE3kWzKn8m2EQzfB0GTXUC3efymWP1c1TPkOf49E=;
        b=M8uodAjQIcD2ksdt8SV7RiilmFuKbrlQCVNLeEZ1Hn8t+zWntlXD917XU3oFEWxzsO
         ho/uTg40X9ByEXisL2w0Dk5dsr9vMCF0y8vWsmj65aT91hHJZhQVeOrNbMT0boWFjRcU
         UIhrFBw2Rq6zwxNDXovzgdaYR72fk2r8XbZsffGu98Np7r0U9mH3Z0viGTyWNBbuFRKc
         CHMVhaV7Ko326zfozONa0smCtSR3N2YkxZOBknUkC/4YZTYlKzTHD5Eh8+Gfy5Unq8jY
         r+8bjKHN5ur+S7bKHqnL28u5SwR4lVLHWbCUpdTz0ErKuChxss9jL7Y6KP03zHaGqrmJ
         WwcA==
X-Gm-Message-State: AOAM5312twYrE/GMX5D9fWgUzYmi1xLTTunx3qbGoY5AYsyrRnG4xRjR
        nh0v1NCr3qrZjxW78Ut/wow0kPH/K94yofJXm61sMvb27qFWJ1vo4ge204a0Q20q0abGCUUkuyg
        yQTWlUfiepAqtna3KhHReiwj8bKGssDKxR0KgeYLrtA==
X-Received: by 2002:a05:6512:1690:: with SMTP id bu16mr13334451lfb.401.1637141567692;
        Wed, 17 Nov 2021 01:32:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCdKqd5FNdIgVi9XX0hHJu8BNrFlMoy3ea8PUMcCosFUZH6OudczR+Fx5/5gm2I3rf9adQow==
X-Received: by 2002:a05:6512:1690:: with SMTP id bu16mr13334432lfb.401.1637141567549;
        Wed, 17 Nov 2021 01:32:47 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id q6sm2057366lfa.267.2021.11.17.01.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:32:47 -0800 (PST)
Message-ID: <ab349feb-c152-14d3-1634-7a315a2dd31c@canonical.com>
Date:   Wed, 17 Nov 2021 10:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: CHANGELOG: [PATCH v1] NFC: reorganize the functions in
 nci_request
Content-Language: en-US
To:     Lin Ma <linma@zju.edu.cn>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20211115145600.8320-1-linma@zju.edu.cn>
 <60e40977.194e9f.17d241a5ad5.Coremail.linma@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <60e40977.194e9f.17d241a5ad5.Coremail.linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2021 15:57, Lin Ma wrote:
> Hi there,
> 
> Compared to the version-0 patch, this patch add fixes tag in the patch file
> 
> + Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")

Changelog goes either as cover letter (git help format-patch) or after
'---' separator to individual patch.

Best regards,
Krzysztof
