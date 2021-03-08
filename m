Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F1330A31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCHJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCHJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:19:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236EC061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:19:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i9so5538120wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hEOGgoBFFfBcRYu8R+ZFzD5oTYtm/qga63LL53Ov/bU=;
        b=evLEsiqayrflm8/aMCMFF1KGm9tCqy5TgmLozN1pf5OV8v3XOrrOZ7dusez6ueByqx
         QbfNJbn3Tb6TelmwrFWDd4WHxalQui+FvvMLcnchyO2FEC0WH66rXpO7Bg5MqXxBzX+Z
         cc9Pr7PgNkEy1bM1xcbTqIIGCmKoaS4GNgx3Ck/1lpofYRw8U2M/EjDO4iJe0z6SkwP7
         NEfv8QFCktFfq07V+8oK+WYbUu5K7JfqkfwOCUZH8ZfaC1XQzqb4v836tecMta/an5NF
         q1zYSc8uWIE/dnLOv0rAgqCp8RZ+/3Pe/2mlOOfPdm/KIfJDoR0E3DqxqFiDR11IYcOx
         uh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hEOGgoBFFfBcRYu8R+ZFzD5oTYtm/qga63LL53Ov/bU=;
        b=abQXi14M7ufGA6obg0L4BwSm4zVEmuyUWoqphOkKCCg1ipCzJUVXh9HkZgwzmt5oL4
         lrANRMZqPRRx9bkwJnb/guELaksUkOZl7vVwut5vXQGw8ev2xzQthf3OkGkwCZlcCW4u
         n3iqOZjgguKi9AmTyTpm22fLMrRbVOpqpFmQEX6RQCr2hpQSMdPOrMfVz9fOe3AOHrRg
         Oe+Ha8kE8V7/gmnJCaaMJLVTZ7BkrhbDCLfTc01KwZNRQjm50S5ALBf7YA/59CYzRp64
         eEKGQWnuR6aekieHdvqmLjCxaHEdj4tKoVXlyz0tCYFgCcrX/pVKHcrJxeMVI/GIW1tL
         ajjg==
X-Gm-Message-State: AOAM532IDuH5Cn3FJ8JleI/NAoEnY5XAiSqO89qjHrNmz1wWJubXRELD
        wLGynwWjvNaPXdlBo99M2Q+IIg==
X-Google-Smtp-Source: ABdhPJySpXzmJ3MCPU31zc4PaUGqi7NmkyvQv0pK/pj0WvYnEHQRAY6VwjmHVQ6JfBzbPkybjDafLg==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr20979920wma.167.1615195176468;
        Mon, 08 Mar 2021 01:19:36 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id i11sm17599389wro.53.2021.03.08.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:19:35 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:19:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Roland Scheidegger <sroland@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Jeremy Kolb <jkolb@brandeis.edu>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Leo Li <sunpeng.li@amd.com>, linaro-mm-sig@lists.linaro.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        nouveau@lists.freedesktop.org,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Clark <rob.clark@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>
Subject: Re: [RESEND 00/53] Rid GPU from W=1 warnings
Message-ID: <20210308091932.GB4931@dell>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2021, Roland Scheidegger wrote:

> The vmwgfx ones look all good to me, so for
> 23-53: Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> That said, they were already signed off by Zack, so not sure what
> happened here.

Yes, they were accepted at one point, then dropped without a reason.

Since I rebased onto the latest -next, I had to pluck them back out of
a previous one.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
