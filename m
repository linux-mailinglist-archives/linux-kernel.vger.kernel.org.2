Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC88D36E4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhD2GVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbhD2GVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:21:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E9C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:20:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s22so25303864pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=eGhjBR4zaGeybot+MbINCHNH51ifDbBua1uieBHnQ+w=;
        b=rJYMvlNW0fPvxvkYd8FjRM4Rdya30nobauOKU5eomIqlua9RCqZy2kemhwj/tlmusI
         ZH5t5+k65DhuxHSAkSkRmyLebc8MWUmMEoy/hbB+O0EzD9paXqz82uwPOPRbavXLAqTH
         tP3iciC+ifk12Sp3lywAImJ2bh9r3LaVXsz/ilGkwtXoJ7JkP818L9+3rpU63N6zpSkW
         EurSraYBmOUcSjGNe7iMcl0GoqCw+SsBg7wc5x1+U9MUlAbS4nYTSB36bi7BsSkErVZe
         qSbpxIwq/pS/Ob5j91lRHIqvYy4V+T04ceumU0Hp6Zb4t9j/1Mzr7716LVqn5syThfN2
         WSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=eGhjBR4zaGeybot+MbINCHNH51ifDbBua1uieBHnQ+w=;
        b=timPbaGn+wNIZUACvJe7jyzGY1YaMVILTuTXh6qBXZlr2ryvuiUpHAFRWI570ZKv3e
         566eTRKEPIfqq06C1galYDz2sayt84ITW/MZhL0KoAW8wPtc4d+2EtCYHgWvJrFWGXPg
         OpN516mAat6BCyWT4Fv5Z68B1r6pW6z4hPRpAeZh4L//SysifU/mCRzDsDJy4rDar5Wj
         Ok1MCfspbOns91caoCpAnhE/mVH8Ukzdgy7d6cfNLdW9CkFuoUKBsnCPo6TUeiKd1/3s
         mttC6g+pTmfjwP30IJ6Ta8EiYK3j+DTamuJ3MtDibqV5e3sFFyJFYj8GMHqSDyukEfZN
         Bgag==
X-Gm-Message-State: AOAM531L/shvJcnhFrcHbcYvWHP+zpxMjwR2/MW+UW62zc/0ASy7Peqq
        lfNYJad2AZqd1Xr/2jrryosHuw==
X-Google-Smtp-Source: ABdhPJxZ/f8l0Cp6+Li7MVzuJ9EGWthR4rmgkLzMcO9VW1vgGn5YwwFBEEqAsNeYqnVTeZpPOOximA==
X-Received: by 2002:a63:1708:: with SMTP id x8mr3202869pgl.266.1619677224052;
        Wed, 28 Apr 2021 23:20:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y29sm1440377pfq.29.2021.04.28.23.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 23:20:23 -0700 (PDT)
Date:   Wed, 28 Apr 2021 23:20:23 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Apr 2021 23:19:16 PDT (-0700)
Subject:     Re: MAINTAINERS section RISC-V/MICROCHIP POLARFIRE SOC SUPPORT with invalid file references
In-Reply-To: <CAOnJCUKrqOXGY7ePLEqxtAk39_fbhxt0wVhEtrv5m6X2wwuUpw@mail.gmail.com>
CC:     lukas.bulwahn@gmail.com, Atish Patra <Atish.Patra@wdc.com>,
        Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-cb6aa290-2314-480a-ac89-743a2d5f95bc@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 23:31:17 PDT (-0700), atishp@atishpatra.org wrote:
> On Tue, Apr 27, 2021 at 9:15 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> Dear Patish, dear Conor, dear Palmer,
>>
>> Commit df29598aaf5c ("MAINTAINERS: add microchip polarfire soc
>> support") adds the new section RISC-V/MICROCHIP POLARFIRE SOC SUPPORT,
>> but that section solely refers to files that do not exist in the
>> repository.
>>
>> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>>
>>   warning: no file matches    F:    drivers/soc/microchip/
>>   warning: no file matches    F:    include/soc/microchip/mpfs.h
>>
>> The patch series, [PATCH v4 0/5] Add Microchip PolarFire Soc Support,
>> never adds those files, though. Are they coming through a different
>> patch series into Linus' tree or do you intend to refer to other files
>> instead?
>>
>
> The actual files are added as a part of the following series.
> https://patchwork.kernel.org/project/linux-riscv/list/?series=467187
>
> As the "Add Microchip PolarFire Soc Support" series added the basic SoC support,
> we thought it is better to update the maintainers file in this series
> to provide the information about
> the maintainers for the PolarFire Soc.
>
> Should we just remove the Files section or update the maintainers in
> the SoC system controller series ?

I've just dropped this from my tree, it's best to keep it along with the 
drivers.
