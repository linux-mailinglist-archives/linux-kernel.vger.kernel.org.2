Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0430F0B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhBDK1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235369AbhBDK1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612434362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLWFqqioSQuJpJPY+zOLA8DJwaXfSTLmoy294A06xlY=;
        b=I+knhNCpg1pJ6nrpESPJQVhk4rR3nqO37gVwWr4akdBDOdyKdegejfXO/3S9f4HG9ZCkm0
        jKsNGUhEMvV5BJm0v4h75okg4T/BIU1AAWymA/3RM/XP3GE1eNRdMfBfXcDH38+3mEkK6F
        mhHhEqy+JOQ2ooPKvq52mzskNEOHaEk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-H4JgKV9zO0Km38firua44Q-1; Thu, 04 Feb 2021 05:25:58 -0500
X-MC-Unique: H4JgKV9zO0Km38firua44Q-1
Received: by mail-ej1-f70.google.com with SMTP id h4so2341099eja.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLWFqqioSQuJpJPY+zOLA8DJwaXfSTLmoy294A06xlY=;
        b=OHSWLFdTytbotuApPJK0nSMKb6UeUoOO3TF3tI+SbOO064QCVW5xlAeBCqWbehW5/v
         ufuYnA9qtlnyunvXvq0bWLsEK0qn6XpR7g4z1xRA6qHGyJVlqBI8TfjPjmVpH/zu8QJy
         WDiNv8V2VTz1gN8fblwEB4xybcE43OWc1ZLxEBMf0ELGGYJ15g0ftY+1tAv/uBtOAyEw
         IOXO875sLRduSF6JYloP4/JcW9d4W2sRbQ0R7lEQ05omJXH9o92OyGPF86szQj94N02z
         E2HP5tCkrWM2ryZ2dVK7dmdrUzs2ibPgEhZrP7gkBIHC97ays4pM/aXJLbZ843Q88P/q
         Vv+g==
X-Gm-Message-State: AOAM530fU41bxZmwogsPu0cQj8+YNM3h335VzIHje6uqmP28UB1NL167
        42Uu59Zg6CeotTJzBl3tyHxPKV9jZNZaUKzUQwtJ30FSa9DlTST0GdH88x7qDXboPsHuVhCfRnR
        izd7UQreOFlFiVTe//jatUjZa
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr7786798ejp.458.1612434357561;
        Thu, 04 Feb 2021 02:25:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfUEL2lUcZLgfZ9Y/2lbVtndPBhLJVsJgRX8pZK0yj1Upi/WWsjVlAqx7qWdxEnRbUuMGGGA==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr7786780ejp.458.1612434357413;
        Thu, 04 Feb 2021 02:25:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id y8sm2119405edd.97.2021.02.04.02.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:25:56 -0800 (PST)
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210120214957.140232-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
Date:   Thu, 4 Feb 2021 11:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 1/20/21 10:49 PM, Hans de Goede wrote:
> Hi All,
> 
> Here is v4 of my series to add support for Intel Bay Trail based devices
> which use a WM5102 codec for audio output/input.
> 
> This was developed and tested on a Lenovo Yoga Tablet 1051L.
> 
> The MFD and ASoC parts do not have any build-time dependencies
> on each other. But the follow-up jack-detect series does have
> patches depending on each-other and on this series. So IMHO it
> would be best if this entire series would be merged through the
> MFD tree to make merging the follow-up series easier.
> 
> Mark, if that is ok with you (and you are happy with the ASoC
> changes) can you please Ack this ?

I believe that this series and the follow-up:

"[PATCH v4 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support"

series are both ready for merging. All patches have Reviewed-by and/or
Acked-by tags now.

I guess it is too late for 5.12, but it would be nice to at least formulate
a plan for getting this merged after 5.12-rc1 is out. Given the
interdependencies I still believe that it is best to merge all the patches
through the mfd tree and then have Lee provide an immutable branch for the
other subsystems to merge.

Mark and extcon-maintainers (for the follow-up series) may we have your ack
for merging these through the MFD tree ?

Regards,

Hans

