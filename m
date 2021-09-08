Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91CA4031CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbhIHAO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233183AbhIHAOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7264B61106;
        Wed,  8 Sep 2021 00:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631060028;
        bh=kWYt8IVn1IyabyzMQamj0G5Idrpz7ar/7WuS3fGAML0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ij2npBX3goct6c9jy4Bc/94fPhyQAXjmEQnKtKuE+7A0wOFCAlaBN0AIDo07ktc1V
         8xP6Xv8fGg0MbCvyPCSvlXYrXdDgFf8/Avpg79dLRsssgaZNROJ4d7A3vujXpPqzPd
         Cg+wCcDKD+MYMmBYIpzZ0pyY5QdQ5mDo1QTzwZ20PUa3ETJsJMYMdSnyppynivbc6R
         Wioc4lJoRvb/0Vao0dtML/mE1dcpFaa8JV42OhwdcUfU9tc/Greq4vmXwCARqIi1K3
         HD8Z0xoEiB8dFFphdXIKv8+JdS8vDrsvE048k8rx6gaY7xsyJwAe0WOkphsD1iPSnD
         h+KnYUva4CEpQ==
Date:   Wed, 8 Sep 2021 09:13:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-Id: <20210908091346.65e6c4c58bc31676e942ccb2@kernel.org>
In-Reply-To: <20210907230710.1189193-1-punitagrawal@gmail.com>
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

This has been fixed by Julio's patch and we are waiting for merge.

https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#u

Thank you,

On Wed,  8 Sep 2021 08:07:10 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> While looking to build bootconfig tool in order to debug a kernel boot
> time issue I noticed that tool fails to compile. The broken changes
> were introduced by commit e5efaeb8a8f5 ("bootconfig: Support mixing a
> value and subkeys under a key").
> 
> Fix the compile issue by introducing a "ret" variable to track the
> return value from xbc_node_compose_key().
> 
> Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
> 
> (Apologies for the resend. I fat-fingered the email address for lkml)
> 
> Hi Masami,
> 
> I am not sure what went wrong but the patch in the lore link[0]
> doesn't match the end result (bad merge?). You may want to recheck the
> other changes to make sure it all looks sane.
> 
> Regards,
> Punit
> 
> [0] https://lkml.kernel.org/r/162262194685.264090.7738574774030567419.stgit@devnote2
> ---
>  tools/bootconfig/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index f45fa992e01d..fd67496a947f 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -111,9 +111,11 @@ static void xbc_show_list(void)
>  	char key[XBC_KEYLEN_MAX];
>  	struct xbc_node *leaf;
>  	const char *val;
> +	int ret;
>  
>  	xbc_for_each_key_value(leaf, val) {
> -		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
> +		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
> +		if (ret < 0) {
>  			fprintf(stderr, "Failed to compose key %d\n", ret);
>  			break;
>  		}
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
