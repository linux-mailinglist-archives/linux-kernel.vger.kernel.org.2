Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6743EF561
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhHQWDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:03:21 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:37763 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhHQWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:03:20 -0400
Received: by mail-oo1-f48.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so96482ooi.4;
        Tue, 17 Aug 2021 15:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ScTdPLrwQtDi3cZmXhC5N6qRhBgFnKWXKKXDfAopA1E=;
        b=rU52YXTfz35kJB1wvnJvFjInGIX75figKq2vqXbbcN43YT/JvwLGTaSbDbmM7xFbbP
         3GdYtu/UCrDVsk9H6IGc10bEZCmuZxmUYz5/X5sBPWAVIKfeTqQt2DOihKxbqXrcGZbK
         KlQtN2DkfTpF353UaDxhSZdfnFn7o2SXB8DKqK8bbJiFqBeFAC54SIWHJ7HGP9Ux4Dru
         a+zhrkqoHW50nmVKlERV6BNxrq/4T3l1obmGNbx7yus7CDfnA9oRWKINMJMKD5KSIfeW
         S10cEGmWn4sO0QnZqFh4ykN4g1JmDD2X71+OQKkMw7kywftMQN1XXPNJ2/T+TfEIJE1n
         W+iA==
X-Gm-Message-State: AOAM531Aes/eNP0LpVkw/yvQUUvFdnfe1fAiiJQ3B39iIahv8fZmgf+B
        YDIWWuMDqDDyzDun+fcm/Q==
X-Google-Smtp-Source: ABdhPJyERq+7XZqG4HqZb1SJiiUtZw8LOQg4skKX78fNFKeMnu1izNvJAEFmOHLlZJ/0MRh5bIsMMw==
X-Received: by 2002:a4a:b601:: with SMTP id z1mr4094467oon.7.1629237766211;
        Tue, 17 Aug 2021 15:02:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p4sm687381ooa.35.2021.08.17.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:02:45 -0700 (PDT)
Received: (nullmailer pid 917896 invoked by uid 1000);
        Tue, 17 Aug 2021 22:02:44 -0000
Date:   Tue, 17 Aug 2021 17:02:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/2] of: property: fw_devlink: Add support for "leds"
 and "backlight"
Message-ID: <YRwyBMjtKhdXlLJU@robh.at.kernel.org>
References: <20210814023132.2729731-1-saravanak@google.com>
 <20210814023132.2729731-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814023132.2729731-2-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 19:31:30 -0700, Saravana Kannan wrote:
> Allows tracking dependencies between leds/backlights devices and their
> consumers.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
