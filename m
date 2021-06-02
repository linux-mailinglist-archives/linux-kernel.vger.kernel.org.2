Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64B3993A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhFBTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:38:26 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35367 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFBTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:38:24 -0400
Received: by mail-oi1-f178.google.com with SMTP id v22so3811425oic.2;
        Wed, 02 Jun 2021 12:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYSx52f4ZDE8Bx1jem0M8DJEVHzH9GCK3SePAGeVDLk=;
        b=aCE/UFUxBVXEBCJKA9hznqDB5iXf/tuZdRH19LW7+VHtALO8CR6T4REcWkX6CACfk3
         AxOJaeSmSbGM0+5luXulev4xrcbgJZ5elOgFY430UbuLNuOxQKx4AUlE1STKtLEY1LCK
         umeGXRS0RQyceaPWiGSf7Yct9vmNxTb0c304Pcj4fgDQ/zqSlMAmLtKx06FT7WXofQFE
         QUEyCci6pDQHOdnMAsWljl3pJLIj3qWtn5iNLy2eQPsF31PTcpGvCBzYP+PBfY/x785s
         xBS5QS9qsSkUWUgJvpV8GhlKBEx5mpJS3x1h09/3WZaVsdvieZWbtOWHU5+/+pt/zATU
         niXA==
X-Gm-Message-State: AOAM532zg6WpO2/pzQgxuSXWeE6H7CEJazvuCBMKw7ZmMPmVSd2rkkxE
        mu+6Cn3eY2TkYNdzkcWCLw==
X-Google-Smtp-Source: ABdhPJwaesupVLKHtFpoCvPdYuv99AGaU/mQgNQjg0yrJd/8nqZv438WAuo6ReQODxrjn9yuciKHUg==
X-Received: by 2002:a05:6808:341:: with SMTP id j1mr1744943oie.43.1622662601135;
        Wed, 02 Jun 2021 12:36:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x9sm176105oto.79.2021.06.02.12.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:36:40 -0700 (PDT)
Received: (nullmailer pid 3847385 invoked by uid 1000);
        Wed, 02 Jun 2021 19:36:39 -0000
Date:   Wed, 2 Jun 2021 14:36:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        badhri@google.com, gregkh@linuxfoundation.org, linux@roeck-us.net,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: connector: Add PD rev 2.0 VDO
 definition
Message-ID: <20210602193639.GA3847324@robh.at.kernel.org>
References: <20210601123151.3441914-1-kyletso@google.com>
 <20210601123151.3441914-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601123151.3441914-3-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021 20:31:49 +0800, Kyle Tso wrote:
> Add the VDO definition for USB PD rev 2.0 in the bindings and define a
> new property snk-vdos-v1 containing legacy VDOs as the responses to the
> port partner which only supports PD rev 2.0.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> changes since v2:
> - no change
> 
>  .../bindings/connector/usb-connector.yaml     | 15 ++++
>  include/dt-bindings/usb/pd.h                  | 69 ++++++++++++++++++-
>  2 files changed, 81 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
