Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E532E33149E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:22:52 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:36817 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCHRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:22:27 -0500
Received: by mail-il1-f180.google.com with SMTP id g9so9531693ilc.3;
        Mon, 08 Mar 2021 09:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X9ydJ7FmAW3txncN0dBhxkpB3+hhJPyuhe3NuQo+X1M=;
        b=cXrVTuAQcGfV86R1HaCFur2rPQGJC1Yi4v5CLqrBci2zhW6bXUrRX7TUuIftFyQ/nE
         ozbcutHJ29uFFH+CbMMJipTXLdK9lWlb6Q3a6w3VstVxuGr8Lc3NwCkUDC97fQLh/A7f
         83nPWyybcGz9MOQ2m5ZASBVGOSBJoJ9Itu5+NvJpULxJbr0PFnIr51++2CH2/IzMQyJf
         Mkt7tYEpmxu+vAVRuhwy4w+mHHl/nxmtYBvq/rTWrLDVikTWYQ2m3Q+c1btcuV1/jiBU
         qOuyAHkpGdk8HStRIosaVEsAq0LiTIyn9ZuoBrxnLalfmqpFf2Bhhd8r7tTRppfgmUNo
         dDYQ==
X-Gm-Message-State: AOAM533e7yA1BKtkyTDh+cpJdo9brlaUPUYVJi9+3nz8JmJkB9Q6UuXz
        70I2+hG9u0c+PHLDjmuNlw==
X-Google-Smtp-Source: ABdhPJyvejW5S+6hAR4SMK+ayD29ZyxVUaI3u2P/Hw1rzkn6j325EMRmao72L9ZNPTCNU7zLfXTKhA==
X-Received: by 2002:a92:cd0c:: with SMTP id z12mr21481018iln.109.1615224146696;
        Mon, 08 Mar 2021 09:22:26 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u14sm6276831ilv.0.2021.03.08.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:22:25 -0800 (PST)
Received: (nullmailer pid 2656083 invoked by uid 1000);
        Mon, 08 Mar 2021 17:22:24 -0000
Date:   Mon, 8 Mar 2021 10:22:24 -0700
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: lp875xx: add optional reset GPIO
Message-ID: <20210308172224.GA2656034@robh.at.kernel.org>
References: <20210226142852.19632-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226142852.19632-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 15:28:51 +0100, Luca Ceresoli wrote:
> Document the LP8756x-Q1 and LP87524-Q1 ICs reset pin.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml | 4 ++++
>  Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml | 4 ++++
>  Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml | 4 ++++
>  3 files changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
