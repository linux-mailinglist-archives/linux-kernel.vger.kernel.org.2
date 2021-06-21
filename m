Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC13AF148
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFURFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:05:55 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:35385 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhFURFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:05:30 -0400
Received: by mail-oo1-f45.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so4656714ood.2;
        Mon, 21 Jun 2021 10:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3f9U6C3nBsAvn02vUv8K51MfY0R3pWhrXNzVaZmJf4=;
        b=M3JFRBHMmcVEwTNxeuaX+FarXBYDB9XMGBJisEL48DWDrxavSMfAMvTbCa4LMWdFsZ
         gkM8nJWm4ONlVOT4+9Si/s3N+qqdQnwsXm12sAmh/DkEVzLDp2wgpWnyuVap0KUMWm2S
         XrG8dxD6Fqnw5ThkXsEu5SwsbDoojwh0AS0iv8t9n26Lap/nzcimGvCgZlpVj/6ftWcY
         kOX4BQOqyrsWr/zd2ovQXhUNEHC8Eyd7QZfTbl9YThbl9PIgYkCiWapVqhnssvaJBqZV
         ZBmzIAVnwzVzFSssV8caY7qN1Al/lnjGLQSdwPfwnDv3E8ly24C8Rj/ZEBbzoeVMqUpc
         7XEA==
X-Gm-Message-State: AOAM533ynjOwNTRyxYcpAyilwHsVMjAQljMUkZAG7HdkzvCbOWc0ttjx
        y/cgyt4pKpT8AHsMdWwWGg==
X-Google-Smtp-Source: ABdhPJzOpUzG6IiPLfjBVe2mMaG7pE1YhpEe7+vjB7L1qy8iv18ZTET0u8xuArEfsr6snzDh8HYy2Q==
X-Received: by 2002:a4a:e907:: with SMTP id z7mr21832643ood.20.1624294993992;
        Mon, 21 Jun 2021 10:03:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d136sm3679015oib.4.2021.06.21.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:03:13 -0700 (PDT)
Received: (nullmailer pid 975940 invoked by uid 1000);
        Mon, 21 Jun 2021 17:03:11 -0000
Date:   Mon, 21 Jun 2021 11:03:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: spmi: Correct 'reg' schema
Message-ID: <20210621170311.GA975843@robh.at.kernel.org>
References: <20210615172024.856360-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615172024.856360-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 11:20:24 -0600, Rob Herring wrote:
> 'reg' is defined to be N address entries of M cells each. For SPMI, N is 1
> and M is 1 or 2. The schema fails to define the number of entries as it
> only specifies the inner cell(s). To fix, add an outer items list with 1
> entry.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/spmi/spmi.yaml | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 

Applied, thanks!
