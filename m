Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254FB312D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBHJgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBHJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:19:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B7C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 01:18:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l12so17234355edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 01:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QGcy+LVaBTe03RvcLEkLirzoNYsSN55TImtVQNmyuNc=;
        b=kaS/bnUpS3XICL+fvM+ime45O31tilIhRCELq9iFRCUV09KOVpS0RNZ1XPW1qq5EQS
         q5iL63Yhvn+cGnEHGYnZlDl9rWSiqQlDShLJ55ma3WnERHIwWcYBXAdJqSpYKMF1DI4q
         iXTrfHtretIr/vb4sFYF6At99JjD1BJ6svXG1UrvzEm6SJv9bjfQuA3c95U19I9qQq83
         ni7FvUz4P2dcg3raP53YY1Vw6i9f43qzq1KyC1zgYi91r/CZomGb6OYrBbIO/y9z5njX
         Zd0CoFhILwFoaR+I0GTnJO6slPNdMCIH1hmrmYEROXQTY37nAjYNWFSuHo53Kk/2gnwt
         qXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=QGcy+LVaBTe03RvcLEkLirzoNYsSN55TImtVQNmyuNc=;
        b=kie9svwxW5deYpNktoOfZatwCF+nE5hOj/QSiCGhtJzYthl61eqTZ4VHJfwxCgTRLn
         MuVLINbaxAaJgeL6q5y77SUTbHgdXIWKf20r1rsGvPQLo+q9bZHsfJuIp2fdIpz23ACz
         KCib3OM74vmGcHKoXN2IdjdMjpr8E+LPgVHGn/BQ8H4rdEJgXm1xVc/W/98P6dwx0MQ0
         GRaF0cE059DU/jSkpGz6u20r5wG3NDhyzwOgZCJbNObolwlexBVXPvyX8lzENPZEga8N
         pm2gGkqM0mEFJAq03t2HnHL/AxGAKHquzeIzZHlQC1ci73ShwxrOMR7hNzpCd1i+btKu
         lQCg==
X-Gm-Message-State: AOAM5333Rr7NWfnBIocdz2ewiLJql9gzrleST5U1ZwLrLCeMortClpnk
        X5J7xjODmh9trMWrDFUlKOM=
X-Google-Smtp-Source: ABdhPJwFPLKopzUJXReRnLoHJECO1RY11ATlvmhZi/WnrJ/Ft1BopfcxIEn7JphzmKs2nPhNqwEIjg==
X-Received: by 2002:aa7:c895:: with SMTP id p21mr16335569eds.165.1612775937870;
        Mon, 08 Feb 2021 01:18:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id u27sm4412750edi.79.2021.02.08.01.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 01:18:57 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue
 [ttm][amdgpu]
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Rientjes <rientjes@google.com>
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
 <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
 <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
 <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cf60a50d-d3ca-2ce9-918b-0763a26552d8@gmail.com>
Date:   Mon, 8 Feb 2021 10:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.02.21 um 19:17 schrieb Mikhail Gavrilov:
> On Sun, 31 Jan 2021 at 22:22, Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Yeah, known issue. I already pushed Michel's fix to drm-misc-fixes.
>> Should land in the next -rc by the weekend.
>>
>> Regards,
>> Christian.
> I checked this patch [1] for several days.
> And I can confirm that the reported issue was gone.
>
> [1] https://lore.kernel.org/lkml/20210128095346.2421-1-michel@daenzer.net/

Are the other problems gone as well?

Regards,
Christian.
