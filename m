Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5181D34F42C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhC3WWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:22:16 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44556 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhC3WWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:22:04 -0400
Received: by mail-ot1-f46.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso17055229oti.11;
        Tue, 30 Mar 2021 15:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6zE7eJ2fq/h+F919KpIJBmhEbaiUg8/PKDecbu+g1Qo=;
        b=QWBF2RrMQx/X4i/jvsSZCZ4L+P9rCQejElbtfOseHzqxc+PUGvqjcee7h5aeUMAJyT
         Uu75CwBBoKfizFKHCswqi7z0DLDDzXOW8fRftXwCFQUPxZKPn0/yXJuPoqX470mXqESZ
         1EQa1oLtBu4pQwsZxoQ/FY1Z43gtGHGxvEQdUA0cE2eLXLsIzyisyOZmv5UNFPwcciOs
         OEzi6P0dG5zTBArUlEMZOM8SS157zMXr9h3DLdsAtrRAtyybN0jFvOjzvltDJoN/NPn2
         KdkSAZUYAzuyGjfjrABHA/PEkiM9QpcMWuE5j9Gz+TCxhQboXYc0ku23cAFD2cfKFcwG
         4Ztg==
X-Gm-Message-State: AOAM533f1HpsXA42Hk7fCVqx0J2qim83PgDwWoqvfsV0Pk8xJj7THBUU
        R1gmSDsfowsa/f6Ua2W4MQ==
X-Google-Smtp-Source: ABdhPJxxh7Vv32YkMChIM4ids4ZCy2CnNS4R0YBJbzedDc+MeQB/Sq7p3Op7wydFkRethpl2DIl3KQ==
X-Received: by 2002:a9d:798a:: with SMTP id h10mr105741otm.170.1617142923563;
        Tue, 30 Mar 2021 15:22:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm81958oiy.24.2021.03.30.15.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:22:03 -0700 (PDT)
Received: (nullmailer pid 819184 invoked by uid 1000);
        Tue, 30 Mar 2021 22:22:01 -0000
Date:   Tue, 30 Mar 2021 17:22:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: ti: dpll: add spread spectrum support
Message-ID: <20210330222201.GA819152@robh.at.kernel.org>
References: <20210329164222.26794-1-dariobin@libero.it>
 <20210329164222.26794-3-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329164222.26794-3-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 18:42:19 +0200, Dario Binacchi wrote:
> DT bindings for enabling and adjusting spread spectrum clocking have
> been added.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> 
> ---
> 
> Changes in v3:
> - Add '-hz' suffix to "ti,ssc-modfreq" binding.
> 
>  .../devicetree/bindings/clock/ti/dpll.txt     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
