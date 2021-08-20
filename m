Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F73F36A1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhHTWsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHTWr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:47:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BAC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:47:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f5so16194449wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nd2DplYlzS7tpLT2YnmXCm1lJ+3H40hwh1u9gxB43hE=;
        b=MVoVNxGBO2HhxMCZMQBtTKDl+8fqji/DgKSE6Lf3ld0I1RogciMZmkYFKrXKW8XiQU
         m0wg59mGHlnPVl/lIxUMsbAizNdsmZamVoOX8388O4KEpc92gfQCKGUwLvXLjY19BkW7
         A32p+A3PuVY33DIRX3jdICh0saAeC/i/GF2IPnhF4t+Lx5E5fpQbF4O4wQBWPqWcW8yS
         7OPFbeQoLJfc6jQWObCf0ZJJPy7gmNeDbNfuMXDuR0uHIVoHy6mdbXwzRCAIlIKS7m8D
         7wVIevf3Q55dtsxOkvpg46JN/wX7cGxaOlTA0N0VQnJgbHP92hoM/PiZuUg+AbTBK4fM
         KfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nd2DplYlzS7tpLT2YnmXCm1lJ+3H40hwh1u9gxB43hE=;
        b=MJlLUzh4PLQvkoQ8j5pgXz74Mr/0UckQBFeJQYQF88t1On93YG5nAOqf+wJFriB76N
         zIivELg+kCfsIPKOaqfPm4m6q2FVebEPXYDbljTGe/tE1Wfabi0nrEDegI58lQSSzVFG
         3ZFF0ha+i9FbxXEg88jSYZIljeYBRMPj0tfDa9+o+sK/gW0nYHTFcdTLLrfWc6R3z4qj
         W3eyUx6ojhLNfGlM5HiaMs2G2SQ4lZcrIKxjYpDjVkRmJLRLZosJnqmxvT64sjFy1h1h
         jdwhU7T9xeVciVuIlOfZiOs4jWt2jH0zU3gFTZqPOsOHsHPOm0WJgQr0tRpcku+SDBw1
         ZNNQ==
X-Gm-Message-State: AOAM533CyjBUjbEaxFl85h1JN4mYLtAshyUl1HQiMvLSCaSCoi/mJ7/W
        P3QIoCL5Xm2Yxx6PbRJ5gA5FNQ==
X-Google-Smtp-Source: ABdhPJzMMcPKJhezh9ZmdvzFupAeU9IfMrM8dO02glOm2bpB7YSxu8BX27fMA/dAQ+Y1YpkBnQ26EA==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr1022516wrn.365.1629499639180;
        Fri, 20 Aug 2021 15:47:19 -0700 (PDT)
Received: from ?IPv6:2001:8b0:dfde:e1a0::2? (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id v1sm7003487wrt.93.2021.08.20.15.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:47:18 -0700 (PDT)
Message-ID: <21bcab8649183ae2a36fb015fda32e79cba7ecad.camel@philpotter.co.uk>
Subject: Re: [PATCH 1/2] staging: r8188eu: remove unused function
 rtw_add_bcn_ie()
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Date:   Fri, 20 Aug 2021 23:47:17 +0100
In-Reply-To: <20210819112200.32030-1-straube.linux@gmail.com>
References: <20210819112200.32030-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-19 at 13:21 +0200, Michael Straube wrote:
> Function rtw_add_bcn_ie() is not used anywhere, remove it.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c    | 63 ----------------------
> --
>  drivers/staging/r8188eu/include/rtw_ap.h |  2 -
>  2 files changed, 65 deletions(-)

Dear Michael,

Looks good, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

