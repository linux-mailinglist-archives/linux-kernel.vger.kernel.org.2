Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DFA410707
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbhIRO2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhIRO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:28:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60799C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:26:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y132so9511261wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AX0s/bkQXmMh8cMES5eXhcrKmGGepgxzOpmbwlBIgA4=;
        b=C2xK68kYNJDDuMiCcsKn/Vb+zBsh9yp04P+54jfH/N5Fm0zhX42062irQ1dwM2aUzL
         YAoKW+HSGMAz91T8UVxjR/fXPyIy/syZAiS+cKmyCZkH7s8M/T95L+J82FI8HeoOlLfy
         zAeVy1zKZJ2YQWEp6WvQrdF2hbxJYx0VPWl6S8aiH0Vd7/FK2Ckou2+lnYL26fxuVcuG
         vNeZonNNfFiFXyFXDjjYYOvRd5BvLjahIKOLpmUOQRjKEY//gp7LymJ0rbq0sfEOWXUm
         ag10q8OUm22IUtidmQ6y9wiGpEeKMNSDT625aXm+E/ruecmLFix1qoP1k1+j6HNwnZ6Y
         vyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AX0s/bkQXmMh8cMES5eXhcrKmGGepgxzOpmbwlBIgA4=;
        b=NwaXO3YQc95ex2uXrfMIlLDKwjMdWtNuppKP8vuvSH0h1qFV0OtTxtI7HOJNNQrkS9
         czzMQpjzjpZY7gq7WlAq91yFgjrUaaALIwyP8twRD1PmEu6AEYrAqMihx3Coyv7TRxux
         D1RIHjQwucYcfZI1qhDRCwmkSDyl7QeI3mwqX7JII8ZxI/n70Ug7Rl52t+BuTtsDcQQ9
         v3L75TM0Jfm994PSdE065x5IcakO9lhH1ISkmwD/eIf+qesEULrm3WbgyYvuVX5x96vC
         sigTCE/UAMQsHEuDxSJpXJNjjNr0505ehifHDeNgutshK/bVU00OGY4kwosvbL5aV/DM
         pKxQ==
X-Gm-Message-State: AOAM530I7NeJs2xhwA3XSqeqtVsrSvWwx4ovdWUiMuj4QKR3bsQZbYUw
        Sy/IV9N2QfwcsfsyS3c3vMAsgfIDx5MT/Q==
X-Google-Smtp-Source: ABdhPJzevXkIzuS5HuddUwoN+Xew+xLXVnGz0ROBbFqbMZ5cCnx6B/nLkNcS3v/Tu5PA5WR5Wy/YpA==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr15288403wmj.184.1631975197034;
        Sat, 18 Sep 2021 07:26:37 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::cde? ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id u8sm14778348wmq.45.2021.09.18.07.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 07:26:36 -0700 (PDT)
Message-ID: <71fb25dd-b695-47ac-2bfc-7e7cb2baf6c5@gmail.com>
Date:   Sat, 18 Sep 2021 16:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] staging: r8188eu: do not write past the end of an array
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210918134024.23837-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210918134024.23837-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 15:40, Martin Kaiser wrote:
> Commit f7b687d6b67e ("staging: r8188eu: remove NumTotalRFPath from struct
> hal_data_8188e") removed a for loop around a block of code that is executed
> only once when i == 0. However, without the for loop, i will never be set
> to 0 before the code block is executed. i remains at 2, which is the final
> value after the previous loop. This results in a write past the end of the
> powerlevel and MCSBase arrays.
> 
> [   28.480809] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: rtl8188e_PHY_RF6052SetOFDMTxPower+0x124/0x128 [r8188eu]
> [   28.493752] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: rtl8188e_PHY_RF6052SetOFDMTxPower+0x124/0x128 [r8188eu] ]---
> 
> Fix this by replacing i with 0 in the code block that used to be the body of
> the loop. While at it, remove the powerlevel array that was just holding a
> temporary value.
> 

Oh, I missed that.
Many thanks for fixing this, Martin. Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
