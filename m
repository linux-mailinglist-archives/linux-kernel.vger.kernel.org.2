Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8871A39CF3E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFNDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFFNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 09:03:44 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B2C061766;
        Sun,  6 Jun 2021 06:01:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so240770otl.0;
        Sun, 06 Jun 2021 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wL5lK/b92oqC0FMeaL7qFxLQLCTfCIxg70uGbHOejLQ=;
        b=bfdR8034AFmMEBBb2jO2wPp0Adu6tAmzVP3uL2kcFYNjtaSa2LqEM7WI2oj9MINo2k
         WGLA9BpHxB8xvPxcYQrHcX55dk2ynHxP/AVDN0TfDqm8qByqzBXYy0PE/zVyX7ZOrv9j
         Hm0GrvjydGmMC/9BIuMbfnNZ3mVcbK/AYW1MjqBwglAl4FabDVmRC6rt6xXiBJnuCDOE
         knag1PyhDqoIO7baQH+tZDi6aKr8G6Lm2UQEWtx+j5yQfnVWDF4c5cn5XcFUUQBIfwLK
         iDbamUWkvFOMmg9llc73yz1LWRrZi9zMaS1rDUH7MthcGvqKEuR40fu04uc/nlMf55aN
         QUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wL5lK/b92oqC0FMeaL7qFxLQLCTfCIxg70uGbHOejLQ=;
        b=J86tkwcckMCNW3/iQSW92Qp67Y9zxr7YQlsIN2KcdS39raq4V77ZpYWh9lQzqWqziL
         ZpCxcG+Gc+4PRz6phi9hDYc3nNKt0N5OxNqJMAVGhjdXQQs5ZrMbbVX7D8b6QeBuPSzS
         L3JgUdwFrXZsk4utDrCGj57BoSjtj9tfReLrEoLbxDwKU0aA60FhX612HwKIcrUmSqwl
         r2CnwUbSSTx4yMI4M87jiTmLS1Kl2wbMf0j7TA2r9yP6rWTYvpuTayhKMu4T5GfY90Zn
         xiBYFUtkHW+voI1FAERm7ZqZQlqg83QA3mW0pJAUy/QNAEbjnML4DVbPIdOmYm+W/Ood
         S9iw==
X-Gm-Message-State: AOAM531oIG/miX4wrMQ7i6q8phS24whILgr9smRlgnHNPeNBJ110BWXl
        vOazRvDL6TE8CSJuzaNFOJs=
X-Google-Smtp-Source: ABdhPJxl8dpxfANCMVhQ66Uoyx4brTHGFl5OMLtbw9QDMhmSLHBCw6EZuQVJEQv4h0Uch/kjKD6HJg==
X-Received: by 2002:a05:6830:108a:: with SMTP id y10mr10302282oto.187.1622984498503;
        Sun, 06 Jun 2021 06:01:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm1656400oiy.24.2021.06.06.06.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 06:01:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Jun 2021 06:01:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/34] docs: hwmon: adm1177.rst: avoid using ReSt
 :doc:`foo` markup
Message-ID: <20210606130136.GA3050494@roeck-us.net>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
 <32b0db7e79a3ed0e817213113c607a1b819e3867.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b0db7e79a3ed0e817213113c607a1b819e3867.1622898327.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 03:18:21PM +0200, Mauro Carvalho Chehab wrote:
> The :doc:`foo` tag is auto-generated via automarkup.py.
> So, use the filename at the sources, instead of :doc:`foo`.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/adm1177.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/adm1177.rst b/Documentation/hwmon/adm1177.rst
> index 471be1e98d6f..1c85a2af92bf 100644
> --- a/Documentation/hwmon/adm1177.rst
> +++ b/Documentation/hwmon/adm1177.rst
> @@ -20,7 +20,8 @@ Usage Notes
>  -----------
>  
>  This driver does not auto-detect devices. You will have to instantiate the
> -devices explicitly. Please see :doc:`/i2c/instantiating-devices` for details.
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst
> +for details.
>  
>  
>  Sysfs entries
