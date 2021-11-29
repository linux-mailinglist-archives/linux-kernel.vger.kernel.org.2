Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE538460BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376425AbhK2AyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:54:21 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35720 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhK2AwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:52:20 -0500
Received: by mail-oo1-f51.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so5201086oog.2;
        Sun, 28 Nov 2021 16:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdygPQfvIuf/Rqnm/LiZpMOirVFNGDG0GAPsA8dkmE0=;
        b=1Ojs8WAjd8onWkLeIVn37srEEUOzomf2x8TaPYiN2T1icfUAMeJOPGn1+2u1Umynpc
         mrJmEZUJZWA77zb2pJRAfAJqsUZ6EqThGpd5AGF4SQZ+QBtb4TbukECjH4+q9YGIsYaS
         Z+7hOL8d0GjBfJm2Y9qJNhyq+Xcpg1suId4hJrPrFFO86j3nMptpWsBU57jg9etNNAd5
         kp48U0Jb3QVyr+bwauoCcB9DLUWt+7ozAyNiSsc3px5UdsSasunJN8oWbBwviNHFwEfw
         aEgSjwMEcz+NWtyxc8rA9EvcqvlMBZxhVhwiw7iglIUalv51JqAnFaGnPJ1DyD47diBL
         HcYw==
X-Gm-Message-State: AOAM530HMMfCup0LIaRpa0ae2NRDL768QyySlnNsxYvLbFaCkF4KRDuS
        y7q2stnp5hWdoT/y3+PtSg==
X-Google-Smtp-Source: ABdhPJyEcBYNOQIM8Q9FL9csszUFP9BxCEEL9u5/QJ44Yf5RlvSazpzWt8vkACMHBIn5JHWR0abgnA==
X-Received: by 2002:a05:6820:30b:: with SMTP id l11mr29850146ooe.32.1638146942936;
        Sun, 28 Nov 2021 16:49:02 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id a3sm2381090oti.29.2021.11.28.16.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:49:02 -0800 (PST)
Received: (nullmailer pid 2917160 invoked by uid 1000);
        Mon, 29 Nov 2021 00:48:59 -0000
Date:   Sun, 28 Nov 2021 18:48:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: da9121: Remove erroneous compatible
 from binding
Message-ID: <YaQje7L++mz1CknP@robh.at.kernel.org>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
 <2e5f602d3fba02691f6113884a57a894a697ba0e.1637709844.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5f602d3fba02691f6113884a57a894a697ba0e.1637709844.git.Adam.Ward.opensource@diasemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 23:27:56 +0000, Adam Ward wrote:
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> ---
>  .../bindings/regulator/dlg,da9121.yaml        | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
