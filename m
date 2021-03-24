Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482C1347BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhCXPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhCXPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:12:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB8C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:12:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h20so8097893plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L8CGCu683ap3F7hcKSeSmXZu53NqyU2bsVETlec1vPY=;
        b=Bgi5a04hjuwBhd4sezqjdOw3l2MpVDQReCtu5al6yx/kbKVgtebwvuacrAtD4t8S5O
         Vg0DTfLNHUaHbursO58xzcS5gU2KXddaOVEBBO81pXIqShe7JseJX13Tkv2PQLnPtsQN
         h13OHoYpINkNIt8LnZNh7GIrWvt+L5u6zLW2wawponkCOATN78ABAQxoiXGj8WCt6HPf
         YHovZbRswV7FOlM2he0HfycUXMHfntbT1DBWlIStq9oYVJZDNbQLcPmTRaT+LUfTzUL3
         fgyOIwfgfq+383iAD/kt5rM2tCGab4b7oAtX9Hjt9SWHKCIH/zeAPn8lO2UQxq0M8kvt
         dzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=L8CGCu683ap3F7hcKSeSmXZu53NqyU2bsVETlec1vPY=;
        b=R+D+asGuC2T8kDZ9QXBpFDDw6DrGoxHg+/QHDfVQ+WbWMP/zt+UinMCXoqau5ZlRC/
         phOuvoHnwMIk9sJZQbyoase9kRGT9syA/0nr1ftphw0de+tIFeBLXPnp9G0BNPL9+gZt
         kkzUEPk6OkiE6JZQdp37NHKgyx603zMROFsH79I0iKdsKgmdwpuCIq7U+JhQUGW8WKAP
         VMIzD9EbcEOOoPtvy3JLsrHdKNMiDG+tGXzx9LwZH+6CxB3b4Wu0Xnu3YgrJbwwrQl7A
         h0mIUagXq1hMl6E4h1Hew9rIVNDb/5fah8o2S1U1VXuAZ99taF7xJukVmAcyYxvncAnq
         0ojQ==
X-Gm-Message-State: AOAM530thf2iOjf1TgoUZTZUQAdzwge9XqELwkbHnDis+6UG6qPnSvXR
        tiP1hsBDus8JAU+U7r0UD5k=
X-Google-Smtp-Source: ABdhPJx312Y2XyaQfPeo2zH0Y0TfpcUXUXSQiWQo93nuhBKMIpgS0MlEIA0GtuVDqQ/hZcQpKUdVrg==
X-Received: by 2002:a17:903:4112:b029:e5:f79d:3eb1 with SMTP id r18-20020a1709034112b02900e5f79d3eb1mr4170507pld.48.1616598752488;
        Wed, 24 Mar 2021 08:12:32 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id y20sm2985105pfo.210.2021.03.24.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:12:31 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 08:12:29 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v6] mm: cma: support sysfs
Message-ID: <YFtW3XxE9mjl0n1+@google.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <3d90177b-e143-03b9-0f78-77740690266f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d90177b-e143-03b9-0f78-77740690266f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:33:07PM +0300, Dmitry Osipenko wrote:
> 24.03.2021 04:05, Minchan Kim пишет:
> > +static struct kobject *cma_kobj_root;
> 
> This should be a local variable.

Sure.

> 
> > +static struct kobj_type cma_ktype = {
> > +	.release = cma_kobj_release,
> > +	.sysfs_ops = &kobj_sysfs_ops,
> > +	.default_groups = cma_groups
> 
> I'd add a comma to the end, for consistency.

Yub.
