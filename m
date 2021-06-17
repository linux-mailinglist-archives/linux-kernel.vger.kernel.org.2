Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDB3AB48C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhFQNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231702AbhFQNXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623936071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwGEMKYQQJMv/CxGUZtjWsZj084biuCitqUYtWHA6Pc=;
        b=QGMtsbjA/TEXHqQk9jwNrFmDVdwRWzlb6C6kHhigBwUSKUEQfqhkTjQxqWBEpUxkpOHySY
        02xad4AL8Df7bayUp8x648v63KQD8J1T/vTNvG/gHEwDASc1h5J1NDyACgSx3HKiRw0TjR
        W/XRw0zx7bl4BQW9ok9Tj3Fc2DXYKv8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-xVEZo99PP7a2Y134OF_wdg-1; Thu, 17 Jun 2021 09:21:10 -0400
X-MC-Unique: xVEZo99PP7a2Y134OF_wdg-1
Received: by mail-ot1-f70.google.com with SMTP id f4-20020a0568302044b029044be209a5d7so657962otp.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hwGEMKYQQJMv/CxGUZtjWsZj084biuCitqUYtWHA6Pc=;
        b=atPwlELaQ67qkvo8lWg7rvCndwuj1PucSYcNiAsIxTGMzEeM9sgcoFUvlaIbBcf/rs
         G/t8f7j8lUWHmA68ocBSKlRrKGaKBmkkfckHiF7xKeNmzypWyc7GykJwGGiyk/+Cr4Fm
         voaW1YYgbMZbQpqtDvsPFnlzePHL8X/J6YlCdlseOBNASnRjJffdxdyKUPzsnYhDt4yV
         LqZcV9URbzqAsLn5BPrLMLm4ljEVzBZqj+XUkAvcpjHpyn0wdDiChCFqJ7zygrS1q26b
         /kJGR3e3+URZaSI9byb0BSZWaSZvjLtTC/aZia6if9WjB+5USwWv+5SC+FQ5OmbTJqhJ
         vvDA==
X-Gm-Message-State: AOAM530erWsf7NbIXvmlbNr2Q+cNUcwqwbSWNRIPNCW4AABBVW91HbFP
        qLrRxQCJZUg8b6T5sBO3ZnkHP/Zs3PII7EwzZxI4PoqJxI8YEJ5Irw61omPLFfsCImPl+S9mb02
        ow9trTLzCc4Gwy8OYdpqEr/nw
X-Received: by 2002:a05:6808:1486:: with SMTP id e6mr10274740oiw.9.1623936070108;
        Thu, 17 Jun 2021 06:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw931LqYJItw0hcQXVJGwWvQ9NYX/nBhC2hX9cM9jm2EmErBb/zfH6Daxmhleh0YKe15pmFdA==
X-Received: by 2002:a05:6808:1486:: with SMTP id e6mr10274728oiw.9.1623936069920;
        Thu, 17 Jun 2021 06:21:09 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e23sm1264022otk.67.2021.06.17.06.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:21:09 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
To:     "Wu, Hao" <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
 <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
 <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
 <DM6PR11MB3819259241791EB04A2CB9C8850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YMrS9OUSaCdtGwrE@epycbox.lan>
 <DM6PR11MB381924F43550A6699CB55213850E9@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9c527087-3646-2f22-1234-2b0247511cc9@redhat.com>
Date:   Thu, 17 Jun 2021 06:21:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB381924F43550A6699CB55213850E9@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/17/21 1:34 AM, Wu, Hao wrote:
>> On Wed, Jun 16, 2021 at 01:05:36AM +0000, Wu, Hao wrote:
>>>> On 6/15/21 1:08 AM, Wu, Hao wrote:
>>>>>> Subject: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
>>>>>>
>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>
>>>>>> Follow drivers/net/ethernet/ which has control configs
>>>>>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>>>>>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>>>>>> FPGA_BLA.
>>>>> Hi Tom,
>>>>>
>>>>> Thanks for this patch. : )
>>>>>
>>>>> DFL is not a vendor, but something can be shared/reused. It's possible that
>>>>> other vendors reuse the same concepts and the drivers of DFL. If vendor
>>>>> drivers need to be moved inside sub folders, then maybe it's better to
>>>>> leave DFL in the parent folder?
>>>> xrt is also not a vendor, more a subdevice framework like dfl.
>>>>
>>>> I am not sure what you mean by other dfl vendors can you give an example ?
>>> It's fine, but the description here is a little confusing on vendor/framework
>>> handling. No other vendor so far, but it's possible, DFL can be used in
>>> non-intel device, and related drivers can be reused as well. Then a fpga
>>> mgr driver depends on DFL, should be put inside dfl folder or new
>>> vendor's subfolder?
>>>
>>> Hao
>>>
>> I'm somewhat neutral on this. If someone non-intel starts using DFL we could
>> also
>> move the common parts back ...
> That's fine.
>
>> That being said, I'm not super convinced we have to move stuff in the
>> first place.
> I remember that the first submission of our code is having everything inside a sub
> folder, but was suggested that to have everything moved out, this is why we have
> dfl files here now. To be honest, I have the similar feeling as you, I didn't see any
> strong reason to make this something we must do, but both solutions should be
> fine. : )

xrt is bringing in the subdir xrt/

Even after the likely move of xrt subdevices to other subsystems, there 
will be about as many files in fpga/xrt/ as in fpga/

If both of you are fine with a mixed files and subdir organization, then 
I'll drop this patchset.

If you want only files, then xrt needs to refactor, so let them know.

Tom

> Thanks
> Hao
>
>> - Moritz

