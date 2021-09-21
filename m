Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03B412F48
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhIUHWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhIUHWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:22:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E682C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:21:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so36262538wra.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9lJls9x4Ir3Og0tsCxemcW1jUDuoRfpiScVUmuJYNs=;
        b=4o+4O73eYK9bMb4Fnk+vy9cFbL0G26TLFn+vItPOnLqaOCHIUQdahny+5V97crEcUV
         bUn7xnxEVYgaT+PSVTU9WixGDjvYpwFkxQrmg7KlJkHkrs5X4kdoPPNX2gm0A0Ltrtsh
         8ixNu0sMryS7jtRPFOvlrYW6e0i/CBXQtyj8VkeQVRT9cbd12gQ4bH2rP7lASKIpGtzI
         nSkDxmoipXgdzMn8t9U3jndTGFEJ3VYNk4w4eS75MhfVNtnp0xDF1tuO44mrgavHaHWl
         qQ4qh7fYtNmRRbMmoCyv3ftbXdrbMOMRFXhxPT+tquakPZaoEZcdzQ9wKlBhlceVioJS
         SYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e9lJls9x4Ir3Og0tsCxemcW1jUDuoRfpiScVUmuJYNs=;
        b=4BOREIh/9DCHxsxQrHCoAfSywnte7D9eCWRkG868qORG6cABU36jsyXay5OCTdMWk0
         FeQCBoX5RuBlwN2VKBqKBIpkdMvPzylHliD7skSwTf/2tyrY9Wcj/+ubvSZTUijknjFj
         qAf/VbebD+HOpICeFD5JCSlhDOvGFiw1m4CWantzXHkcM384Tgt0OLv9YiaNKd0t334p
         o1DVLhN1FFMPp8WzOcrspOWTBejNB/k6500ypbkZoFhyx1gwUp01f4sVK8uD8PqEaLbX
         K7bBBXE9mQ1gtToVtimcAEUDcNXckr46rVtM6Tq3jiseegJuo8ADEICeCQmQP4NmORbt
         iKDA==
X-Gm-Message-State: AOAM532VXLCZ4NuLkgtsMDw81LTPoDnStNFcYXdRu/B2r8uX87886r1K
        l+mzKQ59t28H+95KGbu0yyj0hg==
X-Google-Smtp-Source: ABdhPJzELYbJ8jy1mwr1UoPKsoHlMwAbLOQHyrlZPvZHTluI+64PrlGi9gxNT1kbI1txsk+x490UTQ==
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr19634849wry.53.1632208866904;
        Tue, 21 Sep 2021 00:21:06 -0700 (PDT)
Received: from [192.168.1.10] (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id z133sm2247263wmc.45.2021.09.21.00.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 00:21:06 -0700 (PDT)
Subject: Re: [PATCHv2 0/3] Fix the pwm regulator supply properties
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org
References: <20210919202918.3556-1-linux.amoon@gmail.com>
 <CAFBinCBK02mnf6nEGFi+ZLUX4irAHL720ujms8NJxRe_NZC6PQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d0d03e85-85d9-eb23-b57d-e8482475181e@baylibre.com>
Date:   Tue, 21 Sep 2021 09:21:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBK02mnf6nEGFi+ZLUX4irAHL720ujms8NJxRe_NZC6PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 22:13, Martin Blumenstingl wrote:
> On Sun, Sep 19, 2021 at 10:29 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
>> Anand Moon (3):
>>   arm64: dts: meson-g12a: Fix the pwm regulator supply properties
>>   arm64: dts: meson-g12b: Fix the pwm regulator supply properties
>>   arm64: dts: meson-sm1: Fix the pwm regulator supply properties
> all three get my:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Thanks for working on this!
> I haven't runtime tested the patches but I expect that they will work
> in the same way that the Meson8/8b/8m2 patches with the same change
> did.
> 
> Neil, some of these boards are covered by Kernel CI.
> I suggest queueing the patches in v5.16/dt64 and then seeing if
> there's any feedback from the auto-builders.

Acked !

Neil

> 
> 
> Best regards,
> Martin
> 

