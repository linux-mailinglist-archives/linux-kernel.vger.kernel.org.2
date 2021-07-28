Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7444A3D8F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhG1Nrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbhG1NqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:46:22 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E01C1C0617B0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=gSlg8rRsSXoJ0fWh8d+x+IcEx/wtHhvBcH
        sY6dFKF0A=; b=ryb3fbKBlgKMA7reFRVg6exgROkuPU0THvFSabOvpO+g9BEPCX
        tN1gXX639yATePUgxA9cf763wOW0BXsDGKGp5vIqIZ/VDL/51RF18sUhdf88n34S
        CJ3CwbkrW1Jx1f7I6siaaXlQB5LQG3C3TEVFiPXfGrEt6dQhkFokIMefg=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3Tkx8XwFhDnNaAA--.1287S2;
        Wed, 28 Jul 2021 21:45:32 +0800 (CST)
Date:   Wed, 28 Jul 2021 21:39:34 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: stacktrace: fix dump_backtrace/walk_stackframe
 with NULL task
Message-ID: <20210728213934.5a0ee52e@xhacker>
In-Reply-To: <20210727221656.wq3ponbzhvftfxc5@mail.google.com>
References: <20210627092659.46193-1-changbin.du@gmail.com>
        <20210628134404.4c470112@xhacker.debian>
        <20210727221656.wq3ponbzhvftfxc5@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygA3Tkx8XwFhDnNaAA--.1287S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw17GFW5WrWrXrW8KF1Dtrb_yoW3Gwc_Xr
        Z3A3WDCrsrZrZ7Ca93Jr13ZryDKFW8Jr4rKw4v9r95Awn8G398JrnYkF1fJF1DKrn7ua43
        Gr9xX3WFg342vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxU7GYLDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 06:16:56 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> On Mon, Jun 28, 2021 at 01:44:04PM +0800, Jisheng Zhang wrote:
> > On Sun, 27 Jun 2021 17:26:59 +0800
> > Changbin Du <changbin.du@gmail.com> wrote:
> > 
> >   
> > > 
> > > 
> > > Some places try to show backtrace with NULL task, and expect the task is
> > > 'current'. For example, dump_stack()->show_stack(NULL,...). So the
> > > stacktrace code should take care of this case.  
> > 
> > I fixed this issue one week ago:
> > 
> > http://lists.infradead.org/pipermail/linux-riscv/2021-June/007258.html  
> 
> I still see this issue on mainline. Is your fix merged? Thanks!

Nope, the fix is missed twice. Palmer has added the fix patch into
fix branch, I help it will be in next rc

Regards

