Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E8B40C044
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhIOHNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:13:51 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50054
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234862AbhIOHNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:13:50 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8FC3E40262
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631689951;
        bh=191SUmgkCeF6ZQfCKm5T3c+lIG15mkBcbqwnFyOCstI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KkDhMzcW8X8369iUkGo5nfyP5Tn/MGOOdkiPhJZ/k9+t+9rJZKuM9a+8QdP2Yj3Cn
         qJjEuHMNsnbrQ/BqIrpAmiNNmcfesF0pC3IsK+7MZxC6w8weRuYGmYqEUUUwmW7hsS
         SsodyRCz0rMeLxJOguGQroS/nCd4oX6do/gMZzZRffQ1FJKgXdtCfBOVvu8thiemlH
         e+qky4n+rapJ4iRgk7UUKyBX1KwWkJrnBslYlX3DCA9EyLer2sjzIUW0k5qb7iG3Mt
         UnGkOqCEVdYPeIrwMorEz8YRl8UmEE6K8N3TLhkfyOOww+CGmfIFTj7TOXnOW79BN3
         b/iEpnda+7Maw==
Received: by mail-ed1-f69.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso1064324edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=191SUmgkCeF6ZQfCKm5T3c+lIG15mkBcbqwnFyOCstI=;
        b=W9lChLzYCZYQ7JrhOpqYE2CWqOMpsqhvgxcYBsRn+Ju+Se1Ej2JnEwj5QJkqf+Y/9w
         LHztWbUJOiIgti47LwiJZXhJfOnOL6kZsiJLNsb9Wu6ANvahHjc6uflk1W7S7BfxqrAs
         EuQj8gywysbEcsJIh0G+0EYz5W5tx0SEBZogKQ3H4CJ8gmwBOPdBRzgkFR/UIYGChEQ2
         5JKr4e5/pEknLHjIh2vcThc2LFu+vGRQ+VRUqtS/5c18h6teVcw+r3B/WHG9gqa4iKgv
         Zy3bmSkkWCQyAcJA4jl3ziH6oTPRszquGYll61zctb/WZhCE2aNutFjKIXi+YVVLXIB4
         5F5A==
X-Gm-Message-State: AOAM5330nf7p8UGuyn9oQpaKmbxZesvuBPS3+sopvL3KEi5kGpzTQOty
        /XjfcJ93mH0XNZ5dORGaN6jaClCb5ZGgeZF85rPwDk9tJLGenQ+tHdGPa9tBCnb+adKkQPvs3bS
        xf18j1i6WS7OmceeuOToqqxLVaiUwPV608sYdu7yXYQ==
X-Received: by 2002:a17:907:1df1:: with SMTP id og49mr23623914ejc.35.1631689950874;
        Wed, 15 Sep 2021 00:12:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5UTlhBkXQsaIUzYd+PTbm7+gO6+qavmcR/SDNB3M32OjLvLJ+G9bwfmFaihvVDi3NUULxjA==
X-Received: by 2002:a17:907:1df1:: with SMTP id og49mr23623889ejc.35.1631689950598;
        Wed, 15 Sep 2021 00:12:30 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p23sm6916478edw.94.2021.09.15.00.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 00:12:29 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] memory: gpmc-omap: "gpmc,device-width" DT property
 is optional
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh+dt@kernel.org, grygorii.strashko@ti.com, nm@ti.com,
        lokeshvutla@ti.com, nsekhar@ti.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210914122705.15421-1-rogerq@kernel.org>
 <20210914122705.15421-9-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e0c4759b-7c2d-e32c-f912-8409c1f65b49@canonical.com>
Date:   Wed, 15 Sep 2021 09:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914122705.15421-9-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 14:27, Roger Quadros wrote:
> Check for valid gpmc,device-width, nand-bus-width and bank-width
> at one place. Default to 8-bit width if none present.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/omap-gpmc.c | 41 ++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 

All the comments from v3 are still applicable because it seems you
ignored them. Please respond to them.

It's the second patch where the reviewer's comments got lost, so it
creates rather poor impression.


Best regards,
Krzysztof
