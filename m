Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6830F649
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhBDP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbhBDP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:27:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409AEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:26:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y187so3334660wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6rHTIXNhBUEIcxhLkeKp0zwA6qrd3f0bS7vW658gGlk=;
        b=mPI4dGRxfPDVhVPFx05uX/HD/WJydMFT3pfqXg3kLDpNccdg/QW6OJO1y5hJUoM9/c
         XMnXmjhVa52zZAon5WLaYoXBgqa4VpslK0RdjfxdnFdi4Ly6wm+zpI/zt4b+vK7zfu+V
         BiPz0qLmh7ZdpMHfELspVVYam6DtPYXdx2zsGtaOx6ywrhxQjgRqMPHqSr9xPKfspet/
         vpFCf/XQ+OTmr6M6ilboRKEu9gXnjqzBt6FcL0B5myB9pczkQv4zTMmAM/q048OXwucR
         SLN12sti4+nZ8oQSUk1g480oyhvfafCHgpq0vf+iS7anTOBQ2qpbmJszkaXbnBHNVdw/
         5YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6rHTIXNhBUEIcxhLkeKp0zwA6qrd3f0bS7vW658gGlk=;
        b=UsYCwGXq4B2EyW86jBpMNh3RdamTahaMXTQlpPI7HlRrPfHg4B3xfobObOXCUmpL3S
         1gjYM5xAkAKYR9FUb8YC5DMkAGEJ1qonQabGpuye/JDgYbgf8uu1GTKMFam45F3AwGcO
         ZijwBH720m/dRliQvpGAZQeY/MDuyQZV/a50dXlGC0G+AyxeIoLcC1iuQ6pvLVjyil96
         if5Xtd22oD0BA3EvI6v7OF1wLVS9JCCnmdj4Imtchg9I71cLSzfc4wdph8G7hk2vOSAV
         INsrKWZEfDDk2cFp2mJANNadDp0mKyETNTGQZKWk8MmtlPHNjVhSQafuKZ0bU7VHvHTm
         Zs5Q==
X-Gm-Message-State: AOAM530hy0QH/M0CKVOgs3tkuyqlZskkC+sc8bs0RK9fWkF13hng4sa7
        GYb14S5TeMvUU2WU2IHrMMf6vA==
X-Google-Smtp-Source: ABdhPJyRDvddIeS1/YpBHwwIUziToV1k45g4xx9NofiOb7Hsstu3xrVH4MqxU/Yj85dSMQr2JDK4tg==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr56642wme.132.1612452385915;
        Thu, 04 Feb 2021 07:26:25 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h23sm6700747wmb.41.2021.02.04.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:26:25 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:26:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     samirweng1979 <samirweng1979@163.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: Re: [PATCH] kernel: debug: fix typo issue
Message-ID: <20210204152623.6vmapcjpddlsnbuw@maple.lan>
References: <20210203081034.9004-1-samirweng1979@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203081034.9004-1-samirweng1979@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:10:34PM +0800, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> change 'regster' to 'register'.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>

Applied. Thanks.
