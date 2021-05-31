Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE2395FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhEaON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232272AbhEaNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622468716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UITNUt5ZmZEDO3e0WLoQny0/vMV9bsuhwmIZlIKhPMU=;
        b=MlTNY8AFJ8xwguCcfbZWXdSldNTH7p4Yc6BSiabWpCfZkFfUoTC6vkJAKpzaJfAdOlmHGH
        weUZ6ftjg7zMSMSCVdBauWhFCZri1P4822YnLFjsiYw2QIBWuzGndlMOzr1gAcoKj0GOwo
        MJklrhac6vVE79Oscpn4AC0q3h5F3Zc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-I2gL0sApPsGOT1pf9rJ8vA-1; Mon, 31 May 2021 09:45:14 -0400
X-MC-Unique: I2gL0sApPsGOT1pf9rJ8vA-1
Received: by mail-ed1-f69.google.com with SMTP id dd28-20020a056402313cb029038fc9850034so4730503edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UITNUt5ZmZEDO3e0WLoQny0/vMV9bsuhwmIZlIKhPMU=;
        b=BgmhKZP3dr8od+nQCNX2cHy0mCCZ+78D/POJq1gsBAvSn3XX9VtR9URnt5SOKGAhJc
         BMAsm3cAzW1GRZb8mM4RtKnZCotsZVWwXn6Q140rxQ4XinYNSjeit76cJL9DnXqbOW2c
         DvL0j4+XZo7G5ikPwbkW6M+LDcnhkpb+iIuWuEwN/fb1zI9yPdv3epD87/7RYtk6RWbJ
         wzGrjx5bmMk863rTpOonvoDtJBmd3e8xCxiNtUryrRt2gNePvBSMTeJpuF0urtzQ3a8D
         4r5R9h8ClqUw3N54LW+5Sf/v3bgNAoYSCVf5HWjTsJY0TONB8wKTJoCsFEdofQo+6YfH
         MPaA==
X-Gm-Message-State: AOAM530aOnAx7DtnBKF+cdmYJVXW7K5DdDgUFNQ15au4mLMiCunvEuMn
        m04QQJXinA4f+swoWX4TR9wQltSFDPlRHhhgJ/LcUSvrYCfgqtq5f5kwAMw9Oxd85DRjrwSKykn
        xD5RU4St0PB+STuep6BvFlhJCjWxN3Dz00XdNF0VDvUbtUw/MuSSajiAiTJUHGGwgHI4lSzetI7
        Lv
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr6220904ejr.296.1622468712862;
        Mon, 31 May 2021 06:45:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIlKc5cUaeS3FkVx7yUbhYD5Ys/fuqUauyR567JXtEx/Bo1Hs5GrEneiuC7HyGHLj6iLjk1w==
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr6220877ejr.296.1622468712651;
        Mon, 31 May 2021 06:45:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bh3sm5947830ejb.19.2021.05.31.06.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 06:45:12 -0700 (PDT)
Subject: Re: [PATCH -next] x86/platform/uv: functions should not be declared
 extern
To:     Qiheng Lin <linqiheng@huawei.com>, mike.travis@hpe.com,
        dimitri.sivanich@hpe.com, russ.anderson@hpe.com,
        dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     steve.wahl@hpe.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531060747.21934-1-linqiheng@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <56198fed-ce73-f7e8-3d90-50089e243799@redhat.com>
Date:   Mon, 31 May 2021 15:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531060747.21934-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/21 8:07 AM, Qiheng Lin wrote:
> These function declarations in 'bios.h' are already marked extern, thus
> their definition should not have the keyword.
> 
> This quiets the following sparse warnings:
>  function 'uv_bios_get_master_nasid' with external linkage has definition
>  function 'uv_bios_get_heapsize' with external linkage has definition
>  function 'uv_bios_install_heap' with external linkage has definition
>  function 'uv_bios_obj_count' with external linkage has definition
>  function 'uv_bios_enum_objs' with external linkage has definition
>  function 'uv_bios_enum_ports' with external linkage has definition
>  function 'uv_bios_get_geoinfo' with external linkage has definition
>  function 'uv_bios_get_pci_topology' with external linkage has definition
> 
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

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
>  arch/x86/platform/uv/bios_uv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
> index bf31af3d32d6..7e7634c8be62 100644
> --- a/arch/x86/platform/uv/bios_uv.c
> +++ b/arch/x86/platform/uv/bios_uv.c
> @@ -172,55 +172,55 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
>  				(u64)decode, (u64)domain, (u64)bus, 0, 0);
>  }
>  
> -extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
> +s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
>  				size, (u64)master_nasid);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
>  
> -extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
> +s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
>  				0, size, (u64)heap_size);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
>  
> -extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
> +s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
>  				0, heap_size, (u64)bios_heap);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_install_heap);
>  
> -extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
> +s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
>  				0, size, (u64)objcnt);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_obj_count);
>  
> -extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
> +s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
>  				0, size, (u64)objbuf);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
>  
> -extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
> +s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
>  {
>  	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
>  				obj_id, size, (u64)portbuf);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
>  
> -extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
> +s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
>  {
>  	return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
>  }
>  EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
>  
> -extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
> +s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
>  {
>  	return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
>  }
> 

