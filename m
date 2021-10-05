Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178B1421B66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJEBGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhJEBGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:06:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A7C061753
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 18:04:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t189so24028430oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AD4ntWnk6xy141WJ5eSD3VNPPmOSSryVzLkskjX3TQw=;
        b=BlLMVXco8MKkLfoYVrWtbG6ZlSQ0rP8Pfgi4HI/royWJD9pexjRZi+sAb3wxSsZpjF
         u6uIpVHylQ4GkUNv39I1brHqxTOmYQEg73VySR3ZYzdSob/Svl7gqZUzTRLjkPX2g5tH
         gYxjGuWw6K9diz+BcdE0pqny5ByE+dBggV2Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AD4ntWnk6xy141WJ5eSD3VNPPmOSSryVzLkskjX3TQw=;
        b=3K5aWQgUwIJ2Ww3PkjZxuUK8Iuj3O5no8bgy+nGLXcqFd8u7O5gM0vM42vD+BMtXEE
         jUFSrW7fL4UY7nLJACEANnag0aR2MjQByp7wVlJMVjFje7ZmuSM39DgJs9p3/Gj/c0df
         vi+oWRLr3tJnO8TSQ+QyH1EDm2UzWyEhORU79gwIXYNT3dX6mu6GcEKfbRIQsoy8JSVy
         HPn59uiLmTdx5Fseip2ewpfEobpO9tSkXOZDF7bzH+fIXhMQFQe0/M7I6pKzbD5JITes
         1YL926Q5rX0BLALXPsmRzAGGygODy1iGh0NKGqKxLy2XImzJsLlhEnK+3HL8ahZ/1+ZG
         JqcQ==
X-Gm-Message-State: AOAM5332XSmUL/l+TN2mJi07Q02NebUrxIw6uA5y8PvKCPZnM8/9ye8n
        eH0ivfd7fCtnFzQk5z7VDAsG3Jmx2JQ8gGZJOe+1Fg==
X-Google-Smtp-Source: ABdhPJxcUdbrGerYfkCTPf/PwoSth3WvU4LBsMpt+DUDQ6/rOPEOVLhYZsKx1xZnQv15BKA9nAwgwS6G5Ye9CrwRt5w=
X-Received: by 2002:aca:3110:: with SMTP id x16mr240108oix.64.1633395864926;
 Mon, 04 Oct 2021 18:04:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 21:04:24 -0400
MIME-Version: 1.0
In-Reply-To: <20211001174400.981707-4-bjorn.andersson@linaro.org>
References: <20211001174400.981707-1-bjorn.andersson@linaro.org> <20211001174400.981707-4-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 21:04:24 -0400
Message-ID: <CAE-0n52bY27rZzarqrgjh37W3SsyvKTH70H++SmqoZOyETZKPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm/msm/dp: Refactor ioremap wrapper
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-01 10:43:58)
> In order to deal with multiple memory ranges in the following commit
> change the ioremap wrapper to not poke directly into the dss_io_data
> struct.
>
> While at it, devm_ioremap_resource() already prints useful error
> messages on failure, so omit the unnecessary prints from the caller.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

I realize this will cause some prints when we use old DTs. I suppose
that's OK though because we'll have more incentive to update existing
DT.
