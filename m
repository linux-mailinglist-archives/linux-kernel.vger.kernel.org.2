Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D9E412A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhIUBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhIUBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:40:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B33C06EA8D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:46:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h20so20199235ilj.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Na4bI2RIoAWJG++IZgxN0vC+TC/18LddBM+x8YPaYaE=;
        b=wfHm0PS6hmpGOVVTgGEUsVEjRm8PiEraDhP3gsrJQDDsx6W05DX7o7dYOEp2Yq2iY4
         V3w8YKxLGRsmZc0FB7WWmCjj1GsBlnKGF5l8hkkZgZ2rs26N3aEFENzE1QuF1H7btNPe
         bCV4xPr7WdAbthGGY7k+ZUr+4b8KUtaIyW7feQTSHVmqQ9Jl73MALs/iA3wYEMaCACPd
         m7Bh1A4N8aGgjh9oGdVbYhaI1WM3+DXCMzM4KgPM1bsUYUfhdhJ7UuK9Amt3/Ki7m0GB
         QitSFUKMmKXAwBEUv/SjYQya9bNARsn74UYaTVKjIO6V93edqfNyRs2P7DhpQH5nRaje
         hwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Na4bI2RIoAWJG++IZgxN0vC+TC/18LddBM+x8YPaYaE=;
        b=FxRLPNUnpVHHeo8uIuh76gStA/R5O7T2gWKDHxkvZ19yc6TDDILZx5bjOREjI/Ws+5
         wI/8VbmM9WzOk/YGGKkIAslAsre+tHR0LIZ1v1E7KCwA2GUhjcgpebEAS9ZUI+nyaaN0
         7wQ7k7Lwe8AiIBAvtUPFcy09kYMGwplfYWq17tH1O/PbbocvXfQUc7k2Z+V5MXYO5zvL
         0FkQZI6Hi2L4nOiHgfUVVw7Nq8MVYB4OSrxgUC4NhUPGKeltCTZBzBuaH+NxeGmap2Z+
         cPXtWe9CErvBMj3RAf45bOF8gvAYFuOmow1GN1jXOn6gIhEpog22uduriUMic0LVpCF2
         JoaA==
X-Gm-Message-State: AOAM5302jMKOl4ZLsm0kwPRGRTB4H8QaVp49GvjlkEcJtzeONAvJjt7c
        kRTcOM5I7TgWVpk8YIJq8yy4L0cZiVCgMJEN0ETtRw==
X-Google-Smtp-Source: ABdhPJzuC7qd+6LCeZTIOuuvehAPjDL8aSaBRqXjWA5WrOFBNf+Dd+Cz8sNU6WQPKhdm7LvZ088eqmzOye0I2ubwaQA=
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr10312578ilv.109.1632170779498;
 Mon, 20 Sep 2021 13:46:19 -0700 (PDT)
MIME-Version: 1.0
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Sep 2021 02:15:43 +0530
Message-ID: <CAMi1Hd3k2snB4-=M57pVrMVom=a9_2a0DTFk-+Hzpubwk-Pr9Q@mail.gmail.com>
Subject: dwc3-qcom: tx-fifo-resize regression on Poco F1 (sdm845) with v5.15-rc1
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley, All,

I see a reboot loop on Xiaomi Pocophone F1 (sdm845) with TX FIFO
resize patches which landed in v5.15-rc1. Upstream commit cefdd52fa045
"usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default" to
be specific, which switched on this feature by default.

At times the phone crashes into the fastboot mode after the reboot
loop, but mostly end up booting to UI after a while. This is what it
looks like https://people.linaro.org/~amit.pundir/beryllium-userdebug/PXL_20210920_162749483.mp4.

PocoF1 does support TX fifo resizing as I can see that in the
downstream dts. So maybe it is the tx-fifo-max-num which need to be
adjusted for the device? I couldn't find the tx-fifo-max-num
equivalent in the downstream tree though
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/tree/dipper-q-oss/

Curious if you had any ideas what might be going wrong? For now I'll
keep digging around tx-fifo-max-num, but I figured I'd ask just in
case it's obvious to you.

Regards,
Amit Pundir
