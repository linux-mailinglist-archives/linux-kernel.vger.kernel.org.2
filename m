Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08C6381EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhEPM5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEPM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:57:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E73C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:55:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l70so2842061pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZxcBGrT6Kyw/+duJ+BUSdpPCJHKScouIvkGJ8rV7HfI=;
        b=U7x3BfjBpTAKts9FEMf8K29lMBLNInANLuYCvw9ZMoG5tfsIVytInnUkmLdqo5FO/q
         GcQGQmK0d+FLzMEuXhCaOgJeqSddjApL8ZcIvygk7vjH9ypviy413lXoFiXf+jNPPwRB
         XHP3IE9eUmqkK8mpdWq3T8DT0r+mwXPzXxvwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZxcBGrT6Kyw/+duJ+BUSdpPCJHKScouIvkGJ8rV7HfI=;
        b=GKTo+DB7Kt2zFz3tncDTuaqOp6iSVfYrTvdkJYCzDCJ/C1qkB6VNPxQijY30o6JVRq
         JMuZcaMfR2nfK0ksHFlE7NrYzKabcXaqwliHdQiH9zbjOZ7cXhwS6JYQlOvb7PFpdcUp
         Zi2KU/WFfvjbSlGL0SmMuJin5p11fyEwaZf77+FDOcF0FxL4EF0mG1HnwGX2yFx/R8jj
         bMQ6ywBPBzaXVlHYv/VOuqIF9TvEgTl39DA/t0YSgjfCAQAJVhIOGBhEgAb8EmVSZA1a
         9CD9LK/6qIh9np7RkxIt1v8RFifhrlZ6FlA7hR3t+1tw8+ZL02v4WJbnb+8SDrCfu4A+
         JZmQ==
X-Gm-Message-State: AOAM532xy6yYDM12vVt51x2eLzJRLsww5I9cDIGvy7w6DzV1aQOOm3Za
        g2k9x7yrw9KmH7EYFSVB6K/x/Q==
X-Google-Smtp-Source: ABdhPJwBSVlfoJv9AlafwzBVQ170xi4hh/0woJXOQkdsUBMyXrxu/TCRP/+JGLPdo9R5VbUN9J8B3A==
X-Received: by 2002:a63:af57:: with SMTP id s23mr4519959pgo.393.1621169750516;
        Sun, 16 May 2021 05:55:50 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id 187sm7572024pff.139.2021.05.16.05.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 05:55:49 -0700 (PDT)
Date:   Sun, 16 May 2021 21:55:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YKEWUYdGSXQFf02o@google.com>
References: <YJ4yBmIV6RJCo42U@google.com>
 <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com>
 <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com>
 <s5hbl9b6mah.wl-tiwai@suse.de>
 <YKEAqdIAZ5K5FS+1@google.com>
 <s5h5yzi7uh0.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h5yzi7uh0.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/16 14:07), Takashi Iwai wrote:
> > > For fixing the crash, this patch adds a internal flag indicating that
> > > the stream is ready to be updated, and check it (as well as the flag
> > > being in suspended) to ignore such spurious update.
> > 
> > I reproduced the "spurious IRQ" case, and the patch handled it correctly
> > (VM did not crash).
> > 
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > I'll keep running test, but seems that it works as intended
> > 
> > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> OK, below is the revised patch I'm going to apply.
>

Sounds good.

> Thanks!

Thank you.
