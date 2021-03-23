Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF5346630
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCWRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbhCWRUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616520052;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAyFL6IZIY2oqC27uvurT02K8tPhgIqI61UB1ihbE4M=;
        b=bmvsaTO8VonyT8q5u2lCZ9VkC9vu9S2L9WdPE/fRMu72+nJhE5Pe5u4CATdD6mTEVMMtUf
        6DPIKrMomuhAlGZ9tEhDsGjF3MRbTLLAJ0WIwnzhci7Kev2+Z9qie/YCxoiT8A9vH46HaP
        FW4qq9gay/R77c17FxdAp/YeQ1kskg0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-Tx5cGBvlPfatWGCD8DgrtA-1; Tue, 23 Mar 2021 13:20:51 -0400
X-MC-Unique: Tx5cGBvlPfatWGCD8DgrtA-1
Received: by mail-qk1-f198.google.com with SMTP id 130so2485553qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YAyFL6IZIY2oqC27uvurT02K8tPhgIqI61UB1ihbE4M=;
        b=YKszAKuudnV1GguRFwkNPVWzQ8uNYDcJvjAvl+XcOFxFb6qMTxZnbtjSU0rztIMaNX
         SkOESnUwUNfUxVIGTpAWwye/8cLbm5vu1EzQTR0DLfCdWL+c3Wmkw/CWCTO257E+JlHe
         qIRa23SMH/zinyxesMvsp1uXyrrYjTOqm4OfifkLY2FZIUTP6hv78+Azt9KzINrhgf8j
         r+Ow8bxO/AcSLEx1COtHG8qORRosqVOfl+BERaCjJFgZOTXVvxuKdy2Z+NakMwCGk2FD
         4TLS53ql8rHq5oylDq0e5DnVpmGiJ/P/07k+Zh8WK6xDAVTAGbxQec0ZMIjxvcdswLT+
         9Ptg==
X-Gm-Message-State: AOAM531oKHs/A6/MwGo/tU1/7AteLouK9dJnHHUFRBK0lNSojCMwvZfq
        +w1YzfEJOib80UpZ4q6Vn1uOWvQDtWQ0+BEk/B4LsfQyGpoI10pKXkVXaUsDchw//rJL+FeRynG
        5czTbYInmhXTvgNQXxaVQ7cNV
X-Received: by 2002:ac8:7b3a:: with SMTP id l26mr5459629qtu.150.1616520049924;
        Tue, 23 Mar 2021 10:20:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztYTHgeNEkdPAMioM0BwWW+Vm6mK0rE7umTqs7yzRlDH9oowzpWEj8LVq6M8gu2Op7eNL4Aw==
X-Received: by 2002:ac8:7b3a:: with SMTP id l26mr5459610qtu.150.1616520049760;
        Tue, 23 Mar 2021 10:20:49 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id x14sm13757985qkx.112.2021.03.23.10.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:20:49 -0700 (PDT)
Message-ID: <fa6903109e07ba8d3f1d5374d1785e3d8df10ebb.camel@redhat.com>
Subject: Re: [PATCH] drivers: gpu: priv.h is included twice
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Wan Jiabing <wanjiabing@vivo.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Date:   Tue, 23 Mar 2021 13:20:48 -0400
In-Reply-To: <20210322124513.130470-1-wanjiabing@vivo.com>
References: <20210322124513.130470-1-wanjiabing@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2021-03-22 at 20:45 +0800, Wan Jiabing wrote:
> priv.h has been included at line 22, so remove
> the duplicate include at line 24.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> index c39e797dc7c9..09524168431c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c
> @@ -20,8 +20,6 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>  #include "priv.h"
> -
> -#include "priv.h"
>  #include <core/firmware.h>
>  
>  static void *

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

