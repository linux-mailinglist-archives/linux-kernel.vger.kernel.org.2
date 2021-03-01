Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8616327A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhCAJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhCAJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:02:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE0C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 01:01:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so15238735wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 01:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g4W5dBF0qbRtxiyxch5HU6fNLbEdEIt4hBih+QxI3w8=;
        b=Sz03B40DODgMbYlNZxdd6btsImGzluXrVtdlrURVlm2GNl7qJqQa7YPSuOPjuHzASY
         MbDhfFV7IF51PEpyOhGvzMHmKlmfinyds1Lvs2F6r1DK+GuJThNKQH77skFVrjMcEM32
         2ooAKsnRlAAxxeRKT8KMB1OfyQwxxGekJpDXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=g4W5dBF0qbRtxiyxch5HU6fNLbEdEIt4hBih+QxI3w8=;
        b=LFHzDMPqeIJLkixQ5UUW4T/urZtjfLoBEu4nXyg/OgJ7CPymJ8a+wP/RZearifQkiO
         LbqOG61sruqoR6MKExba0fnVh7wjv4ceWjNEDu3B2O/BkjpFE7yp5leRTEUXKUzqAYn/
         F0j2jqKfBLorK7XHbNfrDJKqk24CcYJNtBeoNtBtaD54B7ZS2ZkxOflqE660857vUOVt
         t/S+Ck5fhraCgm5ksVoGprhHdR20de8bfdu1eCHLozJVQMsKKWV2q9yJ7IW9ckpxDN3z
         DzqxH5F1Js6JUpf6Fcrh+0G0gmuLjK10WObqfqVlDMYg4oAn7AmtFQtpIMbwaf4ZkDNq
         ZtFA==
X-Gm-Message-State: AOAM533DxyLulfynoeatJgDmuDmRZJwckXVqYrEBulZsKKRaEQl7KOcq
        TbSDLdpu46nmPly6vAggyBRN1A==
X-Google-Smtp-Source: ABdhPJxGV5UZhGGDfGhp16kC0XG9seTn+X9JCgKx3K456MS2XOEVB9n7TMxtH0TTGcCcP1/OPPz5ZA==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr7840199wro.324.1614589286762;
        Mon, 01 Mar 2021 01:01:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t7sm20020214wmq.44.2021.03.01.01.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 01:01:26 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:01:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pavel =?iso-8859-1?Q?Turinsk=FD?= <ledoian@kam.mff.cuni.cz>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] MAINTAINERS: update drm bug reporting URL
Message-ID: <YDytZE/AupG2NoHg@phenom.ffwll.local>
Mail-Followup-To: Pavel =?iso-8859-1?Q?Turinsk=FD?= <ledoian@kam.mff.cuni.cz>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20210228163658.54962-1-ledoian@kam.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210228163658.54962-1-ledoian@kam.mff.cuni.cz>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 05:36:58PM +0100, Pavel Turinský wrote:
> The original bugzilla seems to be read-only now, linking to the gitlab
> for new bugs.
> 
> Signed-off-by: Pavel Turinský <ledoian@kam.mff.cuni.cz>
> Cc: trivial@kernel.org

Queued up for 5.12, thanks for your patch.
-Daniel

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bfc1b86e3e73..434adb869522 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5793,7 +5793,7 @@ M:	David Airlie <airlied@linux.ie>
>  M:	Daniel Vetter <daniel@ffwll.ch>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
> -B:	https://bugs.freedesktop.org/
> +B:	https://gitlab.freedesktop.org/drm
>  C:	irc://chat.freenode.net/dri-devel
>  T:	git git://anongit.freedesktop.org/drm/drm
>  F:	Documentation/devicetree/bindings/display/
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
