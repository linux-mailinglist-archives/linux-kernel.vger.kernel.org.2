Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD4400CC7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhIDTHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhIDTHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:07:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECC4C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 12:06:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so3512206wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AkQJf6wMVAtTiytE5TeAIUUT3cc5gz6qLO2GIm6ptGw=;
        b=O0PgKcQr2woF9NHv4Et9+XdiVj5R2Y64r3D89ZvdKyutoRawi11SsLX2klAvP0SbHJ
         2O2DRNADWSHibX6kuJXYZSj4ed9xHaHCFm/zMhKNJSWoIKH/7yxM8dKQcq7k2eoyS/eq
         qrNMxJm2+PbUyj5d6obHBdlXng8MGAUbXjuzPBh8DS1n4knP83mMPQwjFPjLiS/fZbdm
         5XGOqxkne4dQ6zB2WWcDoaoxK/P1dJ+jiBoACmMFV6Ku7HcEaJFXST+YwFmykOd9A0C1
         pVLSFzd7SsBruxDn+xxO88+H7n9B6ea62uNcaj6pxQY0RMqt4shfGhm4OoNdEHdQrfBG
         f/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AkQJf6wMVAtTiytE5TeAIUUT3cc5gz6qLO2GIm6ptGw=;
        b=f8Dup6MF5T0+WuLYX24YFe7Fq6EACZ4QJf2o3gCN4R2tSb6zKYfws3RlDQP/dwlDbm
         nW8r9NIqBBXlQ5bTf00/yQXrNwTfl8ZfGU8xy/rEWLCX809yrh3v6li0CFSLRJ9hHh+C
         f+JKxO7PVVZZzpMbuPMB9Ta4frxLCkfwG1gnLZrYP/ry3VYf6MccvXHV0ogL92b7GzF0
         T9aipvT2Z4quG4Vyc9klqKkN2WMK5efveCa4eWfac8VaqcyjPZTcNjZqWzft4J130noK
         M+6Ne9JwJdK6syBrertc4gVW3QUh3I1Hlttu4Q4COFw8O5459VV256/+m9zhzNUmGQCq
         oRDA==
X-Gm-Message-State: AOAM530S2yJX49YdGJdCnvKvr6+qigvqhJsg5D8gz/qnxr+ZMIN+xp6P
        aRNr9svohki9TiJwS5DeNqv49KuSyCS5Xw==
X-Google-Smtp-Source: ABdhPJwhzytBPmjBlvto52pArb22R0ONysceF7WL3lT+VNWte5TTl3E86ebHzPRfBDLAENYcIfW9Yw==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr5231684wrp.76.1630782392660;
        Sat, 04 Sep 2021 12:06:32 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::8fe1? ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with UTF8SMTPSA id k16sm2922659wrx.87.2021.09.04.12.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 12:06:31 -0700 (PDT)
Message-ID: <11231264-b315-9994-31c4-b1f2e463ebd7@gmail.com>
Date:   Sat, 4 Sep 2021 21:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 0/6] staging: r8188eu: remove some functions from hal_ops
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210904124033.14244-1-straube.linux@gmail.com>
 <CAA=Fs0ntWh8kanSBMA+jBLHAgVTAjH7SFJ8ROrmncZTkzSy-gQ@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <CAA=Fs0ntWh8kanSBMA+jBLHAgVTAjH7SFJ8ROrmncZTkzSy-gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/21 20:27, Phillip Potter wrote:
> On Sat, 4 Sept 2021 at 13:40, Michael Straube <straube.linux@gmail.com> wrote:
>>
>> Getting rid of the hal layer is on the todo list. This series
>> removes some functions from hal_ops and make the driver call the
>> pointed functions directly.
>>
>> Tested with Inter-Tech DMG-02.
>>
>> Michael Straube (6):
>>    staging: r8188eu: remove intf_chip_configure from hal_ops
>>    staging: r8188eu: remove read_adapter_info from hal_ops
>>    staging: r8188eu: remove read_chip_version from hal_ops
>>    staging: r8188eu: remove wrapper around ReadChipVersion8188E()
>>    staging: r8188eu: remove GetHalODMVarHandler from hal_ops
>>    staging: r8188eu: remove init_default_value from hal_ops
>>
>>   drivers/staging/r8188eu/hal/hal_intf.c        | 33 -------------------
>>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 16 +--------
>>   drivers/staging/r8188eu/hal/usb_halinit.c     | 10 ++----
>>   drivers/staging/r8188eu/include/hal_intf.h    | 22 +++----------
>>   .../staging/r8188eu/include/rtl8188e_hal.h    |  2 ++
>>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 +--
>>   drivers/staging/r8188eu/os_dep/usb_intf.c     |  7 ++--
>>   7 files changed, 16 insertions(+), 78 deletions(-)
>>
>> --
>> 2.33.0
>>
> 
> Dear Michael,
> 
> Looks good to me, built and tested here:
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Regards,
> Phil
> 

Thanks for your review and testing Phillip.
Much appreciated.

Regards,
Michael
