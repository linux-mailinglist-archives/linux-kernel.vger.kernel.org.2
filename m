Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8F3FF520
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbhIBUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232087AbhIBUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630615592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCglRUEE7rogtAfOGbvk+uUlCVK6Cupx/05Png5N9W0=;
        b=hbgY3y1CsYgoN9JihIq49VqkJUIOszJvQVApwCrCSiwCVBpT8fFbcbmCAjsUsqqflZocw+
        vD6j45dg8nn2xzkxQoGXmmY6OurWr7SHY5sfmv0xX0gvrk5do3xBxO5f5r/kJ9zFSL6mYr
        AQIkjAGYXr/itPnemkTCv2GzF1yoJNk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-erW04FsyNzyJG-i5XmYo3w-1; Thu, 02 Sep 2021 16:46:31 -0400
X-MC-Unique: erW04FsyNzyJG-i5XmYo3w-1
Received: by mail-ej1-f70.google.com with SMTP id c25-20020a170906529900b005c56c92caa2so1577407ejm.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCglRUEE7rogtAfOGbvk+uUlCVK6Cupx/05Png5N9W0=;
        b=ZLijVStC5SsLaOlX9fxiIP2Wt6ImSgRP6gHHqJI89LHCARLcK+nOwGM9J5sl5y/VMT
         QWt+1J2lVol8ZWzWT2h0HP+UT2ENfDjPPtfMwsndBrzXMrj0S6Lf8UEjg7QZxpif1rki
         h60tq1LNS5JM2TJej6i5wXjSBCxVr3O/mYnFPW3n+xApXgtfLRXugjwG5Yh40QPj4SZr
         hlcCYMNMajpNOBy+VTdR6okXERuePAm3nGsXnntys7D966DTj2V6ROIx5mLcoivKRzi7
         TGVZncJ6EFiNXdL25jlxqOYHCS1ajTZmCma6vPi1oCuyF+tkXa58y4gHRnqi2kGZbL9N
         wXbg==
X-Gm-Message-State: AOAM532SULDPcaOZJDbSs8mVQCTT/izyDSRAyKJNj+rKC4al4s7UcSYD
        QhbEPlqYEFm6RuboxEYO143uKcgzSwMnpG+5/prSrTV/znNEzYweOgYr2M3eF5jeV3hA165coJA
        vFf3kMH0jhMFOliQo7joH9LXGjKL1lx3e9RMGAOJ8aRQo1EEjXHItn+26L52B0b/6UeEC0+4UkC
        lN
X-Received: by 2002:a05:6402:714:: with SMTP id w20mr270982edx.62.1630615589424;
        Thu, 02 Sep 2021 13:46:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZkrpfUmKqFbYAigKUyboyl/I0MERdGX15LTrs0VwKkrMD1DPYnzz5haBWGo8xBvrcLPNz0w==
X-Received: by 2002:a05:6402:714:: with SMTP id w20mr270966edx.62.1630615589234;
        Thu, 02 Sep 2021 13:46:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id mb14sm1703522ejb.81.2021.09.02.13.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 13:46:28 -0700 (PDT)
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tor Vic <torvic9@mailbox.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
Date:   Thu, 2 Sep 2021 22:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/2/21 9:01 PM, Martin K. Petersen wrote:
> 
> Hans,
> 
>> So it looks like we actually need to disable NCQ for Samsung 860/870
>> devices when the SATA controller has a vendor-id of PCI_VENDOR_ID_ATI
>> rather then AMD.
> 
> That's another great data point!
> 
> I wonder if there actually is a Samsung problem (given that these drives
> work fine on other controllers). Or if it is just the queued trim
> handling that's broken on 1002:4391 controllers from ATI.
> 
> When I originally experimented with queued trim I had systems I could
> not get to work. But queued trim worked fine when the same drives were
> connected to more modern chipsets (note that this was "did not work at
> all" as opposed to "randomly corrupting data").
>
> Do we have any evidence at all of queued trim working with non-Samsung
> drives on these controllers? Not sure how many modern SATA drives
> actually implement this feature. Maybe the reason we see Samsung drives
> in the bug reports is due to a combination of popularity and the fact
> that these drives actually implement queued trim support.

The Samsung 860 / 870 series causing issues when queued trim support
is enabled are quite wide-spread, covering many different controller
models from all well known controller vendors (Intel, Asmedia, Marvell
and AMD). So disabling queued-trim support definitely is the right
thing to do (and we should have done so a long time ago, I am to
blame for this not being done sooner).

As for your theory that it is really a problem with the controller
and not the the SSDs, I honestly do not know, but I doubt it,
there are no such reports with any other vendor's SSD or newer
Samsung models, so this seems unlikely.

Regards,

Hans

