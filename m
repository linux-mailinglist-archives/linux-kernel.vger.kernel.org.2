Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F245968D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhKVVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:25:28 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C06C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 13:22:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t11so6712155ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/ZRtTj11U+Uq/wLppGJLQ+QkgmE9jsfIiGfPFTvZiZY=;
        b=EVXGel7oSRQ3sSAFS7cnQXO7lKiHuAIAMC6i7yhANnR4k59rpm1wgkxfVCVw3XJkq0
         PZEkP9RC92PbnPp85ZH8Qh63aYaurBCk2a/x1Ggf7mi8Am6C7puc96n0YcaFUkwf785h
         le5GTyogKnNYCW+Xeak/TLu3zC3zHj6JGpTLliTbMGmO/VJa0BxPb7Gxk7Gq7JTBVLTI
         L9rw2MX/qNaCoTJq7ZY7ZI7P7dlmaMIny3zBqSqt5an42dBN7k23+/lf9ZJQ1NXfFN1Z
         HKSxr/u4xgBWebIacIFvUSFLJI6SnAabmxin8V8m1QoUSZZM/bXwoMtmkzXZS4Sr40G9
         ogrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/ZRtTj11U+Uq/wLppGJLQ+QkgmE9jsfIiGfPFTvZiZY=;
        b=FUpfZjwS9OSQpIP0Jg6lQpOmG3Qc0z48caYnDeqO5uqfbzVQWzzj9G+0gdv2kUBO9b
         5RcQPC4tDgLyjD+K/n4jyQBOm56hIwFBu4EVAi21YlZ2QfN+v6G4o2huX5OXYyycqEi1
         qHVyrcyoM8DOVcTag35nti9ONJGu2hxEu5DoJKswJoFwEWQk/EJKRYA3LH/sh7sJRZmf
         W7ftzrDO8gp7duYfthc4AUiITdilM9GeETZRWMtWGDqJuqrya+LakGSXisvsExlebDQe
         JTGhw9GZJp2+9zvwmfG3juDKmbvSx+NT8iME16mIb1iEK8NQ3VrPIaeOUro9A8QItmeH
         9xCA==
X-Gm-Message-State: AOAM531pGtyBe3mDDIOtJPjQn8aO/Z19qH06ECeTyyJLnF8M6Smd3TMc
        RHraQUU4CIGkxnyX8g1uHT2hO1D7BT8=
X-Google-Smtp-Source: ABdhPJz6LAXCZ7T5M/iuEDj/nU2hfyccB9Qe7UtNPsa3ey6RiDDFg6Q4v/xq7N8Q3tP6mHOuP2R35g==
X-Received: by 2002:a2e:9d05:: with SMTP id t5mr90018lji.433.1637616138825;
        Mon, 22 Nov 2021 13:22:18 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.63])
        by smtp.gmail.com with ESMTPSA id j1sm1079438lfg.154.2021.11.22.13.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 13:22:18 -0800 (PST)
Message-ID: <52ad7e4f-7164-e868-ca49-2f0fecda3395@gmail.com>
Date:   Tue, 23 Nov 2021 00:22:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary NULL check
Content-Language: en-US
To:     Vihas Mak <makvihas@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211122195350.GA166134@makvihas>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211122195350.GA166134@makvihas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 22:53, Vihas Mak wrote:
> remove unnecessary NULL check surrounding rtw_free_netdev(), as the check
> is already performed inside rtw_free_netdev() in
> drivers/staging/r8188eu/os_dep/osdep_service.c.
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>

BTW, same can be done in rtw_usb_if1_init().



With regards,
Pavel Skripkin
