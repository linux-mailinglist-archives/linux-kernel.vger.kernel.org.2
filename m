Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2162D401EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhIFQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhIFQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:51:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7767C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:50:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so309179pjz.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mzSa9wZBKlWhK0MfqqmZO/9vUDeVuVCig7dzjAMX9tU=;
        b=poqQLF143MSqjX1x09dOGpUZELMkqVG4vNZB2PH8jKS7wyUw0A9iY9zGVZ3qWDJ9rb
         oawjx9L3oObPLILFPPfqAuzEjlafiSg8GXvwrRH+KOGkTvmwonfCQfTe010LosiSNJVZ
         Cq9NWoiUfK6hmL0NLmUBxsyXLsSPWx/xnSf0b9+6UuERLwEZ0+niwqvqKaKs3n68jnu4
         t3I9t2bhawcfYthhIeyvt6QhSAxJPRmnYG1Da0fovy360VJ0fiHwEqk6/M0ya8fuDVEb
         6spBzwAp5I0GRsznKzmnRgir0U1zAv9aksoCiwoZ2i/ztvJCCEhR3KcAyaODBiFFlvHe
         wECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mzSa9wZBKlWhK0MfqqmZO/9vUDeVuVCig7dzjAMX9tU=;
        b=t4+FJxyRtnSIUmABWvVOPH0jUlmgUL21jlRiCs9RtsHvIbYQvFOCjAUZDj6Fi98b+E
         Pc6bCtpxyVqMNXdiFFCD4OrgZZtRrB+F0RWMuAHACUctY55RYGHDytbxmyfCOC6v66om
         LEyudyLTx/1y3+EY2Ux96/engSS0qSyfEG7qlQXmxnCbbFQeXbtb+jqMKWW7xutrUKqP
         DDzfA5+Zc/AjK20QV/HfZaWleSEABfOskOo5UQVVms6qU2/fDYwSmU6VgxlLuYFlOGE0
         53LcY1Olu7C4YwdAR5q59+T9loyrqgE4n3grGIQeJW0q77XmAOnwLh4PjgcdyzD+lgjK
         sQJg==
X-Gm-Message-State: AOAM5329Q8p6CDjMVnWkh3gchua7izAUu+RqnorXwoVLpo9SIanQD229
        NgXUg+JzzpWVWmQemrS8Y5tnme+8SchO+w==
X-Google-Smtp-Source: ABdhPJy/jURIOVEtyn0M+4wXFYwWfE4UEADRr4DC3FcP1IgRZ/135+xS9pCFjmSYRiKZCcwC4jlp4w==
X-Received: by 2002:a17:902:6f01:b0:138:9aca:efda with SMTP id w1-20020a1709026f0100b001389acaefdamr11493582plk.19.1630947008991;
        Mon, 06 Sep 2021 09:50:08 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id 11sm8143234pfl.41.2021.09.06.09.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:50:08 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Move similar execution in to a
 function.
To:     Greg KH <gregkh@linuxfoundation.org>
References: <YTUQZdPiYFscIsvU@user> <YTXjSwWcyd6RRMjO@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <4b62cbec-b356-b920-17ba-3ee7cc6f9713@gmail.com>
Date:   Mon, 6 Sep 2021 22:20:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTXjSwWcyd6RRMjO@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/21 3:15 pm, Greg KH wrote:
> On Mon, Sep 06, 2021 at 12:15:57AM +0530, Saurav Girepunje wrote:
>> Move the common execution for read_macreg_hdl, write_macreg_hdl,
>> write_bbreg_hdl and write_rfreg_hdl in to a new function
>> common_read_write_hdl.
> 
> You said _what_ you did here, but not _why_ you did this.
> 
> I can't easily see why you did this, please explain it better in the
> next version of this patch.
> 
> thanks,
> 
> greg k-h
> 

Ok, I will add explanation and send next version.

Thanks for review greg.

Regards,
Saurav Girepunje
