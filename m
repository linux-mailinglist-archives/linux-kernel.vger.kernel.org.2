Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A04C35AA48
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhDJCOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDJCOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:14:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A5DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 19:13:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d5-20020a17090a2a45b029014d934553c4so4761671pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nLePSplx7PtSkXHGdXyCusnm0ImMRD9rerpY+TAlPHg=;
        b=cXw10tBrh9lVLSS0FkJG7oTiJtaMODJjfgdmqz4mTEi+hVS0Wr48giTPDmIyZzQf6r
         2mKJvQ/xUxJMdPj5PNzMlmNkpDJfTaCxaYMqHxs+kb7y8ZfL8Tp+0zVUq3v7OVyaDqFs
         tdDAHKHxr427clCOZZi7nY1dc1dsdxkYQcGoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nLePSplx7PtSkXHGdXyCusnm0ImMRD9rerpY+TAlPHg=;
        b=UxADNdpc2GMlzseu1JFQKejS191dKWu4Hl4B6kSvtVCH078IHcvLx1IFr8H37yBFSy
         4jGgSd8hSTMZukNBiU1rDelS3Ma7ZZvZCbovEDXA6deNYFYQcOImbzpnbJF1R7RsyeYu
         7TqO9f5SxwfNIMre1sKP+RMPC5cHyOPZ4yZinKCaWGWQ52ADHMB2JhmyZ7SSHbMCJ10m
         YT535/Z+5s500z0WhmAerYYKakBzt3j3n4Xkc/f2AMjbmjAIGHscZrWlkgRczZfrk1de
         e/Z7+DEvIZXLxXH1ln6IxRE/IvYGfjKW9v7W4hqyj1brJAC7dt8G2M63rVCvl5TOvQct
         qodw==
X-Gm-Message-State: AOAM5304MFtsMWoNc1bWblL4aFDH7WLcyRDE6j3F4D8VlO0a4lK1ORop
        ELdQ8m346CfbCUZ5ZXr9Y0wPgULAjDG/yg==
X-Google-Smtp-Source: ABdhPJyDcS64ZZFzixjsjMMnAtyV704sq0UdPuwlwsXio8lAwsnAuX2nMSAYMbgnNY74A6RJcHXizw==
X-Received: by 2002:a17:90a:55ca:: with SMTP id o10mr16069191pjm.173.1618020835728;
        Fri, 09 Apr 2021 19:13:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id q15sm3795524pje.28.2021.04.09.19.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:13:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618020280-5470-2-git-send-email-tdas@codeaurora.org>
References: <1618020280-5470-1-git-send-email-tdas@codeaurora.org> <1618020280-5470-2-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: sc7280: Add cpufreq hw node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Fri, 09 Apr 2021 19:13:53 -0700
Message-ID: <161802083374.3764895.12006553235097369856@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-04-09 19:04:39)
> @@ -1116,6 +1124,17 @@
>                                 #clock-cells =3D <1>;
>                         };
>                 };
> +
> +               cpufreq_hw: cpufreq@18591000 {
> +                       compatible =3D "qcom,cpufreq-epss";
> +                       reg =3D <0 0x18591000 0 0x1000>,
> +                             <0 0x18592000 0 0x1000>,
> +                             <0 0x18593000 0 0x1000>;
> +                       reg-names =3D "freq-domain0", "freq-domain1", "fr=
eq-domain2";

The reg-names provides practically no value. Can you drop it?

> +                       clocks =3D <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL=
0>;
> +                       clock-names =3D "xo", "alternate";
> +                       #freq-domain-cells =3D <1>;
> +               };
>         };
>
