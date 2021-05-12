Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C937D07D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbhELRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbhELQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:10:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED9C061232;
        Wed, 12 May 2021 08:49:13 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h202so31234763ybg.11;
        Wed, 12 May 2021 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1LgsqPi/5J34aRfiQ4OAfRKOwxu94hxIuvDDA8q2eE=;
        b=mW18cFKa+9JkzCXo84G2iq2LurpHEMcQ7tyBVv9Kg8ZpY2G2JxZY7V5LvPzfMm+KTr
         x8Dbxo53Dv2S9FFAcUhtmlgim6RpOxE2Os1PCkVRli9jm5GFgo+NLhSE/9ShcfHBuS+3
         +hngoZ1DkCy+B4vs2RcoReX3Kib5FMZt9wiqB8LZ4Sg3zkHzii5GjBHhcdRbqcMnX9Vf
         S125+5w8dMaXNkpgiQB1bmQM68HD8wTqYKM1BF70IzQd5n//eFa/hCdqIdSSaAKDW3nv
         if+tG3PZdUZmGMw7D66YMIlCGx3ZzQqd4QGkd/+1v/rrWCR281UaIKFfKaqbxfqmttk7
         OMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1LgsqPi/5J34aRfiQ4OAfRKOwxu94hxIuvDDA8q2eE=;
        b=aTFLQE1d6iU/pEu8bcqq4q2bfI0FjRhK6y3PqFQ4X6F2apJ3khPF29UsdlAok6cyEb
         3tUYB0smBRBSI/Elz3yNiFyihtgvoHq40ABXUy7L3CRKI2CrtToa4WXGorAxqVe7/yLE
         eI5nR7NDRwArEaD4iJNIC5e0augFa25KBkB5UDyEKRugIDyvsDcmJSbV6OgKCz5HIR2r
         vcbm00t7lDsMksbLtWXFuZHuJ7yg8rf7k3nlPEsTHmQ+GQtqTLxxUMP6VApQo8b5gEz7
         b7whylVxeT+mBTneKJsLf2/kUaC0L3k0Uu0/A5cnpfKipJU3LV6hTmIvd4xUU5qV2fYA
         ja+g==
X-Gm-Message-State: AOAM5309Can9cHcOvEzkqlP2Eo/lLiLN4PFN5tlnLb1yQZbgSh/uNiu7
        besRYabcSXp1blJ7vZ87CVg8HBGNkhWOUwUsHGk=
X-Google-Smtp-Source: ABdhPJwxGIrTb+lFdWzSts3+FwNXEM+hGK8Q3w1KtG+ooNHiPor89gdXv1+juyiaCdugXS0T28vRUl6K8aHiEE+lK4s=
X-Received: by 2002:a25:abe2:: with SMTP id v89mr27927426ybi.26.1620834553261;
 Wed, 12 May 2021 08:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com> <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com> <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
In-Reply-To: <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 May 2021 17:49:02 +0200
Message-ID: <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Schlatterbeck <rsc@runtux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 5:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Seems like so far no one has picked this up?

Queuing it then.

Cheers,
Miguel
