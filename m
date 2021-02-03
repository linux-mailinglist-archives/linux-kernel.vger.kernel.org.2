Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F30D948
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhBCL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhBCL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:56:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B454C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:55:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g10so23913154wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UwWGiG8OEmw7Jkn3+9/+1DRBsZZ6FOChrQTe2byMSDY=;
        b=L9PdQMB0oAaOQeOXLQkRWY+ETxgFa5E3dd1NcQ+3WiB5uQ7Yqt21eXifjWe4rp0rey
         7qRRl97PWH9agZFScyUnyYPv9+73ZfxjtoISayWnuqXpz2mQfj+W9Mo7w1i0cT2t3uM2
         lOQ24QXRu6hs+sspcgcdceq4Vntme0oWXaJAk0kZyiAeS2oiE8sDSAiKTgd4EbULASz0
         M+4upoG+3x9bQQyrZVuaGwoV1IY0R2iIJCK2RvyNNbC/Ed6pXPAoYVdC5Co4vE+jFWU5
         ueYeugBhACqA/hLC1a6Uaz4YR/hXnImV91oVwVz1GfHdFkcPnAVNKKluZUw2cQzq9kcD
         MsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UwWGiG8OEmw7Jkn3+9/+1DRBsZZ6FOChrQTe2byMSDY=;
        b=L7TMm52N08yLjJY1ikaqjRVq7jgR+5yp4LsZlD6HWAW1HQxbOYwxqYTfeJaIkAVn1e
         HrupSib9XMShxmOGFiGugwjBjFz4r48L0vKOfWOyQ4xCDEA5aawgZ9iap3B9Hy9UBXt3
         a2rfK0/c1ZZC04mew6ZV+wDNVCpAfhRDd/vpKE6dl7iaGazJxUvjG2S4wo6Hi9N4IfiH
         xk/B0PSizw2kt1IBAr3ZtM9GvGXrJ0enP4DmCKsJ9BFt6dLK7BJZJsociIJr8kCuVtco
         9n13+B8WX2Dlc5M2Ov/N0HWdBBaDrOFG/294yacCWQPMcOhDDw3X65yWD3v//XYUkvAk
         QhiQ==
X-Gm-Message-State: AOAM530B6kEd7OymDnJ1raB2DTNHxJV0/UvFZRHhF2cqWj4Cghf2/+JK
        mjqF0Z9xDpsVKF6JhORSnvKT2Q==
X-Google-Smtp-Source: ABdhPJzEwxhuazkz3NzzBzi/R6KRxmCnNVVrvZSWSi4VAWNQzji9Z9rqnJnQu4c+BFQya3r0llcA5Q==
X-Received: by 2002:adf:92a6:: with SMTP id 35mr3134158wrn.193.1612353357327;
        Wed, 03 Feb 2021 03:55:57 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w4sm3502992wrt.69.2021.02.03.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 03:55:56 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:55:55 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     wengjianfeng <samirweng1979@163.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: Re: [PATCH] kernel: debug: fix typo issue
Message-ID: <20210203115555.amlmxszvfidjic46@maple.lan>
References: <20210203081034.9004-1-samirweng1979@163.com>
 <20210203112359.cdy73gw4wip5cnyn@maple.lan>
 <20210203193609.00007678@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203193609.00007678@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 07:36:09PM +0800, wengjianfeng wrote:
> On Wed, 3 Feb 2021 11:23:59 +0000
> Daniel Thompson <daniel.thompson@linaro.org> wrote:
> 
> > On Wed, Feb 03, 2021 at 04:10:34PM +0800, samirweng1979 wrote:
> > > From: wengjianfeng <wengjianfeng@yulong.com>
> > > 
> > > change 'regster' to 'register'.
> > > 
> > > Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> > 
> > It looks like the Subject line might not be correct for this patch?
> > 
> > Is it really the first time this patch has been circulated or should
> > it have been tagged RESEND or v2?
>
>    The patch was first sent on January 25, but nobody relply me, so I
>    just resend the patch, and the patch is the same as last time,does I
>    need add RESEND tag? thanks.
 
Yes. When resending a patch adding a RESEND is a useful courtesy to let
the maintainer know why they have received two copies of the same patch
(and to make clear that the content is the same).


Daniel.
