Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E9349F00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhCZBru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:47:50 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:46623 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhCZBrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:47:22 -0400
Received: by mail-io1-f48.google.com with SMTP id j26so3851742iog.13;
        Thu, 25 Mar 2021 18:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sngwlWp/1C1wLCTJioHA8yvieWGfpSo2gnaG3nDM7ew=;
        b=QFvM5JcYaLjcF3vtrzjkeMOCRfjZCrMpMa0CT+UDkFILo8aV2cjv0sQ9U8T3nFzytc
         fqZil8d/PS1t2Asf8Ihy/opv0KRtLjLepEt7G9Wg2l6zU/SPLho4PkvWAy3aygH+34Kj
         lVKKsNFoqmM6bhpmM4wQMt34HSczXkMZHX3w9OMOkshJN2TZ5ug8BGDGgtxqdqwpSZmD
         cmnM7I+zw0Z7bydTTX+FZdHe4/1UAzdKQhqC/wNAktdV0zkU7SLJbSmvmWAOy/Rq4P3a
         3jpVfBWgafQCH3CQT3UVBytinlNNRUklVA/xyp2idrFzT0Hxdj/e2pdFWmx9U3chSGcF
         dIdg==
X-Gm-Message-State: AOAM530v0mZha+QvsnZ9oaLsd6VVMd4Upil9NwX/NUHx/xSBO43qFaV5
        5TzJ683FKyjMvKmY6sf9dg==
X-Google-Smtp-Source: ABdhPJxKQXQxICnj68NGH7tX+voeXqgKUwQnqNDWOx4izu+rOGFOkjE06gdEm4iuTT8i/Je1ZRD01w==
X-Received: by 2002:a5e:990f:: with SMTP id t15mr2027581ioj.180.1616723242204;
        Thu, 25 Mar 2021 18:47:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v7sm3519300ilu.72.2021.03.25.18.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:47:21 -0700 (PDT)
Received: (nullmailer pid 2156132 invoked by uid 1000);
        Fri, 26 Mar 2021 01:47:19 -0000
Date:   Thu, 25 Mar 2021 19:47:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        haidong.yao@unisoc.com, Mark Brown <broonie@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mailbox: Add interrupt-names to SPRD
 mailbox
Message-ID: <20210326014719.GA2156074@robh.at.kernel.org>
References: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
 <1616134537-27966-3-git-send-email-orsonzhai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616134537-27966-3-git-send-email-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 14:15:36 +0800, Orson Zhai wrote:
> From: Orson Zhai <orson.zhai@unisoc.com>
> 
> We add an optional supp-outbox interrupt support to SPRD mailbox driver
> with newly added sc9863a support and change to configure interrupts with
> names in device tree files.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
