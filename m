Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547443ECEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhHPHEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhHPHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:04:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87855C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:03:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v2so14444671edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yb1VspGeEa+6vIqGhuygrtILxKH6YEsREcc1oSVU1kU=;
        b=s9yyjtPYUOo2hNoAhkHh4Ljw2rRwbh9qrqCeX6+cxU41O9kzimWIUrVJUKaT4NyaQo
         m+cpgqVBCnLf4ZsEE3cixzK5JCSs8DCCD8CcfgHr+jjfGQ8Jre2GhQkp+xlqcDQ+Q2BB
         er7F7rROjbXr05CEMLzGEB7cE8gSJhsQlSVtpQGpJwQAZlUy6BJ76FSEPbHcDQjJ5Otb
         8YvsuZtI3OfTBWy4OL0LAhe2Y+muPh9M9YupzO9bDcIXzyQkUrZFWD2E/faLiZ0UEBm/
         lSip/dcsD5suO9kpkfZxUte+w0i1L1LnMmJmyCPn4k4Y10OoDj9b1r2TcP7bBFmcbc77
         1log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Yb1VspGeEa+6vIqGhuygrtILxKH6YEsREcc1oSVU1kU=;
        b=BjPOUCGhwwo0yyDyIzMU5/zZellzVXw99VD9PnBqCrZRxfpRD9iZEV74zq2LdR9QO2
         8nwYJJmwsHObwrfTHUTymCm/INeDRU0/G1/E2jHOo5Ktg9NJFOF9AxBuUgR3W75vXiXz
         IcEbuOb3R8w/ZpUiWxA+nwgDmKCDqPn05HQ3lzR5c8/uV9zo7iKnAlEPTnLluCT8xHuZ
         DNt+y1ybIEkqfPnWfWgFVyOONcfgn0OjVxTMdP4NM6JxE/GToOrdGcMrI6NGWgX2lv94
         0an9eT9e4583XNJt84mjBkKOr4UbbQJtJglR/932cwsujRyzPfWucQmSaVegYaMZqux/
         bL5Q==
X-Gm-Message-State: AOAM5323iHIkG9rIg6vHXIHUCxJvHAnEvNwfM519OKCEGAzmBb0TIScA
        O5Uxq86qF/CXcyJ+JX7j1Nzu9BJGoN9D2w==
X-Google-Smtp-Source: ABdhPJwZeh+sgTffMXUq95Yfd+ceZxj2C+La50wtKTotzfbkIE6hit2C7rhtFrxt0lV+6JpQO69qvA==
X-Received: by 2002:a05:6402:184a:: with SMTP id v10mr18149746edy.324.1629097428184;
        Mon, 16 Aug 2021 00:03:48 -0700 (PDT)
Received: from eldamar (host-82-55-38-10.retail.telecomitalia.it. [82.55.38.10])
        by smtp.gmail.com with ESMTPSA id h10sm4360839edb.74.2021.08.16.00.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 00:03:47 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Mon, 16 Aug 2021 09:03:46 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/nouveau: fix a use-after-free in postclose()
Message-ID: <YRoN0vWFN6Lw22ej@eldamar.lan>
References: <20201103194912.184413-1-jcline@redhat.com>
 <20201125202648.5220-1-jcline@redhat.com>
 <b4da382b17a77b66e45fd374c9d806dac6054e3a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4da382b17a77b66e45fd374c9d806dac6054e3a.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 26, 2021 at 06:00:51PM -0400, Lyude Paul wrote:
> This patch series is:
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Btw - in the future if you need to send a respin of multiple patches, you need
> to send it as it's own separate series instead of replying to the previous one
> (one-off respins can just be posted as replies though), otherwise patchwork
> won't pick it up

Did this patch series somehow fall through the cracks or got lost?

Regards,
Salvatore
