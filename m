Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E41F41692C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbhIXBDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:03:00 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37439 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbhIXBC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:02:59 -0400
Received: by mail-ot1-f49.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so4137211otv.4;
        Thu, 23 Sep 2021 18:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urz8FYBXj65a7OQWijy7xkzj+b5LyJCaBborSqW0HQA=;
        b=OYwE8TUMmg//RJ/Q3wVK2IJee+epycAQoQPYufB5Eqw2qlb5V+YAS40H5RMbZX4x0C
         xx4RGQyN/cXTutImw/wDXHuFN6bL9ss082GlbAKa/3RPxB4h9uWCJl+YkvlJSa4jHktr
         oTCdmzyVt0s+gM4te2ZAeZwxbmfdzneXdEtPQS1it+o5X7ooM6ih7ZwbCrHbpbA0VZNV
         mhxPp/YwxtuihA8Clcoq/vKo7XZTslmfwMvPJPezn4/vabqpg7sr/cITLw7eFJNljXqL
         j/yHJxXlaynrwF8j0M0VI6NYS6YeaP/7RInL2slROMF2NwUqwse7OITSxzdUPidejsoa
         td5A==
X-Gm-Message-State: AOAM533jXJ4ZbbGsjGh4YIMNXFf/onurxaU4i6WW0UucCO6iXoMfnSWj
        Das3LJcE/ffWPmKpIHPdrA==
X-Google-Smtp-Source: ABdhPJyYluxit92wpgHRxp5jm/+GCNNV1Rzzp6SPv42n9fF9kjTALxEgk6gmgNeZvcL8R+VX8w/dkA==
X-Received: by 2002:a05:6830:2b1e:: with SMTP id l30mr1515926otv.55.1632445286993;
        Thu, 23 Sep 2021 18:01:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n33sm1706549ota.8.2021.09.23.18.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:01:26 -0700 (PDT)
Received: (nullmailer pid 3850087 invoked by uid 1000);
        Fri, 24 Sep 2021 01:01:25 -0000
Date:   Thu, 23 Sep 2021 20:01:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        yulei.sh@bytedance.com, osk@google.com, robh+dt@kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        andrew@aj.id.au
Subject: Re: [PATCH v6 2/4] dt-bindings: aspeed: Add UART routing controller
Message-ID: <YU0jZb/VgSTeHMMK@robh.at.kernel.org>
References: <20210922073241.14119-1-chiawei_wang@aspeedtech.com>
 <20210922073241.14119-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922073241.14119-3-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 15:32:39 +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed UART routing controller.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
>  .../bindings/soc/aspeed/uart-routing.yaml     | 56 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
