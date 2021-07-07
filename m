Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7C3BE753
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGGLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhGGLoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:44:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8AEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:42:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p8so2712947wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKpgpEz+pk+V+ldgYqur++W1nBmK81ST14+xbKpmd58=;
        b=Fa/4vUyzf6E/EeDLy6JA+hJ9oLQfkIh9ABPr1r7T0uafu1NuvOHR3sFu5FyWw0L3GF
         ZFn6unFwsJeeh8WW+FhQFlWCsUjK/jt+pMYKIeStGioEptkrLw2RzPnHrzPO6uezZQHr
         im692Taa5fNCLajZnqP9itJUWEFobUwLQxw/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bKpgpEz+pk+V+ldgYqur++W1nBmK81ST14+xbKpmd58=;
        b=ReDYTu8GItM9KVEKqqb1nYREIf4rJzC0GyNpYwjB59Y23AVTJgynCBXqUxOluYX5Q3
         BQpdEW5Pe3KzlNXDmYJ7e7oDqLxy9rzVgw3Zy/lOC3N6f8zGa9YMNrcrBWyxkmbTGv5k
         QwIJBTNrAgHUPKzbnyQJCr9jakH61uxdYFdGa4y4oZm8DK3YDFngNTFXzX5g1D5AyNAC
         DVHOoP0glcodJRSSturcVOYpjYY3DC9U4vBDT12GWfo88WL1MDHLW7O7TB0PYUUvFpzc
         HDoPMyrMGb17QpMbsadIQPzdVcTsivS26ro967ArL2X9j0PokgnBXy0+nMdErys17zUY
         6POw==
X-Gm-Message-State: AOAM530CInzpg9qMvQc97fFJYJuFG+OOp2mQp25TiY0ZSlbL2tKB9KWU
        9mUK7g6NzXmT7nYncZoPiKZ5RQ==
X-Google-Smtp-Source: ABdhPJz9VXlKr00wIlz5nQYZ/vo1ak+FD0N7gT29dc1uZMdxDAOtpeV9ocDO/8PFl/9HtziAzBi5Qg==
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr20190027wrd.410.1625658123765;
        Wed, 07 Jul 2021 04:42:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d186sm6226981wmd.14.2021.07.07.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:42:03 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:42:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Simon Ser <contact@emersion.fr>
Cc:     Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>,
        Philippe CORNU <philippe.cornu@st.com>
Subject: Re: [PATCH 0/2] Add "BACKGROUND_COLOR" drm property
Message-ID: <YOWTCSpOZTGZS2qP@phenom.ffwll.local>
Mail-Followup-To: Simon Ser <contact@emersion.fr>,
        Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>,
        Philippe CORNU <philippe.cornu@st.com>
References: <20210707084557.22443-1-raphael.gallais-pou@foss.st.com>
 <31K3xupK1-7HNWorHqIwGwgEJl-1XdFjUQEoNYm6yB-lRoZ8kq5quRji_r3mzPZ0bUayLef6xPfQDiETgZp9lR7vUpDn2nB_37ncSd-J0Wc=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31K3xupK1-7HNWorHqIwGwgEJl-1XdFjUQEoNYm6yB-lRoZ8kq5quRji_r3mzPZ0bUayLef6xPfQDiETgZp9lR7vUpDn2nB_37ncSd-J0Wc=@emersion.fr>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 09:03:03AM +0000, Simon Ser wrote:
> Hi,
> 
> Thanks for working on this. Do you have plans for user-space
> implementations and IGT?

Note that these parts are mandatory, and there's a patch floating around
further clarifying what's all expected for new properties:

https://lore.kernel.org/dri-devel/20210706161244.1038592-1-maxime@cerno.tech/

Cheers, Daniel

> 
> Thanks,
> 
> Simon

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
