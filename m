Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1695A437407
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhJVI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhJVI4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:56:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B82C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:54:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 5so1147865edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HrFPSVbaJCP8/VAvKJYHEZxALPWGOLisv+WT9WnEMzs=;
        b=CdOJsrCpWxgBJFhnkbEKydkOdlcMVmMZR2hgstaEGtJmlBe46Ty8tVVy0E8CqrdrCK
         JlgvD2RR93zRhol+NsTkOpdpX8CXDva+9RjV6C8CcBcok27KnLziOCISDzfjgJouyThw
         VGip+UFiHDGEBEB7SiJqfPm7A96YR9GFFSn2fhUqUcG0Oc0YHIZa12ClSpqLXAcxUjIW
         sml7wJfZXefx1aldFSbpFoJ9YeOx6ip6dIvWv9M2c9YZ8vQn21PehPiihhwYC+aOERcT
         1D2wrSjABkmIJznlfFErKXQ4qUrWbbR8qT0PvyCfeWlUmxFfgN6k4OiJnETUfp0ID1WY
         dLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrFPSVbaJCP8/VAvKJYHEZxALPWGOLisv+WT9WnEMzs=;
        b=22nkvaNvIxSM0WveUXiT4e4sxf76ou8UpapvmViGylfpdCqri0v67waLxfA1XQkmgw
         jD99s9Bd2lq/9zo00W5G/fPwc3gHvUPPyo7tMUjArUM0LCDamucUwVIaeL3Med63nI4r
         pMiCWEpLg/LR8/wX786DfZf8VH0idgyDWPOER/C8XNjQe4EkLMoZHjL3L9pN1zSrUnhH
         uIMo2dhd6c4E6xxPDiHmdz7ZHStPQJx79KEyZa6gGzTCvO8qbXpFmFSTsP9eTKjDd5+I
         Okb3XX98d/hDk8gyGkTF94fyjwbOaMHjVUy5087sdH6ze98XIukh1Ac+hWrg/tAN7O/F
         WNCA==
X-Gm-Message-State: AOAM533pmpswlWVZXTCn4qTFSNZ0zQO5zOEuoUqPuzSYQC6578y3NwbJ
        vpJDyfP8fxzi5KmDmxWboVY=
X-Google-Smtp-Source: ABdhPJwd3EAEeZYXCwIDn2/7h23nVuBVLhj8dulP37GOTibbGwUFEwDZusTLqbwrT6H/3/TwibRd9g==
X-Received: by 2002:a17:906:5a63:: with SMTP id my35mr2002043ejc.104.1634892868583;
        Fri, 22 Oct 2021 01:54:28 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.retail.telecomitalia.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id c19sm4466759ede.16.2021.10.22.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:54:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove unused semaphores
Date:   Fri, 22 Oct 2021 10:54:26 +0200
Message-ID: <1905861.9EeI4ENUQp@localhost.localdomain>
In-Reply-To: <20211022084727.28035-1-fmdefrancesco@gmail.com>
References: <20211022084727.28035-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 22, 2021 10:47:25 AM CEST Fabio M. De Francesco wrote:
> Remove two unused semaphores.
> 
> Fabio M. De Francesco (2):
>   staging: r8188eu: Remove initialized but unused semaphore
>   staging: r8188eu: Remove unused semaphore "io_retevt"
> 
>  drivers/staging/r8188eu/core/rtw_xmit.c      | 1 -
>  drivers/staging/r8188eu/include/osdep_intf.h | 1 -
>  drivers/staging/r8188eu/include/rtw_xmit.h   | 1 -
>  3 files changed, 3 deletions(-)
> 
> -- 
> 2.33.1

I'm sorry but I overlooked the name of the driver in this cover letter :(
Am I required to send a v2?

Fabio



