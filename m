Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1E3183DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhBKDIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBKDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:08:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 19:07:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cv23so2499473pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 19:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mhBJs7OoyfS2zcVrbQAP79xwHQs56wVRNi/BY1bbvY=;
        b=zWdzLtxtpSIzvCC92tWtiO8n8oojDUA7anDSZzkEE4lkpolIANyXBag5Fmb/HGhQXb
         51RfYqW84ZIIY9q5iK6XVAvOxC3KBHEhDeDRUdYytDRk1P5/NxCqs9Bu/mxKU510V1t2
         o3nhicKcHDi+EGf2cASP5264ruoQlNnSgkmCTTQtNKMNejvYZc6CnyN44tzcPoNIliI7
         XO4pOcOOsOWs57gS9dbEMbzQMb4kxrj2AUdpjOzREo65XYPi/td+jcf8M93/GGLTt5/D
         bg4+O9zgy8/rOXJ/TJvDfaNPwkvPRyzRbHG6X9pks0Tf7DMt5xddNWG7gOieZFU704MH
         WQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mhBJs7OoyfS2zcVrbQAP79xwHQs56wVRNi/BY1bbvY=;
        b=qvKyDmYbKu9xdB11aBgpop5HzamSb40dRQ4mVY9ijpDSOMev9fK/ehbK6b6QRv3lit
         SpuPofnGAZ3oi04h8zaO1lrWwzenvbwGjqT28efVwJk57pGcZQrG4C64R4PFtf+jwDHi
         1qesFxWsYL3ljc0XcLDr/wzeKfgo66OwLhLNlryv8homwkoU7htgy/dwVS5+PHT46pg2
         8bK8af56pFoLMsmWruXVxm0IK+tco8jo7pyJ9up2rQId/PLLgexBYgRitpuozVZqsWPY
         2EG/Lu3NLEob6z5aEB71+NwIzTICN1oOKqk8etP2RwwBExkyxWIsrb/65hBBdGGG34AR
         PTwQ==
X-Gm-Message-State: AOAM532843NFOqsyRfYoO28HfGc2Xh5CSfRT1qXujIcUD6XdBm+rH4ib
        WyLzRGldQ1vlUSEtYBBQEjT2oQ==
X-Google-Smtp-Source: ABdhPJyS3EIC1/0cxujchAyzsIFrMFqk/EK4Apvf/tfm5JIYYCsOoMqnVgrUU8+L9AA6Vl2lzq8YOQ==
X-Received: by 2002:a17:90a:ca8d:: with SMTP id y13mr1992054pjt.76.1613012865254;
        Wed, 10 Feb 2021 19:07:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::11c9? ([2620:10d:c090:400::5:9df6])
        by smtp.gmail.com with ESMTPSA id p8sm3778200pgh.0.2021.02.10.19.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 19:07:44 -0800 (PST)
Subject: Re: [PATCH] block: Replace lkml.org links with lore
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Justin Sanders <justin@coraid.com>,
        linux-block@vger.kernel.org
References: <20210210235159.3190756-1-keescook@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8cdd00cd-c17f-fe69-fa07-b144a64c55e5@kernel.dk>
Date:   Wed, 10 Feb 2021 20:07:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210235159.3190756-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 4:51 PM, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.

Applied, thanks.

-- 
Jens Axboe

