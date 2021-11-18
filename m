Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A20455240
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbhKRBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhKRBgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:36:51 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE16C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:33:52 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso8158509ote.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4b4P2TJUsQmMD7ulO5jskW7J+R4EF/1H7E16Fc7M+tk=;
        b=lwE1jNkaQ6vRIYJfuDg1xVkUFcf6I9dfnMdqvFzcLVB9aZRng6kzelTHzd9M2GegQt
         G+F6eYa/CXyot083R2bqXE1ZITf+EOHFfCrAuPGKm/iEJlaxBPzElDYHm+wER3E6nXcv
         QqgCD+3QH3rqwWIYqnDlyqizIZB5ODklXHB1yl8yC6wzlvc85IfV/gHa3pF6niOkuPOg
         HxMcizZ2Ly8ANIpX0OR0kYfl6gDnFmnCMPC947Qy90+zQ8QQMVjy1EhgvgLtTeaMoSgo
         VYorYBk3LxsAqqIAPOzJccXh6uOrl33XCXnN9hkWcP+AhMTXGa4aeeXa+9V73FGNO9bi
         PRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4b4P2TJUsQmMD7ulO5jskW7J+R4EF/1H7E16Fc7M+tk=;
        b=sP8zD2UT57oCH5VhMQSWKLIUi25btZy9b5JXz8zurnc0Ro+rfuZRsMBb6ydLk0o5/m
         XzWEsCghNemIweJuqcGcmvBg0rQnxHt1bnnVF1f1lbwbBwJPb5Ckk4YjiUrxEPgzRxM0
         Vmv09RuSJL78r7wrltSrPuUtmYPYpqT8y1aDmyyikXwplwgOOdW+Fjhf0nQunXmsepjk
         BkIdT4xEp22aIkqaGQ/cMzFtAI6M2lyZDGTI2kc/6hBoDFaWzXViABzFmhAyF2cLO7p7
         q7sKbSBzByEkmtbdPd0Ffzeh5EppgEgjvQpm1hXrUXt1IkB6O6IDWOhZTkZZfjBkgmP5
         438Q==
X-Gm-Message-State: AOAM531sdP9HEu7FPYWXqBXRzRqAWn0aJNPRQxQT/9X/MYcHgK2M/zjQ
        KEQjN+mV/3bG4uAa83l9bXa4EA==
X-Google-Smtp-Source: ABdhPJyAP0uCLZL43+mhZCRInEmazFHlxnQ7X8cjmMuZqDA2VCVNiYRJvwQ9Jffhy6a/v8ncNhEAsA==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr18065620otq.8.1637199231021;
        Wed, 17 Nov 2021 17:33:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm329745oth.81.2021.11.17.17.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 17:33:50 -0800 (PST)
Date:   Wed, 17 Nov 2021 19:33:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        devicetree@vger.kernel.org, robdclark@gmail.com,
        robh+dt@kernel.org, sean@poorly.run, vkoul@kernel.org,
        quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, quic_mkrishn@quicinc.com,
        quic_kalyant@quicinc.coml, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Add Display Port node
Message-ID: <YZWtfGNPAGtHOXZ+@builder.lan>
References: <1635896673-5841-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53ArJSYEAtLbc5dFrPspKhi3Kv=hpu=wS1TMsOWcmz6pw@mail.gmail.com>
 <88a5219e-c82a-87fa-6af3-578238d6027b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88a5219e-c82a-87fa-6af3-578238d6027b@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Nov 10:43 CST 2021, Kuogee Hsieh wrote:

> 
> On 11/15/2021 3:39 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2021-11-02 16:44:33)
> > > From: Kuogee Hsieh<khsieh@codeaurora.org>
> > > 
> > > Signed-off-by: Kuogee Hsieh<quic_khsieh@quicinc.com>
> > > ---
> > What tree is this based on? I don't see edp_phy upstream for sc7280
> 
> this patch is depend on  --> [PATCH v2 4/4] arm64: dts: qcom: sc7280: add
> edp display dt nodes
> 

But there's a v3 of 3 patches in the patchworks queue, unfortunately I
don't have this in my inbox. Not sure why, but looking at
lore.kernel.org, you didn't use get_maintainers...

Also why are the patches Reported-by: kernel test robot <lkp@intel.com>?

Did lkp tell you that you where missing edp support? ;)


Could you please resubmit the 4 patches together?

Regards,
Bjorn

> it had completed reviewed.
> 
> https://mail.codeaurora.org/?_task=mail&_caps=pdf%3D1%2Cflash%3D0%2Ctiff%3D0%2Cwebp%3D1&_uid=1789&_mbox=INBOX&_action=show
> 
> 
> > 
> > Otherwise, looks good to me.
> > 
> > Reviewed-by: Stephen Boyd<swboyd@chromium.org>
