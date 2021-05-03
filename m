Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E49371756
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhECPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhECPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:00:36 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FACC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 07:59:42 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a11so4336211ioo.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6egtxTN5q4QLPOJLRd3y+Z0fKzalIDR3UohhkwtOCM8=;
        b=rMzOccYnjQjJTQplZd4m5b4GYay4fmSvBEXQ0cyrH9TWKEEaxSW7ofFPCXRs6iV6ZV
         gn73VPb/MX5vg1btYyq2Gj38MRIouiIJ+j4GMlahaOcMMPBIAXqGfHAvFgbZPraXTR1Y
         +WcV4bAqr2poTCc3OMyAQpdso+VA272r2vwbSwj368IFnfgMBk7pUWjQ4YYZfWRO/7Xs
         H1rDmVrdkjETcygVtzVSBfcngngQLovheZLeGdIPvPJWR0sR+z2l52KuNSmNoMVppLNR
         AvjKs1NTEeLXCGjD0BIUOLk7xVt68zMFFQACW9XAzHC4MNaclyET0PVR8awjabSMexKU
         vVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6egtxTN5q4QLPOJLRd3y+Z0fKzalIDR3UohhkwtOCM8=;
        b=mF4Tn3Hxfev7EUm8Vt0fJLYzUzMjL6xAFxyxJyiy/a7jv9Gz8ntMK65wGmogPUDkjB
         eBZ/zQ4CkmNKOOCFBeK/h9ZfTTHVh/oVBWSuwqHeKctiMaQB6Plb+bD3T0Bg6Ww3exR0
         JFSgetO2z9WFj7b0vNGZT+ksCfHpZtn+ECWKcJFPWQ3VW/Z9m+yKGJQiBEtVTSDwNAvQ
         2nt5cpac2RG6kix7lm/nf+tErE6goz7Ux6pk1Jv4kxo98gQxDEYs2aM5sPL/tW9C5Wz0
         NoI2xJ6SOkgMhRhNtxtS3v0kF36Yqjy5NGMak0aOnPFdDYthEvdqWxCUQ1W5hKg3tmpq
         dmAQ==
X-Gm-Message-State: AOAM533o2kPNrKFRSRwuy7/8CpQ+x780yoqvCS6bd5GCo+0zXJ0iKhLj
        VOay+9uNtnvElArpkPhxTuuxzw==
X-Google-Smtp-Source: ABdhPJwI1R2aI/WV1VcSccFj48I+dXgpwOXLiCW3REwd2nVuBgcj93isKO595yRlv6MPq97L7l7nBw==
X-Received: by 2002:a05:6602:81e:: with SMTP id z30mr15264730iow.90.1620053981968;
        Mon, 03 May 2021 07:59:41 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q26sm273508ioh.42.2021.05.03.07.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:59:41 -0700 (PDT)
Subject: Re: [PATCH v9] bio: limit bio max size
To:     Bart Van Assche <bvanassche@acm.org>,
        Changheun Lee <nanich.lee@samsung.com>, yi.zhang@redhat.com,
        ming.lei@redhat.com, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot@kernel.org
References: <CGME20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa@epcas1p2.samsung.com>
 <20210503095203.29076-1-nanich.lee@samsung.com>
 <72a0b4e7-a374-97fb-ae73-ed24f719da98@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c48d45cc-9c4f-0b6c-51d0-3044e7cdf7f5@kernel.dk>
Date:   Mon, 3 May 2021 08:59:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72a0b4e7-a374-97fb-ae73-ed24f719da98@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 8:54 AM, Bart Van Assche wrote:
> On 5/3/21 2:52 AM, Changheun Lee wrote:
>>  struct queue_limits {
>> +	unsigned int		bio_max_bytes;
>> +
>>  	enum blk_bounce		bounce;
>>  	unsigned long		seg_boundary_mask;
>>  	unsigned long		virt_boundary_mask;
> 
> On April 23 Damien Le Moal posted the following comment about the
> bio_max_bytes member: "Please move this below in the structure together
> with all other fields that are unsigned int too." Making that change
> sounds like a good idea to me.

Why? It's next to an enum, so the patch (as it stands) actually fills a
hole in the struct. Moving it would be a mistake and waste more space.

If anything, we should move the bounce member below virt_boundary_mask,
but since this one fills a hole, that's better left as a separate patch.

-- 
Jens Axboe

