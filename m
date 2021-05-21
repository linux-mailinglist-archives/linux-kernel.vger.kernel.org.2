Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4338CB6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhEUQ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234370AbhEUQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621616290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VojTeZKFK9PJGOUd3X9HN/meFrWzT9f62q8BuQnov1w=;
        b=AgQaOxE2kvp5/DMA0YpN/3ghIYdxONnlQm91FXzXZI5BAWlZa7ywvk0tGidMqOs349en8x
        q+vbrZn4NQAyM9KqUUt/0hFA228hPY2gw5x4shN9OXI3Yamq5nfxB8hF/UGa4y8MgCCJpE
        4YWrhrRIqFlTc+Bcb4B1o3ZZ/1UVCHg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-Z27OxJMeN3ChfiVKPkrTkQ-1; Fri, 21 May 2021 12:58:08 -0400
X-MC-Unique: Z27OxJMeN3ChfiVKPkrTkQ-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so11663701edb.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VojTeZKFK9PJGOUd3X9HN/meFrWzT9f62q8BuQnov1w=;
        b=SEDpy4ztx5/5Yq3FaXjMpL6Wo2OZqYTx8THuiQGTQyVd8Ed5bmfFXvwP9PiOb4+7NS
         ZCyhh7OxtFwLIXGhIVt9R9fjcP4phEDQR4sTEvXzkW7jxkLOxlTNvWHCDec25x+iH0S9
         UlEzk6ToWy+6wvdAF5K0qWzkPR3PB2Hs0D7NTmMr0XU3fnUg4P+CkBdP+zGh/JycDok0
         /YDniswUL0GPDCatHv3bOtpu9AEBYwFmSP8ifLuW0qxzpufBJpJMplQk96B4x4wEbPHu
         A1U7hDMRiU3Lt68Q0svrEgH+PN3XDUPxF2bvbbFGwhJY8QO8h60CNYZlZT6eXDlObg2E
         63Qw==
X-Gm-Message-State: AOAM531qz3tFDr7g8SVFt3f5p4XhHs5HZEO8zkFrrFExYJYzmNhgveuv
        uLM3OwliZGLg5RYkfl6y1SaU5q8JGNTCudJDkLjb3Xqf96G12wn2/JfDMpnh43CWKLvISkXvO2s
        htZF4KX0IcarsYHBDqoExcbHcYe52QSQps59QdHFCsL6Gf1QlnQ4tVzWR16awO1nNnbMG0NlttA
        RL
X-Received: by 2002:a05:6402:17d9:: with SMTP id s25mr12139970edy.337.1621616287450;
        Fri, 21 May 2021 09:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy98pEvLlP1FzPi912wf+uy7l7QAd8jCgg1bs5C8GAUzcIzy3jEbDdR6gOp1ZH05CFh139jaA==
X-Received: by 2002:a05:6402:17d9:: with SMTP id s25mr12139954edy.337.1621616287262;
        Fri, 21 May 2021 09:58:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a21sm3947276ejy.85.2021.05.21.09.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 09:58:06 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove GA14/15 quirks to acpi/video_detect
To:     Luke Jones <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210419074915.393433-1-luke@ljones.dev>
 <3559f449-7d43-bf6f-0047-3138fd303db8@redhat.com>
 <HEDGTQ.IHJJLIVNVMJ21@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1e25d42c-005b-dcc5-a016-06f0d698de73@redhat.com>
Date:   Fri, 21 May 2021 18:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <HEDGTQ.IHJJLIVNVMJ21@ljones.dev>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/21/21 12:35 PM, Luke Jones wrote:
> Oh, thanks Hans. I wasn't sure how a git revert was meant to work and assumed that
> whatever git did was fine.
> 
> I am absolutely happy for you to take care of those issues and push ahead.

Ok, I've pushed these 2 patches to pdx86/for-next now.

Regards,

Hans


> On Fri, May 21 2021 at 12:24:13 +0200, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Luke, On 4/19/21 9:49 AM, Luke D. Jones wrote:
>>
>>     Revert two commits to allow a patch to acpi/video_detect to correctly set the backlight control as native. Luke D. Jones (2): Revert "platform/x86: asus-nb-wmi: Drop duplicate DMI quirk structures" Revert "platform/x86: asus-nb-wmi: add support for ASUS ROG Zephyrus G14 and G15" 
>>
>> Thank you, since the matching drivers/acpi/video_detect.c have been merged by Rafael, I've added these to my review-hans branch now. But there is one problem, these miss a: Signed-off-by: Luke D. Jones <luke@ljones.dev <mailto:luke@ljones.dev>> In their commit message, I assume this was an oversight, so I've added this. If you can let me know if this is ok, then I can push these to for-next. I've also rewritten the commit messages to explain why things are being reverted, see: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans <https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans> Regards, Hans 

