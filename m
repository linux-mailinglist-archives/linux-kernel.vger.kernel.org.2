Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249BC3D2F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhGVVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 17:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhGVVaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:30:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4742B60E9C;
        Thu, 22 Jul 2021 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626991889;
        bh=+yR4JB5jiQuXpEjcMflD7YJxgquTfOOemk1c/LenJfw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bQEWRndUas6gFIJtxpj9Pjji5Dwifqu/AUnidsvodFKWzbtL/5o/qQaI/DXAukVCx
         7Hlkg74WXbtRKkdd6UY8ypam6iLGS+ku7nQNSYxUNuEmFJEBPJ4C3rJMXblnZ6lyuI
         PZiq8iuKsffUCxBf3uve2wzlPqYvfF6AajlyQY0Zu3f1rLE/03io7xFteTpFBMLKnF
         oCKdMLVurqKTlYszbnNehBU5HvTaz5OsGM9gwYnoCBP2vCB1Iy3FX0G5u5fakm05w8
         DL5rD0BJU6O3cWCYRLv+UEuYtcUD3x7U+HnbDYmobj+1qUX68udqoCATaRl2TJmLp7
         qL8JwvMHQthag==
Message-ID: <19e90ddf9745b28aadd838ca205e548b0139b157.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tracing: Have histogram types be constant when
 possible
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jul 2021 17:11:28 -0500
In-Reply-To: <20210722142837.280718447@goodmis.org>
References: <20210722142705.992001628@goodmis.org>
         <20210722142837.280718447@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 10:27 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Instead of kstrdup("const", GFP_KERNEL), have the hist_field type
> simply
> assign the constant hist_field->type = "const"; And when the value
> passed
> to it is a variable, use "kstrdup_const(var, GFP_KERNEL);" which will
> just
> copy the value if the variable is already a constant. This saves on
> having
> to allocate when not needed.
> 
> All frees of the hist_field->type will need to use kfree_const().
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


Looks good to me.

Thanks,

Reviewed-by: <zanussi@kernel.org>


