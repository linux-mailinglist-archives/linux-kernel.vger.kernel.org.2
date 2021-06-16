Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577F03A8E88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhFPBs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhFPBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:48:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0CC061574;
        Tue, 15 Jun 2021 18:46:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t140so809033oih.0;
        Tue, 15 Jun 2021 18:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z4DodPexuFXJM3ooqAYXD9b+NvarcFc46B5kVfXrpkY=;
        b=D8WasroVcI2LvuRBJYcfwM7jL1YPp9UKZJfEMiI4HtiiRdqYdfTEDqkBZ2d0P943aR
         //v4Y18ojXIKC8uQqk0mZ42SydQHhiJND/WhiZZmvXSH30+QVN4pK/ZobagFJXBD26VC
         co4l/Tpuh+3HZhpyZw6drzYqUZdSKeCsbv3vgGOnCNJhVdBifPsGrf6c/lCB5M4tB81H
         Z46hRZ5xQ5plLa5DXCiolaGBp4DYJk7FhnA8cuKNwCSZHELgnG2nvI7ssOIbxmAUd8tI
         XzHNB0jSKe4HvFygqSgNn5zg3Kg6zYocACZaRshT421DjHTyf5wMBqJ9Wgt2eYhUfNfF
         /a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z4DodPexuFXJM3ooqAYXD9b+NvarcFc46B5kVfXrpkY=;
        b=kSzWnIHJwMK032HZExLgVDAflEy/Nhmga0fDzmHfx+dKmdCJ69OqSuLlc5HPALgKSQ
         FBdT3ehTBYwJHA9zw0RMuQGW0tOQG5Ri8MruMeakObzXUHTuZ2RGYeJdBKHxPi6q3rDw
         pXySRDr3GJLKtLQLPwAcE5Lwlg8tH5IvJqFRMB9ofirufvIdQrF54fRmFoZ+2sCGZfaQ
         makz5fmhwU/wmKZDdUNzx2/JOzyRpoWBukyDTswWN2O+PDJK1mruKkAH10FawecZftCZ
         zlVkW9LE3gpa8XFp8cq1f3T/ZpiacHCR+Cbh9BIjV7f8YvkZphPQPmaTMnCdK+ocGAlF
         377A==
X-Gm-Message-State: AOAM533k89LEeCAmZvrj4Ol7bbTT4+Rgo5Zxf859JFPzwJ7vbX5oXO0o
        ED6UTelbXFRPlbnZPvKCkDGAnYMD1w4=
X-Google-Smtp-Source: ABdhPJz4Q1EA2WPCX2VETEFcFRAzcNaq+9QqtWlJgD7OHRHNS6gm6xInukD5N5NPAWaPbhZB8YkpMQ==
X-Received: by 2002:a05:6808:4c2:: with SMTP id a2mr1346134oie.63.1623807979821;
        Tue, 15 Jun 2021 18:46:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4sm174027oth.30.2021.06.15.18.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 18:46:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Jun 2021 18:46:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pmbus: dealing with unsigned mantissa in linear reading
Message-ID: <20210616014617.GB969448@roeck-us.net>
References: <67dd830c-c40f-b555-2b4e-3b7d383ef2c9@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dd830c-c40f-b555-2b4e-3b7d383ef2c9@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:34:53PM +0000, Chris Packham wrote:
> Hi Guenter,
> 
> I've had a report from someone testing the BPA-RS600.
> 
> When they have the input voltage set to >= 256V (apparently the PSU can 
> handle input up to 264V). The Vin reading goes negative.
> 
> CMD 0x88, VAL=0xf3f8, Vin=254
> CMD 0x88, VAL=0xf3fc, Vin=255
> CMD 0x88, VAL=0xf400, Vin=-256
> 
> Looking at pmbus_reg2data_linear() the mantissa is cast to s16 which is 
> correct according to section 7.1 of the PMBUS spec which says that the 
> mantissa is an 11-bit two's complement value.
> 
> It seems that the BPA-RS600 is using a non-standard format for the 
> mantissa (probably because the range of the standard linear encoding 
> can't support values >255V). Does the pmbus infrastructure provide a way 
> for me to define a custom format/conversion for a given sensor?

Essentially you'll have to implement a custom read word function and
convert the value reported by the power supply to a valid linear11
value. In this case, you may have to shift the reported value by 1 bit
and increase the exponent by one.

Not sure what you mean with "standard linear encoding can't support values
>255V". Why not ? That is what the exponent is for, after all. It rather
seems to me that the PS vendor decided to violate the standard to get
another bit of accuracy. 

Guenter
