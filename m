Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6323E06A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhHDRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhHDRTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:19:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EAC0613D5;
        Wed,  4 Aug 2021 10:19:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d8so3079833wrm.4;
        Wed, 04 Aug 2021 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O9SItd3XY405dHzvkc9GDc7qBcgktuPcRH3jW9NDsus=;
        b=a7X1e0HiSjvwjVXzD8OJgN8F0pq+uSvbd+ug23nvL7Qfj0KIXJ/DxQL515BzoQxjtM
         KGmGjJSfj6+nMw32lREnSJK8vXnQ9A91vVIBFmYSYmV0Za2GThvhHLls+jxcF2d5JS9a
         D71ajMPeqbB1ahf6ZufXJaCChi4HEmCI6l88zujyjQLiLUvhXDzWEA20E+16DTiZTqW7
         aNW8MvxX0FjUdEx3ZM4SnM361m6RD9Ymnq+nEzsucSJ79IUQKeh/Pjkqutm7pBV+YqGC
         n0E3S2kjkjR4d+DMrfaaTjPcFTHDm2cE0vTQft6TsfSY7lsWHFkJMnZ48JwLI1Pd7Jit
         +blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O9SItd3XY405dHzvkc9GDc7qBcgktuPcRH3jW9NDsus=;
        b=D5+Wuw9PJd9j7NG/r305uQbp2UfwLlze+wkqFJbaitLE6+oaLwt1C4CNDcFM2OkOM+
         qPckQf/yEJgNGgHW5mZwyYjDObAhqnRCjYa0fTPRoaSucuxqf8WeCdqNfpNUEOk6xuFY
         q7GexoiJXe91Rufb5pJYU1OuBJdKphmA/+0SJXqQBdt3acUm/OmJrAcWqaxn0lyaGf1E
         nbf+GuCaUPm/ApEjeYqtFLZh4kk2GW2t7p5SzJWFkPpS1oQxEnSK0ghksYe3g615Eb0F
         DY7IdKpROah+Y895+Fab7iNjyoPvf2OvyltyMfxWaJPAEBWjKB1iodTQFRiKOLRrg9cA
         2FUw==
X-Gm-Message-State: AOAM5301kBb4up10KbkZyxLDgd+/BhfWgCTXEuG7t8niOFvUXYc/o3uo
        x6pGAPaB17Ho9uggp3HVYVNbwXbTl/guBQ==
X-Google-Smtp-Source: ABdhPJy1Ufwahx5HIvCTUwg/AGqU6WYCwDXtjONKbsOazi/UN4zk+Nv/cBLQovbRWSrw19JuGoZPAQ==
X-Received: by 2002:adf:f710:: with SMTP id r16mr470460wrp.124.1628097580131;
        Wed, 04 Aug 2021 10:19:40 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id w18sm3537191wrg.68.2021.08.04.10.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 10:19:39 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] arm64: dts: mt8183: kukui: Use aliases to mmc
 nodes
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210728040710.2891955-1-hsinyi@chromium.org>
 <CAGXv+5EVcSyfG1Fk6PZOnWUZo85brf_cneW7iob4Z5gnjFca7Q@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fb0d8da4-6d0f-b10b-a207-af234d47b171@gmail.com>
Date:   Wed, 4 Aug 2021 19:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGXv+5EVcSyfG1Fk6PZOnWUZo85brf_cneW7iob4Z5gnjFca7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2021 11:58, Chen-Yu Tsai wrote:
> On Wed, Jul 28, 2021 at 12:07 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> With commit 1796164fac7e ("dt-bindings: mmc: document alias support"),
>> a way to specify fixed index numbers was provided. This patch use aliases
>> to mmc nodes so the partition name for eMMC and SD card will be consistent
>> across boots.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>> v3->v4: change commit message based on review in v3.
> 
> Thanks for following up. My reviewed-by is still valid for both patches.
> 

Sorry for the confusion on this series. I now took this version into
v5.14-next/dts64

Thanks
