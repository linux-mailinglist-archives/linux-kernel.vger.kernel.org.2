Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC83EDDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhHPTiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:38:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB60C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:37:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q3so24015748edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hWBgaZy/6OsUctviq0mTpGRfIkXffP/uL/sHIzQRKqw=;
        b=LaEUTxeXvM1m0ruw74D8pqZaaZI/GGNETOjvIEV8fw/BiBu7ddzIaQ4kgJlziCVNbI
         tPS8BFwPPrn1X2oLj+gs72hj2ewi8e74tmKsr6ipHcXkXvbesOqljPUAhC5iPudYQDw3
         hkM+NCo+WvmaaC1GRmwYIVU0qsm9h097PVKyvzqGIjVGooLClFvXS/EllvA01Hm2HJLt
         jp1RBQnrvCbrAC5KsaAbPHVNBb/FftXhxoqR7AaSNqUUpAQsb5KU0MWLcFvNgjPmXTgG
         ZFcBRnGOzNOuPeMYiBb0aSvFOqF1phR5/T1sGsYdAbpYMsX+BGNFShs153H0ETbmNX0/
         4BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hWBgaZy/6OsUctviq0mTpGRfIkXffP/uL/sHIzQRKqw=;
        b=pkNHpUH1MrW+KCo5O0NEJlTnyihrWfIHCFuOr+BIcOtYfk1+faXc8Fs0NBpDOi6B7C
         BujuNvxQSD+I84UnQzvVdgFpOk/yErzc7hQnMcRfWdNzav/wT3/lUDFpF7b6kcsxbz3T
         FJ4NakxKytjOcQjT1jdxJgynxjJ1XO6n1K3HNe0gxa0vLtz1u1RXgPOh6hDvsACkFRlg
         3ewGdtbO2/SMovDRujJarmbNK37qy4g+ew7puFqnK3bjXRc80d4dMr9BkobmPLpS76vU
         rBND5pDzGpqkiZYvT3DXFXhw3i6W9B6S+806EvVQ245e5tErEyMhlrUTxEBdBVm4WLST
         my8w==
X-Gm-Message-State: AOAM532A2e1NAPPo60MK//Ef/Q1CFPkFYDloO3Nxzfo43XNQWuXW8K8t
        GswU2DZmi/rz4Rx+iXFLFwXCvK1EKKk=
X-Google-Smtp-Source: ABdhPJxdCrIuKYXWhR95PUNP7cr+X72slU1ZspA8KvPxIw0CCWVxTDxBURgHesFPkbw4Vd+qaxpAQQ==
X-Received: by 2002:a05:6402:1d3c:: with SMTP id dh28mr201892edb.257.1629142647171;
        Mon, 16 Aug 2021 12:37:27 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id x20sm58610ejb.100.2021.08.16.12.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 12:37:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] staging: r8188eu: refactor
 rtw_is_cckrates_included()
To:     Joe Perches <joe@perches.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210816115430.28264-1-straube.linux@gmail.com>
 <22319347.s0ZA6q4zN9@localhost.localdomain>
 <c30b9e08b7df2bade93d217c0bf6eb4b416eb2ec.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <7a09afdb-5f85-0302-0375-93665e2f3f1a@gmail.com>
Date:   Mon, 16 Aug 2021 21:36:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c30b9e08b7df2bade93d217c0bf6eb4b416eb2ec.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 6:15 PM, Joe Perches wrote:
> On Mon, 2021-08-16 at 14:59 +0200, Fabio M. De Francesco wrote:
>> On Monday, August 16, 2021 1:54:27 PM CEST Michael Straube wrote:
>>> Refactor function rtw_is_cckrates_included(). Improves readability
>>> and slightly reduces object file size.
>>>
>>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>>> ---
>>> v1 -> v2
>>> Refactored to more compact code as suggested by Joe Perches.
>>>
>>>   drivers/staging/r8188eu/core/rtw_ieee80211.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>
>> Thanks for redoing the series as suggested by Joe Perches.
>> This is a perfect case where conciseness and readability don't clash and
>> instead the former enhances the latter.
> 
> Perhaps do the whole thing in one go (moving the & 0x7f into the helper
> avoids an early loop exit defect when the rate being indexed is 0x80)
> 

I have sent a new patch that does the refactoring in one go,
so this series is obsolete now. ;)

Regards,
Michael
