Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569E356836
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350206AbhDGJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhDGJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:40:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9CC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:40:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so26547313ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CqgxxVtYZOz6q7IqCr4JDKdv/8b/r2zDQXQ3ftTZhUA=;
        b=xWrWn4mwneIHhQf2Ifutc2Xsc4uk0I6VszC2XxK2Ngvby0DMMA3QixrzmaNZO6DU/d
         JgpJXyb2Y/OUiA/qYFCPR3bsRczODmD4lVPARBq/wWpBX0ts7ReuwFl8wZCV+22+TTZ/
         RE26uL15CZqXiud28PNOlYbnzXblbR36DoXMqNh1Xdn/24JnHnLsM6ZzoIz6CvBxBeme
         OcGCikc/NLixVDQYy5K6J2akSmz9pIIHhsahQq6nFD5Leh5nISNPE+Li1Bf3YuGbLuWr
         lS+CZrQH76O+3l9SMwCnXTOFepE7Eb4Lhuzwe8wc3UwcFimQGBqkE8dlaL5uPD7HnCU7
         S51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CqgxxVtYZOz6q7IqCr4JDKdv/8b/r2zDQXQ3ftTZhUA=;
        b=PrkjyfxF7V6ZXJe+cxt+tiJABb12hPuqJxDaCnEnb+VZ6whLCJ0fZAJ0R24UFAmh3m
         wr/Mr/kTJkoQiCWiH2QSzemN1fYd8lOw5nr/is3b7KW+IfvpY3ujA+oFVpM/xE9HfanH
         mIBYl6hTSf90DHAALMZ+vUREOq06v0/S7eUARLURBZe5A7/urau9/B5ocST2KA8tumY5
         X8JZsvWaOKfa0dS4aUuORgcL4dS4q+FipJARxS5WoqEfZSm2FgrgCmin91mbJ4lHOU4k
         YHPGDQ6VWwhkuIyaYjxphg1prQz4TmX4PzAp2ZlzXN9XO/iAkIdYOp5efEzXHRot47rV
         /lTw==
X-Gm-Message-State: AOAM531hfDYZrlh6Cqh4lNesnSvaRf6T8hPuPI3UobBaB10a8vmG/t34
        D0vURXKNKs3tu8Oies4t605fpQ==
X-Google-Smtp-Source: ABdhPJxzzRQl4cqIEqRKz8DTF0olVr/zvDcpf+Ih7ynA/VUFkrhZyBrVbM6cTGA3tSWXvWKhaigbug==
X-Received: by 2002:a17:906:8988:: with SMTP id gg8mr2627726ejc.264.1617788436230;
        Wed, 07 Apr 2021 02:40:36 -0700 (PDT)
Received: from dell ([91.110.221.225])
        by smtp.gmail.com with ESMTPSA id cf4sm15327239edb.19.2021.04.07.02.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:40:35 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:40:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: max8997: Replace 8998 with 8997
Message-ID: <20210407094034.GA2916463@dell>
References: <20210127073230.1583299-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127073230.1583299-1-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021, Timon Baetz wrote:

> The max8997 header is using "max8998" in some identifiers.
> Fix it by replacing 8998 with 8997 in enum and macro.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
> v2: Fix commit message.
> 
>  include/linux/mfd/max8997.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
