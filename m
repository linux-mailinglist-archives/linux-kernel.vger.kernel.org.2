Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA26442F03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKBNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhKBNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:23:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D35C061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:20:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d21so3367573lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dczPTm8CRjx864gDRFl5nDvDcvUiz4NUX5XbHa7J7F8=;
        b=FnOFGHiBYqf/NDURwonj7/pC9oiLvv8KGyNv2yNwfP5oNaEoAXJU+erU4/kyUgP6Kx
         o0QLj+xXSbbIst6XD0CcRqIQ8JVkc4OmYc1DQn/8iiS8OlqKpCOy3H9aWv/ilu1zjUn9
         IPOLik9lPCovbFI6AHdjC/nXMx/YvHJ84O9tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dczPTm8CRjx864gDRFl5nDvDcvUiz4NUX5XbHa7J7F8=;
        b=owiOIvC8zGvv0A605g8cmThOpQX9ziUFEe8NJXPwy/Vg26aLEHzNT93uujk5rv2Qqi
         4aqPdvLA3W98W9zKVcYlCgvGW7NBs5ooqjuCSVUP8JZiJ6pWUx5tmeRZmZoz+eME0mvf
         KM9H6NdVg/UsKoZYPpaoIVlldgyrb0fXr2SxZdt7/dZRwhRWci0Iuv53WvbkRT6pyoxv
         WJyTihn5jN9w73oM58FSPagalQwfuoHi5Ty9yet+ePLyUmGl6DWMow0TigiTAUZjHZmc
         0OyYFEbA8OxYuIDRMNMEmbd0HsfwFTJ/hKPwuTHPssGaO5tYSS/RTh2+Gv0GxDZIp57o
         AUig==
X-Gm-Message-State: AOAM53215R3RLxOL/ZU+VGH2bd8+Nb8fHCsFoNRgiS5KKLjDgtbe5kN7
        08ZAdM0hLq4D4SPVADhFETqcJP8h1TVa+nei
X-Google-Smtp-Source: ABdhPJysRBCDMrP9geNJldUkpS2ZdHF3R+hV1FlJYzeiE33NCFzrN0Qj3xzWMWsUAB+9n/eIjwH+7Q==
X-Received: by 2002:a05:6512:150e:: with SMTP id bq14mr35354152lfb.444.1635859253707;
        Tue, 02 Nov 2021 06:20:53 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id a17sm1311823lfb.179.2021.11.02.06.20.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:20:52 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id bu18so25761355lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:20:51 -0700 (PDT)
X-Received: by 2002:ac2:4e15:: with SMTP id e21mr35940936lfr.655.1635859251039;
 Tue, 02 Nov 2021 06:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211102054237.3307077-1-kuba@kernel.org>
In-Reply-To: <20211102054237.3307077-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 06:20:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdE6=ob5nF60GvRYAG24MKaJBGJf3jPufMe1k_UPBQTA@mail.gmail.com>
Message-ID: <CAHk-=wgdE6=ob5nF60GvRYAG24MKaJBGJf3jPufMe1k_UPBQTA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.16
To:     Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keescook@chromium.org, kvalo@codeaurora.org,
        miriam.rachel.korenblit@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 10:43 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-for-5.16

I get quite a lot of

    ./scripts/pahole-flags.sh: line 7: return: can only `return' from
a function or sourced script

with this. Why didn't anybopdy else notice? It seems entirely bogus
and presumably happens everywhere else too.

It's shell script. You don't "return" from it. You "exit" from it.

Grr.

                 Linus
