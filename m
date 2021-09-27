Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036941A0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhI0U4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhI0U4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:56:01 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8DC06125A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso26117841otb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDdeGJOBBJPnUr7VImnSEIcCMtCi0Ce10ZXN5bmYag8=;
        b=atM9FD1vLwjuKqF62GySXevVlnqo9c+vQYnDxHviTkENroRpn+dr/wBJ6XMioj2r/h
         y2BYQ+N28ivFUzbibJbideDg2LAzovo8LBQXxUsvJs6a43cDTNOrj1E/DlXL4LbWwz9Y
         oVeLXr6SKEkLZhi3XnVHgsTCw0XYDQhy2fHo6zpN1IVt9td6sUKk6vOE6IN5CT82q5H+
         mC0x58QEWBpj4sNIY7HD0xLBHJje11R3jyl7XJoKMspASXvMUx+ia/a3nVfDeMnl/j0i
         EvfJce0uu3osOam1x6Pb+KPlTfpPbFkzxl8vSUcM3/gjLw2LjuzF8QWuAYI3XW2dsl/Y
         iiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDdeGJOBBJPnUr7VImnSEIcCMtCi0Ce10ZXN5bmYag8=;
        b=c8XE0QDoyZmGn7b8VJDuvdHfi5WDphX3Yva4LS+o7PaRVFGtiEF9FlXN8D2szs2Qpo
         5SD8FXqlVfqfDRnGgYAjs3jWkCBMrnYufkGQWzjirtLZY1VJ7RsU2FjFbEFwfr9r9BpK
         YF6OB0RKF7paCSPOYD4B7sop783yLXYguZAJTnr/cJsi8fljT3huuXDbh67CeXD75kpj
         xh0TeuaaXR34MovVZmk1PQdtLn39sjZkYk5UUgn85QtgvCCEojMdyh/dcoe5iDIk3xV3
         dyrlbgdihiYMZ6qiNdTEw9AWzFrJqGlxZTNaE+5aAiJWDxIrM4x3ejsTwN2BT5fUjTXl
         MXqQ==
X-Gm-Message-State: AOAM530e+ah5oGup9UiDbrQXBhm9ftHITTWOgJ7yrm8Rwf6iQ6XNsjXM
        pILf7m8xe9HEf2FUrqIbeh2iSA==
X-Google-Smtp-Source: ABdhPJx9/naDlVpyGLpe7FwzuSBOEDI0VynLTTxXxV9kV7yuqsfIfcaBlRc8XBGMhyFgcBE4DmSAcg==
X-Received: by 2002:a9d:6089:: with SMTP id m9mr1880131otj.64.1632776048758;
        Mon, 27 Sep 2021 13:54:08 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z10sm4187275otq.64.2021.09.27.13.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:54:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, robh+dt@kernel.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, sidgup@codeaurora.org,
        linux-remoteproc@vger.kernel.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, agross@kernel.org
Subject: Re: (subset) [PATCH v7 12/13] dt-bindings: msm/dp: Remove aoss-qmp header
Date:   Mon, 27 Sep 2021 15:53:59 -0500
Message-Id: <163277593826.1470888.9821309633445465547.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631800770-371-13-git-send-email-sibis@codeaurora.org>
References: <1631800770-371-1-git-send-email-sibis@codeaurora.org> <1631800770-371-13-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 19:29:29 +0530, Sibi Sankar wrote:
> Remove the unused aoss-qmp header from the list of includes.
> 
> 

Applied, thanks!

[12/13] dt-bindings: msm/dp: Remove aoss-qmp header
        commit: ec908595825ce84fb40e94a68b378f13c65076af

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
