Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D140643522B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJTSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:00:55 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39554 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhJTSAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:00:48 -0400
Received: by mail-oi1-f176.google.com with SMTP id s9so8249925oiw.6;
        Wed, 20 Oct 2021 10:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kk18om8C4AqBKZvLH6Ib1TuSuLkolU+LnVa8ozj2pfs=;
        b=L3dHqT/9cHakjBDX0PIzE0IGEKnGqIyopRJtt9sXKFRbF72issP5UXkW+dcF2PQgGM
         JJuKTrUa826KA3BOXNDOqpiWFinFfQLRqbYWgTQ0sn0BmV7sXOuDZmKFnkeDXHTprOxO
         QD5JnJgTE9Bqc9HvpIQvtpVKZ06FZjQ0bhL4i53j7pTvwFU0UL8IICinONjvDaYxJGLr
         FS/UF1nv9gqrAExc1Ti4QTvbavPuLrqeEV7Ci8CWIWzjonh5RuNN9gi/cwTy0iNo2bcF
         f6/7J9dHx5cn8DuFc03RqbAKQqSaeYMe+O+94z4j4gdQqLSr5Mg4IF3gL98P1vZJVXnl
         JMww==
X-Gm-Message-State: AOAM530rEVEMvaLZznKHnDh9g+U1t1kFH1Zsw1MUnDkfS2nAzMdsZSvn
        KyJpAdCz9io8RNSjj/9BeQ==
X-Google-Smtp-Source: ABdhPJwp0JqU4/Wxxgx1FRcjgX7QeNNb/3ySVEtbUs7hgjQfBCZD2pDkAMYTKxXnJe9X7VcvTv2muQ==
X-Received: by 2002:a05:6808:f86:: with SMTP id o6mr373346oiw.68.1634752713998;
        Wed, 20 Oct 2021 10:58:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm506024ooa.20.2021.10.20.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:58:33 -0700 (PDT)
Received: (nullmailer pid 2593622 invoked by uid 1000);
        Wed, 20 Oct 2021 17:58:32 -0000
Date:   Wed, 20 Oct 2021 12:58:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kael_w@yeah.net, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of/unittest: Add of_node_put() before return
Message-ID: <YXBYyM2f3vRb9676@robh.at.kernel.org>
References: <20211015082658.19005-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015082658.19005-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 04:26:58 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/of/unittest.c:3091:1-23: WARNING: Function
> for_each_child_of_node should have of_node_put() before return
> 
> Early exits from for_each_child_of_node should decrement the
> node reference counter.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/of/unittest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
