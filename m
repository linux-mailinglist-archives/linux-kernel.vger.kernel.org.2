Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8B3CB061
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhGPB0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGPB0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:26:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:23:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 22so13179472lfy.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwM1T+8Px0FLEGXWA6zrhkQm5HdM2ArGoJTAqP8zhhM=;
        b=bOAeC7egClGteDwWbqiswPawoH7i+SRUVeXxcWVXxnOr1WLw9CE+ulpGnPyaApeDGY
         eR71JMdMltJEdM+2w6XQA57uqchLFRO5ZDCxc/QhgxzPCBG2CI2DwtVIklatUWH5mVwm
         vYSZLhzWvie85hoxZnxnHeBhFgbWcSf51dBtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwM1T+8Px0FLEGXWA6zrhkQm5HdM2ArGoJTAqP8zhhM=;
        b=WipRtFUT8w4qR6bSqy4qoMhGKRerkrF3Si9g1iful2gOpof0JcWGXUkR5zSdhERWwJ
         bMBDKM76dkPmCOXr/lTdGJxNXmGw0Jcdlm2DyXZNV33xqusrB4L3qMA4sRM/T5ZPYu7p
         qePjY6kEPBVAKkw9uIQyJBYW33zS9O21WjN0C2XbsWDTxrHDhS8UHxMYQy4AZgJtmCMU
         6cnOqYlajsyrUXrwVZl41Gff/KH+sudaE8AlCYcQn8yV3ejfS23iEQGw2Pk5Ypd8wSNf
         67Y+GRJ3VDI+nUT7IcXpjIP/kwluhh8U/iCH2Bff5JNwQd1VW+pedmYUZJmoopxbT8Zz
         mPjw==
X-Gm-Message-State: AOAM530sKBiOdl+AVY1cJ9CZF4SEWVlJMX2nH2gStUdFm7B27RWTiLHT
        CA5XeHijMKEZV2yCHLtiwAm6VFoGbTcy8c4A
X-Google-Smtp-Source: ABdhPJytrCTJaKHVRJbRCgebxc4lohNFITgUpZ4e1H2aqLVh/qqu0SoiDVXQuJnM3SACRs0pjTXIoQ==
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr5531180lfo.651.1626398582454;
        Thu, 15 Jul 2021 18:23:02 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h22sm796857ljk.133.2021.07.15.18.23.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 18:23:02 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y42so13267851lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:23:01 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr5671088lfu.253.1626398581772;
 Thu, 15 Jul 2021 18:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210714200523.GA10606@embeddedor> <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
 <5d170cc8-501d-0cec-bf03-2f53108a8486@embeddedor.com>
In-Reply-To: <5d170cc8-501d-0cec-bf03-2f53108a8486@embeddedor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Jul 2021 18:22:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8GqP8ughGBbwcyrBNNdtcXVo_G=XjQ1MAUVUuJfUtGg@mail.gmail.com>
Message-ID: <CAHk-=wj8GqP8ughGBbwcyrBNNdtcXVo_G=XjQ1MAUVUuJfUtGg@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 6:14 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Kees just opened a bug report for this:
>
> https://bugs.llvm.org/show_bug.cgi?id=51094

I don't have an account on that bugzilla, but it might be worth adding
the note that no warning or error should EVER not say where it
happens.

That's the thing that made me pissed off in the first place. I build
my kernels with "make -j128", and if the warning doesn't specify the
filename and the line number, the warning is just unacceptably bad.

How can a compiler _ever_ give a warning without specifying where it is?

The fact that the warning is also entirely wrong-headed in the first
place is just the extra cherry on top.

But at least it should hopefully make it easy to fix in clang - just
remove the incredibly broken thing entirely.

             Linus
