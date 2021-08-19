Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6233B3F1141
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhHSDKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbhHSDKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:10:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E97C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:09:33 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so6908645otf.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SsXVSz/26EZKyGqHQ3H98C+Z+vwznDQGFVyM/rcTClE=;
        b=oRLpRJvMBywHPqy3mP5+xHspefHDLfoPPXCmKMZGgiwYSxb4ZL7W+wPmesXjmhuXq4
         AHMRMRyApr/SLz/94iRdy7wm4mdQua7EX6AQuK2uiYcxmPERmaJBVr96U3E08hWWntYk
         lB8SKlcIKP9h+mB+Ozn/ywfXd7y+m7AIinh9qsXnJIFv2xRCxPs/vuME9ou1AdJrBJ9d
         NV2vuEaZQ+pgj3rt4MLAXaOLW0U/5ZXBMhUIbm5ZVF/PHNyuB3SToMWj1Ay5Q966V+mM
         QbIYlzPBNenCzZ550cq26p/jAQolvTHPkat/VGOigKlnGfhOVK9cjYdtBQjKg7mGJi+l
         0qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SsXVSz/26EZKyGqHQ3H98C+Z+vwznDQGFVyM/rcTClE=;
        b=qlVSYCtkH3EHHbyAxg4xjB4Z1o6XYFXQzHmax4NGNDRdpWqidObR0jsRf1uACTHmYq
         /Q49FS1y8kp1lR6XDuvzd31FXGa5+aBaGVyf/F3kZnpi4M+bxHag1oDgEEYwDa/Es00A
         AHLcUdSbEAKxE0Z/AoLGfXArZjSr51+j3fqbT7sMESYe9kMiwyZehfPhP7wcdUjbXIBC
         PUEy7F5Mx5mBbeLiGQPz65cYIQWzKuaCfjZWNLGNJVDLGHAy2mzLVt8ou+sxCpR6OO8M
         IUPq9WQhqfLNTc4JndZ6gi7Sk89inPVeyLozJkrebKvriSS/cb3wLzGEv2M2wQj/YrBV
         VWBg==
X-Gm-Message-State: AOAM533amKmxlUglFsv3lyUoknUUzPNubh5Iq4lf0dPTM92zqdZEGmoL
        cjNvDow/nj/NB+LMM3Aaxu0FlWgxDn7yxA==
X-Google-Smtp-Source: ABdhPJzUr7YNQNUEn92uuV9i+Siah4bxj2eJM18N02R01SKX3saiB6iP+BzbrB8LhTchbMu/QBzTPg==
X-Received: by 2002:a9d:4d90:: with SMTP id u16mr10046192otk.226.1629342572357;
        Wed, 18 Aug 2021 20:09:32 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j70sm449089otj.38.2021.08.18.20.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 20:09:31 -0700 (PDT)
Date:   Wed, 18 Aug 2021 22:09:30 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add SDX65 pincontrol driver
Message-ID: <YR3Lah3xSMnrfXSd@builder.lan>
References: <cover.1626987605.git.quic_vamslank@quicinc.com>
 <ae414345bf85359f38895b44cb53eeb82c4f8758.1626987605.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae414345bf85359f38895b44cb53eeb82c4f8758.1626987605.git.quic_vamslank@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22 Jul 16:18 CDT 2021, quic_vamslank@quicinc.com wrote:
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdx65.c b/drivers/pinctrl/qcom/pinctrl-sdx65.c
[..]
> +enum sdx65_functions {
> +	msm_mux_QLINK0_WMSS,

I think this would be more aesthetically pleasing if it was lower case,
like all the other entries. Can you please fix that?


With that:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
