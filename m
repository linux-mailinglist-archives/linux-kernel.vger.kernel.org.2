Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9484543C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhKQJcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:32:02 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52188
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbhKQJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:32:00 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3254C3F1D2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637141341;
        bh=g6sftRfYoS5K8kCTriz66+zQQzgvVb2wBfDCaV4eUgU=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=PF30djKa5SRkbsiPnkDAUCwJv28dAbT5S5h42BJ5MZbwHdSqyBOiuLQoyqx3WSqzw
         MApQe99mVQdZceBTsIj7ciJ2Ra8uUmTLZEf/4O3/R3X/MO140Nq4b8UoO1LWZ7+qa/
         I5pyuZ8GTKnRwC6inD8MDJL14QPI2mVbdl06o7mEa9zcV9nspZE9okAykRJ1Zt5Sqx
         AXlDtdIYcXOokmEnlXQTaDPv3ib8a8/gxfp7X1HWoaj4IxLkC/DsSUu9n4pPMX59kV
         U6Ebx9WS+elaq248VPQuD4kih+O7VCTJP8Av409KLvrJGqUL78DsVy0BGB5iEMxnqz
         6DXVFEkU5K60g==
Received: by mail-lf1-f70.google.com with SMTP id bq29-20020a056512151d00b003ffce2467adso1079812lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g6sftRfYoS5K8kCTriz66+zQQzgvVb2wBfDCaV4eUgU=;
        b=3bbblXBoAm8bkwFzOa4YrBMTgtWkpIqrfBuBWQiljJxO5TAEyzYBsWfe7ZF/E7ithS
         vvjFbLhlPIkXYxS+TI2tRD/n96mH61P1EPuR1zoZehHAZ9MFtDPgNgFIQ22alSzpmH5a
         7Z+yKHs+1IjOubyIoiurXqFQBjbMDHHLGGRlYlieSejn7GIb/ApFacZTRtvW6q+NBRT8
         tz8klp+Tkslswn57unrvTCuSFe8Ch/iaZ3v6p6O6etkyBs4b3JLPNBoMf6x0/1vwCui5
         z5mBUjQ8PBUzmw60bZ9MDAwxxo/w1g9Fl/X3FnSLHAQmvJY+oN2W8RO3IL1502t1NSoW
         HaHQ==
X-Gm-Message-State: AOAM533vw8dcNDhrnw2z7ADKi4CjdCWKsySqMSVuUnkshQYq62NWIxGT
        rW74KuoykB4W6QS+2RYPU7axlz7Qhp7r5AFoofRwGZzOonLZDD5LBHPdn/0mC7L6wU/As1whWFy
        KZfqbGhM/CF+KN/egShlm+baXoqMS7i8NenGY57kLmA==
X-Received: by 2002:a2e:a591:: with SMTP id m17mr6124181ljp.511.1637141340605;
        Wed, 17 Nov 2021 01:29:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk3rckhVD3o/KrVz7Fl+GIwyh2oCoLL4QcTE6BtGG9W8Byfyh6HuAtKrO+h4bpUSVl1x+npw==
X-Received: by 2002:a2e:a591:: with SMTP id m17mr6124171ljp.511.1637141340471;
        Wed, 17 Nov 2021 01:29:00 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u16sm1666325lfu.42.2021.11.17.01.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:29:00 -0800 (PST)
Message-ID: <1444ff08-24a6-afbe-1512-9ea24ad5b32d@canonical.com>
Date:   Wed, 17 Nov 2021 10:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 1/6] riscv: dts: sifive unmatched: Name gpio lines
Content-Language: en-US
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2021 00:57, Vincent Pelletier wrote:
> Follow the pin descriptions given in the version 3 of the board schematics.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> 
> --
> Changes since v1:
> - Remove trailing "." on subject line.
> ---

This is not a correct changelog placement - you have to use '---' just
like git uses it. Just test it yourself and you will see the problem.

Best regards,
Krzysztof
