Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26D3FD3D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbhIAGcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbhIAGcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:32:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F037C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:31:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so1268511pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bpafk1X41xGK7MXDbJ4VMxRCE4Mzuv5uYTag/1eQibs=;
        b=E4pSGWJ/pCQWOPy/QHPIVscmiPk7GDQnP8Ckbq4SEJS3kYCdoDp/GzKpzTwPQP/lse
         LrpKqoqSyM2OpkcoSxmvISKxyhKrbt9a0eIF+jrjgtqFSgKnYySy6qjpxb64ufkvhSXo
         WLaCLbuQC0EQQq/Lb84kToLsnPRw+32XzUuuhJgzo+x9ho7MBAfFY8shcFqa0S53cuF/
         7+6lNDZ03P0VuQh4BNtQKq/sLsPhUkzytxcudzH//w8Lx6xbleCcHtS+5g6SfJcikmhF
         2rlGg5vKWfepZK39qtS+oVNaDr/HlYYwnXrXY9s2s4LTx1zBrI+vX5vmB6rFhOa2XgP+
         GbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bpafk1X41xGK7MXDbJ4VMxRCE4Mzuv5uYTag/1eQibs=;
        b=bjbvCCqj+6JTjD5kpyk3pYYCG8hqEIH+A9+8CSzy+VclytW7hKdilj0hU3aqtA78F1
         VIoxYjdVXkxXetEMzqqQHDnUkIL/W3/uMA/7XybET/MmDBsnSq7mkxjJKaRo4eyVCIww
         gQsad7KHFoCbUMQgh91sXb6FxtVR9wDWtCiAZTUDOKFEJfTZ2xgOhxfegSl3bRMCLLgr
         HrRdqkO3EpWtZ9+sS4BEna3aJNFGHHJR4gwHdDGS5N5OAWgPLqClr9lRUszqYsrW4/b/
         vxgQYMCS7qXM4+2CJLBo6nwr+KhzY/zP1rF8YQ0PDJRcNAXBeUJoWWhaP1m1AgFWVBxI
         ywdQ==
X-Gm-Message-State: AOAM5304Hht/B2d2unCSuMGE1r12/QpmugYAlcIPVd1tkvn5PEvfACFs
        BtRAa3mmb4jGRX/h53ybAMkP/+UIbWkGuorWsT2EYA==
X-Google-Smtp-Source: ABdhPJxprnOJMY4UIu5n1XDKPKNGr9RV+zGkMFTEI22fw+hJGHUzBjxZ7RvaQyjWpEoorsORfRskSTs3bbt3V9WssXA=
X-Received: by 2002:a17:90b:238b:: with SMTP id mr11mr10076478pjb.18.1630477885388;
 Tue, 31 Aug 2021 23:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210901030542.17257-1-benl@squareup.com>
In-Reply-To: <20210901030542.17257-1-benl@squareup.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 1 Sep 2021 08:41:48 +0200
Message-ID: <CAMZdPi8QdLwrWM5ghDNYTT2nxNJm=NgNkZGxYvbRGsYQFHGxXA@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: handle connection loss indication
To:     Benjamin Li <benl@squareup.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Wed, 1 Sept 2021 at 05:05, Benjamin Li <benl@squareup.com> wrote:
>
> Firmware sends delete_sta_context_ind when it detects the AP has gone
> away in STA mode. Right now the handler for that indication only handles
> AP mode; fix it to also handle STA mode.
>
> Cc: stable@vger.kernel.org
> Fixes: 8def9ec46a5f ("wcn36xx: Enable firmware link monitoring")

I think it's good to have but does it really fix the link monitoring issue?
Is the connection loss detected in this scenario:
- Connect to AP
- Force active mode (iw wlan0 set power_save off)
- Wait for no data activity
- HW shutdown the AP (AP leave)

Do you get any indication?

In this scenario, DB410C (wcn3620) does not report anything.

Regards,
Loic
