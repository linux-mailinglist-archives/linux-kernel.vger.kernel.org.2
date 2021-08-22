Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF03F406E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhHVQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHVQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:26:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED5C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:26:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o1so14280791lft.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eEylF64YOOVNfoffZ3hjmQbtnSTwkThkMzn2D+PAOPI=;
        b=nLFGt87n8+HppeUjS4jTpzr7IC4wOi66Q3mKgZw3kxMOdw6DhvL8TfuFE+E7cyXJj1
         Z8m25nI4mNlTN/n2NwFaptCSoGj6V4neUbdRuis0p080Rtyq2H4F0b0+PwWAVJDlTCia
         TXg7MjO7dLNp9K6CKo52skliU1GM0IsDiimdELGUSJrKXalDgzKArY55kXhMjSvHlKaj
         hlDPjzv2Ozm66HB0GlbadGLwwIjv7tPmUCKjjB4TEA5SrVCje2lnLMpemHFBp37/x6b2
         pnZoZGFcG0IjY/sQ9Vs9yIKAapmYe5oFpqWL1Y8UsHIsymMW3T6Tit+efyR8yfrpZig8
         RQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eEylF64YOOVNfoffZ3hjmQbtnSTwkThkMzn2D+PAOPI=;
        b=GMcgFZu/LyeugR1WfFRV6J0cj2ovha+qwQK1fLNqBmKpronmA75iGU8un9Du7XZwit
         GMhCnQ/7OVt+AjXo6B/+fPJ4ZzVhQhmuZdlv+0zBfdsu06x7ATD71U2h9yRABCSPiL5t
         V6yU3zRaFmrO4MAib1dgN+2Vd4BFiX8KCb/XyEBsQis3N9vC8rleUcXZNZ+qvsAsEW3Z
         qw9+fHfQuXy6qPykbT0xRHSE5Qw1jE6ia1OzhE6OmJUL2Ja8cxlPbSYflC1glt4lrYxf
         MEiSAiEA7adW63QmhaYX7L87igex7/Hps22MlF5RowFlAHDZ5+gsD0W6AJQvy2qsllzv
         I/VA==
X-Gm-Message-State: AOAM531qla33LXSD8qhbLmlJ2pO4dBiz2AHxhN++NH9QIdRSYgE9OJAV
        TAmRJXbH1VwjlWErU8BMUuQKzlmh5giZX0vH
X-Google-Smtp-Source: ABdhPJz4rl5KjpE2SIpnNQBBjngwjwTs5xOWz6OmTfTvx/V8anJps+gDTZvAV98S1arD9I2KSk/eNA==
X-Received: by 2002:a05:6512:ac4:: with SMTP id n4mr21915783lfu.475.1629649572874;
        Sun, 22 Aug 2021 09:26:12 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id u12sm1227539lfq.173.2021.08.22.09.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:26:12 -0700 (PDT)
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
To:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
 <cover.1629642658.git.paskripkin@gmail.com>
 <44fc34ec-6bbe-9cd0-0c51-78836bad7e0c@gmail.com>
 <d479bf75-f031-136c-3967-16127ed26868@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <9809a91e-c524-9c6b-67e3-8a9c9b91628e@gmail.com>
Date:   Sun, 22 Aug 2021 19:26:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d479bf75-f031-136c-3967-16127ed26868@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 7:05 PM, Michael Straube wrote:

> Hi Pavel,
> 
> My one is a TP-LINK WN725N (not sure, but I guess v2).

Wow! I found this one in my city, thank you!

> You could also have a look at the device table in os_dep/usb_intf.c
> 

Yep, but I wanted to hear from driver reviewers/maintainers about what 
they use to test. I guess, some devices could be broken or not unwieldy 
to use. Thank you for recommendation, will buy one in few days :)



With regards,
Pavel Skripkin
