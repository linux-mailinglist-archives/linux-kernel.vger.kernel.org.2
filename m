Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475E3EEE18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhHQOHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbhHQOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:07:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:07:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so10158903otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjrWqg5iL7My1Sr03I7/kUapdaKKEVG8PdV3gZ9eQ5c=;
        b=UAdw8iIf1KQ4XcA+YoXbiW2WnCf0aZvDhdzhGq6fdomVH2hQy6KaDEj3vfMHfALYv6
         TQpDbwuyoIKzh3hHatjWC2nJf9moQprUZ2tg4YEEqzp0MgLOa9hAhk/tzSDVL/eHIa+K
         AoqUgTV2lsAhSg8mt9FbUfK2nAgufws5OC++v03zH4Mzp3nPolTqZYC17k2JCsBaqqp0
         1pNRlPEZhNBxqDufiX2TiEAwa48cot/TPWXIcOiSizQH6GGJhGjZyr4KN+nvPN8Ci5ye
         z/mFkx04yvnmll+D0yTg0FHXOYXHEYLG3QM7swAErrb+wfe6X7k42bqTVmBCJoYERvZC
         RSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjrWqg5iL7My1Sr03I7/kUapdaKKEVG8PdV3gZ9eQ5c=;
        b=O0OJ8VvjpCwEgO51TG6A9cBRxRvi3l5pRFlqh9N1vBd95a6pV4DCAjHvpmvPGZ+9tE
         9BEckRSlJNvV0vwc4A1fXJnAtKQY3ZGHJIJQ/M6jnoXqHVo402Vagw56Q8EdaHpi/IMn
         Ch8ln18DwUyavdunLL5R6Px91A5qFG3/0R/70YS9m9ri7kvCNR+HcYwTq2EUgC3ZXf2q
         Inf0+dzDKxbrtLhzRMy8eKctFV85PggMwL8kUQohDGShXH5axJm1NfMELz+SrjnoDp0s
         tQ/Q4bhmxwGNl6KFLiY5s95hUaJoLkfmG0h39qUHhMjD6ow5s0TF2OY46GfwOik6RBLx
         pwlg==
X-Gm-Message-State: AOAM530UqtMPkBzqdlh5s6mRb04KtagFCAoY2OaXzlU2JMpthY6ZMTtG
        iZNpZe0n4qWAPPI6E9dqbJhl2Q==
X-Google-Smtp-Source: ABdhPJxgbrZTySfGDM1CDSbpZKb3negyXgjIKPfl8i3ksWXyLl4lrCduMCUTEPkrjtnienG26pp+7A==
X-Received: by 2002:a05:6830:110a:: with SMTP id w10mr2663999otq.291.1629209223152;
        Tue, 17 Aug 2021 07:07:03 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16sm438399oop.3.2021.08.17.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 07:07:02 -0700 (PDT)
Date:   Tue, 17 Aug 2021 09:07:00 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        rui.zhang@intel.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        robh+dt@kernel.org, steev@kali.org, tdas@codeaurora.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [Patch v5 1/6] firmware: qcom_scm: Introduce SCM calls to access
 LMh
Message-ID: <YRvChF0j2NOsDuK3@builder.lan>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-2-thara.gopinath@linaro.org>
 <19659756-4716-4c5b-949a-58d362dcee22@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19659756-4716-4c5b-949a-58d362dcee22@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17 Aug 08:17 CDT 2021, Daniel Lezcano wrote:

> On 09/08/2021 21:15, Thara Gopinath wrote:
> > Introduce SCM calls to access/configure limits management hardware(LMH).
> > 
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Hi Bjorn, Andy,
> 
> do you mind if I pick this patch along with patch 2/6 ?
> 

Please do!

Regards,
Bjorn
