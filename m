Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACB3FD436
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbhIAHIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbhIAHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:08:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD1C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 00:07:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n27so4464681eja.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ttiQ81PexZJ9BGCM+uGkFoS9kvTRFiKEGPrljwS10qs=;
        b=U/iZjFHthqroFyYfcY2w4kGxTYoCptbQhhNwDDtk/TKEFMN4j2jXGu2cxCVRSLWbE6
         bHkgM/97NkydlwKz0wjdfsBAO3lzrPbA6YZ0waUUbfjvPd/XnVxcCYRE8Ua//nnwJgEu
         pQ0l5D5GnXMcq1ENAa+YDGWEH6LT/oXojyGppV6z5Uhg1pvsGDcH0g/x1nliHOEU197t
         W4j5WZt67tRNDW2GbTW6qNHAJZU6iMkHcDBkxgeO2IV8yTXc1UkUDhlI19scxotKgto2
         by1apb6E8b2I8cCXbaiG4T4EPY4R2PFeV2s3Rl2EfJ2AzCwH6PWxCaABygYpv3xTt/ai
         VxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttiQ81PexZJ9BGCM+uGkFoS9kvTRFiKEGPrljwS10qs=;
        b=EmSadNN4IZ992zb4vsn/xNmvtv/kAJjjv9xV6IRn0w50bJ+3ibKbZ0uxbtDkgVrUAc
         9tXf6VfvREV3pKW/zGX4ciyhLF07KOW+sXoeavT4iDjAdtn/SjKU17BNkIboKtfk3eXz
         X/ugMVQBCy/s5cJdMvN4dFKUwfoutiDLbd6QGYr5tvWuHNQP2WPA/Av3ilkFOvZECyb8
         KceBx2JxBsIpwW/V6vJwyyBaKwM2YWjGzd9IvQJld6ioRGgO0RYh4suwud6ouguWMyr9
         zHS1FOAqoQqujwnRQXkI/i2wqN2vgBkzK0EdrjLsZm46Fm+MBpPylu/pe2Zo+0iYb2Dr
         PYlQ==
X-Gm-Message-State: AOAM53346JPR76Afs8cy6XKVXSlWnEnnei7ifHEbbiPwJSuXHRAkn74R
        5arfL5jpPmA6P9dstCNimSTS+g==
X-Google-Smtp-Source: ABdhPJxZelQA90F5Buio/vqxtgsumcQADmv4H9aCrXzl4D7WxUkP6IhSFyso/oUkwAW/xm65amt1LA==
X-Received: by 2002:a17:906:d20a:: with SMTP id w10mr36630482ejz.426.1630480076830;
        Wed, 01 Sep 2021 00:07:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id f30sm9177868ejl.78.2021.09.01.00.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 00:07:56 -0700 (PDT)
To:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Maurizio Lombardi <mlombard@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20210901021510.1561219-1-nathan@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] x86/setup: Explicitly include acpi.h
Message-ID: <35bd6f7e-1dd3-da75-c8c8-464f0b2bdd9d@tessares.net>
Date:   Wed, 1 Sep 2021 09:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901021510.1561219-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 01/09/2021 04:15, Nathan Chancellor wrote:
> After commit 342f43af70db ("iscsi_ibft: fix crash due to KASLR physical
> memory remapping"), certain configurations show the following errors:

Thank you for the patch!

It fixes the same issue on my side using a configuration based on
x86_64_defconfig with a few extras on the Networking side only. My CI
also noticed it was failing with a config based on tinyconfig.

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
