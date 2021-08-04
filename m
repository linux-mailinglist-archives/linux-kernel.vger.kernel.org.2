Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674E83E0744
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhHDSKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbhHDSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:10:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CFC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:10:40 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y18so3855321oiv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nO7o2mnROm6vfrwIFqpPmkud04mZHjdO1289sNb+Hw0=;
        b=SZUpBRULSN2CSoeeNZ16bWEwfw9BT+28HqCpb79v4tkTQVtEcEpowHLFyE3bARU+AP
         yGdSakKCvE0yDTm+5/FXktniQT1fh4tM5N6EyJST9UfZfk+TPXOGrvJHms6ly5oEEDlW
         x4qFcMj+jtEgKWEF+Or+aa1mGmQ7M8LVkrIoNmt3g4K4iFSxmvEeBPZyE6iTnHzguDeT
         CbRdfdJxgQueqUiMUKrdYwMTdbEOnMwHu3Z8sPJFQqChjc7AKfOfiAs8dPS8TSk3m0w0
         PxvqCnaG+EvQ1hQBXxpDAQan/W4lIx8PF5yLP+FftLVHl5RUOtL5ZpriNZKTKPdm+FwX
         Zk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nO7o2mnROm6vfrwIFqpPmkud04mZHjdO1289sNb+Hw0=;
        b=IjvHKwlaGYNAWZ+edwOeIjS2GeFJwrsQ2ygajIGHHG4LwXb850CYD6ur8Ot5YrHD3G
         zo4oN5cIdpcR/UF9222E3bv/OdJiqyOq0nJBlUC7ZXjaQnCQIItoedxqv5Jv4wwx7fNn
         mo9lsS8N71bjJVdoJTrkRjaau2stFBfV6gzLxRbYikpBRZmgL07woCwPrnmNyCi7b3cf
         GnOxlGS2P+ZxJy1S749rzhSXIhNbTZOX9bQ19OO9yjAFwMMkHG6Ln5F1oyGm1OVRA8IZ
         pwVW8ZOX5ajInOCm8B8eiJAIRhhsaK7wQGFFAKRsU+Zl7XzRLzep83HPCR3rXuhSOEFJ
         jH1A==
X-Gm-Message-State: AOAM533lOkFWfd/lvbfX3gURrGkEBO/CebZroFZhB5ul+aF9YOdTLa5i
        Hn6y6Z5jVkL7WuNxbvPoWH4+ilTcH6k=
X-Google-Smtp-Source: ABdhPJxQfR3eULiGVYmQ466ZqjtzMkAdnUNOO6e49aXKcmE3YmWTf2uZ4d9Ehn4RPBezXBwuACTC0g==
X-Received: by 2002:aca:f089:: with SMTP id o131mr547234oih.37.1628100639168;
        Wed, 04 Aug 2021 11:10:39 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id d7sm431522oon.18.2021.08.04.11.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:10:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20210802005517.12815-1-fmdefrancesco@gmail.com>
 <20210804130136.GJ1931@kadam>
 <CAP71bdUDEX=B6Km9wZO1AyHpVzqqkGNw6xNvspBz3qUABSKMEQ@mail.gmail.com>
Message-ID: <406c6f84-a2f6-1a0e-3a52-9406df41973c@lwfinger.net>
Date:   Wed, 4 Aug 2021 13:10:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAP71bdUDEX=B6Km9wZO1AyHpVzqqkGNw6xNvspBz3qUABSKMEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 10:09 AM, Larry Finger wrote:
> In other Realtek drivers, the while loop has a call to rtw_mfree_stainfo(psta). 
> That routine does not exist in this driver, but I think it should. In a few rare 
> instances, the driver leaks some memory - this missing code may explain that. In 
> any case, this patch should be dropped as the fix will require testing.

After looking at the original code for several other drivers, routine 
rtw_mfree_stainfo() just ends up calling a couple of routines that free a 
spinlock. That operation for Windows and FreeBSD is not trivial, but for Linux, 
the routine does nothing. Thus, despite its name, rtw_mfree_stainfo() does not 
free anything, and it can be deleted.

The original patch is

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

