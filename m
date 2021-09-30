Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49A41D2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348093AbhI3FdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348085AbhI3FdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:33:14 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38210C06176A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:31:32 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso5824513otb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=O2fZWX65wwxbZ/8+54tIkBzEVMUloMahRKU53//DuPY=;
        b=Sp705WrfblJnCXVzdG4cvRpZAkD9m35RykpNAMAk5aeuQ5jiMtQbUX5NyasewstQTr
         qtDlB+TplSRffbHto+BBPoc6JVna7N1cuZGVCA00pI9s27QsznAqXq4pWo/jWpmXEM4Y
         FT+Zwz9Eo60x0oppPyskLn2aAGRHSUgLXJjac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=O2fZWX65wwxbZ/8+54tIkBzEVMUloMahRKU53//DuPY=;
        b=lArnOQuyspxiw3dwdgq0h+C0s4UOD8eKRSZ3m+tHj6k2pFrRBIjG62HVOIpJUQvvEp
         lnl4PXiV4O78Mb93oVVNp93x1qopoNSt6E6LLmpH/ubFOb61JeM4KrBR+crFseaSJBXO
         stsLF/TJBQ6kaX1p4e9vLcnsyzBvHYJjjGfhqkOyPW1o7ljqPzh8RtYuMV0C9aDoSgok
         4rIP6UwjzmriZGW6gHgRFjTimmpaaM+zEIMbrLY8EJtHnUPuMn5pbDMCeHjDnanP3YCk
         1ibeJw0GrdrpBSgHBDZ8uBpeg8d9h5g9VL+vRqmClMdkj1K6NNoTB8AZDSIbSGnAqMqS
         C/Qw==
X-Gm-Message-State: AOAM531yxM694d745ijQ4KbPjqbsckvoDUdPFFFOukgW/4jN6doLY92A
        ISoSRKCY1Ggj0KS7uso+K1r28bLviSFSb20DO1qxow==
X-Google-Smtp-Source: ABdhPJx3b00gsa5ra1+RLu/Oq+CIGE39JSoVMgtcaYIKHIFNFYRX0dyVO71PDuq2Fwi0fDGtGQx1ri+xit5xoeyzju4=
X-Received: by 2002:a05:6830:708:: with SMTP id y8mr3460444ots.77.1632979891627;
 Wed, 29 Sep 2021 22:31:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Sep 2021 22:31:31 -0700
MIME-Version: 1.0
In-Reply-To: <1632892123-11006-1-git-send-email-rajpat@codeaurora.org>
References: <1632892123-11006-1-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 29 Sep 2021 22:31:31 -0700
Message-ID: <CAE-0n51Vnb1YKZKtg-2iSK7r+50RrbURW5TN6Wyvc+9b21jZNA@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7280: Add 200MHz in qspi_opp_table
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-28 22:08:43)
> Add 200MHz OPP in qspi_opp_table
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
