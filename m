Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE641AE79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhI1MKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240458AbhI1MKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632830916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/Lc3rR4l11GPbjW1XnUBBSJ1grXPqqIBxR/0GSoPfM=;
        b=gL12dtxRbXHmyNV7IT0HbPrZtycVetske01ZqotdhSAWoVwfZPpZAKmgT8iSJufZwU5JrS
        0ulutj17eddV+CyPyKrL4nh29L3Vojxbi/4XoDrn2XS9V4cQxxoer8fYN1fLd/JEht8rrY
        5ypszUVMYyUPkuY7lep5Mc7Zl/oOAiA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-fXMYAXj7PEajoN1um67zAQ-1; Tue, 28 Sep 2021 08:08:35 -0400
X-MC-Unique: fXMYAXj7PEajoN1um67zAQ-1
Received: by mail-ed1-f69.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so21499610edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/Lc3rR4l11GPbjW1XnUBBSJ1grXPqqIBxR/0GSoPfM=;
        b=2GpXizHh8f4biO5kCbZ8nDT4B8eglZd+C6sR0Ri6Bn8Wq1LAjCSq7We284BITf4vz3
         6jOSAfI3wmQOdG4pniKfdOoVnmEUh18iy7BWnrSYZ51oAz1qYWcTiLobYo20vN6yA4nC
         sSvWOHs1llHhyJULng85UtmpvndIXMtyHA7f7z5zu4hOj8pP6xRbcgzokIYJmg65TTwo
         y91JI0iw4NOI4CR7PS5+1fpvGvVj63zVQJujUk8wR0iHK9f13/cTDwAiUDmb3OCHFLyx
         SbDPLrM9QonRPvlU7BgLIMRRD05GfAJ9eu6GYoc3D2bw4G7Xf56z7YWz3+6ow2zlDd5n
         dTfQ==
X-Gm-Message-State: AOAM530s854ZymkYhF4u/EwEcdOvQXKleb8lIPoTE7V43iX1FV1PkX9i
        5A9gYw7udsYXdA/UpxMxpiNTZ2OAin7/dr3nMLFzfCWNlRLd4FuKv303T05v/jhDPeBbME6D8ke
        0NfFmeYCTFnYQ8wbUImnCKv8VITT2Ce/RyvQ1R5lOYy3Uglq1ykgJ8M5y6rti2XAU8fn1lIuuCH
        wM
X-Received: by 2002:a17:906:1b58:: with SMTP id p24mr6377881ejg.534.1632830913161;
        Tue, 28 Sep 2021 05:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUX1QyxsYStX/6gb3Uk7MgrjzzPBt1j1XaISvDLocJaMgZfG0V1OALe6fnOPHcRGTDS9HRaQ==
X-Received: by 2002:a17:906:1b58:: with SMTP id p24mr6377857ejg.534.1632830912898;
        Tue, 28 Sep 2021 05:08:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u10sm12601839eds.83.2021.09.28.05.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:08:32 -0700 (PDT)
Subject: Re: [PATCH] update email addresses. Change all email addresses for
 Mark Gross to use markgross@kernel.org.
To:     markgross@kernel.org, linux-kernel@vger.kernel.org
References: <20210921135358.85143-1-markgross@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e74afe6e-38b2-54b8-9d52-4177b8e63e10@redhat.com>
Date:   Tue, 28 Sep 2021 14:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210921135358.85143-1-markgross@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 9/21/21 3:53 PM, markgross@kernel.org wrote:
> From: Mark Gross <markgross@kernel.org>
> 
> Signed-off-by: Mark Gross<markgross@kernel.org>

Since most (but not all) of the affected entries are
under the pdx86 subsystem I've merged this now:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca6d6fde85cf..9d9800f79b97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6683,7 +6683,7 @@ S:	Supported
>  F:	drivers/edac/dmc520_edac.c
>  
>  EDAC-E752X
> -M:	Mark Gross <mark.gross@intel.com>
> +M:	Mark Gross <markgross@kernel.org>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/e752x_edac.c
> @@ -11979,7 +11979,7 @@ F:	drivers/net/ethernet/mellanox/mlxfw/
>  
>  MELLANOX HARDWARE PLATFORM SUPPORT
>  M:	Hans de Goede <hdegoede@redhat.com>
> -M:	Mark Gross <mgross@linux.intel.com>
> +M:	Mark Gross <markgross@kernel.org>
>  M:	Vadim Pasternak <vadimp@nvidia.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Supported
> @@ -12431,7 +12431,7 @@ F:	drivers/platform/surface/surface_gpe.c
>  
>  MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
>  M:	Hans de Goede <hdegoede@redhat.com>
> -M:	Mark Gross <mgross@linux.intel.com>
> +M:	Mark Gross <markgross@kernel.org>
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> @@ -18460,7 +18460,7 @@ S:	Supported
>  F:	drivers/net/ethernet/tehuti/*
>  
>  TELECOM CLOCK DRIVER FOR MCPL0010
> -M:	Mark Gross <mark.gross@intel.com>
> +M:	Mark Gross <markgross@kernel.org>
>  S:	Supported
>  F:	drivers/char/tlclk.c
>  
> @@ -20376,7 +20376,7 @@ F:	arch/x86/mm/
>  
>  X86 PLATFORM DRIVERS
>  M:	Hans de Goede <hdegoede@redhat.com>
> -M:	Mark Gross <mgross@linux.intel.com>
> +M:	Mark Gross <markgross@kernel.org>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> 

