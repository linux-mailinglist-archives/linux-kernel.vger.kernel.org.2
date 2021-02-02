Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4380130BD8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBBL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhBBL5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:57:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CF2B64F54;
        Tue,  2 Feb 2021 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612267026;
        bh=hJANvgAJx1Itgu/daXTB54JwtMxbyN5SjIal+o1Jncs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9H7Dgb0nXZ48uK7JDCHkm4E+ol2lb7pf/o6rWPy8tAKqz33xJuRrkDPoB3YVkJPH
         UCKCzojMcHBtVqwNLwHxcvLZJgkADYbPNm/ia/WzLRuj+gOQh9A8zMfw3CRISXWSSJ
         KFmw4SUp42LPKyVE8PPnTUsoc655m+yHWWx7cbAs=
Date:   Tue, 2 Feb 2021 12:57:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch
 help?
Message-ID: <YBk+Dqbyu0W9P3rI@kroah.com>
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
 <YBguQ/dENrfvtptJ@kroah.com>
 <CABJPP5Ba9pDJco16R0CfcpXZedT7vPx_Md9QTRX=y_guQcwLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJPP5Ba9pDJco16R0CfcpXZedT7vPx_Md9QTRX=y_guQcwLww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:31:33PM +0530, Dwaipayan Ray wrote:
> On Mon, Feb 1, 2021 at 10:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 01, 2021 at 10:04:01PM +0530, Dwaipayan Ray wrote:
> > > Hi,
> > > on linux-next,
> > > $ git log --pretty=format:"%h%x09%ad" | awk '$6>2021 {print $1}'
> > > gives:
> > > 4a2d78822fdf
> > > 12ca45fea91c
> > > 09f2724a786f
> > >
> > > These are patches from the year 2085, 2037 and 2030 respectively.
> > >
> > > Would a checkpatch rule be helpful for these or are they too
> > > isolated to waste runtime on?
> >
> > Dates come from your email client, not the patch itself, how is
> > checkpatch going to catch this?
> >
> 
> I was hoping that the maintainer could catch it before merging it
> into his tree. Dates being a trivial thing might slip human eyes,
> but checkpatch might detect it there.

What is the problem here.  You can't treat dates that patches were
"created", you have to always go off of the release the patches showed
up in.  So while you might want to do a sliding scale of 4 months or so,
in reality we have patches committed to the tree today that were written
years ago.

I think I still hold the record for "time it took to get a patch merged"
with a very old devfs removal patch, which was many many years...

thanks,

greg k-h
