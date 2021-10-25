Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5F43A56B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhJYVID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhJYVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:08:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B2C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:05:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t16so11578841qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqpOduu7lgR/ChCv8/UsQoSrvt3yOCf3GV9DkR2zoYI=;
        b=JsNgxGryTgPHPBzCVlCRUZhnAcCYoL+kYxE5k10qS4bOwqXVT850k1LCHnuJxNn1kD
         2TCFG5DtXky68M3MjKfrqVjqCyMWh4nHT21AaG4lqpE2oNKdu7f2X3vEMOeftBcELtkR
         BN8i1velF9pfuwqlqpxx/GIuxDVY+3W7wvDyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqpOduu7lgR/ChCv8/UsQoSrvt3yOCf3GV9DkR2zoYI=;
        b=2uHY+IjB7J65Ry/l/KdCuBB5Sd9oKAybX2WdmCfsoagdmfiotdomaZHRdxGT4lHoyy
         wMaabXGhRvcM49YXAa87gMNNBSKLn27n1XvjhG9Ix21jrOPrduaPcJ54gZIpsFu+Fb8X
         CtWhRCaLjD8ix9peX86nKy/qIvJ9viKVc3NzoNvWXwPd0r5N21a4xl3Ka/aGKRgg9qt9
         PqtM27l+mOLoNaQMIkA7+/J+xQR4psAab+M0jAV1JUy11rKDdN0ZDsaIWBT1vXV2UjoI
         gf93nuR7mD8YDbDM1Iq7xzG5GSlvRGntzAFB4DlzOI7uyvmR/CP1EG6pSBmA+zb+RBcY
         V7XA==
X-Gm-Message-State: AOAM532sME2CZZI+WJLuv2yxSoBvzCEBbGb/1OQdoeQlaS/OjDtxb5HN
        Thtfy17cVs5/Yd7Epe3d+IQtxcU6JcaYcw==
X-Google-Smtp-Source: ABdhPJxAZA+QMvMVKms/ShCvWP5QG1aZ3u8AOBzf1iEBfmOH3MwHdHzMs8NYawb3HvxuH/I8/P1zMA==
X-Received: by 2002:a05:622a:310:: with SMTP id q16mr20798346qtw.10.1635195938713;
        Mon, 25 Oct 2021 14:05:38 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id e13sm9232919qkm.81.2021.10.25.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:05:38 -0700 (PDT)
Date:   Mon, 25 Oct 2021 17:05:36 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: submitting-patches: make section about the
 Link: tag more explicit
Message-ID: <20211025210536.hlmkpjwf3nll6mlm@meerkat.local>
References: <cover.1635152553.git.linux@leemhuis.info>
 <27105768dc19b395e7c8e7a80d056d1ff9c570d0.1635152553.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27105768dc19b395e7c8e7a80d056d1ff9c570d0.1635152553.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:06:35AM +0200, Thorsten Leemhuis wrote:
> +If related discussions or any other background information behind the change
> +can be found on the web, add 'Link:' tags pointing to it. In case your patch
> +for example fixes a bug, add a tag with a URL referencing the report in the
> +mailing list archives or a bug tracker; if the patch is a result of some
> +earlier mailing list discussion or something documented on the web, point to
> +it.

The "for example" is splitting the sentence awkwardly, so I would move it to
the beginning of the sentence:

"For example, in case your patch fixes a bug, add ..." etc

Otherwise,

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K

