Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D930636083E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhDOL2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:28:49 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:57273 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:28:48 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 28873A1BD7;
        Thu, 15 Apr 2021 13:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=81cfrwKyk1g4
        YvKpu+6SDuRsAjmGLhY0/Dw8H276Oys=; b=taWd7haYyNaObn8OcPAQl5IKK4PR
        JGYiK21bgYczqSr/5ZfIRTXbyNFiSpUcxWxXcxIP+kFLMigUKzxIz3iDVUlCJT2/
        RsYznnc20WhhFG/G3K/L3vPeBX0px+mnxPZAkAzAt3uqbQ1yVf3NrJf6GmYMFaOj
        MGuDAxpg33TKiWZkjLdreyPN/wBFhd2bJaIq+yApxQGwEk+3BHoeKgCXgBD0LFYe
        NY3VJ5ozWwfNWWj6wdo9vu2OCUPQa8muBFK4jHu5U67ae4nuvSDLO3/wS+Ct4ySx
        VBhzeCoNNL6qik4cHfFLs08YJW8lJGYcu5JHQLSEXZweKhSXYwsGxurjMw==
Subject: Re: [PATCH] sound: virtio: correct the function name in kernel-doc
 comment
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210415052645.14465-1-rdunlap@infradead.org>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <f63f2698-991f-409a-0d00-009059f0588d@opensynergy.com>
Date:   Thu, 15 Apr 2021 13:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210415052645.14465-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.2021 07:26, Randy Dunlap wrote:
> 
> Fix kernel-doc warning that the wrong function name is used in a
> kernel-doc comment:
> 
> ../sound/virtio/virtio_ctl_msg.c:70: warning: expecting prototype for virtsnd_ctl_msg_request(). Prototype was for virtsnd_ctl_msg_response() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: alsa-devel@alsa-project.org

Thanks for fixing the copy/paste mistake. :)

Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

> ---
>   sound/virtio/virtio_ctl_msg.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210414.orig/sound/virtio/virtio_ctl_msg.c
> +++ linux-next-20210414/sound/virtio/virtio_ctl_msg.c
> @@ -61,7 +61,7 @@ void *virtsnd_ctl_msg_request(struct vir
>   }
> 
>   /**
> - * virtsnd_ctl_msg_request() - Get a pointer to the response header.
> + * virtsnd_ctl_msg_response() - Get a pointer to the response header.
>    * @msg: Control message.
>    *
>    * Context: Any context.
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

