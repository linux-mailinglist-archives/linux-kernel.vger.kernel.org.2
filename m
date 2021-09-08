Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C64037A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbhIHKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231723AbhIHKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631096137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ihDKG4Tw0EnUG+d0NDTmmjNsIWl/e+6yG1VQhYJPCg=;
        b=dQ4Ks5sApsizixegmRTOZ9pERC8XLdiKKEk48/minbzj4xjlQknr7HWi8nOMRhaIacQm8E
        Bi6WoEWyfQFMYZEuVKSyMgMLU8nXk+7jGVb5B8fLKYk23TA4tO6WQ0umnAOAAyrhod2sre
        /Qgs4rgAHTs8qpWgTNS4XuIzio4idFM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-3fDPr3F0PH-kZmB9x60m6g-1; Wed, 08 Sep 2021 06:15:36 -0400
X-MC-Unique: 3fDPr3F0PH-kZmB9x60m6g-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a056402270a00b003c8adc4d40cso823546edd.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 03:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ihDKG4Tw0EnUG+d0NDTmmjNsIWl/e+6yG1VQhYJPCg=;
        b=oToyEw4PKzZ6HvKdUGb7PGrnI9Z7JA1aF0S41AtDpbdzstxxtX9Qtdefx7xcAWRyGM
         6E+BOqi8fhDP5JCTEs2OZVdvQbt5mWwYYLxOfs+dy05rrMl30Wka8Vyt0/MctMVAC0bj
         7SQAOZZTIPWa7xAmsIjzYRxKa2oFQkfT7q9kGgTeqnWnQvBg1OHxJULg8WxtxMDQJFHV
         E0kyZpMa80/3r1qR2feRYzqkaypsl0j8Zr5INDzIq+QxCBfyjYCFbFdP8d+rpLGNAl9y
         GDO4nz5YmG/CZ3XhOQSf57L3TwXdI/75HHmU7d67IwtZoi7KPu/ftsqCGv1AoLExdqBk
         7d4w==
X-Gm-Message-State: AOAM5318vXQgu/fSCzba/NhMZYyqVPBBvZL8ccqWu2CpQZsHgYpdHUFh
        XTMGb/pj3JKvHUfa258JKXrNxvrbTL90UcIZXsImLA0IEBJn07szgpYSX4j65Yeel7hREwhnHOW
        W+J/gmuxA6c+nRU6GbngjhmEuTvE5xHmkFHImuRfNG6qS3T3eoLnrsO9v4t7r2TLpRLwkOFlfXn
        8=
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr1338495edv.187.1631096134906;
        Wed, 08 Sep 2021 03:15:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4/0lK2GziclYzvBU6oxOpxM0ciRAxQdwo0WMU2F/LVYgXFUcb99XNPS15AjWmOPxcWq97iw==
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr1338465edv.187.1631096134580;
        Wed, 08 Sep 2021 03:15:34 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-204-109.retail.telecomitalia.it. [87.17.204.109])
        by smtp.gmail.com with ESMTPSA id k20sm784805ejd.33.2021.09.08.03.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 03:15:34 -0700 (PDT)
Subject: Re: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "bristot@kernel.org" <bristot@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210831022919.27630-1-qiang.zhang@windriver.com>
 <20210907211714.696cca61@rorschach.local.home>
 <BL1PR11MB5478CF84562E63476BB1472AFFD49@BL1PR11MB5478.namprd11.prod.outlook.com>
 <20210907225534.7d9d48c0@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <dc614025-f79c-fefd-b337-7691e1d3c681@redhat.com>
Date:   Wed, 8 Sep 2021 12:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907225534.7d9d48c0@rorschach.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 4:55 AM, Steven Rostedt wrote:
> On Wed, 8 Sep 2021 02:34:46 +0000
> "Zhang, Qiang" <Qiang.Zhang@windriver.com> wrote:
> 
>>> FYI, no need to add the "# v5.14+", as it also breaks my scripts. The
>>> "Fixes:" tag is now used to know what stable releases it needs to be
>>> applied to (if any).
>>>  
>> Thanks Steve
>> I will resend v3.
>>  
> 
> No need. I fixed it. I'll add Daniel's reviewed by if he gives one.

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

> I'm currently running it through my test suite (with several other patches).
> 
> -- Steve
> 

