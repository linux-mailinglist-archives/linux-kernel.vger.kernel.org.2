Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC97309EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhAaUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhAaTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC0C061A2A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:27:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a8so19830612lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6H5fcOYsCdCMeYtK9w3yBnEADl8ww3PIrbmNmUj0zc=;
        b=VP+jz4z48jAJrpEvYsTpMFNfMe2qxiAH1/I2a2lexKBJP3F2grNQr9PHwlif8mGFi5
         53a+hzhGsyG7FnQz3m/eADFq1z2nVcTaqrDaGnyTMa7xpBgP9LyDZ6sacoXlrR6qFfKZ
         +z6/8PmqcVKJ8EcHlmju64NeVLWhA1ETHUmQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6H5fcOYsCdCMeYtK9w3yBnEADl8ww3PIrbmNmUj0zc=;
        b=jW3Av6G1yyIlTNMCvTunpFshQACk6+PO354g02vyZt4NlxnZZhO5aXPLAr06uAIpEc
         s+IAc75+HlENTdNYFe/VH/y7efgmlw8mLrf7Hz526h5oRxoK9QwiJyj09TcG82q3E8/f
         FUzNL0Cl+QoJmtbKG5lBcHwzbAtCdtNN2o9qIgoDs4WHUqwGKlIiawbI235lT126dbYR
         vmQ1fu83H0LAkzDLJjjnZ03g9J8FgwGA06pKCxrVLIhVsL5MB0Toc885OgXpIWQuKzgO
         VI2lIa3UdtniBAjdRvgNd1rHgQkFy2VtI+AqmKzq6dkHBe/R9LA2il+iXylmy2rpN7dl
         Ky6w==
X-Gm-Message-State: AOAM530u/0Se/FNHW216maayGELM7pE9c1BPh5YIv6nVbfMfeYX2+gys
        b2MBl+xoV7JlhiJ9EOWDWR1guYC/NBYaYw==
X-Google-Smtp-Source: ABdhPJy6zdzdUrzKWIqKGrBGQwLa/GR3fJPJixCj8L2ktPmmhzaBrC2Hix5xIkOFMpRIbpC/Ikhvng==
X-Received: by 2002:a19:40c7:: with SMTP id n190mr6551725lfa.635.1612121251706;
        Sun, 31 Jan 2021 11:27:31 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id u4sm2765171lfc.277.2021.01.31.11.27.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:27:31 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e18so16908377lja.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:27:30 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr7966866ljo.61.1612121250410;
 Sun, 31 Jan 2021 11:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20210131105914.2217229-1-alex.popov@linux.com>
In-Reply-To: <20210131105914.2217229-1-alex.popov@linux.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sun, 31 Jan 2021 11:27:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibeoCxGOaHxmEnFC=Ar45=qAwu2myrTUCiF3iiYKPs1Q@mail.gmail.com>
Message-ID: <CAHk-=wibeoCxGOaHxmEnFC=Ar45=qAwu2myrTUCiF3iiYKPs1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] vsock: fix the race conditions in multi-transport support
To:     Alexander Popov <alex.popov@linux.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Greg KH <greg@kroah.com>, Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I'm checking lkml for at least some of the emails that I'm cc'd on ]

On Sun, Jan 31, 2021 at 2:59 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> There are multiple similar bugs implicitly introduced by the
> commit [...]

Note: this got eaten or delayed by the mailing list issues that seem
to be plaguing lkml - I'm not seeing it on lore, although google does
find it on mail-archive.com.

The maintainers are cc'd, but it means - for example - that if
maintainers rely on patchwork, I thin kthat will be missing this email
too.

            Linus
