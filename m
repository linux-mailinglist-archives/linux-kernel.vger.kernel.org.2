Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54B388D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353158AbhESME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhESMEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:04:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6627C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:03:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z130so7144925wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o3LfSzRyhixcXxomWmxdvec6SZ9Wlq6bPaub1d1bIoc=;
        b=o0XEOaE+eJKuweKUIXOFc43Wyun9W11HQto5KxeOYOw2/+wE0TlSYRlFV3o9m8EkDL
         tI5lH27HOEMfMBivvEWJ/74LnFz14EUOxb8dJVpmno5Sta01pZpcwSPnJS6FzW814wJI
         TYCpH1ahGdUuciU83vcn8hPhR9ORRU7zUh+QMj7PYfVcKdVplTv1nBc6ocEop/+mFrYD
         RrEW/qeY5L2RPQvIJieYImD4tlFSJ6DLUA49OLz9wvhTtK4y6XnTCGQ71bPwNWWJT3K/
         rmEC3iaJWjgx3crpgM1p170ycoi6b3JFNEYikBwYWj11L2MrnU4TtUqtDSJQLFZ19tUn
         Nz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o3LfSzRyhixcXxomWmxdvec6SZ9Wlq6bPaub1d1bIoc=;
        b=WkSkOIbS2Gfe9gZCP01OzTai0uxq7KRqiGlxE3zvGawUN/e7YUBcZ5BtHosKO288DE
         ciecx+cZuuBYS/jyU/cjO8PAwYt0rqjBkwNMiVTELjWbM5UWL4QtAYT4SmOV0Svqyhvs
         ZdA230hiN630ii93GqEUw14MuS4muJVGPWNFt4/M0FEw/CkXkbbdzspg23xtmG1XeFTu
         1TugSGJ7WMBfQzt3Yf5wyDNcmm8/X7uaRJPJvNZVV8zk3J0nM40ZQmNXWu2GoXt3Kfgo
         HK+SFKEgMCpdLqzO2Gh9YwUjyL2PxM3RtFYex/Xrk6LOAxYNCLXL50qHnqsnncpOAzsU
         0ASA==
X-Gm-Message-State: AOAM533Q4kxCAHP23ayfkBi+7h9r2z9cXoeGOJtFHmiNw8V9ndMNF0m7
        f9OPY31o9MaNfT1yQYPZJmPmAbrDESUDrA==
X-Google-Smtp-Source: ABdhPJzRBm+0qVXy1+H9YSgyw5QH5IXxt9u1AgZ9HHAfUdmS68Kqg3s2zyHluFrzBTI7LUcJPNJh3g==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr10759597wmh.86.1621425784317;
        Wed, 19 May 2021 05:03:04 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v12sm23736159wru.73.2021.05.19.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:03:03 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] mfd: Remove software node conditionally and
 locate at right place
Message-ID: <20210519120302.GH2403908@dell>
References: <20210510141552.57045-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510141552.57045-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Andy Shevchenko wrote:

> Currently the software node is removed in error case and at ->remove()
> stage unconditionally, that ruins the symmetry. Besides, in some cases,
> when mfd_add_device() fails, the device_remove_software_node() call
> may lead to NULL pointer dereference:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000
>   ...
>   EIP: strlen+0x12/0x20
>   ...
>   kernfs_name_hash+0x13/0x70
>   kernfs_find_ns+0x32/0xc0
>   kernfs_remove_by_name_ns+0x2a/0x90
>   sysfs_remove_link+0x16/0x30
>   software_node_notify.cold+0x34/0x6b
>   device_remove_software_node+0x5a/0x90
>   mfd_add_device.cold+0x30a/0x427
> 
> Fix all these by guarding device_remove_software_node() with a conditional
> and locating it at the right place.
> 
> Fixes: 42e59982917a ("mfd: core: Add support for software nodes")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/mfd-core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
