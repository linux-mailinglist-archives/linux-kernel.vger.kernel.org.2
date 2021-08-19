Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4A3F1DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhHSQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:22:26 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:55188
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhHSQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:22:24 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 884F9411C4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629390107;
        bh=+cZtuR9o2k87pvi0rgBoRi8/bFI7YeJU/qox3v5ZI5U=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=TnGoL60l6+xHV2u2QYgrhlcDga3uUlfW3nSfJY4N0dFtvmlPq0DIy+BdXKWGqr76w
         sfkXI3ySjRtABEQ4fGDJWXxK2AItk+1i2rnn7jEPhzBevRw15eyPUXMTRytZoTfEg5
         +Sx3W00FyMkZGEju+29T60AW27x+m2keMkDyQCBsH9KdG6cOr5EEa8yeeCSyKlI3Jw
         m9Cmra8DxF2aAyZCJdrU7Je+c/eWkjOHYrOgzNrlsWwV63MFmORFGk7MdNhTySqY2A
         QQc+fj+8U27HuW2wdmwkr2cOVdM0s6NdIhjpUKuVJ/RDo8d+O0SZ4wDzbqNvHO5zMe
         wav8AzC9TpSRg==
Received: by mail-ed1-f69.google.com with SMTP id bx23-20020a0564020b5700b003bf2eb11718so3059585edb.20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cZtuR9o2k87pvi0rgBoRi8/bFI7YeJU/qox3v5ZI5U=;
        b=P9oCDYAQeqYbbVXJ2rnVYYKsFKIROJlDZRKLYkBrbwSlD9jcuF5b+5ErjULQimuvF/
         fTk/hE5bOC6ndLRGL595jxfJhNHcvuCGa0tiJt0QG0CKuyj6ONApmj8yH7vlhQ2AlVrD
         mNbJSceHgJ1E22uF5cZE5La/gYKjqA8LaePBSzMuDZ0u1//iCfI4qq/apuqOcR19DJ63
         e+5MgdOs6rQyWr5iH1glTd2D7u2aceXlSih3xwrb8OqYuqR3uJcZFY8MW6AEXtTUOBsG
         HCuEuPZF9L1b237CTHHSz7AE9oPWEYyhVe3Kb3JPT8muWW9oorRR0SBO95um3+RKAeKS
         hWdA==
X-Gm-Message-State: AOAM530c8hfJGsXBztcXF6tvQtLTngK33VDMira95FC/+DadIvx03pBk
        FNkAv39A/Wx1LfzO6odZhG+iap9x73le9xlG0GvjrMHtt52HYItEelmLjiOKJUkb0NyQkX3uvl1
        81n0/C2zlQhd+HlGmLs4VeDAJyoRlFvlWlJuGvqDb/g==
X-Received: by 2002:a17:906:87c2:: with SMTP id zb2mr16503211ejb.322.1629390106277;
        Thu, 19 Aug 2021 09:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuaQqSj/y3QMWrvKAdgV8r7CJmiTSZ6zuwkSNkqhhy0AKGNuqM3cQONHkLBZcKm5Sw3vridg==
X-Received: by 2002:a17:906:87c2:: with SMTP id zb2mr16503202ejb.322.1629390106161;
        Thu, 19 Aug 2021 09:21:46 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id j11sm1478832ejy.112.2021.08.19.09.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 09:21:45 -0700 (PDT)
Subject: Re: [PATCH 3/6] riscv: microchip: mpfs: drop duplicated nodes
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-3-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4d0d6290-8341-56d8-7902-5a8c36bc7bb5@canonical.com>
Date:   Thu, 19 Aug 2021 18:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819154436.117798-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 17:44, Krzysztof Kozlowski wrote:
> The DTSI file defines soc node and address/size cells, so there is no
> point in duplicating it in DTS file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 5 -----
>  1 file changed, 5 deletions(-)
> 

Now I wonder whether the subject prefix should be "riscv: dts:
microchip:" instead?


Best regards,
Krzysztof
