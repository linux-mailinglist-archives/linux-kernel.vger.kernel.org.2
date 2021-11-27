Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF93545FDC6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353961AbhK0Jy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350537AbhK0Jwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:52:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3453C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:49:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r11so48865115edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ek72XmF5zebDTqplFEZ+Bj/2i72f7eNky/xq+3hGyBY=;
        b=NM7HNP+xs1nv8rmUE/Fv5cTZajnku4ZGJ+GMn7pdHT5/rkYz2PDmDP+DXYTPX7svyM
         2Gtbu7/DbENVtOXbXvvCMTM1G/tKZJnoKMtJylK/RPEEiYtNyMdAQiovUzsxBTIzY4DF
         LZwheNIW4shf8VNI3ERO0ULrlh4ze+Dj161vkgE7h4hYs6a7LYERJ4dSh8YFoX/RcEwd
         DTy/euZyEeZxAM+CAbJ5M1GfJ1xguI5fwsSw+Sek+yCrNO5pQI7Zp7AN+L8VHzbrEN3n
         b/UiEEYs+a+lJ901+jD0V8iywA+qkI+6pdV1YzjkNrEOuhFzsDEZXh0iB6sd/XRmLzgt
         Fhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ek72XmF5zebDTqplFEZ+Bj/2i72f7eNky/xq+3hGyBY=;
        b=K2uiLjNOeg2fxUoQgKnKxXfVPJx6Ud2qUOGdxcr9jgpOIpPK88ctoht1rVBqD+vuIP
         IBSF6By+jCA1yKZoEROxMGQAxkM6WS2M+o+LFKw8VdLZrrKhwsekqsmr66yBTWmdLDmh
         B0MuiT4v0tfjkttPwoK3+fwMx72dCryovfv5evwMnMSyfZOD8l1yOdpfPfOtSwmom471
         WgIMGdKRupswJKqmewGRXjV8dai5ExWdmXqVCtEL0/XfKA9rikk3pe30phPjJuK4ghTi
         JhhsbRM00Nc7pihETvBZ+v4GOPmUTgm/wmXJoBUGJOyN53BVTPoB7yrl3y3E8bsAp302
         pi9A==
X-Gm-Message-State: AOAM533XMrLmIYbbr8SbWcF7Bo8rDgZkLksfBagqJuDpREJw7GN3tlLx
        Kog5RmMUo0M9sSRnt4YDGeTbzTHVw7Y=
X-Google-Smtp-Source: ABdhPJwJ6eRiW1T2rUKkZGsdbAHv6Aai1hfw8Oiu1cV91/sTKHTGtrlrjsH8HEzTm+MKnxfsMFomFA==
X-Received: by 2002:a17:907:7f0f:: with SMTP id qf15mr45839969ejc.560.1638006579397;
        Sat, 27 Nov 2021 01:49:39 -0800 (PST)
Received: from bulldog (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id f7sm5296049edl.33.2021.11.27.01.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 01:49:39 -0800 (PST)
Date:   Sat, 27 Nov 2021 10:49:36 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, forest@alittletooquiet.net,
        karolinadrobnik@gmail.com, lucas.henneman@linaro.org,
        dan.carpenter@oracle.com, tomm.merciai@gmail.com,
        eantoranz@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211127094936.GA3102482@bulldog>
References: <20211118211128.GA156436@t470p>
 <YZ+9yDiG1SoWrWED@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ+9yDiG1SoWrWED@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this v4 or v5?
My fault is v6, sorry.

> Subject says v5, but this says v4 and then you sent v4 two days later?
> 
> I'm totally lost, sorry.
> Please resend this again and properly set the version number.
To be honest I'm a bit lost too :P 
I will resend the patch with the correct version.

Thanks,
Alberto
