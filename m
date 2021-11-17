Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38A454369
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhKQJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:19:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38532
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234309AbhKQJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:19:00 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 228BC3F19B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637140561;
        bh=zYEF5UbW5URF0n5/9aJrAQZkFg5ps6+9jc/WK19rfmw=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=leaVFzT2MYmsynIhxBrIz2ZJsuGJ0IvKqpn0ePRXfAZ6ImqEIckGGNJ5ZiFKHEZAe
         FjkJSPKvhciJK2djyZnlHRnMyNExajR6BZ7wR7Le5CQHtkWOKWsVV/DrMrQ/sTSlK+
         INC94U24GOb/kK56HdyIWTlzmFT6fMzgBeiz95aVcw3hKYUEX+BWwSm+uRfPZMFair
         p1v70yH7kOM2GCapqjNHuzCk/Z78aSDnvGo7lcS1VG9uhbTGgXN/herkQpRyHPaRwz
         yorJAjRjcDbbyFXVbf1JSJPUE3CmriQVQhi3EVQZs6tqV2+u+v8K1zfTsTmzYVou3N
         e/7agh4+teAdw==
Received: by mail-lf1-f70.google.com with SMTP id i1-20020a056512318100b003ffd4e89eb9so1030894lfe.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zYEF5UbW5URF0n5/9aJrAQZkFg5ps6+9jc/WK19rfmw=;
        b=ekGo/V1MeHUpg/88Nwsu5YhCnH89iPK4lAAZRMxwEsO3eUitZJnIgLferNcALrwZoH
         iURHXAN2iV3g9gcAHW5TOX1odeLeqx+/iz9/trR14ldTmtGS2X5kXx7TdQCh193c5ocg
         Jnv96hAKfTKLdCdt3Ej0JNE8SyUXXceKU3H9mLPxYHZmtmHl5FgVzGzlsz3iV5Je0z15
         yc8MlnZbpSWn4LwB88mJq9A45LC2uisRyJHNSNIORLu8m0Jr7SZk1PuvvihtfMDJcWQJ
         P2Wrz1kjoTVVRkbV8btZLG5HxDCwFFn3Dt3WsuJKSNUZVC8y64oMXiEY9BTAD98Tj5br
         59/w==
X-Gm-Message-State: AOAM532/Fi/fokCHBCY8Evv0NMczxc8UoGc2mo76CU3EnqZCloxNbDPy
        3Qc2+xKI2Sw6ph1EY2T1kANZSh6DWSxLpSihEl6l5ohAI5b948sIlw3QFZVxpg44BVYxGq2WW30
        r4RvpF9K7ijdgKhpURoPmcL6fVKubaijb1gQXfvsaqg==
X-Received: by 2002:a2e:9f0d:: with SMTP id u13mr6517616ljk.61.1637140560614;
        Wed, 17 Nov 2021 01:16:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxU3ehOh0ShZhGM+wz5whDmLtSwMogtXZr4nzbrKd/26lkA6hw68MIGQvtFQ1UKXNgl0L4Zw==
X-Received: by 2002:a2e:9f0d:: with SMTP id u13mr6517582ljk.61.1637140560348;
        Wed, 17 Nov 2021 01:16:00 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y32sm2055959lfa.171.2021.11.17.01.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:16:00 -0800 (PST)
Message-ID: <24e7675e-5ed4-8b99-6d9c-de28d7e60912@canonical.com>
Date:   Wed, 17 Nov 2021 10:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/2] convert ifc binding to yaml and drop "simple-bus"
Content-Language: en-US
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211116211846.16335-1-leoyang.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211116211846.16335-1-leoyang.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 22:18, Li Yang wrote:
> Convert the ifc binding to yaml schema, in the mean while remove the
> "simple-bus" compatible from the binding to make sure ifc device probes
> before any of the child devices.  Update the driver accordingly.
> 
> DTS changes should be submitted after binding/driver changes are merged.
> 
> Changes in v3:
> - Rebased to v5.16-rc1
> 
> Changes in v2:
> - Update endian property to type boolean
> - Remove example subnodes that don't have yaml binding
> - Spin DTS patches into a different series
> 
> Li Yang (2):
>   dt-bindings: memory: fsl: convert ifc binding to yaml schema
>   memory: fsl_ifc: populate child devices without relying on simple-bus

Thanks, applied.

You keep sending it to wrong address. Please use
scripts/get_maintainers.pl to get the list of people who should be
notified. Maybe you send to wrong address because you base your work on
some old tree, but in such case you need to rebase and use the latest.
Patches on older trees might be considered as not tested.


Best regards,
Krzysztof
