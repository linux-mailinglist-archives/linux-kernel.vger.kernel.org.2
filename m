Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D339B926
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFDMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:41:37 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:45885 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:41:34 -0400
Received: by mail-qt1-f173.google.com with SMTP id l17so2689077qtq.12;
        Fri, 04 Jun 2021 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8tFXQQshqxSB1HMy8vDC7vDQu3YTSPaP6sR63Gdou1c=;
        b=rAX+pnpB7Dvclp28To6NqrG6G4zEE6aJ2nCrSNJM6cssUc3AgNkffeQtKWekimrVtV
         L0eYjB5ZjA+K3IJk1WWXf9vHqbS1/VHdOIE26Zs4CaCgfm3+AtzgCi2kEzT/IrXsOS5s
         CYs3RKtn7Cygw7UxH7+C0FbOn8ujhsEL0UNKMZg3FL8ERgTAHva9tF2CqGHhdKUjOXq2
         BiXiipzsM/lSubN2iLC3R9dcoSaXAeseYoXBY45EpKXNCEYfe1IiAWFK9CCvpgix+5HR
         ubzIodtw/ASDfpr0I6MZSObuIXGEf/+6h0PNwKzkJgpRWR1Y8iml3LwhrcTOHks9QkC3
         HJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8tFXQQshqxSB1HMy8vDC7vDQu3YTSPaP6sR63Gdou1c=;
        b=um+LuWgjQdb860ct1h86kmlnd82FCV3LlCyfX55qooBjdL6PDvpkvzNtZGSAPkCI5u
         AoAMEEWoplx2znEKjEXFhMnOUiHNgLQyz/XdkUb602LT8H9d/wzBhpDiGgLYJk5SKP2u
         3NBtCmxFaAgkrGDQRWEkMxvIFg/k7EfiHSOBnVGY79w8sCp0Li4FfoG1Gx7C/yGjZJTI
         n3Rn0IuWKt74Z0CQBgZFqfcrXBlFnpY1vvv4iXllWVylxWKXJJLgZdn8PiCXlF/fXd5C
         arAC2Y/CFJ5UwFuRyxdI+nSxzixgI0mEHded9dX7tH/vF6HosVXiFu9x3cZryxo5MjaG
         MY6Q==
X-Gm-Message-State: AOAM532lj6bFLZ/KhoGAIULb1EDU07RoLGD0R7OT301Md7gJxM8GzR2b
        pVCi9nPXvcEa4ZqdFoLI2pA=
X-Google-Smtp-Source: ABdhPJxlotMgspuEyAtTyWXww/4NIkeRSjCQ1vlG6K+hRbbVDXks6kAI7g42AK7Htj8jNFiXE0jLjA==
X-Received: by 2002:ac8:578d:: with SMTP id v13mr4394401qta.9.1622810312918;
        Fri, 04 Jun 2021 05:38:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12sm1652589qtw.61.2021.06.04.05.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:38:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Jun 2021 05:38:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        Jonathan.Cameron@huawei.com, alexandre.belloni@bootlin.com,
        sst@poczta.fm, krzk@kernel.org, alexandru.ardelean@analog.com,
        devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        jmp@epiphyte.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <20210604123829.GA3939356@roeck-us.net>
References: <20210528103828.53320-1-robert.marko@sartura.hr>
 <479725a2-7d85-1489-4228-ddff16b52287@roeck-us.net>
 <CA+HBbNGu6kkp23wHrnVeM7vry6nT0-P66U0V8KXCQ=kCcs+n8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNGu6kkp23wHrnVeM7vry6nT0-P66U0V8KXCQ=kCcs+n8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 02:16:02PM +0200, Robert Marko wrote:
[ ... ]
> >
> > > +}
> > > +
> > > +static int dps920ab_write_word_data(struct i2c_client *client, int page, int reg,
> > > +                                 u16 word)
> > > +{
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * This masks commands which are not supported.
> > > +      * PSU only has one R/W register and that is
> > > +      * for the fan.
> > > +      */
> > > +     switch (reg) {
> > > +     case PMBUS_FAN_COMMAND_1:
> > > +             break;
> > > +     default:
> > > +             ret = -ENODATA;
> > > +     }
> > > +
> >
> > Does this work ? It is the wrong error message for a failed write;
> > it should probably return -EACCES.
> 
> It appears to work fine, I was looking at other drivers, and all of them
> use -ENODATA for unsupported word registers.

No. They return -ENODATA to tell the PMBus core to use standard PMBus
access functions, ie to handle the access in the core. Please see
_pmbus_write_word_data().

Guenter
