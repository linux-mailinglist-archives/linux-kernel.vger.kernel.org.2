Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D279A381F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhEPNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 09:16:23 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:51484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229888AbhEPNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 09:16:22 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 152DF18021DB5;
        Sun, 16 May 2021 13:15:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 5485C315D75;
        Sun, 16 May 2021 13:15:00 +0000 (UTC)
Message-ID: <81d398b86b1c7214e64a0dd25a9ef090f86bc16c.camel@perches.com>
Subject: Re: [PATCH v3] samples/kprobes: Fix typo in handler_{post,fault}()
From:   Joe Perches <joe@perches.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Randy Dunlap <randy.dunlap@oracle.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Date:   Sun, 16 May 2021 06:14:58 -0700
In-Reply-To: <20210516190201.790f4f2085e2691bbb96c58c@kernel.org>
References: <1621046346-7855-1-git-send-email-yangtiezhu@loongson.cn>
         <20210516190201.790f4f2085e2691bbb96c58c@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5485C315D75
X-Spam-Status: No, score=-1.40
X-Stat-Signature: qcytjufepgrgjatjrgjkmngrgxj5bned
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/z+bZQ+EMlYUPk7KqNrGVOmNeFidOA67s=
X-HE-Tag: 1621170900-47233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-05-16 at 19:02 +0900, Masami Hiramatsu wrote:
> On Sat, 15 May 2021 10:39:06 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> 
> > It should use post_handler instead of pre_handler in handler_post().
> > 
> > As Joe Perches suggested, it would be better to use pr_fmt and remove
> > all the embedded pre/post strings. This would change the style of the
> > output through.
> > 
> 
> NAK, this also shows which handler cought the event.
> If you wanna change it. Please replace it with __func__ instead.
[]
> > diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
[]
> > @@ -10,6 +10,8 @@
> >   * whenever kernel_clone() is invoked to create a new process.
> >   */
> >  
> > +#define pr_fmt(fmt) "%s: " fmt, __func__

It does that already via the pr_fmt which uses __func__.


