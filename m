Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91413EA779
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbhHLPY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238119AbhHLPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628781836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ICQtW9GMphiP22attaVtlBOOoe4Tvs14BWMJu6ZDb8=;
        b=Sn34wcunXuY7XcrhGr1tCDHfMGEKAnTRYvCIOcVLjKG0oftZijrTHn1JuFJsGi8WrhQqKW
        WveJgEpy0R/NvMtdHf5XfAKCI1CvQYAHTCUEMlwcu/Xp6Hslcz5okCbovaMnzN6EVAH37X
        67w0FWuF7AGc/LbxDkhswNro4f5UMGI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476--3Ql_obTNO6mMhUlGNf5vw-1; Thu, 12 Aug 2021 11:23:55 -0400
X-MC-Unique: -3Ql_obTNO6mMhUlGNf5vw-1
Received: by mail-ej1-f70.google.com with SMTP id a19-20020a1709063e93b0290551ea218ea2so1957930ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ICQtW9GMphiP22attaVtlBOOoe4Tvs14BWMJu6ZDb8=;
        b=YUr/Qtj2HevvsvrHx0RfW9w/cIs8hHZQkla8FgxvCvanr2I10nIWx1zSIHcgMWP9/+
         PjNJRDo8ar6719IPuqfDKBVCXNDpNhgywzr0LbBG1zcvXpYK+1Ac+UzZvSTT6v3Pzc2X
         MS1vrLIlTznXMnL4K9Y72ZMi3MDGrIotOqMFPUeYiYKfhEOVqhwOgAsnhHcJCK/Zao9t
         DZE0KAnKDyq7r9PdYxGG68t21DPmquRaAQ22tTpY3ZRldhzmDnevWXVnargiXLCKa81V
         ebOg3vTKGc0cdgbt3hZSm9wZyk5ILAanHyVi/fQj8LNcXr7IGKNJEJ4XZggJV1/55zNS
         seqg==
X-Gm-Message-State: AOAM532Yt0T0bKI5GiN+Mxq79Y9eEBwD8kiKY13PJ3sEc7Ov83IB6fN0
        ZxlJRpiEwllmYAilFgAXu3fkiKQSjRq4tHNMgG1QXBndE/TILwo+wHrZKLui7pPSghDRMws4oYo
        6a14HbNPiwAR72nqiT7qZHoKn
X-Received: by 2002:a17:906:ad7:: with SMTP id z23mr4253650ejf.419.1628781833683;
        Thu, 12 Aug 2021 08:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCZzG8+PZlSp0svnbgjoO0/j1tKqTl+9B+Ed/fosms1HkelKfHOublb8HnWPPAKep5ULVz2g==
X-Received: by 2002:a17:906:ad7:: with SMTP id z23mr4253577ejf.419.1628781832888;
        Thu, 12 Aug 2021 08:23:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j27sm946533ejk.18.2021.08.12.08.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:23:52 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Support for ASUS egpu, dpgu disable, panel
 overdrive
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     mgross@linux.intel.com, pobrn@protonmail.com,
        corentin.chary@gmail.com
References: <20210807023656.25020-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55ff17e9-b881-0f73-d8d1-47cfab1fba2e@redhat.com>
Date:   Thu, 12 Aug 2021 17:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807023656.25020-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/7/21 4:36 AM, Luke D. Jones wrote:
> This patch series adds support for some functions that are found on newer
> ASUS gaming laptops:
> 
> - Panel overdrive: Some laptops can drive the LCD matrix slightly faster
>   to eliminate or reduce ghosting artifacts
> 
> - dGPU disable: ASUS added a function in ACPI to disable or enable the dGPU
>   which removes it from the PCI bus. Presumably this was to help prevent
>   Windows apps from using the dGPU when the user didn't want them to but
>   because of how it works it also means that when rebooted to Linux the dGPU
>   no-longer exits. This patch enables a user to echo 0/1 to a WMI path to
>   re-enable it (or disable, but the drivers *must* be unloaded first).
> 
> - eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and an optional
>   eGPU. This patch enables the user to echo 0/1 to a WMI path to enable or
>   disable the eGPU. In ACPI this also appears to remove the dGPU from the
>   PCI bus.
> 
> All of the above patches have been tested over the course of a few months.
> There is a small possibility of user error perhaps, where the user tries to
> enable or disable the dGPU/eGPU while drivers are loaded which would cause
> a system hang, but it is expected that almost all users would be using the
> `asusctl` daemon and dbus methods to manage the above which then eliminates
> these issues.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> 
> Luke D. Jones (3):
>   asus-wmi: Add panel overdrive functionality
>   asus-wmi: Add dgpu disable method
>   asus-wmi: Add egpu enable method
> 
>  drivers/platform/x86/asus-wmi.c            | 289 +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   7 +
>  2 files changed, 296 insertions(+)
> 
> --
> 2.31.1
> 

