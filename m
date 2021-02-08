Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6D314250
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhBHVxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:53:09 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33181 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbhBHVuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:50:51 -0500
Received: by mail-ot1-f54.google.com with SMTP id 63so15674831oty.0;
        Mon, 08 Feb 2021 13:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwpHaJPHT9hwbQZAIHBuEis2Nw2MqCWdqmW8x64JWp0=;
        b=fDybsI9PQHMEjbEZHOluydIE5M01dSO097SgvNFD15oeD2kiw86HPkBSzf6ZYICQT9
         99ZvCazbl9mFWotHBYyZlyMmiVIO5SN6oXRT2EY+fWvDDxUPomiBQ/oXnTCvwYTo+Hhp
         cva1Mc0IMt3H8ClRM7Ggu4svAXBoX7Qeu+A/+s7JGYrVHg1p2Ka3+56wu2WnXyie493V
         Hs+yhwh/wQ7FMCVizARew6VzbjjwvPsjCeL2VW2BIxos1K5sGWh0VLvxkp32VxcO43t5
         vL94vgtVZRebBy7AKLHFUy02MinzDO7vmgF4KoIxou38X7JBsIiyJ9UvfRjbWh/dEOi/
         umBQ==
X-Gm-Message-State: AOAM530I8R/sRhX9Ur+QlOHNUjBl7P+3s07g1f+t3CwTBXGkA1ZU3a+Q
        89RsumFURiKRCDVqHDsl+g==
X-Google-Smtp-Source: ABdhPJyxT/PQgj7oJF26Sa0uel4nUG2DgEpWm+NsrJts5eqFEtl51umzi+NDwtHflzXRubGqKByvZg==
X-Received: by 2002:a9d:7519:: with SMTP id r25mr14493915otk.339.1612821009979;
        Mon, 08 Feb 2021 13:50:09 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm451634otk.2.2021.02.08.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:50:09 -0800 (PST)
Received: (nullmailer pid 2081875 invoked by uid 1000);
        Mon, 08 Feb 2021 21:50:08 -0000
Date:   Mon, 8 Feb 2021 15:50:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: dt-bindings: display: simple: Add
 N116BCA-EA1
Message-ID: <20210208215008.GA2081820@robh.at.kernel.org>
References: <20210115224420.1635017-1-dianders@chromium.org>
 <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 14:44:19 -0800, Douglas Anderson wrote:
> Another simple eDP panel.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - ("dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1") new for v2.
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
