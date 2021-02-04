Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B630F188
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhBDLFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhBDLFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:05:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040AAC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:05:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so1916526pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2RNw7s2//NW2fuLIVh8/+sxVNgBPDxz0OVbkWuXi54=;
        b=RZbSgBHaHcjJIRofOjVczP4woy9u/6drflLi3xxVxgv1O6om63nzmN70vR1MWVeQSH
         53CuB506IzFVEf0j7tCg0jq48NX8tqFcBLwbuqWP4mSFj1O3rR+BzjJSsxmP6SMHFQlr
         OeXAeVvQRKQGyxOPmpCfSjLgEn/GSrkHL9+APHBlub1fTnoe4GtB0rfKnJTVPFfUYrWy
         AqngUFv0WeyCmnedkrmKULC1Mo5CDSxQSQUEWZLe4Kw2T6MXSsizqAajJPqISvDbaZAq
         eCbtFaxSIoMfQPXUd3D8s9F35lh3TcrcA/0xIc4hGSMcaoAvy3swJnyDspqsrjqKT6bF
         QshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2RNw7s2//NW2fuLIVh8/+sxVNgBPDxz0OVbkWuXi54=;
        b=rlLSUP45OpNOzBO/s4jN2dLNfcEZoKtSg/0KN1kSDGSm3aC1GgRmnRtAG73jaz7ep8
         DQF34WyE5iPKapwzUeeSDCilD+9XjCYUMDOVdIQeIx2I+A8S2qpdQIuI7uAOkgPhWAq5
         doddPwH8S2KN84CcQ4XUJQ2pduzaV6SwOvlldAO96dOgKspOWsDN8dGAs9uITlRx8At5
         rsr4ZzpwR/uYU8U+6kqM2/qbT3LE8FJqi8n/+A8DYvNvFFK1L3X1OzSosQY2zXPQYnaz
         So3WisCbca+S9H4ejdDj/v48y4N7gOzf4HU+0gLFMirJE1lWojm+T1PeUD88dK7xxSHN
         SIjQ==
X-Gm-Message-State: AOAM5317uqa3Y4+OKlbgbwpxAuBbbJmx4rj4r7GK/bbzenb9FchD90NP
        SkuJCTI57qqJxmia6fIxk8Eyww==
X-Google-Smtp-Source: ABdhPJwC+CYcqFcmOVXt6CNsz1zDmZE4A6ZI8MsaEyZmPPxuZGle7YyXqhg/X9w9JYz7PbfHJf/1oQ==
X-Received: by 2002:a63:e210:: with SMTP id q16mr8274104pgh.249.1612436710603;
        Thu, 04 Feb 2021 03:05:10 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y21sm5683143pfp.208.2021.02.04.03.05.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:05:09 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:35:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 2/3] PM / devfreq: Cache OPP table reference in devfreq
Message-ID: <20210204110508.xgl7drlubv3mhqm7@vireshk-i7>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
 <CGME20210204081436epcas1p2acb2b052090c18979c48f2c343f6b7aa@epcas1p2.samsung.com>
 <20210204081424.2219311-3-hsinyi@chromium.org>
 <876e4164-1d28-9d0e-3b10-28d62099b904@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876e4164-1d28-9d0e-3b10-28d62099b904@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-21, 17:46, Chanwoo Choi wrote:
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

I am not sure if keeping both Acked-by and Reviewed-by make sense. I
am keeping Acked-by as it was the latest of the two, lemme know your
opinion as well.

-- 
viresh
