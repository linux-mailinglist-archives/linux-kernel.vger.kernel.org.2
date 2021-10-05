Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7F4232BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhJEVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhJEVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:18:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50799C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:16:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t2so1931730wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PlGyYXdHnRb3uBFBFPOmPhSz+6CwwP78f00acOXfK5s=;
        b=Fi0qjIZLQ52mrZjTeuH3S5xGIaUaG45rRcYdiWsbBgwLYSEJJEZYSIzCeVoWkQoP0v
         +ZtUBxkeftA3Btr//ExtEXledeE4O6sQh/pbNB/V3NFwntHK92Hir126Lrp3SQBvv2ht
         pymBZIh4Nz/aBWxGUVt0YdBj9TPN3jkyy2S8H778TW2WcLsL3QRHja9S6mNiQwVe+lFg
         1hEHNc1pcYnzLuXnr5iW6B9SOBYHgqWaIaFeq2qz5bhFPN1KMgH559SUP/4J1Nb1ysRB
         2C5tXnfYjkSA6UPDg8yrEl5Vr4zR36jihiRIlfk7fjipdz2ZEnN7VVcbKnPGkogkjTQl
         gkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PlGyYXdHnRb3uBFBFPOmPhSz+6CwwP78f00acOXfK5s=;
        b=bPa5mHkD2z0+7qaf8+q+imySCwVpPwD3iaYrLOMJZ7R8F5qIN9s4wQ57+qfAyRuvHv
         x+K0LjG3UV/hpYqoJKLuFXpERMPtviHu9A/+5K8dNMkr8ko5kBe3+l6uEqeT7LEmIbRV
         3kApfJ0WC/CcEZKbBNzUysURYgMlIVGep0Ee4vWcYvmYq5vHT4Qy6ySXpNwosbdEdvUj
         AlRD99uaDPQ+e5tWI/hLJlZYArifARaCbHwunPSyIesy26VCX0LF6c6btCO3V3Avnc2F
         jnLsZ5Z/BMEydKsrwIWnmjX8I+pMk4xoH66cbFxCWUU7sfQ2pBvAAOSSMGmjbFfL+MUc
         B7ug==
X-Gm-Message-State: AOAM532L0NKfTFu9HENGb34AR00djCKM0Lj2XJAywraRkhLpJHMZa4Yt
        VLVbUvIehmZGZ9q9qBp/tSzwuN0y5nsABRuK
X-Google-Smtp-Source: ABdhPJxbk1T7tbndW0Vc+vuX6+xaIh20l7NhzfmeUzYXGzp6pgzr7ZjpEs1oMLR/YXzDB7d9SDWP7Q==
X-Received: by 2002:adf:906a:: with SMTP id h97mr23666547wrh.220.1633468594592;
        Tue, 05 Oct 2021 14:16:34 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c7:8d80:d71c:ed62:e10a:e7ca? ([2a02:8084:20c7:8d80:d71c:ed62:e10a:e7ca])
        by smtp.gmail.com with ESMTPSA id s13sm3177074wmc.47.2021.10.05.14.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 14:16:34 -0700 (PDT)
Subject: Re: [PATCH v2] staging: r8188eu: Fix misspelling in comment
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <7bc392d5-11e4-7ad0-dab6-295ccadf63b9@gmail.com>
 <YVwpEa5T4HnOX5/g@kroah.com>
From:   "Siou-Jhih, Guo" <hallblazzar@gmail.com>
Message-ID: <f1569e97-8996-e538-182c-cc5f6510dc35@gmail.com>
Date:   Tue, 5 Oct 2021 22:16:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YVwpEa5T4HnOX5/g@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/2021 11:29, Greg Kroah-Hartman wrote:
> On Wed, Sep 29, 2021 at 12:29:01PM +0100, hallblazzar wrote:
>> As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
>> looks misspelled by accident. Help fix it.
>>
>> The original error is as below shows:
>>
>> CHECK: 'followign' may be misspelled - perhaps 'following'?
>> +Set to 0 (HT pure) under the followign conditions
>>
>> Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
>
> This does not match with your "From" line in your email header :(
>
>> ---
>>  drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> What changed from v1?  That always has to go below the --- line as per
> the documentation, right?
>
> Please fix up and send a v3.
>
> thanks,
>

> greg k-h

Hello Greg,

Really thankful for your time and point those issues out. I've fixed
the issues and re-sent v3 patch

  [PATCH v2] staging: r8188eu: Fix misspelling in comment   

If anything should I additionally aware, I'd like to fix them.

Regards,
Bill G.

