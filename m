Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1C31BA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBONvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhBONug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:50:36 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5739FC06178B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 05:43:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t63so6387570qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 05:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUY/mk1Lc8G78pgBS2Mx3NjfEuV+qgOPeV5BhtagDQU=;
        b=d3oq4pH/F36Pnfxw8LFnft/6C40f2NyuTx5tsiCjUqEJuMfkxR0hMYfxwrsSdiYDLw
         z7jOcR5Dx21ni9aFGTLRqqLZhS3AgAIG5Rj67PA4/Bt+6LNqZyGI+p/jkjh/KsJ1qa8J
         L9PURCEku8u+32fSdUmg3Z5e8GghXQfbDoi761K9lDi7XgsvjP7Z4qJIS9fXZGKXET0E
         /8kRQPjAWSM2zqrNguwD0S5cS0yAz079SdrpN730F6QIXDUfqMdkKo5wZNuKF61+HG7T
         d5VoAmgUcdUBNFrucfXposBo9VKXiAAjyo0NmTvj/5xsx0y5HOVzVCdLzXP/TirzSZLQ
         Mi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUY/mk1Lc8G78pgBS2Mx3NjfEuV+qgOPeV5BhtagDQU=;
        b=a0bredBxecpbWTX1fUUPGgme8CUEzlB5yk+My7WZMTmoY0fdHrrtVW88G0pJznbGej
         Czt+0QpEAqE1HMh3hzoXFWEVtYv7awAtgNFzauabRFyNOohGyDnPijmagQzoSvDBzm0w
         5IJbBFKt+99VdCDoay4LGMEjVIwXs+rMosLJTCR3K++pEvSfy8FtjnIBB8sZ+TSP1/8M
         61jqj1O+sfUFeuK2fwBeuahLYjrBurhbG2eoyr+XiOOuVd2XpOR3osRzBkuMWC+AvMKH
         2PvzlGXdEHBYIzjpfoBxZ4N66DahuJPa9EDU9GqlQhOL5DxMSAH/ggqTLfX1zJYiO6AW
         5Ztw==
X-Gm-Message-State: AOAM530tI/nxgbcijGuEvFlu9zqmdPqPc2zvVdF8fiJ6SGjzBDL/gGQQ
        8Kk7z2TiYWfgbSF3HSatjdkk+SvfVCTiB+DmCT8=
X-Google-Smtp-Source: ABdhPJway5dC8YnY6EDt+sovapZvXabHX7uKu7byF+eRzFpJoTdRrtkbN3oRQ6hjTJKgatfekIJKwiZK0+qpQT/iX/4=
X-Received: by 2002:a37:a20b:: with SMTP id l11mr6003460qke.237.1613396606583;
 Mon, 15 Feb 2021 05:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20210127200319.662842-1-tomas.winkler@intel.com>
 <c8d0f22c5fdf443cb8dda1f996b148d9@intel.com> <1776363776.325713.1611782270873.JavaMail.zimbra@nod.at>
 <a6cb6eb10bbb48989d3a9e087951e50e@intel.com> <1665542284.336646.1611820031174.JavaMail.zimbra@nod.at>
 <f91d7eff1d764ba7b47f023bc0fafacb@intel.com> <20210128100032.5eb542c6@xps13>
 <10c2e98c393a486cab3bc953e9926e38@intel.com> <1363048722.339069.1611865409332.JavaMail.zimbra@nod.at>
 <783a45b0bc04483e9a0a6bb0a083bccb@intel.com>
In-Reply-To: <783a45b0bc04483e9a0a6bb0a083bccb@intel.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 15 Feb 2021 14:43:15 +0100
Message-ID: <CAFLxGvyjLejD8LSGnrEaBHv8=XxD9HH7yeTYjO3Si8+WMCU2Nw@mail.gmail.com>
Subject: Re: [PATCH] mtd: use refcount to prevent corruption
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 6:12 PM Winkler, Tomas <tomas.winkler@intel.com> wrote:
> > Well, the trick in glubi (and other MTDs with "hotplug" support) is not to
> > reject removal of the sub-device. ->_put_device() is of return type void.
> > The key is grabbing a reference on the sub-device in ->_get_device() such
> > that the layer below doesn't even try to remove while the MTD is in use.
>
> I understand that. But in that case the kernel is in the mercy of user space to close the handle,
> the whole perception here is that of hotplug that the device is  physically removed it cannot wait
> for the user space to complete. What's the fix is trying to do is to bail out gracefully.
>
> > > so we postpone the mtd unregister to  mtd_info->_put_device()  but it
> > > that state we have nothing to hold on as the device is gone in
> > > remove() User will fail anyway, as the underlying device is not
> > > functional in that state.
> > > Anyway I've tried your suggestion, the kernel is crashing, hope I
> > > haven't done some silly bug.
> >
> > Can you point us to the affected code?
> > This would help a lot to understand the issue better.
> > I'm sure we can find a solution.
>
> Got green light on releasing the patches will send soon.

I'm eager to see them. :-)
As said, I'm sure we can find a nice solution.

-- 
Thanks,
//richard
