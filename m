Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43A311D4F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBFNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 08:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBFNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 08:05:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB9C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 05:04:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f16so8238006wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 05:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nKPg84vPAsler8ZdvnZRQBxc8c9vuzM6TiW3fRfh4Ic=;
        b=P6sPszSGjY+cuuLSq/tSJyOYB/KLmUVT+22d8vHVBc5SdroAX42KHsfDtsIRMupJtP
         q+YIdxVNeIMu+SzNiDAHM4Q/uuzhqOy/JIsNzXgqYsyDF56r9UKgN5a7bjwUttcu2T4j
         x7r/cxVqt2IOd3CyxwQdJQn3J5EIGpufOQnqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKPg84vPAsler8ZdvnZRQBxc8c9vuzM6TiW3fRfh4Ic=;
        b=hp/jAaoriXcsfWR+nI3JuUn7ZGuJ5mu8vNjd4G5FJyx9CvUbhF5bIak6g9EIiznHIj
         CLCQdWucUn8vsU6WsbTA+JNcylb18gyDkkhHEGequORII9HpV3Vuu6cP8bsB6c53JG9Y
         XFOw7bpcQejcVs7jwm4uMX/J1AawVKspp/goC4HthQQm0Mr4kzYrBjLpyUYoou6SyYRV
         J9sHZoYdRbDWeZ6HciQY6ij+KAuU83Q5UBNLhHk5NRXqawRfUAeQtGdaH39sLyz9vNyx
         /LSLKoQrYid2cCKGwg6RgByt8ZToUdOlFv4L82kkSM86amWDm8gFGIjV7U6iCCEpBToz
         v23Q==
X-Gm-Message-State: AOAM532xkO32FtYYvSqRkuz5dorF0iu/vaZpCuw1uSPGpzlofoweU5Tz
        CAvs/h0ixsh/XYjBxpju8x31XQ==
X-Google-Smtp-Source: ABdhPJzDr+z8XXOjRDoi4zwVh2uS+yX88eMtN2z221hyOhrx24tJcwcLrEvM6PuiVJHKGr6fRezt3A==
X-Received: by 2002:a05:600c:2351:: with SMTP id 17mr7562026wmq.2.1612616694504;
        Sat, 06 Feb 2021 05:04:54 -0800 (PST)
Received: from localhost ([85.255.234.177])
        by smtp.gmail.com with ESMTPSA id f3sm12390313wme.26.2021.02.06.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 05:04:54 -0800 (PST)
Date:   Sat, 6 Feb 2021 13:04:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] checkpatch: Don't warn about colon termination in linker
 scripts
Message-ID: <YB6T9Gf6oKu8R8e9@chrisdown.name>
References: <YBwhqsc2TIVeid3t@chrisdown.name>
 <90cf805f4be6ecf5887fe470af6db2d596dc46a3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90cf805f4be6ecf5887fe470af6db2d596dc46a3.camel@perches.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, apologies -- I was somehow operating under the mistaken memory that this 
was under Andrew's purview and neglected to run get_maintainer.

I'll resend. :-)
