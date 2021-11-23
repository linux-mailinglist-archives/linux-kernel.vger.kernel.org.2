Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D890645ACC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhKWTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:47:04 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34572
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234047AbhKWTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:47:03 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F18213F1B1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637696633;
        bh=X9nPu6M4MnGefRZgRydbBLcoxEN2an8Y7q8i1bd1GgY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XasMiacnwimSC1jWxF6prZs9p1sfeiDJzOsZVX1ema6Z9KevDDuv3UpfPlPYW5exQ
         8mCvwk69Ctzxr+EOvLNBupLqu8mJ18j6xol1XrWVyYXOIQ64myy0sXygQZ4p9PL6OF
         B6yuU43b7IIPQJtj5ZXFZFdu0duV88zpGoDsr8zUGP541ftcdypzDBTT+Dqq/NausP
         QhDViBrewdPkhZLDxgLpMoWrHWciGEhrwPKQ/jNkQ8wFSUoQcJ27/vOJ4tkRjuCKKx
         7igptTjunrNg+0IzEN1caKfQK2G56NRAtY3xf2uWHCIgujUOQ6XauB5faKY4Z+sRXx
         wiD9NcVgiG+gA==
Received: by mail-lf1-f71.google.com with SMTP id 24-20020ac25f58000000b0041799ebf529so149976lfz.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X9nPu6M4MnGefRZgRydbBLcoxEN2an8Y7q8i1bd1GgY=;
        b=mZtywXCGff11kI4t4a2eFkqKLqXjflecnPATjQzmJyN1F20XH3zAjbrwwNIAFPzM1G
         gL/ahR5NyvCiB+F+ZwRhpGjaPPH2XIpZ28vKfSUwiZGPGN4PcKBXZu3xms4I0/3VV/Ia
         l6BHbK/j1GM7JZWl3ReyH2agvXzBFShhFGAheQSO1yyBelRZm5C0HXoejYVSfbxuKOHS
         ndYkdU59WxBA00HnURx8oFLzXO6w10Gcs4ytrrLtZFwPSunhQrWOpGabsRaAPKKAzBH2
         xdu80ZoT0byU1zjDCktNYvxquNbitYvLhk/maZn2rvdfh5kzEX5rmpMvi/Hnt/1HnVQT
         VLkw==
X-Gm-Message-State: AOAM531iJA8iTnxxOInNBx5fc7v3HkxLTDErGRqCD1H2BuSC1OlQ6Z8A
        kLlR017yDqgh7jUp5THrekXYlvSnck+hdz6KHTiD6SBn22jolAR982+WRgDaUFA8eJxf+qxxBKO
        kuvnXSZnq+7a2SN0vLOTbuhUhdWV8cEj6gSt6bYzvVA==
X-Received: by 2002:a19:f242:: with SMTP id d2mr7801927lfk.516.1637696633487;
        Tue, 23 Nov 2021 11:43:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFaBRKZmEoS9PRHvnxswXTWeitqkbEItlmIJMyGoqfOpgMWayVxNDGVMByx8TFop12tJI2zw==
X-Received: by 2002:a19:f242:: with SMTP id d2mr7801899lfk.516.1637696633321;
        Tue, 23 Nov 2021 11:43:53 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r3sm1387507lfc.114.2021.11.23.11.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 11:43:52 -0800 (PST)
Message-ID: <6a8f93a4-7390-1f1e-6ba0-601859c21ac0@canonical.com>
Date:   Tue, 23 Nov 2021 20:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/4] memory: omap-gpmc: Fix menuconfig visibility
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211123102607.13002-1-rogerq@kernel.org>
 <20211123102607.13002-4-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211123102607.13002-4-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 11:26, Roger Quadros wrote:
> GPMC was not being visible if COMPILE_TEST is not enabled.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/memory/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

... which was probably on purpose, similarly to many other SoC drivers
which are selected by platform. Therefore there is no bug to fix here -
lack of visibility is not a problem. Please document instead why you
want to change it, e.g. why this is a problem or unwanted behavior.

Best regards,
Krzysztof
