Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A336889C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhDVVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237012AbhDVVbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619127057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGXUjW0OOazPOpzZD1uN6g662t8VP358/xyYRhHZVKU=;
        b=A2wPPWE+mdyJCvv4lAAO0xO627Lv7qZuFroIEDmzTk6vd+kJGXFzc/Y0I/1/jFbXlG+gE2
        8OGS2P7s9VogrZKAx7L4Mc3vnTknvLdsBNgOU4nbIVeeAnDqvRN4VJmtO+1dLLXPAQHf3B
        rkchn/FzEFL8o9hn6JODUUJLJ8WWna8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-7Nf1smN9OpmMkDRV3jdueA-1; Thu, 22 Apr 2021 17:30:55 -0400
X-MC-Unique: 7Nf1smN9OpmMkDRV3jdueA-1
Received: by mail-qv1-f70.google.com with SMTP id el4-20020ad459c40000b029019a47ec7a9dso13095921qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 14:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nGXUjW0OOazPOpzZD1uN6g662t8VP358/xyYRhHZVKU=;
        b=m12S+afp3mIcThPVHeocWKrPtEw/q+HB2N5HCc0U6AJ26JVgEPZ97RwkYoA+gJ5nLj
         zJlO2uKd6rnTrBtay85xp9gZ8NCymKIaGk3ZYJ1PcYv0UtfGwPNNqT5icRMi9I+mz8jp
         ovXs2FgHFidXP8zc+qwzZifYwIkBJI35Jic3quFVmSGfu1O/SYl0ud4zJeqzbCoGc7W8
         nAMbeuoxdvmh1uzrlNGkkcGZk9KOZtBHbSGvYbcODMebNYuKnge4H2iVkGt/7g5CGFiO
         JUg77adOZsRoleIF89OXmywtM47XwX2f1W7xXIOPeEbE16aoCczz5GwkBCUXYtX/ssUG
         sNCg==
X-Gm-Message-State: AOAM531HTN6CtIMjyKqTkuVsMq8OwGi0kTVVEdIbO/E5/XfEm41E3SKH
        ZXPHyobUPQWY8Ctg9B8CPBSLp1QJg4LzGnLnVq7xaUa1zDB+fYzkL5zzI6E6sYTaBi0sikndGWZ
        3tKiIPR6oRGf4FRAP7rJ8wHat
X-Received: by 2002:a05:622a:54a:: with SMTP id m10mr565327qtx.298.1619127055272;
        Thu, 22 Apr 2021 14:30:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGddjOvp+BMhmYr1Yf2ygOT9gDyiMyYmcUgID64jNhky8K5BaSrCaFhLaflCC9Tjriw52stA==
X-Received: by 2002:a05:622a:54a:: with SMTP id m10mr565301qtx.298.1619127055097;
        Thu, 22 Apr 2021 14:30:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:70c0::42e6])
        by smtp.gmail.com with ESMTPSA id 132sm3061295qkn.52.2021.04.22.14.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 14:30:54 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] bits: Add tests of GENMASK
From:   Nico Pache <npache@redhat.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        akpm@linux-foundation.org
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
References: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
 <20200621054210.14804-1-rikard.falkeborn@gmail.com>
 <20200621054210.14804-2-rikard.falkeborn@gmail.com>
 <935a7b98-ab4c-15af-3bf0-aa7c1f9de068@redhat.com>
Message-ID: <6547e027-443f-3752-c14d-6f93d7df1e33@redhat.com>
Date:   Thu, 22 Apr 2021 17:30:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <935a7b98-ab4c-15af-3bf0-aa7c1f9de068@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was missing something... This was not my issue.

Sorry for the noise!

-- Nico

On 4/22/21 3:40 PM, Nico Pache wrote:
> Hey,
>
> Where is TEST_GENMASK_FAILURES being defined? This fails when compiling this
>
> test as a module.
>
> Am I missing something here?
>
> Cheers!
>
> -- Nico
>
> On 6/21/20 1:42 AM, Rikard Falkeborn wrote:
>> [Snip...] 
>> +#ifdef TEST_GENMASK_FAILURES
>> +	/* these should fail compilation */
>> +	GENMASK(0, 1);
>> +	GENMASK(0, 10);
>> +	GENMASK(9, 10);
>> +#endif
>> [Snap..] 
>

