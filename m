Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C68379A24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhEJWgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhEJWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:36:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:35:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u16so17275494oiu.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUc4hgydM0CmYj7T3eVJGvSCBCFbFHknkLeXpTs7Z6Y=;
        b=SLk9lya6kpODyG3A9aha91IDHmammqhVWHFEBiXDvoQg/K/Eygl/gKDZR6/tL3Yebj
         hDklG7mlvfI9Ci+pM9tIk5a8GIbH+nFzxXMB2be1qS6t9I60mqrkmwyxFWZAjTpYf/2n
         Yaf659jnGqNryNN0ZbPbhm1wM9hffJ4XBddJQfUjWRRLuVJqSAAlfdkUHnJ4Dbwr5PCt
         Nuc5t2GleTZvRizJ4pb6x0Ds08BybB8NTXy6Cgwh+2AMQc2eCSi3hFatmimpUOhFS9cV
         3SJmHiv9U/GxrA3hWaCOM4JrKd1e3HFItKYJQ+U1bLM++X0UZr2rPnvN5cTywazaVgk1
         MbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fUc4hgydM0CmYj7T3eVJGvSCBCFbFHknkLeXpTs7Z6Y=;
        b=ALhlSzPLzT94em1nwlPaDD6MAd1RMX0G6meKwa8oCBeqZ6B8H53Ioq5nboqedaEcYX
         WCrLvsAzyzMgNLEtZ6qUG6m+6cWwbZzSeqJaSsz9UvRfcLY5OUHg4kmIiarXxYXZIjzv
         SMWSvLBkQLcEhmTh8g9AuLw7iiz0eYVmgL1SpZ3hWruGqMZ0x+Zum90yRFzr7Cd9w7cR
         wn2fN6FdtQCr+gadvjV0D4zfo+T3Z3p4jNPqkllOvEUQhSpgG0j0N2E2Sk3hwLiO22Gi
         V5rt8Hkov8Gddm3Ffe9opTrzL0e7zBeA3IIRv7GnMZcIi+WDRc3iHlEQ3wEp9pZ2xpaA
         PUng==
X-Gm-Message-State: AOAM530gtpfeyzMHidhLLG+eFnv4yavGGHZdlVqJFFTcStY0zBux87Jy
        IpFHc8utHZ18soHJJHMIxZQ=
X-Google-Smtp-Source: ABdhPJxgFNdDGEUHPyAgN1KF//N7LH3FxagGp6jWy4NeVMTG7lL4PBPgFcGh/CxI8K5qN3VESAycKQ==
X-Received: by 2002:aca:ebc1:: with SMTP id j184mr19502217oih.125.1620686135243;
        Mon, 10 May 2021 15:35:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r17sm2948830oos.39.2021.05.10.15.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:35:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 May 2021 15:35:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rajat Asthana <thisisrast7@gmail.com>
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm: Declare drm_send_event_helper static.
Message-ID: <20210510223533.GA2335713@roeck-us.net>
References: <20210510123243.hmwar3swmrewskjs@gilmour>
 <20210510131616.544547-1-thisisrast7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510131616.544547-1-thisisrast7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:46:16PM +0530, Rajat Asthana wrote:
> Declare drm_send_event_helper as static to fix sparse warning:
> 
> > warning: symbol 'drm_send_event_helper' was not declared.
> > Should it be static?
> 
> Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
> ---
> Changes in v2:
>     Provide full name in Author and Signed-off.
> 

Turns out a variant of this patch [1] has already been accepted.

Guenter

---
[1] https://patchwork.kernel.org/project/dri-devel/patch/20210427105503.10765-1-fmdefrancesco@gmail.com/
