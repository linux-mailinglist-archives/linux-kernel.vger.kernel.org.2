Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047223AFA19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhFVAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFVAKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:10:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58064C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:07:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v7so15511653pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cEZ2B0/VxjehmXDHG4+9ccmammhIbJj7C/0nukp4rN0=;
        b=TEZqtPQoDr5M/38Kdx4v+LTnR6iZmtN2PaeBsW34PV5K8OuwMaDRjodD+QhbC3g6wA
         c3rPjJK9VRM2TTgKzBz2/5MRrmVdO28n/pyBGMOtYpmDPWjF/LkXF0MIfPU+Guo/9+vc
         vs72ElzBPj6G2vfbZIddOiMpTQJofVM4dgFUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cEZ2B0/VxjehmXDHG4+9ccmammhIbJj7C/0nukp4rN0=;
        b=HM4SF63l13xTbxbV6F3bNr/36VeearysFIzxun4Z1jzgLXrwUXwFRzIgsoiR7vWKnQ
         apJ1+LcqcIC6oGU/BW/8uof3wB3cLCccyp00LU2PvzYZb4W7wAouZqquUz4coFL+hskh
         DDXWZpfMGG+1DShQXLw+Q5INdRU7C527cWCRp0jANPb005zbdHRTDCFeNKgispWOw02L
         BRD+aWSddR64PeEAp2+iSTzDlvNnbIN3zdEZdOdssGWSJkHXQ/xQhSdJiDUDpLJhTrQb
         JJE+QwHtsX1xqUZ/Lv/Jbp9aaToW2YO+z03SqjGous1v1A5v6ge7IlP7092GN5WzA88U
         pItg==
X-Gm-Message-State: AOAM530xH76arCeQj5p+/JxQIML+yQB8hPIqKKNKKgU4DU1TY/B/yE9I
        qNYKQbu2XyYsL5lCz5xWC+9CGA==
X-Google-Smtp-Source: ABdhPJyIEERW8Z9bugjAaYkJE2XC+IsIIQNSIjl9wYtNA/TBpGkKu1694BD7NR/9teqcWiB6ZH8GXw==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr985871pgt.307.1624320471927;
        Mon, 21 Jun 2021 17:07:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9f0f:4fd2:adeb:6f55])
        by smtp.gmail.com with UTF8SMTPSA id cu4sm290845pjb.40.2021.06.21.17.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 17:07:51 -0700 (PDT)
Date:   Mon, 21 Jun 2021 17:07:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        okukatla@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: icc-rpmh: Consolidate probe functions
Message-ID: <YNEp1kTcsqRs39tj@google.com>
References: <20210621214241.13521-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210621214241.13521-1-mdtipton@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:42:41PM -0700, Mike Tipton wrote:
> The current probe/remove functions are implemented separately for each
> target, but they are almost identical. Replace them with common
> functions that can be used across all rpmh targets.
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>

Good catch, the code is indeed very redundant.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
