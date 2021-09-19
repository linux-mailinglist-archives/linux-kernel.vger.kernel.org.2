Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D5410C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhISQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 12:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231449AbhISQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632070282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9A/ZW/hYr0iV04kgVzIKko+q+g2fbtqUk/FZXyEAQM=;
        b=M/kWPRcgI2nPkaSD6YKvuBHIsK7UwlHeYGwjvPTD0UouJylMX3xdJAK+nvaLlJNb5DILXR
        uioQL+yiPPquknz6R9hFbqXrBRaFo106oICifJy6nlR6XTZrBo70dT1rbgllOBQtdAw/hU
        IKjDup70BQE+6WcSfPYeqsV/9IFO3e4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-rhlz5vU0NdSdMhkCviwjfQ-1; Sun, 19 Sep 2021 12:51:21 -0400
X-MC-Unique: rhlz5vU0NdSdMhkCviwjfQ-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so12690703edn.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9A/ZW/hYr0iV04kgVzIKko+q+g2fbtqUk/FZXyEAQM=;
        b=NRtS8coYyV6AxHNWlXzZOdM2Q9jTHCfJ5uuheXfAucCRhQ8OGAorrnq1c2ZJUxBVX+
         icQGx9Ri84Nx7QBEp/OV9MsXVdyPPCwnKPJA6XxrrzllC2U0B/WpX5kLVdc9XQ6/0vI/
         rk0h6iLnwPk+j1UvDu6iBYv9pOTjFCTABKvSNfLm6l+aE1/kpo2Jh3hGFn+U8xlJhD1x
         GOCuMvuBScblKPWmeYnHwXe/j4Lheb9yHdvs3GWsgm9UcZ9FjPLgiSaumVPRDpR0+Zrs
         r7+IiAqWcntPpaSAmXiqmwvhmh3nEWWRJtlYlyMtr44dqVI1zS26jwMGTPKMLlP6E6Se
         3LYA==
X-Gm-Message-State: AOAM531Cu41/0ebHbtSqp5LulpSlZ0zEcJRHLa15j0ebFasPwOvxiSeJ
        SzhoVxvJArvYM++lOe0VCaf2PJdEYi6sq/53F4ZvaBiposIvUzVUYyx5cq6E6KmxbHKx/8f8Zlp
        oLZGFfr0qRnjdLiHerq8LoJ7x1shYWd18yehqinB0ZxR8yd3XIBU2SbPNtivlzDxJpdjEW8jGxR
        XG
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr24857559ejp.520.1632070280219;
        Sun, 19 Sep 2021 09:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu9tmc5IiASoxzvTqmp01CKGM4gJcPBoC8MmukNHpp+eGCuR+z/e3wHMSPI4q1UQCKZCuUKA==
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr24857543ejp.520.1632070280004;
        Sun, 19 Sep 2021 09:51:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h8sm5277277ejj.22.2021.09.19.09.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 09:51:19 -0700 (PDT)
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
To:     Tor Vic <torvic9@mailbox.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
 <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
 <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com>
 <yq14kb24e97.fsf@ca-mkp.ca.oracle.com>
 <f071dfb3-1aad-003c-00bc-6b7ecf103e91@mailbox.org>
 <967d7639-fc31-a209-8c21-ea8ab3718de6@redhat.com>
 <66b4c377-1b17-1972-847e-207620cc9364@mailbox.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <361d702e-44c4-625f-5b6b-121a4dc07105@redhat.com>
Date:   Sun, 19 Sep 2021 18:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <66b4c377-1b17-1972-847e-207620cc9364@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/19/21 6:27 PM, Tor Vic wrote:
> 
> 
> On 19.09.21 15:27, Hans de Goede wrote:
>> Hi Tor,
>>
>> On 9/19/21 4:24 PM, Tor Vic wrote:
>>> Hi,
>>>
>>> I saw that v2 (?) of this patch has made it into stable, which
>>> is quite reasonable given the number of bug reports.
>>> Are there any plans to "enhance" this patch once sufficient data
>>> on controller support/drive combinations has been collected?
>>
>> ATM there are no plans to limit these quirks, we have bug
>> reports of queued trims being an issue over all usual chip-vendors
>> of sata controllers (including more recent AMD models).
>>
>> Note that unless you have immediate "discard" enabled as an option
>> on all layers of your storage stack (dmcrypt, device-mapper/raid,
>> filesystem) then this change will not impact you at all.
> 
> Is that the "discard" mount option?
> I added this to one of the partitions residing on my 860 Evo,
> reverted the patch, and it still seems to work just fine.
> 
>   $ mount | grep sdb
> 
> 
>   /dev/sdb1 on /mnt/vbox type ext4 (rw,nosuid,nodev,noatime,discard)
> 
> Is there another place where discard has to be enabled?

No since you do not seem to be using dmcrypt/raid/lvm that should
do the trick.

Except that it sounds like this is a partition carrying vm
images. Those never delete storage, they only grow, to
effectively trim you need to either punch holes in files,
or remove files. Discard only comes in to play when used
diskspace becomes unused.

To test preferably remove several large files at once while
also generating a whole bunch of other diskio (e.g.
compile the kernel while also deleting several large files
from the same disk, with discard enable).

But even if that works for you, that is 1 report that this
works in some cases, vs many that it does not work; and also
note that you had to manually enable this, it was not
enabled before. So this really is going to impact the
performance of very few users, while looking at the amount
of bugreports about hangs / disk-corruption the problem
of having queued-trim support enabled is much much bigger,
so I see very little reason to re-enable this even if it
happens to work in your case.

> Or is there a way to check that discard is effectively enabled?

There probably is, but I don't know where / how to check this.

Regards,

Hans



