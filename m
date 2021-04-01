Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A53518A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhDARqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbhDARim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:42 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9062FC0225AF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:35:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c3so2577140qkc.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPcX6QtS7Ve6UUCNbDaDbB4vAvudpBUFG69ugXPs6T8=;
        b=AHguOOTFAO2NQe8XmSdmlyagtr/wB7GhsgTQRCF/4VWbWuMjMbDGipaw0RxlA0M6yR
         men4W9o7Z3lOPEhONt01til0PnMg/us3/Y7ioK47S+E3qh5tEsfAwsau3lssAXnET16Z
         y4UgVblAdat0wp63BW2m5H52N9VLE+J5QNlQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPcX6QtS7Ve6UUCNbDaDbB4vAvudpBUFG69ugXPs6T8=;
        b=LjCX4kNuWUoX8WAhwXO6mzwknMdRCtnlEbR5Qi8W7tKXmGJi4yhi5VBveGP5Q0FAd7
         7mQWeiZrIEk289y7pKcckiOdidVNXBC4kYoq4bVjrpWwuniFxkKVosdsS9NKHTR0HWbS
         +1OLwPNB8LwcfBrELvlRbjVSvoykj1eULtPz73viwb/ahHleXsAboMZgJfazYWkA4wf4
         MBm9I5USHMOpIpLI8qrEysN7FgxNucBI53CafI7mULM+GHglTttGwPNe1hOvqsg7AUET
         Nd0cFSeysefqfqSda1l07wi6qoJiZqMsg0ct6RwGjtQz1aoWh3rmGZa+qEcmv/i9X+Ec
         URyQ==
X-Gm-Message-State: AOAM5315t6bCfuRbFERtYp8NQ08eeCqfmYz2sUMLF+5cNQKZLhL73rVz
        2eqddfiGb5On9DbaMLQX2aOnqVMdCKn+RA==
X-Google-Smtp-Source: ABdhPJxPz85IAjVUQKJXYIVtT8ZmH+6XT5LrNmbO+5xj9ZilPhQrHrbZxdtM/EtyKlRKOFwacB0NsA==
X-Received: by 2002:a05:620a:15d4:: with SMTP id o20mr8861282qkm.81.1617291302689;
        Thu, 01 Apr 2021 08:35:02 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id q125sm4260720qkf.68.2021.04.01.08.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 08:35:02 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id g38so2178556ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:35:01 -0700 (PDT)
X-Received: by 2002:a25:74ca:: with SMTP id p193mr12383521ybc.405.1617291301361;
 Thu, 01 Apr 2021 08:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210331221630.488498-1-robdclark@gmail.com> <20210401012722.527712-1-robdclark@gmail.com>
 <20210401012722.527712-4-robdclark@gmail.com>
In-Reply-To: <20210401012722.527712-4-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 1 Apr 2021 08:34:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQoauA5kzmmj5ask_sK19mJycYLJfAOeriXsr2pvxaFw@mail.gmail.com>
Message-ID: <CAD=FV=XQoauA5kzmmj5ask_sK19mJycYLJfAOeriXsr2pvxaFw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/msm: Fix debugfs deadlock
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 6:24 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> In normal cases the gem obj lock is acquired first before mm_lock.  The
> exception is iterating the various object lists.  In the shrinker path,
> deadlock is avoided by using msm_gem_trylock() and skipping over objects
> that cannot be locked.  But for debugfs the straightforward thing is to
> split things out into a separate list of all objects protected by it's
> own lock.
>
> Fixes: d984457b31c4 ("drm/msm: Add priv->mm_lock to protect active/inactive lists")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
