Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D021F4586C7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhKUWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 17:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhKUWwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 17:52:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:49:40 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n66so34102007oia.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X99/qOPdJ+WUbWBBOwNYpUmngjvM1PDWHkQjo0ad32Y=;
        b=Q44svvAiadlk8aMSRveyGTPXRA5oCYbxFmT+IhIUTIN2fwuIw52DehmCszaMmv5M7t
         mo1dASbLVJt1oJ5uYp5n+1c/QqzKMbyE/hmBiNoxaEufxzhfelf5KD2Z8d9M5inU4S9y
         FuERCfwcJdOG0DZbzcbVXCE5/f/5K+0kk6Q1q0Ast4WisWpKmjB5mvyrrkVcHnaeT4hS
         1i20p3nA5Xsk5zB5b7tazj+rpqTz/yMPuIawvy1D9eTl/Cum/pPAbzKERJAo2sGeu7uc
         /PBtXxWpdWAhP+DwcgjeeZFk3iiwZGM8JT7MWqhygcvPtbAfM5/icS9l1cBkeJSBxsNO
         FIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X99/qOPdJ+WUbWBBOwNYpUmngjvM1PDWHkQjo0ad32Y=;
        b=dBV4wg+yaQBo1mO5yiCwqzPO1tT16XOirq/ERFhvzQtrAPTxWJ1kXz2CAw7L/ko5WM
         wSa60cZR7Lt0ZyvK7gTXf+8vvJ+EQ8A2Bs2kunXsEiWNuuPscjl9MYT3mvPX+pPTHdm3
         il2l+lI/LGijK2Re6vKoiRSYlZyUTAEbAWb4f/enaiUHOTzaRElQOSf2CN3OL8AwaDLs
         GMGlYTqKP59VBAA4gaH+3mD45MLQaqT/ZLrHo3jK3IQFu/tNLmLBD6IwjmIeoWA/agdP
         n6undYkBC4D0hu1f7Z/UM5/m0UAzcRmFlqs2rGsLVeb8Z5vi+VNROMpauBYxiW8mxFGU
         GWrw==
X-Gm-Message-State: AOAM533X25jo4z5StUfr1yYfc61BI3qv11qukKF0S/Gz8QEkrv5Hrtlf
        93rkOXdBoLgpF9z8HCSstFqMNvBD4sd9tcbkiV+9Wg==
X-Google-Smtp-Source: ABdhPJwgaKcMuYgYCnXAWZszLJBD35nrr/psdZgwCLa+EINWN49QQKsj71cxw3YkXzLW9+ZE2BbOlleDjfZ50bFaefI=
X-Received: by 2002:aca:120f:: with SMTP id 15mr16999633ois.132.1637534979818;
 Sun, 21 Nov 2021 14:49:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637048107.git.quic_vamslank@quicinc.com>
In-Reply-To: <cover.1637048107.git.quic_vamslank@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 21 Nov 2021 23:49:28 +0100
Message-ID: <CACRpkdY7h2ff8Td_iV03Bq2F=UcSOJj5W+5zB+UAA8uWK8z12w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add pinctrl support for SDX65
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 8:40 AM <quic_vamslank@quicinc.com> wrote:

> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
>
> Hello,
>
> Changes from v3:
>  - Addressed comments, fixed dt_binding check errors and collected reviewed
>    by from Bjorn
>  - Rebased on top of v5.16-rc1

This v4 patch set applied for v5.17!

Yours,
Linus Walleij
