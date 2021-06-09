Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992F23A0869
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhFIAaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:30:07 -0400
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:46760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232202AbhFIAaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:30:05 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3BEB88384364;
        Wed,  9 Jun 2021 00:28:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id F1CE72EBF91;
        Wed,  9 Jun 2021 00:28:09 +0000 (UTC)
Message-ID: <2ab2fd8be606ad925bb19054b74d1f3ebd2da095.camel@perches.com>
Subject: Re: [PATCH 1/1] lib: Fix spelling mistakes in header files
From:   Joe Perches <joe@perches.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 17:28:08 -0700
In-Reply-To: <20210609091821.32b82ba464f6f9aecc3a7d59@kernel.org>
References: <20210608021932.12581-1-thunder.leizhen@huawei.com>
         <20210608021932.12581-2-thunder.leizhen@huawei.com>
         <20210609091821.32b82ba464f6f9aecc3a7d59@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1CE72EBF91
X-Spam-Status: No, score=-2.63
X-Stat-Signature: q4we9jke1x4p38zkgcdm846ssd7ibbbo
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+G4l1fAkidsru6fkscs4KOGcXVpw3wqoM=
X-HE-Tag: 1623198489-595966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 09:18 +0900, Masami Hiramatsu wrote:
> On Tue, 8 Jun 2021 10:19:32 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
> > Fix some spelling mistakes in comments found by "codespell":

Another:

> > diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
[]
> > @@ -165,7 +165,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
> >   * is stroed to @anode and @value. If the @node doesn't have @key node,

stroed/stored

> >   * it does nothing.


