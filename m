Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96A3623CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbhDPPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbhDPPVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:21:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F4C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:20:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id h13so10526449qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vJQzDyPMzRCR3Pj66zSN4Mp2TuH3DXRBeVPYYvWoKrU=;
        b=uEKYeSNXrs0vvy9Juj5zS5C4UGxfquZmEwu9JoW5KpfTcfCHeCtkFbqIiVnFqv4n1m
         6GPV/7cnX9H9daoTZHsDYLZC/9P89NumjGeKNXhrqm+i4ErxteTIZxdXgqIhxYPJw0QX
         BJOhfLNXfzZjE0lN2V9R6M6uOnyWXieqY2wCh1LNziVouc59fcrDODJbLIiQ62La2+YC
         FkGGQPSMMjnHIFktdRH+Nhdk16hG28vH1LHYKEcbEtDr0EY/2maOggPIWETx8NKfcrHs
         iq5bsLelijNu3aUF0D3WYUglqbZRXgkJTszbpCW0QgGfoeipKRTaZ0drVNOatoDOob8a
         Gojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJQzDyPMzRCR3Pj66zSN4Mp2TuH3DXRBeVPYYvWoKrU=;
        b=tgwgjB8PXth0L40aklHjipF0g3SIpA/yJA/rlM4DycROsCGiHdAKRwRaP3wuDfWW4h
         UQ+vmRo3UvDBYZpo1XsHmlmmORBEkWdfkwrct4TAr+3iOvUK8Op6Bh9CoxX+mwTlAM6E
         zO7sepEEo9oowinY6kMxz1oodCOw0GR5Bj0zqRNmJ0Rk3ayBwUSzlS8yDtr5bO6W8Txd
         +3Pki5Pb2jNBw7C+JlEtjG6l+6fMTo7Cc4YkvfWdiNlandr+ldWfgCIjvM7KelcRaOSk
         DkD5Sn1EuowvJlIorYchkJX/alnibOhYIwGkthn2+kpWepFvTv9KmMhUMiTPaUP8avff
         oOLw==
X-Gm-Message-State: AOAM532UZmWC2Y7K+f0mUMD0iigRv+OClFcC88YojQ6/5lVUcSCMBjkq
        r34CT+K2leyUibd75sIVDhL3Hg==
X-Google-Smtp-Source: ABdhPJzS50rG84nFsNhmYFRBrJz0q3QKdkqei7X0wdsmuaffsPY8xFLGy5knA6Iix4oozzqyZBJnvw==
X-Received: by 2002:a05:620a:22a5:: with SMTP id p5mr9275130qkh.480.1618586451806;
        Fri, 16 Apr 2021 08:20:51 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id w4sm4393844qkd.94.2021.04.16.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:20:50 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:20:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 5/8] mm: memcontrol: rename lruvec_holds_page_lru_lock
 to page_matches_lruvec
Message-ID: <YHmrUaho1SLSCfk7@cmpxchg.org>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
 <20210416051407.54878-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416051407.54878-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:14:04PM +0800, Muchun Song wrote:
> lruvec_holds_page_lru_lock() doesn't check anything about locking and is
> used to check whether the page belongs to the lruvec. So rename it to
> page_matches_lruvec().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

The rename makes sense, since the previous name was defined by a
specific use case rather than what it does. That said, it did imply a
lock context that makes the test result stable. Without that the
function could use a short comment, IMO. How about:

/* Test requires a stable page->memcg binding, see page_memcg() */

With that,
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
