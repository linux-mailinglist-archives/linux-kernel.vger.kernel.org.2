Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4032BD39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384009AbhCCPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356594AbhCCKrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614768381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cshNihsT70kA34dCPACF1CCG63bGyROQDb6b88wnZvg=;
        b=MELuA1cprrxAn3eq+7gEfzSYw6dDbsyndykP1VkNobMyNZB4JUFgmvPkzKPsikAP8DFl4F
        KmtfuFeg/cfwlwlCX/liY+QdSRCqnsTWJTO1EJe//7jW7V7QHv8cIF5JMapYpqrpL1i1cm
        rU76lRyoyyF71oJFuE18ycTj/9nKK54=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-4GCeuVmiMnyhTs96KZRdRg-1; Wed, 03 Mar 2021 04:45:41 -0500
X-MC-Unique: 4GCeuVmiMnyhTs96KZRdRg-1
Received: by mail-pl1-f199.google.com with SMTP id g7so6552399pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cshNihsT70kA34dCPACF1CCG63bGyROQDb6b88wnZvg=;
        b=n+u/Uj+8oZ1R9wAkvxgv7T05e8OVU3rLh0EuaA9oNhPiIx2Pb939+fFsNoH6/bcEev
         fqVowOTYf9iCQK+d0m594SGMGxiHHU3obtHl3H3Xcxm1PZbN2xaa+xWD7Q/T7jQXVVtW
         WA8brMANnDdZ9LnzBGldFXAyPHgKHQZvV+FdpmAVcAx6M8rDHwmKZxUnrd+fbdCeyZ5p
         v/HyXyQts5oxdiA838RG10K1kWI8HjGkZAZ79qXm9beklim72Civxh3Y0TME5Y2YeWJs
         wt6kRfFi3kxzIcUcqYpVxlTy2qcKCIlTIgjzeD4fZ1WmPLBTYYc/L9Nzz1rf7JefJ+Gi
         qSFA==
X-Gm-Message-State: AOAM530BPcpAZZktj2UG75F/L/RPb+TyNDm9a4/omhAhxwbbP5K1O0ri
        QW26off896UjI+Dj8g+W2x3v2JKu2CdKuqrQVmNsHFuoQlYYCPbGiBUwkAoRlhr0vwiZDbPDtwk
        LnYsq7IIqSmL/bGadrVUyDIbT
X-Received: by 2002:a17:902:968e:b029:e3:a9b8:60b4 with SMTP id n14-20020a170902968eb02900e3a9b860b4mr7325533plp.61.1614764740219;
        Wed, 03 Mar 2021 01:45:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhxw9k+pawLT6E5fKwXWvbGnWK52c80D5k5VW6r+WMv0sxJ0XABOxB+c5SZrcGoJ6gjtIdiA==
X-Received: by 2002:a17:902:968e:b029:e3:a9b8:60b4 with SMTP id n14-20020a170902968eb02900e3a9b860b4mr7325512plp.61.1614764739880;
        Wed, 03 Mar 2021 01:45:39 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x9sm6135360pjp.29.2021.03.03.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:45:39 -0800 (PST)
Date:   Wed, 3 Mar 2021 17:44:58 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc:     netdev@vger.kernel.org, kexec@lists.infradead.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Message-ID: <20210303094458.7yootsa5dvn5cnba@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <CAFTCetS=G_JV4Ax6=Ty20uifoL1jscrqPGhdh7d2k+t=0d+L8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFTCetS=G_JV4Ax6=Ty20uifoL1jscrqPGhdh7d2k+t=0d+L8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

Glad to meet you here:)

On Thu, Feb 25, 2021 at 03:41:55PM +0530, Bhupesh SHARMA wrote:
>Hello Coiby,
>
>On Mon, Feb 22, 2021 at 12:40 PM Coiby Xu <coxu@redhat.com> wrote:
>>
>> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
>> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
>> for 1GbE while "craskernel=auto" only reserved 160M. With the module
>> parameter "resource_profile=2", we can reduce the memory usage of i40iw
>> to ~300M which is still too much for kdump.
>>
>> Disabling the client registration would spare us the client interface
>> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
>> saved for kdump.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_client.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> index a2dba32383f6..aafc2587f389 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/list.h>
>>  #include <linux/errno.h>
>>  #include <linux/net/intel/i40e_client.h>
>> +#include <linux/crash_dump.h>
>>
>>  #include "i40e.h"
>>  #include "i40e_prototype.h"
>> @@ -741,6 +742,12 @@ int i40e_register_client(struct i40e_client *client)
>>  {
>>         int ret = 0;
>>
>> +       /* Don't open i40iw client for kdump because i40iw will consume huge
>> +        * amounts of memory.
>> +        */
>> +       if (is_kdump_kernel())
>> +               return ret;
>> +
>
>Since crashkernel size can be manually set on the command line by a
>user, and some users might be fine with a ~300M memory usage by i40iw
>client [with resource_profile=2"], in my view, disabling the client
>for all kdump cases seems too restrictive.
>
>We can probably check the crash kernel size allocated (
>$ cat /sys/kernel/kexec_crash_size) and then make a decision
>accordingly, so for example something like:
>
> +       if (is_kdump_kernel() && kexec_crash_size < 512M)
> +               return ret;
>
>What do you think?
>

Thanks for the suggestion! After having a discussion with the team, we
think it's better to not intervene i40iw in the kernel space. Actually 
when kexec-tools is building initramfs for kdump, i40iw is not included 
by default unless a user explicitly asks to include i40iw by changing 
/etc/kdump.conf, i.e., adding 'dracut_args --add-drivers "i40iw"'.


>Regards,
>Bhupesh
>
>>         if (!client) {
>>                 ret = -EIO;
>>                 goto out;
>> --
>> 2.30.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby

