Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E453C9D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhGOLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbhGOLSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:18:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B065EC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:15:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso925869wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E8lXG5uhDpqbhPe2W0SRgjhQ8NVXkyqNHQoMYkbY1Us=;
        b=lmoBw7yjPz3iMrmJbpE2rot8f6kj94tx10EOMZ1TtSITYlxrhHsiveAxNN+3mBXKgq
         8e1JfDDDcMoIVMDbZQJr9GqiTpDcOXfO3u+GAZ8APM6W1VYXP9uwMD/gtUbwDAi9yCgr
         VSrLAh9AQ5OEJVPtsqAgnYliOm8k6j7n8FHGH7YZYQFGwneOHVut/nY9gg5oEuKc5sV4
         snmepxiAzAmftGl1mZAkXVjIyt6K8Ufr7wWWRqOQOoYquEjl6ZIxJw7YTh7c6qz2ZkfM
         9G2H0zX3wo9gJVCkcSnGs3arYSbLOzf7mNnQbXN1smmZKDOpmR1m4PV3dqSS84Kr9hc2
         WnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E8lXG5uhDpqbhPe2W0SRgjhQ8NVXkyqNHQoMYkbY1Us=;
        b=f/ztl6ieflvfWPDERfFsgkdfm4rvdqAtEPMvy0xePM6o2lEXW1MbYt943TdI+ToB8x
         htpAxnF2vjuw7JALsAjr6DJZpAVvQHYtUXHaK9xOckFwRN4HWMDPb104KnRGmcJbKXey
         3nX8em6BRM7huQqHgnc73Itfi0FNTaK+hfoJKdCGHP7pQtXWFGroDjeqh6vYlDGlR3Y/
         6ucgomiFrbBYbbRRhLvET1oZtOGil/nDbW7MrY1vPEMfv4PLtLDxpoLS7CHrrHn/O+3v
         yND51wsuQtJJTHL3oatx29y9lQQb02jbzjuAXZCYKc5cJUXQYRfkilLRdeP95N80YHFi
         58Ww==
X-Gm-Message-State: AOAM532dU/0UVFA1H4yJiIpNHpwp7YHuF5Ds7He2g6LkJZmWWupo9hZH
        u+WVUNeoBXVbismtduX3Yfy1CcaB343EXw==
X-Google-Smtp-Source: ABdhPJxg23ChCi+hZ3oEn7SX86+gixEJRkb6AlTQocoioEXM/XtfqvhsFlu32Rae2qQ9lqkaaCU3og==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr10185161wmc.4.1626347712371;
        Thu, 15 Jul 2021 04:15:12 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id v11sm5920549wrs.4.2021.07.15.04.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 04:15:11 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:15:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, jbx6244@gmail.com,
        zhangqing@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-binding: mfd: syscon: add rk3568 QoS register
 compatible
Message-ID: <YPAYvZjHieZOscMy@google.com>
References: <20210624114719.1685-1-cl@rock-chips.com>
 <20210624114719.1685-3-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624114719.1685-3-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021, cl@rock-chips.com wrote:

> From: Liang Chen <cl@rock-chips.com>
> 
> Document rk3568 compatible for QoS registers.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
