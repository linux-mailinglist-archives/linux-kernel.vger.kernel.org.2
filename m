Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B708B3A9B07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhFPMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhFPMw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:52:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:50:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so2398851otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9EeUX2UsPaCBEnAKSjR99hjgC77Z+OizHQhkbZcMkqw=;
        b=LE+ZfMrJkutKA1SU9/ZQsE22a3ilajA+T7eIQIu6PqnEe+ituJSy7XEKuxTWY44z5I
         fIVSteoEGeOk35eaUL0sXUSnLvxlkjs/ywW5xJwgLqTqL9JopLcihafwwnsx+vXjzR4y
         OywK6VLthqddMp634Fj4+Xjkfg/lNkWLTwS1REHpaAwiIj/WDcHiHVUXENXg3VWMp32S
         LdT2sXNK3z9hIIePuHFpygt4cP+pCZfd27eNrVK21oI6lxp25fZtQbma96qvnwEpBu9k
         Adr9BQ96SDiMyii1IE3uhwJ8AdH4BU7H1Rtui46q0fXSTUaXEFczp7mSgpJWAjjWQepC
         dfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9EeUX2UsPaCBEnAKSjR99hjgC77Z+OizHQhkbZcMkqw=;
        b=m/lgnezeyaNOkVexTXgVYmyuuP8w60qIDg7im3TgK4ZKhGVERcX3NmHm5bWZd3vZCv
         TaFEsTdfiy7oHTqBUQ1ahWB2cXnySJpcHgjGjYme5GzY78d/+DgdV6ORJuYfMNGVSVIF
         YkFFo6bQCWt1Q9DLPLEwJGJkH7p8r+6d9WjYMd2c6TmjKxIpgZo121nvs5DT6DEwpIj9
         eoUzy+LpRn608Wb7DOmYDXlBdo6fdzRTT4SzWMTwD6yH0j9OM0Sn/FCscSC3yoDsf3TL
         m7J6EL1t95Bf4YloXd1FLuicsjIAd9zZFKdvcpGxm00U9ro77Lm4Lbexyx2wNAmycs3O
         RV2w==
X-Gm-Message-State: AOAM532hW/Wh/nVqnizZXCsPqGJgw+EP5lNHf4uq+VJ56TUobrbIcZ50
        Vq5Ql5S5GUKprG5A0LANo/kVlfkk/W2clg==
X-Google-Smtp-Source: ABdhPJw2MSjcGm08Xx2Mx/PBazpPm+5j6gpvsVQRpa4iq3Izh655EVDvEEEY/JIyZYNzBfC0ILY5dw==
X-Received: by 2002:a05:6830:1e99:: with SMTP id n25mr3874549otr.279.1623847850728;
        Wed, 16 Jun 2021 05:50:50 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id c188sm465013ooc.29.2021.06.16.05.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:50:50 -0700 (PDT)
Subject: Re: [PATCH 00/11] Rid W=1 warnings from ATA
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <463f14c8-c597-2b29-88ff-2929df55acdd@kernel.dk>
Date:   Wed, 16 Jun 2021 06:50:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 3:04 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Queued up for 5.14, thanks.

-- 
Jens Axboe

