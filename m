Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9813E41A0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhI0U42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbhI0U4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:56:11 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E5C061203
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:10 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 67-20020a9d0449000000b00546e5a8062aso26173768otc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWnZyTphdDZe5u0D1r/ElDTD3TO7HnP/sS1mclgplsM=;
        b=fIrR1pfST8fkgbklbWioDGRIIrCcLfA6m32qQgtV+7bXgkI7FM8F8PWFfNGYeufkcM
         eWEj2KutQsCq/omhkZIXGwjMyguBzuhnOe2AT2ueVxcxCAoIZ9xdwoRd4BwbC2W0x9KQ
         vcHzgnA5o73GgaU7Ssoh1F/p8jZ5QZ+0Td2SRCSLzxc4zt9qYAaaycWNfCHhPJva5Mnt
         FWVHVDCdwxMtuIxXjpjwcElXAddSl4YgUHOZjmUKBrgXGIqEVxLuU2eSo+WOrf1mqtb9
         CeOn+5gxhOlpqhbgnIVAtvtxamaIIWjEDKSZdYsEdsWY3Q6YcBvltD14DyPDs+beql9I
         +7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWnZyTphdDZe5u0D1r/ElDTD3TO7HnP/sS1mclgplsM=;
        b=Z8CKLJDgvskhfApuW85NG8xnbp31OtjfJdaDTX67KU0U5istvUO8CZR3Lk24vFa8qr
         lvkokFDZv6SJF94ObtgtzYaTPoRSwepD1NymPVXd4jLr5Ue8LUYlNZYysm/fWC6FmxEu
         +pnkOfuv0RfcUqCKIavovr8d/5YJrkrPwvfhbf/bTGMWHwXuLFhVzrg+Zxd1Q3kQkglj
         euvhNk9ujvSpv/4i8HXR86DNY2opuDbZ6AebLP+wH9MXYEcy19OkwojWTel1exzY6W5l
         jm7h4P5fFBmNK2bSf6MXtD9w8ROVl0NqC49DZSKqeHdD+uExa3wT0DcDm1t56LGi4vmH
         viJw==
X-Gm-Message-State: AOAM532SLdUbjXzgbTl2mPvtoO91gxibiI8l4fzmuFAPMgDMV77RqqJL
        8N/qvXM95tJVIoTUc/eAD0i+pw==
X-Google-Smtp-Source: ABdhPJyQy/YjQ2ajpYdAZm8ENqhdbf4HH3uUcOOX3tC3NDqP+y7F0PBDcsVw79yBZ+Y/7dOgvWzyTA==
X-Received: by 2002:a05:6830:4182:: with SMTP id r2mr1882403otu.242.1632776049751;
        Mon, 27 Sep 2021 13:54:09 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z10sm4187275otq.64.2021.09.27.13.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:54:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, robh+dt@kernel.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, sidgup@codeaurora.org, dianders@chromium.org,
        linux-remoteproc@vger.kernel.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH v7 13/13] dt-bindings: soc: qcom: aoss: Delete unused power-domain definitions
Date:   Mon, 27 Sep 2021 15:54:00 -0500
Message-Id: <163277593826.1470888.8272015889163734088.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631800770-371-14-git-send-email-sibis@codeaurora.org>
References: <1631800770-371-1-git-send-email-sibis@codeaurora.org> <1631800770-371-14-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 19:29:30 +0530, Sibi Sankar wrote:
> Delete unused power-domain definitions exposed by AOSS QMP.
> 
> 

Applied, thanks!

[13/13] dt-bindings: soc: qcom: aoss: Delete unused power-domain definitions
        commit: e603577231d4d041eceeaf23c25935df5d008798

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
