Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FFB443DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhKCHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKCHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:35:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83434C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:32:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d13so2058668wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N8wlzTSWng30/uEuf5SuKMJUDGPCudj/Q+eFg1K128o=;
        b=C2pgopklk/bvxgsz61fLxfgp1P3QPmJW62dGpr3Hh86vtIrMm6bsUfeUSiv8ChKCpK
         xtCOVgDKqZ4h1wBLl7P7eoeJVZWGBWzYEvpxCiKr/4G4KU4kr+iR8xFy55ImuBO8WrGa
         I4Pf/7P4zKs/2qOpAOSFdpKoYwXUxE9PqmXLWqiioWEzT0wzztYTHpXDGsWVndCXZbY3
         T8xwvx27fO9SlKPyabA/bNnqAndvsPR0CYua1lcC/SRjR4FbF+jgtGSOLZzz92vOjw7F
         KKxebMlBY9Bu15H5t0IWAXBrkZcAGJKBHDd5s5kA7iW/4mo3An6GE21CEQvprn7GKTnP
         gQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N8wlzTSWng30/uEuf5SuKMJUDGPCudj/Q+eFg1K128o=;
        b=HixpWTcIZIFGE66p9aJPc1c4FJ/ueyw2kjKfObOy5q6lI9MBzfDKrfS9R+OnSthdWO
         iNuXhpQlHx4UafzPlaUffiMOwzMjEjexOA4wOxn2wHw+vQh9Vdq48urKwgz4olb8ouCN
         sgBwR+4lb1efokiiM2pRT1/5HlvuTja/LDgZ1202Ku3Sbi2JpqfHeMw9MkL2b6EqrOxU
         z2BWFl4Vmvykz1efQp1/42OPqFdvIuO98xX7nbjAikNZXQka8XpAo7YBfCo1tv06YPJG
         bb8oyvorCvlcHftHqizXWSl1qfnLVQhMxZHrxBOkPO3DRJsb0ai46R6cxjoGl8UB2BeI
         bJaQ==
X-Gm-Message-State: AOAM532b2ntB1zOSdD2Fvp4PNUeCcNnK3vSqu5+97DwLQcHb1eaeYLyb
        Z3j0k92Ih+fBONKQGrXC9NdMcdPXB55pQw==
X-Google-Smtp-Source: ABdhPJx1VQXQee8DvbyFpEelUPjfzWYrq/xTC/hpARqLTIuBhYNHK8ACdZd0yM1NFFCIPqwep7V1Jw==
X-Received: by 2002:a05:6000:168d:: with SMTP id y13mr54522869wrd.300.1635924750164;
        Wed, 03 Nov 2021 00:32:30 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id 6sm1083903wma.48.2021.11.03.00.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:32:29 -0700 (PDT)
Date:   Wed, 3 Nov 2021 07:32:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
Message-ID: <YYI7DFjoCgYMdLl5@google.com>
References: <20211102100420.112215-1-robert.marko@sartura.hr>
 <YYEeS8gz8TBW63X8@google.com>
 <8b2b9e6f61107b79f93dd191c3fc2918@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b2b9e6f61107b79f93dd191c3fc2918@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Michael Walle wrote:

> Am 2021-11-02 12:17, schrieb Lee Jones:
> > On Tue, 02 Nov 2021, Robert Marko wrote:
> > 
> > > MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build
> > > error:
> > > 
> > > aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function
> > > `simple_mfd_i2c_probe':
> > > drivers/mfd/simple-mfd-i2c.c:55: undefined reference to
> > > `devm_mfd_add_devices'
> > 
> > What is your use-case?
> > 
> > How are you enabling this symbol?
> 
> Mh? drivers/mfd/simple-mfd-i2c.c is using devm_mfd_add_devices which
> is provided by drivers/mfd/core.c. So select MFD_CORE is clearly
> missing here, no? I mean most of the MFD drivers do a "select MFD_CORE".

I'm not debating that.  The patch is fine.

I am however, interested in how MFD_CORE is enabled for MFD_SL28CPLD.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
