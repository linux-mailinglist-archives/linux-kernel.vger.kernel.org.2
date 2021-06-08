Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB539F059
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFHIEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhFHIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623139360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKpNGaQCUEHHfd7MT/ExHFw1fhpDia+6aX46sXXLlDs=;
        b=NqxtvT9QUpZHX+GFOpiG0JKTjQPiTHGPEQAgSDIrvkXSRnRzSWbR1DcxPv2WNbwQ5kXpKw
        ew/5BGlmqQOT5KZqVyBjn0lpLvXDlzZqMbS8GlOee8GpIxDivfsbBP4SrqgHB8gnI+yllR
        zkR6Rx+9tdRQ8cnwqkErhY5P853TmQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-nY4PaJUIOk-R_6l7KjHChA-1; Tue, 08 Jun 2021 04:02:37 -0400
X-MC-Unique: nY4PaJUIOk-R_6l7KjHChA-1
Received: by mail-wr1-f72.google.com with SMTP id e9-20020a5d6d090000b0290119e91be97dso828502wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 01:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nKpNGaQCUEHHfd7MT/ExHFw1fhpDia+6aX46sXXLlDs=;
        b=L+r22bHeykiz3che9y4VgBI7/Yy4Tr9N7Qq3yozfsKnElkMA9FXI1uIcUl2MgbQWVY
         mA8NrxUyYpNXIOHktG5spWSx1JmhT1fF74CK0UYFh4rOp2vWdZ389/WXFFApOCS9yHcX
         s9md8DmKewtCqEECK2T2vEPH8ZfxVECYgMM1fK7ecE77gkNQABf41CqWtnQyjToureol
         xuvosoQ7+PXo/tPCK5Cuz0KyDBY+D76zuP/2VL1JAFLOqx3DV+gLXHU2ueWjqUro1bzR
         1gX7Mam7s7C8TFRzGL2mQzFEfylt9eFd2j8yS/7fD11sZCI+e5UMc+3YsYIMR5VYn1ch
         ZCHA==
X-Gm-Message-State: AOAM530oa32+6KwQP8eRdcSDV5RmW2EORNoQuljemfc0CuZrum3sja5M
        8xhdtYN902wOCzkbEbIGAov3grQI5v9EM9x2McExVGrAiFDwFCi53cHZQsD/NAZtq9JwpJ24Euk
        UdsffxlD4tLZxGBwcQTaaTu8Eo5cKx92dups6nPOFPGLUG5WeCy3gWd4RLwjcKjfbRkitugwult
        w=
X-Received: by 2002:adf:ded0:: with SMTP id i16mr21414771wrn.30.1623139356121;
        Tue, 08 Jun 2021 01:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYrfpKlnATy0WFWItLlG9XWgy/bAHikZyJwX4kOJpLKQCbfPOgnNUWOVssDtv6XqK4j3LEnQ==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr21414737wrn.30.1623139355894;
        Tue, 08 Jun 2021 01:02:35 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h9sm2039560wmm.33.2021.06.08.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 01:02:35 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_PCI=3a_rockchip=3a_Avoid_accessing_PCIe?=
 =?UTF-8?B?IHJlZ2lzdGVycyB3aXRoIGNsb2NrcyBnYXRlZOOAkOivt+azqOaEj++8jOmCrg==?=
 =?UTF-8?Q?=e4=bb=b6=e7=94=b1linux-rockchip-bounces+shawn=2elin=3drock-chips?=
 =?UTF-8?B?LmNvbUBsaXN0cy5pbmZyYWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210607213328.1711570-1-javierm@redhat.com>
 <c3f49fe5-edbe-2889-bd59-92891adc807b@rock-chips.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <805741e9-b814-32a5-38ce-bc13df6efb0c@redhat.com>
Date:   Tue, 8 Jun 2021 10:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c3f49fe5-edbe-2889-bd59-92891adc807b@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 8:48 AM, Shawn Lin wrote:
> On 2021/6/8 5:33, Javier Martinez Canillas wrote:

[snip]

>>
>> So let's just move all the IRQ init before the pci_host_probe() call, that
>> will prevent issues like this and seems to be the correct thing to do too.
>>
> 
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
>

Thanks a lot for the ack!

Peter Robinson noticed a missing word in the changelog, I'll send a v2 now.
 Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

