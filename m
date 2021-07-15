Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C433C9AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhGOIzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbhGOIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626339159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjJcHjl6F1c9c06u+Cty1wPbq2wMQMTR8ijLpEU91MA=;
        b=Nq95QimBBNLhmhgDDgJyZYb/VOu6QB3pb9wlYfBmJ2kOiIfh+C1hVFhVq2iBmqp6SP+mJj
        M2ZKmI52vDxEAw57t4zcaHpaUv+1eY2QvBf66oZbFJqWln+/KsG/+Gf6KWpbjkABRKJcBj
        7sQ0n+736f4BWinxYfpOPQsT9kqLAGQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-C4hDjIvgO9-ZQXnPbsCa3w-1; Thu, 15 Jul 2021 04:52:36 -0400
X-MC-Unique: C4hDjIvgO9-ZQXnPbsCa3w-1
Received: by mail-wr1-f69.google.com with SMTP id h11-20020adffa8b0000b029013a357d7bdcso2981825wrr.18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kjJcHjl6F1c9c06u+Cty1wPbq2wMQMTR8ijLpEU91MA=;
        b=W+NmtgNb6Wd0Te1cMLnJ1v/jtvfMTPHvV/vuizUZ8euB6LkLPkuarLjPgJ7TDIOuqL
         jCmI4LekdNt7OpN9vJ3dMs09F4NWWxvE4TyBRCOwPSI4LtzMJUH37/872XjXgV5OyStq
         LUTpewJsPY+AwhqN8MocAm/AjfQnrTSPZAvWpV/zun473o2dVvNAlgfgSW6rpZt0qWWo
         ELcRav/J/CcRpPK2Kr3z+dCrE8SaZgqgcCkJQ7Ftc7Tb/b8sAENfs6veJ0bN4odd9ghS
         eODPhqi4J/XMQINK2TVweeXvK0FcRyDvEIx4L2fu5uq8gBrNxBhFxpVXQUXHDzWA8THv
         i33w==
X-Gm-Message-State: AOAM5321FwkZxGb8rtwb5cgVWZEKaZY5VcLuBq2FAdU/LfDIb3d4tNXj
        yM/TxoxPp8HNTMy/+g1B5R6pC3Hov9BCSVgcOwnrrTAby5GF8jkU5QBtP3RtVPjC+XC2bcGdANu
        o9QEo7WjhA0gImy1VCI51qzAD
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr1532695wmo.28.1626339154916;
        Thu, 15 Jul 2021 01:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG04gNyhAovDkzb27Ic90ObKsP032kjSM4Ta6rsdLHYz3DjpiTPfAKMPYYw2KwDBRjER7OUQ==
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr1532680wmo.28.1626339154774;
        Thu, 15 Jul 2021 01:52:34 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id d14sm5579705wrs.49.2021.07.15.01.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:52:34 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] KVM: s390: Topology expose TOPOLOGY facility
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
References: <1626276343-22805-1-git-send-email-pmorel@linux.ibm.com>
 <1626276343-22805-3-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3a7836ad-f748-296e-cd1a-a10cbc570474@redhat.com>
Date:   Thu, 15 Jul 2021 10:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626276343-22805-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.21 17:25, Pierre Morel wrote:
> We add the KVM extension KVM_CAP_S390_CPU_TOPOLOGY, this will
> allow the userland hypervisor to handle the interception of the
> PTF (Perform topology Function) instruction.

Ehm, no you don't add any new capability. Or my eyes are too tired to 
spot it :)

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/tools/gen_facilities.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 606324e56e4e..2c260eb22bae 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -112,6 +112,7 @@ static struct facility_def facility_defs[] = {
>   
>   		.name = "FACILITIES_KVM_CPUMODEL",
>   		.bits = (int[]){
> +			11, /* configuration topology facility */
>   			12, /* AP Query Configuration Information */
>   			15, /* AP Facilities Test */
>   			156, /* etoken facility */
> 


-- 
Thanks,

David / dhildenb

