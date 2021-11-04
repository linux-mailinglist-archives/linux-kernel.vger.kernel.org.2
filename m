Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49FE445051
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKDIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:32:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2FAC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 01:29:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d24so7397733wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ghkyarqNnDB/Y/3YhsJn3L40yfD5gAUeaEhu3iM2NF8=;
        b=McRL81hs7UZiC/3Lnw2W+WOYHQQZzX1+Q0DGYBYygh4eZ+1477NbnhDH/CMHbgxkQM
         2m9Sm1M7rW/awLEglfR/wHbnVYDmoxmLGfl4cyt0niJGVn9oZbh14urSj4mLuZVJl7JB
         NZ0xkg7nRHkdkd0w5xGlBlBeMPGn6G//AS9/HSxV8Lcuw5JjeqFPShyR00A0bBUAmD8u
         o8mu9bTc0jBOLrJn2PH8GVHFUykkpAaKmCrofKYQDZY8K64FzydkURZpUBTR/eZpBhzH
         bJqmWyNGr5CDQ6kgeah4UcE2LdiZS53UdM4DAi7Gt2V6iejD0nfUMRnJleYtsc7kfZth
         OJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ghkyarqNnDB/Y/3YhsJn3L40yfD5gAUeaEhu3iM2NF8=;
        b=ItXrTD2F7FFi4OvRFi1LyzAUb7MC8nCvUrxjmjYjGUh0ZBNBSUbCJfKScwu0csOur1
         w6JD2aEXyhgE1ChsGU1X61CjmfnAx3f6yFSsIrl6hDpEY5195EulhCgP8knIyFalKpon
         rXCWzI5+uPoFLn5TPgnYeIOHWUUS+oPb/aggmng0X+Wdt2N7nRbDZ1o18mBUQHnUO9tZ
         RHSnq+rHpNWtgGdpCyyzap37/qJKrXVVnsk7n2vhedY+o8k8PSxud36u2CKdtzF2nH5e
         BOcLub9HqJbX3+BdXfMWk//Q8AkAWjd3c+MWegtRsH9VB/yiCXxfrh1gVIq7v0fnAIMn
         elnw==
X-Gm-Message-State: AOAM530yVTk0uD77oYalOlTKO88aaI/fdDcn/+v9gQxIukpNcK3AWJAe
        ydHNMAdPIVA2l73IgBM50/X+wg==
X-Google-Smtp-Source: ABdhPJzjqTmlaB5EcPKJkTRmpsTFj1DHOMCUEW7CV7MprZs+xQjB/Ok02LX4XBkJ1vohpKd2+F1GdA==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr40788300wrv.278.1636014563955;
        Thu, 04 Nov 2021 01:29:23 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id h18sm4597774wre.46.2021.11.04.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 01:29:23 -0700 (PDT)
Date:   Thu, 4 Nov 2021 08:29:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Message-ID: <YYOZ4TI29Oq6i6za@google.com>
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
 <20211103171756.wxthncse2f4syeiz@maple.lan>
 <5d431db5-30dc-b51c-7abb-ab57a3de2f8f@redhat.com>
 <20211103173107.xlchsysme5xzpn24@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103173107.xlchsysme5xzpn24@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021, Daniel Thompson wrote:

> On Wed, Nov 03, 2021 at 06:28:15PM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 11/3/21 18:17, Daniel Thompson wrote:
> > > On Tue, Nov 02, 2021 at 11:55:04PM +0100, Hans de Goede wrote:
> > >> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
> > >> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
> > >> "XMCC0001", add support for this.
> > >>
> > >> Note the new "if (id)" check also fixes a NULL pointer deref when a user
> > >> tries to manually bind the driver from sysfs.
> > >>
> > >> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
> > >> so the lp855x_parse_acpi() call will get optimized away.
> > >>
> > >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > 
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Thank you.
> > 
> > So what is the process for upstreaming backlight patches,
> > do these go through drm-misc-next (in that case I can push
> > the series myself), or will you pick these up ?
> 
> Lee Jones gathers up the backlight patches and sends a PR (but, except
> in exceptional cases, treats my R-b as a pre-requisite before doing so).

Also the merge-window is open, so this is headed for v5.17.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
