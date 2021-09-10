Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B70406F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhIJQOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:14:08 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34537 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhIJQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:13:32 -0400
Received: by mail-oi1-f181.google.com with SMTP id p2so3611751oif.1;
        Fri, 10 Sep 2021 09:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTACTH+bqUqqQb48Lw5xQr1Hpj3NEFTPtcT1LDOj2n0=;
        b=eZQ2sFXRm2E8K4kIEYiGbVu7Qpt1vUqAff7WME9rYscDrjprQgIPTqNlq4MA/Nu514
         ebNnB8iLmalG3ey9RL3Yqx/MnAKN6l5mXoqQIEgsFSDMDHV7SVU1V0iJznAJngJ0ea4g
         m+lCT3iIRJCM2j97I3xSUb3fMUSAPp/kF30NW05z2seZ43gyAxuA5Pf96cxH5TjlNOnH
         pLQOsvoq4cuDdbbv1FfRts9ZISO34R/6BLI9tJn8B+Sdq9GD1eUkm2xgGlItT/STcqYj
         TY6tJtSmK2pXY1MyMm2Gpg2BBsi0pbxRTftLLUau3y53i7pTrXZh9oOSZAMy+mk2JB52
         Em5g==
X-Gm-Message-State: AOAM532Acu3UeKB8ulCFBTM3igs/YjWVsleK/5gOjNMcsd5eGrK079Yg
        mV816pbYSKJcUE8/mMQDsQ==
X-Google-Smtp-Source: ABdhPJwOfLk76cZaYabj9CW1ZCNHAL/1McTB+Ki9yn8bejUdyhBJZW7m1bZDb6ZSZS+L6mQvK9ui9A==
X-Received: by 2002:aca:6008:: with SMTP id u8mr4812086oib.127.1631290340300;
        Fri, 10 Sep 2021 09:12:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v8sm1301839ota.16.2021.09.10.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:12:19 -0700 (PDT)
Received: (nullmailer pid 2782029 invoked by uid 1000);
        Fri, 10 Sep 2021 16:12:18 -0000
Date:   Fri, 10 Sep 2021 11:12:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Andre Muller <andre.muller@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] of: property: Disable fw_devlink DT support for X86
Message-ID: <YTuD4vxkklqLNOyd@robh.at.kernel.org>
References: <20210910011446.3208894-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910011446.3208894-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2021 18:14:45 -0700, Saravana Kannan wrote:
> Andre reported fw_devlink=on breaking OLPC XO-1.5 [1].
> 
> OLPC XO-1.5 is an X86 system that uses a mix of ACPI and OF to populate
> devices. The root cause seems to be ISA devices not setting their fwnode
> field. But trying to figure out how to fix that doesn't seem worth the
> trouble because the OLPC devicetree is very sparse/limited and fw_devlink
> only adds the links causing this issue. Considering that there aren't many
> users of OF in an X86 system, simply fw_devlink DT support for X86.
> 
> [1] - https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/
> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Andre Muller <andre.muller@web.de>
> ---
>  drivers/of/property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
