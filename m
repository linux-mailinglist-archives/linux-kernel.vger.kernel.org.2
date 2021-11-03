Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68DE443DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhKCHf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKCHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:35:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:33:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s13so2122539wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=87t3cRjg7u1Zp2KhfytX73O1Q3ZMRkilirTsqAdAYSQ=;
        b=tGiiPklVY9svjnIJbqS6ta7qyTgFdWoffpRcNS5l+h8oQ+LrlPVoyJbQilxwO3md2G
         /hYcvuPc/ICLhL5MVDhnb2JWIC0qHqBchoZEJtEvBNGEcyOd/+EnWTloGv/JI+31mK0U
         H46X7m1G0BcA4IqTK01QzS9ZlWoLPtpOAsA2XZN+L5QQLwTEs42NWaHiJm7nP5xustGE
         6LDsRJRzLTZoTA2WNwu1iy+21WOo300zOmLlKKrC83LlXBUx2sn+Nlqeu+3tst9iPxHN
         tFs85dSe+Jc0gnCxrLVINObyAZ60yXVxJEof2DBT3EGSiwkfiStmw9xYe4wPjoFwlwb6
         LjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=87t3cRjg7u1Zp2KhfytX73O1Q3ZMRkilirTsqAdAYSQ=;
        b=l09REvDmVP30hmYDZLZymyJUCgbfuEnHq/nQKvDIgpsJc8+pE9mVi3/65mxXhMSeNd
         5dVgOhbFD8I8CaufXlA5VIvFBTJZZ3CCxC3+syJKiuaSkd2gQ8SXoh0imjK+GWrs9xqE
         e0FHX4jC/nwD3mpk7p4pAVpCU8vOuYgaYzAyd2+hsovHZ4ART+Bdh1eItbhnmPCqn/zw
         ObBfgTz06RaoMPKkP8Uj4QqqiPuOWQymGZ9E2wuAAqBxP6HMUku+yUNBfFOh1ItLz0St
         oqjzbxax/vPUq8wRiy84/9n0mJz+8lXGJKpvlWUOS2OuSFX5mTmHjD6nAnzng0B+aCES
         dTzw==
X-Gm-Message-State: AOAM532i7g+tYEUM3IznVCV9yd4DXX06pCzXX/JTWN3qb65ZFagFOgQ3
        dwg/j7COjkHAOo1NQNiyuNB0VWton9D0xw==
X-Google-Smtp-Source: ABdhPJzrIm81/gDElGH8edbhfm7xR44j4oX6DYZJnE/14zlAkm38Itol8HjpKze4ZW1lKJvU5qLZjw==
X-Received: by 2002:adf:eb4b:: with SMTP id u11mr39590829wrn.49.1635924798571;
        Wed, 03 Nov 2021 00:33:18 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id j19sm1165940wra.5.2021.11.03.00.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:33:18 -0700 (PDT)
Date:   Wed, 3 Nov 2021 07:33:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Michael Walle <michael@walle.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
Message-ID: <YYI7PE9pTX/78nlf@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr>
 <YYEeS8gz8TBW63X8@google.com>
 <CA+HBbNHWV=+qDpOaD-ePz2yPpSjBOFEgdkuWBiqobBP9VN7W4g@mail.gmail.com>
 <YYEiijBp3dK92ep4@google.com>
 <CA+HBbNGGpSXtTqvXb=cGGadT38LkrOGdcjQ5XwojvnA8yTUuTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNGGpSXtTqvXb=cGGadT38LkrOGdcjQ5XwojvnA8yTUuTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Robert Marko wrote:

> On Tue, Nov 2, 2021 at 12:35 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 02 Nov 2021, Robert Marko wrote:
> >
> > > On Tue, Nov 2, 2021 at 12:17 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Tue, 02 Nov 2021, Robert Marko wrote:
> > > >
> > > > > MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build error:
> > > > >
> > > > > aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
> > > > > drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_add_devices'
> > > >
> > > > What is your use-case?
> > > >
> > > > How are you enabling this symbol?
> > >
> > > Hi Lee,
> > > I am adding a symbol like MFD_SL28CPLD does that you can depend on and
> > > that simply
> > > selects the MFD_SIMPLE_MFD_I2C and I have hit this issue since the
> > > MFD_CORE is not selected.
> >
> > That's interesting.
> >
> > I wonder how MFD_SL28CPLD selects it?
> 
> It doesn't, it just selects MFD_SIMPLE_MFD_I2C
> 
> MFD_CORE is probably selected by something else masking this issue.

Right.  That's what I'm trying to get to the bottom of.

Don't worry, the patch will be accepted.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
