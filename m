Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB42397362
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhFAMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhFAMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:38:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B63C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 05:37:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so3505567wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q0VBZ1AmByAwe483WcR/T7rzmaJh9QClItlEm17BvFI=;
        b=d2Hgau+jcqalZ4sy6NlOFUwOXyUHs4G8vNJNITWkEyxo6ZTyRi0W+W7PkycmX1qqM1
         L2MXvn4TJ/hQsqIjFiXcuXZ8PPNjEBm5UHAseOTHzAhWiyJhmQNfJroG0qDHmhBVpnkQ
         fdbn0Xx5DBVT1+FqgqWHbRbvatcuxeg5apstgUHyoJfqoEbx/CQadfM9af7BQL3ZxXvU
         KJCmMhbuq0nj8S/7W0oMu522gOGO3Pz4d+yOiMzKi75fYABMUfVkWEQ0Fwf7Xlvq5Ip1
         0QQg+LNGMQWrdzySFIqcrJFQTO7nJwNhIIXtjT4/r3dDzwYp+JyoTiPeX5j+yJvIrUtQ
         SxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q0VBZ1AmByAwe483WcR/T7rzmaJh9QClItlEm17BvFI=;
        b=pkhTCjiqoQngoIuCAAxM9bkP92+pQcDgSUMa8XtEaM8OIzTtGBqsAI7KpnyRrLyZ9F
         awNJIrX/qVonJtE15TS/yGY+tOK8dBsmLVVgslc4ZZyDX3Ib//zpKkIWx/YZa9ZQhT4a
         X/SawdQ3EWN9WO+6WqMQ1slX2+BpBf41usPL0+u0dIZLVwGNuTuClL9mqJ6ZSg6665LV
         HG14OycCYXwerHEEUU3+xMVUGA3Nrw0rHX/vMj9BnF4qfBYWZ8x4E1iOEtPrR1/tCOI5
         ai+XejSpSMaTQJBfaGdR2ZxKbPyqaRcHQYwrtIhLv0SqUeHxOqDO2T13xnTMiHDF8RDt
         twcw==
X-Gm-Message-State: AOAM532oI/FTL+UpBrFMluux/ExlnUfq5hWlvlTDN+I99jf4jIGGzenz
        gZYlJkdv8C1UQpZAAfZCHtjwDg==
X-Google-Smtp-Source: ABdhPJx+WkixZCBNz3HyAM2qy3S4l/JY78r8hqeHHTCllSX5rLccBj2FPCaEijRD6IGJi7GnZig83w==
X-Received: by 2002:a5d:6484:: with SMTP id o4mr26822370wri.8.1622551030771;
        Tue, 01 Jun 2021 05:37:10 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id b10sm3900609wrr.27.2021.06.01.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:37:10 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:37:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2] backlight: Kconfig whitespace and indentation cleanups
Message-ID: <20210601123708.GF543307@dell>
References: <20210517095839.81833-1-juergh@canonical.com>
 <20210519110300.17918-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519110300.17918-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021, Juerg Haefliger wrote:

> Remove leading whitespaces, replace multi spaces with tabs, and fix help
> text indentation.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  drivers/video/backlight/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
