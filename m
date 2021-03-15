Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFF33C957
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhCOW0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhCOWZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:25:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8058CC061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:25:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g4so21325446pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T44fMIb2uCjSZw2eFwBZbGk7b2xfr3szZxL9yxh1Crk=;
        b=UDFYG0atDDj5sSeX/1y7HUnb6dP8I3jqiuTsHf2tJmc3NEgWDdt66xTMLGtGK7ZH6e
         cKB90JZ4wo3mffuSgGBOAUAVYKvIhXwUMMC+fxwFRexVIBCkN1GsmvE4PxUUcE+kYlXm
         2LmxxTws6BTuypLzuKNCkDGAmwmxnbwIRHgvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T44fMIb2uCjSZw2eFwBZbGk7b2xfr3szZxL9yxh1Crk=;
        b=auhKNZmxH7r2dHbMk0DMDe5wx9GTJpp5uqSTkL1GVsGbZaRtWzum6aV/mdGuqKOjBa
         JL0fM3trLic3y1BR38HXrXhzEkg/QrQ2ZdhZJ850NWiR6xWRejt1qW6FvKgBFBYt7Eza
         A8qssVs2jD0NrgQdjo75JxosSZ0a7F2SxXr3rB9eY8U8+qlO9xxvMFU8u7fUWTyitfrF
         uPR6RQyO8o1kibN/u8YmiVJUJ4feOQgEPd0a0y71Cr84onVir2IaRrPSPx2bX8CBdMtI
         Fk0JV4QpcLB2bnqRoJZmRG2AVvqL+VWtZPtVkBRITB4NWTIaXafwb0KR++CienQ+8L/y
         064Q==
X-Gm-Message-State: AOAM530kJLPO/yC5124ppkfwUE0FjA4aUieBD61SO5UjQ/nYWv7ijxQD
        tizzkfcqi5ryyaZ/IbeBDCbRr208kBobRA==
X-Google-Smtp-Source: ABdhPJwMlr8Hw12OJ8YMycTNoY7l4zoBqghMVW2hRcl85cLDUW7/Q4+FYnn1MzCd3v+NeN4+ro3mGA==
X-Received: by 2002:a62:6202:0:b029:208:f11c:2143 with SMTP id w2-20020a6262020000b0290208f11c2143mr4611414pfb.32.1615847142099;
        Mon, 15 Mar 2021 15:25:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:9867:b969:5d4f:e017])
        by smtp.gmail.com with UTF8SMTPSA id y9sm628683pja.50.2021.03.15.15.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 15:25:41 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:25:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>, s@google.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add "dmic_clk_en" + sound model
 for sc7180-trogdor-pompom
Message-ID: <YE/e5AoydTeKCRtm@google.com>
References: <20210315133924.v2.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
 <20210315133924.v2.2.If218189eff613a6c48ba12d75fad992377d8f181@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210315133924.v2.2.If218189eff613a6c48ba12d75fad992377d8f181@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:39:31PM -0700, Douglas Anderson wrote:
> Match what's downstream for this board.
> 
> Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Cc: Ajit Pandey <ajitp@codeaurora.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
