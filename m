Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE7401CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbhIFNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbhIFNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:50:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0AC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 06:49:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so4825236wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A4jOhR2vRvnKHiSaA5vRT/Kewp2YBhwRZF6rf63lEkI=;
        b=DEaD2/Yzj/PIEGHCf2Hgo9sTxwYOGS0pd4+5rls6fny99vQBctrGXz+mpQT3NSi4qv
         vpvdJns2nVVQnM6kFp0Bi5TzO1zETmUQx8IwPSsb1UUGf9mh/iKoTz0OFrQB1+8K/5cJ
         /+WZp85bDP1VjTlBquBB0A0ueMkIFKeWYVnqq4W35+pS+JeYD826QdMswqdLt/8IYucI
         S598cEr7xEJJ2bU3bFVBg8KALmxcBkmzABNs1VLF6hXh/jXwE8C6XvmzpIJS90RYbyR2
         BIEISwZl5ESCB1CKuSissqglGkIZOmJdYoJK+sNKG3WtYlh4px8lQTavdaOZFy1iYDB5
         kN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A4jOhR2vRvnKHiSaA5vRT/Kewp2YBhwRZF6rf63lEkI=;
        b=PBSAz0+YaWfvtxyPmMM2V6THYFKUbcRKQq/2alYKV2vZUT2owNjZjtURtT4Zq0Gb7I
         xcz7KrDsEHsZNvq2bS9UZQjmHu18tYLDmIT7y2l9ky98TVvkqS0+inINf24RlKXuU5Bz
         Tyx8Ii9xHhr8Xde8sLlN0qRw0o97i7vRprTE7TI820jSq87tjlAuGGnVLkHUF98ojoiy
         QqjO97FkRJh+10TZYSJOPgLbIX8QMrKpbUaeSLTs3iaAj+7QGNtpIwVwVWIeBXYVFI07
         6yNKMeqqpUorETqLrfpafDWptpKsmtq5UwHtUbsh7ODbF90yuLmABmeFE1nsk7sceL7Y
         Xu9A==
X-Gm-Message-State: AOAM533V4yEIzpiPZ/agrtzi2gZZFz4Y8IKKxZPB0AW7kR+5c/oH5GHu
        9ERP1bFvV+NkGk9/LcCQCLu/RQ==
X-Google-Smtp-Source: ABdhPJx3FlWvq/ELhQaqN25Y+JvPNsma3T425v7WMG7udITx98z2t1PeLJlC4vWYiLbDd9Hp9mhtWg==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr11185837wmc.7.1630936193693;
        Mon, 06 Sep 2021 06:49:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id i5sm6838107wmq.17.2021.09.06.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 06:49:53 -0700 (PDT)
Date:   Mon, 6 Sep 2021 15:49:51 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     gregkh@linuxfoundation.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net
Subject: Re: [PATCH 0/8] staging: media: zoran: fusion in one module
Message-ID: <YTYcf3We4dcvBx1h@Red>
References: <20210903191540.3052775-1-clabbe@baylibre.com>
 <efe035cc-1839-210f-c0d4-4d58801aa65c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efe035cc-1839-210f-c0d4-4d58801aa65c@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Sep 06, 2021 at 01:03:56PM +0200, Hans Verkuil a écrit :
> Hi Corentin,
> 
> I finally had the opportunity to test the staging zoran driver.
> 
> I found several issues when running v4l2-compliance -s (I posted a patch
> for that), but more seriously is the fact that trying to capture MJPG
> at resolutions 384x288 or less just hangs my PC. It works OK with 768x576.
> 
> I discovered this when running 'v4l2-compliance -s -a -f'.
> 
> BTW, why isn't the initial format equal to MJPG 768x576?
> I would expect that for these boards that should be the default format.
> 
> Another issue is that the TODO should mention that for video output there
> should be a second video device node. And that's really something that
> has to be done before the zoran driver can be moved out of staging.
> 
> It shouldn't be that hard to implement, I think.
> 
> Right now it is impossible to run the compliance test for the output, since
> it doesn't even see it as an output.
> 
> Regards,
> 
> 	Hans

I work on having a second device for output, (it is the reason of "staging: media: zoran: move videodev alloc" which will help).

But I still have the problem of non working output.

Does output is really needed for going out of staging ?
Probably nobody have it working for ages. The only way to had it was to use an old mplayer output which is broken since so many time.
Note that this plugin will never work again.

The only way to work on output is to use ffmpeg which just recently have suport for writing non-raw video to V4L.

Regards
