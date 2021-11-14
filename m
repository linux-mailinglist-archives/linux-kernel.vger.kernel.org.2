Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3F44F9CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhKNRpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 12:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhKNRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:45:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C62C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 09:42:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so61264835edv.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpEU5W9fM9uUVputwI2dthK1R1N2dgY5w9BBuptA+Sc=;
        b=gUfny8hjPYP1FEGMwIPomSxZAtuH8z6Ff4PAyQPVy6dNS+TQpINAkJs+JrJ8DC5bR0
         ZFAZGNCXYoscJ7Mb7/N5GnZ31bfW1HdvZstDcllHeHL2sLrVoEGRGJ1sfEC6V7189Lq3
         FrH2et+3GkYXHjzZXLnI5IBrq2u6twWB/Cjnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpEU5W9fM9uUVputwI2dthK1R1N2dgY5w9BBuptA+Sc=;
        b=eW8ohufKFq1H7iu0w2Rj218rGPbyxct03a3Wq1WUcmQaTHcnFcfTb67Jli1g2SUIbk
         sSByhUIcKLDf20zAfGh5AnIIHfnIqQG2EOtU72m59J0zAnwCi/pw+VylUktbFawLKzlC
         /MP+qoD6kLoWmSnMrKH1B+lRVAE5czXrOExERQEuds1pTdbpfo4bp5VM2Nbn0DOPsH5e
         k406HqDCaogXdzCXt2hak76J/fBnm30ZssLXoks9i/LKn7BI90Zas+4TDSiilsh+lZgo
         0awxf9M2nlX8mwGHraGpP3y++TJMFLsWd/szpMejZBzzDw2EsR44u/qiIgZIG+R/rM68
         3QZw==
X-Gm-Message-State: AOAM532EQ+jNdCR0iUZoXJVGmqi/DuKBsSptmktq0mX8i0FMyaZJo1KX
        wOvjipAY+cX3HEK+9teqoglJ1iq+kdn0l1sefkk=
X-Google-Smtp-Source: ABdhPJyrVcXLZFYoopKjQ9pvoofNryxrxDGTTAvf06Y6ls4o6CqYHPY3oT133I3vWI/wfTeO2NrEUg==
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr45952884edd.347.1636911764187;
        Sun, 14 Nov 2021 09:42:44 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id t16sm6258942edd.18.2021.11.14.09.42.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 09:42:43 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so10661592wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 09:42:43 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr35436818wms.144.1636911763086;
 Sun, 14 Nov 2021 09:42:43 -0800 (PST)
MIME-Version: 1.0
References: <YZDxFAYjVp2nRteh@zn.tnic>
In-Reply-To: <YZDxFAYjVp2nRteh@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 09:42:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMYyYUsMC8kMkCUvAnq3usC98Tw9_ogkznS+2anzvR5A@mail.gmail.com>
Message-ID: <CAHk-=wiMYyYUsMC8kMkCUvAnq3usC98Tw9_ogkznS+2anzvR5A@mail.gmail.com>
Subject: Re: [GIT PULL] sched/urgent for v5.16-rc1
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 3:21 AM Borislav Petkov <bp@suse.de> wrote:
>
> - Avoid touching ~100 config files in order to be able to select
> the preemption model

Heh. Too late for those of us who build our kernels during the merge
window who now end up seeing that question again, but I appreciate it.

             Linus
