Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5E311F0E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 18:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBFRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 12:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:10:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287E7C06174A;
        Sat,  6 Feb 2021 09:09:31 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id s107so10126396otb.8;
        Sat, 06 Feb 2021 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbFT243mI7AiARSf3wYUyklIqlMRugc2QUO9QFrosEs=;
        b=IApJfL7FyU4Ku+vu2rUSqLaY+SZKakMtPlULBgjEI5m4e+9t9l0+qdCeIrDd3tui0s
         1Y/XwZZrp8j+Y0cwR0nMnqcS1HW5NxyMjieraDb+N7iOqZh5fx8WnucpRjoTg96R/qxQ
         062Wt++bSGoQLGyqE0oUF192IzVa9EFffGnJ6lspmfhU9DqAiME5D/E7fhnjYiF1IOnh
         rsOuyB2sgPt8nSq9fUFI81YzjbcHv22nPLeSVzcjeIRnd3Xd0QP08/cOD5KKUa9FU0gY
         feNHtkY+YHB/+wM1ACq/vQjeuAYY1BlojZUeW/FSMxlQU8XIEdi4w8F0kxRyGo80C13F
         qW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbFT243mI7AiARSf3wYUyklIqlMRugc2QUO9QFrosEs=;
        b=rwJyhNWVxWLN6Ihfo+hrovtQFKUVUu9FBwDn4sGWW9WsU5N7GVV2lwh6eEHmRfvHDt
         tMOOKbvsxUfzNM2CdJAhIbGxFM9TgHSks2cIO03zSYnGZuKT9amldYOXKaIzP12qWVzY
         63jM9CgLjsu3w9blTkFfw963bPno/p2qNc7inviPgVjH+1TRGO5kH0QqlIjuE6GVbCjX
         6O7ajdfTmHxGTwcaF6gR4dWB5EMtSap/a1O58fn1PUsvmEgrapmbQOpMTGslXPoAw4f5
         sxI5R5u7+Iuys2QnMPxn75h1XazgU/jogK7JgWHYWTYuShE5oRt4koGgvq8Eq7yIW/Af
         PsNA==
X-Gm-Message-State: AOAM533b9cr9zLhSZGOWhzuWJImpV5ZJPPu3+OHPYyiJxVYTtCGpDnrT
        jzd5DtLQ7nVgKAc8HpKwRkcYUS58hdxLy8Kfwx8=
X-Google-Smtp-Source: ABdhPJzPVE47QMMSkvFDGpJ1bGbxoCCLV1g84yGYEOZirC9G2RShxELbX9nzGITyNIOaKVyvYl9Y40a4ezfMoVPleIM=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr4225038oth.254.1612631370618;
 Sat, 06 Feb 2021 09:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20210205220618.611388-1-enbyamy@gmail.com> <a3215a2b-76d3-6285-8072-160a905de362@physik.fu-berlin.de>
In-Reply-To: <a3215a2b-76d3-6285-8072-160a905de362@physik.fu-berlin.de>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sat, 6 Feb 2021 09:09:19 -0800
Message-ID: <CAE1WUT5pXOH=wjzcXBZ4YiFoVv6Xyb1sT5mxdm=NR1A1MqKgjw@mail.gmail.com>
Subject: Re: [PATCH] ia64: Fix style guide breakage
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     schnelle@linux.ibm.com, corbet@lwn.net, mchehab+huawei@kernel.org,
        tsbogend@alpha.franken.de, linux-ia64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 6, 2021 at 8:07 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Amy!
>
> On 2/5/21 11:06 PM, Amy Parker wrote:
> > Some statements do not have proper spacing between their C
> > keywords (commonly if and for) throughout files in the ia64 tree.
> > This patch corrects this to follow the kernel code style guide.
> >
> > Signed-off-by: Amy Parker <enbyamy@gmail.com>
>
> I never noticed. Does the kernel coding style guideline actually require
> space after "for" and "if" and similar statements but not before function
> names?

Yes it does, actually!

> So use a space after these keywords:
> if, switch, case, for, do, while

> int system_is_up(void)
> {
>         return system_state == SYSTEM_RUNNING;
> }


   -Amy IP
