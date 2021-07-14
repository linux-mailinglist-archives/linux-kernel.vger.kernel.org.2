Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0963C93E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhGNWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:33:57 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:35607 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbhGNWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:33:56 -0400
Received: by mail-il1-f179.google.com with SMTP id a11so3179622ilf.2;
        Wed, 14 Jul 2021 15:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IdK0IO2DN+mRcPjrdhNoWbulNJtj9bPZcIWuLX28H2o=;
        b=eHzVErcInt+tFYxYjw1MG/eelsVMbLiatHM49iwbJoVIthXMIoq+klYkzNmyTyMu0A
         yiiaV2uwtjRZhQEI7RrIa6sz0rDumr8tmUKGZo+W3QIQobUlPyYZ8cVPtRR40iP+H23A
         a1LQm7kHcNV7N35W49EcTRxo3ps5wK/gMOmlor0EIrot1M1xN5PGSnLWuEXLyJiO0icl
         bWWXFT1zvWqZjSKbP6DRBHtmURM0G+0mxlIacZucJ2Yq0l+evu3FxRzdUYZKr5hEXNms
         1HOlgoq0GN0jCdrJWahPCuO7QVvjBDdTKOha71GG1EwmD7YXmqG9MMOQrF3qLTSwx2vN
         6fvA==
X-Gm-Message-State: AOAM532dLkhzc6blQzUxCfMiuFAb9ZW0MhEsziGPSptDwXwp/GmlU7hZ
        lBtun3Ap8PToC/aOrL/fnA==
X-Google-Smtp-Source: ABdhPJwkQqrE9WhjInb9jEM0M38D4KnzR/ziBq0L5GV92HdpriU7PYWwrXjCPOgBtnNAiz3ZF5QHPQ==
X-Received: by 2002:a05:6e02:1154:: with SMTP id o20mr105554ill.168.1626301863235;
        Wed, 14 Jul 2021 15:31:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p6sm1997996ilg.4.2021.07.14.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:31:02 -0700 (PDT)
Received: (nullmailer pid 3653436 invoked by uid 1000);
        Wed, 14 Jul 2021 22:30:59 -0000
Date:   Wed, 14 Jul 2021 16:30:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
Cc:     "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>
Subject: Re: [PATCH] of: base: remove unnecessary for loop
Message-ID: <20210714223059.GA3653253@robh.at.kernel.org>
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p8>
 <20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jul 2021 23:03:28 +0900, 권오훈 wrote:
> In __of_get_next_child function, loop iteration for getting next node is
> unnecessary.
> 
> for loop is already checking if next is NULL or not, and
> of_node_get(next) always returns next itself.
> 
> Therefore checking return value in the if clause always evaluates to
> true, and thus it always breaks out from for loop in the first iteration.
> 
> Remove the unnecessary for loop for readability.
> 
> I tested the code as below, and it showed that BUG was never called.
> 
> -       for (; next; next = next->sibling)
> +       for (; next; next = next->sibling) {
>                 if (of_node_get(next))
>                         break;
> +               BUG();
> +       }
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>  drivers/of/base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Applied, thanks!
