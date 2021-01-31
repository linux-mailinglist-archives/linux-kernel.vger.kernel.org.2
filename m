Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81C309EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhAaUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhAaTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F5C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 09:22:24 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p21so19568299lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=38mDXl4HxVSt6bH36Q3sea0vO8kLUw4mr0l5Ac2TSrs=;
        b=c9lvLWEHPflBNd7P3pklMadbcUBDr73cFvrCXgxKJkf3sExcEZ8glZ1gC2QxOcAeWP
         79d3u2TP8tLWjhyslNS0z5ry5aTU15fEWzgUO0++JDttSeq69t6R8xxHMZALEFzpzKgK
         hEbXe44f3JkSJDW5aeJwRUcwmcOS0E7+oUASrw6xLxMwW0kMM6RzSTASWgsVZ+9dkjeQ
         eiOFyUJB6nuO4MXcGnDuE5U1JLkDiE5PmQ1I6PLGKBcF6iI4lpghvBMUKTf3MkAiD0w4
         QZQC1tpXunU2qxkc4iyb/VM/MAS6hvfBCDisgNj2EiLVBX6cGXKx25SP/a7zdydx1Hij
         66iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=38mDXl4HxVSt6bH36Q3sea0vO8kLUw4mr0l5Ac2TSrs=;
        b=qFkzXuNOE1m1krLBfVD0/6rBi8QibuqOpYz+E4TkSXp1/MFeCm/EwVk4A/fVndXtlR
         JQOA2MJkOFiaX1wSWwxh96chNg+G0u39kY42Cxr0hwon/UpaX37oOxW4VPC401pADg2X
         fdSEHbt+c0KZk/Mulu2CSyIRFDZRZoZ5zziR0vCAGRIe5opdEJdGm6a2zIpV8UqXzPg/
         I227R5merrnL6pT1WfEeTMSXBHypSc05JI4nY9MUvz3sdpntOj1k76Jm26Wq7myyGipi
         0QYnYvdxR0ITLiEvsS5yOWrfPlapZuvLCwZujIxtm7+byL3YlkUyyylVScoA6K+VCpSo
         14+A==
X-Gm-Message-State: AOAM5317E1W6+R8N8is0WPX2S/JLcnKYXSOTPXEpv7FM0Txk8HJg3rOh
        3DKbnyCL/Uc/lUJUPnL8ysiPuKuSuokeTb6oRO8=
X-Google-Smtp-Source: ABdhPJzNP1XSSygZR6YXN91nVNKzcrR0FSDDIdn9sOOSU9DNEfm+cPg49aGzN3dtN6WqtW7Xxvnd18DlqZfMTwThhqY=
X-Received: by 2002:a19:804f:: with SMTP id b76mr4370348lfd.491.1612113742748;
 Sun, 31 Jan 2021 09:22:22 -0800 (PST)
MIME-Version: 1.0
References: <2nft2kipqg.fsf@aragorn.infrastructure.cah> <983b87d6-edb8-21ea-7d6f-f653f5c0d048@oracle.com>
 <20210129005129.GA2452@mail-itl> <44068a70-8940-824b-9e39-b800635b92c7@suse.com>
 <CAOQxz3w-2aJn1dKbQRG8_m8f3_pN0zSXzYkfyU7cvo34vF6P=g@mail.gmail.com>
 <16a2f371-1c39-13f5-c214-e054b08abbab@suse.com> <20210130232513.GA6354@mail-itl>
In-Reply-To: <20210130232513.GA6354@mail-itl>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Sun, 31 Jan 2021 12:22:11 -0500
Message-ID: <CAKf6xpsjaQdhgKPp=pDz==-qmrVt7ng1Qq328bZvTywdS+2KVw@mail.gmail.com>
Subject: Re: Problems starting Xen domU after latest stable update
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Michael Labriola <michael.d.labriola@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sasha Levin <sashal@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 6:25 PM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Fri, Jan 29, 2021 at 03:16:52PM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> > On 29.01.21 15:13, Michael Labriola wrote:
> > > On Fri, Jan 29, 2021 at 12:26 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.c=
om> wrote:
> > > > If the buggy patch has been put into stable this Fixes: tag should
> > > > result in the fix being put into the same stable branches as well.
> > >
> > > I've never done this before...  does this happen automatically?  Or i=
s
> > > there somebody we should ping to make sure it happens?
> >
> > This happens automatically (I think).
> >
> > I have seen mails for the patch been taken for 4.14, 4.19, 5.4 and 5.10=
.
>
> Hmm, I can't find it in LKML archive, nor stable@ archive. And also it
> isn't included in 5.10.12 released yesterday, nor included in
> queue/5.10 [1]. Are you sure it wasn't lost somewhere in the meantime?

It probably would have gotten in eventually, but I made the explicit
request to move things along.

-Jason
