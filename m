Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC343DB33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJ1GhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhJ1Gg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:36:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451CC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:34:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so7195617ote.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PRgWCRCX7AtwJtD++BtDcASmdtlLCky0vNsp17MLlCo=;
        b=em7rMEP++cDD6gn1cQ27hJKr0PZKndl+gMTj5cIe4wcUsLq1UdZ258NJ827zstWX79
         EmDvUqjsQQT7BlzCpY13u6u29OM3jwkeYBAvmvdv1rvMxknpaUWbppiNXIueAmOAvjPz
         LhbvwuU3B7empW598hrp22LTfyfUFg6buyuU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PRgWCRCX7AtwJtD++BtDcASmdtlLCky0vNsp17MLlCo=;
        b=3oLpykQowZhnejcd8p2gT73bb1bowFLASpTOTc+YaiPO1aGMdkpl2+l/FnWDy6wK+m
         K1+DfuxsQMzm/5uy9MZKvhKD36wZyorObz2DkG8I69u4zWqVxtBtQ2L6Ooas959BKfkj
         pn3E/SpescVxCXDFllCnfx+ihwSlX8VcWuMtJ3Wj+08nJH+/hT+dtGNLCoiaLdk3oh67
         S3GZveDjQaIwT/riYq0SCKFLbPT/zrsSB8lIUcMmZDZKi2iDsK20yAMKafimsVotnXJo
         Xwk4qjoXuZpBSoH0OeasFBUPB+3WRRfzc+2ZhJ4Vkegeyob6P900FqFajDXcHY0tlYwA
         YO5A==
X-Gm-Message-State: AOAM531cxUXFcAUqJhWq7kCK5XuRdgCvVQFBEYnAhHwu5wPG7n5/dlaH
        OmH0/tBD6kAhPUGJSsUkvpbus2iYm0fXjdVFyrN16A==
X-Google-Smtp-Source: ABdhPJxWcOa3Xkk6Hw5Lr0txJqbDDMJPmnfEf8oGlsnZUqb3TVVAZTrS+4RFqV0jimxB4yUnK+VWxsK2/WZ+xbzr3qU=
X-Received: by 2002:a9d:6e16:: with SMTP id e22mr1863400otr.77.1635402872221;
 Wed, 27 Oct 2021 23:34:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 23:34:31 -0700
MIME-Version: 1.0
In-Reply-To: <1635386088-18089-6-git-send-email-quic_sbillaka@quicinc.com>
References: <1635386088-18089-1-git-send-email-quic_sbillaka@quicinc.com> <1635386088-18089-6-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 27 Oct 2021 23:34:31 -0700
Message-ID: <CAE-0n53U0JARXjzt=Hr5kfEdEHJR5AFKYx796V7LGbn6CVnVig@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/msm/dp: Enable ASSR for supported DP sinks
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org, sbillaka@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-10-27 18:54:47)
> The eDP sink on sc7280 supports ASSR and dp driver will
> enable ASSR in the source hardware. The driver needs to
> enable the ASSR field in the DPCD configuration register
> to avoid screen corruption. This change will enable ASSR
> if supported in the sink device.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
