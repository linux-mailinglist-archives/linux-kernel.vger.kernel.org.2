Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF833EDD51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhHPStZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHPStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:49:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28301C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:48:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qk33so33496301ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8PFRwZuGgLnjGYqNPj65Tp5wh86w1dIRSgEKxDTD6rM=;
        b=LjTNGM9ChdUAVR1dOVsde14mlfdDOP4zzcWKthEmGUHA0z9XLCxj8g7cacWm/AFaGs
         tB3dcRmS6m2pUB/RuNrGvCCCCvbXbkSNUhBUHQoWUcYm0441Nsc7caomMliAWPhFJHjS
         QSGQrhqgKCZbGaK2ff6Qv+v+OhynZTwoA3tcTB4JvgrbUpx6lVzFyEbVNsmHF/A0q0W0
         GanEE/FJADi1tvMSi9KYzGQ0F/n/adLaLXo0F436kTcodRfTz9yB6XgId2/xf/QyFj2S
         y56kjWEe3KA2jwy0+kETBsHIuF4djEn67FelGU7uFavhj+vmwVbSz3vDn1vvIhqM+iQM
         PiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8PFRwZuGgLnjGYqNPj65Tp5wh86w1dIRSgEKxDTD6rM=;
        b=CkEQxrK6ouDDKSt5BRg3DfDVRpn2oqSSn0pm0HXvPn7RQ65K5GcEksDCGWRCPzwmyV
         U5NWB8wbs9Ri1k5MVBVOeWB6noKRac6VbRKzWElnkrmcMcKYlq0f+hQaOBnz2bDbWrZs
         HlHdB0zhFBCcv3uaVuS/uZib3UqU1ZsZObV2KEAoOLNhVR1LKtagmLm6j9chWgy0OV34
         sbREFfMmleUonA6i0D2QrmwxONL6ZLluvycScyrdd7O7Vfd5YD7JEpdibg0mkSD4JxZ7
         prOLPjjETD19cszKfPvmI4iCza+FgfyZ8iYRreOTyCF/ES3K/ir9e58GQXr+teoF5cHT
         s71Q==
X-Gm-Message-State: AOAM533n4F9vkE58e40ZgpawGIN9XkzuPpTPMjWGBSmBRWIwMSpr2gr8
        D4VkCCxH8LdoA39e6KRDADk=
X-Google-Smtp-Source: ABdhPJxgiGuvKpHKOc0fqqXI5GqMua4XTW7NclGOMr6etNYmeXmjNTF3z8tNfgkvHhC4pTLxbQ4lgg==
X-Received: by 2002:a17:906:3b89:: with SMTP id u9mr17353880ejf.299.1629139730740;
        Mon, 16 Aug 2021 11:48:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id dg24sm1529edb.6.2021.08.16.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:48:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Date:   Mon, 16 Aug 2021 20:48:48 +0200
Message-ID: <22319634.U67b3Ei0OZ@localhost.localdomain>
In-Reply-To: <cover.1629135143.git.aakashhemadri123@gmail.com>
References: <cover.1629135143.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 7:35:05 PM CEST Aakash Hemadri wrote:
> This patchset fixes the below sparse warnings
> 
> rtw_security.c:72:50: warning: incorrect type in assignment (different base 
types)
> rtw_security.c:72:50:    expected restricted __le32 [usertype]
> rtw_security.c:72:50:    got unsigned int
>
> [...]
> 
> This can be applied cleanly on next-20210816, and is compile tested.

This warnings have been fixed time ago against staging-testing:
please see commit aef1c966a364.

Thanks,

Fabio

> Please ignore the duplicate of this patchset, I did not CC staging.
> Message ID: <cover.1629134725.git.aakashhemadri123@gmail.com>
> 
> Aakash Hemadri (2):
>   staging: rtl8732bs: incorrect type in assignment
>   staging: rtl8723bs: cast to restricted __le32
> 
>  drivers/staging/rtl8723bs/core/rtw_security.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)



