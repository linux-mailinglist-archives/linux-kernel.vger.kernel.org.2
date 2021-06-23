Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5D63B1B96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhFWNy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFWNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:54:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D3C061574;
        Wed, 23 Jun 2021 06:52:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n23so1709751wms.2;
        Wed, 23 Jun 2021 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RswLHNaF00PO7Arh2mf+qDFVtXypth6PIohJQobPJdA=;
        b=UqW954dW/ofN6YhRqH73bEer3gWpwd76LByR3QvhJ4XH5VBMQEsJyUzgvc17Z1PP08
         9Ta/WfWcthg1CDJ+BgUDwTbhLtR1I1WKN4UpMlrAeld4PF6u/AdTKtiviudC73hwg8Lz
         xYmjVrq9lSY/hFRYosKRoMFA+/2XAo8cvhjVYEoIEcRL6Ilt46oQrXkH9truJbKjMj4M
         3hbQ8xoMfcwX+HTZm+NZ9tHzrEoltJ8w0cOU/MvfVYzBUGqX5jDOOlbKk1CaOS/ziVQR
         NEA+Yyz0Piv4jNBNtfA6Ckj5Z4cP/iwbRnKlevBw/le+v9zujhnXnyt8/N2R792v9hEz
         AVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RswLHNaF00PO7Arh2mf+qDFVtXypth6PIohJQobPJdA=;
        b=JrwVbGKVrftTTozH/vo9rIV6Z13lxmbCuAdrVK2HiLHAzWEAAlD0iTQ8pNt5EYhnhB
         StTRZWUhB3U3E0F2/DcPhTC+avDsMQRKe5CmdImZyhCnhq/Oe28mEj/wWPxnZWAAX3D4
         cLh+MgyT6CmlD1+aNIjsvYn3dbPSXeZs8ZRIErQpvX/BhdF+B0ojTpVlcI0otXLNzV36
         uUP2YoeyCiCR/t4l9E1DIjEPpdfh8QwxjNsVMm1OIrY/mFtYZONxTTPpUP6aoPZ09C0t
         ilsJMQb6II8xduuXHgnMkht0kfd0FZPM0lgUVs3h+LP3PXBVkf5Ri0Nbg0B9AkNr2O30
         ti7w==
X-Gm-Message-State: AOAM530knw9Es18dkloj5QTAra9y5O6NUcdINuAE3RxxAPXNzOJZs1bl
        ZGZSPagg1e0tPnjF/v+TKVOLm7TFRvFH
X-Google-Smtp-Source: ABdhPJyZYaSej/0iKW6pQbiDQdw7KsYcMOhnQ6fIa7wK6mYNSV2Kr4abOqf64sshVHHxZwVMqV3Zow==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr11124693wmk.21.1624456326541;
        Wed, 23 Jun 2021 06:52:06 -0700 (PDT)
Received: from [192.168.200.247] (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.gmail.com with ESMTPSA id r10sm122412wrq.17.2021.06.23.06.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:52:06 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdmmc_ext for RK3328
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, wens@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210623120001.164920-1-knaerzche@gmail.com>
 <CAGb2v67K-BRhQ_a1yXtdPCX8T30FJPLojueJ2cvpXmGUskOLjA@mail.gmail.com>
 <6327455.haC6HkEk0m@diego>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <f1cf1be4-b386-2ab0-9813-dd47dc4e7a8f@gmail.com>
Date:   Wed, 23 Jun 2021 15:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6327455.haC6HkEk0m@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Chen-Yu, Heiko,

Am 23.06.21 um 15:40 schrieb Heiko Stübner:
> Am Mittwoch, 23. Juni 2021, 15:11:12 CEST schrieb Chen-Yu Tsai:
>> On Wed, Jun 23, 2021 at 8:00 PM Alex Bee <knaerzche@gmail.com> wrote:
>>> RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
>>> boards have sdio wifi connected to it. In order to use it
>>> one would have to add the pinctrls from sdmmc0ext group which
>>> is done on board level.
>>>
>>> While at that also add the reset controls for the other mmc
>>> controllers.
>> I recommend splitting this part into a separate patch, and
>> adding an appropriate "Fixes" tag to it.
> I'm with you on that. Adding the resets to the existing controllers
> should be a separate patch.

Will do.

Alex

> Heiko
>
>
