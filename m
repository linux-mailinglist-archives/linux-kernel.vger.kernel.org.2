Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BDC31DBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBQOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhBQOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:55:13 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:54:33 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id i23so16409134ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eW3LA1cMGZsWxGBTyavm4NRE0/iFEXmezUgPd8JDrw=;
        b=uzRl5FUfskRu8WBAvZjyt8A7P+d4ve/tU0wc6QWHJH/S+68vsn7KeGCY3YCkEv9WDU
         cK9/Q3LYnFUYkeYIk2y2c/kqwzXSzGqLtM4B6xOoGrY52obwH6r4LbAY/43QwZCxDqo3
         dvA9cfbquRhsB6ssjmAPFq6LSLhyLlyV+cn50ZkwRwcVRrDgyS2jb2alg5+Em99L1tEe
         sxAAUc70n6DNWl1cduaVBYOWktxYnJWBwOBTCQdJW1GEcdYacQS976HB6QXZO/DGjwEQ
         Y7ZtOiw2Y504CJ26alsOiakX8diuzGD2xnBy2U1ICT1XnaZ7pcGEWTHu0g25B/JIsBgf
         0snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eW3LA1cMGZsWxGBTyavm4NRE0/iFEXmezUgPd8JDrw=;
        b=aTUCEpp92xH5V1O5PRvfge373dVtoV1bU/vdnkz8Sd3pO+F3PbjxtTALuOZsT59EGW
         V3FDxEmTXM/GLayVtypBJT+/n0YpVqymTve/pJ8S9XfG3TiDu8u9cJqG2L2vr+N5IsHD
         FoQ60nuhelzZb7Raf4t55A2l25k/cQiG/ueouJk081Om+U4VT8yBFqCw7iBGUevw13P9
         xHOBYAjO/cqX5mV0ily7Zr7EGHrxpWW9QfKQZ2753Sj1ytn7NCVmqa65x7MQXPPAWJQo
         ttJOyIKSjielYVylFyIqoqp7poeKFeZGmnZy9I/zIIk9y/qMomMUkD3jh7ocytYgWA+0
         nm1g==
X-Gm-Message-State: AOAM533kIb2A4DoxMJ3qvZC94FDj5gj7NB90iSwc1PYexPC6pw0DVK+l
        di/ksNFWQM2vKAGIWzTZguizjs2xr0MOLtkndviemM2I3XNTWw==
X-Google-Smtp-Source: ABdhPJw4kb9KSeUbijA4QgzZlMVsQril4Khu0lYfNxhBSf2zC/5Q2rhbObi2fEGOqL/tHHl+GZc0X53A0dP0sNwftvw=
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr24058492ejx.466.1613573671755;
 Wed, 17 Feb 2021 06:54:31 -0800 (PST)
MIME-Version: 1.0
References: <1613501314-2392-1-git-send-email-jhugo@codeaurora.org>
In-Reply-To: <1613501314-2392-1-git-send-email-jhugo@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 17 Feb 2021 16:02:03 +0100
Message-ID: <CAMZdPi9S5OnWs_QFnf+xVM+jLve6cpdvi_vpC_KdEbUUaqoFYg@mail.gmail.com>
Subject: Re: [PATCH] mhi_bus: core: Return EBUSY if MHI ring is full
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fan Wu <wufan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 at 19:50, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> From: Fan Wu <wufan@codeaurora.org>
>
> Currently ENOMEM is returned when MHI ring is full. This error code is
> very misleading. Change to EBUSY instead.

Well, there is no space left in the ring, so it's no so misleading.

Regards,
Loic
