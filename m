Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAD34202E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCSOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCSOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:52:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:52:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y200so6063995pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s9dD721Qoi9A6nP4USAe0BwTKPogrK0wNZD6hR+1vb0=;
        b=BPELqe0VGp/joC5lJ/lt1o9n1LPO7HAKCFFrcB+hLzk6KMbPfcFOn89WByJDkXtRfW
         lN7AUnqlpn8F4Y9TEIB3gJHRsX6TwOIUC3V5DB+c2gB5DRgsRB1EKVUISJoL/dVngz63
         juTgA2ObCOPQT5SoYXO5wY+P2jnL6XnUoX8zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9dD721Qoi9A6nP4USAe0BwTKPogrK0wNZD6hR+1vb0=;
        b=Fw0CLXPRmkECBg4AdA+00+QxH5qEyyYgwdVrvAjsrlaACUK8ILh9t4z1cpGlsNLUqc
         /Bf9HnHORmzLrxNmkYby4Wza3dYFsw8WVk3xyHCvmgX0dtWxVnr4aIfN1U5dEd7LnwL0
         weqXwF/LJ42KW549b7zUgwMU2PVJ/IGo9pXyE5/u5zEnh1I5EIDIsxLEmmSuaaHKBK7T
         tCv0O5+EPb/kK/F7aK/gZmHYxJtnHu7SDijlMWiomEO635GkBHeSkcLzqWXwPh5D3PiB
         NDFJG3K8ygSZem7833W91tgL8t0q94aAj4a8txzZdKTHdFnmjGMuxAhXFQgKP2eaM6NJ
         swGQ==
X-Gm-Message-State: AOAM531EWvSSd32HX45R592Sn+YMaYvSUykaF5Rp5ejmt0O0sLN2la/9
        64eVFoJIvXR05+RxygX2OnyPLg==
X-Google-Smtp-Source: ABdhPJzeWheZzfrpUMnjNyGb8v52wV5HjGnxwNDaaDbubFip9W9uCFoVRed5Roj+7FSREAsK9AwP/w==
X-Received: by 2002:a63:f014:: with SMTP id k20mr11805259pgh.323.1616165550751;
        Fri, 19 Mar 2021 07:52:30 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id d11sm5582335pjz.47.2021.03.19.07.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:52:30 -0700 (PDT)
Date:   Fri, 19 Mar 2021 23:52:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Senozhatsky email address
Message-ID: <YFS6qlpD+D/mY6oH@google.com>
References: <20210319054508.124762-1-senozhatsky@chromium.org>
 <YFSAUCZbOg7oBk/9@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFSAUCZbOg7oBk/9@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/19 11:43), Petr Mladek wrote:
> 
> The patch is comitted in printk/linux.git, branch for-5.13.

Thanks.

> Now I have to remember using the new address, for example,  when
> calling git send-email from bash history ;-)

:)
