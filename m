Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05444434422
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhJTEZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 00:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 00:25:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC2C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 21:23:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so6720961otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yt6EiAAjEPG25gxsasjBuM4mbLF5niFnwtytBdS3uM4=;
        b=V8i9mBT4pzt31nb/yTOgV6BrKh8z8BsQDWk7s0MX2PHGJnVoK67pMRV8xfP4rpAkBN
         Es0EFPvV1x78CB+bKWoKeAOoC/wyPB+NbneN6TBel2p+y9L5wvSx2qj3CDta2t/T7/YH
         5GKQRZQH4ZP02WLwX7rBa5/z/iEeD26kDfUG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yt6EiAAjEPG25gxsasjBuM4mbLF5niFnwtytBdS3uM4=;
        b=vMbZ7WmBxxDpH4YsFhxcBFJrLEtpVDkw8GTLhRU0LWz1jQbCtXGTcnYvmfeeMky1HC
         mFnsc3AcRWPaxiJ0y6q+/BH9Ns8LwcLLaO+q26eMtup7LKJl+AcdfoImUVIQOr9YVB+S
         sBLMvsxof7PtcYXcRFfGdxLl2X5sYBR3udqjDJwDC/qdTKjSNDqQd3zykztJGzyW8Qv6
         rUseKjlZMdw/0o8T2AOFrUTjQjmaub7cl4V0RpBFCDS7bBq/eAKrbpEq5ifXAEm8SdpF
         cV08KntTZHaL0+pNcEIedMfa8C/tBTbTqE+SzRwaVZYRudRsHkGWzgWNZQw2Y46NSkXd
         ZELA==
X-Gm-Message-State: AOAM531ZrUbZtqEmGMu1MMwSwj/SdWhpyNLOyBiI3oX3xFC+328IEPje
        H6W78sYbIBgKSlZWxVqmTXXH9AUXYPbQXk7JqZZdaw==
X-Google-Smtp-Source: ABdhPJzRCMQWM7zdErCHDQEAynoWxorVbftKDo7vaBbuguWxFCMzCOvIsdaPThCRFhI4ZZCxkXhlC+KZ+JSrUdMPVqI=
X-Received: by 2002:a05:6830:1c2e:: with SMTP id f14mr8355994ote.159.1634703821547;
 Tue, 19 Oct 2021 21:23:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Oct 2021 23:23:41 -0500
MIME-Version: 1.0
In-Reply-To: <20211019153823.477524-1-arnd@kernel.org>
References: <20211019153823.477524-1-arnd@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 19 Oct 2021 23:23:41 -0500
Message-ID: <CAE-0n53ZSkzAMkHH-VmBBHEykJnBY9njYcY0Xxnw+h9C0bWF5Q@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: fix linking against QMP
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-10-19 08:38:04)
> From: Arnd Bergmann <arnd@arndb.de>
>
> With QCOM_AOSS_QMP=m, the built-in q6v5 code fails to link:
>
> ld.lld: error: undefined symbol: qmp_send
> >>> referenced by qcom_q6v5.c
> >>>               remoteproc/qcom_q6v5.o:(q6v5_load_state_toggle) in archive drivers/built-in.a
>
> ld.lld: error: undefined symbol: qmp_get
> >>> referenced by qcom_q6v5.c
> >>>               remoteproc/qcom_q6v5.o:(qcom_q6v5_init) in archive drivers/built-in.a
>
> ld.lld: error: undefined symbol: qmp_put
> >>> referenced by qcom_q6v5.c
> >>>               remoteproc/qcom_q6v5.o:(qcom_q6v5_init) in archive drivers/built-in.a
> >>> referenced by qcom_q6v5.c
> >>>               remoteproc/qcom_q6v5.o:(qcom_q6v5_deinit) in archive drivers/built-in.a
>
> Apparently it is meant to work without that code, so add
> another hacky dependency to prevent the broken link, but
> explicitly allow it to be built without QCOM_AOSS_QMP.
>
> QCOM_Q6V5_COMMON is a hidden symbol, but add the dependency
> there anyway to give a hint in case another user comes up and
> misses gets this wrong again.
>
> Fixes: c1fe10d238c0 ("remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
