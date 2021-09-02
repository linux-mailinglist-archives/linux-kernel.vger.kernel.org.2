Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39C53FF524
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbhIBUvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345215AbhIBUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630615808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQbxtwjvWQKASY6WHAu3BsyqnKPCj4Pmu1yx7Mqm3gc=;
        b=ENUpYlX4i3W+fyRYnie1Gycuzdc4tPKiTq0ao/Q2C12xLXxm3H+aPYrmgaREkkS4M4dxLe
        IljmPb5saeiYxFqnXGhHKNKx6NoRkCATYTlQT+3IHRiZMOxAPQw5n6sA1dYvwagWMfyu9H
        PPh/lWZ3gKTzEVWVTZ7wmR7a5mwgOXo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-6_S8YQHiNtOiniDj8RHJbA-1; Thu, 02 Sep 2021 16:50:07 -0400
X-MC-Unique: 6_S8YQHiNtOiniDj8RHJbA-1
Received: by mail-ed1-f69.google.com with SMTP id x4-20020a50d9c4000000b003bed5199871so1626383edj.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQbxtwjvWQKASY6WHAu3BsyqnKPCj4Pmu1yx7Mqm3gc=;
        b=l3jkhblfy9BkYsoBYgjeBIvrHySQW/VbGQVLTM2XQguXtLoGqr66xXigygweLuJoyh
         25HO+AD/2UnSTjQYg8nnv/mkdzGt741n9XAuboNm5kFHcfqrgmVz7Iy/3n89DHhT1YaI
         GTRrfaCfKtzHJbxGj4J8B311bF7fGT8KsMIXGdmp24s655NaKSwUIMpOqSl+akj19jvh
         s6mUKXfF93Ev1uL2Zn9ibAzcBjONPMaN5Wo/w99PcbUXyuNIseDS0xEucemVgd3nwbAK
         tLo674d69rXwFEtsBsgslQ7sTCmAMx55b5SttgbJeMOdZqYlMh5vX9VvxuOqgVMklgqJ
         98rA==
X-Gm-Message-State: AOAM533xUeBOlzzniJgmewTQeSe+46qJtItY0FJsLaoHoW1xlg/hqjEd
        NnR/eSiiAtbn/sQHajPw0rbVmpVdCrkCJm0k3e9O9UaDCRljtcZuvSUMwyXMqUnFgD5bCHpua+5
        ZbT+g0k5pr8BFyp3Md/iPOPtx0iQ+ojFuRAgfNAKAwGYPPMN05+lto7zik7vOZHM9EipWsq7CIy
        7q
X-Received: by 2002:aa7:dc56:: with SMTP id g22mr246027edu.187.1630615805779;
        Thu, 02 Sep 2021 13:50:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpXjEioEZ4NDMJiWSCSpSrqHi66kEFaovS7Z3RU5NrgGnCr+42S8pIlg8oEKUG4ZssCKiXsw==
X-Received: by 2002:aa7:dc56:: with SMTP id g22mr246004edu.187.1630615805542;
        Thu, 02 Sep 2021 13:50:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d22sm1716441ejk.5.2021.09.02.13.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 13:50:05 -0700 (PDT)
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860
 and 870 SSD.
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tor Vic <torvic9@mailbox.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901151643.13562-1-hpa@redhat.com>
 <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
 <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
 <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
Message-ID: <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com>
Date:   Thu, 2 Sep 2021 22:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again,

On 9/2/21 10:46 PM, Hans de Goede wrote:
> Hi,
> 
> On 9/2/21 9:01 PM, Martin K. Petersen wrote:
>>
>> Hans,
>>
>>> So it looks like we actually need to disable NCQ for Samsung 860/870
>>> devices when the SATA controller has a vendor-id of PCI_VENDOR_ID_ATI
>>> rather then AMD.
>>
>> That's another great data point!
>>
>> I wonder if there actually is a Samsung problem (given that these drives
>> work fine on other controllers). Or if it is just the queued trim
>> handling that's broken on 1002:4391 controllers from ATI.
>>
>> When I originally experimented with queued trim I had systems I could
>> not get to work. But queued trim worked fine when the same drives were
>> connected to more modern chipsets (note that this was "did not work at
>> all" as opposed to "randomly corrupting data").
>>
>> Do we have any evidence at all of queued trim working with non-Samsung
>> drives on these controllers? Not sure how many modern SATA drives
>> actually implement this feature. Maybe the reason we see Samsung drives
>> in the bug reports is due to a combination of popularity and the fact
>> that these drives actually implement queued trim support.
> 
> The Samsung 860 / 870 series causing issues when queued trim support
> is enabled are quite wide-spread, covering many different controller
> models from all well known controller vendors (Intel, Asmedia, Marvell
> and AMD). So disabling queued-trim support definitely is the right
> thing to do (and we should have done so a long time ago, I am to
> blame for this not being done sooner).
> 
> As for your theory that it is really a problem with the controller
> and not the the SSDs, I honestly do not know, but I doubt it,
> there are no such reports with any other vendor's SSD or newer
> Samsung models, so this seems unlikely.

I just realized that all newer Samsung models are non SATA...

Still I cponsider it likely that some of the other vendors also
implement queued trim support and there are no reports of issues
with the other vendors' SSDs.

Regards,

Hans

