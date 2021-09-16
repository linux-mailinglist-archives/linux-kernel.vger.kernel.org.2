Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAA40EB2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhIPTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:55:49 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:44644 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhIPTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:48 -0400
Received: by mail-oo1-f51.google.com with SMTP id k18-20020a4abd92000000b002915ed21fb8so2428287oop.11;
        Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P8yKybFkj8lrDPXW7Os3C5NUGXbJPcqo5yhZY5pR8wY=;
        b=vzVdjnfljkHaLs965jF7T4yBQWGtfcrLKxEdhMJNhxsocg56nylvu9pxtrEWoyKPBT
         qJrV4alN3JKdIl/zR66FKNPea6YCp4RSyLVse1bk7nzs/qMO6NrreCoqHxMPY54EE6wL
         u7ZIh3wJWmvYO8JVdsi06P456FaaIaErDjqBrcAEee+F9frVb+DEbquh4+WuB4sEEVb3
         /0LzTmMQFVq94w8IBb0M/SqZ7jOHo/8M0Bo0rrazZF5erpkROnrLHWtX03MoMbnEg1ma
         h7mzHQjJSL6En7BMoBJy9j2zWJbDxLk01O7zSyumureaAvFsSnTZz4Us4HXQuR7M8RZr
         CCDg==
X-Gm-Message-State: AOAM531UKXpm05dHjFc9/sBHWxUoGQ/Pl7met98wtk+b5FauIvB4e7dq
        0scFifTL9CRODWwAmHaspg==
X-Google-Smtp-Source: ABdhPJzqQYc9fk1ideD8xo+zjME0IBa/yn9xoKgUQy0xFxtBQsjU9UzwvguQUm5pLqb12ErUNwpuNQ==
X-Received: by 2002:a4a:b502:: with SMTP id r2mr5800419ooo.70.1631822066935;
        Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id z7sm1010458ooh.38.2021.09.16.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Received: (nullmailer pid 1386188 invoked by uid 1000);
        Thu, 16 Sep 2021 19:54:23 -0000
Date:   Thu, 16 Sep 2021 14:54:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v9 2/4] dt-bindings: mfd: logicvc: Add patternProperties
 for the display
Message-ID: <YUOg7wxwRuQC0pK7@robh.at.kernel.org>
References: <20210914200539.732093-1-paul.kocialkowski@bootlin.com>
 <20210914200539.732093-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914200539.732093-3-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 22:05:37 +0200, Paul Kocialkowski wrote:
> The LogiCVC multi-function device has a display part which is now
> described in its binding. Add a patternProperties match for it.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
