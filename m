Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51F398D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhFBOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFBOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:42:10 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AFFC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:40:13 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v142so2433840oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWVAxqbt2ragLnej0S2guhkFqxl9f5X2TG9vofPgr5g=;
        b=pIK5I0OJGNcUZKY6fYRPbWFjK/lbB/dhyRXSbbm+CTTMFSRjrlWjvL5G5XGfbhX3K6
         CGKXNujPs93Tr1f+duXmLRro7Rtvvd3PeoeSAXXamUOCFow3NZdJtOCk5nQkQ2yerRhJ
         lAX7VU/YBPjMjMeh1RioPTnUaliC6N+lg0eaH0xWmF9VxYspJTWHZjWx1kX9HAPNSlMQ
         33kL5izgAkE9rx0Rp6qUuU8yFyE8JEVfvqBSI5MjHgAdwniQ7cKoSUlr/71XclJ92/G3
         A13Bxker1PmlMbws/jkuzEZs0rumjVtvDPb5kh1183ZsbwmdsA971Gu2+kYYPbWqqoes
         5fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWVAxqbt2ragLnej0S2guhkFqxl9f5X2TG9vofPgr5g=;
        b=mnYsKsj0aJMqQbLD/4OXiswAQEnhvzc3KQEcKiPq/9tdE0cTtCBKsHQtTPQcRjAEyB
         BfzILNx+1Oly8ruYl65ffXcrzW2zyAdyuCBORfiNDdPaPDxQdR9Bw+jrVmLM30UNi9ZO
         kgeyJo548YOkH3I4L/V3p+5EOpso7h3DQZzFpUKzEJsgOqL4uW+xenEELLpX4m3aKyD3
         ZduCBKeOId2/Q9FN8zrHcNlbuYk+1pouSFpliPgW1ZM772RI+TN7mhTzg51lo82s4UCX
         er+YAcxLSfzE1z+aqKUDp09cAgT7Ah3MUVLL62HH7VGTo6a7wzzC1Bk4lZbBh47ddW9O
         ibgg==
X-Gm-Message-State: AOAM531tZhM+7pmhRHBhENFkODLLIqjQVnboMWm6a3Pw93KSGX0pGLOj
        NoaOUI+hXABBeVx1x15Acl+IA11THg2mxnqKH/o=
X-Google-Smtp-Source: ABdhPJw9W8YmUacJHRTLRKCSRcE6AT1Zu3kRNDtCEpiYsKWDEmet6F863hn0P5W2iDFQ+YX04vhuiOFjMdEZ014wjcU=
X-Received: by 2002:a05:6808:244:: with SMTP id m4mr3971937oie.37.1622644813198;
 Wed, 02 Jun 2021 07:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
 <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org> <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
 <YLeXoQH2/iJjxkc+@kroah.com>
In-Reply-To: <YLeXoQH2/iJjxkc+@kroah.com>
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Date:   Wed, 2 Jun 2021 20:09:27 +0530
Message-ID: <CAKzJ-FPZeM1QettgDyNaXy4xXpXX0YVm1TNVaKHOopiYevALjA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Elder <elder@ieee.org>, Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Thanks for the clarification.
Regards,
Manikishan Ghantasala

On Wed, 2 Jun 2021 at 20:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 02, 2021 at 07:57:35PM +0530, Manikishan Ghantasala wrote:
> > Sending this mail again as I missed to reply to all.
> >  Hi Alex,
> >
> > I agree those are called bit-field member names rather than labels.
> > But the reason I mentioned is because the ./scripts/checkpatch.pl
> > gave out a warning saying "labels should not be indented".
>
> checkpatch is a perl script that does it's best, but does not always get
> it right.  In this case, it is incorrect, the existing code is just
> fine.
>
> thanks,
>
> greg k-h
