Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477DA449AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbhKHRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:48:45 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45659 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:48:44 -0500
Received: by mail-ot1-f44.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so23554490otv.12;
        Mon, 08 Nov 2021 09:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZu9bcvpFSuPChsd8AmgNZQmz9XHq12un/oglUoVUNc=;
        b=BB4Iv/MWqF93t8YDggSYviOTYnSSZoGBpWvlwbbLsP9Jnng1Bv7YCXRokkTGYk44kp
         MJ3KnBj97v2NzfIjHYwX+zrH5JpVHqKakLyKWl8oXCMlOlSNtmcZE4tx+dxWbSEW8nG8
         cZWymCosZg6tu8GNuWrG+wmXzV/nI29aJ633B+Lb7ak+srHIO1GK1Sx53zaxgWlM86K9
         2eQqzAI8FKnrZAFMbZ5TCbjUSfpt6D06tAXKg4ynZQcxf+rpEsBNDU/aDBbYHAkVETuN
         GINw2aIeztZfumz6oRRq/Q4JY7X6sYPT7u7QQ26oqlysOwHqWBG0sytwxsSOw1llUzYv
         RtEA==
X-Gm-Message-State: AOAM530HCdlrZP48vL3mLagBt5CMVXSxBhc/ib/ogV1K1uxz2YzXesWk
        zux1hvHwo8UBvYCpCHQ/2w==
X-Google-Smtp-Source: ABdhPJzYXKOwKUPjtXy6Q03uk2L6xb4RUQ42qRyorNZQZ5+A37Oe0WkSfATgUVQQsgURKjZLnBFBxQ==
X-Received: by 2002:a05:6830:448e:: with SMTP id r14mr611327otv.171.1636393559064;
        Mon, 08 Nov 2021 09:45:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w29sm5157502ooe.25.2021.11.08.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:45:58 -0800 (PST)
Received: (nullmailer pid 3814559 invoked by uid 1000);
        Mon, 08 Nov 2021 17:45:57 -0000
Date:   Mon, 8 Nov 2021 11:45:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, arnd@arndb.de,
        linux@armlinux.org.uk, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux-clk@vger.kernel.org, broonie@kernel.org,
        wells.lu@sunplus.com, mturquette@baylibre.com
Subject: Re: [PATCH v4 01/10] dt-bindings: vendor-prefixes: Add Sunplus
Message-ID: <YYliVZ/2vzUGXokY@robh.at.kernel.org>
References: <cover.1635993377.git.qinjian@cqplus1.com>
 <1a5f86dbfd1e4053cd2a69111fc7b277a49bc98a.1635993377.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5f86dbfd1e4053cd2a69111fc7b277a49bc98a.1635993377.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 10:56:58 +0800, Qin Jian wrote:
> Add vendor prefix for Sunplus Technology Co., Ltd. (http://www.sunplus.com)
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

