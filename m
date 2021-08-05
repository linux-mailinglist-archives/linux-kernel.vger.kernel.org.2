Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7083E100F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbhHEIS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhHEISz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:18:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F0196104F;
        Thu,  5 Aug 2021 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628151520;
        bh=3Qyqz/XehSHX/KN//v96jroYOCaR+p2m3HMTILA0UBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1tfTAD2SzzVKWhuczBMWWCBkLmJujhVs6ns1DA/ZOSo0U1X148bi5U7Tw/q0OrooI
         fejyLXMwHkCrIrbtlW97iHgOA0bXRKN2IF340MROLRuSypoXuueXE/6sTbuuy6aRu+
         umdeCMGPzCKRl1oD9ddTkCi+WD9x7kM4XxVtbiqA=
Date:   Thu, 5 Aug 2021 10:18:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YQue3tK98e6fAqwP@kroah.com>
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
 <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
 <40f78d10-0a57-4620-e7e2-f806bd61abca@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40f78d10-0a57-4620-e7e2-f806bd61abca@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 04:08:46PM +0800, Xianting Tian wrote:
> 
> 在 2021/8/5 下午3:58, Jiri Slaby 写道:
> > Hi,
> > 
> > On 04. 08. 21, 4:54, Xianting Tian wrote:
> > > @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno,
> > > int data,
> > >       hp->outbuf_size = outbuf_size;
> > >       hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
> > >   +    /*
> > > +     * hvc_con_outbuf is guaranteed to be aligned at least to the
> > > +     * size(N_OUTBUF) by kmalloc().
> > > +     */
> > > +    hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
> > > +    if (!hp->hvc_con_outbuf)
> > > +        return ERR_PTR(-ENOMEM);
> > 
> > This leaks hp, right?
> > 
> > BTW your 2 patches are still not threaded, that is hard to follow.
> 
> yes, thanks, I found the bug, I am preparing to do this in v4.
> 
> It is the first time I send series patches(number >1), I checked the method
> for sending series patch on LKML.org, I should send '0/2' which is the
> history info for series patches.

Please use 'git send-email' to send the full series all at once,
otherwise it is hard to make the emails threaded "by hand" if you do not
do so.

thanks,

greg k-h
