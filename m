Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C946A3D1FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhGVHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:49:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F0C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 01:29:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so4585589otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYbztYoVjZgOeHTU+hwjUgQL+Xi95TvcDcwtmr8It80=;
        b=1iLSGKTozk/lPo6Q8/ym67DuarP0UWIPLn8w8u5O/Nd4M2rSwvKkQzFdU68NaADPe+
         DLHUwWPXh7gvZFJvKvOgDernTfxnVnbXOse2kdtdAIXQv8DhDxDmgsUXfkzawmjC0YVy
         UnTnyxoc5te76Z0gvMZivgHJgQZztljfOwrM0H2WhBJ6zwharnDf10lkvetDdxyq16U8
         2iM5Tm3RzXlk8z8l+5uUUQkHL9KpWwSB2iuUbrg7ur3rlytlirZ9jz2DZvP28dX6cStV
         VN7uHKfcCGz7RSIoVMQ85nKF9xKjUV2SoYnlN7BUeeY+7BGG0kiVdrNlTJkrLvX6JSVm
         wu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYbztYoVjZgOeHTU+hwjUgQL+Xi95TvcDcwtmr8It80=;
        b=KVfayTP29N7HXPNxcAxVO9J9F0QrzUuGyh2uTtsDY9d/IXkmTn4g3tme10KcaOLW9x
         JcglsLmtfTVALQzI8UugsVRf8+viq3IzHHxoQvLv/rROmH8pm6gxdMcg4/EgVRjYqvzw
         2JzMAKIeME3lHkff/YuDOoHGUYIt4xbPbYWaibm7p1CL2qwkuGG2qnuKoldx2MFgyw4s
         3w8oQkVzTJFELCbr222OY90fymey6YQO8cpH9m11deRTjDiSHFPQhAKvfh8SNa2hEPIw
         8Yz8+sEgSyYKH5g//7tW3nQKhV29Em3ysTEqf8m8DHGwom5kadAEYIATV4202AwCQzJU
         Ebow==
X-Gm-Message-State: AOAM5325yPByWkEBj0LCbJ6RuUuOqpB6fSJNyroVPzOReFG77E3hFDkH
        /GvbF3WSJkcEEGF4ZZ0A395kyA==
X-Google-Smtp-Source: ABdhPJxTKST+odH6IEFwOfCHDDyjeI7hDkboff01u3SXvW385jzT+MHRQCg7xqULBGGuufOZdwWkjg==
X-Received: by 2002:a9d:404b:: with SMTP id o11mr11155386oti.41.1626942597788;
        Thu, 22 Jul 2021 01:29:57 -0700 (PDT)
Received: from ?IPv6:2607:fb90:c28f:4e7b:6680:99ff:fe6f:cb54? ([2607:fb90:c28f:4e7b:6680:99ff:fe6f:cb54])
        by smtp.gmail.com with ESMTPSA id k13sm5030391otl.50.2021.07.22.01.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 01:29:56 -0700 (PDT)
Subject: Re: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
From:   Rob Landley <rob@landley.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     richard@nod.at, vigneshr@ti.com, David.Woodhouse@intel.com,
        Artem.Bityutskiy@nokia.com, ext-adrian.hunter@nokia.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linfeilong@huawei.com
References: <20210708131359.21591-1-linmiaohe@huawei.com>
 <20210716010224.44582046@xps13>
 <95e3d455-ccb1-0e22-ee83-78dc6ad8aab1@huawei.com>
 <20210716114808.246e92ba@xps13>
 <f7f55c5e-f6b2-542c-66d2-20f4d88bf669@landley.net>
Message-ID: <c1d3cda2-5beb-21be-a1bd-d30c1c035ff3@landley.net>
Date:   Thu, 22 Jul 2021 03:47:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f7f55c5e-f6b2-542c-66d2-20f4d88bf669@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/21 8:34 AM, Rob Landley wrote:
>> The only way is to create a second UAPI.
> 
> Twelve years ago a patch was submitted to add a 64 bit MTD api:
> 
>   https://lwn.net/Articles/326418/
> 
> But for some reason they only merged 64 bit erase:
> 
>   https://github.com/torvalds/linux/commit/0dc54e9f33e2
> 
> But NOT the rest of the 64 bit mtd API in the same patch. I've never understood why.

That said, the workaround is to use the info api for erase size and use
lseek(SEEK_END) on the device to get the length.

Rob
