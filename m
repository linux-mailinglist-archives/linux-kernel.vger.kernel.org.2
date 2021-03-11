Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66433718F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhCKLju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhCKLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:39:32 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A28C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:39:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb6so3332325pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADPzK3H6sB8h/JfPc3FdbYC41bAimO6D0R94MA1ppio=;
        b=Lt8zvBGJJOWrmr5MnjIrDxbfyEXw5cErBb8KO0M2zNbilxjuiGaeLqnEeT32/Csgcm
         A98DpeLnLOc1B2n+5POC+XbxgpSJtAm7R4vIq+8zkHDMFdQgtHeb+mRvJzOe63lzjce2
         9A+QUEWrBel2ekF/Rp/4RYqRtzsOcjmxShhLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADPzK3H6sB8h/JfPc3FdbYC41bAimO6D0R94MA1ppio=;
        b=bHM8N7vEW1rFb+7f34dofZuIGdf+ik8bOyB1ZHZwJQZ4YMyHTo3RHnJI+/Wd/Fo3EN
         nYXHt10kcQBAVVNCb70OmkUPYxESEpy9I4CPaaGEweRSZo7WCu6IgZw2amOe8ZvDRG9u
         2Dl2a9WGBjKyjElBZLqQwEFAjNSZga1oQgaoyM90S2UUy5Xxb2obTjrUW6N1cz1CoYOT
         Kb5X8rZjK/ofMnVknzAUChx2aPKeOkX6oQU3+0B1rpf7v8K+WzJ+ieZk1EbYY1awVqhC
         BBx3tOSt9mcXTVEKWcR+DroKLErda0AYJInb4YjwjTZP9k2CDMetxeeVgErEkz8MDLs7
         yGFg==
X-Gm-Message-State: AOAM531Z/K+WN0ZylGB4NVAM67l++UtJPkZM88JPEBLZDnqtey8uHZz3
        Stsd+e7/yxdHX10fHWUVQrbj6Q==
X-Google-Smtp-Source: ABdhPJzvzemfEAzE1p53DQfgkIVDvp8YkYJ53hOyakRNo2ME/NGI+BVCbDVlq6R4j5Xk9KT8XiqC1Q==
X-Received: by 2002:a17:903:1242:b029:e0:3263:1693 with SMTP id u2-20020a1709031242b02900e032631693mr7898852plh.33.1615462770253;
        Thu, 11 Mar 2021 03:39:30 -0800 (PST)
Received: from cd5f4d36aa95 (59-102-6-122.tpgi.com.au. [59.102.6.122])
        by smtp.gmail.com with ESMTPSA id b14sm2199936pfi.74.2021.03.11.03.39.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 03:39:29 -0800 (PST)
Date:   Thu, 11 Mar 2021 11:39:23 +0000
From:   rudi@heitbaum.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 00/47] 5.10.23-rc2 review
Message-ID: <20210311113923.GA1770046@cd5f4d36aa95>
References: <20210310182834.696191666@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310182834.696191666@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 07:29:23PM +0100, gregkh@linuxfoundation.org wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is the start of the stable review cycle for the 5.10.23 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

The following patch is still missing Pavell's identified missing line
- patch @ https://lore.kernel.org/lkml/20210310200458.GA12122@amd/

> Jasper St. Pierre <jstpierre@mecheye.net>
>     ACPI: video: Add DMI quirk for GIGABYTE GB-BXBT-2807

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 811d298637cb..83cd4c95faf0 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -147,6 +147,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 	{
+	.callback = video_detect_force_vendor,
 	.ident = "Sony VPCEH3U1E",
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
