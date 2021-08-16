Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBA3EDAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhHPQbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:31:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E4C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:31:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r19so24020532eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2oS0fCAjXI17IygY9TEY+eiBbZmRvOzA4iXKmsK4ngc=;
        b=DaJaPTbAtUVJCcUI83uEp2yGqYFUIfwRwAdKj/o10p2KMpNSu3eGlPBQAKUg6R1qGS
         EgH+89EjK3I7Gb+rsE6VrMywwUIfwlxxNGyUjjhDPmoPOxsc4LHjqQaJtP2tLcVzhC1M
         VQVi5EciYiYlIdEsFDNfuzT1a18DmEyzlvrqi/K73iu2dv7kL5W4QfxBoLZBtZ/gLRpm
         aic4sKaMV/DyHpITKQ9Eir5VVelSZ41tSs6bmIj8hSBig8zbYar/ekEBYWM2LSBOiapJ
         LxgofdnnedIQ7X3mVfr5qBfH0CsqQKKg6p2FKMo2yHuEk+uj8XLYbtKJhv7SLaS1PyL2
         ArBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2oS0fCAjXI17IygY9TEY+eiBbZmRvOzA4iXKmsK4ngc=;
        b=gcQAB/JebpII7QvJatJvJim9O+UtvKD1zM6Mtsg9Vqe+7uIQj6TMocAHXcVUnsY2+W
         ESxAKD5uu7aDWG8k6gtL/ip4cAuF/Xd3uH5j09qa/vZ/wavjepEDy9uDoLPw5dSutjyg
         Jn37qjzWJ7UFacqI+fc56nVKRj8QF6dtFdsK2ntlgLFM1j/H1uoY9183pakGm7LgFC0+
         OpHsoJdLuKzJIPnh7hnUN+CQxcIV92QPj7KSJYhxU7+jiJmPWfYa7RmkxgMDUYLXagwe
         JxHDJ6By1AaOiIBRPXrmAT/RYL9k167sEf6nM+yLFSvyd/yBoP2H0oEuUi3bW9sxABxP
         Fw9A==
X-Gm-Message-State: AOAM533TWqhfceE0Gr1QDlpIhZU8pAdpMQUj2pkJOLfDiE2PeN8GASu/
        1yjdawLz+lYnGpVBurGYNUxdB275s4U=
X-Google-Smtp-Source: ABdhPJxt4+KInPm+4/Qu8wJEKPhp5DgJmXjMui/w4vrk/QM6HNDr1//leCMU8d09Gb7po0dnWu4CHA==
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr10591717edc.175.1629131481027;
        Mon, 16 Aug 2021 09:31:21 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id c9sm3434767ede.40.2021.08.16.09.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:31:20 -0700 (PDT)
Subject: Re: [PATCH 0/3] staging: r8188eu: Remove unused code
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210816160617.11949-1-fmdefrancesco@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <abb1428c-c70a-e51b-5750-74c60301e312@gmail.com>
Date:   Mon, 16 Aug 2021 18:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816160617.11949-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/16/21 6:06 PM, Fabio M. De Francesco wrote:
> Remove unused code from the r8188eu driver.
> 
> Fabio M. De Francesco (3):
>    staging: r8188eu: Remove unused nat25_handle_frame()
>    staging: r8188eu: Remove all code depending on the NAT25_LOOKUP method
>    staging: r8188eu: Remove no more used variable and function
> 
>   drivers/staging/r8188eu/core/rtw_br_ext.c    | 263 +------------------
>   drivers/staging/r8188eu/include/recv_osdep.h |   1 -
>   drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
>   3 files changed, 1 insertion(+), 264 deletions(-)
> 

Acked-by: Michael Straube <straube.linux@gmail.com>

Looks good to me, thanks.

Regards,
Michael
