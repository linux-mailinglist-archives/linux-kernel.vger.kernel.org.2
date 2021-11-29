Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45A5460BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376635AbhK2A5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:57:54 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45938 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhK2Azx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:55:53 -0500
Received: by mail-ot1-f52.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso23153306otf.12;
        Sun, 28 Nov 2021 16:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HCqhseT4+/Hl1t/scbLsEWRI/4ZoR7CJXoQ0/zCDzvg=;
        b=annj4HbrF0nSwNMvMTXK7RVdmyiGyWbmFaDn58vjeubE376THr7DGyjZdppek0y35D
         mgYjb80zVLmL8IeGmX0eT/9+mmGwKYyMWnDJJpHsFX2AIiczklQl3b/Z0U3vqt/3b2OL
         hSOedr5MgUlA9oCZ9Xn4gMMrCdY7UvYcEsWZLT7GgUvU/HBs0T5CYi2timX7LCxqwp3Q
         FmHbg7vXZvPU6YtcnfPbrayacq/0QE97Sp2/NmNsR0yQlHogjCNMS2ALOHCc2WoRzerr
         PerpDW/ILPtz6ozDPUGQiZbc5lGFhx96jPoftl+jGM8Kt48SN8KV3XGMs/WHKgYRKl5/
         cUzA==
X-Gm-Message-State: AOAM531PJEWRV0EIiCTZmlQ/JnjR5r5/KWqom55EGNMXPxKnMpqzoiof
        11VetklUe+8JhdFxWOm89FW1BVwvIQ==
X-Google-Smtp-Source: ABdhPJx4wTCjAQT4EaY0ly2dFFI+f69LFRO+xpHYdLTA5GgBRgh8vt6fKUNrKxa7NTOCl+uS54d26w==
X-Received: by 2002:a9d:7758:: with SMTP id t24mr42340386otl.264.1638147156637;
        Sun, 28 Nov 2021 16:52:36 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id bg38sm2773555oib.40.2021.11.28.16.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:52:36 -0800 (PST)
Received: (nullmailer pid 2922409 invoked by uid 1000);
        Mon, 29 Nov 2021 00:52:34 -0000
Date:   Sun, 28 Nov 2021 18:52:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH V3 2/3] dt-bindings: da9121: Add DA914x binding info
Message-ID: <YaQkUqKVDBaCBCIW@robh.at.kernel.org>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
 <32e300765a1e3889d804e81efa393d4a6fee93e2.1637709844.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e300765a1e3889d804e81efa393d4a6fee93e2.1637709844.git.Adam.Ward.opensource@diasemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 23:27:57 +0000, Adam Ward wrote:
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> ---
>  .../bindings/regulator/dlg,da9121.yaml        | 75 +++++++++++--------
>  1 file changed, 44 insertions(+), 31 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
