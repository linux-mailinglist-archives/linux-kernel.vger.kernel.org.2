Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74353A1A70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhFIQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhFIQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623254694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlsRXJEr6LiJo2+q8NkInylNQDLsfhpmGjGniaTEWmM=;
        b=HZ2UOspKPR6J5AiYZDYMsCoqQvg2UdSAqVYatqbisAU2vCeyROAOYqSBwW37O/Y4E2FskR
        szHVmA7MVAwm0ZzQxSu4D0KBNeRb0hvrGoAoKuz+0iQzNZ0ik3VpQyMhftMB1tPk7tjGUz
        wnLdW+t/j3l2Y9H8E+drRVdJ+GHdZKM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-39tzDrnsODa443d4pXOUgg-1; Wed, 09 Jun 2021 12:04:53 -0400
X-MC-Unique: 39tzDrnsODa443d4pXOUgg-1
Received: by mail-ej1-f72.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso8210135ejt.20
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 09:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlsRXJEr6LiJo2+q8NkInylNQDLsfhpmGjGniaTEWmM=;
        b=UxZosxtDuEiNJmjo5lTw25HT+b73z5kuSwqZpRIXbaqbaOWBxE06ojTBSn3fglIMQS
         yExqZPyT/FZ/rzNXARjLvQg/5gqGUFhdZZlUSpwrtRBSRgp9ibXIbe5yJg3JLm0lBcFX
         aAshjIV97vrKq8Uojoegj1AoxTAnLstyYsrQKCkMHcEWRgDj8s4AlSMCUZ1WPGIxMXLk
         a+zPL4b/IVZD0vSS+4XwQwp3N9brTyPBhg4lV+Ewpy6mOjdSTYExcI0hfX0HTiX4tJSE
         ykmh60V7wwS9rHg0pb1bJOYcuhA+OjyNjynHfhcCNrzSW/LIJZ+CJEC0R14usi7/viax
         +2DQ==
X-Gm-Message-State: AOAM532s4eknYL/aR/PIihIv0RFm0qRJ8p2NgVWfIFDkb7T83hfe9RWz
        odEoe1pmn8QmqgKldCnMlcj9pD6mfNz+wMPkz02OW51oHWoAi2RgGKG6LMla00cifg0xXSiZHd5
        weiNHFrtcmmwS03keEQxx0EuiHEzR34Qz71Ts062mcVhMVlokD+MUheAA2PZwze6Vb5pLYx5iet
        kt
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr597249ejc.494.1623254692176;
        Wed, 09 Jun 2021 09:04:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxZ0Bs8BiBbljc4OGOpwfru3Q0ICUTvzCkmjEbSYRb1tmwl0z3LAjYZ4WMHg4pBmK/e2g+0g==
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr597220ejc.494.1623254691934;
        Wed, 09 Jun 2021 09:04:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d24sm69575edr.95.2021.06.09.09.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 09:04:51 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: set fw_attr_class
 storage-class to static
To:     trix@redhat.com, divya.bharathi@dell.com, prasanth.ksr@dell.com,
        mgross@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210609153445.3090046-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <073c59e6-8d2c-2412-537b-2fd5f78538c8@redhat.com>
Date:   Wed, 9 Jun 2021 18:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609153445.3090046-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 6/9/21 5:34 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> An allyesconfig has this linking error
> drivers/platform/x86/think-lmi.o:
>   multiple definition of `fw_attr_class'
> drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:
>   first defined here
> 
> fw_attr_class is only used locally, so change to static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thank you for your 2 patches, I just merged another patch doing
the same earlier today.

Regards,

Hans


> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 1378c18786582..636bdfa83284d 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -25,7 +25,7 @@ struct wmi_sysman_priv wmi_priv = {
>  /* reset bios to defaults */
>  static const char * const reset_types[] = {"builtinsafe", "lastknowngood", "factory", "custom"};
>  static int reset_option = -1;
> -struct class *fw_attr_class;
> +static struct class *fw_attr_class;
>  
>  
>  /**
> 

