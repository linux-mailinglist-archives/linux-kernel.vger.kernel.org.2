Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60963DF8E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhHDAXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhHDAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:23:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D31C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 17:23:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so6303956pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Vfp+2k/Bq5EMH5P0mbzsQ/oY2sEu5vdbGDAQL7dI63Q=;
        b=fU1FikMXptsLCNC/MdycLY+mZHs7TTqKv+3LSC9BjJeuJF61URasVwNE9x0RFUFp/K
         wTUeTmovK42BYJx290mQsjv7TajwKH3V7cewaFQ9qs2uyHpypDtPA9FyAzSSiAiLsjB8
         3ImSkwtZymWNsN1bCeGOcYL4EhrUpDPiyoBQOP6zdvABzCvsHps9oaVvQzDQ8h7OonaK
         mtxp3zQXLrVUu7Vf8RK6AkCmWFXFVweWNK6lhjayMbL8Rk0VXqgsLKhJnf+AEW3nUslB
         ZVZPiI62GHuik4CsRYqOVhm0X9r3tqAHiYt+lvIWtovgjHBTK+ZyIXiQddOuefUKnz76
         Bgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vfp+2k/Bq5EMH5P0mbzsQ/oY2sEu5vdbGDAQL7dI63Q=;
        b=gZuSBGg8X6R7Hk2Ldf1FyLeRR13HH7y4fTjCWdq6ZxXKR5WV8XJ0Z7SILSA1qTcDyy
         rImep6IGR6DyCNzvCl68k9X2Zon8Th3fmbfZUIOr4LWx9f+OiJVDAjSPP/YITw14iFjl
         AvHlIaqRZorZB6QGmsxPC8gcajxeguTsYw2sakkqTOF92ZOqQyKULTG77vtnn1hl1jMJ
         LKlUzGBX2uygHv+oj+ajs3r2wtPxrY03nRSTOTIrWT+R/a5XnIWkR2atj9CmfUjqTHRo
         sEMbToc8jWt6REeadRCOdDk2wLz64mcLdqbgrLCpDT9RsBJcZCulxIv5RSxzJr0zkk0a
         aGVw==
X-Gm-Message-State: AOAM530Q+5Pw3J5/SAfeBUhliTQh6Ln2XQEd3ny/XeBERU5x0YOoHgax
        foXH/W/55BOlFhZwEdfD5iZJaefSpNk=
X-Google-Smtp-Source: ABdhPJybu6znL6ITn3DsXyWKOBk9XLt2hobeIrJ4kgu3SN2cNI4RZtyeAEtzshoyKSvpW2WL/Glf8Q==
X-Received: by 2002:a17:902:9688:b029:129:183a:2a61 with SMTP id n8-20020a1709029688b0290129183a2a61mr7245589plp.27.1628036580704;
        Tue, 03 Aug 2021 17:23:00 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:ac7e:8039:fb28:2ad6? ([2001:df0:0:200c:ac7e:8039:fb28:2ad6])
        by smtp.gmail.com with ESMTPSA id f4sm314430pgi.68.2021.08.03.17.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 17:23:00 -0700 (PDT)
Subject: Re: [arnd-playground:net-space-cleanup 7/14]
 drivers/net/ethernet/8390/ax88796.c:104:6: warning: no previous prototype for
 'ax_NS8390_reinit'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202108031717.qedj386m-lkp@intel.com>
 <CAK8P3a0V1B6M6+wjJ=zXCEm3YDiv9o4OSUt3i2pbZ-YsxPxz+w@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <60f0f79e-34e0-c4b8-c30b-1962084465fa@gmail.com>
Date:   Wed, 4 Aug 2021 12:22:41 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0V1B6M6+wjJ=zXCEm3YDiv9o4OSUt3i2pbZ-YsxPxz+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 3/08/21 10:31 pm, Arnd Bergmann wrote:
> On Tue, Aug 3, 2021 at 11:35 AM kernel test robot <lkp@intel.com> wrote:
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/net/ethernet/8390/ax88796.c:104:6: warning: no previous prototype for 'ax_NS8390_reinit' [-Wmissing-prototypes]
>>       104 | void ax_NS8390_reinit(struct net_device *dev)
>>           |      ^~~~~~~~~~~~~~~~
>>
>>
>> vim +/ax_NS8390_reinit +104 drivers/net/ethernet/8390/ax88796.c
>>
>>     103
>>   > 104  void ax_NS8390_reinit(struct net_device *dev)
>>     105  {
>>     106          ax_NS8390_init(dev, 1);
>>     107  }
>>     108
> I'll resend the series in a bit, fixed up this warning by moving the
> declaration to include/net/ax88796.h.

Thanks for taking care of this - I had lost track of that patch altogether.

Cheers,

     Michael


>
>         Arnd
