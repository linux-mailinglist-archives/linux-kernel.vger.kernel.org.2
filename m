Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3B460B45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359616AbhK1Xun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:50:43 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:38807 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhK1Xsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:48:42 -0500
Received: by mail-oo1-f49.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so5161212ooj.5;
        Sun, 28 Nov 2021 15:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1bNxGTLKwnOkIQ3OD4aqwYap1kbW7vuiCRU2yUm5aE=;
        b=wnZuIQIXfy0dhIyCFe8kwsE0dq7tOLAQ336DtHZT7Au8u7/EylwJAFJYQ5oNtwkdk2
         BlASpD1BKZiPyr5XXyd8kAkuSSZjo7oIQh2EGVli7VaPYM17nGqT4XJec52QuZJ6uiI8
         pX/mcGGJ5i0WbVxDptJrUC6Zu7zRBGl706YXAu3kVA1+8kkGjZxKlJBg9QYl6ziAPStv
         MNEc2xioMwEyr1KMnENuPTPjYv4XPxhAc4s72K5+mxyHuX4+wpkay5wFzy9sRKoMATra
         FDWL4guM3Aa178LRcc4JnMdQf1iQS5DHDS4lqfnJ7IKI9prZMhLMr4u747EJ0dV+/fKs
         bRRQ==
X-Gm-Message-State: AOAM531okzdyzfBazkZon48r8OSdO1LRaIgnZ29fDI6CcOfp7xjKOtsN
        YGIpQuEViYaIcQG5npi45D/Q6Uevew==
X-Google-Smtp-Source: ABdhPJzclhrek5Yh54TMLe3ygipLJxYxBpq59+BJkrZd1tr2X8PDt2gvWjWXw2eNiqZmzg7v0r99lg==
X-Received: by 2002:a4a:dd04:: with SMTP id m4mr29583601oou.18.1638143125503;
        Sun, 28 Nov 2021 15:45:25 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id w71sm2613703oiw.6.2021.11.28.15.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:45:24 -0800 (PST)
Received: (nullmailer pid 2837880 invoked by uid 1000);
        Sun, 28 Nov 2021 23:45:11 -0000
Date:   Sun, 28 Nov 2021 17:45:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        aford@beaconembedded.com, Fabio Estevam <festevam@gmail.com>,
        tharvey@gateworks.com, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH V4 4/9] dt-bindings: soc: add binding for i.MX8MN DISP
 blk-ctrl
Message-ID: <YaQUh9H9isjal6gb@robh.at.kernel.org>
References: <20211128131853.15125-1-aford173@gmail.com>
 <20211128131853.15125-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128131853.15125-5-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2021 07:18:47 -0600, Adam Ford wrote:
> Add the DT binding for the i.MX8MN DISP blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
