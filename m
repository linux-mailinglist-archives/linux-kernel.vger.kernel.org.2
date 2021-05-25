Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6738F6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhEYAMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEYAMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:12:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C871C061574;
        Mon, 24 May 2021 17:10:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b26so27081329lfq.4;
        Mon, 24 May 2021 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t47JtVy6KStbnEN3bYR8XchCG9158eP6cF4birDMKa0=;
        b=G/U0nPV1Xjr3193n014viIGgNkMnhsWpnLKWnb900gKF1JBYt1cCdfOrjwhttWtrOF
         XdajzNZL52kbVvmEwxUM8iG0sP22GIUcK5pQA5SXS0Pu9cmq1n4H/tvyvrrZQNqypXKF
         yzDSgOzur70gjqARQOhXZD7SO1iyj5aaqbaeoTczxwguTxghgJUyhkR8WaYaR+vNA54q
         BJZ8dk2SbcggfZfokwpz9Om0/Ee7FxT88canLXZycqxFyVdwqWz4DmRZFqp43Q944d+d
         vonC4tkfYl4uFveq1EFNg660ZjzQLSm0ZJP7mnd/v7SwPR/3n1rkVIlhBzJQxbu9mUs3
         5c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t47JtVy6KStbnEN3bYR8XchCG9158eP6cF4birDMKa0=;
        b=NlRjmiaWCH9R2oAA5MCarwmYJ4sDRCeHFPoBtj8+FDCLIvTyRrr6XrQEySbb2xO/dU
         k6qrQQkHPm8LUWFM8mRACsD3C5aKBzysEqr4SLVAEuieCBtsOl42P2ndXDOSOoEK9vz/
         dw+FvN2vW9UcHyh/xuxanDo+QXgjUjKq6CWrkl2WSxjXal09r9moNa+SXWU9NoeoKiU6
         w4DBL6ZHRWkGXM0jECke0aSYfouklPIJP+ufDqkEls7kMbbmkK4lU02h0sLsj0/Xxuo1
         VGSccFQvIYc4HxPE2WbdOsAFYDLzxImgH1fvyJuowfXPkkJd8Vj2iDcTX1Mbfcxabvlz
         47Lg==
X-Gm-Message-State: AOAM533ugiBp2eZJZvk5HnII0hUiguiQ9SCwFBwdvua6Dlzl6dryUI57
        BvZ6eaQodMio19zilQ7RggLkirkQe3YzsbUzYeg=
X-Google-Smtp-Source: ABdhPJzd004l0A4EycAUS1IJ/n71pXJaFU/sj8ALH0v9m4OuRqvXaFqbFRo+GeHTcMOWIixGW7oPbxFa7kz4HLNZj7k=
X-Received: by 2002:a05:6512:1031:: with SMTP id r17mr11948626lfr.583.1621901449531;
 Mon, 24 May 2021 17:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <4964298a8d264dafaa807c43bab5d174@dh-electronics.com>
In-Reply-To: <4964298a8d264dafaa807c43bab5d174@dh-electronics.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 May 2021 21:10:38 -0300
Message-ID: <CAOMZO5CaK5mJpDp7-ak3Q08ErWrfBQ-xCgOPpqD+rH_yT1Ok8Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02
 boards [Klartext]
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, May 24, 2021 at 7:39 PM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:

> My thought was to be future proof. If there is no match with the Solo now,
> it will fall back to the i.MX6 DualLite. That is why I added both fsl,imx6s
> and fsl,imx6dl in this order.
>
> Should I remove the line with fsl,imx6s?

Yes, please.

Thanks
