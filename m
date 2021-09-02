Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8273FF093
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbhIBP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbhIBP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:57:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945AC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:56:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m4so4440504ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tWcVr7MLDZpPWzTOZpOUAoFHRjrwNvs4WRjRVjOspg=;
        b=KH1wTSYYNkIIXj+dSMOI6DDJtdkIeI2clasBL4nA439Dh+mKKlY9U04v9ebJp4MYST
         CHwk0Nup2Ft9gHLzEZcJkVEeSKPc6O+xfdkR9RqfkLQTs8lC0MleEEr6ifDXTYX76hG/
         n1hszphKMMnGTrGLBeiQVXqZN9sPWHA1nyQU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tWcVr7MLDZpPWzTOZpOUAoFHRjrwNvs4WRjRVjOspg=;
        b=nAM53PcXRhVOGx9JNVzAxlilCweiWw6AV6HtZXELjbD3xakiCizpEoIp1dern3nzmn
         SZSNM9M/1VldCK5CZOQLP1Ojrt7aSGG1qlty8rF/lSYjua4n+/xbwBxSWqUUuCQa6x2H
         4HkH/ZdK/53OdUEcyQZxgIi/OjAlmU49ZWs9cxzhkvdQt1+V4d6y/uzO3ibQAsVabK/7
         aancz0jP5WrXow7egX/mOmb6rDVJVxsZbMtGST5L84T0xmKttBV/zIrmomBToqIQKz9c
         6IoQvmaYAy1+pZIS+HHcglmkWy2Y4bzkJvWAaewr2fZBuINcDsjCWddRjC0LVYl8spnG
         q4tQ==
X-Gm-Message-State: AOAM5321Ao0Pf1Mvges8lDoCGMWBPJIl1+zX4E7isABaEI35zczokheK
        Yt5OaY4SOKHvGZbvQJbGbynmWuvdnRZPmA+n
X-Google-Smtp-Source: ABdhPJyiClE36bhsqBM9GWtVIjZAExSA6gIIibHb+HwqbRzcH62yre9AlqJ5J1Tzuioy71lw5C/xTg==
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr3199338ljp.369.1630598168209;
        Thu, 02 Sep 2021 08:56:08 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l3sm233368lfk.245.2021.09.02.08.56.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 08:56:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id m4so4440359ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:56:07 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr3161301ljq.507.1630598166945;
 Thu, 02 Sep 2021 08:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <635201a071bb6940ac9c1f381efef6abeed13f70.camel@intel.com>
 <20210902101101.383243-1-luca@coelho.fi> <20210902.113908.1070444215922235089.davem@davemloft.net>
In-Reply-To: <20210902.113908.1070444215922235089.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 08:55:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5g9+-0VJCMYZR8DNnWpip_PZtMTxyUf8_dz_t_pWCfw@mail.gmail.com>
Message-ID: <CAHk-=wj5g9+-0VJCMYZR8DNnWpip_PZtMTxyUf8_dz_t_pWCfw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: mvm: add rtnl_lock() in iwl_mvm_start_get_nvm()
To:     David Miller <davem@davemloft.net>
Cc:     luca@coelho.fi, Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        miriam.rachel.korenblitz@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 3:39 AM David Miller <davem@davemloft.net> wrote:
>
> Linus, please just take this directly, thanks.

Done,

            Linus
