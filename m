Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7D4279FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhJIMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 08:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232995AbhJIMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 08:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633781484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKwH1AQ8+kltMVWWlSh3UrS4QYWo2BzlpfwvNcamlmU=;
        b=EYdve1I/sGevtCUDoILWMxudyRlC67WnlGxrVA+xyPrjr+mG2q+Tl0YC+oq6rYalGJiqnv
        jdAZw3r/xKdE/BQKxIpnNqHS/EkbW+v5CdLUlaMegrRLqf0V/dc30Nn15/PyRtmHSKAqWv
        DvIm32Ip0u//f0szypc3YlQIC7oV6RY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-gXYg4WXyMB63nIlhHtOLZw-1; Sat, 09 Oct 2021 08:11:23 -0400
X-MC-Unique: gXYg4WXyMB63nIlhHtOLZw-1
Received: by mail-qv1-f69.google.com with SMTP id t12-20020a05621421ac00b00382ea49a7cbso11031050qvc.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 05:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QKwH1AQ8+kltMVWWlSh3UrS4QYWo2BzlpfwvNcamlmU=;
        b=grJmv6XQ5jrHkzNInny7s76RHMeTD8m0L9niq1p0dI7OwRD/BSi9RKqV2zzPaIvVDd
         XZ5qcugkj7lcCwjK5la9sqUvPqpgQAZyjyR8nD2xMeUU1htiFM2xTkcj7q/oS4VRYUIm
         J0yfdP1XxPj4Kb+/37jr8CUGpVpi2oa+g6yu2VdLhvi7mVNq/XZ4rVK4AwyaTyL4F+aI
         mQLxy6nfzGWXvXBRZ95aA3VHgwYGWwSGMHuvf7ZttWgepdUGKTuaVuaVTUCVQY7uu9LW
         VTQOPe9hWWmhkG1KZzaYdciPV3NWlig8wuAMyr2f/JuZmInzbNJFaqReksjjSDq10sTV
         KnYg==
X-Gm-Message-State: AOAM530ozieMIA/n+9SehIMZrqzCLSbp6s616o1NPMCFf+vZSVKIsc7k
        IPTpVhaFnH9Tqi5IW4ssPxHjKCpX1z+iJ+qfTFmY+cCTSlVfQiHS42Hssude3gFvpGykhi2kMCe
        iXxZ3GXfZQ0ytkU5mhqJDkKWo
X-Received: by 2002:ac8:614b:: with SMTP id d11mr3566696qtm.396.1633781483237;
        Sat, 09 Oct 2021 05:11:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdYalZXDw5wrJxDyVhw6BPxuWtjDsnkMz+tTLNVUPz4ey5j1iP6Qji6Ygr404AffYHlGwppw==
X-Received: by 2002:ac8:614b:: with SMTP id d11mr3566670qtm.396.1633781483014;
        Sat, 09 Oct 2021 05:11:23 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r6sm1349122qtp.34.2021.10.09.05.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 05:11:22 -0700 (PDT)
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20211009080859.GA85181@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
Date:   Sat, 9 Oct 2021 05:11:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211009080859.GA85181@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/21 1:08 AM, Xu Yilun wrote:
> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>> The FPGA Image Load framework provides an API to upload image
>> files to an FPGA device. Image files are self-describing. They could
>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>> specific files. It is up to the lower-level device driver and the
>> target device to authenticate and disposition the file data.
> I've reconsider the FPGA persistent image update again, and think we
> may include it in FPGA manager framework.
>
> Sorry I raised this topic again when it is already at patch v17, but now
> I need to consider more seriously than before.
>
> We have consensus the FPGA persistent image update is just like a normal
> firmware update which finally writes the nvmem like flash or eeprom,
> while the current FPGA manager deals with the active FPGA region update
> and re-activation. Could we just expand the FPGA manager and let it handle
> the nvmem update as well? Many FPGA cards have nvmem and downloaders
> supports updating both FPGA region and nvmem.
>
> According to the patchset, the basic workflow of the 2 update types are
> quite similar, get the data, prepare for the HW, write and complete.
> They are already implemented in FPGA manager. We've discussed some
> differences like threading or canceling the update, which are
> not provided by FPGA manager but they may also nice to have for FPGA
> region update. An FPGA region update may also last for a long time??
> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>
> My quick mind is that we add some flags in struct fpga_mgr & struct
> fpga_image_info to indicate the HW capability (support FPGA region
> update or nvmem update or both) of the download engine and the provided
> image type. Then the low-level driver knows how to download if it
> supports both image types.
>
> An char device could be added for each fpga manager dev, providing the
> user APIs for nvmem update. We may not use the char dev for FPGA region
> update cause it changes the system HW devices and needs device hotplug
> in FPGA region. We'd better leave it to FPGA region class, this is
> another topic.
>
> More discussion is appreciated.

I also think fpga_mgr could be extended.

In this patchset,

https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/

A second, similar set of write ops was added to fpga_manger_ops,

new bit/flag was added to fpga_image_info

The intent was for dfl to add their specific ops to cover what is done 
in this patchset.

Any other driver would do similar.

Is this close to what you are thinking ?

Tom

>
> Thanks,
> Yilun
>

