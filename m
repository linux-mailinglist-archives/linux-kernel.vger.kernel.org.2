Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC745411B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhKQGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhKQGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:47:39 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9990BC061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:44:41 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so2920876otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4KLLnT3lbE++1zW9IFNlDp63h9Sm/+5C3hvYnuVhVto=;
        b=Pou//tJ+XTHrkeW/AllQYZpDimofzYxEc7jVKrltzTA3GjLP7+nyqqdUg7UgoOcl0P
         NeahRDIxD6QXIcKG5oT/GnvwX2bYABXdVEn8lxIwicbPnLhKrhPeq8CxOAxtQwleVefn
         o33v1ohDjye4Z3ztHsH0vrGjImvOhvUoqvRRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4KLLnT3lbE++1zW9IFNlDp63h9Sm/+5C3hvYnuVhVto=;
        b=do9bPHsvETfFvT16mpmiiiA3JnucoplpUPwG/7Viv0iQbU9yntueGbDNajvZpqP01b
         XmnhXXAMHVJQcrNO5EEB7hvEcfJWw+gfKeTAHelSHT0yWaEb5A0RGwyiqRQ9cPDRrZ3Z
         YByd8z4urWA4F0Acph4oKiDrmRSiSv3Blk792pp0dZPSKKTXabD1T06ibbHvjQFTu93V
         rWBJLz4JUJKH0mrZd35rdbEKU0bz+7ZwcARPi8qMYTOw2M47bOxNCZRD218eKV/RKzdl
         QYzRUlwAF3ay3Z4W98oEnXiwbOxWL5o0aODkwSXHHSicaWRS5BBFrsoFHJEVjiHI8n/Y
         mSpQ==
X-Gm-Message-State: AOAM533LvQDbMaNL+9EE+jZeruBqykezLK5k3d24rw+zSzTVteEFhojX
        0Q77gsTQhbTmtyDf9x13IUOIB08eN1i9//rqtoH82Q==
X-Google-Smtp-Source: ABdhPJzyXkbDI3NrFOfsZtutYyMeBpAr8cH2dtM4PqNy4KOdAZHLaC2NYpVU1JLU58nPIOoLn0OLZ322dDNO0JgsrYU=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr11601317otl.126.1637131480911;
 Tue, 16 Nov 2021 22:44:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:44:40 -0800
MIME-Version: 1.0
In-Reply-To: <1637046458-20607-4-git-send-email-quic_sbillaka@quicinc.com>
References: <1637046458-20607-1-git-send-email-quic_sbillaka@quicinc.com> <1637046458-20607-4-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:44:40 -0800
Message-ID: <CAE-0n50jpAq7jynEL5opHJd06zThUaWVzLvc_zidi-qYUxiwcQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] phy: qcom: Program SSC only if supported by sink
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-11-15 23:07:38)
> Some legacy eDP sinks may not support SSC. The support for SSC is
> indicated through an opts flag from the controller driver. This
> change will enable SSC only if the sink supports it.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

I suppose as long as the existing user has already chosen to set the
opts in the controller driver then this is fine.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
