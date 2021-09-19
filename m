Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7C410C28
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhISP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233267AbhISP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632065229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSy0qSazpxmU03SoDhSpde0uFhTOnrJsDqywzUzjo44=;
        b=d/Oz6Ktj70an1Fh/hdY/CXzxFAXpARRab/K4D1QKTbt1e+6xfIau8M7TZMzxquj2C8iw7e
        bjSx9We6toqS8cjJkByOhxENiu1Xel3+WK1qgIC0oEJW/gb4ky+2OX6wV9xv7xVvS0WKOg
        YgKd9pkZr0R9WAVShiAUU3GRwQAwIWU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-lUb-M7z9O-utWIoD96Vq2w-1; Sun, 19 Sep 2021 11:27:08 -0400
X-MC-Unique: lUb-M7z9O-utWIoD96Vq2w-1
Received: by mail-ed1-f69.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso2212775edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSy0qSazpxmU03SoDhSpde0uFhTOnrJsDqywzUzjo44=;
        b=nI9uiIdCb446qNIK9wt7vqAWQaBfZfDDXbwGbCEU1vNakHAAEYTqeZ1jnP3QyjdVJP
         HF/qbWrP2p/7mJi4iC1EXmAeZh1ojLgOG38s/3oPzY0m9G8QG06LkwSFd0IzjTgNuhp0
         /cNs6X77KEr46vBh17mWlNj9kNAL1UdGKElJ2HB5xpzwQLVVkZ+CC5UQlq2wX2QHKG4w
         mGHGh65nI+itvNqAhsdN3BG/ES1POhnNZ7S28ZO+qA9L+tKokjkQALaaWCOBV07w2Hcz
         cuxQVrche/DU32E4Mpf42pZHxVZvLL4EDOuiM8JivY47HOC4CcEOterTulW+z+t3pslw
         84KA==
X-Gm-Message-State: AOAM533gXCCUpNv4U9rhoiLHMYoDTHYBwhcsago72qASMdM6cCcc2RO/
        +qGosr7c+u6ajm+lUvGePNm0bpId0iDpDZ+VbtUnqt/R0sijxruCpHhLk6lXaL8kUzm71z6U6m5
        oWp2BiqUsRV/2aceumRXihXnboy0tYG7hd8oyQHmQ4VuBAtIAnHZkitHzyDDpHVH6abFsK/0BbZ
        83
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr23233455ejb.278.1632065227118;
        Sun, 19 Sep 2021 08:27:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymySWXR5PitvxFBfYirVcRcCRDdr9WoU5KFrhKSouL5UtZ+ltob0hExB0o/D3JAvzxSNkAyQ==
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr23233435ejb.278.1632065226849;
        Sun, 19 Sep 2021 08:27:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p24sm874569edq.27.2021.09.19.08.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 08:27:06 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <967d7639-fc31-a209-8c21-ea8ab3718de6@redhat.com>
Date:   Sun, 19 Sep 2021 17:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f071dfb3-1aad-003c-00bc-6b7ecf103e91@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tor,

On 9/19/21 4:24 PM, Tor Vic wrote:
> Hi,
> 
> I saw that v2 (?) of this patch has made it into stable, which
> is quite reasonable given the number of bug reports.
> Are there any plans to "enhance" this patch once sufficient data
> on controller support/drive combinations has been collected?

ATM there are no plans to limit these quirks, we have bug
reports of queued trims being an issue over all usual chip-vendors
of sata controllers (including more recent AMD models).

Note that unless you have immediate "discard" enabled as an option
on all layers of your storage stack (dmcrypt, device-mapper/raid,
filesystem) then this change will not impact you at all.

Also note that AFAIK all major distros do not enable immediate
discard, instead relying on fstrim runs from a cronjob, which
again means this change will not impact users of those distros.

So chances are that your workload simply never triggered the issue;
and this is the cause of everything always having worked fine for
you.

Regards,

Hans

