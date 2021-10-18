Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DC432461
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhJRRFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhJRRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:05:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C890EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:03:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o4so648960oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vapiWb/xC/HRW5SVd0n9p5J20MNFCuAe3IsWE2MHhPY=;
        b=GqTp8rvXsmRgSRBgRe45CQVjz1yaUBVMoi36eb0mCXIkj3yNFhYbNyiHrgcQHnI0T7
         XubLveOeE7PZHLsJ+FyA3yQApHPHEy7QrG28bHcN2hx4Sz5FadDjXLdj4Df8+1/6iELu
         F06NmOHAYROdHylmOCvNQx/QGAP0exqVpShEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vapiWb/xC/HRW5SVd0n9p5J20MNFCuAe3IsWE2MHhPY=;
        b=w1kURKn0daKv7KJ+Bx0SkDX2iUb2z6jRgv8psz5biYlr4rhCIZhc3YiAxGsBrpibgL
         SpDHUqCDTiQv3kOuYyC3CDUmr1YSS1g9W9jycHX2vRJwAvC71bIpczJJhIcv9Yla21VS
         ZBlDUHMiOygpFiQG96VxfJuM//NiiHlxWqVOxehKASyt2Pst9J4bjUPYfkQ+msfDejYW
         +We+8LXkvDY3a+XtG2XuTmq6DLkdZQIj1J3PvUrM2jy4WA8BgcesVZwlzMlpFzC56Ffz
         8A3BQfmqmdKRLISTcwsT3bn9D0n7GJL0+bJkH9ZlJRDpZDPj4fCOpIlz4CcaP9jacnGM
         YuzQ==
X-Gm-Message-State: AOAM533nl0gx2O4zs8aLk8URng+B4MoLCDM4tcxQMwDVjtZ1D6K4px2i
        YNRxGDxL9m2SUhS7GxtxG8SvmuC2NUc=
X-Google-Smtp-Source: ABdhPJwZdQMnOKS51Nw63JPBwfX6AulSAwK0GxrS+wBjvPAH+ZZcUgVAsznXMze5d30P3kxLaiDcgQ==
X-Received: by 2002:aca:604:: with SMTP id 4mr93536oig.8.1634576581818;
        Mon, 18 Oct 2021 10:03:01 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id t5sm3014936oic.4.2021.10.18.10.02.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:03:00 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id q129so766898oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:02:59 -0700 (PDT)
X-Received: by 2002:a05:6808:30a2:: with SMTP id bl34mr36459oib.77.1634576579273;
 Mon, 18 Oct 2021 10:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211018063818.1895774-1-wanghai38@huawei.com> <163456107685.11105.13969946027999768773.kvalo@codeaurora.org>
In-Reply-To: <163456107685.11105.13969946027999768773.kvalo@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 18 Oct 2021 10:02:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMQhjOCwjVUcstx3GoZeqsFJ4e_6FCFos6Kqb34N66axg@mail.gmail.com>
Message-ID: <CA+ASDXMQhjOCwjVUcstx3GoZeqsFJ4e_6FCFos6Kqb34N66axg@mail.gmail.com>
Subject: Re: [PATCH net] mwifiex: Fix possible memleak in probe and disconnect
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wang Hai <wanghai38@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, shenyang39@huawei.com,
        marcelo@kvack.org, linville@tuxdriver.com, luisca@cozybit.com,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 5:45 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> mwifiex patches are applied to wireless-drivers, not to the net tree. Please be
> careful how you mark your patches.

Also, the driver being patched is "libertas" (a different Marvell
driver), not "mwifiex" -- so the subject line is doubly wrong.

Brian
