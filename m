Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1612F453FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhKQFNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhKQFNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:13:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B13C66187F;
        Wed, 17 Nov 2021 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637125842;
        bh=YAWYlbsffL0+V+TDNFAwJ7WXF7SeHKdpZnj811euHtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npGFUrADa2IMYN9GEaNkt/aEHsR/P5aDG3yl9cwUaZRsYC12H6s0oCpLfHvR3vq90
         mc/X4mEbR2mUJh1N8GVdTC5UtZO5bpCjmIIKAsBIiDI/d7saXY9ooU4tVPNrl8+Gvi
         iV0GGiALIL1N2U2v3Gy9HFy9DwsUZfGdUdpu2KbkbMBfJj5zGQV3ivofpkUr25kYxf
         yfp/S/POujotodSlAESXx0tWoAGY9KwlU6CLbjUzIN+kWkAmNrNbSmjFyuKISZA9Ju
         SiWhZcxOzcZx1XOIX7PcyZjsSqUvq1VHJ3xKKwPr78vMkaqrjwvUzOL6GgXQ+NNoic
         8ZQaEi9rsg3aA==
Date:   Wed, 17 Nov 2021 10:40:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Robert Foss <robert.foss@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lontium-lt9611: check a different register bit for HDMI
 sensing
Message-ID: <YZSOzhygBRli1DVh@matsya>
References: <20211117020724.2647769-1-pcc@google.com>
 <CALAqxLWn67emfDPcMGrjVag0zCCrNF2=rEiHKQgr2eJ8AotCPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWn67emfDPcMGrjVag0zCCrNF2=rEiHKQgr2eJ8AotCPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 16-11-21, 20:47, John Stultz wrote:
> On Tue, Nov 16, 2021 at 6:07 PM Peter Collingbourne <pcc@google.com> wrote:
> >
> > It has been observed that with certain monitors such as the HP Z27n,
> > the register 0x825e reads a value of 0x79 when the HDMI cable is
> > connected and 0x78 when it is disconnected, i.e. bit 0 appears
> > to correspond to the HDMI connection status and bit 2 is never
> > set. Therefore, change the driver to check bit 0 instead of bit 2.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/I7e76411127e1ce4988a3f6d0c8ba5f1c3d880c23
> > ---
> > N.B. I don't currently have easy access to a monitor that works
> > with the existing driver, so it would be great if people with
> > monitors that currently work could test this patch to make sure
> > that it doesn't introduce any regressions. Otherwise I will change
> > it to check both bits.
> 
> So very interesting! I gave this a spin with my monitors and it works fine.
> 
> Vinod: Can you check the datasheet to see if the wrong bit is being used here?

Well the document I have does not list this register :(

I have asked Lontium folks about this register description, will update
if I hear back. Meanwhile we can get this patch tested with different
monitors.

Thanks
-- 
~Vinod
