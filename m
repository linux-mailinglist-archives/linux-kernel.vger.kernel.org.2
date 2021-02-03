Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABEA30D903
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhBCLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhBCLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:42:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75478C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:42:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so4894288wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cgpZfuZr2SJft3uC9lIbX9i8wXPRLzgaCvn6F6h99Io=;
        b=J7WV84daNeAoEl2OYeL+2PXNbxRoREoyuumU1bTgoBdZ2MGZHEmQyW2+YMOABFdynI
         xuUp+/emlPoaGjNOEzOXW8fUkNkFZCYOZasG7y/OehCzsShqOIb5Kv6tZQPUiYXipF0m
         FvA8SWbHevNznZMVy5u2u1eiyo5ps5FUXe046T6zJTyQ5m1vSye1dvq5gDLmgKK8omlu
         KfnFtQ2ELibWuv1V/d67BDkzzYuzFUzuHt3g3uyuc3mlb7nXnz99Ys5yuXBlugvCxll2
         n8S2ojS+0TIWAApjgt4ukDW6rhcBzR5JGdiOMrPwho2aWnWBiOVNMhjZvjs+HdInrE+0
         KQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cgpZfuZr2SJft3uC9lIbX9i8wXPRLzgaCvn6F6h99Io=;
        b=cIvtUB0dYd0rEcYtx5KRf5G+dZ+mt5Qymag+mWD1NZp+qzytzR1WGtyTLyddqnaKDL
         YV9kOICm4IHgLCg3wNNGgJXr5e8J8oUmuP097FxS04VNjhlIGz6n99Bog4vAEuVZAqPj
         3C5njqtAPevie9B6US42cxaNCaBNuesMUEcHkBoE+xZQ/oBY/E9j7sMcJQ+FnOLsJwLk
         w9NN7h8MLq5Cgoa496KSlxeQB4lkG/nJRhA/eu+B3TGM6ZIdPETBk4vBZa+dvSHpHX/O
         UcxHJevNzoQZOwt5logfnIxx2SU7P17SAdUfNqw9A41glf70TUfFvBWai7HMS/eyTSxl
         pRig==
X-Gm-Message-State: AOAM533s7HIV8yX8Mm5VDgr4UeXnzBEKxWrw3/z6wPKn5aXUW81drQP7
        ttEzhsm2H1JCfhckSKY4cgsyQQ==
X-Google-Smtp-Source: ABdhPJyNBeYILeVQnQ6x/pjaKcCiQpLKlGxAmpNNQG2sGdx3Bnxf8IZSS2NrrCMnLCEZR6FsrVTtRQ==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr2488809wmq.2.1612352551160;
        Wed, 03 Feb 2021 03:42:31 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d16sm3152065wrr.59.2021.02.03.03.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 03:42:30 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:42:28 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     FUZZ DR <driverfuzzing@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pcf50633: pdata may be a null pointer, null
 pointer dereference cause crash
Message-ID: <20210203114228.4tr4j6hxukayo4ei@maple.lan>
References: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
 <20210202092541.2wvzpe53mavrd47x@maple.lan>
 <CABF6pWFar726YKG9y_wVZoX9fd7DxBQce0AZKAibmmzU9qZpMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABF6pWFar726YKG9y_wVZoX9fd7DxBQce0AZKAibmmzU9qZpMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 03:25:49PM -0600, FUZZ DR wrote:
> Sorry about the missing description, I have a description at my local
> commit. But the commit description disappeared when I used git send-email
> to submit this patch.
> 
> backlight: pcf50633: pdata may be a null pointer, null pointer dereference
> causes crash
> pdata has been checked  at line 120 before dereference. However, it is used
> without check at line 130. So just add the check,

To be clear what your analyzer is reporting is a mismatch of programmer
intent.

In line 120 suggests a belief that pdata could be NULL whilst line 130
suggests a belief that pdata is never NULL. Your analyzer cannot not tell
you which belief is incorrect, only that there is a mismatch.


> It is better to write a default value to the register if the ramp_time has
> a default value. Then it does not need to return -EINVAL. It will keep
> consistent with the behavior at line 120.

I disagree.

You have assumed that line 120 is correct and that this code needs to
support the case where pdata is NULL. However eleven years of history
disprove this! This code is never called without valid platform data.

Therefore we should fix the assumption on line 120 by making it clear
that this code code expects non-NULL platform data. Given there are
developers working to eliminate this kind of platform data structure
(by adopting device properties instead) I don't want to make their
life harder by implementing unused and untested special cases that
they would have to reason about.


Daniel.


> 
> Daniel Thompson <daniel.thompson@linaro.org> 于2021年2月2日周二 上午3:25写道：
> 
> > On Mon, Feb 01, 2021 at 08:41:38AM -0600, Wenjia Zhao wrote:
> > > Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>
> >
> > There should be a patch description here explaining why the patch
> > is needed and how it works.
> >
> >
> > > ---
> > >  drivers/video/backlight/pcf50633-backlight.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/video/backlight/pcf50633-backlight.c
> > b/drivers/video/backlight/pcf50633-backlight.c
> > > index 540dd338..43267af 100644
> > > --- a/drivers/video/backlight/pcf50633-backlight.c
> > > +++ b/drivers/video/backlight/pcf50633-backlight.c
> > > @@ -127,7 +127,8 @@ static int pcf50633_bl_probe(struct platform_device
> > *pdev)
> > >
> > >       platform_set_drvdata(pdev, pcf_bl);
> > >
> > > -     pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM,
> > pdata->ramp_time);
> > > +  if (pdata)
> > > +    pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM,
> > pdata->ramp_time);
> >
> > Assuming you found this issue using a static analyzer then I think it
> > might be better to if an "if (!pdata) return -EINVAL" further up the
> > file instead.
> >
> > In other words it is better to "document" (via the return code) that the
> > code does not support pdata == NULL than to add another untested code
> > path.
> >
> >
> > Daniel.
> >
