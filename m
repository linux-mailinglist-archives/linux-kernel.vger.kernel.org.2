Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7E42D76B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJNKti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJNKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:49:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF78CC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:47:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v8so970696pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bo5VQ//3tqrnPktse6M9enS5exQT9a929Q+6pOvyezg=;
        b=qckgPGDzOiDMdPYjj7VihdXg+SypVSMzKyRh0i8VyoYbdQK7zHYwg6WWpI1xbAbUym
         CShHABDahGp5aiQ8u85i5AZTkOsGkF0uDlzmh8HdLrpJLC5C02YFQN2bJAGFnk+Zlxu9
         2ACVTFFx+Bdk4OJFPoeW/qxMbq6y9E76qvS0avPgVpBsJvHQ/k2tmFw+unky1iyEYfYz
         vUPV541kyFSu6oz5rM9WoXI6n3l5I1+STH7kWoP9ll/IJLCgpGx/qWRedvHpCLhhWbyF
         /jORo46Bv0f6LEKgJx2BhgT7ql3arbNoVhhSQwaDFYuKjLnEjfjYWCMZyoTO48B4HUs2
         zXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bo5VQ//3tqrnPktse6M9enS5exQT9a929Q+6pOvyezg=;
        b=voPhFF/Y1hBr4pEXktgmR7ym1ytvPsIjiHWlNXx7fumjKPRJi4xE6Rb1Y39L4aMtw7
         OHkJtNn6ptktBZN5Z/hUC1fCctQKjqRsJx/xen/U1oc+X0BtwE5At+LfQNDarXuQ4d1j
         Guusw586FGJ5X/qbGlYtrcp10dXFmUBsB1wd/G5U8H0uJAfdN2+xd0k8C5gbanfoJGSm
         tz95vXnm2XNKkg7kIClNTWJtS/V/qsO8RvzxY6O1CrK4QJ8Zzwnsz4+5PYmhEm8VZI2q
         /J3YfvzLbPUIyoXnNgE5akd9ks7LWEq3j8sJCTcyiUbFaRp3HSx8dAa3NaBcoQvMdCi+
         WE1g==
X-Gm-Message-State: AOAM532apjWS9vcJArLNFFTEZHVE4eOHB8IyrLzeNsvOelo2uLpq+6J2
        gJnEfvehZ+kAi7c2PSu1svK3NYlKXkuZ1ylxYV5nNA==
X-Google-Smtp-Source: ABdhPJyn+5cDPpdGQJ4rBXK1JXXu+EDq8jOWBZVl0gH4sY1jyHea3nxm+bx6JXYsxcUpoVEOqgS4XdC+aw4OG+O7K+Q=
X-Received: by 2002:a05:6a00:d63:b0:44d:186d:c4c0 with SMTP id
 n35-20020a056a000d6300b0044d186dc4c0mr4622573pfv.47.1634208450140; Thu, 14
 Oct 2021 03:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211014093112.3852491-1-fshao@chromium.org> <20211014093112.3852491-2-fshao@chromium.org>
In-Reply-To: <20211014093112.3852491-2-fshao@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 14 Oct 2021 18:47:19 +0800
Message-ID: <CA+Px+wUKXJ7a9th1HyxvCgDTQXL9kHtZH+O9z9oRqCfcF8H-sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Fix local clock ID usage
To:     Fei Shao <fshao@chromium.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:31:11PM +0800, Fei Shao wrote:
> +const char *clk_name = "gce";
> +const char *clk_names[] = { "gce0", "gce1" };
Does letting them static make more sense?
