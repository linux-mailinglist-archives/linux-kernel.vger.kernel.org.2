Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3294443BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhKCOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhKCOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:43:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F71BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 07:40:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g11so2548526pfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WXn/tck9I3dCSb6Sqxnz0FpL7sizj58Bae5H10F9O20=;
        b=WLcw+BX4CEBEwC5oxT61xEeODA46ZoNoaQq1Ki9IqYn8A4R8KLEqtrJAJagmlgla6Z
         O/rgOjq7fN87R5PedHVVHg8v0C8WP4EowdL2E780f6Aehp4LIvDHPgISJ3wE1omL5wfV
         5BVQ1PsWng8p5jSUQ3aa8zfQrfLORGL9w0tf5/cKSLjjIADE4az1jumM/HH4AjTR+ea/
         FPjbOers02FJtnn7jvz258mBdkVkZesCLAIyZuX47PJNTS80bb5PiJAtQHu7EXHak6ys
         hIh2LXUz3rveShzyCec0gYruXieX3mGz3bUKsAn4v8EyyYR/qFzYewRZ20Yjf+ziyzpN
         J7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WXn/tck9I3dCSb6Sqxnz0FpL7sizj58Bae5H10F9O20=;
        b=bG0N95F1y7WRGdUH/060zG7x9feebD0OJLE1RR1sxZXGtaXK6HxbuglsXBq6ib8An9
         JHk4Q4dkYQ7R66p0NxU5lxmg/BQkOPLTugvoOKMX8oAstC5VZgjyP8CLfILYou5RbUuk
         3p6P2Nuf7EV2ygo1MDxpAFiz+7JaAVlepZbesXL+UmOa+wfBCfwFBCrJi+hX2pzHI1t0
         EmTLYJHL0lQlLnkpxF/FNSHFNufvj/1ASuQwW1QmNiVr08WY4pzBoP6MIC7UI/eqXh91
         RSgJQLTHOvBbpNruLAzrRAjIvN6oYDEu/iZmgzouaTfOPSbr6Bui0HK7y4Q+RroGPejj
         xDAA==
X-Gm-Message-State: AOAM530JVCPoguzG2ojaOB8OoEFSI+yhk3/ZUf46Id98FRESeOalubPr
        w5rzm6i6iZZH+iQR3yC2Tr8knbpvUOLuV/PL
X-Google-Smtp-Source: ABdhPJxb1BGI7wiwVazryNyanP5gFZuzdtXbmEhWke+a/LIlM0549Gnd85lr7EzfpFeKlxD+/SIneQ==
X-Received: by 2002:a63:d00c:: with SMTP id z12mr32568626pgf.334.1635950451526;
        Wed, 03 Nov 2021 07:40:51 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id g22sm292376pfj.82.2021.11.03.07.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 07:40:51 -0700 (PDT)
Message-ID: <9e820a6e-a42e-1098-4044-5b6786ad7b2e@linaro.org>
Date:   Wed, 3 Nov 2021 07:40:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] scsi: scsi_ioctl: Validate command size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20211103003719.1041490-1-tadeusz.struk@linaro.org>
 <d1259a80-ac2f-a164-685a-4d1763653021@acm.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <d1259a80-ac2f-a164-685a-4d1763653021@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 20:32, Bart Van Assche wrote:
>> +    if (hdr->cmd_len < 6 || hdr->cmd_len > sizeof(req->__cmd))
>> +        return -EMSGSIZE;
> 
> That doesn't look right to me since sg_io() allocates req->cmd if necessary:
> 
>      if (hdr->cmd_len > BLK_MAX_CDB) {
>          req->cmd = kzalloc(hdr->cmd_len, GFP_KERNEL);
>          if (!req->cmd)
>              goto out_put_request;
>      }

I missed that. I will send a v2 soon.

-- 
Thanks,
Tadeusz
