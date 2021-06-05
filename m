Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CCD39CB34
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 23:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFEV2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 17:28:41 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33665 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 17:28:41 -0400
Received: by mail-oi1-f181.google.com with SMTP id t140so8474068oih.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=nDGVMkwUgwdjkEH0hG7ASi22La0UWmLtqIvR+gpN50c=;
        b=BTK1W0VgQTwdsUqPJC2JMeWQHe/oG0sV0uSI7t/AuJN4FhyLldkvR/V50OgZ1WkQ3Y
         E2KIBDbE8jzDxK1L8GQj9FHWF9sbHqjk03gw52+j1vksR4WcFb8pBAhOtA6ILoPRRF/5
         Fu0bRbfzhLXQVRZQLg4nMWzU19aRBMl0wGMo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=nDGVMkwUgwdjkEH0hG7ASi22La0UWmLtqIvR+gpN50c=;
        b=EWnUsOiXRW5iMkGaho+S2Bn8K1/bEWMk43wpb0PwCm0MC3rOZu3+gdmjBFsq5UmiL8
         2FTm3kharCHzFFV+VpqUz1PjfiQp786xfJpu5/LjgtSBVpGPEKhNlVfrph279/oaJPOs
         dXfDMbg5nslLV41cjzNvj0WoFAyimNePUXS9gptT+uKJ2NBOHJpITFYwj3dPTue9Q7P2
         miTuKJsZj+nwPPCMZZ5s7v7cjrJxHJXzTmrlF7mrz2O64Zpo2b4DyIb9zG0Y00FJFIQx
         v5w/M6dCjC3L6zx3l8DdXAWH5pYOE5Y8Y2+gD+lL8LUdmbDSRpL8lp4vfIPbfSpdWJUP
         EiVQ==
X-Gm-Message-State: AOAM533OmpMtqUzthXOjCvsDOeN90hu8NYE5wCdrp0AOzudZfE4z5NPl
        oIradm6DyFP4X43rI7iZqgPBHKKS0jhk2599Qz8+Ug==
X-Google-Smtp-Source: ABdhPJwqWjgtkV6EVmyoaOkoIT65rH0dn9l4jgw00hx1mo9ouL6X8MY7KOpfRx2AQCm8fVUEz37W3iRqokSQ23ETSXo=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr15519145oiv.166.1622928340013;
 Sat, 05 Jun 2021 14:25:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 5 Jun 2021 21:25:39 +0000
MIME-Version: 1.0
In-Reply-To: <20210605123543.8986-1-bernard@vivo.com>
References: <20210605123543.8986-1-bernard@vivo.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 5 Jun 2021 21:25:39 +0000
Message-ID: <CAE-0n513KEA+_5m=X1EKjnAbVVAeGXADqJ+S=Hs+E9cr7gEzJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove no need local variable
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bernard Zhao <bernard@vivo.com>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <groeck@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bernard Zhao (2021-06-05 05:35:20)
> Unneeded variable: "ret". Return "0" on line 880

But the variable is "rc".

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
