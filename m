Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C781645DF87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbhKYRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbhKYRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:22:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE2EC0613B8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:08:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so13035379wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGh2DLNS/hhJyZQIObSk6tHMQ2KGLvBP7mcZX6l/Xpk=;
        b=myjOAKYGovGV9PEdZhCETyYZtcDup2aU0YXJjix2Q9FHBkQyfdSRSGG2z6zTekd4Jr
         iU+2l2IHWiauJIhrLcLXoYMDUMRF8t43QS/W1orCTr8N9R6V+h/FvecH3rBKiNpezDJX
         msLq4WNisW/tTDGBl9h1XVbHZQar5llPEBH0MNfyldtEH5STyWkWJ4NVGB17+KF2iEor
         rUuZtYjuCDVU21pL30qeg9jyDuSIW3N1vhQBkk2BIQnHp+zuPK8/dmayNmRTHnKFzPkQ
         p+syaA/KywXeZDlRWgQD72sdU4Xtv2sG+we6m3b/dRZjBgpZ4cE+zlzZhKYxJkzdvktf
         v7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGh2DLNS/hhJyZQIObSk6tHMQ2KGLvBP7mcZX6l/Xpk=;
        b=UJ/KWO/0weA87tjYEajin4TbyB7TRD66Y5tBkrojGnHnHqRlPNhXoRisRfSCb4uJK6
         s7hLB7mp91IM9dMacWLz+C0GR97hRKvLaD7HKEJ7gU88/SD82fkHXTtA3AFRuMpxg6dJ
         DDko/JnhRHp58NSvZ5AsbYPP640fXTdiwNi79jRKMqeAxExkgQhsPYUsL4WsjSJPgO7Q
         SxSLK1PhXxX6blJAlbgG5Qu8JnIkt2PeuAk32aufhV4qV+zr84aGktXC9jurRVELixTg
         8A5HWi43+snmK/DwqqrL316fkKmA0/aQWPB92RBLfcGMgmML1yTCTxjHTY1y22zvCSo/
         N5gw==
X-Gm-Message-State: AOAM531QTN3YfIHrqwrsnVC8psUaJsZoHShI6N1zm41qkvj0mtr0xMQp
        oeRdXzX5VLmV7hvs271rzW3kUYa5VajSwYEltP82hg==
X-Google-Smtp-Source: ABdhPJyh5mOfDI1hes5JAKVqu7jhhHV3VkGhFyzpVmc+T8IaEG4DsoNQqRZtyikjiDUmrLqJ4xqA1GoJHdi4OkTzPu0=
X-Received: by 2002:adf:cd04:: with SMTP id w4mr8405735wrm.406.1637860094302;
 Thu, 25 Nov 2021 09:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20211122103931.GA6514@kadam> <20211122170335.1468730-1-zoebm@google.com>
 <YZ4Nej0yftiWh5rc@kroah.com>
In-Reply-To: <YZ4Nej0yftiWh5rc@kroah.com>
From:   Zoeb Mithaiwala <zoebm@google.com>
Date:   Thu, 25 Nov 2021 22:37:37 +0530
Message-ID: <CANMHzA4U-qc3mqz5XV4YOex-=CtsJ1UA2Xv4VaEQsf66Qfnh7g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Staging: rtl8712: Fixes a camel case variable name
 style issue
To:     Greg KH <greg@kroah.com>
Cc:     dan.carpenter@oracle.com, trivial@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Where are patches 1/3 and 2/3 of this series?
Apologies, I was unaware that the preferred method is a single email containing
all the patches instead of a reply on the thread with only a single
latest patch.

> And this looks like it does not apply to any tree at all, are you sure
you made it against the correct kernel branch?  If so, what one?
This was against torvalds/linux, but I just saw that
https://kernelnewbies.org/FirstKernelPatch suggests using gregkh/staging,
I will clone and make further changes on that.

Thanks,
Zoeb
