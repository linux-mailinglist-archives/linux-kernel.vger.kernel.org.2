Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6215E436AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhJUSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:55:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D05C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:53:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so3188108lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mO5anQzGXTxh2v2wYXdU6rU0TROIAFTKDYYEe0hmhSM=;
        b=FFYXPZJcnXPuGpp/ZSB3wwIMJgRYVA5DfPknKpPhzU3edEVeidgNQQjVtvILLsP8Py
         f6IUDDJ7S6nLRcAOWVduJ5d9y+J/FaTMsrVZgKiPEJMuMc4Soy4K30HT+M+ckvanbBZ4
         GCo8tXJOfnq65fdy3Bgkrn1fwNgOFEYoDJsbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mO5anQzGXTxh2v2wYXdU6rU0TROIAFTKDYYEe0hmhSM=;
        b=BHi582oll2VL0gslJOcweIs+Y8cC8peV16bKOWMXIjQb6iiqx9zbxdonyZ4PuCbCFr
         q3rGDZNnpGIyC3+Z2RsIFlh4UtDMhetB0txE8p0OvVqgCrn/btDkOEXnFgdQXaL8coJ9
         n29oC+HcpM/Hx7k1Kncd2WvSdD6rnAYo11jouPj+uJZcu4InBToBSoxp+w+nEi0Kyrfp
         jBVwsRJtAK4jbSYg3yeX2vqdPHAI21dV3vB47YC0xsKNxB8923szlzEhw9X/9i77zoGD
         6RPvZtyT/ykT0/O5KT/a32nqEt1UdCSfAv69/ZJvgq+VFCrmgboRx4Mfg+pmAVZIk+s3
         kiDQ==
X-Gm-Message-State: AOAM533qsFKbOWsE0rkV5zSmqSLnm2P8oIIDLBg2wRdXn/3RH5Ifsv67
        PHgQY1G9OV8jQcyjcRnNvSWiTdARceODo7AUEgqqMQ==
X-Google-Smtp-Source: ABdhPJys9VUKRoYmYMSGZ1MXhUxuDtqJg+cCKLhocitFkTrbjasOhV/035KFy9HQ0JHl5V8hksNICzzekRoQ6niNOmk=
X-Received: by 2002:ac2:5c12:: with SMTP id r18mr6938328lfp.251.1634842414238;
 Thu, 21 Oct 2021 11:53:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Oct 2021 11:53:33 -0700
MIME-Version: 1.0
In-Reply-To: <20211007140854.1.I70615769f27bbaf7e480419d0f660f802b1fea43@changeid>
References: <20211007140854.1.I70615769f27bbaf7e480419d0f660f802b1fea43@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 21 Oct 2021 11:53:33 -0700
Message-ID: <CAE-0n53b2SPJh7NABca_XDTeO2z_5omF7TGPa6-idsRa3BNqJQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add Herobrine
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-10-07 14:09:11)
> Herobrine is a Chrome OS board/platform based on the QCA SC7280.
> Add a .dtsi for the platform parts and a .dts for the board
> specific bits. Currently the .dtsi has everything except the
> compatible strings, things will likely get shuffled around in the
> future as we learn more about the differences between boards.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Ping, can qcom maintainers pick this up?
