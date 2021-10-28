Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614E043E5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJ1QD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJ1QD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:03:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WPI3HGeY+QJAr3olI2zUkaqrGB17KW9jhBoLk8LEx0s=; b=nQxyl1pzM4GZBegx0zgg3RzYAy
        S5k7jmu6twSgp+Y1yW6oyRiYwWL/uPJpQP4dKYL1YH65LjbtPiqCvjXNe3U6lLsSdlMH/hfG34947
        daQBPetwPAqcFWGlCw688XGJZADcYFSyLqDwetqkNQ5FBNQZ3KMiDCTjiPfmNFtZYqTf5pUXQ5xln
        pHY08+sMm5tG0HymZm4op/jPPOLgEdNPMqN20ucEc/JnirAVoqYMMaZOTcL5SGVWzplgwYIcb4zxz
        nzKkRJPFG5K4w18RCMi5+dGtpDFgrHnp4uOj6D006Vt6s6L07uS24Vy6HTUrJ+eyz0DGFPpPEA2sp
        A7b2/b4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg7po-008Vf5-Mg; Thu, 28 Oct 2021 16:00:56 +0000
Date:   Thu, 28 Oct 2021 09:00:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Export pelt_thermal_tp
Message-ID: <YXrJOKb17cH6vkTc@infradead.org>
References: <20211028115005.873539-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028115005.873539-1-qais.yousef@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 12:50:05PM +0100, Qais Yousef wrote:
> We can't use this tracepoint in modules without having the symbol
> exported first, fix that.

Which modules is using this?  In linux-next there does not seems to be
any user outside of kernel/sched/pelt.c.

> @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);

... and while we're at it, all these exports are unused and should
be deleted as well.
