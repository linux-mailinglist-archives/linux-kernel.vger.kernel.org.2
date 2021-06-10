Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D53A3304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFJSZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:25:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B1C061760
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:23:22 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id u20so601614qtx.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gi/arimkSHwydb+IRl+gsdmHypvcrITgoc6X6YtJlzo=;
        b=CrpNFLANQtl2GqFCm/Mz6BQVoy4o0fpyIY/77ZSfpYBaIeULYm8mLaFcXsUWOrAoLX
         fUyrO2xKcER0ZP1XfghZP9dAZMU0rPFSlongJWsbBnFZR486z2lfsjXFwJ1ObzDnlAxH
         UbJ5ykLFkF8nMeTFIWNH6jwuqEHk1CbSzdh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gi/arimkSHwydb+IRl+gsdmHypvcrITgoc6X6YtJlzo=;
        b=q3LVBPRtYJTLMnpXJW6iq4XWX8SngswWDxGvxvQvQTli5MxN2Xk4fRvoyz6SiKhyDV
         U/dj9Q8F3AiIpIvV119I4ln3cLoAlON4Vdz5R2AS9z3CuKjfNghMSSrxXTQcv8IiXNF3
         IZyTkPxL1HmSeMuQvkp8rzvQlrtLl1LJKGZRUbpzqTEhA/KSbIeXXFVv4n+PIyD4L0si
         UrKdrBO1S1ly3ko3ppHcV53InaIx3NtsTSv7xbwfyT9nxkDK69a6LJmbRV0JbMojQv4v
         efSgA+ymf3Zl/IK+jdZWNtK/18Xh/+kMdziJNwPjw59Kl+8D9HHhI1zgcun2MCL4jL7m
         kfig==
X-Gm-Message-State: AOAM530Upyf8RsoOAmlblt/Gw5vlJPXRDOG2QTEURavo0jMIG49kNtdA
        emARbb2WmZ/6oZIr6pGZyMmRXtKk/EKzNsjF
X-Google-Smtp-Source: ABdhPJzr/jg7uCK65jVADwAaDfKz6xQnTjHNB4oz9W8d9VnSPRV6hubXEEk8+XcP16M7322WdLinRQ==
X-Received: by 2002:a05:622a:1495:: with SMTP id t21mr98910qtx.63.1623349401115;
        Thu, 10 Jun 2021 11:23:21 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k9sm2770435qkh.11.2021.06.10.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 11:23:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:23:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     David Hildenbrand <david@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
Message-ID: <20210610182318.jrxe3avfhkqq7xqn@nitro.local>
References: <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <b32c8672-06ee-bf68-7963-10aeabc0596c@redhat.com>
 <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 08:07:55PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 09.06.21 12:37, David Hildenbrand wrote:
> > On 28.05.21 16:58, James Bottomley wrote:

*moderator hat on*

I'm requesting that all vaccine talk is restricted solely to how it would
impact international travel to/from ksummit.

-K
