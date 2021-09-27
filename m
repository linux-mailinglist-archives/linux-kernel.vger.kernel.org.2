Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D941A3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhI0XPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbhI0XPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:15:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74AC061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:13:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so20917576otb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVuMZMqVV04eQ3Tb7rVw7n5uLN5vqLDGlsaVhkH6vzk=;
        b=oVP0g4qMd5qWo3M3F1aW6UU+Ws0NL+zn9GuNUtkm6RsR4uqiTMi3g3YqRTqyptXGQC
         vAITBe77HANeeI+WXUGpLn8e5rMaxWhiWaKHudhs27TGC2+x/U62jU1zzX79Qo2ngNTN
         Ht1555PUyM6wUfdasdj4CFh/JvAkbVKg7wEYwlD2LNHN3MnPdKvF1cFJwsIItnIS583L
         /Lir38FwWD6RWFZ9c6NEec8fwYR3/0fuS3uHDTgr7DtR14esDfjiBKvr5UKkDbmyDQPh
         t4ZOBFZBvIAYO7YsfA7ObZUCNAPj26+6LoqvyO43V0HD1MD06PKkGAHJgI9tzF84EztC
         BibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVuMZMqVV04eQ3Tb7rVw7n5uLN5vqLDGlsaVhkH6vzk=;
        b=CzWr2Y07nnr3wpIzkH2/bOZMOUfuUUL2ovhTcWUh5x6W7eek9rWYGcJpiZ+ekUobrg
         9pfVJU+eqozeEo9WTWhByqGcy7GwdnYRAZWH0RfqvqB9DhnDRZy9CpGozfSWhiJEI6WO
         Xg5TRpB6gybFP1RnI6bhwUlqqwbuEBWiy0CoaL+1DuZ3R3L3ZkZUreivp0n0ZeO85XO4
         5gP36yDU3BM+fMIV6t9kZd07eyzm530eJdlQN4GM0Z4oecR7QqlORNFshV1cfLZ10C7C
         u3RRLtdZemBSbQcAMhktppIm3tQBAzc+iEe67GRebTxS1sgxYzmeBLvrf1RKVJPaPW1h
         vbSA==
X-Gm-Message-State: AOAM533rBy+Nt3P2IxUpJJad8t7K8amD3KvGn1uQCzG70p1SShKPm7Q7
        mMD/JsLPjoP0gpU9met7Gs6sIQ==
X-Google-Smtp-Source: ABdhPJzaEwRSbrKNt2Ihwn79FZaMrmiL6jA1t5+oKfxg1X5E05wzeb3V31yxVtzsdzgCZAQLTBqEkQ==
X-Received: by 2002:a05:6830:12cf:: with SMTP id a15mr2283847otq.296.1632784438533;
        Mon, 27 Sep 2021 16:13:58 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p21sm4162268oip.28.2021.09.27.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:13:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: (subset) [PATCH v2 2/5] remoteproc: qcom: pas: Use the same init resources for MSM8996 and MSM8998
Date:   Mon, 27 Sep 2021 18:13:53 -0500
Message-Id: <163278440375.1524647.6708298654473355392.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926190555.278589-3-y.oudjana@protonmail.com>
References: <20210926190555.278589-1-y.oudjana@protonmail.com> <20210926190555.278589-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2021 19:06:22 +0000, Yassine Oudjana wrote:
> The resources for MSM8996 are missing power domains, and adding them
> makes the resources identical to the MSM8998 ones.
> Rename msm8998_adsp_resource to msm8996_adsp_resource then use it
> for both chips. Also add power domains to slpi_resource_init and use
> it for both chips.
> 
> 
> [...]

Applied, thanks!

[2/5] remoteproc: qcom: pas: Use the same init resources for MSM8996 and MSM8998
      commit: 0e235460be2e8c9b08e567c839641395a8ca68d9

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
