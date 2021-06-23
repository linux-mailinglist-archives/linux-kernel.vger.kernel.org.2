Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8353B133F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWFch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:32:36 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56309C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:30:18 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s19so1441749ilj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkwJfD+9JbK1oq4b62hgbaE6jtrSjfI6D/NEnPdUhSA=;
        b=vBFzqdReY0r/43igR8DEqJFlggZn1MvcSot69Vc50whSaj2Dt4xL0ZorQwwDlw/U7W
         BQNTD2XNDg1RbFSw5ClR8owRgQ6crAWxAEYOnT24zWnnak1VPSOVU6d9DXul6KWsxxXl
         NbTw7RjEhz8MLsUQP74FpAsNhaHiLAzJP7R8C0Rz2tZwGyRxo+3A4lJvb3f1YGApWASS
         9zT1GTiBYqWGXteMzM099F1Uf7OwvhY80MQugeUAvH7EWV3mBTC9ZzH8bB0g9C0sKPuB
         maVzN1J/nTLfs8s0sDC5LM6eIw0bCGfR4FdQlm38RgYM96oNWABZ56gVlsKxq0qxu+Sg
         HjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkwJfD+9JbK1oq4b62hgbaE6jtrSjfI6D/NEnPdUhSA=;
        b=MgiOSYOuxh4MQKdEj67SaByKj8xBIv/TYRH8r1fUtu93fiKwYDv6vT20ztAeDyeo0j
         2LjeMv1MY8SSvPFWH9YXAme4Gw4DjTRDr+BMqji/skQn4o4jsPZhARuJqXG96qpwFiXz
         t1US/e9pTCrVIO84abfqOSG/RoIfKYOAnizIMLJDaBp+ZHut8WNHvHIz62dmXYeswwIQ
         Wn9OsbrSftb5YY3x3ATPgy/6CrHnoxrPfaVCMKgNqx+qP88Eo2ExX/D1EChFwyetyh8y
         NIAZUw4h3KSqvANKXvzFTRPGJwQbSdTvQWz21hB+yYkTzcCXB9I3z6wgIFWr6d+5YFjc
         MwtA==
X-Gm-Message-State: AOAM533h0SybA8j7bfYn73Zh5NkI88M07iMs/8VUZjw3czki8XG+GTQ4
        fjsM35X539aw21atDp8Gn268jyn81abf3GK8YcK8Jg==
X-Google-Smtp-Source: ABdhPJxV+0U33TwQlRrhkYebAuOuvvUm2yiD8B+cLmDSJV3xpHJxOwigW3tDHsI7+qrB2LoPw7JRgcwumeLjH3MAehI=
X-Received: by 2002:a05:6e02:1064:: with SMTP id q4mr1653159ilj.127.1624426217267;
 Tue, 22 Jun 2021 22:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <1624271985-23591-1-git-send-email-kewei.xu@mediatek.com> <1624271985-23591-2-git-send-email-kewei.xu@mediatek.com>
In-Reply-To: <1624271985-23591-2-git-send-email-kewei.xu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 23 Jun 2021 13:30:05 +0800
Message-ID: <CA+Px+wXb-kO7CJP9M6C06YAy6QMaoA0sDe_RO+RMTKT9WoQDkA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] i2c: mediatek: Add OFFSET_EXT_CONF setting back
To:     kewei.xu@mediatek.com
Cc:     wsa@the-dreams.de, bbrezillon@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, liguo.zhang@mediatek.com,
        xinping.qian@mediatek.com, ot_daolong.zhu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 6:40 PM <kewei.xu@mediatek.com> wrote:
> Fixes: be5ce0e97cc7 ("i2c: mediatek: Add i2c ac-timing adjust support")
> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
