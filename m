Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85623804FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhENIVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhENIVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:21:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A07A61457;
        Fri, 14 May 2021 08:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620980404;
        bh=t7IeHlZBRCXl4t7slKWm6HY44Ba6kKP4CTYxi9OlQ50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duxnHOMrhWHvICY5zKu5hJBjYtymCymdEL3dBYaTCfS4HqxPmkx/e0Nca2xvEyx7p
         BIztXq8OpS+fGEs2M4eJkWhYfT6vyVh8xmJZEvph9K+T/MbnKSxkvjGp3SK4q8P5K8
         I0QA0FH33+1NUwEKrZRP+uN4mOVYcUONU7Vab1rCU/bl1Fem2TtgWLvIEOcKFhtl4C
         1gnk/qffGkCMtZq6Kgva+2I/Y33NYdofYfebYcw37U71BMScA5zYJzEN8sScvEVpT6
         J81uKVcsSX7Ku6G9Ga6dIcQW9/DWMdLNUX9t73PTbYbDh48gntnFIcOch2DPKPm5qX
         iA/7LKLCSdl5g==
Date:   Fri, 14 May 2021 10:20:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module: Use BUG_ON instead of if condition
 followed by BUG
Message-ID: <YJ4ysIDqL9WWg3ZI@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <1620828117-88111-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1620828117-88111-1-git-send-email-zhouchuangao@vivo.com>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ zhouchuangao [12/05/21 07:01 -0700]:
>Fix the following coccinelle report:
>
>kernel/module.c:1018:2-5:
>WARNING: Use BUG_ON instead of if condition followed by BUG.
>
>BUG_ON uses unlikely in if(). Through disassembly, we can see that
>brk #0x800 is compiled to the end of the function.
>As you can see below:
>    ......
>    ffffff8008660bec:   d65f03c0    ret
>    ffffff8008660bf0:   d4210000    brk #0x800
>
>Usually, the condition in if () is not satisfied. For the
>multi-stage pipeline, we do not need to perform fetch decode
>and excute operation on brk instruction.
>
>In my opinion, this can improve the efficiency of the
>multi-stage pipeline.
>
>Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>

Thanks for fixing the changelog. Queued on modules-next.

Jessica
