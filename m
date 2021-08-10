Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB973D6AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhGZXdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhGZXdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:33:38 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831BBC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:14:06 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso11698791otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XxnsPvoYRBPAgRZmEnXc9qSyoDT9N9isv4C7b/Cbdhc=;
        b=aiEyG+Z1erdqfHn1g0iRzhw1Z5rqqqCTw3ky2Xz268rVI1pRqvQF1oEcCyFvKqPCGG
         l4wSTVtHyRkqj564VFZE0F8V7X7Hfo13jmetWW6Fym0BPTSfxOGrLvx95UMqMhMVnYIv
         qMpO7pKp4nlxIgUuzEoPFWXvaa+0diu1/MyT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XxnsPvoYRBPAgRZmEnXc9qSyoDT9N9isv4C7b/Cbdhc=;
        b=O93ojEr/cXedldNe36EaaqpD5bPPvVzPA8FwYAxa4X72fq9WfIu73/es3epa9tD3Zn
         37VTtqOztG/laVzbLdhXxFech9G3AZwWXaGJ5BaCMnFL1vJysoBMaj+2+Py4X5CQUqMf
         Z34b46cSjI6GuoAXcl9zd8wt+lpUleGMbCN6Uqd8dhp9Pz7VEuS98CS82DxVPcM8J0nG
         Z8EfN57HX8xdQeuAUJQ7rxXwg2FLz2pOb94SJkeg7Jjki7AX39CfCRnG4Xbjg3JvpwRB
         9XN8Vk3QlcdvAvSGWh6ycySbH1RpjrMt1n6ziAqc4X/w2Yq0F6t+txvkLzQJrk9oDeGH
         5izQ==
X-Gm-Message-State: AOAM533VXLMLWY8s0cEBHE5+NOIoVuivf62H7CvEGb4I65wLmXsq/rh4
        WpxVt+QSLTAhjaQ+6vdYNxKqq6bN9n4UYS+4q8eePg==
X-Google-Smtp-Source: ABdhPJwDZlKXIYSwsqPZZiWOuhSDBSyF+mwnygwGZvir1Lyq0RiZsScqWR71HK9UC6CrhmfA8hEMZ3ILJsdSznkRSYA=
X-Received: by 2002:a05:6830:44a7:: with SMTP id r39mr6036694otv.25.1627344845954;
 Mon, 26 Jul 2021 17:14:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 20:14:05 -0400
MIME-Version: 1.0
In-Reply-To: <1627306847-25308-1-git-send-email-rajpat@codeaurora.org>
References: <1627306847-25308-1-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 20:14:05 -0400
Message-ID: <CAE-0n507C35pUxqciP6jagFiL=5hiGckx8VYTwhynUZQcV1HLg@mail.gmail.com>
Subject: Re: [PATCH V4 0/4] Add QSPI and QUPv3 DT nodes for SC7280 SoC
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-07-26 06:40:43)
> Roja Rani Yarubandi (4):
>   arm64: dts: sc7280: Add QSPI node
>   arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
>   arm64: dts: sc7280: Update QUPv3 Debug UART DT node
>   arm64: dts: sc7280: Add QUPv3 wrapper_1 nodes

Please include a changelog in the cover letter and Cc me on the
subsequent rounds of this series. Thanks.

>
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts |  133 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    | 3169 +++++++++++++++++++++++--------
>  2 files changed, 2482 insertions(+), 820 deletions(-)
>
