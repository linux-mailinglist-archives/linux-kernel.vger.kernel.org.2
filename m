Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51F641A193
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhI0V6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237468AbhI0V62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:58:28 -0400
Received: from oasis.local.home (unknown [209.210.2.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C5F60F4F;
        Mon, 27 Sep 2021 21:56:49 +0000 (UTC)
Date:   Mon, 27 Sep 2021 17:56:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>, namhyung@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/cfi: Fix cmp_entries_* functions signature
 mismatch
Message-ID: <20210927175648.3e9118ce@oasis.local.home>
In-Reply-To: <CAC_TJve2aS_tHfmMCsayPFrAPaMid5DU3NK82KXC3dB9vhPdpw@mail.gmail.com>
References: <20210923170908.2184404-1-kaleshsingh@google.com>
        <CABCJKucTiHDitevf1U97eCV1KdxAyui+fWvD1i7c8piVMnmjoQ@mail.gmail.com>
        <CAC_TJve2aS_tHfmMCsayPFrAPaMid5DU3NK82KXC3dB9vhPdpw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 11:15:01 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Thanks for the patch! This looks correct to me and fixes the function
> > type mismatch that trips CFI.
> >
> > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>  
> 
> Thanks for the review Sami.
> 
> Steve, will this get picked up for your tree?

Yeah, I can pull it through my tree, but as I'm currently traveling, I
can't give a proper ETA on when it will hit. But at the latest, I'll be
looking at all my patch queue next week.

-- Steve

