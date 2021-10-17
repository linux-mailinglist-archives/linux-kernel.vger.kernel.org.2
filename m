Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B5430A2E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbhJQPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbhJQPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:38 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF440C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:28 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id r1-20020a4a9641000000b002b6b55007bfso1190638ooi.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RwjU+xMTKwnJSdI/ZvJQg7RwuWcVuJ6qT981afubY4=;
        b=egX+4knf0mp/ETZTK2SirLB3Yfw0qsJSNehObIg6sfzDYPQbuoqNBGkHo/t8BvRkBH
         BNmd7KPPih+yWo1dXRep1zuymIv4wibMQj+So/7GxZo6WIa8zeOxAckauTcDxlPVoWeY
         xiMu5Q5xJqAmk9T8MQDkvadxZlMUep71BHIAt3RdPm6NYWW0CTQ3PwvvpGWZ30aZpziq
         LSCCpp30OTH9wdYXXxx1EfKkBh08ux2Kqc+5v7WJbCMfFawiUXJlOIkhAzSXrAHMw9kM
         UzoOv/qpPeK3706UZgD7KoaXUe8caBeqKNN9fcwwfJbluZkyNmlGn6AL1yEbGmx/QFuO
         YZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RwjU+xMTKwnJSdI/ZvJQg7RwuWcVuJ6qT981afubY4=;
        b=jH+nueka61k4CjTeg6VXLXFNrnT8H8eViJ773fwi+4PimlMBVZGD1CDxm5bX9vgIeR
         a6GVRKbANEWu5pc9fEf2knd5SyHawRu1J2XmeCmcr8l0N/dIxGw/7O9V2e6ZSDA2yQ2j
         JlXVYSKCkXQWFYi2yg3A4p2xMMms92RlJgxqwQYzc8Rx00jIt/WcjZftcNPWyc0dcnPG
         cCy22WEnbSfFVlxYWEXygv5l+vkirjULXj5hHaNuZUr3TvhSOchPH+ftnDcI490dAyeG
         UeXy3Qu3lwN+fo04Lb4aM5/QOAAtVIv8rWtYSw8E5TLupPAdBOvRzT4rA4FBLy9SGTSZ
         NAHQ==
X-Gm-Message-State: AOAM533Nhkb3Pmjp07I+Dfo/520nErLalUaW2JTK+BOjC+ulhX7OAsPP
        ib5xkT2mkxyeb+VP3vN7rI0vFg==
X-Google-Smtp-Source: ABdhPJzHDaDBSR9eIppkqcxxm46japDYxXj9RAds0rnAM9bYXyGg9tFLS+fndIqSUyTv2Z3E+mxSGg==
X-Received: by 2002:a4a:e9f0:: with SMTP id w16mr17707836ooc.3.1634484688160;
        Sun, 17 Oct 2021 08:31:28 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Philip Chen <philipchen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
Date:   Sun, 17 Oct 2021 10:31:14 -0500
Message-Id: <163448466185.410927.18392226904278200617.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211008113839.v3.1.Ibada67e75d2982157e64164f1d11715d46cdc42c@changeid>
References: <20211008113839.v3.1.Ibada67e75d2982157e64164f1d11715d46cdc42c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 11:39:34 -0700, Philip Chen wrote:
> Factor out ti-sn65dsi86 edp bridge as a separate dts fragment.
> This helps us introduce the second source edp bridge later.
> 
> 

Applied, thanks!

[1/2] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
      commit: 4537977a50e6257c6c19db925479298c19822667
[2/2] arm64: dts: sc7180: Support Parade ps8640 edp bridge
      commit: 0faf297c427372ad2a02dc28e6d1327825031882

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
