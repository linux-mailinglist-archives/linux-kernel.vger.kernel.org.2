Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D423A1899
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhFIPKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231389AbhFIPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623251293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3petPtHlsPDryAINfA1PFiWj/Uqj+GdPUr7vulKPiao=;
        b=dNlqVUQf9AnOGAA9f2VxFNybQLhZPLgNQs8VS1LUCl1UDGEzyy8D5FRvVlOmewIlYdk3/T
        9Q0jAqSCXx5S9HoGx/N53Z5uZ4rORui/YGT0Iey6cYRT48LCHycRb8GvrA6Odw6bX1wWrj
        iRvBD3Mgd/QgrN+8/nW7FuMwfbaJ2qQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-jtJ9SVRjMVa80ggQOyuoDQ-1; Wed, 09 Jun 2021 11:08:12 -0400
X-MC-Unique: jtJ9SVRjMVa80ggQOyuoDQ-1
Received: by mail-oo1-f69.google.com with SMTP id 3-20020a4a03030000b029024950bdb69dso10617697ooi.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3petPtHlsPDryAINfA1PFiWj/Uqj+GdPUr7vulKPiao=;
        b=MAjg3ALHn/PnwvY5t20st4HG4sVR4KhEGlJfqFNChx6L+L8KSIEZpEGjYnUJqFNZsk
         hQrDNx5tjicMLePmBTx++CajchG6npiNT5WUYu8xln+9jKAL65htw6VyTt4xdckGW2sr
         dX6hNsV9uHiHQ4oIbuFJnE73zYt8pGGso6nW8YdF00zl7ncYZwpaN7v7K34VyxvENXI9
         9WzhmEnAinQHDAnhn6CnflIz1nBRT7sVtVFjXgMXY+nSBneCYH8doJPMMASdBGZ/thnY
         ArTxEoyWPp6Wzchjg7qsG9ldBgQeLRxSys2dHwW/vX3GeWgqgfxDoGrBhNcH1F92jupg
         l3Eg==
X-Gm-Message-State: AOAM530FMPiF4mRhEgipxYtyco5QPK7j+CJVfZz9G2XFvYFpv53XVrC9
        hBo9JVN9MfyMuXdmdYyxRL0QBcpCBpeIKYxS3w7RiInTsQjKWHNO7S8iwa+IZeaLAsVbm7HooaV
        iQge6bIYXa8HVUYdq6KjM7wZ8
X-Received: by 2002:a05:6808:9b2:: with SMTP id e18mr7077831oig.109.1623251289112;
        Wed, 09 Jun 2021 08:08:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbHsFNlaNYpno/4x7efvptW6SQHPDd6WOjUIUALjKKBlIhJgxL+9Cv0ptzSOy7nphUSHVJvA==
X-Received: by 2002:a05:6808:9b2:: with SMTP id e18mr7077813oig.109.1623251288875;
        Wed, 09 Jun 2021 08:08:08 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t21sm45440otd.35.2021.06.09.08.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:08:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
Date:   Wed, 9 Jun 2021 08:08:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMDV7R52QUTFhpHH@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/21 7:53 AM, Greg KH wrote:
> On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
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
>>
>> There are several new subdirs
>> altera/
>> dfl/
>> lattice/
>> xilinx/
>>
>> Each subdir has a Kconfig that has a new/reused
>>
>> if FPGA_BLA
>>    ... existing configs ...
>> endif FPGA_BLA
>>
>> Which is sourced into the main fpga/Kconfig
>>
>> Each subdir has a Makefile whose transversal is controlled in the
>> fpga/Makefile by
>>
>> obj-$(CONFIG_FPGA_BLA) += bla/
>>
>> Some cleanup to arrange thing alphabetically and make fpga/Makefile's
>> whitespace look more like net/'s
>>
>> Changes from
>> v1
>>    Drop renaming files
>>    Cleanup makefiles
> You can rename the files, you just can not rename the .ko objects
> without everyone knowing what you are doing and you trying to bury it in
> the middle of a differently described patch.
>
> If you want to do that, do you?  I don't really understand why you want
> to move things around right now other than "we have 40 files in one
> directory, ick!".

I am trying to resolve the layout inconsistency between what we have and 
what the xrt patchset does.

The big issue is the files vs dirs.

Over specified filenames is secondary, so I dropped them.

40 files in one dir is itself not a problem.

having 40 files and an xrt/ is.

fpga/ layout should be consistent so the Makefile and Kconfig are easier 
to maintain.

My preference is for subdir's.

Tom

>
> greg k-h
>

