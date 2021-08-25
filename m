Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087C23F7B53
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhHYRPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240947AbhHYRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:15:39 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12220C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:14:54 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o185so272297oih.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4yoU6MgRpyHMQCI8/aIYpU1Gn5IyNakl9gt064YtAfY=;
        b=gzyqrUdbRGEAEIbjb31k97p0Zp1HVx7FRFA3JhZjDAMIhKUSOWy+xnekpombral+8d
         TYO+jB16rDnAfz+d6vStj7yebxkvdEgsPBfTF6SzQUNvE5WWf9BSm8mMYQ2c68h/OoJA
         Hb6ColQSudnWdMHG/gcSnFMUQK9exKqA6NZ4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4yoU6MgRpyHMQCI8/aIYpU1Gn5IyNakl9gt064YtAfY=;
        b=bfp4LryzCpZBGw6Ai7KTl5fq6nciqlsztuJV6ygx6jOEyasJZoju5EyUUNra6dTeXj
         SF5apG50Z8sUkawSlT/BwQbH9uvU6u2adR8k802PrEXhmKmXroabvBA6UdmP9sbD41Eo
         EUe1F4oQxAFODg+B/Lc6XKFAVUgWeC9W+MxtFMg1zxtGzmY8E3QZHC61jZ9L3FjSQeFO
         wTf/KRunaYIXx0AXqVVEMUABFPeEeQFF0Ht6aRnKt7bo4fWNp7qGCdifPu6+2iBZd5dU
         npQG4BGHaJc+GnmcyUXge5+jRBIQVB1gZc6qj8rdfgD2hg/d9HKqrn1jgY5Mgq6tNZlX
         aufA==
X-Gm-Message-State: AOAM531AjTE0iy+qN/tfzIl4PQXBnpyauexvOVqJJOhLucJXXE4ZdcJl
        EoRDHwVAV3e0PKjg0ETVbm6SLWjvZ0CtlKb1Ck/kDQ==
X-Google-Smtp-Source: ABdhPJxqtt71ACfMw/k5fodalQ4d5SrnSWZLAiuInVzNbuk2R2bsR9abyyG3dHLftDYZuCIKZZkd/9+TqHYvaB1rMkA=
X-Received: by 2002:a05:6808:181a:: with SMTP id bh26mr8054262oib.166.1629911693455;
 Wed, 25 Aug 2021 10:14:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Aug 2021 17:14:53 +0000
MIME-Version: 1.0
In-Reply-To: <1629887818-28489-1-git-send-email-rnayak@codeaurora.org>
References: <1629887818-28489-1-git-send-email-rnayak@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 25 Aug 2021 17:14:52 +0000
Message-ID: <CAE-0n50oJMqheR5pJO5aR7dMFtPosigs_71tsx=M3_UcF4mhKA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Define CPU topology
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-08-25 03:36:58)
> sc7280 has 8 big.LITTLE CPUs setup with DynamIQ, so all cores are
> within the same CPU cluster. Add cpu-map to define the CPU topology.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
