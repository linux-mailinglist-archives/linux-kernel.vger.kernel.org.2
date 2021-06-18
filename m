Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496A93AD3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhFRUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhFRUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:52:57 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:50:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10961908otu.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=kRNWiMsuDwCABlJIXRwiBrKtEw3zU1zAQGApvhY0o0E=;
        b=iE+xCRsQztTO6PzEVaaF9P0kqpmlM+yqS3oZ6CQpqC3bnRiVEsDPOKyWmi5svcQhVl
         tzJeX6HZtpQVMkLaLPqylQ3F+0gPSchDtbceTCw6QDnnc4EHX5iqHuDW05ZjDu/mOP1a
         tYXXq8nR2IkNbtxrHB/pyt25mcyGn7pUG+ibI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=kRNWiMsuDwCABlJIXRwiBrKtEw3zU1zAQGApvhY0o0E=;
        b=cOV4ZjGsdBC50PoSV0ka+BzF0O3CFehGNTBMIxOdfIxbVVn15z81f40+p9oXycyrbL
         IqOSq3HS34lpdz/REq+7yQ4cXcxmY/rTIwGlBCXpT9asA4JiYU657yF4eR7EHli6GYyZ
         ZlblUtxcw/5gTsnCP0I4r7mXpRlnjALnFrroF0f44/htUkA6eqzdKrqpOkk488Cq8x3Z
         IS8qbsYadi/hvY5Fw+J8W0mL5YlaE1Xqs9tvBMHX3MGo3pQG1X7osYUXPNr4FHUhtHKK
         9aKF0ngVOHS+ZMmtrQYueBeIV7TZ5OnEdey3vT2N5OPTKITqLuQR95VVp7IscaEHpzlR
         0Bwg==
X-Gm-Message-State: AOAM532XnsvPL8GLLCYedYn/CRhG23rtuyCcM7tgIFiMvsQxTuFGjypU
        jQUqv4AYetzBipmr6uc4Him0korbZjuTxuMAEEP11Q==
X-Google-Smtp-Source: ABdhPJysVVnraSQWaWv6lOjj1uXH2d1ll8biMB/3yfG2+2C6R9WMkadXSyDiiEon494WDlVCIDNuVMsbc2eM7btPOZg=
X-Received: by 2002:a9d:624d:: with SMTP id i13mr2754794otk.34.1624049446316;
 Fri, 18 Jun 2021 13:50:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Jun 2021 13:50:45 -0700
MIME-Version: 1.0
In-Reply-To: <1624025283-56360-1-git-send-email-zhouchuangao@vivo.com>
References: <1624025283-56360-1-git-send-email-zhouchuangao@vivo.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 18 Jun 2021 13:50:45 -0700
Message-ID: <CAE-0n536Xk3W-eG6HvgW+SVcBQXB=XgFT0e9QNktbYZEnw4feA@mail.gmail.com>
Subject: Re: [PATCH] drivers/input/keyboard/cros_ec_keyb: Use kobj_to_dev() API
To:     Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting zhouchuangao (2021-06-18 07:08:01)
> Use kobj_to_dev() API instead of container_of().
>
> Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
