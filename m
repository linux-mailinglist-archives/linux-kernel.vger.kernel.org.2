Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B97345410
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCWAo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCWAow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:44:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:44:51 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k24so10002097pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8gpi64cF5kMqHz3hWfTceD8Btp88LPr/NRXUKhPFF4=;
        b=CXioe6b1M+1aq7DUqGgQaLVdOVTx1QCdGwVlhwACkO2U4bxW2H2coUT0nWGKIRjMjg
         jv16UOvWPb9/Pv2CCS+qlg3bPzaIcAFV7Ryi2ZPoGgM3DwKmt2k+OXEvKo+ydhzVqigl
         /inSRofnWCoaKr9xOgBl46MR9Ljx/zlUTpfjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8gpi64cF5kMqHz3hWfTceD8Btp88LPr/NRXUKhPFF4=;
        b=BgR+0VEOwNLRO+jW7YI3Qb4kxBDr8ALdUqBMJ0BQXg1SU2cG5MO2iWXsBRPxO4+FSW
         JEJ1QU4OipzFRSU09aGMojUswqprstjx9BigqCJoEJC84EM690wgrt+gTp8kEbsszD4f
         5EpOMsIKwqZzdCfYOvPvSkrR2Eatf49+Y60qxpoDt4GWvGygiPbUkOMZ/NWILamqT3aA
         UWVKU366N24QPDizPHqSYZY7VPSxUNaTAdOqW5XwvKOoQCT4olZ/3LWsDBAU+xtJXZ8s
         8xxotS6B1x3aq9J60M0NJ6Eo6LDbTuyJVtw5K3efv43dhjijlQXQmuXNEoP54B/hXoMm
         gPqg==
X-Gm-Message-State: AOAM5338c7WNyNwdyGaI0MAQSXz6TlwNkcJ8r7lRFySrZGgFhf2Rwyuz
        0DyIaW1FxyTkIp/G/aMiYSnGRw==
X-Google-Smtp-Source: ABdhPJzHtPrfpHQc5JKj7moe1xvgB+smMUBy6BwiKJlLPq5/nDwAlK0lytfkgPQu5ie3TTesgd8x6Q==
X-Received: by 2002:a17:902:b781:b029:e4:545d:77 with SMTP id e1-20020a170902b781b02900e4545d0077mr2354442pls.59.1616460291364;
        Mon, 22 Mar 2021 17:44:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:90a9:b908:f93a:2f78])
        by smtp.gmail.com with UTF8SMTPSA id y66sm7338467pgb.78.2021.03.22.17.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 17:44:50 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
X-Google-Original-From: Matthias Kaehlcke <mka@google.com>
Date:   Mon, 22 Mar 2021 17:44:48 -0700
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, Kalyan Thota <kalyant@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, mkrishn@codeaurora.org, hywu@google.com,
        midean@google.com
Subject: Re: [v1] drm/msm/disp/dpu1: icc path needs to be set before dpu
 runtime resume
Message-ID: <YFk6AINTcg2S6vDe@google.com>
References: <y>
 <1616404632-13693-1-git-send-email-kalyan_t@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1616404632-13693-1-git-send-email-kalyan_t@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:17:12AM -0700, Kalyan Thota wrote:
> From: Kalyan Thota <kalyant@codeaurora.org>
> 
> DPU runtime resume will request for a min vote on the AXI bus as
> it is a necessary step before turning ON the AXI clock.
> 
> The change does below
> 1) Move the icc path set before requesting runtime get_sync.
> 2) remove the dependency of hw catalog for min ib vote
> as it is initialized at a later point.
> 
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>

Confirmed that this fixes a bunch of warnings at boot on SC7180 when
(out-of-tree) camera support is enabled:

  [    1.832228] gcc_disp_hf_axi_clk status stuck at 'off'
  [    2.118292] gcc_disp_hf_axi_clk status stuck at 'off'
  [    2.442383] gcc_disp_hf_axi_clk already disabled
  [    2.750054] gcc_disp_hf_axi_clk already unprepared
  [    3.154835] gcc_disp_hf_axi_clk already disabled
  [    3.421835] gcc_disp_hf_axi_clk already unprepared

Tested-by: Matthias Kaehlcke <mka@chromium.org>
