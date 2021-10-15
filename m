Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1D42FA22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbhJORZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbhJORZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4CC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:26 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so13736419otb.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QjqbZW56QF6+OwRmwUlYOhG2CZ9K1YswtZnwatHW6g=;
        b=S+MgA2Fb3WTji+feDAFyOpwuzNmJT2S7RiMZEZsEl2VbXCwauubouZzc7ztcUMvjXB
         3wfvMS2z/Yx39lj2ho8vwpLh1tF/dkJWCXiRJzqqs4yEY860u3jSeyBm9vaFNO5YMDW9
         SWT4LKMUkYSe9i5fm0256gvhBiR/+isbUL0CcH4hkIkLqi/h/la3eQQRbtRskV3u30o4
         oALaMvmQ7eLmfWoYatfOdEuCPwoaxJZ7I6POucA8phtugQOeDWCa8mk16JqRl/lSQcAX
         RFXzD2WFY85sM1WZa6FvcIfto3KRtDWc6IAOgRGKItnXu+5EFFdJY9xDnSIll1BkTTla
         vgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QjqbZW56QF6+OwRmwUlYOhG2CZ9K1YswtZnwatHW6g=;
        b=j83VFMm7Rbzk5U8G7ki1MoGmKgLgqYnJs/a1zzTXzdhap9esUUIDjzRy9W0cyR0uJS
         O0R3FAKVYC9A0X1wjcbFs5TivN5MfGDeI7RHY0rYYnQJnpqVXBoYk2KNrQWfY8pfvsU7
         a7MnG1el9yWCCUUbGfbRdO3WV4P9M4nQtJSJw30iII+jQMrw5O3QJyfkaPDcg0Te4Nm5
         G1tpTc31SQrGWrhNdCRoJuSF50t0p8w+lCpI/J0H78O5qTaWpW8pLe/g/QmS8PGoolPw
         7VuvCv0Fa7f54T1vqlrl3t2xy/ipkhX5dnwzs+NwJ1CtPjodnm2Jpj1iSGYitblenEDq
         3yhQ==
X-Gm-Message-State: AOAM531YFjRMzrBPbHYzgFRv3pIUP3s6sA94Ct/h8sKXiGRFVQ8bz1ME
        YrQ4IlxRehDDnRYIe1qf341V8w==
X-Google-Smtp-Source: ABdhPJxCsbFyOPN3ydHCJ38rsRvlUCfgrnTgtgkl3SXd1Om9F2DWWP1EcVyhmuneq5ZY3HLi+bDdvw==
X-Received: by 2002:a9d:6088:: with SMTP id m8mr9267229otj.214.1634318545468;
        Fri, 15 Oct 2021 10:22:25 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     clew@codeaurora.org, Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH V1 3/6] rpmsg: glink: Add TX_DATA_CONT command while sending
Date:   Fri, 15 Oct 2021 12:22:15 -0500
Message-Id: <163431847250.251657.9371435112014321266.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1596086296-28529-4-git-send-email-deesin@codeaurora.org>
References: <1596086296-28529-1-git-send-email-deesin@codeaurora.org> <1596086296-28529-4-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 10:48:13 +0530, Deepak Kumar Singh wrote:
> From: Arun Kumar Neelakantam <aneela@codeaurora.org>
> 
> With current design the transport can send packets of size upto
> FIFO_SIZE which is 16k and return failure for all packets above 16k.
> 
> Add TX_DATA_CONT command to send packets greater than 16k by splitting
> into 8K chunks.
> 
> [...]

Applied, thanks!

[3/6] rpmsg: glink: Add TX_DATA_CONT command while sending
      commit: 8956927faed366b60b0355f4a4317a10e281ced7

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
