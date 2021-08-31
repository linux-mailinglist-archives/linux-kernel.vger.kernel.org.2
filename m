Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79F53FCBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhHaQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:59:17 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37727 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbhHaQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:59:13 -0400
Received: by mail-pg1-f180.google.com with SMTP id 17so17387884pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RADL0VZuutsxcjrH1H1OF6veIv0hkmcVRwm1RbHKyCk=;
        b=KKqx2iLg4trmWziUxeVarBuNnPs9hYcLrSLR8qidD8eFRRWJlZ4c3Uj0YX+/ylEpEG
         0KmgnxlQpjLgjz6jS6/8h+3Z54GYDIEJ6CeTPi+8U1c20CDRSSa+BZG2MVUTQ6Azmlf/
         kabel35rx//MiNklCli+6mzqdtphv7cBNcxKpmjJKhmdu0cNrge/Sdnf9AyJiqOdXuF5
         R4rxkYOie9v2mwus9AqCBXtUH/QQSFChuny09jJO2kMZuWw4P1bkorfNgpWGeM/kcLgj
         9LJ3erDt5K6b9TcpAk4EFRtCFfy5RmneIVezh5k8siXtIIOa1SW/ogf0yJHgNDgf4lBv
         gm+A==
X-Gm-Message-State: AOAM5326UWJB85QT8qH/lzhWWXFgcryLFBY3DYTwpNBuN7lVX3oQwcEY
        g+kG0LAowCDviDOMvmLZXZKbcrY6G9nyWQ==
X-Google-Smtp-Source: ABdhPJw07czNLMoYptSEg6sH6hXZ+gG/xSCCE36wwLWMV2FLlnCYne2ys1ncRp4xynOz516uKhzUzg==
X-Received: by 2002:a65:5b86:: with SMTP id i6mr19353438pgr.62.1630429097467;
        Tue, 31 Aug 2021 09:58:17 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-131-119.cust.tzulo.com. [198.54.131.119])
        by smtp.gmail.com with ESMTPSA id 20sm18487987pfi.170.2021.08.31.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:58:17 -0700 (PDT)
Date:   Tue, 31 Aug 2021 09:58:15 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, mhocko@suse.com, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: Stuck looping on list_empty(list) in free_pcppages_bulk()
Message-ID: <YS5fp8ZKvw1Xnkgf@sultan-box.localdomain>
References: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
 <11357114-eb6e-39a6-b16d-5e380f770943@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11357114-eb6e-39a6-b16d-5e380f770943@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 06:51:23PM +0200, Vlastimil Babka wrote:
> Does the kernel have commit 88e8ac11d2ea3 backported? If not, and there were
> memory hotplug operations happening, the infinite loop could happen. If that
> commit was not backported, and instead 5c3ad2eb7104 was backported, possibly
> there are more scenarios outside hotplug that can cause trouble.

Yes, it appears that 5.8.18 contains the 88e8ac11d2ea3 backport (commit ID
5b21a116b1365 in linux-5.8.y).

Thanks,
Sultan
