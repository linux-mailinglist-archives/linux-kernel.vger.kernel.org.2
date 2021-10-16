Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE0430467
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbhJPTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhJPTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:02:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A15C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:59:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 5so21927716edw.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skfeQJo7hKVQdukfcLCg8zqWpJh75xXNSTOi+22jEa8=;
        b=UqxbM8jmPTqerLRDSuuNvVsIfPngxRBalWaCmshagQkDn0w/EM2IcmSvfsj8yPMb/w
         UrcP46Vr6ZhTIp5x6avRhgKoH/KhDpX4b8Re/HHju+Ql9Zo56DpmZLXampR6kskJr0gy
         ozqUbf5Tdy5edmKCpN70684Zjyk/lHRgSR7gnPMKK6oZQUOvQ/GetW1rC5SRC6h4iTF4
         51B9Uhl7maIfST6Bn4VcQM7RoWGNoxuxwOQfmXzqpwL61c/CfcSzbfL168/OO53VUxfi
         Pmhs3XEn/0AQltZ93DTIJ8OF3dcDwTmD/3mtMovUKT6Lq0NiSZraFkb0U+XcWrm3GWEA
         S32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skfeQJo7hKVQdukfcLCg8zqWpJh75xXNSTOi+22jEa8=;
        b=eIXc/IHfk+zjAq9t1e1OBzzgPCGzC0BhaZVG5RPHHreFKNz4lk+3vOj8tQ8IGWtoGA
         Pglpb2jZlT/xIkCKBz6/LBPF/b4gAimKVwK9M+S5nDXK4UpuC2adHweu2Lvt+Ohu5Kog
         kBdTblCd3IJAVYBDvwtQIkn/nOBsEzzQvm/i/tIIU7H9D6xRU8Dc0uVfFNAvwQhHWZOK
         4qIMQU5QL4wtnIoN3swv1qg7x2BXkPJFUZRESI0TtIsfnWAdaCITfu38jj/h34UsgCy1
         AHuo1+LRhHLe4a3gfIvXjy1FFgTxKgGgDAK1EHuiNsWEZ9HXjqY9vL3R8QGx/waV+T7N
         9yiA==
X-Gm-Message-State: AOAM5319JDgIRvP0MPfjAcLj5CandOwA3hOHmgWH1D4Iq+ynb6QnNXfx
        CGEk4U9RxJNel2LfJzK4nhs=
X-Google-Smtp-Source: ABdhPJyrK7CbW57goS6ePYN64wESYguN0CjsgPw8LH/mKt94yOBLJsuBh67IOZDAHMjqX4OTsPbTeg==
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr16085911ejc.24.1634410790068;
        Sat, 16 Oct 2021 11:59:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id lg3sm6510831ejb.78.2021.10.16.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 11:59:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 2/3] staging: r8188eu: daemonize is not defined
Date:   Sat, 16 Oct 2021 20:59:48 +0200
Message-ID: <4247755.Dd3urQpL4E@localhost.localdomain>
In-Reply-To: <20211016181343.3686-3-martin@kaiser.cx>
References: <20211016181343.3686-1-martin@kaiser.cx> <20211016181343.3686-3-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 16, 2021 8:13:42 PM CEST Martin Kaiser wrote:
> Remove dead code that depends on daemonize.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/osdep_service.h | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

Fabio




