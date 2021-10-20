Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1A43503C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJTQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:36:57 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41668 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:36:56 -0400
Received: by mail-oi1-f177.google.com with SMTP id bk18so1390970oib.8;
        Wed, 20 Oct 2021 09:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=an5EVoSMMD3uE5hVl8845T3OpCZVxBk/sBf7jKjyc58=;
        b=sgU32uICL4LTKhEz9gDUIuUr7D6pt+AroOSIMIARbfTiN+eyzy/XaI2NN2XPzOs7tT
         iHoXn1okQpvM/dQ+Ga3yFpQ+eh/z95gVP3NkqrIWh9Ywtxvee71POlsEbXxMdrAiHYNM
         CYmdW28cux7zMRjkjnezqpaLOVw5dM74HYbBoawDfKjkRvrm2rxUCDYWST/z9g3z9rtR
         FAkeHE3a+kPuV/SvKdWUxfV8LWk/faZDjWNG63jPfDQI+HlhfmyX+Mw9JS76DzModlS4
         bdTX8oRwGL1lbsukVbvZ4ATJkpjxT4y+ecLYrTG/cEnN7v3vBnm3igNfaC2Hda0GdF6j
         7/cA==
X-Gm-Message-State: AOAM533+AZNuMd0yv/SB88ZnEqpbzPIjH+WDAF7PDsGuR679nZxIACav
        ObH8FjGIwei5PZP0cLo3ng==
X-Google-Smtp-Source: ABdhPJxlA9sDn0qd1fNqM0Z3ug22LxrSlHptMcwkBWHTNFW5gmoU7SaLo40XxuOjufBiTs+Cp1fB2g==
X-Received: by 2002:a05:6808:3c2:: with SMTP id o2mr1251oie.15.1634747681630;
        Wed, 20 Oct 2021 09:34:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s10sm528029oib.58.2021.10.20.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:34:40 -0700 (PDT)
Received: (nullmailer pid 2481665 invoked by uid 1000);
        Wed, 20 Oct 2021 16:34:40 -0000
Date:   Wed, 20 Oct 2021 11:34:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     frowand.list@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: make of_node_check_flag() device_node parameter const
Message-ID: <YXBFINB1+4Foir9V@robh.at.kernel.org>
References: <20211014173055.2117872-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014173055.2117872-1-nathanl@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 12:30:55 -0500, Nathan Lynch wrote:
> The device_node argument isn't modified by of_node_check_flag(), so mark it
> const.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  include/linux/of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
