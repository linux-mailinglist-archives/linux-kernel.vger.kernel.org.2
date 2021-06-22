Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B093AFFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:05:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEAC061574;
        Tue, 22 Jun 2021 02:03:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m17so6922063plx.7;
        Tue, 22 Jun 2021 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unCh4xTr8ctUvkpXbvFxIHGcpTYkIcuuiIVNLuFkgvc=;
        b=vdjk+y+wOVN7jSA0ClnsEox8C/zw/ToZD0GWev7qieEi0fIg1anvgW5NmPkHLCw56e
         QaTmoK3m/jcXX2fLUGb0EN/NsGTQpfC6DaLfPARVz6BLDdokKtPmFzE101BP7Co8+K4K
         YFtc7QHZu+x3ZZBwub07Je3IPEhyBqG22bbkGtIHP+upIaQqbjP3xcLI2Ubhg1ewlkkT
         HphqppXk+kpekIbS1x69jcdZ79pe172hK8/i867xYqnsx50Y+Up2CO2ENh/+gC+yUSK9
         o03XNBfF7v8QkW3g0Ba60de510KjY9H/weoxgIGRWN5kRxOHcf5PQBpX4eJ0oDA0oNbn
         AmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unCh4xTr8ctUvkpXbvFxIHGcpTYkIcuuiIVNLuFkgvc=;
        b=HZyau7W1OlceBBKQveJzXNcYbC0mpYNuckAcVorA4IMm+KITMn/Gk13jV4DcfMyZQR
         dl2pg8Acq8Bqlms6oa8uvz0qwSFqLWyw4syrBkzsX/8XwHd0oVvc6JXCHhCqVinw217d
         N4FFFG0MNfLFcmLch8aoLyfOUmPQvSAZcac6dag7254Q4eBELXQdT+djl2n1Cd1ZUnlz
         cCJq5SMJXS1WncVlaBkEGBMyh7HSsXeNd6AiYaiBNPsqzhrCm0k/7hyCD+wA1Fxru23t
         mTcueIguiyaWPFtq8B/u+Bq2AhRsu0x5kxt3KVv4dadU86qkcLkyiOQUvB4mcYL98Kmb
         9Viw==
X-Gm-Message-State: AOAM530EvjjatjQS40gILi+44cnbu3LGL6jX/HFj3RE0F4jwdJTeqD9U
        u2QAV+hcfxkSsHmf0weJKWVT0uZixPZpGFN6MDw=
X-Google-Smtp-Source: ABdhPJygCnt+uLSzE+9LSP5v6izfLu0ZB2mePUXe7JcIyMWtqE2l21zF2O65OfJF+fUicbR9nf9TXbxFiCNrYDIixXI=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr2977955pja.181.1624352580314;
 Tue, 22 Jun 2021 02:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Jun 2021 12:02:23 +0300
Message-ID: <CAHp75Vcjr5F=4qSCrEWtUhBhFycBrE6u55Krg77ENsVn6DbOMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] platform/x86: Remove "default n" entries
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 4:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Linus already once did that for PDx86, don't repeat our mistakes.
> TL;DR: 'n' *is* the default 'default'.

Daniel, thanks for your testing!

Hans, patches 2-6 were reviewed and tested, do you think we have a
chance for the series to be applied?

-- 
With Best Regards,
Andy Shevchenko
