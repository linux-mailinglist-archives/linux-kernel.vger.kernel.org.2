Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392C83241F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBXQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbhBXQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:17:48 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222BC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:17:01 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 15so1217626qvp.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rz5RhReura4CcmI0uFLwnF+N34P1WN0iecznbdW2HMo=;
        b=WGpCLLl1ryOZCXK7onehQGkJAtjJs4oZKyW1YuWcgRF2Q7W9IjAwCznxRg+15u34yd
         uvaIvvA0+SoA1hh6NYTBY8W1ne/UgkPZLFf3yoruB7CXPwRpzEQ9YQB9AoqKRMUFUSBs
         vkhZGtFlIqP2/DeUrRlB2BtzcyQwdIj5wRsd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz5RhReura4CcmI0uFLwnF+N34P1WN0iecznbdW2HMo=;
        b=akaeg3D1M7r+/0d/0J9vkFjBql+vyU3Y0U2tF5xepH/V/hLzv+gp0SH1yj8I7pNIeS
         +Wj2jH8Ex6w/ml73bgpgfDjR3zBRfoxhMA9ZvrSLO4joc52/D6K68bjO/5ycsTQE5TpR
         NY7Kv6PrE2ysJDrD3X0rbtyYKFQki6qRydJQLrcB7Sh/LDRHJYLCONi7t93MOArpxSO2
         KMPixqlGh51C6tlewcJag7ehkO+FOrqncSCkA7RkgzV2E6g2tJrJVvn9mcVGrUORi/HC
         GH/RIsMqJIWNpjV7KPH5zmxrQQmxR+vHnVd1RlSqC5iCs0enLEBI69UC6553D3f+a5wM
         zTHQ==
X-Gm-Message-State: AOAM531eBvWHTyjoO5/A5I/ukHvYxuURRW5TOtNwxtCYm6135WnHzl2A
        6XHU8M9UAQw0wgakvAkWBj6DFCCL7w+tHg==
X-Google-Smtp-Source: ABdhPJzKXX+Ot0/AIkbFEIaWtf0Ym6s6NA2nq5nORRJhj1DbWPOrHQPVv0ozlmya4sBjg87VnlEdeQ==
X-Received: by 2002:a0c:8365:: with SMTP id j92mr7421840qva.19.1614183419946;
        Wed, 24 Feb 2021 08:16:59 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id o1sm1569270qtq.81.2021.02.24.08.16.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:16:59 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id c131so2363036ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:16:59 -0800 (PST)
X-Received: by 2002:a25:4e83:: with SMTP id c125mr17357577ybb.343.1614183418740;
 Wed, 24 Feb 2021 08:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20210224071653.409150-1-sumit.garg@linaro.org>
In-Reply-To: <20210224071653.409150-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Feb 2021 08:16:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VZr=fEr9O6eKVs7T1DH_ptMM2=8rH9fVN+=uDQpwFtrA@mail.gmail.com>
Message-ID: <CAD=FV=VZr=fEr9O6eKVs7T1DH_ptMM2=8rH9fVN+=uDQpwFtrA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Remove redundant function definitions/prototypes
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 23, 2021 at 11:17 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Cleanup kdb code to get rid of unused function definitions/prototypes.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Keep kdbgetu64arg() the way it was.
>
>  kernel/debug/kdb/kdb_private.h |  2 --
>  kernel/debug/kdb/kdb_support.c | 18 ------------------
>  2 files changed, 20 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
