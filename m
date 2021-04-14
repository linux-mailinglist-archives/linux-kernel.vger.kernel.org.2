Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35E335F8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352711AbhDNQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDNQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:25:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A04C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:25:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so32351004ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iP7KGYih0ScL9NDo4YHcxu5ievJ0k08+ogShzicxdcI=;
        b=yicn4QCpRAW4psE8yFGxsrVdKLQvpoxJJILCW/xOysKBCPsxr04f1+yIOBoiq+en/W
         AWHC0EojiRGsfCu+UHy8BPb4ZhIXU35KpFPh5aBgTpazizLnf8v9YMSDpBCBHjEiCwU5
         ZYoQuxKqArnLxcEgorwAJh5ZJMbTPx4wfa+M3Q4YmoXrhHJ2EciAqZ0f0DT8jGTKT/Ov
         C/Cfr7ICwGgn8KMVRf4Aim/5svCUIxJV6cgfVG79ztVHkuXdY8kjbyhUpeaPbOcBh3Xh
         IpvR3LKXHoEteLXkQh+Xtuxb1mpn4kEDXdToZzaeKz1guV7RVsssfms+/nB58C1POa2A
         sy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iP7KGYih0ScL9NDo4YHcxu5ievJ0k08+ogShzicxdcI=;
        b=rVWWuAPIHnOQPL6NzB3amTekVia1bZ5dzpfKNzz82MJvpRLZF+At6v4YrGKOtnWOK+
         LAQSpMEd70CcVh2jlDQ0IXLk/yC+0lpbDaJoI4Tkcvo5aiecf9reWS16ixW0ht3EQnXI
         Ecml/yBoUFN18fkY0OptpCTersLBpht3wutianpnGUW2iFmTnh/TeX1oRm2S3KTw3Ww4
         kv2CxPDERKdJj436g6CABq5ykXbhMC6R2nQHTnZov6BKrPJBHMqUQeXaL62N7H2UcfSL
         +wNSHOOwfK1lWl57H6YZNDVrCAN5lK/dftfHAb8SUP/aqKQ/U+tb5mZ1n05BDFGYqc1B
         qGcQ==
X-Gm-Message-State: AOAM533XrMEXy5Zg14lBi2I7V5G3FLuugbHQUbmxRZHUXa0iLUZ4kAT9
        VOs7gQAqTCUEyQsIEq7WkiVVOQ==
X-Google-Smtp-Source: ABdhPJzj/VkYQmA6hewZS4HCBdddVZJyTjlKToqN7L4xUMN2MR0fcKB4SBKxRtX20NtKVUNqOb1ZeQ==
X-Received: by 2002:a17:906:a103:: with SMTP id t3mr39048501ejy.334.1618417521254;
        Wed, 14 Apr 2021 09:25:21 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id u4sm19631ejf.11.2021.04.14.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:25:20 -0700 (PDT)
Date:   Wed, 14 Apr 2021 17:25:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v9 1/1] mfd: intel-m10-bmc: support for MAX10 BMC Secure
 Updates
Message-ID: <20210414162518.GP4869@dell>
References: <20210412195329.241357-1-russell.h.weight@intel.com>
 <20210412195329.241357-2-russell.h.weight@intel.com>
 <c7044c0a-b3fb-837d-137f-fdb9b1d42847@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7044c0a-b3fb-837d-137f-fdb9b1d42847@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021, Tom Rix wrote:

> 
> On 4/12/21 12:53 PM, Russ Weight wrote:
> > Add macros and definitions required by the MAX10 BMC
> > Secure Update driver.
> > 
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > v9:
> >    - Rebased on next-20210412
> > v8:
> >    - Previously patch 1/6 in "Intel MAX10 BMC Secure Update Driver"
> >    - Rebased on next-20210121
> > v7:
> >    - No change
> > v6:
> >    - No change
> > v5:
> >    - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
> > v4:
> >    - No change
> > v3:
> >    - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
> >      Update driver"
> >    - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
> >      underlying functions will be called directly.
> > v2:
> >    - These functions and macros were previously distributed among
> >      the patches that needed them. They are now grouped together
> >      in a single patch containing changes to the Intel MAX10 BMC
> >      driver.
> >    - Added DRBL_ prefix to some definitions
> >    - Some address definitions were moved here from the .c files that
> >      use them.
> > ---
> >   include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
> >   1 file changed, 85 insertions(+)
> > 
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > index c4eb38c13eda..f0044b14136e 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -16,6 +16,9 @@
> >   #define M10BMC_FLASH_END		0x1fffffff
> >   #define M10BMC_MEM_END			M10BMC_FLASH_END
> > +#define M10BMC_STAGING_BASE		0x18000000
> > +#define M10BMC_STAGING_SIZE		0x3800000
> > +
> >   /* Register offset of system registers */
> >   #define NIOS2_FW_VERSION		0x0
> >   #define M10BMC_MAC_LOW			0x10
> > @@ -33,6 +36,88 @@
> >   #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> >   #define M10BMC_VER_LEGACY_INVALID	0xffffffff
> > +/* Secure update doorbell register, in system register region */
> > +#define M10BMC_DOORBELL			0x400
> 
> To be consistent with the existing register #defines,
> 
> The bit values for the register should follow the register and have a
> M10BMC_ prefix

This patch has been through 9 revisions and has been merged already.

Any changes will have to be submitted as subsequent patches.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
