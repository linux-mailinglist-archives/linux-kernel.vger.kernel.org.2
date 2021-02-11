Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5C3187D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBKKNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhBKKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:11:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951AC061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:10:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id r2so636775plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UWUI/kkDinmay7MvgnYpZn7ou/nW9tAWna4jMvJtvY=;
        b=X4/N9a6jFvnHFA8dpCYtIvGz3rj4GP6BpvaHedwgXzGOBETztL3uI14VkXupf818UB
         SOOaaJQad81JdAO9Dx1t2cliZrdNQ4ZkYaukHwhRmkeMp+fUTVebo5/67atzKn/DpRAt
         6ykqKZ7p7OmvD7ru/GeeAlACeA67u1sMgkBsiMoK+eoPws8qtwwAFsdoh8Ic164VkFZC
         qkkDpVdUEAlgzq7wFfIY8jveTpiBNk4uQ4eBmwXUga99ETm+1kboWHiISCz5PU7eyOVf
         Kxu7gh8HrcB4cHLxabl+U8RwpIHDGSgtWLhFNhCfgL8lf54R442C6qQuMPlhCTvdmnd/
         Em5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UWUI/kkDinmay7MvgnYpZn7ou/nW9tAWna4jMvJtvY=;
        b=uT99uhGlvgC1jh4PYeroRWdU/px7T64HFamwIiScy+rhOhfXup0u9h4/FGao+9DJkQ
         hB5J3dGWHy/k1ENst4qfHQdK5+OsI8keKVd96ORcU7OeGDZ40ctoDSxRsdyd+Cd+PCyM
         I084GyzFDI+IQPG59q8Kx4UkRpmRGCqFAgM2Kv0wnRww5jPSwkt374W0Ud3rbDizg0yx
         QvdRZrz/OPxLpgxwp1FIiT+3piKqB8YpaST+N3mrDS/mFiFXpAXoOMwQoZl/aiRssUiC
         YHmWUqlJ4VYT3oxFDLOVbYZjDkghF/9xU6KCTGqYE+Bh5XglYWoLZHt/t67Slur3szbI
         c17w==
X-Gm-Message-State: AOAM531JglFdGxeSdTCZ3GGiI2w5uTankREWQYXZNSAMAqsc8aqHPz0a
        yu9XUxh6bLDNqaCkmYPT5Ujong==
X-Google-Smtp-Source: ABdhPJyI4I2N7+f2yBokicCsqPV12GPsfMpH8tS1rxFrBawOPBvQFC5Pa0IK/8oSkGKZYpcmRkkM8w==
X-Received: by 2002:a17:902:c408:b029:e2:ba09:d442 with SMTP id k8-20020a170902c408b02900e2ba09d442mr6875531plk.83.1613038242539;
        Thu, 11 Feb 2021 02:10:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id mv14sm7847662pjb.0.2021.02.11.02.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2021 02:10:41 -0800 (PST)
Date:   Thu, 11 Feb 2021 15:40:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hemansh Agnihotri <hemanshagnihotri27@gmail.com>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH 1/1] staging: greybus: Added do - while in
 multi statement macro
Message-ID: <20210211101039.m5q26qgxififotqp@vireshk-i7>
References: <20210211095444.54447-1-hemanshagnihotri27@gmail.com>
 <YCUAMgFa6i9vl9An@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUAMgFa6i9vl9An@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-21, 11:00, Greg KH wrote:
> On Thu, Feb 11, 2021 at 03:24:44PM +0530, Hemansh Agnihotri wrote:
> > This patch add fixes an checkpatch error for "Macros with multiple statements
> > should be enclosed in a do - while loop"
> > 
> > Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
> 
> Any reason you didn't test-build your patch before sending it out?
> 
> That's a bit rude to reviewers :(

I also wonder how two people stumbled upon the exact same thing at the
same time. Copy/paste ?

https://lore.kernel.org/lkml/20210210221439.3489-2-yildirim.fatih@gmail.com/

And of course NAK for the patch. The macro is used outside of any
other routine, and is actually used to create routines. No do-while
required here.

-- 
viresh
