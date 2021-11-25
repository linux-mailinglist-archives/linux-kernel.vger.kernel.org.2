Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3730545DC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354634AbhKYO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:29:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37682
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239501AbhKYO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:27:20 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F6693F1D6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637850247;
        bh=jJ1CvK9RCVKJj05miAYFdX0zpNfhh9+b9Y39+PdS9oM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=aOCqC/JuOoweCuLs5omb78+TNGRy57ZqgoEaXjWtTJ7RBL62kUk8zosS2pwh9tWtf
         UrmKoQn9IHZdVT6yZ+mNxobcs5eoX7pMHJgy2+6Un4CgW5GHjt/wZpYe3XgbkgOs/v
         xmT23yUM/ONf9u+5Xy2l56nu6xC1iXyORuIcQBU27YMMTTUIkDhUU76NhhndKGAso+
         2KM4Go0n4ofXe1S/9+zhmsRJhc7asNW1OW/0YX9l8A6U244fiH3BbAoRQrEAxy71p3
         LQF6dIKkjOWcbyo/tT1W68I/PHgkY4nd36F6u7aClJ+5Zzoslgoesv7EbyxZnkczoN
         B/F1yg98NtECA==
Received: by mail-lj1-f200.google.com with SMTP id w16-20020a05651c103000b00218c9d46faeso1886495ljm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 06:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jJ1CvK9RCVKJj05miAYFdX0zpNfhh9+b9Y39+PdS9oM=;
        b=GrN7lpe8adTeswErP4JV6aCOqcVG3yjqdxQIq47rIN49z7KUb5tP4+33ydi/yx+f8d
         Qqjrk0+KuGr+WtmodLAmtdS05MBfXKCsPTFDAy7Tv38+lMU8ef1fE9/5hnmytkhFtx77
         pQN9tMtCEIe4uMvXmC90z8SDK6peXoBn+IC80cfWpkuaIOooY0/ww+7PCjrLcgedAmg+
         sTfxtoIcf4drR2tKrJBAu8FM2dDvMcYyTMrIo3BMmNMW91OndI7a2InRIj2lGxO9gdms
         xAogHMDzUXn+I5QYsmkRnfXMAfbjvb52BLw1XJVQgx89LIXc7CAn7A6/b1kpNZakt299
         VdLg==
X-Gm-Message-State: AOAM532xwjv/xqFlJUJYlXdX0zRsw9DlFyzIxpwIQ8CjRPwtt7ixEX1W
        sSqNGCrfrljb/b7NxZki5C+FLSbbZQ0nF4pi9fpmjCUojpR66Vn16ZcAie/ZYXDzY/u34ytyIZf
        N55UL19uhKqTfRZZTQ2rAAAOpDoG5yjqKOAdeGxeffw==
X-Received: by 2002:a05:6512:a84:: with SMTP id m4mr24021455lfu.284.1637850246397;
        Thu, 25 Nov 2021 06:24:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZt9BGxb3SteRzbKydg11/7MAVLZ8xf/xO5RgFnE/o2qUWQ3QTFDY/nRqr2DLousCbioJWXA==
X-Received: by 2002:a05:6512:a84:: with SMTP id m4mr24021422lfu.284.1637850246164;
        Thu, 25 Nov 2021 06:24:06 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s15sm272325lfp.252.2021.11.25.06.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 06:24:05 -0800 (PST)
Message-ID: <872e6a95-721d-2c33-77c4-764a0b859f43@canonical.com>
Date:   Thu, 25 Nov 2021 15:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] nfc: virtual_ncidev: change default device permissions
Content-Language: en-US
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bongsu.jeon@samsung.com
References: <20211125141457.716921-1-cascardo@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211125141457.716921-1-cascardo@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2021 15:14, Thadeu Lima de Souza Cascardo wrote:
> Device permissions is S_IALLUGO, with many unnecessary bits. Remove them
> and also remove read and write permissions from group and others.
> 
> Before the change:
> crwsrwsrwt    1 0        0          10, 125 Nov 25 13:59 /dev/virtual_nci
> 
> After the change:
> crw-------    1 0        0          10, 125 Nov 25 14:05 /dev/virtual_nci
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>  drivers/nfc/virtual_ncidev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
