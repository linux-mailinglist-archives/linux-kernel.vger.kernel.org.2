Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C0372FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhEDSXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhEDSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:23:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBD9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 11:22:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 124so14713769lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95tKEyQCRjctWNwfrxHZvLv9YtVr1nyw8aN8qwe62ek=;
        b=DfmgA0a2l67EFPmtb/aEWt6XaeBFKai/W5LbfSGCLk41/gVTTY8y1dx24hHl8MoY1c
         D7AF4rCyuVObdpCyKlGU1SIvQZgZMNnJr2054NtjuOwX9qTknRQISNVFAWl1xjEB+8sl
         d3ukkMTAydjJSDP9Y1te1EWdizvDDWyakizNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95tKEyQCRjctWNwfrxHZvLv9YtVr1nyw8aN8qwe62ek=;
        b=Zn+WLSb8RjVs5pz/DB1/vwIPJQk/SZbbYieHwbwegNMbxyLCvhlSNYynfdILFcFcY5
         qO5h4EiphDyebn201W5EdJX4ENwK4LaZoqOnQ0Ob/BJ6wOIgo059ARsLquS88bi0aWaQ
         TvNKj56Cj/7B+ic+i6EWd1QRlJ22rPKHWzzs8hRrm+saiK8i8wGbZrP1EDHzusGZVcPx
         2nsntjIyUxt/MbMjOxHPl7uShbk7SVgNP8cr6XBfJEz7vEtK1O/aTkOZWLEXrzCd9jbM
         5lwAiIVJCXH3Fqnae/egEIqvnx3UGuGtFADRIrqlFjAU3xKBrulGvHOAp51TltHWiRLC
         tGqg==
X-Gm-Message-State: AOAM5308BjKHmxP9Mc0egHxjCpNo2uVblzy0g5gamKqqoXmbbnVSXxoJ
        3v1c5qIOSFp51fyCrmskKvFso8onO+IDeLi9
X-Google-Smtp-Source: ABdhPJxjnNyBtyEaFAdIbss3lLf0ELtR7udNSm3WetuOednxcdOP6dGsUlRXAmBQ98vR076JnlThEg==
X-Received: by 2002:a05:6512:713:: with SMTP id b19mr17221236lfs.125.1620152563671;
        Tue, 04 May 2021 11:22:43 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id w23sm1766339ljw.59.2021.05.04.11.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 11:22:42 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id v6so12386526ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 11:22:42 -0700 (PDT)
X-Received: by 2002:a2e:9251:: with SMTP id v17mr4541263ljg.507.1620152561717;
 Tue, 04 May 2021 11:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210504150351.1468612-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210504150351.1468612-1-bjorn.andersson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 11:22:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgea9bo-j4+LAvZF7OKPAXKqrGgiBAhXTJ3Jv5JAZgA+A@mail.gmail.com>
Message-ID: <CAHk-=wgea9bo-j4+LAvZF7OKPAXKqrGgiBAhXTJ3Jv5JAZgA+A@mail.gmail.com>
Subject: Re: [GIT PULL] remoteproc updates for v5.13
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Govind Singh <govinds@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Suman Anna <s-anna@ti.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Junlin Yang <yangjunlin@yulong.com>,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:03 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> This adds support to the remoteproc core for detaching Linux from a
> running remoteproc, e.g. to reboot Linux while leaving the remoteproc
> running, and it enable this support in the stm32 remoteproc driver.

Honestly, when explaining new functionality like this, it would be
lovely to also give an example of the _why_, not just the what.

Ie, some concrete example of "this is useful to have the remoteproc
continue scanning wireless networks" or whatever.

I'm sure there's some actual use-case for this all, but neither the
pull request nor the individual commits seem to actually explain that
"why", only the "what".

I've pulled this, but hope that these kinds of issues can be explained
better.. I think a lot of people care more about "why" than some
implementation detail "what" cases.

              Linus
