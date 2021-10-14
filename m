Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1542E12B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJNS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:28:19 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40642 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhJNS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:28:18 -0400
Received: by mail-ot1-f49.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so9429631otr.7;
        Thu, 14 Oct 2021 11:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQAasxDLRS1u9jevsqz8RUI1IQpuWssfa8XgMkeur6c=;
        b=A0n1kukH1io5K/CVk9qTZP5zrxefyCUPZrwmrvTQdLaz4ch7i59Pa4t6/GzoS6iKlO
         ssDaSz+sYCZ8jt343xJNMNnj+F/o0VLWpSs6FT4qwmioWWKQbeymL9EM3bHly4z4Gpol
         4XsWPBRMiZAsKNHz0tQScvHcpf9KSENw/O6dUc4IJBJKnMhxVjUTZb2Wylrx0LvsgCmJ
         TX/Ru5E4+ScgN9bGUXwmZheRVOmOVmqAM/4RepZQmQqCzWxj0pNF17pHcQXOpLBdxqRJ
         G9jCq7B8RjOz/afZi4dW6PE/tRFaamm+3zak67XkeY6Ca+0skAho4yBnGNHiAk1BJk64
         ABcQ==
X-Gm-Message-State: AOAM530ekd0n4NS4tgNdvTOX43UY9Dd7Q73Ly6eDQrQGiZwHD4guoTWL
        B7Lb3q+b9byFgL3OQOerBg5o0nj+wg==
X-Google-Smtp-Source: ABdhPJzrPUgfiX7MCdky9cKW18XrYY61ThSzah9ZAbYUAzImP9lRZ0wTfi2Q4neBpbAQk1qFjQMx1g==
X-Received: by 2002:a9d:72d5:: with SMTP id d21mr4142623otk.181.1634235973111;
        Thu, 14 Oct 2021 11:26:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c21sm728207oiy.18.2021.10.14.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:26:12 -0700 (PDT)
Received: (nullmailer pid 3678542 invoked by uid 1000);
        Thu, 14 Oct 2021 18:26:11 -0000
Date:   Thu, 14 Oct 2021 13:26:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        devicetree@vger.kernel.org, neil@brown.name, sboyd@kernel.org,
        john@phrozen.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: reset: add dt binding header for
 Mediatek MT7621 resets
Message-ID: <YWh2Q4FA0t2uDZSW@robh.at.kernel.org>
References: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
 <20211006112306.4691-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006112306.4691-2-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 13:23:03 +0200, Sergio Paracuellos wrote:
> Add dt binding header for resets lines in Mediatek MT7621 SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  include/dt-bindings/reset/mt7621-reset.h | 37 ++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt7621-reset.h
> 

Acked-by: Rob Herring <robh@kernel.org>
