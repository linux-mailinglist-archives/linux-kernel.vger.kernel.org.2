Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C13C17A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGHRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhGHRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625763539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+MxxEIgHppIPoGs9NgPZPuRjgmYFQ760KzTDD/t7B8=;
        b=H9c330k3s25Z7kvkq/Fy7Ts6v66/MPCme0rzdGFTJuaaCiXPoT5zp7PbEv85rQQuHJNfVB
        ME6HGZDnwWBnfg+NvULf/aWxw8tBus41rv40cQQj1Lu6zyBaw+kxNInIhs50ex4kxSBCye
        H4u9gwBmh93MFGxPtWcBNT+0yDewOdQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-D6PqexPUMXCerUu7D8hshw-1; Thu, 08 Jul 2021 12:58:56 -0400
X-MC-Unique: D6PqexPUMXCerUu7D8hshw-1
Received: by mail-ej1-f71.google.com with SMTP id jx16-20020a1709077610b02904e0a2912b46so2116956ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+MxxEIgHppIPoGs9NgPZPuRjgmYFQ760KzTDD/t7B8=;
        b=KGRqRPcOJUTbfq0vSwzFzr3nFtLXNfaZABue8Ijc7MLUXqIJlnGSWGhWfoUU8150rx
         SiCtmFbVMlQqyf69CiPGGFEb2ML+uybkCooN/xtUejTJU59FJkqWZinOf9sT6coHT9iI
         gqSmn8pk4Vb2C8l0+1Fx1oM46z2DL7FLbFWkKwIqp8qKB8A2eKkplVrHo+Wp9DIpzpbY
         fnJKH7zDjgHf93xTnhhoLd3iSliA2cPcn4AQUpU4x907WX3OcDzyM1ZfwS1w8ZTv2G+s
         aQ4dXWMVxTh4nVDt8DTpm/RL6SCBvoNMcHPXSTmsi/5KcIrBT0lWv19AaH4oGZXviT67
         eXZw==
X-Gm-Message-State: AOAM5305ebKqrdJc0smZhOREh8qgPBKpIkqMS0PURx03bmxYJ7O2Jq9w
        rrOU0OK6gKNvomtIOzO4b9TU+WrYuL1hWGuLnF1zVxhO/f636n2/0GJSFKy0IqlDECgNz0bkNm+
        xSQvSFsSBKAQGeAcrCPT1q8isgMF7h2TPIx7rbj8bUtRGKRYzjsjVL5Gfugg2DqSeTSDsmG5zAZ
        jp
X-Received: by 2002:a05:6402:1057:: with SMTP id e23mr40673382edu.352.1625763535404;
        Thu, 08 Jul 2021 09:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwskCkYwrqK5gDNs5Pk01sWgeZ01rPE8fbcAvoaGolRa9Pk5OAwoAWpbIh28BrbHtDOfUOY/w==
X-Received: by 2002:a05:6402:1057:: with SMTP id e23mr40673368edu.352.1625763535253;
        Thu, 08 Jul 2021 09:58:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u26sm1170302ejx.8.2021.07.08.09.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:58:54 -0700 (PDT)
Subject: Re: [PATCH next] kvm: debugfs: fix memory leak in
 kvm_create_vm_debugfs
To:     Jing Zhang <jingzhangos@google.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     KVM <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20210701195500.27097-1-paskripkin@gmail.com>
 <CAAdAUtiAA+H178X7pU1KLzKwmPZ1jTOUpmsP0TvFzqVH5gJAdg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b028e3d-d363-05cd-3dc3-8ccc5704ae1c@redhat.com>
Date:   Thu, 8 Jul 2021 18:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAdAUtiAA+H178X7pU1KLzKwmPZ1jTOUpmsP0TvFzqVH5gJAdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/21 23:24, Jing Zhang wrote:
> In commit bc9e9e672df9 ("KVM: debugfs: Reuse binary stats descriptors")
> loop for filling debugfs_stat_data was copy-pasted 2 times, but
> in the second loop pointers are saved over pointers allocated
> in the first loop. It causes memory leak. Fix it.
> 
> Fixes: bc9e9e672df9 ("KVM: debugfs: Reuse binary stats descriptors")
> Signed-off-by: Pavel Skripkin<paskripkin@gmail.com>
> ---

Queued, thanks.

Paolo

