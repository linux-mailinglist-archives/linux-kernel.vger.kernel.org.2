Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0003A1532
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhFINNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236014AbhFINNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623244313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgFc0zAfSH9zoyjC3GQjE2BQSADVujKZP1GLq4MokGU=;
        b=U1qb9ayv+D7zwS1TayqoE8BmN4f/hO6EyK2sR4QhRreTkxTehwz56JO2/CSl5yMuPPlZo/
        KbQj3Hnj3/gLODOnqncpntcCYX/1D50Vv8Oa8pUKAebTiF7xk5UZb76pBTOP7Bzflkja62
        kVvrvSpqC0OCDe/J+5DVX1xcx3XciH0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-QSszJ_LUNZKw1EpZe7n7fw-1; Wed, 09 Jun 2021 09:11:51 -0400
X-MC-Unique: QSszJ_LUNZKw1EpZe7n7fw-1
Received: by mail-oo1-f72.google.com with SMTP id o2-20020a4ad4820000b0290208a2516d36so15502747oos.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XgFc0zAfSH9zoyjC3GQjE2BQSADVujKZP1GLq4MokGU=;
        b=Ufq7zhg+S9qlcjxAsuYVEiJ8woqzXKrbJDMjHDG7qqI+0AcsjtNLBw1LmGCbVRN2gN
         OYzKIsPkvDaSCyF+706z6FJrySr3b7o67SmI4BKGDUCwY9UCp9JJUnb52dihXNXwC4NY
         fdzQiZyAcEbu/rmmWVFzUkJLP2Auw3cPDVdD2cueTPMSJX/Jxi+YZnn/W02Qx5VrSYE2
         31Do3SUEetGEli6bVE1K+VO55GS/Jm1RfQz4/qtrKTSXI2+qksPbB1aFZew2ttf8HydH
         wPypStnYpNJ67hgWgMbJlBA1STAnW2xGTPOgXfcuso10GmlwhbdnYOphbLrs239GWnDP
         jCbg==
X-Gm-Message-State: AOAM530Th1MofhjfNCSiT0LoFwVUqUg2qF880SjiK3hbZmnLNfQ2yuz/
        SPnEozpsIVnJ0gPKCGFQmH+Ys2XE/gXDmWeRMOylVOKwQhYCKfmus6BQeKIieVYQKjBzBWMAItJ
        lyv0orNQm5OPSGoltVnZXgKfd
X-Received: by 2002:aca:53ca:: with SMTP id h193mr6249695oib.69.1623244311125;
        Wed, 09 Jun 2021 06:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLzHDUiczC4stYreaSJhKbN33Csqcp7tNRJT12jaa/wjcuUx4sflehsByzCl8QS3RSlUYwZA==
X-Received: by 2002:aca:53ca:: with SMTP id h193mr6249678oib.69.1623244310984;
        Wed, 09 Jun 2021 06:11:50 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g38sm224499otg.28.2021.06.09.06.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:11:50 -0700 (PDT)
Subject: Re: [PATCH 0/7] fpga: reorganize to subdirs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, nava.manne@xilinx.com,
        yilun.xu@intel.com, davidgow@google.com, fpacheco@redhat.com,
        richard.gong@intel.com, luca@lucaceresoli.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210608162340.3010204-1-trix@redhat.com>
 <20210608162340.3010204-2-trix@redhat.com> <YMCRRm/lB2+gfpS9@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a4e6f928-60c9-a8dc-9999-284c77dc152e@redhat.com>
Date:   Wed, 9 Jun 2021 06:11:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMCRRm/lB2+gfpS9@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/21 3:00 AM, Greg KH wrote:
> On Tue, Jun 08, 2021 at 09:23:33AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The incoming xrt patchset has a toplevel subdir xrt/
>> The current fpga/ uses a single dir with filename prefixes to subdivide owners
>> For consistency, there should be only one way to organize the fpga/ dir.
>> Because the subdir model scales better, refactor to use it.
>> The discussion wrt xrt is here:
>> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
>>
>> Follow drivers/net/ethernet/ which has control configs
>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>> FPGA_BLA.
> Why did we get two 0/7 emails?

Errr.. no clue,

I'll resend the set.

Tom

> confused,
>
> greg k-h
>

