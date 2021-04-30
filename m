Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749423701A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhD3T4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:56:00 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:42915 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhD3Tzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:55:46 -0400
Received: by mail-oo1-f50.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so3660951ooj.9;
        Fri, 30 Apr 2021 12:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cv5DoellUyUHmc6wATJcRB+7+HkQncE3Z6E76KEyvN8=;
        b=OKLBsliZWbAa/p9+opgOAjm2VOsc0orDCZiJYeFLD7eFQnLbA+EIt7kXBswIyYiC6H
         nSWCaMMjdlTKFgTd6j3CZo+gW3bocFOl07Cjcba8RlhnUdsgR+N9scMuGpO6Hvg3LEyu
         qHXlurv5lZ02ePpQzhRK5t1ZTSdDTpxVapzXfGifPDAwzdtPac5EhYq/SCIzG4kwFqq/
         2Lr6qx5E8gxOKkP3wR5dkyhBcaKzsvPDK0XaOktndELEcHtgVvrh0j2GTyW2iZrx5Jw1
         tMg9krIAKp29mEbXIEbu4onCIf7R2yegM8dXS8SZFzBfk7J7HjDCipZuGVtj+TqGylq6
         2Kyw==
X-Gm-Message-State: AOAM533geqTcwrHM21cQA3thw0k6yL91Hc9lTpsT3kzb4h3k9Ng15Cjz
        G9TJBfnSckMhRApwAuFzHg==
X-Google-Smtp-Source: ABdhPJwp29LqTJa5FxjUONJ6oRcx2BIKfyJhc9iEtfXkozN0dwyqryBhWO5NAroFzev6mJZ78sqr+Q==
X-Received: by 2002:a4a:c316:: with SMTP id c22mr5925238ooq.65.1619812494200;
        Fri, 30 Apr 2021 12:54:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l8sm881193otk.36.2021.04.30.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:54:53 -0700 (PDT)
Received: (nullmailer pid 3779726 invoked by uid 1000);
        Fri, 30 Apr 2021 19:54:52 -0000
Date:   Fri, 30 Apr 2021 14:54:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v8 3/5] of/platform: Add stubs for
 of_platform_device_create/destroy()
Message-ID: <20210430195452.GA3779685@robh.at.kernel.org>
References: <20210428184132.2184997-1-mka@chromium.org>
 <20210428114109.v8.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428114109.v8.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 11:41:30 -0700, Matthias Kaehlcke wrote:
> Code for platform_device_create() and of_platform_device_destroy() is
> only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
> symbols when CONFIG_OF_ADDRESS is not set.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v8:
> - fixed C&P error in commit message
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - patch added to the series
> 
>  include/linux/of_platform.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
