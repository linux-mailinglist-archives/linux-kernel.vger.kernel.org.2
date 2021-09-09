Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310604041FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbhIIACy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhIIACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:02:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C8DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:01:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso61428ybb.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o8PDKzqZH5YnDx25CbdHIwEItPJ7rMvUJBtgP5mFYfg=;
        b=FBFtm342q8giAehQf40xGgLSuw3lM1gsmX52JN146g5aDYG+WU0u7zAP026p6L3vZN
         TKzeme4N56M2tzwWC6e3PgXW7e9e8G23Q5hx76eEOCVNcdb+IQUHLQGa60ObgmrnSZ6T
         5mu2SWGpFVW0xCORrpU/KuWPVJVGS9uEtF9zmvUSuVpm00p5FB2bPOcZpLBLMfkjhjTX
         HhUdycqqcXrNl24bmrWcOaTwRYFr5O1QXYwiN0BpeXHGhldehaSZ9b3UHgYj+NrT5hCo
         mBGy2jc+xFbO3G3CK1hDX8C03catENyq9nSsADmQGkKEtmB7kjxlaI4Ml6eI8Oiqio2c
         kr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o8PDKzqZH5YnDx25CbdHIwEItPJ7rMvUJBtgP5mFYfg=;
        b=vN7x6teG9FCGSvu7NafpxxuioDu91oE95ASdTLGdQNhiHKvhfiXWgJDYev0KjuyywX
         ohm2whcbPulznmwVmyqIA/E9Hmuv3NBwitWCgsKe6QAUOBsyOZViHuoalRwlSy7lTArF
         wGR/ALDnOx/K2ovI9iKzIR9+nZp3aaizRJNj6vv9Rqhrg2eK0osqTR+9kUJa7ldQKaNP
         YvUmfoF/z6+eiVh6KLSJSvkkIU0lwYYpvGjTNd66MSTwEAhSG0+7neHaP9IC8WKQWKr0
         aTa13kpchzWqLTytCO6ekZ2DY7zz8var3smfc29OHq/A0Qywmr9Qw0qfwoZRSWXzAbyt
         WxOg==
X-Gm-Message-State: AOAM532HJ3PSebdGNmTb9l+K8mbiu+hU6Zvx0imkVHuLGkaqPOhO3MvJ
        x4EXEFToenw0HSTielRECrMSKBRuQ1mpJiOVm4s=
X-Google-Smtp-Source: ABdhPJwwkdww7Py5G40Xq57UJ6i+9ju3eG7gPNOGMVYD3lJJ85Sv7neRHNIbGG/yXsoWkR4T/pG+zWigQ7SoKaH6eek=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:73d2:a834:c835:2de6])
 (user=ndesaulniers job=sendgmr) by 2002:a25:47c4:: with SMTP id
 u187mr82103yba.225.1631145703826; Wed, 08 Sep 2021 17:01:43 -0700 (PDT)
Date:   Wed,  8 Sep 2021 17:01:41 -0700
In-Reply-To: <20210908234751.GA8052@kernel.org>
Message-Id: <20210909000141.3136241-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210908234751.GA8052@kernel.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: Re: [GIT PULL] Compiler Attributes for v5.15-rc1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ojeda@kernel.org
Cc:     elver@google.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What about
https://lore.kernel.org/lkml/20210802202326.1817503-1-ndesaulniers@google.com/
(modified to mention clang-14 rather than clang-13)?
