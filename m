Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7B3DAFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 01:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhG2Xky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 19:40:54 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:35355 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhG2Xkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:40:52 -0400
Received: by mail-il1-f172.google.com with SMTP id k3so7618241ilu.2;
        Thu, 29 Jul 2021 16:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTWaRpGPgXYGZ0nxv3aypr2wXYk30fYpsL6awQ1L3ik=;
        b=iHOlxNGi37ZqvC+qwtsNPQttbWYDyG2XW+lVDEN7hH6Wfjn5cvBUzIYN8TfqI4Zvuv
         2ZraYw17abALs2uhujQyqIRJeA9gDNWGoUslUWMHKKqwvVU2zmwNJLNKsx8c1aT4tw1I
         4kG+4ytqBWBGIIIZBri68ks8HEc+R7kLGOO8a0yCpe79UhY7EgGb1PAFp/tVEiF5ivLO
         F8ojzSVriZZlhqxZoJ7sbGR0NTOB+77SQSYAJ7zICaNiLga9gGTSHnoJEMUWBF0cFH8m
         cjUtYkhqsqQVBhoZFxmfS9HHzOEqt8yXIhJggx69Lgf+bFx+IjvcIC30QYpcd7u/WxDN
         n8UA==
X-Gm-Message-State: AOAM531NKeZRfJBUSTzR10zjWtiSlaBuYIGvcHV+B5KDEEmWwbb4ABVq
        92fPxUOWUi6YtzrhW1uthg==
X-Google-Smtp-Source: ABdhPJy+s4DqM6X4LI7vSIzdG0HB+/20GDhODztS2lTaljhGw7cu/Wa9hFsvPriogt1XQbpJAlFW5w==
X-Received: by 2002:a05:6e02:1567:: with SMTP id k7mr5530259ilu.146.1627602048201;
        Thu, 29 Jul 2021 16:40:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k13sm2353455ilv.18.2021.07.29.16.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:40:47 -0700 (PDT)
Received: (nullmailer pid 1130374 invoked by uid 1000);
        Thu, 29 Jul 2021 23:40:46 -0000
Date:   Thu, 29 Jul 2021 17:40:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add AUO B133HAN05 &
 B140HAN06
Message-ID: <YQM8fp1H/+xxkp23@robh.at.kernel.org>
References: <20210726173300.432039-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726173300.432039-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 10:32:59 -0700, Bjorn Andersson wrote:
> Add bindings for the two AUO panels B133HAN05 and B140HAN06, both
> 1920x1080 panels with 16.7M colors, first being 13.3" and the latter
> 14.0".
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
