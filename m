Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1590A367CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhDVIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhDVIqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E98DD613DE;
        Thu, 22 Apr 2021 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619081170;
        bh=4nheqwl05OYDRXeZyfMJy6aYK1NXONMSey8HL0+Zb9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvJpDtJegEqOa0Gd7QypJCSiRy/z84tE2k+DG4b7G8Z84NqqMouJ1TDqP+F9aZdmG
         /v/G2Z6WXt5hUeHrgeqf2JyrABxWl6I5tyZ3macKHTFj2QQ14OASQliwZezOgg1arb
         s8eROn+lnAu0DHmvTih4kHCbLHHUBArZLkQzlUqo=
Date:   Thu, 22 Apr 2021 10:46:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>, Yaqii Wu <Yaqii.Wu@mediatek.com>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: xhci-mtk: remove unnecessary assignments in
 periodic TT scheduler
Message-ID: <YIE3z7qYNtk7G/VB@kroah.com>
References: <20210330080617.3746932-1-ikjn@chromium.org>
 <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
 <1617179455.2752.1.camel@mhfsdcap03>
 <YGq2YfURFApdJLxb@kroah.com>
 <1617675492.22435.4.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617675492.22435.4.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:18:12AM +0800, Chunfeng Yun wrote:
> On Mon, 2021-04-05 at 09:04 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Mar 31, 2021 at 04:30:55PM +0800, Chunfeng Yun wrote:
> > > cc Yaqii Wu <Yaqii.Wu@mediatek.com>
> > > 
> > > I'll test it , thanks
> > 
> > Did you test this series and find any problems?  If not, I'll go queue
> > these up...
> Yes, found an issue on the start-split transaction, but not found the
> root cause yet :(

So you are objecting to these being merged at this point in time?  Can
you provide feedback to the author about what is wrong?

thanks,

greg k-h
