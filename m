Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41BB39E5ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFGRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:54:52 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42507 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFGRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:54:50 -0400
Received: by mail-pg1-f181.google.com with SMTP id i34so7987401pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1+hC4jDqPM58kpx66LtUqJzj+w3XNmbkGX8CdTflUmA=;
        b=MDns8eYB6RZNAQ4wBED2dsD5GiDkCO2cko4h/uPIn6GHuDTVS3gLEN0xyQzwvhQ2Dg
         ZLd7v3GSjkrHg7dtMe/sb0BFexpFt8KqXY8bWoIwfsmy1RK98AFq+yH2O7ulFDwzSs2b
         oWS1P0X16e1akyq/TwoWPFKfLBk9f410pVAMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1+hC4jDqPM58kpx66LtUqJzj+w3XNmbkGX8CdTflUmA=;
        b=kCYrsn16ly+5vwjJc5HY7ZsT8WwsBTR+aWcj6XAVqPe86+6t1H8cUBDevjgoLqmR3V
         KpTm156ZcXst+D3OV5X7Av4dcn+wxoGJvhJNnZ/hDnOdx7OdLmqovaIw/yaVCOuvwZAr
         L6rxukeucVANuJPORa9aNMEUaN+qrdNmJ+2GAYwXtOH1voo4sExZHMX1eFC8mO/gRGWq
         kCxhB9O8F8iOVRxpl8IjdEgb66pPxK8t2XE1ipL5U2AMqhHh6suik1lneQYx/B/pMuTj
         zXRR6UOe7QyUN7Ugo2EKbkrSKvS9PRyWfWHH7NO+XKXhiyBPGyq2x14MgeWu0bsiP8Qm
         XXcQ==
X-Gm-Message-State: AOAM5332CUfuvtbugJdP010eE/j19fYaTjRPGQQenqSHJ4WDfu3Lg4BR
        vVFY5DnClxFX8qHzoYWn5Umf5A==
X-Google-Smtp-Source: ABdhPJy+GUOTNXt083R9TamNiexgcpKHDyGntTxQJQ/FIvuuinVtlqz31dLtnK36+42VxiYlYHd+fw==
X-Received: by 2002:a62:4e86:0:b029:2ea:25ce:b946 with SMTP id c128-20020a624e860000b02902ea25ceb946mr18707070pfb.30.1623088319105;
        Mon, 07 Jun 2021 10:51:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:312d:da15:9317:e223])
        by smtp.gmail.com with UTF8SMTPSA id e21sm12885304pjh.55.2021.06.07.10.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:51:58 -0700 (PDT)
Date:   Mon, 7 Jun 2021 10:51:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        kbuild-all@lists.01.org, Michal Simek <monstr@monstr.eu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YL5cvT4NvMLIuH+C@google.com>
References: <20210604144027.v11.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <202106050751.uNo0uAEm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202106050751.uNo0uAEm-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 07:18:38AM +0800, kernel test robot wrote:
> Hi Matthias,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20210604]
> [also build test WARNING on v5.13-rc4]
> [cannot apply to usb/usb-testing robh/for-next char-misc/char-misc-testing driver-core/driver-core-testing linus/master v5.13-rc4 v5.13-rc3 v5.13-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/USB-misc-Add-onboard_usb_hub-driver/20210605-054213
> base:    ccc252d2e818f6a479441119ad453c3ce7c7c461
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/7107f99a12058b7147342c6f763d026102bd6606
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Matthias-Kaehlcke/USB-misc-Add-onboard_usb_hub-driver/20210605-054213
>         git checkout 7107f99a12058b7147342c6f763d026102bd6606
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/usb/misc/onboard_usb_hub.c:400:6: warning: no previous prototype for 'onboard_hub_create_pdevs' [-Wmissing-prototypes]
>      400 | void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/usb/misc/onboard_usb_hub.c:458:6: warning: no previous prototype for 'onboard_hub_destroy_pdevs' [-Wmissing-prototypes]
>      458 | void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~

Oh, I wasn't aware that prototypes are required for public functions.

To avoid too much version churn I'll wait a bit for further comments before
sending a v12 with the prototypes.
