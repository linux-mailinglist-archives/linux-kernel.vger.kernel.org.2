Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055CA40EACC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhIPT3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:29:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35470
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhIPT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:29:20 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C919140269
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631820478;
        bh=MMcgzru3ZwhyKOsYx2iFuNW8JodY417NqNj4jNsFMOQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WmsgSjgvRZbCGGvLpwIqgyndnz1GO8TIzbqyguhA46DPqcSXONcGKWFEeHR8us0yl
         erGEGG1N0iPahnFMhHjqKX68P8lhXEYttk61jD60yBxtOLHIELfL9O4BCRnBBua6F1
         q/RZ5umPWYLE8Q8tsZ7nonXuoUXVi2qvoKDOdL9X2MbHnUfmy83R7srXi0m89tiCxU
         pFbxqN4pR7IJiLrVqH3SMF1fxn0FKeouaOhwLgN6UvVvs93vL6D/XMW+l1WAbhbwop
         ZDrNAbuDxucDrUvwiBjz9BL6vXQhq/5q4zmDe/YK2IlX6S40UCfUpuhYJOQdG/9AmO
         kJzGcRCSp7VPQ==
Received: by mail-wm1-f69.google.com with SMTP id y12-20020a1c7d0c000000b003077f64d75fso3530986wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMcgzru3ZwhyKOsYx2iFuNW8JodY417NqNj4jNsFMOQ=;
        b=I7YUBpf/n3qYm1Q/tQBtM1sJ4yFspfLz/RNMuLgsoCpucyhOrk+lpHjGXydQSi9hBk
         yRiY1nJGmOUikajOg/RXYMgS6RuNfBBX6DQyS0jSVtoYq8qqf9xsNafL532PtdYYGHPp
         BANEWuaTkI+J8FB2zhDzuaF/IZJ1uGo/zRSCB+zA1TuREaKgUm+UaI6MmWX5vb/cC+Ms
         TvxAs61Q3QDLhfIlIi/cw2XFR5B5lUFaoX97ZM6593t4k2loQlEu4RVMKOrF8i8zFLu3
         y1kXdvRi5p4XIQdLldH/UoA4Uzy+BT3bujWT8WWVrqWpjE77uKevQxkf14fkdxaj4xN8
         pEew==
X-Gm-Message-State: AOAM5326fiNLbWMnz+nyVS+CSWIWKkqvIzF8V52vi1IPYQ3VJpbYpW8c
        /0EJtKe7JB6eLUAs/39Y+QnAiU3F+Le2s2CkiSrhOAnFdY6qN0Ukpc94rPszjNOkxGKaNzyz/mg
        IFNhYlny6U0HfCVqpLSwxM69N1WmYnqjW9FV69OyVJQ==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr6593059wmd.34.1631820478294;
        Thu, 16 Sep 2021 12:27:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqn1+ESA3K0zllvSWstH2qMZ0N3R38ReyqO045tBhcLAJAO9cDYj4nPSe6W+hMxkhv/fTfPg==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr6593050wmd.34.1631820478167;
        Thu, 16 Sep 2021 12:27:58 -0700 (PDT)
Received: from [192.168.2.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id k6sm7063711wmo.37.2021.09.16.12.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:27:57 -0700 (PDT)
Subject: Re: [PATCH] nfc: trf7970a: Make use of the helper function
 dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mark Greer <mgreer@animalcreek.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210916153621.16576-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <21782e6d-038f-9009-ed8a-d65c2cdfb761@canonical.com>
Date:   Thu, 16 Sep 2021 21:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916153621.16576-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2021 17:36, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/nfc/trf7970a.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Please don't send patches one-by-one, but group them in series.

Same response - I think the preferred approach was Rob's dev_err removal.

P.S. You need to Cc all folks and all lists. The cc-list here is too short.

Best regards,
Krzysztof
