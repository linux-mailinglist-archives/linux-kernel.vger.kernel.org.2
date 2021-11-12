Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1820944E3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhKLJLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhKLJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:11:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1DC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:08:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c8so34645763ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxpzdVv/JmbTcRqxjO49mI7k8UhxXyTuZr7RPBnx9t4=;
        b=SiLag2S5hzRYUHlpMmIZI+lJ8BngrTqYEIs36n/kz4NyDtgpjfuWfrmObd8lW8Qe3E
         GXHcij6GdIH6ns99sc7mZ6jUW+WUnO/p5aa4lxNHb3qMuciScKoYClaz+u2nKsRGCy+P
         HDkfFTj/Vvam4Cu7Lm2hdY57bUjK8c8q3/ViobZJmx+ObsHjLRDNn1GVAonD24vChyxH
         tzZhPEraB8Eq7G+k/FWMhedclFO4vkkMmydUchPlxontQtpIdVSmpqB+3rJO6MXDpYR+
         I/vnw3Nk2wBKamRmQUoKExKkAutKbgmzYrALABLrPq8EMeVCvE09GnRQOGsL7bUOWSQB
         TXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxpzdVv/JmbTcRqxjO49mI7k8UhxXyTuZr7RPBnx9t4=;
        b=Fg2BJB+ZWCUd6M7HDZcNtEK28pGK7zqxHXODZkX0GMTDVxKkXtXv4wqwNvvBKZJQjf
         gmZy04n10quntfWXYEmOPiqk4QpesX5LZ3QMxHRmKYuxTdQlurc4dN/OwOin7w5yl57J
         fBMb6Olp+kmOPBDWgQkEHFYk2bhcumR6BbgKv90oXMHtq4pzmHrLZ/yWGW/weE6TUuDb
         W0klbOk2DedWafiDG4zBSZGjt6aeTgUNhTkfMGDGkh7Iu8EAIdQBNjaQWTm4NFljSzXR
         ca4ul04M/gvLsHkEak4njjuAxUV2xdogJDkh6nrIdHM1ZfI1UY/6IHfTDZt2fzCmDgjU
         S4Sw==
X-Gm-Message-State: AOAM531X1tIybWxcoxCqFjxhDR9JOXkhQq5t0EhPuem52LzrFeK4K2R9
        e/T3V1RaRS94fnwyikkSiUs=
X-Google-Smtp-Source: ABdhPJzZxaAwvcEKZjjYbHJsZBr63GhqyDPRvQ0Lj8zClCa2IJx8dpHdvwussAfZs5V2wE0f46oC4w==
X-Received: by 2002:a17:906:e115:: with SMTP id gj21mr17473492ejb.348.1636708100492;
        Fri, 12 Nov 2021 01:08:20 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id p3sm2386691ejy.94.2021.11.12.01.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:08:19 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 4/7] staging: r8188eu: remove autoload check
Date:   Fri, 12 Nov 2021 10:08:18 +0100
Message-ID: <136395394.ZtFrYW90el@localhost.localdomain>
In-Reply-To: <20211111212644.9011-4-martin@kaiser.cx>
References: <20211111212644.9011-1-martin@kaiser.cx> <20211111212644.9011-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 11, 2021 10:26:41 PM CET Martin Kaiser wrote:
> In Hal_InitPGData88E, the same code is run, regardless of
> bautoload_fail_flag.

Same comment I made for patch 1/7.

Greetings,

Fabio

> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)





