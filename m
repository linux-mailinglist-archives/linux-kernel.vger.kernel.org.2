Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C8432820
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhJRUEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:04:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DEC06161C;
        Mon, 18 Oct 2021 13:02:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y15so2205482lfk.7;
        Mon, 18 Oct 2021 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SpMtLYIU8GJOowBSTYnjNHZ0yjAXLuxDZPqe7TMEks=;
        b=mJsXNq2NKeHSjXOyqVIIB4BB1pJNTSJ/Kc47zJwoUU6lbh31g7EqdVzViaG+f/EfQj
         7p5k/YjPwaG9GPcByveoyAXlk+shCIK5KtAqDo2usfBWoXTm3cVSbiSdnJptIaCMS86E
         D//hIkDV6fbLcamZSudNvF7YalwLFT2gjyJsW0yPM0936s8nht3E7d1eMYsHBEigl+oI
         aF7zwMEQQm1VbNpOZXz23042nWV6Q1ifAimL0Q+5+rc8sShCqIDa3DyiFG0jIH+e6gE4
         x0VPK7mXotHa+W9vq4JvB8Sk8tDB7qReSoG8J7CDgkjlwEUJlB4iS3KDod2iSIMx1pBn
         qPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SpMtLYIU8GJOowBSTYnjNHZ0yjAXLuxDZPqe7TMEks=;
        b=NLhjRdNzeWdBqZk9rVa2/MdL0Glmce3izJj1wbj6nnFuFUHeUAlsqhJvDxPaTWVEAq
         5OnPXHrOXCopds6b81cVAg46t0VGh3eL10M/AsoEwruG53gv+UTMhfzFStkVt9WEwqY2
         6VZ5da0Hi+tOPaQnGixyuOfSSw255OAocBDK3RPx26nBCCKAHnFMSaRHLkV8iex4LcFW
         J94vfjpuVhKgxx1q+P67EFOnHOVPUIxpOBhIE/Drb6SxAmv/TZdmy+saWRVdfV7+UpQk
         1ZNU7O76EXn80tW+9YUDeTIeQQPeIyV8d8DA1zJwRr4qtkxoiecuvA6Ra1jmLHyv+J4s
         R1dg==
X-Gm-Message-State: AOAM530YJgwtiCzbwwSKZ1W9CSXyEraXjUGSaoagPEyIGfQmn9TJFqjc
        1DdXeADulhXkuF+JQFbaIhk=
X-Google-Smtp-Source: ABdhPJyNDv8ZGYSSyt4UUvjM+/1JnYCawxpOkxSmGsCcZFNeq7vyHL7VyFOWLMgg4fnfPgYiwsn8sg==
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr1756100lfr.295.1634587321267;
        Mon, 18 Oct 2021 13:02:01 -0700 (PDT)
Received: from penguin.lxd ([94.179.7.157])
        by smtp.gmail.com with ESMTPSA id q189sm1700147ljb.8.2021.10.18.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 13:02:00 -0700 (PDT)
Date:   Mon, 18 Oct 2021 23:01:53 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <20211018230153.6615e4bd@penguin.lxd>
In-Reply-To: <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
References: <20211015055808.327453-1-pauk.denis@gmail.com>
        <20211015055808.327453-2-pauk.denis@gmail.com>
        <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, 15 Oct 2021 11:21:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
...
> 
> > Reported-by: kernel test robot <lkp@intel.com>  
> 
> New code can't be reported as regression. Or what did you mean by
> that?
> 
Just that i have applied changed recommended by test robot. I will
remove it.

> ...
> 
> > +Kernel driver asus-wmi-ec-sensors
> > +=================================
> > +
> > +Supported boards:
> > + * PRIME X570-PRO,
> > + * Pro WS X570-ACE,
> > + * ROG CROSSHAIR VIII DARK HERO,
> > + * ROG CROSSHAIR VIII FORMULA,
> > + * ROG CROSSHAIR VIII HERO,
> > + * ROG STRIX B550-E GAMING,
> > + * ROG STRIX X570-E GAMING.
> > +  
> 
> > +Authors:
> > +        Eugene Shalygin <eugene.shalygin@gmail.com>  
> 
> reST has a special keyword for that.
> 
> ...
> 
Do you mean something like?
---
Authors:
    - Ed Brindley <kernel@maidavale.org>
---
I have found only such example in other Documentation/hwmon/* files.

Best regards,
    	Denis.
