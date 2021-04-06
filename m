Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E670354FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbhDFJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhDFJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:22:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7157C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:22:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l76so9901211pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8if75d19hp/YlU6eEw5FjXpHNjC0SXd0mqqpC4vW70=;
        b=Z2ZdYW3Y+2Hk0CRdXigdjgqFIuxLByvQTkbRjoLTa0PulFKQwO317WUIJVyum4hPXY
         5pxv1aGSDARDw5HQ52nwRCABpWynDMSoZxPL3/cfsbeIngjWe3sWtxbmZ7P/+Snz8wIQ
         zYuXio48+pTMh4DnqtU2GPiGSZcsq59o9FmLM6XLeVbs2DTeWr+XuuyyjOSS9TBYQkKk
         DFMhowpBYZQFFaZaK48XlanGJVSRDwezSsok2gwtc5nQCHKd+GuIQTcl2hfgWOg/yIif
         e84MW+uS25CeEMvDogODBWV7T8rwxa+pudVrIuXjVuHP5qUF+UjnqihSLEDzXj44rmwp
         GbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8if75d19hp/YlU6eEw5FjXpHNjC0SXd0mqqpC4vW70=;
        b=Yd6c4ZiMjunXSLW+thoSMHOwP5Plurmajy2LNhxvlk8CYZv3FO7jWks92jSG9O6pf5
         inkM7eWjoCMnATHMDz/77sQdqjpP6m7vktsw0BokUkYOSGJ4xgIR7V3UjAWTPyaPQMSw
         Yl6n+6Qn7ySNu3po+24k60kW4/k2VJaPtdRH6+h4GFlnMx9l+0iPmwqsziN/mnacAtlt
         K8kfgT1Nm5hO/P+Q9ymKJXZN8A55fDRsyZrlGN8fTd28fU/nU2JYLJxVL4rlmyQzg2nU
         8VZNDm/vhu3hLNaHWwT7V8cQ1kZ/mzDqe5kdMEbfmr35qj+ls0EAACTXISXeaI9gYQNu
         Tj7Q==
X-Gm-Message-State: AOAM530URUp8VCAaRFBDHTvmx0V6pV6mnBgyqIkiJqUgulIqyus23mLn
        6caVsaMWFeMfPDNiCI+oY9Bj7D8wCjt9HhZ/8mKhgA==
X-Google-Smtp-Source: ABdhPJz3wEVrcZaYOkK3hcz5aaLeeP+mmOlZa0EJoAWEi57112AbAttyDjWnddqH4QBL8c9XEle1O4P7D6umxbmX0K0=
X-Received: by 2002:a63:62c4:: with SMTP id w187mr25683112pgb.173.1617700945442;
 Tue, 06 Apr 2021 02:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <1617399199-35172-1-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1617399199-35172-1-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 6 Apr 2021 11:30:35 +0200
Message-ID: <CAMZdPi--RTCn8-gbKp_b+saX6CgpC1qm5RPofvxnLFWWoJKamA@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci_generic: Add SDX65 based modem support
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 at 23:33, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> Add generic info for SDX65 based modems.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
> This patch was tested on SDX65 hardware with Ubuntu X86_64 PC as host.

Good to see that!

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
