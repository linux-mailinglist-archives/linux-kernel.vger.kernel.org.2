Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08701414A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhIVNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhIVNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:22:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC84C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:21:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i25so11892359lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6arDu0bHKhe+YT1UraMY0MBKwysBZPAsrewYON3ecAQ=;
        b=WjzdbaM+CXMA0teP/YGVvk89FeUFWuAbqAV8nRAin4e3Eb9ONN01Is26Gx6n8Q/s6c
         ZFv0k9lALvY0u9SkBX60mP74hQl2jN4Gu1dMP7fWXHJnvW1FHLCpDi2wxqUjL2PlP44t
         liF+YxmV9KANbC4Jgrw6SFr5pSrbgmyBBXTeiZdtEYAU87qQaFy6jAj1Du6r1i5eP1jA
         qN2JVkpXCQvXNHP9JYgOkJg1XWXL5MR6bhXozG/DoisVT3fdyvgdhjPycq05WvwFp4Tc
         pKP0XZORlFxN0NCB6RPmhze0lekX+5EHMHzhCf+873B83J3GD5e66vEyKWYhAlgMFLTI
         B+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6arDu0bHKhe+YT1UraMY0MBKwysBZPAsrewYON3ecAQ=;
        b=g1dEQt66frRR/Goc/urfmWs8bH9bA5O5DK2MfWpS752S0U6yozrwy/WYUPr8aEYLT6
         zrE+0rEpNdKWhgs+ljRJo1R4T0pr8vHon4CCWgR3Gu8PVUj2uhXymBip2hHOezYzC1cb
         3FVOFxI0O4WTSob13AENqFEOJuMJ2Wtm83zM30k4VWCxkPR3da6c6vQKsK2cxhvDWdoi
         hUbwHiwBOdx79emqWn1fgJ4Q8djCcKvq93Gafwe3XyNBkGPrT0ejeAXlu6Az1ymxIK0U
         yx8JoyywoybhdrwTLsbPFjti4Of8UhprK/DpAcXJNsbiHg3TG6bw1X0V+zp2YZXJjI9i
         sn/A==
X-Gm-Message-State: AOAM531yPG0ZZhl126omIccSHMyTI1hKKcLe2RXmaDxc/aQgsB6UFhz1
        IGO4Z7Y45AKmFv0qcb3NdA8=
X-Google-Smtp-Source: ABdhPJzKMoiib1IP7uFrzIzqrHdxIHI16pju0WUINfy/rVOkyx6qheK25/MW/1hVXwMMv27iUGuXvA==
X-Received: by 2002:ac2:5322:: with SMTP id f2mr15956976lfh.531.1632316867286;
        Wed, 22 Sep 2021 06:21:07 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.49])
        by smtp.gmail.com with ESMTPSA id y9sm191715lfl.240.2021.09.22.06.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 06:21:06 -0700 (PDT)
Message-ID: <dd99d40d-297e-8d27-dabe-d0e4c633d391@gmail.com>
Date:   Wed, 22 Sep 2021 16:21:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v9 16/16] staging: r8188eu: remove usb_vendor_req_mutex
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
 <20210921181834.29677-17-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20210921181834.29677-17-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 21:18, Fabio M. De Francesco wrote:
> From: Pavel Skripkin <paskripkin@gmail.com>
> 
> This mutex was used to protect shared buffer for USB requests. Since
> buffer was removed in previous patch we can remove this mutex as well.
> 
> Furthermore, because it was used to serialize the calls to the Core USB
> API, we thoroughly tested the enabling of concurrent firing of USB requests
> without the mutex and found no problems of any kind in common use cases.
> 
> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Hi, Greg!

If all is OK with previous 15 patches, please, do not take this one, it 
  causes problems with connection... :)

I don't understand what went wrong after v8, but anyway, this one should 
not be applied for now, since it's broken


Thank you



With regards,
Pavel Skripkin
