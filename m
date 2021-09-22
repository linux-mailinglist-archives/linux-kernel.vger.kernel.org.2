Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D17414921
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhIVMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235947AbhIVMlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DC6560F9D;
        Wed, 22 Sep 2021 12:39:46 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:39:44 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mike Christie <michael.christie@oracle.com>, hdanton@sina.com,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/9] fork: move PF_IO_WORKER's kernel frame setup to
 new flag
Message-ID: <20210922123944.qo3quonmrz2fv2bb@wittgenstein>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-4-michael.christie@oracle.com>
 <CAMuHMdXhtq-6vcU_1qYfT_ChPGsnhLAA_yZwPz7ERJgxJERK7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXhtq-6vcU_1qYfT_ChPGsnhLAA_yZwPz7ERJgxJERK7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:32:37PM +0200, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Tue, Sep 21, 2021 at 11:55 PM Mike Christie
> <michael.christie@oracle.com> wrote:
> > The vhost worker threads need the same frame setup as io_uring's worker
> > threads, but handle signals differently and do not need the same
> > scheduling behavior. This patch separate's the frame setup parts of
> > PF_IO_WORKER into a kernel_clone_args flag, KERN_WORKER_USER.
> >
> > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/m68k/kernel/process.c
> > +++ b/arch/m68k/kernel/process.c
> > @@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
> >          */
> >         p->thread.fs = get_fs().seg;
> >
> > -       if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
> > +       if (unlikely(p->flags & (PF_KTHREAD) ||
> > +                    worker_flags & KERN_WORKER_USER)) {
> 
> I guess it wouldn't hurt to add parentheses to improve
> readability:
> 
>     if (unlikely((p->flags & (PF_KTHREAD)) ||
>                  (worker_flags & KERN_WORKER_USER))) {

Yep, I stumbled over the same thing!
