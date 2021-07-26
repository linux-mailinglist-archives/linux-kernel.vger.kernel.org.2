Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96FB3D54A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhGZHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhGZHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:11:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C703C061757;
        Mon, 26 Jul 2021 00:52:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l6so7434806edc.5;
        Mon, 26 Jul 2021 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AaM4y6RazzXQuuDdTjSTqLkohIWqL53KdsjSdPJ6ZEw=;
        b=Lw/vHgj9KqqEqMBanNNBEybP3JIerZKOywu554T1F+xh9vZ0mJ9fg3/X9DtffhykYB
         yK0r5GEiAexjzFuBkWLKZ1+TRPJOtuEROPKWVNEfmUxEruoBO6sntrYu/CYYqr0bT7mj
         e+ZUcVA1A1GAdx+vKk5Uwib3HAhwgdWXzeXLTtuGqr4aHyktEnSeB8z+c4pif2I8zr8Z
         PxLhFxsFp85u1QZWtqmFJq3Ioi998EPCLptYNcDHfVER6fLAhwLdkaalOSwngDAolD6G
         bKa8gd4k5HelKtde6ClkB4xK0PM6IltG/Cz/tOk0rFT1cJVDZd9gJPhu4GOjAK2UWzrO
         x6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaM4y6RazzXQuuDdTjSTqLkohIWqL53KdsjSdPJ6ZEw=;
        b=WQzqK2PCS5hd8/gYzINVY3jjuipJCC+jRu03CHBdIkH9PiK8f1Z9gt5kKl+jQ8EMIU
         rZxYTxVrSkk1faQlFGS8kX2uZFiThz2J8p03GUSR7XbuJusryPigEVmpsem9fxv8piId
         V53T6UmtIGT9qtfQmxAfooP7/Gfip6LEKdAo8H2nDxkCzptGuU/J4fGeCjpNGnl57aZ4
         Ql/QEoeEXxrq8FOI7d0+QXv/h92xo0D/q8y47PORRIv2Qi2VClCDgsAsu3Dl2JXihNa2
         3/0GWmvjq+JSt4Pnc4o4dLe1DN2bxIE+ee6w581v28kZjDpTdKN/WH/mJJ3z7czmcWRf
         uajg==
X-Gm-Message-State: AOAM532789QfNzyHM5bidgUEMSmdOJmZs8rQUK+0IBlAGp4vsh2bFdkO
        k6rMvJfI0iHvBRaU2wcV9dI=
X-Google-Smtp-Source: ABdhPJyUguAOT5xjjXwhLROhPMHfGYnOQD7SmS2eI9s9NajEmanndl6z0ouP7oTXtWSNBHoGExXmkw==
X-Received: by 2002:a05:6402:3482:: with SMTP id v2mr20244649edc.116.1627285944910;
        Mon, 26 Jul 2021 00:52:24 -0700 (PDT)
Received: from [192.168.74.110] (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id f5sm13826511ejj.45.2021.07.26.00.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:52:24 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] drm/panel: Add panel for Samsung Galaxy S5
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210201165307.51443-1-iskren.chernev@gmail.com>
 <20210201165307.51443-2-iskren.chernev@gmail.com>
 <CACRpkdai5+vDj0C053qfPkdM-FCC-74HDCVF4=SPtUb7LE=Srw@mail.gmail.com>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <9e5d9c5b-8276-6e75-45e5-2296afa90c02@gmail.com>
Date:   Mon, 26 Jul 2021 10:52:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdai5+vDj0C053qfPkdM-FCC-74HDCVF4=SPtUb7LE=Srw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/21 10:34 AM, Linus Walleij wrote:
> Hi Iskren,
> 
> thanks for your patch!

Thanks a lot for reviewing this. Alexey wrote a new version of the patch [1]
that was recently reviewed by Sam, and it also includes support for brightness
and another panel found on the S5. My patch is pretty much untouched out of the
panel driver generator, so we can definitely improve the generated code based
on your comments.

[1] https://lists.freedesktop.org/archives/dri-devel/2021-July/316804.html

I guess Alexey will submit a new version with the two panels split, and he
might incorporate your suggestions (as his code comes from the generator as
well).

Regards,
Iskren
