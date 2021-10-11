Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E007E428D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhJKMhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234738AbhJKMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633955708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ba4l9I0Mosgv3Ok9i/bESNFlFmplkPp7bopZCCj6mfc=;
        b=VCns617lKH5SwnvtX/iTKxuNyQKW9QXgc07ogXkPBPNpmYo+Y4Yd47qsQYJo/nD1rvXKoT
        5Tp7Fd7yNcVhIQGRr6whlr2f/4sEvfIXpu90sx1Mzy2ET4rPeCDfEz1KPGsz56wAVpEKVF
        5eJKE8PEGtBFVVVmhxeygGKYAmRLrQw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-3m1h5BGiMwWtfi6mwmV_zg-1; Mon, 11 Oct 2021 08:35:07 -0400
X-MC-Unique: 3m1h5BGiMwWtfi6mwmV_zg-1
Received: by mail-qk1-f197.google.com with SMTP id m6-20020a05620a24c600b004338e8a5a3cso13898080qkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ba4l9I0Mosgv3Ok9i/bESNFlFmplkPp7bopZCCj6mfc=;
        b=PDmthW8zFrq9nmGaPA2+spCohDGc5q/nwJmBJE2aKbuxoiiILSaN1LI1eqZukpQe9E
         MoSvAm6SWOXXs4soxRlxPGVXlEcwpz7AJsLYmAUi5YnqOa3VWeCniY7YGabkMOlYVfCJ
         iJSH3SbtywtA6wkCjAqDkSu/iSTB0VYeXSOCYl5xmAP9nchikneRA54IpnOM3bNGoKvW
         Mj7WH46W5XnxlHq6Gp47K/RWXxHscZxgF6zXtTfgj3EgpsQzxeLE1bEGIXGkYpUY2oE6
         4zExS0VjjozxTbUvk0WDNRdWQ4qd8R+pGfmc2BbwxKnbTXHjd2IjRkASDhAJzhBbYhHz
         xT2Q==
X-Gm-Message-State: AOAM532AseOBTahKILSsrO+cJ+696x6mQ+sgFLvZaMkRaNMifQZFJjju
        3nQPWelQpquZzd97ZY1g2YA3FsmU61Eb57ZSq1Yeqv9e04477N7FCXM7eiYHDb6MtJ6pHV4a5RH
        rqlMKJwYE+sMpzb37oAivkGYM
X-Received: by 2002:a05:620a:4c3:: with SMTP id 3mr14090464qks.19.1633955706708;
        Mon, 11 Oct 2021 05:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRyQvepzs8aBAqq3JIilECK82BCiuR7DKierj2oZcaTE2csUiDfuLDYvppAcutEIUGe8irog==
X-Received: by 2002:a05:620a:4c3:: with SMTP id 3mr14090440qks.19.1633955706508;
        Mon, 11 Oct 2021 05:35:06 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k19sm4281942qko.115.2021.10.11.05.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:35:06 -0700 (PDT)
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20211009080859.GA85181@yilunxu-OptiPlex-7050>
 <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
 <20211011014154.GA82360@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <79350773-3629-2734-21c0-0314a762e722@redhat.com>
Date:   Mon, 11 Oct 2021 05:35:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211011014154.GA82360@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/21 6:41 PM, Xu Yilun wrote:
> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
>> On 10/9/21 1:08 AM, Xu Yilun wrote:
>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
>>>> The FPGA Image Load framework provides an API to upload image
>>>> files to an FPGA device. Image files are self-describing. They could
>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
>>>> specific files. It is up to the lower-level device driver and the
>>>> target device to authenticate and disposition the file data.
>>> I've reconsider the FPGA persistent image update again, and think we
>>> may include it in FPGA manager framework.
>>>
>>> Sorry I raised this topic again when it is already at patch v17, but now
>>> I need to consider more seriously than before.
>>>
>>> We have consensus the FPGA persistent image update is just like a normal
>>> firmware update which finally writes the nvmem like flash or eeprom,
>>> while the current FPGA manager deals with the active FPGA region update
>>> and re-activation. Could we just expand the FPGA manager and let it handle
>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
>>> supports updating both FPGA region and nvmem.
>>>
>>> According to the patchset, the basic workflow of the 2 update types are
>>> quite similar, get the data, prepare for the HW, write and complete.
>>> They are already implemented in FPGA manager. We've discussed some
>>> differences like threading or canceling the update, which are
>>> not provided by FPGA manager but they may also nice to have for FPGA
>>> region update. An FPGA region update may also last for a long time??
>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
>>>
>>> My quick mind is that we add some flags in struct fpga_mgr & struct
>>> fpga_image_info to indicate the HW capability (support FPGA region
>>> update or nvmem update or both) of the download engine and the provided
>>> image type. Then the low-level driver knows how to download if it
>>> supports both image types.
>>>
>>> An char device could be added for each fpga manager dev, providing the
>>> user APIs for nvmem update. We may not use the char dev for FPGA region
>>> update cause it changes the system HW devices and needs device hotplug
>>> in FPGA region. We'd better leave it to FPGA region class, this is
>>> another topic.
>>>
>>> More discussion is appreciated.
>> I also think fpga_mgr could be extended.
>>
>> In this patchset,
>>
>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
>>
>> A second, similar set of write ops was added to fpga_manger_ops,
>>
>> new bit/flag was added to fpga_image_info
>>
>> The intent was for dfl to add their specific ops to cover what is done in
>> this patchset.
> I think we don't have to add 2 ops for reconfig & reimage in framework,
> the 2 processes are almost the same.
>
> Just add the _REIMAGE (or something else, NVMEM?) flag for
> fpga_image_info, and low level drivers handle it as they do for other
> flags.
>
> How do you think?

A single set is fine.

A difficult part of is the length of  time to do the write. The existing 
write should be improved to use a worker thread.

Tom

>
> Thanks,
> Yilun
>
>> Any other driver would do similar.
>>
>> Is this close to what you are thinking ?
>>
>> Tom
>>
>>> Thanks,
>>> Yilun
>>>

