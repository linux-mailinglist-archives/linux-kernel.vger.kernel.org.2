Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C884B4170EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbhIXLhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbhIXLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:37:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAACC061574;
        Fri, 24 Sep 2021 04:35:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z11so14101023oih.1;
        Fri, 24 Sep 2021 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+p9pHwAPxHd43foSyMEwPagB9wdIt/zyt+VQKZNP3eo=;
        b=HiS/u+H/HjibyGwJGxTwjkT/5swlq0yD6RKI9t4ifff3qzcryhxbleZrcRwwUuYxRU
         Eh7rsp4/yqcbD1Ix67m20OpQeeoxF7XesDtG3d6UxMpFM+KD2C+7C0WnZLlvCioffEhY
         b+F7c5bkF06WortTmjJZsrtOCA42GcSlnz2JcEC+gdrQ9e8cLCRyhwR+phSzFXnimF+P
         e/v5cOKha5eEFbvSSHKb48401wB5jf4dDqwSiwb/dLOuRRvdhq7pDrhFb0am3P0QixZk
         k1FAvhnKoQhkxTmFVkuAu/7go+Pih6ftUd9cImjOgPRHqMP75WnRSkIgG2m10wviyhyx
         F0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+p9pHwAPxHd43foSyMEwPagB9wdIt/zyt+VQKZNP3eo=;
        b=wCtSPW6XjeH8Yoxy5ehYUhdBNroPTtKaFvXCcKBcTfv+3jTVWj+Kl6h/0ymS3ueEat
         a9xUufLNWNtnGQUh9ufCT8rpi25SN6eNA15uy9A8P+VbQd7h3rWwgovwVAKAEv5aDshf
         VUawGkeqUfJt4zkxTjt7Lx1GXL4LEnvouV6djCDDWCg9vlGzbsniCYXNDhTkHqYrJuI1
         jH97hbW/30wz8v5UtTkP5ED5gk3KqC5sXgPM6znUikFV/M9quFAFGj2g3eT/v3z4mT9J
         jMs9u22k7mUzebvmcF9nY1XpHpPIYwUNDixfVczwN8A9fpu+auxZdT8ZfLhcf5j88ni3
         CD0w==
X-Gm-Message-State: AOAM533iiAiBIaVI8reTj0+ovACZ8wU5VuxCVG3m+oTYviK0TzDx3Uqf
        O42IzcFOtou/6TU2k9Pr0oI=
X-Google-Smtp-Source: ABdhPJyDv5lNvZ1B0LRfq0GzhzA+sDXj1A9UQyLBF43PemuwWhnvajJ+w2RTk+/u1th75aeeIEwFqQ==
X-Received: by 2002:aca:be56:: with SMTP id o83mr1040562oif.51.1632483349201;
        Fri, 24 Sep 2021 04:35:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1sm1985794ote.41.2021.09.24.04.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:35:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 24 Sep 2021 04:35:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: tmp421: handle I2C errors
Message-ID: <20210924113547.GA2694238@roeck-us.net>
References: <20210922155323.GA3205709@roeck-us.net>
 <20210923094801.23332-1-fercerpav@gmail.com>
 <20210924022020.GA3032273@roeck-us.net>
 <20210924074450.GU23326@home.paul.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924074450.GU23326@home.paul.comp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 10:44:50AM +0300, Paul Fertser wrote:
> Hello Guenter,
> 
> On Thu, Sep 23, 2021 at 07:20:20PM -0700, Guenter Roeck wrote:
> > > --- a/drivers/hwmon/tmp421.c
> > > +++ b/drivers/hwmon/tmp421.c
> > > @@ -93,7 +93,7 @@ struct tmp421_data {
> > >  	struct hwmon_channel_info temp_info;
> > >  	const struct hwmon_channel_info *info[2];
> > >  	struct hwmon_chip_info chip;
> > > -	char valid;
> > > +	bool valid;
> > 
> > This is a cleanup, not a bug fix, and it isn't even mentioned
> > in the patch description.
> 
> For the bug fix I needed to add a line setting data->valid to false
> and was reluctant to assign 0 instead as it would be adding more wrong
> (type-wise) code. But since you say that's the way to go, sure, will
> do.

I figured that much, but it is still an unrelated change. I don't object
to making that change, but it should still be a separate patch. FWIW,
I don't mind if it is in a single patch if the code won't be applied
to stable releases, but it should still be mentioned in the description
(eg: while at it, convert 'valid' to boolean).

> 
> Regarding the cleanup, I see hwmon has many examples of "char valid"
> and so it might make sense to do them all at once. What would be the
> procedure here, is that a desired change at all and if yes, how to
> approach doing it? 

You could write a coccinelle script to detect and convert all uses,
then submit a single patch to convert all drivers, with the cocconelle
script as reference in the commit log.

Guenter
