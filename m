Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611CB3A152A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhFINNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:13:24 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:59528 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhFINNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:13:21 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 67416B005D0; Wed,  9 Jun 2021 15:11:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 65996B0058D;
        Wed,  9 Jun 2021 15:11:26 +0200 (CEST)
Date:   Wed, 9 Jun 2021 15:11:26 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] lib: Fix spelling mistakes in header files
In-Reply-To: <20210609013451.13706-2-thunder.leizhen@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2106091509590.60148@gentwo.de>
References: <20210609013451.13706-1-thunder.leizhen@huawei.com> <20210609013451.13706-2-thunder.leizhen@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021, Zhen Lei wrote:

>  #endif
>
> -/* A example struture for using NODEMASK_ALLOC, used in mempolicy. */
> +/* A example structure for using NODEMASK_ALLOC, used in mempolicy. */

An Example

Or better

Example structure ...

