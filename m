Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335F932F4C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhCEUuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:50:32 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:36462 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:50:25 -0500
Received: by mail-oo1-f49.google.com with SMTP id x10so755722oor.3;
        Fri, 05 Mar 2021 12:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xxudWTQxZK+9ycvs/GcyZMOtlJ6x1HLohTyz9rI2C/8=;
        b=aeaHh4oyECuzEywAZA3RqVdt6SZiufqQT2AvvAGo9ee4H+pUsIMv9ocihEZ9zNNlY3
         E4IHIGsfqui3Dv6yO7wQR/9S0iEy5wKmhCKlDKcBds+6jSiqVIdhQ/Tmi199ZFF8rB6I
         N7ZVG3R0MJhOAbnFsr4/28YFAeWAzcpzLp5SFfEQugrVgrtBrUm0r9cnAHUEPnnUTj+f
         WYR7xAKMpJImsv+bhoKgR8CbSJoyyX6/Xg2RCt1oG79AOPQ/U3LP6n7N0VGzFqIM52nl
         bBVEbvDuteuZyRQgSlTlwksouh2ONBJpnqUaMyk4nx8vEeU9j+FnO9d8LUjSySaQVBu3
         fXfg==
X-Gm-Message-State: AOAM533rIKKWUCeoZX6lv216tgAcDKok/jp/Ir1b65qu8fSQdbkA5Hzy
        zcs9H2rN1WjPV7KGLtTkmQ==
X-Google-Smtp-Source: ABdhPJzv+EDixs5xzwCy1Hkn0ymZdtdR/kZiYhhJkzZnPP68bdXdn/A7TPW34L9FkBMJp0RxYfnXYg==
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr9304125oop.1.1614977424707;
        Fri, 05 Mar 2021 12:50:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 85sm732499oii.39.2021.03.05.12.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:50:24 -0800 (PST)
Received: (nullmailer pid 622024 invoked by uid 1000);
        Fri, 05 Mar 2021 20:50:22 -0000
Date:   Fri, 5 Mar 2021 14:50:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, damien.lemoal@wdc.com,
        paul.walmsley@sifive.com, bp@suse.de, robh+dt@kernel.org,
        dragan.cvetic@xilinx.com, jassisinghbrar@gmail.com,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        palmerdabbelt@google.com, gregkh@linuxfoundation.org,
        peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, arnd@arndb.de,
        shawnguo@kernel.org
Subject: Re: [PATCH v6 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox
 bindings
Message-ID: <20210305205022.GA621972@robh.at.kernel.org>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-3-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212222304.110194-3-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 14:22:32 -0800, mgross@linux.intel.com wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Add bindings for the Intel VPU IPC mailbox driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> ---
>  .../mailbox/intel,vpu-ipc-mailbox.yaml        | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
