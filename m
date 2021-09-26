Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6779E418B38
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhIZV1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 17:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 17:27:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB94C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:25:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v10so19305705ybq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u90CRQryuo5qOzEPD2UARXOpIxVXCwqfX9T3EpxFXEY=;
        b=dLdd4Qma6HovI+P1dWmrUmAoYhhLxI3a5fHEzT9CBdS4dCjvyBpgpSsWbZjatGRjDl
         /qdfNMUQxJqK0MD7lyjp3bsxU98Ai/xqVZxadWJn2ZUzXjNUHd3q9tLeOusqIykyVYtc
         +VUDVMaRS+NNaWuRee7hMnI2btcYhTBhutKnpXMbHlhEbB6U9a35IeiQSaDMYZsUOlhN
         UUgXqIhhyYDnm3qEGNjRU+iNFLltQ+kkfa0K0YaFYWfSn9spQp7GgeFqGpculh8Uv36G
         JMT0BrF7qehHXEjDCggp6J80N18oe/R63fhXxyGPDbegpscf68H9Va2Ef2zIsA9PNLjs
         oxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u90CRQryuo5qOzEPD2UARXOpIxVXCwqfX9T3EpxFXEY=;
        b=gpmHpwVPLSjDEL3De0pRRSNcozhmFi5WY1pYnfcX+bz3GhabW1Bg3kd6NXWAaO/sGR
         eDShPez4ZPD0yc3ijNbUrY5UOOQ74dQRenpVelcZqyU38vquSdagLBznkKQv1EDDBcO3
         Ejesi010j/VuxHZOCSWjP41Ipht0ouHSAGiJcGX7O3VKHqp5Fsqw3XdWZF2/RyWM3P0W
         qjOm9qVI5pRCPW66O9Ms7ymKXe2mR+OeyT7Pq7MydeqrMeWRGHkZt6zRTr7+Hw95PwPK
         oHJ9Ztv8BDBZvzmLi7b/LetP5stDPxZ3K8/ZCL++EYQFuDyRA9upvKdILtSurW+EmEYv
         hipA==
X-Gm-Message-State: AOAM533lxoFeyfT/0k1U/5NFKJnYEsb3y7uq9YXqhRfprPBkZu4CPTLU
        IIrX1R53uxns7Jc7FXJa7nfl6ENmraabW1sgPi4/PhCDiBY=
X-Google-Smtp-Source: ABdhPJxoc98jcZdFBXqrdeOonwNyi+31ywmkeMQwNNCb6LjxQ8yDeoDAVI0gHgGGUOPKO2fCsdhTtavDX40PzfyJ+/o=
X-Received: by 2002:a25:2142:: with SMTP id h63mr26275988ybh.70.1632691528815;
 Sun, 26 Sep 2021 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210924135530.1036564-1-maxime@cerno.tech> <20210924135530.1036564-2-maxime@cerno.tech>
In-Reply-To: <20210924135530.1036564-2-maxime@cerno.tech>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 26 Sep 2021 22:24:53 +0100
Message-ID: <CADVatmNKZGoLte9OJwRRurgWCWLVP1RDS9aoS_H1GkRa00xDig@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vc4: hdmi: Check the device state in prepare()
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 2:55 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Even though we already check that the encoder->crtc pointer is there
> during in startup(), which is part of the open() path in ASoC, nothing
> guarantees that our encoder state won't change between the time when we
> open the device and the time we prepare it.
>
> Move the sanity checks we do in startup() to a helper and call it from
> prepare().
>
> Fixes: 91e99e113929 ("drm/vc4: hdmi: Register HDMI codec")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
