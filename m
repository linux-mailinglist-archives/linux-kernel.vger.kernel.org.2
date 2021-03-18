Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12617340879
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhCRPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhCRPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:09:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE310C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:09:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l13so4278613qtu.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LmVYj5GvufpNSkWZh3TqEcOCWKFGXIRDgIsopg1YFuM=;
        b=ulrGxS7Qh+EZB3EC7EZ6XWGF9uV+2Im5DF6vdI74sxHXQ7+LAUp3Z9fzI4t4hOPLu1
         EKGkNt3scr4mGD6IiYO0ph/t84ASN6ObxjhKuvALGQkzndEDQVOVRA6n2Ij/UouVx/ri
         +D3vKXEuJb3QI+JbdIyikPHdHf2n/wqkyUD4PCx22vU58kiF+7Fl1a3zeyRthnDl9c/K
         NBQoQA5u9CJY8QHRTEjrP2xq2Jon32B8hVAHry6S36tx+L9G0lk0YgAXIlXBbzFjY93t
         flcnNyVaUsbDhufdpGvMgm7b+V6/Ccdx3/YFMT+iK0cB2i0ToQUBk0D4LN7/hgeeMSOb
         yzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmVYj5GvufpNSkWZh3TqEcOCWKFGXIRDgIsopg1YFuM=;
        b=IaYpn17KDoZkEMsuX4l5fEJPDSmnXuUTtIh3PnjDsveOeOQ807z7AUrtUV5eD5sLeq
         xtS8FgK65Vcl+Se4auHKWBDKmLtTJFwE7nYGklgQqxiCyqIYVuXT0YAO20VcwDF3jIqS
         tzauimtPXMG/88GwPAxpj8dsJ0eHlUx6PlJBYfkXGzI1wJUcF4PKKwg8Dn5qjlPunwfa
         SOg25qlXYzz4QUvBxNS9MfV1eVZ2Mg9IuQIPEwhwdoLTHwR8PqbZMbWtTrW3+Ad7CMDw
         cWDLvx6SWEtTuT++XV0a+v1J9yCxFkYA3rhuZSQqXdLZ2rBOXyfO4PMN9rEWWfP0rR/P
         JUZw==
X-Gm-Message-State: AOAM530l3ij7Pmxse5kA1HpxH3YVIfbMNGu+9T1/QDK4W8tJOY1eQNGk
        8y5glQ4p9joWaKuA3TDNM45MU3HfXWv/dQ==
X-Google-Smtp-Source: ABdhPJxV+Rn2hqhytpbtN66foGM/tpwhN1aAFHOf77XeB9sQODc/ocrUa0o1hJszW1opYtM88D762w==
X-Received: by 2002:ac8:520d:: with SMTP id r13mr4238983qtn.38.1616080168937;
        Thu, 18 Mar 2021 08:09:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e46c])
        by smtp.gmail.com with ESMTPSA id d14sm1561517qtj.92.2021.03.18.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:09:28 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:09:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v4 2/5] mm: memcontrol: directly access page->memcg_data
 in mm/page_alloc.c
Message-ID: <YFNtJzm2DNEVkTbO@cmpxchg.org>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
 <20210318110658.60892-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318110658.60892-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:06:55PM +0800, Muchun Song wrote:
> The page_memcg() is not suitable for use by page_expected_state() and
> page_bad_reason(). Because it can BUG_ON() for the slab pages when
> CONFIG_DEBUG_VM is enabled. As neither lru, nor kmem, nor slab page
> should have anything left in there by the time the page is freed, what
> we care about is whether the value of page->memcg_data is 0. So just
> directly access page->memcg_data here.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
