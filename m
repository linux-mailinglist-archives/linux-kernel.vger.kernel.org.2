Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681241395B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhIUSAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:00:50 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39807 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhIUSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:00:49 -0400
Received: by mail-oi1-f172.google.com with SMTP id a3so348404oid.6;
        Tue, 21 Sep 2021 10:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tij06sZBOhk4dPckuX930zTj0/mSpGUpmNq1qsMPrI=;
        b=lFrhYQrd9hUkGLc1avm0EV9EHTJfVBh20MgVUXX1dTDloklVT3ib8Zc/qVP+iuGAvi
         1lHpnFWZ6e/emV9VIa03FUhkgcrpWexefPHy6albjcZo5p5PPPwzlbI/MP5I89GDgZ7y
         CCS3nw7m37Zp4q7yiuey+HokLJSQITD2e5JBvGP4PJxxutANIp+Lgdt6TzcqBLcDnFeS
         sxEbH8oYe/XRLlIYgeBKD0qqI/O64ZXDpt93sKouj6w1P1zvPk5GvZT/i/CVIOrGIt3U
         6/zQ+Jesv66TasAAeGjg4AyuSHBRWoUNyFAvfonuIllfumNpLcc/1H9KbBLahwo7OKoq
         pC1A==
X-Gm-Message-State: AOAM530emrazXWXM7VWVe8TpNo4x96t3Hx5b4wSniz7zuX2rIGDlbNZ1
        lrrSQiw3s7JhWqo3hJJHeHz+BeBrKQ==
X-Google-Smtp-Source: ABdhPJykh8BTdxWRtHjP6IXT31v4yHgej/H162fCJhJu0TzXFNuaify8/IHXFawRp7pl808zyP2fuA==
X-Received: by 2002:aca:1c02:: with SMTP id c2mr4761414oic.11.1632247158636;
        Tue, 21 Sep 2021 10:59:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u15sm4556963oon.35.2021.09.21.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:59:17 -0700 (PDT)
Received: (nullmailer pid 3050526 invoked by uid 1000);
        Tue, 21 Sep 2021 17:59:16 -0000
Date:   Tue, 21 Sep 2021 12:59:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tom Rini <trini@konsulko.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: submitting-patches: Add note about other
 project usage
Message-ID: <YUoddAztd2csXINE@robh.at.kernel.org>
References: <20210910142419.5237-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910142419.5237-1-trini@konsulko.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 10:24:19 -0400, Tom Rini wrote:
> In an attempt to make it more broadly known that other projects are
> equal consumers / users of the device tree bindings, add a note to
> submitting patches to say that extra care and consideration may need to
> be taken when updating existing bindings.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
