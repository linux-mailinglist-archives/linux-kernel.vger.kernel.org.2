Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162413185F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhBKH53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:52:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B513C061797
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 23:52:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fa16so2947416pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 23:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=06Yprus+hDrW2/xZYx/mlg+VxWu/BiZE+sW68Jmo1RI=;
        b=Ra6kYfi1+ZunK+HKHgtBU6GmKSsL+3PXTyKBlp2Te91gDQ+k3OFcoTzcZuYbf0YKox
         g2O7fkQAmi8uN/PS6M6qSqjJ7oroSwB0cG6KYReSyAAaoy4LEl8/T/BRNWoOIZOWWaAn
         lxRTTfd8BweGMjMB6gP0AZq1xWVOdz1ONAaxnJSVDy2iXF2BqaE9LOA1UJmKlNsoKndj
         JRSkby1T/HI0M2h/OGKTaxxrWM6rI2LYib9K/ZJB5oz+7bKyXgBFyWa3pPmchZi1GgJP
         hA8fC03P7H61aIfhoAHk61fSf4rhuUnEgpPsvnKsjMcCWVnaDoBtOwPC5yITh+AfZISA
         lrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=06Yprus+hDrW2/xZYx/mlg+VxWu/BiZE+sW68Jmo1RI=;
        b=lqBZx2l9C5Cn6RG0/SIl/4AmVZyg0aSSKs/P1Mh8F2KbnzJ6yp/YWbSi4/XVcKO3Jc
         cFX2TxA1ZE1TjOl9DeDu2sgRgUE0F2BANdy63ktMPu8QFdYyccSuI3TJPmMnXavsDDJk
         D5uOUu7eFq3f085n2nanbqXKj3/iZPr5BRb6J91B5UF0wcDmuvfcN2KA48L4jJgtZu5P
         pYfrjOOM/0n/WEcCkYtd6UGiVmp4RwDCWLWStbhJI1NoPTJfGe9nUp93HUg4v2cb7KPI
         bBOvDCRX/LUoY4ydjB5BZ5BVhJzUN3AuAMoa/TlOEpfhtb1M2KsVDDGoJcUkSGndArAK
         6SAg==
X-Gm-Message-State: AOAM533Q306/aC48IljtoG6EoCRBH5i5lKurkq/riZLHzP1pLPHwgXgP
        zPewxKti0dqviOT+B93Ee2EaAEWtjtH5SA==
X-Google-Smtp-Source: ABdhPJyy0FX3Oitq2i/n8vZ/zcw0IGZLhXbnM/DumP0UFq6ucImVOTkrrFRRQq21ahUAErD/li4k6A==
X-Received: by 2002:a17:902:fe03:b029:e1:2c46:f3fd with SMTP id g3-20020a170902fe03b02900e12c46f3fdmr6683457plj.62.1613029928698;
        Wed, 10 Feb 2021 23:52:08 -0800 (PST)
Received: from x1 ([2601:1c0:4701:ae70:3a7f:bbfb:1664:2a63])
        by smtp.gmail.com with ESMTPSA id r189sm4731832pgr.10.2021.02.10.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 23:52:08 -0800 (PST)
Date:   Wed, 10 Feb 2021 23:52:06 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 1/2] pinctrl: use to octal permissions for debugfs
 files
Message-ID: <20210211075206.GA295123@x1>
References: <20210210222851.232374-1-drew@beagleboard.org>
 <20210210222851.232374-2-drew@beagleboard.org>
 <408ca31f3f43f4db40998f607f582aeb0ffbab1e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <408ca31f3f43f4db40998f607f582aeb0ffbab1e.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:36:39PM -0800, Joe Perches wrote:
> On Wed, 2021-02-10 at 14:28 -0800, Drew Fustini wrote:
> > Switch over pinctrl debugfs files to use octal permissions as they are
> > preferred over symbolic permissions. Refer to commit f90774e1fd27
> > ("checkpatch: look for symbolic permissions and suggest octal instead").
> > 
> > Note: S_IFREG flag is added to the mode by __debugfs_create_file()
> > in fs/debugfs/inode.c
> > 
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Drew Fustini <drew@beagleboard.org>
> > ---
> >  drivers/pinctrl/core.c    | 6 +++---
> >  drivers/pinctrl/pinconf.c | 4 ++--
> >  drivers/pinctrl/pinmux.c  | 4 ++--
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> > index 3663d87f51a0..02f8710afb9c 100644
> > --- a/drivers/pinctrl/core.c
> > +++ b/drivers/pinctrl/core.c
> > @@ -1914,11 +1914,11 @@ static void pinctrl_init_debugfs(void)
> >  		return;
> >  	}
> >  
> > 
> > -	debugfs_create_file("pinctrl-devices", S_IFREG | S_IRUGO,
> > +	debugfs_create_file("pinctrl-devices", 0444,
> >  			    debugfs_root, NULL, &pinctrl_devices_fops);
> > -	debugfs_create_file("pinctrl-maps", S_IFREG | S_IRUGO,
> > +	debugfs_create_file("pinctrl-maps", 0444,
> >  			    debugfs_root, NULL, &pinctrl_maps_fops);
> > -	debugfs_create_file("pinctrl-handles", S_IFREG | S_IRUGO,
> > +	debugfs_create_file("pinctrl-handles", 0444,
> >  			    debugfs_root, NULL, &pinctrl_fops);
> >  }
> 
> Why aren't you also converting this block in the same file?
> 
> @@ -1890,11 +1890,11 @@ static void pinctrl_init_device_debugfs(struct pinctrl_dev *pctldev)
>                         dev_name(pctldev->dev));
>                 return;
>         }
> -       debugfs_create_file("pins", S_IFREG | S_IRUGO,
> +       debugfs_create_file("pins", S_IFREG | 0444,
>                             device_root, pctldev, &pinctrl_pins_fops);
> -       debugfs_create_file("pingroups", S_IFREG | S_IRUGO,
> +       debugfs_create_file("pingroups", S_IFREG | 0444,
>                             device_root, pctldev, &pinctrl_groups_fops);
> -       debugfs_create_file("gpio-ranges", S_IFREG | S_IRUGO,
> +       debugfs_create_file("gpio-ranges", S_IFREG | 0444,
>                             device_root, pctldev, &pinctrl_gpioranges_fops);
>         if (pctldev->desc->pmxops)
>                 pinmux_init_device_debugfs(device_root, pctldev);
> 
> 
> 

Thank you, that is a very good point.  I should have included those
calls to debugfs_create_file() in the patch as well.  I will fix that
in the next revision.  It looks like I also need to change how sscanf()
is being handle per the other thread of discussion.

Thanks,
Drew
