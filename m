Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3639A37066A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEAIWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAIWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:22:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4CC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 01:21:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so723654pfh.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+MuJt4JpNhaeCfTs6whxsfc3L27JznuEHDV6B3gjoM=;
        b=DITj8gyCFnbSw3FzSMIWVDBOLylocxGHOmp4XKAaOTVGbUQuQBSArSR/oSxRwaEjR7
         jQUqo/WH7YTkAr6wVjkYBUt7r4bfEDWoxCOeBZTpyO/NGtM9x2M2Gwd7+5/ZBBhVikzX
         j3J7UXI5PB0myEj1TfS+TYEAN30kImrb91csE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+MuJt4JpNhaeCfTs6whxsfc3L27JznuEHDV6B3gjoM=;
        b=pQfbg7NV+8w03bgF3MnjskEZKx+TUyteUjJWQWf63Qg2zmk2A1H1AuSscdBLQtSdN/
         rcBY7EsRuI0MMDr6Ha48ZmTfggZ9DVd+9lCVjwL1pkTLQFPw2D8REnkD5FQZZCw+ucnj
         7d2UJjqvwziYGgYS92+Gii/ur9a8NkpkocyIqITD4u08qXZEFDTukjNfwIQ/erPgiSl+
         blm/KZtUdUOCjiV0U4LZM0LUL7pFT3t7MLiSpFfDM+DDHUVrz41gvX3GisDePBSbsQ67
         CU9FGPiuTmC2eqS/ADUWm5EfZdbcZaCvT9HQPrWpQYjgyUTpAepqBomlvG3Bcp6zfpGI
         Fdqw==
X-Gm-Message-State: AOAM5318yMwH7VzwGzIH759mLRrJwtcweW/NPiaIqJNVuTP2Tv8TPP6R
        L2B3tPUOfe3g6fAb5tO9lUqrZ281969MVQ==
X-Google-Smtp-Source: ABdhPJxfSzqx7W9tWpLxTtm51XBBb35T0kXip5gom7sToV+vGXBNy3opr+TzKxSH2NkHrlp1ibYDrQ==
X-Received: by 2002:a65:4082:: with SMTP id t2mr8593837pgp.396.1619857303754;
        Sat, 01 May 2021 01:21:43 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id d9sm7737742pjx.41.2021.05.01.01.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:21:43 -0700 (PDT)
Date:   Sat, 1 May 2021 17:21:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 0/5] media: uvcvideo: implement UVC 1.5 ROI
Message-ID: <YI0PkqSCBMjj4P4a@google.com>
References: <20210430112611.475039-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430112611.475039-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/04/30 20:26), Sergey Senozhatsky wrote:
> v4:
> -- split ROI rect selection API and auto-controls
> -- handle very large ROI rectangles: limit to frame dimensions

Please ignore this series. I just sent out v5 with UAPI fixes.
