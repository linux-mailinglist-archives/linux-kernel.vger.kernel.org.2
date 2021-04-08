Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D12358867
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhDHPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhDHPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB89C061760;
        Thu,  8 Apr 2021 08:29:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f8so2916198edd.11;
        Thu, 08 Apr 2021 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/fIHr4k/YCjJndbLMfAFWQ825CO5fXBFr+W4J/YOEk=;
        b=KeSEjnI3xQhjLShbl/Xj/CvT8KGfPMaPSq/CLq+oPKTB2Vh3gBEX8aqmBacMpODw2F
         ybOIcPaahLYHddplr/SlJ3kBfsdIviJaRoDn+4iTQwfl2TaGEje2ht1FErDYWLmXMiOv
         kF736E3CQ31QWuKUvCIdRZaYHHG2gdr7p+8M8yaT/2ReQMaDmQQz7eaTPnE4Xy9N69zl
         /W7wPLteWKgBmKMI2ob1X3y2ZxKH+2ohwMk2ViE3dk7MnjDL7G0dkXQEuFHmhISkWFNj
         r52oEnvo1b6b5QnyKhqWvyDlbkto5QYeNPkFTT+CSHYkhhh2Y4DCUjtvwJpv1QRiKs8a
         mK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/fIHr4k/YCjJndbLMfAFWQ825CO5fXBFr+W4J/YOEk=;
        b=ZJoO3rFEavPEcdatfHdp+lGJWsc9gBUSvptJd179z6ohO0Q0hYTVXTEXz3I9IddN1w
         GVAELiAf1aHwvbsV+DgmSaB3ZOtEEjSJslPWsF54XZpgX2i3knaE+G/Qcb4fwHY2K+iL
         AjjUWPkuhTVytKOpwi902TqPM/w0WdDfAc1//j7ZZ4IsvG2iXciEVpXFpWl30wOYBlDn
         3kRxCyVfktGsWkF1te26x0UBTaGn61wJXU70V9E7tjznwry03NMXhbbXT9d0ZKr8zaK3
         GUVR3/OPa1ENXign1TELJbsAF7mNuyRg5F/zwhgwOkyT2BkaX6mrna1ohksWFeSyBm6k
         Oyfg==
X-Gm-Message-State: AOAM533zaQ/Gm6WG/cw3GaLL+auUjAmiESrc3E0xJ1QbDlDBSHRgtt7u
        MgyYM5gDiQMBIb8TgPAajP8=
X-Google-Smtp-Source: ABdhPJyLvEMUDu77mhH43Jy889Nee9Niz6B50dCrxeIUMtn8HbOuFko9b/4/uWYnq9YgEEeOIPOJSQ==
X-Received: by 2002:a50:fd16:: with SMTP id i22mr12082023eds.239.1617895792874;
        Thu, 08 Apr 2021 08:29:52 -0700 (PDT)
Received: from test-VirtualBox ([87.116.165.76])
        by smtp.gmail.com with ESMTPSA id m5sm6719727edi.52.2021.04.08.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:29:52 -0700 (PDT)
Date:   Thu, 8 Apr 2021 17:29:50 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        florian.c.schilhabel@googlemail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: remove unused variable from
 rtl871x_mlme.c
Message-ID: <20210408152950.GB5306@test-VirtualBox>
References: <20210408120929.GA4346@test-VirtualBox>
 <CAOc6eta6ehHRhEYrWv0daS6WrC4oJg0Q8q2CB=K5BzF-E61jxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc6eta6ehHRhEYrWv0daS6WrC4oJg0Q8q2CB=K5BzF-E61jxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:29:00AM -0600, Edmundo Carmona Antoranz wrote:
> On Thu, Apr 8, 2021 at 6:10 AM Sergei Krainov
> <sergei.krainov.lkd@gmail.com> wrote:
> > No side effects can be seen locally or in r8712_find_network()
> 
> I am sorry to jump in. Sergei, what Greg is asking is basically why
> you want to delete the r8712_find_network call in the first place.
> Deleting an unused variable is fine, but the problem here is that you
> are _also_ deleting a call to a function that _probably_ does some
> things that, even if you want to get rid of the variable, you would
> probably like to keep on doing (and so the call would remain). Is that
> call really not doing anything relevant? That's what you will have to
> explain in the patch in order for it to make sense.
> 
> As a side note on top of the question about the call, it's not like
> the variable is not being used. It's used right after the call to
> r8712_find_network to check the result of the call... so is the real
> purpose of the patch to remove the call in the first place and then
> having the variable removed because there is no point in having it if
> the call goes away?
> 
> I hope that helps.
Thank you for clarification, guess I really misunderstood the question
and didn't explain properly why I'm doing it.

In this block of code call to r8712_find_network() exist only for one
purpose, to return value to the pcur_wlan. And after that we're not
using pcur_wlan.

So in my opinion it looks like a very subtle bug where we have unused
variable, which is allocated by r8712_find_network(), and if that
succeeds we're also modifying value by pcur_wlan->fixed = false;.
And after all that we're not using variable and compiler has no chance
of catching that because of what we're doing with that value.

Please correct me if I'm wrong in something, I just found that
questionable behavior and decided to send patch, so someone can see
it and say if I'm wrong or not. In case I'm right this change can be
_possibly_ accepted.

Also sorry for asking here, but is it okay that my commit has [PATCH v2]
and subject is [PATCH v2] in mutt, but in mailing list I still see
[PATCH]?

Greg, thanks a lot for reviews of my code you did in past few days, I
really appreciate that, but just didn't want to flood mailing list with
my appreciation only.
