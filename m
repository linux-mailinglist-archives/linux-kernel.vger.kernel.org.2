Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F4430A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbhJQPdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbhJQPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:39 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1AEC061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:29 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id w10-20020a4a274a000000b002b6e972caa1so1088450oow.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tohhq9GjBIRiFZisCAGul8f6GOaUHV/TWcCmlpYmUvo=;
        b=pkGK1VT4q955FxLsrhUjurQISed4nnE8blaV+mES2eAK26E/bgQd1F3BYZhb6TIzWo
         O+/e+i2iI2GmKcX+56zucyKxOTQfIyrNwaa5JdTPtBD46na6DInqGSl9COzgsInVARlX
         bGnN7EoQbwECIy/0t+5P0D5qsKfG6Pltg9eHSrzGw48lhFXSrvMNNkZIjg1LuzSKGTIK
         lS8+Zq8V1DXon5NGlLH/PTs6cpJbnhl4uQi1xwZ14fmbQgW+lxC1CWgJP4NlhDkZHnNV
         ysrHT33Xe4XLZ4jj+aifvjNG62vXPVHCNxouCdF/3gQY8B5XfyAFR1gvSXDAsOFUVdXo
         E6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tohhq9GjBIRiFZisCAGul8f6GOaUHV/TWcCmlpYmUvo=;
        b=xe62QcWASx4pXQXeXz/zmMa0ncbSZdlE24vBHN/zmz2eiAuRnnkYK6FHO+2hS7yKS0
         aMMt6E4FVN46YanJc8HopomVqXSUFGhPSrX/9BSz5EVEjmn7ad/PAoZUDdlGYJDu25f4
         BfUSBlUgdkaq+hs9zzhccX47v8yROpQ03vTCP+KagIc+KaLbqXEP5RVW76MYDJBCLTgy
         dpWChLVQ7Me/IBMQN9Kt+wJfOtgDSGXf6qrIMMkh7J5xYv2ixg61HIrUww/aUCzG3zPQ
         ChiKMRuhCh7aOe1dqSTYKaQpB4ijrKK6Ov40xIFlm1K6ifLVGLewVcQvZoFhGFz1a93e
         XVvw==
X-Gm-Message-State: AOAM532fh8KKt8iwLAj31bN+y5jZjsI6tHTxhfNYZ7pfqvrE+zLCHrzu
        raAeI28R0qRQ99oZ064AkNFjpA==
X-Google-Smtp-Source: ABdhPJyUaUWDL3YryqrFgK/YXCTjKSmKfIYQYchEQqNVclxd744cCBvqihawoBLSD6wDppe7QH7dOA==
X-Received: by 2002:a4a:e867:: with SMTP id m7mr17509766oom.5.1634484689112;
        Sun, 17 Oct 2021 08:31:29 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH] arm64: defconfig: Enable QTI SC7280 pinctrl, gcc and interconnect
Date:   Sun, 17 Oct 2021 10:31:15 -0500
Message-Id: <163448466184.410927.13522565174969979342.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007052812.3717-1-quic_saipraka@quicinc.com>
References: <20211007052812.3717-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 10:58:12 +0530, Sai Prakash Ranjan wrote:
> Enable the QTI SC7280 pinctrl, gcc and interconnect drivers required
> for kernel to boot to console.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable QTI SC7280 pinctrl, gcc and interconnect
      commit: 88800cb25484ed6626a35e9019ea78d71aca09f2

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
