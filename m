Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA639A242
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFCNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhFCNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:34:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26CEC06174A;
        Thu,  3 Jun 2021 06:32:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t8so5121930pgb.9;
        Thu, 03 Jun 2021 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iEQOESr2EHarE2eFXszkBy1aNJ++bvs1j++M9Lxe844=;
        b=vPDyYLOTwpL6TFrgNOmQUIXMBjHx9nEOI8sbJHIr182Frpim7246rIsL+wo+ttU3FF
         vOXs0iPPZlq3CNOu4syAMsUUOY70Hn+uiBXsZfqZO6QZg1dABRXb0stQ9uXoOqpzVevZ
         tmRCXt5K4J+1CJPI/5WYIJ2S0Evy0lKtYxVpykRhhl+7ujRulu1xW6PlBF5uusQ6FSV/
         SdPOJZt9ixNBjQ94gyWoQTyNUn+fsFwXVDw6Sb+siiqR31tIekVxQJdhZNQY9TCaAuvp
         Nkv/mf7Z0rByk8mbpq8mDjWwmuWE448YVv8RNlOLXFWLtNQR1PvCFXMwmSSP/6qctaQd
         IL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iEQOESr2EHarE2eFXszkBy1aNJ++bvs1j++M9Lxe844=;
        b=hP1h2Pqqy413ti3MGxE+d0i6Wwk3Kok7o8z14YWZLu1Jixt8UJqpe9IpX5nYVvUWGk
         EzIQfUDSFRSrTYYAbffziOD1Q+IctXHrl0Y4jtQgsoWUKqdrcUrIS6nGNR6DG9yiZsTr
         bcgretGQcfBCbccoNta9lZzlPmYJlkbTi1Eiis1C/o+O4W6qUR12cEWmzkuquGF3QFwj
         b3K3/l6zBqUNBddxDwoZj9e7wpyS82yPJwJsCiBjtHpnpj5sSt9tcfeAUS4iUvj9nVsF
         NVYrNUzpRwGtGLbcHHolvg9iB9IYq/E9zCt7HaXZCmmTQAl/F3a9blNN5Hkr9Hx7MtWA
         Axpg==
X-Gm-Message-State: AOAM530QSG2HDj72xlS+EZDudNfGHMKHjCnIqd35/sj9o0ZYAvthAnhO
        BbQ5TfPPGcskZ3FevByk1uQ=
X-Google-Smtp-Source: ABdhPJy9oqwFXTx23rJ0NmxS6M9NAUoe4sGmMetpjMzUmi+ujURRvVRG9QQaM+6Tn/Ia2SR85oJ5Tg==
X-Received: by 2002:a63:d312:: with SMTP id b18mr39940154pgg.89.1622727176019;
        Thu, 03 Jun 2021 06:32:56 -0700 (PDT)
Received: from [172.28.99.179] ([139.226.50.128])
        by smtp.gmail.com with ESMTPSA id nn6sm2307533pjb.57.2021.06.03.06.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:32:55 -0700 (PDT)
Subject: Re: [PATCH] [v4] docs/zh_CN: add translations in
 zh_CN/dev-tools/kasan
To:     Wan Jiabing <wanjiabing@vivo.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Bernard Zhao <bernard@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com
References: <1622723294-26434-1-git-send-email-wanjiabing@vivo.com>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <e04e491b-69f7-f4e0-882c-6ce86baa39bf@gmail.com>
Date:   Thu, 3 Jun 2021 21:32:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622723294-26434-1-git-send-email-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/21 8:28 PM, Wan Jiabing wrote:
> +
> +实施细则
> +---------

the '-' and the '~' should be aligned with titles, like above '-' should be 8 numbers
since Chinese chars take 2 position. Please double check all titles and its underline chars.

Thanks
Alex 
> +
> +通用KASAN
> +~~~~~~~~~~
