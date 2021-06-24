Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E43B369A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhFXTIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:08:25 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:35353 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhFXTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:08:24 -0400
Received: by mail-il1-f179.google.com with SMTP id a11so7431588ilf.2;
        Thu, 24 Jun 2021 12:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sASZIh0JylD5nlffYVNx6Q2qk0hslOsxCidZn+CssBE=;
        b=umL6sQhl5HZD3O3PpEjqmOlhLccyc+N5YKxKGN+0bcxgLNRvpTdV5emgBkyVXEsv4x
         GLTJfoZoTpXRVkk9ZFVOOy+Yxz0w0gOQYJrfxQKcYTSKnjoS3eDCkYmuuOxjw7ZCTKK5
         +Dc8BK+y0vK184JRMAzEb3vlmT/6002nuHcmZkru0f/ihNPuC7AF5kj7t0Nz4Dd6R4Nu
         a/pwYLCEGHJIhQKwdZAH0jjvgn/PW5kutZp4e+JP2lQTWVEtL+ssExgT5+bllQX/uhul
         hwE1IsOrq4IXSb+/Qk4lkiMsx71tNM2gFtwZF7PE0es8KE76o5YjYULCsN7U+zAEAQeg
         /3Xw==
X-Gm-Message-State: AOAM532xmQ0FcXsxbJGrgK6HbumxnO4IhAmzrDX9p8NSO+6iokOV4/YG
        yvrN3DxGU9xYEtOjt+6ZDQ==
X-Google-Smtp-Source: ABdhPJxiwyiyjZcStomRiRQofvBh6rElZg/J0wGTTpumXIvqvLnGEtvk/m1fPQNTbXqxoAPf9KEGDg==
X-Received: by 2002:a05:6e02:1aa7:: with SMTP id l7mr4537589ilv.187.1624561564334;
        Thu, 24 Jun 2021 12:06:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h8sm975531ile.45.2021.06.24.12.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:06:02 -0700 (PDT)
Received: (nullmailer pid 1820092 invoked by uid 1000);
        Thu, 24 Jun 2021 19:05:58 -0000
Date:   Thu, 24 Jun 2021 13:05:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dongas86@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] of: of_reserved_mem: only call memblock_free for
 normal reserved memory
Message-ID: <20210624190558.GA1819995@robh.at.kernel.org>
References: <20210611131153.3731147-1-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611131153.3731147-1-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 21:11:52 +0800, Dong Aisheng wrote:
> For nomap case, the memory block will be removed by memblock_remove()
> in early_init_dt_alloc_reserved_memory_arch(). So it's meaningless to
> call memblock_free() on error path.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/of/of_reserved_mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
