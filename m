Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF334D860
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhC2Tg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:36:29 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51941 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhC2TgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:36:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 97F08196D;
        Mon, 29 Mar 2021 15:35:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Mar 2021 15:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8oItlbJA/Jy/5SYgF7aFHMRrdB+
        MtY7i3HsT/Byz47k=; b=aZrilUlYurqlB0Z3cG0jK1MX24hYF4rjpHG/uhFa57a
        dK1xgdLOhmvn81w/pZPY7n3c/l8AS6f3wSw74smDQamdUd1K2iPLDq2izyW9fkiA
        DLS2GjvhZBKq6fphRIG81VYoVaPzv34Dp2zpa2H+SlpfuRWKAE1wm5e28jruoKl9
        qtu9RibwLdinkaYTRkQtk3LoyZxNO9B3KZoQjfn+qxy3HDDuteTuLj5tBmkLqoS+
        6FU/Itpad+vf63igjW2MMx0YBwve5EsFWc3P5YAt7RFRI6iEmbENloCCbVpqtd1H
        rUZM4Uyz2FbcRkC3ISDWfJwqhayqlnwR60h1k9zqXXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8oItlb
        JA/Jy/5SYgF7aFHMRrdB+MtY7i3HsT/Byz47k=; b=SADLuFxLL2Q1nBzd53vVYw
        /jzICk7bd/kdeGAusL9bXPcobPQwA0gppkMz1NupSqHRN8y4kZO9tW11hyM2SvB0
        92T93UmGTKMUr/emAGHFJls9Hv6Y869pCSU/4oSrBQGqV5TZgia8pDatwNbYe/I3
        AXCi151DLDlMIpumaR8pR2Z8zX69YH1vGG3ppLX4AyrBxUxN5ojBsk2w/EJ4u35r
        vr0pbDs0lPC6s1Jx8GOIynYBMHGvCYQx6lXg5PayS/aWAZm05sRi6NBNi4E70XLB
        /RDSLZIO4mIe2r1qwg7GUHY6gpFEjQjdDOOxPXP4TpKakM7I0PW3j83nSE5Mat7A
        ==
X-ME-Sender: <xms:HSxiYF3DsdcqXd-pkBhzzcOA4ujMQXu_8lgGNhUEDENk0OZGr5VTPw>
    <xme:HSxiYAWyFu3K9KHWAFMo2nejhinGZu-roQoSn4cAFbRPuvFmlf6-CiHLALFHvpCim
    zhN5jC9pJs2TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfetfe
    fftedvffeltdegudduteffuddtudevfeevtdeugeeugefgieetheefteefnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucfkphepkeefrdekiedrjeegrdeigeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgr
    hhdrtghomh
X-ME-Proxy: <xmx:HSxiYA434YpZw2sjtuYrjybTpXDmCfu78wpHI6Or2-w0six6gMUfIg>
    <xmx:HSxiYHIOQm1difaCJcY2HX3D1aNG1BWH2CnorFhEvWSC2eZpavFtCg>
    <xmx:HSxiYBIyxuPcWfe_OS_1wLXw9OAvXTyv5KUMAu2UOp2eGEnehv5Dbg>
    <xmx:HSxiYIn85_bLvmqvBfbUINJlS6nNT9RSvFGRf-jqAMa64REsxEc8WQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id B74BA24005D;
        Mon, 29 Mar 2021 15:35:56 -0400 (EDT)
Date:   Mon, 29 Mar 2021 21:35:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
Message-ID: <YGIsGlXzIGUpDR6D@kroah.com>
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com>
 <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 09:20:32PM +0200, Fawad Lateef wrote:
> Hi Greg,
> 
> 
> 
> On Mon, 29 Mar 2021 at 06:57, Greg KH <greg@kroah.com> wrote:
> >
> > On Sun, Mar 28, 2021 at 10:20:50PM +0200, Fawad Lateef wrote:
> > > Hi
> > >
> > > I am using an Olimex A20 SOM with NAND and due to some binary blob for
> > > NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
> > > here: https://github.com/linux-sunxi/linux-sunxi)
> >
> > Please work with the vendor that is forcing you to use this obsolete and
> > insecure kernel version.  You are paying for that support, and they are
> > the only ones that can support you.
> >
> 
> The problem is vendor Olimex now have eMMC based SOM which is
> supported by mainline kernel _but_ they still selling NAND SOM and
> only supporting 3.4 kernel (as this is the only latest version from
> sunxi with NAND support, after that sunxi is now moved away from NAND
> too).

If they are forcing you to use a binary kernel module, then they are the
only ones that can give you support, sorry.  That should be included in
the price you paid for the hardware.  If not, you need to go complain to
your purchasing department :)

Good luck!

greg k-h
