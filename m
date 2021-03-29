Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6588534CDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhC2K2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhC2K2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:28:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42380C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:28:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b7so18630808ejv.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGsJ4xZ84OyCSAfqZtuaiVtx07XyTMxsRtbJsypRgQ0=;
        b=NsB7szuvnsVvmZr6fMEaieeRGj9x9QaZGqOI73CDo4jA2TR2ZQ4McdBi4nQRDQzHhi
         AQkCCAdeenVeAZy5lpU4yQjrdZkg1D7hFyTtlopJXDJNAxxHhGkeEVwiv5zWsx+dXjTk
         MN6TNGINXyNxNDcmCiRA8s7QEGIeV+QFYCai7Pslj3/Z7/8ws3ZZ1H7qiIJ52UxUrjap
         7F+e0tXM/ofOblfLBvEFqiVkntF7sQy20nlbwn15LNdWbPJ01clWSTka6IqrLXBU0vqy
         ugW9KMTQMjqSw5KSh7Otb/rBxb5LEJBTL29R+4n5pa8bRbmvtYnwpJQ8OEF2pU6Qh/1R
         1nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGsJ4xZ84OyCSAfqZtuaiVtx07XyTMxsRtbJsypRgQ0=;
        b=dYdfeVBSkxqKjWCbEEzlKWmsnY05R6WSJhSfVebHAElcnwa4493+76QpmyTzSDL52Y
         OJYNgK8TuXR7H08JllSoL/XmnroCUDhriEDM435mbxy1TsPQIwQxSk9z39cBgItLgkkV
         RMtKH/7laUi1DgslF81kEjEx+gkPRR1Ziznr136wzgF1KiQOf8xLP2bsZ6NC+cIrunEO
         0Hdn2AXtemgHvCr7deEict3qU30pQ2OR+oA+PR8kUDg8MAcpy9IVKaWhqouKXeIglKJr
         DuBsBkFrc9JOy50rEtot2JwFxPheoyQOV93FehCatEnFXcqD1/eoMfvuPZy8WHIjaOSc
         cCyg==
X-Gm-Message-State: AOAM530sgFohqYeIAMuyG7/VBAyjhJ61y6Lbe6jp1eG5iSJ9PRwh7ydH
        QHe9wIla/4mJNOyEiYmO6FSQuw==
X-Google-Smtp-Source: ABdhPJxyRisF2a7DxPDROOeg/GclKMFezzp1ztelOuEDIeJGxlql4tmRUFhVw7fB1msFcAt0U2iUgA==
X-Received: by 2002:a17:907:2d24:: with SMTP id gs36mr27997185ejc.344.1617013713856;
        Mon, 29 Mar 2021 03:28:33 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r17sm8755121edt.70.2021.03.29.03.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:28:33 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:28:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20210329102831.rwvj46m6db76pp2a@maple.lan>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <1616945059-8718-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616945059-8718-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 11:24:17PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
