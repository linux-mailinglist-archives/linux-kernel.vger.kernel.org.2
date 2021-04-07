Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B02356F46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353100AbhDGOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244402AbhDGOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617807039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7Zj/q4NY57Kp0s5iCtVo4YzI3svMHdAEVBKj45mo0A=;
        b=aCaqHDgKg7++rogykJIU3ehtaRPtu67JNA0JR+iDTalIaJji2Eb62GhoHAmIoy0MDaIkJq
        faMMLeiaJsO5dfuAVK85dcs8uUu1JUrvsFP5j2A+6san/zyhQHuDkzPHzUPgZre9Ya8zI4
        7+jG67N6id8nmLGto8QVnlHM3gWoB+Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-hBUxlcYmNoisiDoYnVJ9dQ-1; Wed, 07 Apr 2021 10:50:37 -0400
X-MC-Unique: hBUxlcYmNoisiDoYnVJ9dQ-1
Received: by mail-ej1-f69.google.com with SMTP id o11so3320024ejx.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J7Zj/q4NY57Kp0s5iCtVo4YzI3svMHdAEVBKj45mo0A=;
        b=iS94qtmgIQPt/9oAezD0FyqNaBSX8kQX5XWswoGAdhQ0vEYvsyg7eeZRGrefc7QEUd
         vdCoi9oGZuvKXMOzglD5koQSyHF1asQkCdxSvn6ZMIGU9etqIbsZcngWv1vTJn85Yu0t
         CgEN1S2WLHBRAsmmbew30K5XiWSM3uj4HuIJ0Jq570oRMwsqxR2Xnb1/n0fONK+LRM5J
         h83sNm2AyFAvUzB8JgYH1pKpp9Vt+QGJZDw/XKNcPbuxNS1AJDFj+4DBKstWqi/qRBnz
         56InS1ms4LFKSuVwS6drRnfb3Ep0V1L1W+c+f5wg3A1AQV79GqwD3lE8mko71GyTJP68
         jqbQ==
X-Gm-Message-State: AOAM533Vr/XdsoYiKC11248OoMFpfe+jYBsIyd1K1U8kjFlWCct6vFbJ
        TFYYjDN14+4P3u14dI1Zqi1VWQB7AnCjHMZhd08kxzUk/414OvHgHsVUJj/jiJRYrR/rzcRwvwK
        0e7hQTojXzJziXGqHNdQ4fjVL
X-Received: by 2002:a17:906:552:: with SMTP id k18mr4017363eja.508.1617807036417;
        Wed, 07 Apr 2021 07:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR5/BTM3EP66yAOAAmCEbnre/FdjtHTJa0BeTiTT8eDyHwNkFaP2WwUy9wT7oQgCA+O1sgMQ==
X-Received: by 2002:a17:906:552:: with SMTP id k18mr4017353eja.508.1617807036285;
        Wed, 07 Apr 2021 07:50:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lt22sm9069321ejb.115.2021.04.07.07.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:50:35 -0700 (PDT)
Subject: Re: [PATCH 0/3] Adjust contacts for Dell drivers
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@outlook.com>
References: <20210401162206.26901-1-mario.limonciello@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4f0c222b-1d9f-20e3-9f92-97ef5072f720@redhat.com>
Date:   Wed, 7 Apr 2021 16:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401162206.26901-1-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/21 6:22 PM, Mario Limonciello wrote:
> The Dell drivers I'm involved with all have me as an author and/or
> maintainer.  In the future these will be maintained as a team effort.
> Adjust the contact addresses accordingly.
> 
> Mario Limonciello (3):
>   MAINTAINERS: Adjust Dell drivers to email alias
>   MAINTAINERS: Add missing section for alienware-wmi driver
>   platform/x86: Adjust Dell drivers to a personal email address

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
>  MAINTAINERS                                     | 17 +++++++++++------
>  drivers/platform/x86/dell/alienware-wmi.c       |  4 ++--
>  drivers/platform/x86/dell/dell-smbios-base.c    |  2 +-
>  drivers/platform/x86/dell/dell-wmi-descriptor.c |  2 +-
>  .../platform/x86/dell/dell-wmi-sysman/sysman.c  |  2 +-
>  5 files changed, 16 insertions(+), 11 deletions(-)
> 

