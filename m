Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54B5456278
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhKRSjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhKRSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:39:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:36:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q17so5993384plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2OXSIkw3oGDVr4Swch69o3actW5wzxgNgyJjuFMSiU=;
        b=cW/iUYHrxm4bAann0OPgYnEZuL8P5ZvXoXoUOrrOJI8vOT+9dzOIzqUxZ9SizuIND1
         lBtGAC5ynCPsGETz3Mb7kbfL8qwRoqSrJDF4HVvXkhchVojRLPaMw1JLOVFds1OzR1Gx
         okIAGunN94pXyO/BYxJ33x+pXY6G3FvhBvVTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2OXSIkw3oGDVr4Swch69o3actW5wzxgNgyJjuFMSiU=;
        b=wx9G22jQHNV0pEEV3OtG2EHwwp0IFXOBDeIE/dzcCjtFCP3EZpu4mh4FQvkRNJcUMi
         WW22ddgTGTNgRqF9PHTSW74MR5kgeFObDUEdpgcwMEimfYyZM2HXXapG93GBJiYJoNAI
         uqmKrQaNr3PJ12Rq2IFwg4UU7hubmvWW5Nsg9wicP03UCqm9a3gWMC2s7Sxrx7kOqYMo
         r5nRCW0IqT5MLI78UjCVQTj15zx1us9sA7JZM2vfpL1DEUxdHb4E4spsqZVF0vIKtdE0
         KKNDdQ8I/gpCF8U/xG+eGVOlyhHY8xdXaT1jBpsO7wO0Ephzqz4TRn65GyTJQHxGKUSg
         Z3Ew==
X-Gm-Message-State: AOAM530z2t9xUkzw20gHmZTv0Pm2dCiwwl0rfc/yvv29Sb+FMkwiKrbU
        OMMj2YnImoWE0uqt8KjSTzFQAw==
X-Google-Smtp-Source: ABdhPJwRKYQOjPJQWIrEcGdhpbaPxIA4gBG+BmIGd9PAE7iEqrqu/mkC6OkSgbxnlZJ39G3jdnxWbQ==
X-Received: by 2002:a17:90b:1892:: with SMTP id mn18mr13185455pjb.178.1637260566832;
        Thu, 18 Nov 2021 10:36:06 -0800 (PST)
Received: from localhost ([2620:15c:202:201:8ceb:c68a:21af:bebe])
        by smtp.gmail.com with UTF8SMTPSA id h25sm285646pgm.33.2021.11.18.10.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 10:36:06 -0800 (PST)
Date:   Thu, 18 Nov 2021 10:36:05 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>
Subject: Re: [PATCH v17 1/7] usb: misc: Add onboard_usb_hub driver
Message-ID: <YZadFV6tuEyDKjgm@google.com>
References: <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <202111190233.KiLjufx1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202111190233.KiLjufx1-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 02:13:52AM +0800, kernel test robot wrote:
> Hi Matthias,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on driver-core/driver-core-testing linus/master v5.16-rc1 next-20211118]
> [cannot apply to usb/usb-testing]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/usb-misc-Add-onboard_usb_hub-driver/20211117-040918
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/faa2d834f6d4083b63ab466134738d1befaa83b6
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Matthias-Kaehlcke/usb-misc-Add-onboard_usb_hub-driver/20211117-040918
>         git checkout faa2d834f6d4083b63ab466134738d1befaa83b6
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "device_is_bound" [drivers/usb/misc/onboard_usb_hub.ko] undefined!

Looks like device_is_bound() needs to be exported to use it from a module.
