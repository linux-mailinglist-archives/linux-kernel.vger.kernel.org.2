Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388AB3D087E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 07:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhGUFFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhGUFFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:05:18 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C54C0613E1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:45:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so1047848otf.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 22:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dNfcxQisjjJv5eOHz1IDkcy0UHigEE+DFspSgTRkRS0=;
        b=TmXoRy3h4S4nFy3pzooJOmvDq4Nlw9Mwyudp8nErttrXML7dj1of1i8ptfUEpePAQT
         n0d3VZwXzyngirIwAIGbg5mZjQtO+FgvZQUN0xjrx954BhzuklPhnurxjZmfa1Lv6MD1
         Kk57AEJ0JCSnu5rG3QYABH7B3tYUJj2rHBISw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dNfcxQisjjJv5eOHz1IDkcy0UHigEE+DFspSgTRkRS0=;
        b=q7naqAQyG27UWgisWD1uj5K2hyqjVtMxpehLvR3OHwcolvAXDJAJT+Q8/36U0S7o51
         3S90Oo2Swd67pUbHRzfS+L35n5WTW+NTNmE2NTZdFXnNWtleG0zWi2QV1lm+EptpslKm
         BXLT2syS/JbYgIaxM9amlA3An4g7gJeAK+tVVgAnxy+YNOl5cQt1us7vSnV9MiVBHTBT
         F0sucG3kx5cBjnmO9eezWVUsXPWNwbhLvZJIqgpxgjAKpbhOhk6BIpy6o3J+OOIrWNc+
         fnEQb/+HJbyDGC7gVKKvdC84C8IhHkmoi1pxN1h1OWOjt26vj+/7jWwHx7ipkux6Gtf/
         ByJw==
X-Gm-Message-State: AOAM530GKE5pV2A6s8OsR9v1nln9O0lDyhaQ5bsyZPrS0dMVPqDaVwk7
        hhvgGPMEMwpNHl+F2iLt955y4lnFA1kBQFEg9okznQ==
X-Google-Smtp-Source: ABdhPJwZnht3Kr2prR9o7Uwl1hUh3Rla9OGuKEOgfIbY2MFf609ZjI1kLJEbk8naHTyMzMVjSRkQgRiOyGVRCVR2GXo=
X-Received: by 2002:a9d:1b6e:: with SMTP id l101mr10056846otl.34.1626846354073;
 Tue, 20 Jul 2021 22:45:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 05:45:53 +0000
MIME-Version: 1.0
In-Reply-To: <1626775980-28637-10-git-send-email-sibis@codeaurora.org>
References: <1626775980-28637-1-git-send-email-sibis@codeaurora.org> <1626775980-28637-10-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 05:45:53 +0000
Message-ID: <CAE-0n528hftzM-JTv57k9P+Ac3M9Ug0PosFiCquzMQ=jNZ0H5Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] arm64: dts: qcom: sc7280: Add Q6V5 MSS node
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org,
        saiprakash.ranjan@codeaurora.org, will@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-20 03:12:59)
> This patch adds Q6V5 MSS PAS remoteproc node for SC7280 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
