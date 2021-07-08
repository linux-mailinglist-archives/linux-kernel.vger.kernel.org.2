Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1737C3BF4D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 06:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhGHEih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 00:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhGHEih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 00:38:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA05C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 21:35:55 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id z18-20020a9d7a520000b02904b28bda1885so3148283otm.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfQ8PSVhuZ6L8Wdvtm/o1xt0WVv9JVjQWBs6sIfflpw=;
        b=czj3Bg3UkwAJ2FaKsXlvtboq/0UeWCjH+oJ7zB7j5BstzyX9WhzCvWnhb2S7es2gf/
         qDYrKfpA1nCggf6H1R5Bx6DWE5jMNvHeIiWuet8vmoUGB6t3+JsdZbQom+aQhFirYIlw
         lk5k94QPLJXXCSi9P3ZutSP7sC4+t6g39imBzZcY/TKdeDUEkg2AXjYD9zj1A5HLQgTq
         cvTYB9hlVkZ7VN9Rhg/HJtIrSoGMzVIjOc7YDQkNmAqGdyZgJrXTcAlbhd6Z1KWjNLVv
         odpNJfg1EFnQcdJFvXpCKm19UXyToFmeNmvTEf9KM7qSyLa3ccLHvJzQTl2ndJNgd6ri
         csNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfQ8PSVhuZ6L8Wdvtm/o1xt0WVv9JVjQWBs6sIfflpw=;
        b=G2SbMhPbuwKPUItHmZ2r5jjAq79syTrDjQIJtmKtSS3JufFhVI6cVK0/MttpMvpvWJ
         i+muE3O9cdW0XFYx8EbIv27PcagfzTsuukHPSMsZ2x41dGEUDE5ZAHnzuJirc/TEyqMo
         6bDc/d24ECXuOPl9xm7Tlyz6lGWwCXVqnnL0r3lm2hgpqLG2SeAKMpiWgQiXtdwvxYUN
         DYPpCv68OCgxJFNvGxorvh/RfA+JI/dcWP6S2kBXGPlhSdrVXDSmHprhWZIU2lJ8sOvw
         O9W5qqvqdvNzbpL0SR0IhtmFip7DzemJKp5gOZR6J87hftuv+tPUi+Hf0qOXE5jxPgea
         fjAg==
X-Gm-Message-State: AOAM531g5SvOUxkrEss1PX3uvaagxztynZLsvq0cgb/SYvBTkQaNpQ9G
        0UAEMo3ybCr7t28l1sA/XpJcXYmNKAU2tA==
X-Google-Smtp-Source: ABdhPJwGRenAwOfhQnQ3yXcVmV5j8ioSMHQoRYSsO/3D4uWIpOMW3epdehI1Q6E9f8QSvQueuTvkkQ==
X-Received: by 2002:a9d:634d:: with SMTP id y13mr22566972otk.294.1625718955094;
        Wed, 07 Jul 2021 21:35:55 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm325734oic.12.2021.07.07.21.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 21:35:54 -0700 (PDT)
Date:   Wed, 7 Jul 2021 23:35:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: rpmhpd: Use corner in power_off
Message-ID: <YOaAqAqldq3Hyiva@yoga>
References: <20210703005416.2668319-1-bjorn.andersson@linaro.org>
 <20210703005416.2668319-2-bjorn.andersson@linaro.org>
 <CAE-0n50EvG4qV0n+Ag+dvFxKKasnUzwH=MA+f-jsgDdBqaqziQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50EvG4qV0n+Ag+dvFxKKasnUzwH=MA+f-jsgDdBqaqziQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Jul 19:21 CDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-07-02 17:54:15)
> > rpmhpd_aggregate_corner() takes a corner as parameter, but in
> > rpmhpd_power_off() the code requests the level of the first corner
> > instead.
> >
> > In all (known) current cases the first corner has level 0, so this
> > change should be a nop, but in case that there's a power domain with a
> > non-zero lowest level this makes sure that rpmhpd_power_off() actually
> > requests the lowest level - which is the closest to "power off" we can
> > get.
> >
> > While touching the code, also skip the unnecessary zero-initialization
> > of "ret".
> >
> > Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> 
> I think this is why qcom folks talk about "virtual corner" and "physical
> corner" because there's the one in command DB and the one in hardware.

I think the driver uses "level" and "corner" to denote the two different
number spaces, so I think we're good...now that we after this patch
don't pass a "level" as "corner" during power_off ;)

> Maybe we should change rpmhpd_aggregate_corner() to call the argument
> 'vcorner'?

So "virtual corner" is "corner" and "physical corner" is level? I.e. 256
is a "physical corner"?

Or did you get the suggestion backwards?

> Unfortunately we can't really build a type system here to
> make this problem easy to catch with a mismatched type, unless there's
> some sort of typedef trick we can play?
> 

s/i/corner/ in rpmhpd_set_performance_state() would further enforce the
naming scheme used and reduce the risk for future confusion.

But we did just squash the final bug... ;)

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks,
Bjorn
