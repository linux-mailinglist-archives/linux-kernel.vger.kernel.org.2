Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8C3314DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCHR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:28:46 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:39341 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhCHR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:28:32 -0500
Received: by mail-io1-f54.google.com with SMTP id o9so10791421iow.6;
        Mon, 08 Mar 2021 09:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fws5MonGu3/ugwq9UdenhDT89R0PYuNDK5UhBQCoBJM=;
        b=SH8LGVHJHVv/epe9nfZ2indrOYHhK917+G1FVQRE22GacgQ6qXksQWw0qm/Y12SZnV
         m5LSfNhsKiXPS94lahN3eOxwK5nkp7H+Ks+jiYMaPwJzeby9SYuPKgYqSFjs7Et8t2Ae
         mnHPBm6tvpKZc6GTmgrb11LGrq/GhTCfEsIGP/9gYivnT9VFBlRfEmnULDdPkCCjWeXb
         vL/3+tdaV0Pt0xNoRpCojhP8Ho5xPAhr5ZIO7rcKMQYu6E18OJrFuMMYmxnva4d5sbl4
         JGRT5pXU9oYg7sahuU8eMspgXZQUTAtEzLXfJ9K6dlAMW/nVdyxmB7KORJ8Yj5qUJtg2
         OZkw==
X-Gm-Message-State: AOAM530uZWe5I4v9mq2irVQ8G6FmAlBts73DhV6k53+4EIXNUL/9VH+v
        v7Q0m+N7BOJtxTw+z9+b9LtB5vsJAA==
X-Google-Smtp-Source: ABdhPJyS+nur54q9MG9oIinTctfWUfF+pR/TVr6q+ykJUS8fdebTkaBQHkqp6/2E7igSyd/swhT75w==
X-Received: by 2002:a05:6638:238c:: with SMTP id q12mr24925610jat.114.1615224511898;
        Mon, 08 Mar 2021 09:28:31 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h23sm6189744ila.15.2021.03.08.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:28:31 -0800 (PST)
Received: (nullmailer pid 2664795 invoked by uid 1000);
        Mon, 08 Mar 2021 17:28:28 -0000
Date:   Mon, 8 Mar 2021 10:28:28 -0700
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     huangtao@rock-chips.com, finley.xiao@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        heiko@sntech.de, sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        tony.xie@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com
Subject: Re: [PATCH v3 2/4] clk: rockchip: add dt-binding header for rk3568
Message-ID: <20210308172828.GA2664738@robh.at.kernel.org>
References: <20210301064749.10392-1-zhangqing@rock-chips.com>
 <20210301064749.10392-3-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301064749.10392-3-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 14:47:47 +0800, Elaine Zhang wrote:
> Add the dt-bindings header for the rk3568, that gets shared between
> the clock controller and the clock references in the dts.
> Add softreset ID for rk3568.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/rk3568-cru.h | 926 +++++++++++++++++++++++++
>  1 file changed, 926 insertions(+)
>  create mode 100644 include/dt-bindings/clock/rk3568-cru.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
