Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F964446EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKCRWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhKCRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:21:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BFC061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:19:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so2904042plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=xylmLYwSqxe7ddC9lf3Dj1p06tQREVYRAq/82AiLebA=;
        b=ZkT6x7+9+v0Hys8UGCw/tT28nklCC1nVQ7x0pTbEvlqONXqeHKJcuD/A0BroFoXv+C
         6x1Hh56jY6E4IjYB0qycdCzSAISQxvPrc+CyPcSFYGmCMhIfVb+81tLuVWybccV+ve2P
         UtPESS8kvuIS0XOM41N0Bk0TP9bRuD3QdgAks0SfQYXvdkm883PP9YgqPcTMjcjptZ0v
         c5C5lBCmn1e0+09GQR01qdUfAUCoDYCa+WL0P/k3ccqDRN9ATJiGq++Bd8DyaOY00fGY
         8JrdLC1q8UZ+NNyzjyfeC+NyiFcgRQZHxph8xlwpNyoRrPocYc93Y+tQKmWWLbrfEKVy
         KAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=xylmLYwSqxe7ddC9lf3Dj1p06tQREVYRAq/82AiLebA=;
        b=s16UdtC6UQouFeTDx3wKzC63kOhk1gnVC8D388ZoWH9h/Ek0rDie5fjbib/Im6g08V
         wHYVfjGsufnIwYkuI/ehX2rsRkQ1yKmCawLLd2v7bU3q3488Ac8PSl5V7cSFW3gWFlPT
         Wn6Bt8Z1tBD+zAD6z5LlJs2OGEPGysb4betxlkNkmNdboUvIx8wjEwN4wxOAPankIeNF
         OIMAqizjUOTOMFyBwQzvch2Ggoh0b3yfnAwhXLT5ntACfI4fTYIhWSYItVa2lQZR4NCt
         1Hyy25nEySHV9iWCZa9Bj3cuMo9dvmdq/NAYOX/vhbbpjqNQl4eGvmHAX7x+PGD8L1SZ
         QFGQ==
X-Gm-Message-State: AOAM530AP3Bspb9bPKdPvwLGpe33AxX+pgmMg1cLeba0CSqUBeuw6X+1
        GVIaY8qu7sS+bJSBruMwhrWg9X9NhKD1syzN
X-Google-Smtp-Source: ABdhPJxSZRsseumJS6R7lG6abyM878BBPjd31eD/A8tk9mzHlkJERD/s+UB9Vrs6wMR139MT4DRpQA==
X-Received: by 2002:a17:902:7804:b0:13e:d4c6:e701 with SMTP id p4-20020a170902780400b0013ed4c6e701mr39345570pll.66.1635959962673;
        Wed, 03 Nov 2021 10:19:22 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id z8sm2461903pgi.45.2021.11.03.10.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 10:19:22 -0700 (PDT)
Message-ID: <62249975-7bcc-f23d-808e-8a0da1131570@linaro.org>
Date:   Wed, 3 Nov 2021 10:19:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
References: <20211103170659.22151-1-tadeusz.struk@linaro.org>
 <20211103170951.GA4896@lst.de>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH v2 1/2] scsi: scsi_ioctl: Validate command size
In-Reply-To: <20211103170951.GA4896@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 10:09, Christoph Hellwig wrote:
>> +	if (hdr->cmd_len < 6)
>> +		return -EMSGSIZE;
> The checks looks good, but I'd be tempted to place it next to the
> other check on hdr->cmd_len in the caller.

Do you mean in sg_io()?
I don't mind changing it, but putting the check here in
scsi_fill_sghdr_rq() was suggested by Douglas (cc'ed now).

-- 
Thanks,
Tadeusz
