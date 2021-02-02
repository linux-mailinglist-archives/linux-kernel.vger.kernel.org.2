Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9430CE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBBVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhBBVqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:46:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26133C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:46:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i5so2415191edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vykfbz7/KbotLyXDV6UDBOVFIIhhqEAPP4iNreMMRi8=;
        b=cTrK9NT1I4L5XvGBsX9/96Q8xL0d4ldCBYjlJ/hLt3TQFRwtaZ70F1K+bbMZTMTr2C
         RZ9TQMtF2esxFFSy8KDt2F00wlXJZKoo/IZ3ZM2XIsHP5A3QhSKKI2xfFtl0e1yCimrO
         Zf0rlrl6O6B43IkXsVaSv4E9tE5TLxR24+zhcuyYex1g/50RGgptalfMb5wlK0YOd9mY
         XmFaoEDj6FBKVN1jdAZ9qSJKqsFfF3IRGWPGXmq5eBUvCtgLLCEjgoXB+QEM1M/CdUjw
         GoFOYSD3Qt/snkBnE83qRek65mBAvFiqhEU3oXiPr5QsezgfjhHLUc2KWWS+B3+7yNpV
         +UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vykfbz7/KbotLyXDV6UDBOVFIIhhqEAPP4iNreMMRi8=;
        b=H+nXEKNFFSnYClrulTHGWC1AFjM0BGXUVAqgF9+SzK1rD+RLbq6ONnXZZdecIzHv0J
         i+RAM+06rhxjNIXMhEDHyhG3Tb0G7sH+CrrH4TArsErOSH514AZaoX8tAoCq7IrVqE/E
         KFBWobbigCm3ySMNeCYd9rPy2/AI67UTE9iVg5/vgtqheMgPsGPOK840p5Nfp3dDQqNf
         3kGrrsQRZBidCIagjuvhSmbSuHzJ8+o9xv+QH6mbcKiHghpN0BXg5g89X9YtixV8ctwg
         HiJPbdpIE7xAT42agEfvDLZ6Sy4ZIKRWrvmLk4jYMPw7CYsNBJM0A3a42MsXNgLel0Xx
         2jDw==
X-Gm-Message-State: AOAM533/kAoTSej6AyPKPd3O7EDtsWLxQtoli2NLA4qiaAmowFTGI//b
        s5ImBrs2NfOlt4R32/KxuEWo0lVhI66O0+7WR+doJFrHE2a9
X-Google-Smtp-Source: ABdhPJywY/QThq2tkmbGF5CT7h5pJ5vsKD7paTZ7hsCCLFKMhsTboGdKzTlxlX3jS+mSMamk2GF/JciP/AI8yRl77WY=
X-Received: by 2002:a05:6402:6d6:: with SMTP id n22mr136386edy.128.1612302367766;
 Tue, 02 Feb 2021 13:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20210202212930.18845-1-danielwa@cisco.com> <CAHC9VhShkEJHWmuE2C_RLQy-Z3CpvAhTj68ki22v=AKF5hfvrQ@mail.gmail.com>
 <20210202214357.GD3710@zorba>
In-Reply-To: <20210202214357.GD3710@zorba>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Feb 2021 16:45:56 -0500
Message-ID: <CAHC9VhSVBV=_pBnj7sxwJu0siXx5P7JrsYSz1_vW3j6WmTw+6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: show user land backtrace as part of audit
 context messages
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        Eric Paris <eparis@redhat.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Ruslan Bilovol -X (rbilovol - GLOBALLOGIC INC at Cisco)" 
        <rbilovol@cisco.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 4:44 PM Daniel Walker (danielwa)
<danielwa@cisco.com> wrote:
> On Tue, Feb 02, 2021 at 04:35:42PM -0500, Paul Moore wrote:
> > On Tue, Feb 2, 2021 at 4:29 PM Daniel Walker <danielwa@cisco.com> wrote:
> > > From: Victor Kamensky <kamensky@cisco.com>
> > >
> > > To efficiently find out where SELinux AVC denial is comming from
> > > take backtrace of user land process and display it as type=UBACKTRACE
> > > message that comes as audit context for SELinux AVC and other audit
> > > messages ...
> >
> > Have you tried the new perf tracepoint for SELinux AVC decisions that
> > trigger an audit event?  It's a new feature for v5.10 and looks to
> > accomplish most of what you are looking for with this patch.
> >
> > * https://www.paul-moore.com/blog/d/2020/12/linux_v510.html
>
> We haven't tried it, but I can look into it. We're not using v5.10 extensively
> yet.

Let us know if that works for you, and if it doesn't, let us know what
might be missing.  I hate seeing the kernel grow multiple features
which do the same thing.

-- 
paul moore
www.paul-moore.com
