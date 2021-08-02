Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05FE3DD1EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhHBI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhHBI0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:26:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0001C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 01:26:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id x11so28659856ejj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=dsziZdy5Ow5D8gopZOaZ5R2Y9q2Zn8W3l7iLlmn9U8Q=;
        b=c2CitCQI2D0p8lStmugnZTg3EBE0fiWkS2a2WI99GRh4AHvZngehWksh//Fk0dyeqs
         jZYKE/Yv8snD1NXwE21uuKFZ4secH6AltcuGRo/TawavWWF2SIBYjip5p1/63h4lsyxB
         0fjn6qDkkokkr5BBTytsNUgwWbsroAXTQhWVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=dsziZdy5Ow5D8gopZOaZ5R2Y9q2Zn8W3l7iLlmn9U8Q=;
        b=rqtYIz2JmDRbT0BLGbSmzC+gP9G5wRkTaNbqWvi7xx2HfzIUhKy/zbTgYOn8m0fq5T
         VzhOsPFx1TgBTVSJa/ohPd9mxopV7FsUe69TlxMwVVzZuOp9VnlMbH7enlnw3MGEvKTi
         6QgsjoslATcePAOmKPW17Lw9OutEQGZeIgcd/D7OlGH2FCxlIXs/2mLIr0DC6hRFRWdx
         WChCmn2dDXy9iqMvhQU/q+NZXFCYAzu2hhVDpjpJTXMgPZjYa1hBRTJeV6uDF4B0sATB
         ynFhMonlF13fLlV72Brx9CwPTf65NoyZxQGDMrviY4e7cbLrgbZO9LVncYDmGBbd2jcU
         ByIw==
X-Gm-Message-State: AOAM531ee/HKgwYmN//3AseX5pNTjxOsJCy3vQqb0HmteRY34hpAstkd
        fuRpkRTGcyGOyqRMk+JKfe0U4g==
X-Google-Smtp-Source: ABdhPJx/Y5AN+J27nGPtVIm7eKpEVMtxXL+seU+GKR4/npXEszZqv05aJbTr3NsEhmHTZ4BpFBsQOQ==
X-Received: by 2002:a17:906:af86:: with SMTP id mj6mr11196318ejb.144.1627892778556;
        Mon, 02 Aug 2021 01:26:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id de49sm4160066ejc.34.2021.08.02.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:26:18 -0700 (PDT)
Date:   Mon, 2 Aug 2021 10:26:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 0/2] locking/lockdep, drm: apply new lockdep assert in
 drm_auth.c
Message-ID: <YQesKIRQKYyTFyxJ@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 04:24:56PM +0800, Desmond Cheong Zhi Xi wrote:
> Hi,
> 
> Following a discussion on the patch ("drm: use the lookup lock in
> drm_is_current_master") [1], Peter Zijlstra proposed new lockdep_assert
> helpers to make it convenient to compose lockdep checks together.
> 
> This series includes the patch that introduces the new lockdep helpers,
> then utilizes these helpers in drm_is_current_master_locked in the
> following patch.
> 
> v1 -> v2:
> Patch 2:
> - Updated the kerneldoc on the lock design of drm_file.master to explain
> the use of lockdep_assert(). As suggested by Boqun Feng.
> 
> Link: https://lore.kernel.org/lkml/20210722092929.244629-2-desmondcheongzx@gmail.com/ [1]

Can you pls also cc: this to intel-gfx so the local CI there can pick it
up and verify? Just to check we got it all.
-Daniel


> 
> Best wishes,
> Desmond
> 
> Desmond Cheong Zhi Xi (1):
>   drm: add lockdep assert to drm_is_current_master_locked
> 
> Peter Zijlstra (1):
>   locking/lockdep: Provide lockdep_assert{,_once}() helpers
> 
>  drivers/gpu/drm/drm_auth.c |  6 +++---
>  include/drm/drm_file.h     |  4 ++++
>  include/linux/lockdep.h    | 41 +++++++++++++++++++-------------------
>  3 files changed, 28 insertions(+), 23 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
