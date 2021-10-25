Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3D43981B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhJYOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhJYOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:09:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA78C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:07:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so9764687wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YE/NzH8qBpbjmAapzAwapgPnCPKetXqI0pgiy9yOdQE=;
        b=L2dGHyNoFi2z+4ecIyz89lYHwy1pDFUGrmT7X6ovQeMSwRJjiNQ1ptux181OyYZQ89
         4CcnKb0YmJUuZ1HItQyP1HB1NQDmPVHLsnCXUJlC5kmnW3/QKBtREawB1ppLZmxjD3W3
         nK/ZDxQDTMsjonxm1NySHvHsi3s+6J/djsF8TXOyaTMq+oYq+ViWg+iLzctDo76SY4yU
         T9e20DiJrwxC8jHC/f+dgjyeGEsNRkFlDgiV8fq/pY4tCuYE+D7hDLQTRE1NZ+xFqERf
         DmozuhP74V822Q2Y3bOfywpz6WtJnuI/qrlGayFvw6TqdbbWOVty+m+8BgUVn4tQGojm
         /msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YE/NzH8qBpbjmAapzAwapgPnCPKetXqI0pgiy9yOdQE=;
        b=yW6OCJ0n0AOSUreO5/P8yICO028pn2U/7eAJnGeEEXAb75EGXgs5r9HIIY/G3SctlI
         Ic9iKN1wZxOgUuAobosKkDjk2O9+U4jKaPEiW1v3vRt7CnwIphhS70tZvCZmIqY9E3oO
         1Obbrs5GNyWBGnOnyLLKA56OQ8opbaUbjXQ+yq/Fj/4wR/kyD0iFVovcbp8f7iDR8+DB
         tyRLqplq4+G3Q9wT/gLJu51d8TWpQxKVHle49CowdTkfSJlwyg1HV7JrjYSaMD1tCiGT
         ujTOhWEcdVYRXWCTPfdNq+1a6lk3zEkW08/4Hlzne32wePrhR//fDt02TMI5kbUEWdcX
         vIIA==
X-Gm-Message-State: AOAM532i6N6RQnvVHen40IGNznq4bx2tzuENPy5rc3dLkSIlXG5P/Y2b
        crKyD0qw8QKzGBmD9e2xkodw2w==
X-Google-Smtp-Source: ABdhPJyRYFvibtgc8IKqIHYknb4PmyxGSQKD0RMQUpWrP7fkWuU1HAthN9l4r9nE/QnuRmGJqgGJBQ==
X-Received: by 2002:adf:e607:: with SMTP id p7mr23358297wrm.30.1635170819465;
        Mon, 25 Oct 2021 07:06:59 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p1sm5762489wmq.23.2021.10.25.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:06:59 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:06:57 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net
Subject: Re: [PATCH v2 00/10] staging: media: zoran: fusion in one module
Message-ID: <YXa6AVRmkkEuE+XZ@Red>
References: <20211013185812.590931-1-clabbe@baylibre.com>
 <c2474663-3fe0-b0cd-ecb5-57ec370481e3@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2474663-3fe0-b0cd-ecb5-57ec370481e3@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Oct 18, 2021 at 11:55:40AM +0200, Hans Verkuil a écrit :
> Hi Corentin,
> 
> I noticed some code review comments from Dan and a kernel test robot issue.
> Can you post a v3 fixing those by the end of the week? Next week I will have
> access again to my zoran board, so then I can test the v3 series.
> 
> BTW, I agree with Dan, just drop the 'Enable zoran debugfs' config option. It's
> not worth the additional complexity. Instead, just #ifdef CONFIG_DEBUG_FS
> where necessary (in most cases you shouldn't even have to do that since the
> since you have dummy debug_fs_* functions if CONFIG_DEBUG_FS isn't set).
> 

Hello

Ok I started fixing issues and will send V3 this week.

Regards
