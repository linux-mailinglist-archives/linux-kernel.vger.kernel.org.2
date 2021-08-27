Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1E3F9E57
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhH0Ry2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhH0RyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:54:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676E0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:53:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id g11so4462001qvd.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z/pvACIwYDrhsFAHjFo4egknO444SCb0xOTzLp4O58U=;
        b=mbHJscYr7Tjgrd2ruQiWjuPvHFjRq2vgB0nivh5McxWX2Waf8TcBwcU042EoYUQ5Xg
         FjE8pJu6MkdOgHIOwfVnsfii9Ft+LXmkse5dMtxVW+yBm5GquPJTOei+kkTBqhBVs3h0
         L56GG8WFpMayYXvj/ThCYp+4D0lwt2TyIeUdeG3FyxZooraQL4um8+DK3K6INtZhss1k
         uDKonUGGsrr6ba4YShpHYC4XFJws3bRf6+WQCEVEPgBzEfgzR6Tn3VrJRZ8sb8mY/+QY
         1CUjOYwqrqV1lcQ+is4XqAYfs+uAhKAvN8Z142H3XOujxaNjBbPmR3RrUAiltcGYFIP/
         Ep+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Z/pvACIwYDrhsFAHjFo4egknO444SCb0xOTzLp4O58U=;
        b=gc3h/UB9R5KuVURVuszeRyJu14EjLQfbEdtLSoBqWrMXKfA4PMk6IQjSch/RvYEvpf
         0vq4UFwoqqgZJBm6L7b7URmjY0unQtd+JK6M3iJyT8xYyJB1D6o1fg9WgSJTt1m7D46g
         ncuSlQXkZtGaGt6/wjF6zrzqEVUQig/KBd/VdRMta53LHQhMEOQYWjtK3P3IRHedwRho
         TyFkf7W04KyeBueIZcRi7Cq17dYARiQ9gx37tJLmYYmXNUbVCf40y6alpI/yJwnZB5ie
         3rO7rL/J1edeXqZqoUaDA87WXp0OE0VTmjn5WiDkl3i5K4edlaWjaktExAwQxsiKOpts
         +vLw==
X-Gm-Message-State: AOAM532BD24u7Jxwtaal2oGXF7+bMmA6DbS3/4CApQ/K+kPq53ruG6re
        xz9cXyV8XWkzb/zZtlqRywI=
X-Google-Smtp-Source: ABdhPJwvu4tpIJSvU+55fpUd2TRX4HwRspEJrI/S9qzAMG9oM4gxSimheFWtMXbC+qd9Cv3iY+GUHw==
X-Received: by 2002:a05:6214:14f2:: with SMTP id k18mr11106035qvw.19.1630086814590;
        Fri, 27 Aug 2021 10:53:34 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f1:e948:8e69:9cd6:5512:12f4? ([2804:431:c7f1:e948:8e69:9cd6:5512:12f4])
        by smtp.gmail.com with ESMTPSA id x21sm5033736qkf.76.2021.08.27.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:53:34 -0700 (PDT)
Message-ID: <dab10177d5fa144ad271b4efb59fe3e5dc61b56d.camel@gmail.com>
Subject: Re: [PATCH v6 10/11] powerpc/pseries/iommu: Make use of DDW for
 indirect mapping
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 14:53:47 -0300
In-Reply-To: <3d79480a-20df-ea1a-e17f-8bf2c8a8a2be@linux.ibm.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
         <20210817063929.38701-11-leobras.c@gmail.com>
         <3d79480a-20df-ea1a-e17f-8bf2c8a8a2be@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fred,

On Fri, 2021-08-27 at 19:06 +0200, Frederic Barrat wrote:
> 
> I think it looks ok now as it was mostly me who was misunderstanding
> one 
> part of the previous iteration.
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 

Thank you for reviewing this series!

> Sorry for the late review, I was enjoying some time off. And thanks
> for 
> that series, I believe it should help with those bugs complaining
> about 
> lack of DMA space. It was also very educational for me, thanks to you
> and Alexey for your detailed answers.

Working on this series caused me to learn a lot about how DMA and IOMMU
works in Power, and it was a great experience. Thanks to Alexey who
helped and guided me through this!

Best regards,
Leonardo Bras

