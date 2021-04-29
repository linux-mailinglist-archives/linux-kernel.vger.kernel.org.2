Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13A636E5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhD2HRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhD2HRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:17:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E17C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:16:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k128so35165540wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aLrAuIG/XB/HLdtz6qPAEjGKpc8voLmrhSyadZU6mNM=;
        b=nKVHQoUkT4oiTgGhQgIdtpz236GF15yKCCvwLVEZzljdIlyE6Bi0UnMxjmJ8liZt7R
         Vd7cqy1xETWxLgnGILgqntX22OGMXd5dihngZ+B/KOpAvqdPdxqxUBy/S8axzh/F/l0l
         spBPwqveiqtBE2eURa/sfxG6D5mhWLKzFxQ8BWkubPcERiOQvZJZ3A75YvYScUQx3zwf
         Dxy0jiazQaVd+Gyic8G990YEEBDYH9AgY1Gw7ItxlitWG29brdtaXEuqmRrCbx02HdfG
         trJ6K5RsSB016E8pfG48ZqfDXtQ8md5vheWPgWrkv/GWUpV0LLPQNGNbQ1QuyYlQGwZS
         Kr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aLrAuIG/XB/HLdtz6qPAEjGKpc8voLmrhSyadZU6mNM=;
        b=pekWHdOWtUDnU4M3gV1t5i31HthZbRJGN6gfXPoKTXCpQVmAuFEWH7zs8rNV4g/XSW
         WJg0FE+8wAXly4Qs5ecPRUilWe1OTOFoTfOXjKfFIQsdOZ3kdZlDsZXkAlxtAkGiOqJ7
         qqiyYpenOJmn/dWtBDDOJWCYwNNhd3/po+UOPMad+jaSbBK8xB915CS9kl2rRj+tyY4U
         4S4gn1wjg900lWIqzdEkTNA5+HXJNG3fQhgUhSOCId/NeRpRxbr3FmR/LgRqXn22MIzh
         3ufyg+JRFVAOmECrZPfj3S+CqgLcMfy4NL5JsZVkTxZhmG6i3fIJudIi9oib9PcdynJ2
         GAlg==
X-Gm-Message-State: AOAM530OBcf23jXylbMWUavFqB7RadNA1AstzRxH6woDLcNvH7Z6ml+a
        Ft2V+kocWzaN460jU92L9WC1IQpksJBImg==
X-Google-Smtp-Source: ABdhPJwPfMRNWQ4U08NMIYXaR3MsFwEWlOh12gZq29mS0ai4KeGRD1gWMaJOHXIYKECDJOO05yqMfQ==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr36181731wmh.159.1619680585524;
        Thu, 29 Apr 2021 00:16:25 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:cd3e:54f2:98f5:2e97? (p200300ea8f384600cd3e54f298f52e97.dip0.t-ipconnect.de. [2003:ea:8f38:4600:cd3e:54f2:98f5:2e97])
        by smtp.googlemail.com with ESMTPSA id c5sm3317524wrs.73.2021.04.29.00.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:16:25 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c197724b-3d16-45bd-d71b-0a016196ca40@gmail.com>
Subject: Re: wait_for_initramfs warning from kernel_init_freeable()
Message-ID: <4d6aa2dd-92df-4f36-10ac-cd003a0229f7@gmail.com>
Date:   Thu, 29 Apr 2021 09:16:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c197724b-3d16-45bd-d71b-0a016196ca40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.2021 08:46, Heiner Kallweit wrote:
> Since 97f8172f9a98 ("init/initramfs.c: do unpacking asynchronously") I get
> the following warning early in the boot process from umh:
> "wait_for_initramfs() called before rootfs_initcalls"
> Some debugging lead me to the following call chain:
> 
> kernel_init_freeable()
> -> do_basic_setup()
>    -> driver_init()
>       -> platform_bus_init()
>          -> bus_register()
>             -> kset_register()
>                -> kobject_uvent()
> 

Sorry, this is the first umh call, but at this time UMH_DISABLED is still set.
The first umh call where UMH is enabled is the following:

kernel_init_freeable()
-> do_basic_setup()
   -> do_initcalls()
      -> do_one_initcall()
         -> wq_sysfs_init()         <- core_initcall()
            -> subsys_virtual_register()
               -> bus_register()
