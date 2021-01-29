Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C0B308A38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhA2Q3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhA2Q3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:29:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 918DD64DFD;
        Fri, 29 Jan 2021 16:28:51 +0000 (UTC)
Date:   Fri, 29 Jan 2021 11:28:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        ananth@linux.ibm.com
Subject: Re: [PATCH v2] kretprobe: avoid re-registration of the same
 kretprobe earlier
Message-ID: <20210129112849.29b0ecab@gandalf.local.home>
In-Reply-To: <20210129095347.GD117@DESKTOP-TDPLP67.localdomain>
References: <20210128124427.2031088-1-bobo.shaobowang@huawei.com>
        <20210129095347.GD117@DESKTOP-TDPLP67.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 15:23:47 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f7fb5d135930fa..63a36f33565354 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1530,6 +1530,7 @@ static inline int check_kprobe_rereg(struct kprobe *p)
>                 ret = -EINVAL;
>         mutex_unlock(&kprobe_mutex);
> 
> +       WARN_ON(ret);
>         return ret;
>  }

Please use WARN_ON_ONCE(ret);

Thanks,

-- Steve
