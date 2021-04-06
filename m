Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ECF355C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbhDFTuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233018AbhDFTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617738600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTzJR7XbmiabDROWf/tRvtql+2pagdo8Q0WmLPBWbq4=;
        b=IdUAWSnufQ9N2jJsd0JXx0xLYMSzztG+uu8MCcFcvepQZN39Z83vcl+UMk10bvxqfdWQ0l
        k8AW6EgSIVvBQ6kgxFfPUTJnQD3FeLVWlLVcWyOKgsOKk/AGpQV0d2o+NaAu6GpzbkHTzY
        ZoIJfr4k/0hyZsDCSueEkzqdFv8neP8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-m1AkBEknONW6aRnOWSbzBw-1; Tue, 06 Apr 2021 15:49:59 -0400
X-MC-Unique: m1AkBEknONW6aRnOWSbzBw-1
Received: by mail-ej1-f71.google.com with SMTP id jt26so127509ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 12:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wTzJR7XbmiabDROWf/tRvtql+2pagdo8Q0WmLPBWbq4=;
        b=PmVJB51ej1OKoEFe5D/YauUf75lVz25MzBiBJ2t5VR/cDwElVZP4lpu71ydV+Wdkz2
         s3RWUSQnCTb63whIGpOcFI78qfv0DKlHxmaFG/wRRZ25RxaRB1yQ0K0JvVQp1qGMarnG
         FeTLR3dLwXtw5NKCcFIrtWXChl1U/OiJNkMro0L9G6BoFdGzgCOHcDNvVEqK2oIo/YIt
         dCNwmrFThKJWHRuzXKDVGFjqvcrwgWDkgj1l4zhcAoW5BHpO1nkQSfJJvd5tBfRS8i8d
         tEFSD8bZnRawmLaaYjFmdpR8p4Z9gkY3NlqFCl7PmnTJ8NH25drOSaDXn2rZwyLKxPuN
         0pUA==
X-Gm-Message-State: AOAM5336scl0JcUpBeBWr5BEsTAquzEQJDG065cFRY8HjH5dGmkD5sw5
        hVoIKNWQMzLNRZ1bU+9MgsZbOfd6D6sZg5cu9krEwgfCSnSmJ7Kq2jeFpmPsFOKiudp8x58JauZ
        czJb+I1Q1WBMm6GZ4WNX4yIiqGAWnYhDd8ZCxIpddYn0l7jR1+UmE6YM+NeWwtfTaLPmfHag/gN
        RG
X-Received: by 2002:a17:906:9a48:: with SMTP id aj8mr607453ejc.468.1617738597766;
        Tue, 06 Apr 2021 12:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL1KgXNz1wkNd91JTXhCUZ04j/NggKY8Jpwy3qKfXSHUf+T3424HY/NzfCNDC/sswxM9NLsA==
X-Received: by 2002:a17:906:9a48:: with SMTP id aj8mr607437ejc.468.1617738597561;
        Tue, 06 Apr 2021 12:49:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s7sm6182940ejd.106.2021.04.06.12.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 12:49:57 -0700 (PDT)
Subject: Re: [PATCH 06/12] platform/x86: intel_cht_int33fe_microb: Constify
 the software node
To:     Wolfram Sang <wsa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329105047.51033-1-heikki.krogerus@linux.intel.com>
 <20210329105047.51033-7-heikki.krogerus@linux.intel.com>
 <6d4d44d5-c213-1052-16a6-833a7f01a0ee@redhat.com>
 <20210406194059.GE3122@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e0266f36-5d9f-4d1b-714c-94e15c1b4d5e@redhat.com>
Date:   Tue, 6 Apr 2021 21:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406194059.GE3122@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/6/21 9:40 PM, Wolfram Sang wrote:
> 
>> What is the plan for merging this patch / this series ?
> 
> I'll take the series via I2C.

Ok, that works for me.

Regards,

Hans

