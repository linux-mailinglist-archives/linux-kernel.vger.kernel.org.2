Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166923839BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbhEQQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344678AbhEQQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:25:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6CAC0560DF
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:57:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so5121803pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BX/Io4tTMdO3qzC5T80gF/aBXzbDUFf4X9s+rziw0bQ=;
        b=c8niAl7ESDpAN17CH581ks28MAIDSaNjtsSo4xreYKUbMBHvJAnZ+auCCG4P3zn2b7
         +OmZVqSIcQvgtjppY1gqRAn/5fR5xIjjwruT2AZdaH9PBhdvTrSf1uGDf2mS+mwr1gri
         ZsPYUSuvmAP5N6qlwwJ+5LvrX9N4n/mhMVhhHI7QRasRtl/RXiY75yF8lFMJBO7H5Cno
         WMcz/6z7uxz1oHQDyruaNpO7ddhoRJ4MeYH+z99tlCE30wFVgC+CjaPZPrxO70X2wzWn
         W0Mons+Dz71DTk2M7va++0ejFjHwOLR6/nfqqdKKnHoJiUIS3ZnSxjp2ydeJHb4sitiI
         KxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BX/Io4tTMdO3qzC5T80gF/aBXzbDUFf4X9s+rziw0bQ=;
        b=GJj9olmZO+E+aOfGxSzW0gLvUXbXbd4fqYiDpbZpi5mEQ3Ji5Ez3ZaUkPRK8Ifli/h
         11OuY5fFPYdemrkhZS30ThjssWJcWPANr+hwdvB2jb/HAQc87rA8KPPUadSOKAyLkB9b
         WRkQGU/FSy6rTMjOSYThE8PT/X+kGpweastFYj7Hb/LXshKHX8Uam1A7zzJa3D8GhdUe
         oJt4Th4Zw9CEZH8zu+8lf4Gjhl8TtYjtOb0rXgsQNxIpoFeKDCT3NGkQtk9P1MxwoPJO
         H9Nu1M+bfewNnR8he5dcaXtXVD4vyifDxvwTCP5pSYWLfsAuOjwwcmD8ygoQ9NmfuCxQ
         TRKg==
X-Gm-Message-State: AOAM532DXr5XdihkVcbPT7BgYlHeoyU9xmMy9vr1a3rNjZ34WrDdc0EQ
        lx1Yxm/McestLrDs9MWpaic=
X-Google-Smtp-Source: ABdhPJy2+qaj3ctQl2aAncmPDi17/hhtyAc9OskWXvlB/UOcGoL8GAGOid6G3FffLbkTjde1bpQmnA==
X-Received: by 2002:aa7:946b:0:b029:28e:d912:6be7 with SMTP id t11-20020aa7946b0000b029028ed9126be7mr115832pfq.26.1621263423822;
        Mon, 17 May 2021 07:57:03 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id l62sm10099265pfl.88.2021.05.17.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:57:03 -0700 (PDT)
Date:   Mon, 17 May 2021 23:56:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        42.hyeyoo@gmail.com
Subject: Re: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517145658.GA56459@hyeyoo>
References: <20210517132725.GA50495@hyeyoo>
 <s5hk0nxo4qr.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk0nxo4qr.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm kinda new to linux,
but tell me any time if there's something I can help!

thanks,

Hyeonggon
