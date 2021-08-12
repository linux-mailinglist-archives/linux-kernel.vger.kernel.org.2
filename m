Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F283E9C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhHLB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhHLB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:56:11 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3099C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:55:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t128so7779711oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l1TFGpQKbo9d6Zg3cXMrMAMjVR7np9Pm2fOo9b5VLkE=;
        b=FLcKFZSCTWqYSbPbU/CKgWD2Iv58Le4xX78cuzcpPOgp/+At7ln28aVCXzNrM9hKwh
         paI8zIz+aI0/BlEEVIyyi79iMlNN7cuPizSjGRneR2ztkS7gQ3lZT8FKQ1bAMVkNiQip
         j4RGiz3AZYo0+6VHo6DGIvsQQ/MDn4hxIgALob91fnNBswQ1Ssnfv+UDzWj+CJLS00LU
         7bI8LbpCyF13dA9s7gulor9PWP+Ks5i24qfWhNTZVp8bA1OGe6iido0zA8oap0nUG2xu
         aj4HVoKhH6FHFlLI/rVXSu9wu2guBPx52A9UfP8fDSF2T1eCZfbFsCU2fCOfESxkO3/L
         SqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l1TFGpQKbo9d6Zg3cXMrMAMjVR7np9Pm2fOo9b5VLkE=;
        b=SWOmkux9TK+JkKx1uh0XwnORiEpXwYcBGqFuSaCyRiADmNpkeZ6dXW+ewlKYnAxSzA
         um/1AXhiI1SwmqWEBA1RVZiToWfnDQxsoAaOFWoaRXs6OmegbeiigB/k0UlZzfx3AJNG
         Nv4NI4T2Q4BnNd167vVc8N/3jFdgsKOd5EIIshsDYm5IKnqjpOwh+3ZgmYD8pimanqAg
         bR+ym+CK9aWUvl77ArCFciKdHOyy1ND/CNtmvsGT6Sm6Dd2tWan1ub90DVecNEk8IrGN
         /r7PFeV2YB4427i6sx3Ep/d1f8HB9z0MTF9ZLEHjTOw5xxW0r+LE+CsdAgac3hEMN8TI
         Dfpw==
X-Gm-Message-State: AOAM531OyD5Ww8+ngrjlcmg3uxSXrZe//ZzKfV1xARGNOOH1uHfWX6vY
        JGBu5JQG1dCMlTnWuAoYuKCKzJdvUsc=
X-Google-Smtp-Source: ABdhPJy/KphdFc7XiR5guU8xcr1mCJHnEIKZz2vIN+OWYvuZbrNxzTlJfFFKoUGN0w4ILu0ZnEWIGw==
X-Received: by 2002:a05:6808:3db:: with SMTP id o27mr1490366oie.114.1628733346063;
        Wed, 11 Aug 2021 18:55:46 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id s10sm232546oog.14.2021.08.11.18.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 18:55:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH 0/3] staging: r8188eu: Clean up some smatch warnings and
 errors
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210811215806.20426-1-Larry.Finger@lwfinger.net>
 <CAA=Fs0=WeawmsS=Y+iEL7AMvkhyN3wuXRaxD2eC271zvdeBwUg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <21ed5860-1449-bdba-b1d4-daf5673302f2@lwfinger.net>
Date:   Wed, 11 Aug 2021 20:55:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAA=Fs0=WeawmsS=Y+iEL7AMvkhyN3wuXRaxD2eC271zvdeBwUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 7:00 PM, Phillip Potter wrote:
> Dear Larry,
> 
> Sorry, but the third patch doesn't apply to my copy of the staging
> tree with staging-testing tip as of now. Thanks.
> 
> Regards,
> Phil

Thanks for the notification. There was a conflict that arose between the time I 
created the patch, and when it was received. I just submitted v2.

Larry
