Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE71042332C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhJEWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJEWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:07:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A3C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:05:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o20so2339235wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J3pwtIuZMt/8laPuJvM7n0+/Xs/Aq45CaV9WvUH3m0E=;
        b=H0p9KosRJ8LhsjwSEl6kq+EIQM71TPk63cB8Vr1UqUXJZionuCyLiKBQRhXQD7cayl
         n8hHSvh/nqvczkh/NE5C4Tf+PHsTwNM7HZras4PIPWPgzWSw90pAg/nbkM/PQ8aozqdV
         q1L/+uoQXkBDZhK59F4AX3CXUCBbQz0MKq3C8D2OjX4jeBYTJU1YYIwSZdodBEIZ5LKT
         3IOKR4lxiYK3DIWaZ27uOPVJ8p2grHvnM0mhEGaapZgb+hcOREzWp6hUJDiGUFRjNi0x
         +8QobxznQTLyMFYO+UjDESFgfmf4TnzQK9YSKm07BwjFB7QGYnk74oNXHu0/qcbVxjro
         GvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J3pwtIuZMt/8laPuJvM7n0+/Xs/Aq45CaV9WvUH3m0E=;
        b=1UPreNo+YbY75GU0jsGaxp3z9J+8TD2RKYyH2tP5PBtNbY8/+ta37pBao+rv+MFbJN
         bC6BLhfMCynhKxpF6arZ/TCHtao5SP5TlYWdog7YS/QduN2Nfa5QrSnmR38dAYJN8Fln
         DEgWTpbbyaxB3ITQXGEpPptSMRmjgqubj3ORM1lQlzuXgKFFeRzZ8AOf66VDoAocWZ9s
         qAjq1ScoaEoJ0J7yuRNaFvzkPH9Nrwy5RZ3IHdHNkKyqYU4mXusHtTjR9ML9V15te/eL
         0Cv9ouwQ7Inq+NkgmLKzuWESTCIvqCf9RV+S+OBOUEu68AV26LV3876bEdwI35hHBo1C
         Nq/A==
X-Gm-Message-State: AOAM533rWNVET34z+XzVxuxD52WoDKg8azrYHRO4UUSTQaCDu+Moizct
        QrjuDLUeT0RjjX0uB3TXvmQqfuiV5N8=
X-Google-Smtp-Source: ABdhPJw6cL0j7HBC2hRGoJaHwcmpkhHMJnIDMhQ+YV0x4fAi7Ei+yOgvXfWwlYJ6YOwTu49KKARh3Q==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr6131325wmc.40.1633471550252;
        Tue, 05 Oct 2021 15:05:50 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id v191sm3311864wme.36.2021.10.05.15.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:05:49 -0700 (PDT)
Message-ID: <a9b2efd5-2e0c-1c8d-84a8-960c749a9bb7@gmail.com>
Date:   Wed, 6 Oct 2021 00:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/9] staging: r8188eu: remove unused led component
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-2-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-2-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> bSWLedCtrl in struct LED_871x is not used. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/rtw_led.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
> index ebe6395642ae..c035fe267635 100644
> --- a/drivers/staging/r8188eu/include/rtw_led.h
> +++ b/drivers/staging/r8188eu/include/rtw_led.h
> @@ -107,8 +107,6 @@ struct LED_871x {
>   
>   	struct timer_list BlinkTimer; /*  Timer object for led blinking. */
>   
> -	u8 bSWLedCtrl;
> -
>   	/*  ALPHA, added by chiyoko, 20090106 */
>   	u8 bLedNoLinkBlinkInProgress;
>   	u8 bLedLinkBlinkInProgress;
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
