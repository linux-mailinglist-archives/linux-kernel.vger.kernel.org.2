Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475333E1CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbhHETah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhHETae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:30:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8BC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:30:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b6so13179914lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/RddrnSiQlKYlUaXMtukJmyIUY69TH1cBRlEevecY0=;
        b=MCKUw5JBk9VC4LN6XLDfphfslksKy/gZOgkiN1zcwO4T+i+hYHKPj+9n1Hwiahdt9x
         EbNckV58u6O+VlvHLa6Fp1cv7gDFPdHlG08kDZhkYZJQr2i86HsKunPxGh3YKkhaFySL
         FSDFYbjak0pzDzB3CA3dBABzxXa4UOLUqeVC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/RddrnSiQlKYlUaXMtukJmyIUY69TH1cBRlEevecY0=;
        b=gEo7yH3ihvYVZR4++64V2+9uIrym+p+zK2MG0803WzuYJFt8vvLWyLx3w+Gts6QTln
         7FAXEoHOBNY/UhSakPEqlSUaUmDJxYy4S/gRP7XWphzhLG7XPIKqrkH5M6qqypFAMnrm
         nNX225GPiSddGdx23lXGh32b01QqxMtrEgiXSPJM3fZtzdygFcjVGqxNOWF1UlK83gIk
         0lFZEI1lk+Odp3IWWa2UbCt+qaCa6woQVJF5t3bpNlluzn1bp3yOI5MkXJEkMJCiQe4q
         sIwChv4jkUhbtPl+nRVmVEcPfEwSpLflUheWcUkeBQ4K5nvwZPe5UdPMCypqkc9bEFO6
         sZJQ==
X-Gm-Message-State: AOAM530gjiLJisfh53/ACNLHTMy1HgOK4oLuBBRHvMmjpY6utMEIIxab
        V5OW5jh9VK6J/7I6/xuzV/QGyuS8MwTqALV0o3w=
X-Google-Smtp-Source: ABdhPJxWPQdNVLOJGuLn0fIR+9OOaw8XfWQNgz9YD3TABfrVKORPB8weZE2a1tOUcTATZT6s2XSgWg==
X-Received: by 2002:a05:6512:2026:: with SMTP id s6mr4754594lfs.173.1628191817488;
        Thu, 05 Aug 2021 12:30:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t30sm598747lfg.289.2021.08.05.12.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 12:30:17 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id g30so8962232lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:30:16 -0700 (PDT)
X-Received: by 2002:a19:fc06:: with SMTP id a6mr4662858lfi.377.1628191816465;
 Thu, 05 Aug 2021 12:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210805154335.1070064-1-kuba@kernel.org>
In-Reply-To: <20210805154335.1070064-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Aug 2021 12:30:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8ufjAUS=+gPxpDPx_tupvfPppLX03RxjWeJ1JtuDZYg@mail.gmail.com>
Message-ID: <CAHk-=wi8ufjAUS=+gPxpDPx_tupvfPppLX03RxjWeJ1JtuDZYg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.14-rc5
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:43 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Small PR this week, maybe it's cucumber time, maybe just bad
> timing vs subtree PRs, maybe both.

"Cucumber time"?

Google informs me about this concept, but I'd never heard that term before.

           Linus
