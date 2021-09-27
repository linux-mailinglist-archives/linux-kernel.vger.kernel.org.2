Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C741A0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhI0U4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbhI0Uz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:55:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701ADC061252
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so26171104otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYTXXROp3aX1NMBycc9RzQt/DwugfKW9fQbKK8RPVXU=;
        b=Elq1ONDomvbqwYGRiMNWKFo38sox/+9fBdHYiS0MKytSylE2boKfeZOJIXu5SaEwV/
         vWgTl/MFejIwPfrRqBlfdNVZsrBglnvZ6jji4WnM7AglBsN+1IibLzLxdmmgg195yvUJ
         1aTdvQk+h+TnApActDXM1TspO1nxdLdW13+ve8K8wWcE9NNbLec7zyIP0cTrCPwt17Gr
         o5o85ESLYOsIbxBj5i0uSXwxsuqzZB74onnk3XKvE41zrLX6iUhYpHXHhk/zJH6y6mAD
         YQy31x0rMUo3T83ANnS8WxgR1NC6g6dXt2sRHT5fw08OF0evj9sFPzn1TCX14+Lc2GlX
         nZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYTXXROp3aX1NMBycc9RzQt/DwugfKW9fQbKK8RPVXU=;
        b=nKsVxDWCJIzHEPAClLr6fsGgcFacM8zyi8DYWEw6Zl0iVhsS2dCymp3AXukdD5MUfv
         KSLaTHxIljGq13pOnpG0VVXPerGcIpBuGl+YQMpl3QNXeGzwyEihO9N8eazirit/sB5V
         nt0mfRwfvuUFTFgb17Q59j3mwGaYxfb4DRxIjDfseBpIlXI03aFYRMl/27gxarOuManH
         NW9HwK5G0M+1sRIsyyDbFtWBEbPTjg9owTSqarzKYa0ThLna2b7mzazLEMJFZS45rkAB
         eDfrga1XDQauGv3qd4FDvhm6m2Dk2mUcpphoMSJjU+6pFl34T8qkQL9VwVs+8fNZyjR8
         hP8A==
X-Gm-Message-State: AOAM530QmitzC/Ncam3BhJci6GnS7/3A0EKqdPMVDqjsq+nXDhuYT1Hy
        fV2Di8j4DO38V+LsBUYEA9XkIQ==
X-Google-Smtp-Source: ABdhPJylw1hG+IliHWudtH3y6ImeBsXzTXmvhAFWa0/Y4yn708jVIqpWevArbxf+btQkP8T++8nnaw==
X-Received: by 2002:a9d:7284:: with SMTP id t4mr1760104otj.285.1632776047761;
        Mon, 27 Sep 2021 13:54:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z10sm4187275otq.64.2021.09.27.13.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:54:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, robh+dt@kernel.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, sidgup@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rishabhb@codeaurora.org, linux-arm-msm@vger.kernel.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, agross@kernel.org
Subject: Re: (subset) [PATCH v7 11/13] soc: qcom: aoss: Drop power domain support
Date:   Mon, 27 Sep 2021 15:53:58 -0500
Message-Id: <163277593826.1470888.2234978122972156070.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631800770-371-12-git-send-email-sibis@codeaurora.org>
References: <1631800770-371-1-git-send-email-sibis@codeaurora.org> <1631800770-371-12-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 19:29:28 +0530, Sibi Sankar wrote:
> Strip out the load state power-domain support from the driver since the
> low power mode signalling for the co-processors is now accessible through
> the direct qmp message send interface.
> 
> 

Applied, thanks!

[11/13] soc: qcom: aoss: Drop power domain support
        commit: 99512191f4f1dd4e0ad92e6f61ffe4d8a22aa3ba

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
