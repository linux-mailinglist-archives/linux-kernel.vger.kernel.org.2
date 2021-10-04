Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DDD4215F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhJDSEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:04:25 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39919 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbhJDSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:04:18 -0400
Received: by mail-ot1-f48.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so22678393ota.6;
        Mon, 04 Oct 2021 11:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M/SGga67jN2G7/llzVrub5qhFrk1aFwuQmWZS4qHJnU=;
        b=wCIBh8G0T5gov4J1aDH1pbHmRmIeSwg1vF6yeMLbNeq44t73TE0MNnQ4C9AA0vAJDW
         7YT7wYNkEwXXKYxYZSC8x2Fnn8jP8ev3LO+lMbVgxm6/Bwm8nHUfr6z4QDzKu5qtJqvP
         yELQGRQ1cHDy5S16QJoi6N49rhDecH8lX3QtBGJ7ieXkeuzh7St/Im7uNW9Jw5CZrM+E
         JyIcWk5VHOYRkwlffTZ8yvL/JZvW9lGxgyC9zV5NZCK17LgWxUAszrNafWQXzd/AIziN
         pkqOGxiizQZ6xxgd+Q5A+OtnOmWKHyoLipUxqgMo0dVEkL2vRvy7WKgcCtPGke2GbdLI
         m6xQ==
X-Gm-Message-State: AOAM530wWMpDxNySbnCsxx2nx/ti7zocTv+aH9dghMb1Bovo85Hvyv3U
        In7sq4mjJzD+NGyejbs4/A==
X-Google-Smtp-Source: ABdhPJxRFQOGJe/1Gc8YPX/AbyB8SwC/3eUvlri6WIZ7hLGxw4bR0uSlc2koc4irHc7tVC7tGlyNSQ==
X-Received: by 2002:a9d:1783:: with SMTP id j3mr11058382otj.366.1633370548465;
        Mon, 04 Oct 2021 11:02:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l19sm3029186ota.17.2021.10.04.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:02:27 -0700 (PDT)
Received: (nullmailer pid 1570795 invoked by uid 1000);
        Mon, 04 Oct 2021 18:02:26 -0000
Date:   Mon, 4 Oct 2021 13:02:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-staging@lists.linux.dev, john@phrozen.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: add dt binding header for ralink
 RT2880 resets
Message-ID: <YVtBsrmCDk/sLsRJ@robh.at.kernel.org>
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
 <20210926145931.14603-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926145931.14603-2-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 04:59:29PM +0200, Sergio Paracuellos wrote:
> Adds dt binding header for 'ralink,rt2880-reset' resets.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  include/dt-bindings/reset/ralink-rt2880.h | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 include/dt-bindings/reset/ralink-rt2880.h
> 
> diff --git a/include/dt-bindings/reset/ralink-rt2880.h b/include/dt-bindings/reset/ralink-rt2880.h
> new file mode 100644
> index 000000000000..266ef521a584
> --- /dev/null
> +++ b/include/dt-bindings/reset/ralink-rt2880.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license please.
