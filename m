Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67934662D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCWRUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCWRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:20:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:20:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o16so21617052wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ygoTGW3vMkHUTMPi2Ou4IHFFBueRE8G5gmamjKJvDSU=;
        b=eINauvmohhJfpChpcgEHAQc5kYF6hnaUcwqtO6OgOtJJPRgj9P4+2srw/7G0piaCFQ
         xNGAjmz9oGNcQl6EaQvlBC0nKK3sinKwYYkIWdol0hLv8c5zDNkfAPKkO5VJAzH2zCSq
         7dU+heRtD2YKe4qizKsi4PcuPr9fYwpEkvqlOwYSYLjlKMhhf+8SrvmIBQAvOu6W+8FJ
         L52/IqstZVaMk6T6mpy/gP7GvmwjADTT2Qk58l8wwkyitXVh4peKizcCaxsUaa69UUlG
         DyYI2wt+69KZqJW9bn1acU9N9zYn/6BlNKMz1lgaJ+7aScEzhbzusfFzcrQK6ahdhY+I
         ucaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ygoTGW3vMkHUTMPi2Ou4IHFFBueRE8G5gmamjKJvDSU=;
        b=r5LqpY9+fk1j79XXNS1DlzcnaDsR7u61ZndIMn6ap3dTxEioJ13NHyYMe6IMZEE6k/
         Ycjk6qTa+xcn8j38BmnjHo9vSii6AfVQtLfzu3mHKB4ATFy3WQpsvoUjYqhXvFtGdkoW
         viCV9TGrxy2CtvXUmkE6CSQ0bVwQvjDUSr1OTmd0qtbpDuF+8gr0JnAMWz/dv0hI3aZY
         7zuvLjSf3I0dJ2++dQstZ90z906Zy3n22MVUQ4xtRavL9BLbzAWLgUfBsoVI1xAV1DQE
         iHVaYn8MgbaFVhR3bP8XqGarVkUv6ITeybqQe7vg/3NN2meaCazi07fLb6R63QLyO+/b
         P7gw==
X-Gm-Message-State: AOAM5339/Y5UwUAZKdHLc3+3kVd7g0f3RYFKqAmtLDCrCv71a3pJPA6t
        b30wC611SldpNVOCqog3l9DKWw==
X-Google-Smtp-Source: ABdhPJwjaiQ3Ti4dZPm55rW7x/x3TbI9aF6an7wyFN0z5VPwS4bmX2kbvVczEwUPb8/a8G7Sb7y0uw==
X-Received: by 2002:a5d:4592:: with SMTP id p18mr5416000wrq.244.1616520004825;
        Tue, 23 Mar 2021 10:20:04 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id h25sm3631033wml.32.2021.03.23.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:20:04 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:20:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210323172002.GY2916463@dell>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
 <20210311184033.GJ4962@sirena.org.uk>
 <20210322145925.GY2916463@dell>
 <20210323171143.GA5490@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323171143.GA5490@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Mark Brown wrote:

> On Mon, Mar 22, 2021 at 02:59:25PM +0000, Lee Jones wrote:
> > On Thu, 11 Mar 2021, Mark Brown wrote:
> 
> > > If there were more users it'd be better to have this in the core so that
> > > problems we can detect like cache stuff if that's used but if it's just
> > > one broken device it's probably not worth it, this seems like something
> > > you'd have to try to end up with and which is going to cause timeout
> > > problems with a lot of I2C controllers which would tank performance
> > > enough that people would notice.
> 
> > So Yoda, is this to go into the core, or stay where it is?
> 
> Well, nobody's sent me any patches.

Code is still in the driver in v4.

My question is; should these functions really live in the SS?

This is the latest submission:

  https://lore.kernel.org/lkml/20210315191832.16842-1-andreas@kemnade.info/


-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
