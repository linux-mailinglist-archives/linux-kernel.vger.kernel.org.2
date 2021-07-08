Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C63C15B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGHPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhGHPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:11:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A60C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 08:08:49 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x24so5021501qts.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2lQ1y/orDMQNUEXLTETNoGW6ipZLA49f+lo4DxkQTA=;
        b=IG0/w+IMGrUw6Vr3pXUAy4w51HrdpzH+dp5MCiPrbr0zOwkBHS+AsMmD8SQuMFUjYU
         Hs1tTHwUVegLVDNMlVXG3PpxTjcV+yVbUxf4ktyIbU0gGzLcu1JtnBZt2qYB7C5Vk5u/
         YFoIbAM2ypS++mIC+o6Bp2h6nLQn6JB4T66U9kx0UnPXf7GDxEYyFVs7veg4NhozdKKQ
         Fk8o39aXquvFqA38yBPaiG2tLtRDh5znGierjZj+1Mc4nK+ayQ0yH/kSN4pMJrrZTSG+
         GjCbIvX04r3lQUknRz+S0JdN3v36N0oKWEbssE9UCyWXFxQ4X30dzif77erBefXraMBn
         JaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=A2lQ1y/orDMQNUEXLTETNoGW6ipZLA49f+lo4DxkQTA=;
        b=qU9dEgQGHdJkNN1ygMca3WfMLOdi9pgRU6e7Xfoj0wZYOnAh+b1eFqKIUBRdu+XIy1
         7HUVw7gChkaWa3s9fwo9dFq64o4xoNXtnY1REAR9kP7+oRTag95OFIEfJm2z8VSLLibh
         8/DmvsDEaPuSdwWsHu91xZmkMeVZSwRSZFYUJQoaqpsPzeYFw94ZS/IPj4tZ935WF9+g
         CJaSRRDMT0S0NYM0YhMpoMK4mJZl5cPfqqLPCuLep/0YCrXhuZKEbRqX7VWUJPSze6Mg
         P+S36aEVzc6Tkg/KFTl9D+svelyr61ayKInwN+ilbQXNfT8o51udWzgaabJAeuoEB8/H
         nVGA==
X-Gm-Message-State: AOAM532ADnls737/n/H65F/d7SbM/25RbDERvbYD2ewR63TmhSt79tkH
        E8KnrXNFGPFm/iEmiQpH+m34Xw==
X-Google-Smtp-Source: ABdhPJykAIb6xl/0NUHtNKq/lDZDnYHUiHAevTI568j20etsPdR21J/3F20fBzYO5JQ8Nidjfn05/g==
X-Received: by 2002:ac8:5c83:: with SMTP id r3mr28469432qta.78.1625756928553;
        Thu, 08 Jul 2021 08:08:48 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id t30sm1106247qkm.11.2021.07.08.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:08:48 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     andrew@lunn.ch, alexander.deucher@amd.com, davem@davemloft.net,
        mchehab+huawei@kernel.org, kuba@kernel.org,
        James.Bottomley@hansenpartnership.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 11:08:47 -0400
Message-ID: <7263255.EvYhyI6sBW@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <YOcRfBtS/UJ81CFq@lunn.ch>
References: <2784471.e9J7NaK4W3@iron-maiden> <YOcRfBtS/UJ81CFq@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> - Your patch did many different things all at once, making it difficult
>  to review.  All Linux kernel patches need to only do one thing at a
>  time.  If you need to do multiple things (such as clean up all coding

Greg, I am going to divide the patch in three parts, for atm/, net/ and parisc/.

> 
> Why not use DPRINTK(), defined at the start of suni.c?
> 
>     Andrew

Thanks for the idea Andrew, I will make a new version of the net/ patch.

thanks,
Carlos. 


