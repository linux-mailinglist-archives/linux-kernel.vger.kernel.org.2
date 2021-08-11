Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B163E9711
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhHKRw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKRw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:52:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF8C061765;
        Wed, 11 Aug 2021 10:52:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a19so3311966qkg.2;
        Wed, 11 Aug 2021 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lyYMz9VU8jhHpPHC9xSYBkshKOGS2weo/TTB2R2B10c=;
        b=fAP3m2EMQqDx+Hp8c9T2UITQUIdKD2RoBs+vwB5N7F+5pKL7lZBh5+XC5HacAKNYtN
         FxnFx3NOdB0nuqH9TEEJefwaTR3SsIOv2pBGST3sTLsxDzcgJ7aC2TO3S7iz6emCu9GJ
         vTK77J3q9w4cMhgHA05C2LP7EbbbuOkmprFNydHvSnffZIdeMIhYBpoBBAuGYIL36FXa
         Lf77eo9pl/Dp/1ZVstRf9py2rLFtDgIJqMXYQHzJGdlbcrJxnngIk/DY1lclbwilO3S4
         +d9+Eotpeket4SZOuj2Zkd7yS0gc/GEXIzZ9sTWnvWS+ISdb5kMY6humtmzb+307hQgR
         IsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lyYMz9VU8jhHpPHC9xSYBkshKOGS2weo/TTB2R2B10c=;
        b=Yas0TZw5sxIO1VHOHZD1p/+nQSjstJeQG2Erq8kfoDSOiQbPnTD3cAK04/hNyA2HYw
         GYFS+S2Pwrl7PwfWoK7TVsIeZkI3j4eLz5/cJFz5zr5AWtmcfJeDoAguCARumADFZKps
         amNQIkQLoHT7313P+ANxXpOZeXDcxNZU8PuaSiSLZ+s6slh0QbXH9MmFCM5rrM0M2rsb
         DhHosi50K9tL+d/dqtUWi5U2jZv/GdwA/E8Eta06ubezB8gnW7O+kt7LyU6Go/309TU9
         q2UL8Hf1LzFpr1uIVDWH/1MLP3Yr+1mnaVaUjpJb+vHHD9XdnL8R+ZoLf8SwEch/WGBD
         cBpA==
X-Gm-Message-State: AOAM532WI+IWrhkZM4tYwsyfFWo6cQ+jiWWf3Df3wp4iAirpJzxJRK1i
        5POVMp6l0m74k+aHZHljmNWcuvmIN+U=
X-Google-Smtp-Source: ABdhPJzB2Q9RepcfZQEtR5vCMuF6PzNROO/pcQqypGex1cAUlf4K5PmHc48jLnL6J6oh4dvpLeyXmg==
X-Received: by 2002:a05:620a:c0c:: with SMTP id l12mr206532qki.318.1628704323032;
        Wed, 11 Aug 2021 10:52:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16sm4728506qki.19.2021.08.11.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:51:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 10:51:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Jean Delvare <jdelvare@suse.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: hwmon: Error handling in w83793.c, w83791d.c, w83792d.c
Message-ID: <20210811175120.GA3138792@roeck-us.net>
References: <20210811161515.17842-1-lutovinova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811161515.17842-1-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 07:15:14PM +0300, Nadezda Lutovinova wrote:
> In w83793_detect_subclients(): if driver read tmp value sufficient for 
> (tmp & 0x08) && (!(tmp & 0x80)) && ((tmp & 0x7) == ((tmp >> 4) & 0x7))
> from device then Null pointer dereference occurs.
> (It is possible if tmp = 0b0xyz1xyz, where same chars mean same numbers).
> 
> It can be fixed just by adding a checking for null pointer, patch for 
> this is in the next letter. But a question arised:
> The array w83793_data->lm75 is used once in this function after switching 
> to devm_i2c_new_dummy_device() instead of i2c_new_dummy(). And this 
> function is called once (from w83793_probe()). Maybe this array should be 
> deleted from struct w83793_data?
> 

That is part of it. However, the entire code is wrong. There is no need
to check for I2C address overlap in the first place, and the i2c address
for the second 'virtual' chip should start with 0x4c, not with 0x48.
See w83793g/w83793ag datasheet, section 8.3.2.2.
I assume the code was copied from w83791d and w83792d, where the addresses
can indeed overlap.

Guenter

> The same situation in w83791d.c and in w83792d.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
