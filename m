Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22181322E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhBWPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:54:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60729 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhBWPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:54:17 -0500
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M89P1-1lATVT1OiJ-005M5W; Tue, 23 Feb 2021 16:51:28 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 3A6551E01E7;
        Tue, 23 Feb 2021 15:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tnEpDMyau6jA; Tue, 23 Feb 2021 16:51:26 +0100 (CET)
Received: from pflmari.corp.cetitec.com (2-usr-pf-main.vpn.it.cetitec.com [10.8.5.2])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id E826D1E01E6;
        Tue, 23 Feb 2021 16:51:26 +0100 (CET)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Tue, 23 Feb 2021 16:51:26 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Lyude Paul <lyude@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        James Jones <jajones@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to
 userspace
Message-ID: <YDUkfjDA4xLJlxE5@pflmari>
References: <20210119015415.2511028-1-lyude@redhat.com>
 <20210119015415.2511028-2-lyude@redhat.com>
 <YDUN+Re/alMVL0Zn@pflmari>
 <CAKb7UvhFkw23so-a4JKLzpQLhphzjzarOy-9h+FiKP-aAC=4xw@mail.gmail.com>
 <YDUg/9fjsvTkRUqr@pflmari>
 <CAKb7Uvji_+N+b8HghZckU-uSBWn-=BZwNAiUff2oitbVuNUE2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7Uvji_+N+b8HghZckU-uSBWn-=BZwNAiUff2oitbVuNUE2Q@mail.gmail.com>
X-Provags-ID: V03:K1:TZGccT2syXDhApLxVFzVDJq5wKOtDGq/dl3aJQEA5t+BCVA3L2q
 V2lhNWDapJfSve9PZ5g8vpBtD2MQCXpv4W0PVMnTyWJdp+BAqHPypSdzeLnJYlzv9EmFZC+
 +D2ZnMjL5Xr4bJYsf5D69SAm/mbjuwsuOsuWdiJQDmhgdDu0O08nB4SHW3ORqAliTh1oPrC
 5KbbtmIVlyk6JiDnl/AAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2BLltldadtY=:4/40UfQuTN5gRc7injwK9G
 VwF3NpsVQh17Mk95k953iVeMGZ/Yu/dXP1705KZELeDrGyGtxOTTFOnDiiavm06f799DFkiHO
 6tqZYNLBRpm+z4LHOnyO4oOoMCb1M/xDicQ61+6+4irBCbveD4N/lE2lH2MU5y6bzelkdHobY
 GcdCAqhp8tgmuLx/0CsdClgAEw3AYXhIBmhYM8Zke5SNsyOE0yLqFJcBRMzgeqp5jJAnhREUV
 oSutt83jV/UfqJUu8URcvTkOpQVmbIZXr69m1tHErDtqThiGMfAi0O/03KQdhjkgtAQvbdguD
 FeuAgbuAsV7rWmfjwOJiC7CP51/iHltbSRfJjrjX/fku9EuQFw82pI2mBHkGotONBPgAKiSk6
 WFYdkQ3FJbcFoDMSRnG5ozSeU+Ryn5DpBW56d5hepl5DtmntgmvbZUbAvTTG+7pexLzrnGBOS
 OwYhwJJ1lw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilia Mirkin, Tue, Feb 23, 2021 16:46:52 +0100:
> On Tue, Feb 23, 2021 at 10:36 AM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > Ilia Mirkin, Tue, Feb 23, 2021 15:56:21 +0100:
> > > On Tue, Feb 23, 2021 at 9:26 AM Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > > >
> > > > This change broke X cursor in my setup, and reverting the commit restores it.
> > > >
> > > > Dell Precision M4800, issue ~2014 with GK106GLM [Quadro K2100M] (rev a1).
> > > > libdrm 2.4.91-1 (Debian 10.8 stable).
> > > > There are no errors or warnings in Xorg logs nor in the kernel log.
> > >
> > > Could you confirm which ddx is driving the nvidia hw? You can find
> > > this out by running "xrandr --listproviders", or also in the xorg log.
> >
> > xrandr(1) does not seem to list much:
> >
> > $ xrandr --listproviders
> > Providers: number : 1
> > Provider 0: id: 0x48 cap: 0xf, Source Output, Sink Output, Source Offload, Sink Offload crtcs: 4 outputs: 5 associated providers: 0 name:modesetting
> 
> Thanks - this is what I was looking for. name:modesetting, i.e. the
> modesetting ddx driver.
> 
> I checked nouveau source, and it seems like it uses a 64x64 cursor no
> matter what. Not sure what the modesetting ddx does.
> 
> I'd recommend using xf86-video-nouveau in any case, but some distros

I would like try this out. Do you know how to force the xorg server to
choose this driver instead of modesetting?

> have decided to explicitly force modesetting in preference of nouveau.
> Oh well. (And regardless, the regression should be addressed somehow,
> but it's also good to understand what the problem is.)
>
> Can you confirm what the problem with the cursor is?

The cursor looks stretched vertically over a bigger matrix, while missing some
lines and being wrapped over the bottom on top of that matrix.

