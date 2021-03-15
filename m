Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1233C546
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhCOSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhCOSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:08:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6674FC06174A;
        Mon, 15 Mar 2021 11:08:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v4so6157197wrp.13;
        Mon, 15 Mar 2021 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RUp3kK/vs0s8QVZh6opESHEvJ1dSF1ozGcrVeW85OH4=;
        b=fnnAtggmTLVRuIzCK+ICY6vKph/CLXzdOkjoOj8MhjctnkqwJwIbxgCeOx9BNAVNC3
         AL5fRwLYfFLlUzWuN0SIdq5K9zlDecTwLVOZWguJRrqh/kPERkN+s3ifLCjm9sCI9fP5
         XoWj96z17xuJ7asP2iA+tiNejRazgZqGG1B1HhcFDCBQzRypluXHPuQwW+lWMwJbp5uu
         hU66Hp2Q2HSIfuhzFri47Y0R5X/Fb1dRxmnYmyikfu6F+FNULu2fXS9tbduw9juQHZYz
         QEePv8ihrIKaA7IZbV6tMdVR5EHF4aK5X0mJ5L/7zi+ST5KuNJhdkKekTkFQtV5/Wfln
         zFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RUp3kK/vs0s8QVZh6opESHEvJ1dSF1ozGcrVeW85OH4=;
        b=pbRx+oYokuIgl/4b2VbFptcaYsiaTOm9qm9je4c3i6Miu8BE7MAzBnrUsipuVmr4xJ
         y42VlKphsx/mTJx4O/vcmRvk7UR/okuyEjUpx4deV4ZvHgmTXalx64Wa33AlaNNF05RU
         bYXbk0dxRB+eP2e9osyiR/waAQtkZaksQV7hgpIttXwKRdVv72NTWjxEZUl2mdm+gZIi
         9cmbOpFRczXjxJSWLr70d6vp92bodX50Wsuj/IIukvCDnLucHwTjfCMS7KgtO5XQucIq
         SCH3axUXsGDi/onIFiUnqvZgw57rT3XYxumNhHPks54SKPkNZN1ZqAwm2axTL4Nww+4e
         j4+Q==
X-Gm-Message-State: AOAM530i606TodXRTKFGM/gkDZhAlVCauMmYKlwVj5iUZ0lvDyr5c88/
        4WmzyuqbKQ8d/0r54pBo3V0=
X-Google-Smtp-Source: ABdhPJy86KuXUUpTWzkwMOrYx0gjLQbrUhLC0VBPQbKJ1o7CtOKdy/ZNg9rwlvjq4i6qAaUdqBcMEw==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr846686wro.324.1615831710202;
        Mon, 15 Mar 2021 11:08:30 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:499d:3dca:5498:583? ([2a02:168:6806:0:499d:3dca:5498:583])
        by smtp.gmail.com with ESMTPSA id i8sm19943610wrx.43.2021.03.15.11.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 11:08:29 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
To:     Rui Salvaterra <rsalvaterra@gmail.com>, andrew@lunn.ch,
        gregory.clement@bootlin.com, kabel@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
Message-ID: <95422d4a-8eaa-1cd9-137a-55313474127c@gmail.com>
Date:   Mon, 15 Mar 2021 19:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217153038.1068170-1-rsalvaterra@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.21 16:30, Rui Salvaterra wrote:
> Hardware buffer management has never worked on the Turris Omnia, as the
> required MBus window hadn't been reserved. Fix thusly.
>
> Fixes: 018b88eee1a2 ("ARM: dts: turris-omnia: enable HW buffer management")
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

(Without this patch, I get a bunch of error messages during 5.11 boot)

