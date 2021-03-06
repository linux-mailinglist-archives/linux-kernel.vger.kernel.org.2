Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3347332FD34
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCFUjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:39:43 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45226 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhCFUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:39:34 -0500
Received: by mail-pf1-f178.google.com with SMTP id j12so4468155pfj.12;
        Sat, 06 Mar 2021 12:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/6QKpIukS6ktK9WNbuptfWDlWW8/Vp3FCb1Y6WR2wk=;
        b=RKLIIPPDD5TIMAKeca7x4YY00buzVRKbRpLWbwOTHotyw7893LSQUYHI4Rxv/qWMY/
         24Y9HDqCS7FCg7IbRy76niaa+W6ZM30e29viUuHXMqN14vEvpEcDlmek/KxZItZhfqk4
         p2aOKNgpzzy/8wG1/wylODdC2t18n4gSK0Im/ME4Z1LctzQSNhF2uDWQErjOQ6yUJiV6
         3/XcRb4DUq4DW5qnq3+UXkMI23mVAc+rLCbgRmK3jOSwhWmTts4cjKDNyUutyZiGGBoi
         Z30Lhw4+YhRsOlbBdq1KAOE/ZTks3uWpfH1draLU6EI7tKm9X+8A6+IAcQmQnVdbHw55
         Qc7g==
X-Gm-Message-State: AOAM533unjBAxDNFVOToKEJrGqqqTa0PQs0lqFBl7vvZIy1BTywifZn6
        xjtY5Ib3t//osf9fjTTOZE7jLJFPqzsp
X-Google-Smtp-Source: ABdhPJwR2dVQ6xpmhobSkNq2Yb9+uacrgTy1PECJ2Jmowmx+sUQXSCnergs1grjW77czLv31u+31Rw==
X-Received: by 2002:aa7:8292:0:b029:1ed:d6e5:1333 with SMTP id s18-20020aa782920000b02901edd6e51333mr14673406pfm.55.1615063173976;
        Sat, 06 Mar 2021 12:39:33 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id 21sm5945077pfo.167.2021.03.06.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 12:39:33 -0800 (PST)
Received: (nullmailer pid 1176909 invoked by uid 1000);
        Sat, 06 Mar 2021 20:39:27 -0000
Date:   Sat, 6 Mar 2021 13:39:27 -0700
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@oss.nxp.com
Cc:     Peng Fan <peng.fan@nxp.com>, s.hauer@pengutronix.de,
        sboyd@kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        adrian.hunter@intel.com, kernel@pengutronix.de,
        linux-clk@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/5] dt-bindings: clock: imx8qxp-lpcg: correct the
 example clock-names
Message-ID: <20210306203927.GA1176875@robh.at.kernel.org>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <1614222604-27066-3-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614222604-27066-3-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 11:10:01 +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Align with all other i.MX using the mmc controller, align
> the clock-names.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
