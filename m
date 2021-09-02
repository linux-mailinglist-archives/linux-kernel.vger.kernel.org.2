Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CBF3FF225
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbhIBRRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhIBRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:17:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98640C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:16:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d16so4911570ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFMUfBmbSDNmL0+hEJjSMckWq+RWBRj7DJeWmAldrvU=;
        b=HEjM3l8FT7i8s8RTsYSL9OPwwq7dJPL28z4Egg4c2fboPKc4808uvyuJoYMICE5pmO
         0+g+S9AdEVa/wr8F04JeXsa7JKLL1+mKN3eXopoMdHwKKjq38D4IuC66Mp7u4LnE4E/t
         ADQ53/+/iZb1B36anEatqClmIlmm6vR4ZV3i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFMUfBmbSDNmL0+hEJjSMckWq+RWBRj7DJeWmAldrvU=;
        b=gWGxZXguMqhfOQH6ta0ez1hngC3FrYkLT61jAPOgz8wysGNmKhrgcuCbwF9guJy6fD
         Vi8GorXkga1CQOtT593Wy2Gf1S7ndK1HK6qYWDuKmnm2kbBMmeUQt9d6HilTvnrzYq2I
         KELd8ELO8qJzhHnSCmp2WOZpL1e6eZCn18AqNhQHZHp6MSOuzKZc4hfGFGhwI3bkrMUY
         RNBbgWXjLc7cCATVmhLUbdwZn4b+L2gz37Xtt7ocnlZSW6ISuSab0icFwdNy7dUIWOVm
         hci+q0YsM5mtRNxs8nOMu9e9l4y6GTYCys11jZNHXq0wclzAs1ISr9aWb1Dyb0SErPLr
         gHIg==
X-Gm-Message-State: AOAM532NWvULx/Jd8H/x4dRduaTdxdBwCTxrHJkiGuves/je5UgNode0
        Ce5sdzwHZ2HIwrb0ZlOI5XihvFoei5qIa6DDY/w=
X-Google-Smtp-Source: ABdhPJxw7SC9/ARY2TAkwVXtCat4CTYB39/XdMz71zoH5Sf9mub5OWYPbSka7EmDhAS/M+ZraQssaQ==
X-Received: by 2002:a2e:960c:: with SMTP id v12mr3425093ljh.300.1630602993722;
        Thu, 02 Sep 2021 10:16:33 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id br13sm253987lfb.71.2021.09.02.10.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 10:16:30 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id s12so4972539ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:16:30 -0700 (PDT)
X-Received: by 2002:a05:651c:1144:: with SMTP id h4mr3404930ljo.48.1630602990323;
 Thu, 02 Sep 2021 10:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210831203727.3852294-1-kuba@kernel.org> <CAHk-=wjB_zBwZ+WR9LOpvgjvaQn=cqryoKigod8QnZs=iYGEhA@mail.gmail.com>
 <20210901124131.0bc62578@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <4dfae09cd2ea3f5fe4b8fa5097d1e0cc8a34e848.camel@sipsolutions.net>
 <635201a071bb6940ac9c1f381efef6abeed13f70.camel@intel.com> <CAP71bdV1eBm3f1qY0rfigK4VaW5icZ+hU0pw7g6fVM=hGbn7Xw@mail.gmail.com>
In-Reply-To: <CAP71bdV1eBm3f1qY0rfigK4VaW5icZ+hU0pw7g6fVM=hGbn7Xw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 10:16:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whog7gH+7TZ+QfB-U=mbqg4QkHB6eNad9DjPX0hgheydw@mail.gmail.com>
Message-ID: <CAHk-=whog7gH+7TZ+QfB-U=mbqg4QkHB6eNad9DjPX0hgheydw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v5.15
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 10:07 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> I can confirm that Luca's patch fixes the problem on my system.

Yes. It's merged in my tree as commit 75ae663d053b ("iwlwifi: mvm: add
rtnl_lock() in iwl_mvm_start_get_nvm()"), and I no longer see the
complaints.

           Linus
