Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC23EC46E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhHNSTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhHNSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 14:19:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA1C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 11:18:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z20so24337630ejf.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwTwNa68q3D0CQBjSY7s+KH59ivLkffGCGL24NHGJ/w=;
        b=WRZPLeSgDAhjSqVYzVsciYjnoMAlLeGqz4xvSeJOFvV3qvd3Qr7jOB/LnJ7Hi2kYHD
         a2JVnFPoMUMo/9btDEAaOzA+nlDADVKrdjScvF+XzQ+29+8Z+s9t7XMRV0ng1f1XlpcB
         MVJrzO8LImmdEpmry5NCxov4iNrP7VncpENDQi9urO3XTEPuO3+y4fJWTc6azBjm5BVw
         vDqTTm1nQn3ZNBNWy6wIL+oCRA4/V838++s01peOwzDgPd9CPSWwM62TRy+Q+QD3p5tS
         MhvW5gpfX12YleSafpCNuvzLJhNmOpvgrd/vgurGN6ZzzEdDxHYEYONR4jWyqOgcxAvI
         XJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwTwNa68q3D0CQBjSY7s+KH59ivLkffGCGL24NHGJ/w=;
        b=MP4BYKb0aVgrq80a3ylMMo8M+9w8ZpWxyV2IUYCuLH8Ban6IwdagIVdRlRsT8H7r4w
         mYEgxWnYQjHu/CQnOnjhSnZhd6gntbmJPPhL32Jk8+o4jw5PtLYZvX92vzplHF8Q45aj
         9QT8g0VHnxbxnkfDjOdLQiZf+Y0/uQ3JGe5cBKalEcZzRsvTRMTVHKBLjiiSCjOpeSa9
         b1sTgfcYCILbWjK8NrGWJlfNciI+BQ0ST+IEtMD4QhwRRB2GFbzoO4Lr67Cfq8MEbUe1
         N3Y1lvInmwwvn0krVCdyZUVu9ilNuiV4QIrtQPiE2LKDQqyMNAD5PExMlBU7cilY9uXU
         uc3Q==
X-Gm-Message-State: AOAM532SQCN62UxBQKMdhc5UiucNMWG4Z9EkEp1Fd9QvYvDe5mdmkXBl
        1J5jYSjtkbRYJqarCiH7ZcY=
X-Google-Smtp-Source: ABdhPJwmUsJLLd7nqyCKi5XVQBvBfgH27+SptBGP6UmIAP5YKxr/AvyiZ7TIFDfSyudgVCZJew/IZg==
X-Received: by 2002:a17:906:c4e:: with SMTP id t14mr3648887ejf.436.1628965118531;
        Sat, 14 Aug 2021 11:18:38 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id r6sm2531968edq.20.2021.08.14.11.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 11:18:38 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] staging: r8188eu: (trivial) remove a duplicate debug print
Date:   Sat, 14 Aug 2021 20:18:36 +0200
Message-ID: <4137099.1RPUidUiak@localhost.localdomain>
In-Reply-To: <CAA=Fs0kyzRjR1b_QfseyKE4mAp4W-Bxa97esf5QDoUFiOhA-zQ@mail.gmail.com>
References: <20210811201450.31366-1-martin@kaiser.cx> <2555683.U4YhqVPOqN@localhost.localdomain> <CAA=Fs0kyzRjR1b_QfseyKE4mAp4W-Bxa97esf5QDoUFiOhA-zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 14, 2021 6:54:40 PM CEST Phillip Potter wrote:
> On Fri, 13 Aug 2021 at 13:42, Fabio M. De Francesco
> 
> <fmdefrancesco@gmail.com> wrote:
> > On Friday, August 13, 2021 12:05:36 PM CEST Martin Kaiser wrote:
> > > Hi Dan and Phil,
> > > [...] 
> > > > > Just my personal opinion, but I'd be inclined to strip out all 
DBG_88E
> > > > > calls totally. If there are necessary functions being called such as
> > > > > device_may_wakeup() we can always just keep this part and remove the
> > > > > macro call (not checked this function out myself yet). Thanks.
> > > 
> > > I'd agree with you, Phil. Most DBG_88E prints don't say anything useful.
> > > 
> > > This comment from Greg made me drop the DBG_88E removal for now
> > > 
> > > https://lore.kernel.org/linux-staging/20210803201511.29000-1-martin@kaiser.cx/T/#m05
> > > d82a 0ca8ed36180ebdc987114b4d892445c52d
> > 
> > Hi Martin,
> > 
> > I think you misunderstood what Greg was trying to convey with the above-
> > mentioned message.
> > 
> > Well, he doesn't like to feed developers with little spoons :-)
> > 
> > I'm pretty sure that, by "Why not use the proper debugging calls instead 
of
> > just deleting them?", he meant you should research, understand, and use 
the
> > proper APIs for printing debug messages.
> > 
> > Please check out pr_debug(), dev_dbg(), netdev_dbg(). Use them 
appropriately,
> > according to the subsystem you're working in and to the different types of
> > arguments they take.
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > > A compromise would be to remove only those DBG_88E prints which are
> > > really not helpful.
> > > 
> > > Best regards,
> > > Martin
> 
> The problem I see is that this driver is so littered with unnecessary
> macro calls, how do we decide which ones to keep? In my mind, the
> better option is to remove them all and then come up with some new
> ones in the vein of netdev_dbg() and friends. I could be wrong of
> course :-) I tried going down the route of keeping/converting some to
> proper calls such as netdev_dbg() and the issue is a lot of the calls
> don't have an obvious value anyway.
> 
> Regards,
> Phil

I think that you'd better remove only the ones that "have no obvious value" 
and convert the others to using netdev_dbg(). Obviously, telling which have no 
value is at the discretion of whoever wants to carry on this work.

Regards,

Fabio


