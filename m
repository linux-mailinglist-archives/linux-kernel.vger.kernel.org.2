Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5E3586F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhDHOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232220AbhDHOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617891505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heAoMXR13ua17Y0mBk6t6RCTDm/2YpK2rKLhCgGdEp0=;
        b=dQWe5+xrQ2Gj6VnwW+PJDFzYyd1nk0F9AJn/Hj0U0a1qowRfeOLHieACjZsrPvn0jK9Lsc
        zZO+pplBzT8Q3xkuQ9FaOzuiHxdT/l5u3ZBafko8k4JAcVC19gljT6JO6PINKcWABIIUP3
        2X7fhTYkoPIB0aZD1L+gYnPcHe3DWHg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-0Iu4ryPfMRi5TTHFH66Jeg-1; Thu, 08 Apr 2021 10:18:24 -0400
X-MC-Unique: 0Iu4ryPfMRi5TTHFH66Jeg-1
Received: by mail-ej1-f70.google.com with SMTP id a11so683176ejg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=heAoMXR13ua17Y0mBk6t6RCTDm/2YpK2rKLhCgGdEp0=;
        b=Osf3o03zvLu5ZJVRluc3OpY68UFLcVmPLn1az0kIYke4AQ9t3MQnDpvMP/odNlAzvY
         i3u9KQfMxfe/8wo/foBWL7maGJmbYmCpyI9yRn4+zrLkR8g9JUjulgnZa2x7vSXYqVOp
         Q6RGO6rq1rYwjzK9Tnun3oJwDE44dxTewDvPxLHYS6YUN65Hio1kMdl16GRKRmjGa2dR
         q7WpmQzKkCd98g9JdrICrVOasPU5ITQ+mtVxmXW4sEk9U4LtavLcD3tHe9SWi65SphG/
         lUQTFBP2k/SsHxliCoBX26TmxFbtvzcu0WI7XngC12aiHeRs/M1hD3D935DijrQccos1
         GOZA==
X-Gm-Message-State: AOAM533FizFgunktFV5BCKvFczwBij8EnZWi9XRifz7LBN4EdBTL2XH9
        9TLuP3PMAfcfCYfwTZrg+hdoLwivyAr0JMLcm0l7q6+TwUJR8GDeMkIgx+BFgeVMGOYZLoSpof9
        QOOlFTg6lIAegocHlFAq0mDS9
X-Received: by 2002:a05:6402:138f:: with SMTP id b15mr11776747edv.121.1617891502805;
        Thu, 08 Apr 2021 07:18:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4EfxI4NdtRYH0iSGE+S/zrp2Jbq9CkjnDLXHxuU4gU0RGedNvtVEtWlXMpnCJvIKx5DOCOA==
X-Received: by 2002:a05:6402:138f:: with SMTP id b15mr11776728edv.121.1617891502647;
        Thu, 08 Apr 2021 07:18:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u13sm9057314ejr.100.2021.04.08.07.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 07:18:22 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <mark.gross@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210408221334.63262fbf@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <08996ca7-c927-8261-d71e-e509815b5442@redhat.com>
Date:   Thu, 8 Apr 2021 16:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408221334.63262fbf@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 4/8/21 2:13 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   11cccec79c60 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> 
> is missing a Signed-off-by from its committer.

Ugh, thanks for letting me know, this was supposed to come from a merge
from an immutable branch from the tip folks, but I did a rebase -i
to fixup a typo in a commit message and that seems to have flattened
the merge :|

I'll redo the last 3 commits in pdx/for-next to re-add the merge
and do a forced push.

Regards,

Hans

