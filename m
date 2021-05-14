Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F3F381915
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEON1j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 May 2021 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhEON1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 09:27:30 -0400
X-Greylist: delayed 86 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 May 2021 06:26:16 PDT
Received: from bounceout06.ispgateway.de (bounceout06.ispgateway.de [IPv6:2a00:1158:400:1::f6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EDA5C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 06:26:16 -0700 (PDT)
Received: from [80.67.18.14] (helo=smtprelay02.ispgateway.de)
        by bounceout06.ispgateway.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <marc@koderer.com>)
        id 1lhuHf-0006gU-LF; Sat, 15 May 2021 15:24:47 +0200
Received: from [193.16.224.13] (helo=smtpclient.apple)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <marc@koderer.com>)
        id 1lhU6k-0000Op-2I; Fri, 14 May 2021 11:27:46 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH v2] samples/kprobes: Fix typo in handler_post()
From:   "Koderer, Marc" <marc@koderer.com>
In-Reply-To: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
Date:   Fri, 14 May 2021 11:28:07 +0200
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BA687AE0-EB7F-4A27-9868-5CCD83FF1E76@koderer.com>
References: <1620979810-12779-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
X-Df-Sender: bWFyY0Brb2RlcmVyLmNvbQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 14. May 2021, at 10:10, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> 
> It should use post_handler instead of pre_handler in handler_post().
> 
> Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>


LGTM.
Acked-by: Marc Koderer <marc@koderer.com>

Thanks.

> ---
> 
> v2: rebase on the latest mainline kernel
> 
> samples/kprobes/kprobe_example.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index c495664..602db3f 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -89,7 +89,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
> 		p->symbol_name, p->addr, regs->status);
> #endif
> #ifdef CONFIG_S390
> -	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
> +	pr_info("<%s> post_handler: p->addr, 0x%p, flags = 0x%lx\n",
> 		p->symbol_name, p->addr, regs->flags);
> #endif
> }
> -- 
> 2.1.0
> 

