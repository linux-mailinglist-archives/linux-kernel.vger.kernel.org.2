Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CF34EC72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhC3P3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhC3P3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:29:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF19C061574;
        Tue, 30 Mar 2021 08:29:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b14so24396030lfv.8;
        Tue, 30 Mar 2021 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OSsJ/4+KgnHiu5gezRczsING3scAbDi33DDKOpy2Q28=;
        b=dOTBZNhnDGa7nDdY5+QtDDh48H+hcfPpTnDpCUbV/Fpi47iVCM5+kQe7Bd5hH+8/oh
         nVvlCz204RTDlF9lWgnzhBSFr4oOYA3ONB75zwe5dISLTRY9o/3Xdwjjm87GEtIMNrXw
         tpYBDG4VZEfS7dTli+6+2dVQ3mw5TtZ70CqIdNpKO6Z8juq5BYmDNgC0SWI3pXzFSBLC
         GgLdRqe2dp/BQ/W4SRNGzUVmKVdyxKw/SBg3pKbK6AYdKAH4nPbHD/Fan4vP/1u8za5C
         UpEXUraQAXOwOZmTT9xPq5QG0vcQAF9aSPbbrTQZ0XrPki/5KB41lwM8EHtz0Mk+N4Ps
         LW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OSsJ/4+KgnHiu5gezRczsING3scAbDi33DDKOpy2Q28=;
        b=L3iztkydrbC/sX5EgfoCVtjTWzZNG/wZpFR//sbOz5loQ2RF5uyNLvC0TzP3S6z38S
         L++OgQHi8mB9hIMQyo0DoOpTcXfn2OEz9hh28/NTabPktTULJf2mbDTqrlcojcyCfnDc
         cOAD6JIJxPN7d1OSj1PuY7pYm0HXSq+YRaiCovWquzasc9KpkE7//uQKlbobhXwNpm4e
         +UmHbA0Gj4vmo9epYwseN2nGIEuq6QK9NDXbkmevXZUtJ6n2o2ztVCld5nsiAVgrUggQ
         oY3pZ8e3m6bwG6LhHBGV54Mvvdo121z6WeYizxKd9xD8w1+T6dwEYMegj3sSzlDrJJWW
         qvng==
X-Gm-Message-State: AOAM532/5WY4F8gapYq52/qFefKaojG/qzb/OKXAaehPlSoYaDt6+sCw
        xDa+QOGPcrvOTS6FP3OyeC9Unit7krs=
X-Google-Smtp-Source: ABdhPJyKCU1iIoyVTxHNos8jN66if7O3aIGQJzgxIM5LJMHGkYFrvzuq6bdiWgUgY2yvRdMUYeADPg==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr19473965lfi.213.1617118162380;
        Tue, 30 Mar 2021 08:29:22 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:b259:a10:76ff:fe69:21b6? ([2a00:1370:814d:b259:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id z7sm2743362ljo.64.2021.03.30.08.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:29:22 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] dt-bindings: memory: tegra20: emc: Convert to
 schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210329194602.17049-1-digetx@gmail.com>
 <20210329194602.17049-6-digetx@gmail.com>
 <7e45375c-3e24-4fc1-5776-190db32681e5@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <989c3c70-3f0c-abff-ed07-c2dea3b66a2d@gmail.com>
Date:   Tue, 30 Mar 2021 18:29:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7e45375c-3e24-4fc1-5776-190db32681e5@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.03.2021 11:48, Krzysztof Kozlowski пишет:
>> +  power-domains:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle of the SoC "core" power domain.
> I think the core checks the type, so you only need to limit max items.
> 

It's a bit confusing that both variants work and it's not apparent what
variant is better.

I actually used the max items limit initially and then changed it to
$ref phandle because it appeared to me that it's a better choice. I'll
switch back to the limit in v2, thanks.
