Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8739234F030
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhC3RxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhC3RxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:53:10 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:53:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g20so16743864qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YjgPknUpx6ijub4GHdEiRvZSDU1FqZwlL7wT3fyQ/R4=;
        b=AFRnX/BToqNeJ7jBkT+A78U2/chMo1d1iQamFxcc5m+JIO9wEEJNcUr3IeT/jIo3dh
         PjZcZjwHTexZQVpdF3aR7BXE1dL4zjhH0LHrRoDx+F843c5Tk3Qq4V7Mt/qeS3ZcyKla
         nKRu+TIXlRqQBCuIknbRXQbSkWy7xoS2hdY9zIHnakVwRqecXILONz/kmXDtIBOvbI63
         VvKOs4cC80QdzFQVvWbq0AK3uXlcHe1CLObQfzhzmZTfXHExj+6SpQg8Ph5Kcz77N3ql
         kvH/Xw6viGxZkYoTvz08zyQAmKrjU4yiQjKa+Qd60aJtVBKKyFTklk77sOn9sOsuNm7m
         ESvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YjgPknUpx6ijub4GHdEiRvZSDU1FqZwlL7wT3fyQ/R4=;
        b=DRSArWyDsx3VXVK+8V+JWeXDzgXB1cBnsc6S9mzhJm5pydA1q+9CPSRGsawz0bDQIg
         v0bWqjsgTB9sT+AzMD5NIwiv2oHT903Swqz+qNbGyiCjFS5i9rRVcbXMmS8bFc8BPd3A
         S0zpHXnffUfpM7G/QYPVfjoV/lq3yWHjodDQpZhlfy6oIZVTOuqcdVeNQ3Hqd1gQ1Eee
         QGT6ly8P8iQSbU3Trsp/rx2YscpUBzeQEAqD9Ea/qUAIPMlEjLk6GZ+MwMoCUX3y4Zh5
         4QzwTv3oSE+UmBidxO6yhpAEEOXhFw00KGECHgcseiJh+arXlrlc52fKlp/P+Dsn8hH2
         ivpg==
X-Gm-Message-State: AOAM533HTypS20sDXw5PfDBgfEmcR9K/Jk7G7sOBy9OjTzeWZQfdDcaq
        Lyccd80zXq28++21yXY8xrXqaRVNgTR/fQ==
X-Google-Smtp-Source: ABdhPJzj3VquU21kzlmzd09Nbi6WRrQGCC5XiCzMB4og3ZZWjonIg6M2my7/64gwKI6mWne6x11QHQ==
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr32849486qke.383.1617126787406;
        Tue, 30 Mar 2021 10:53:07 -0700 (PDT)
Received: from calvin.localdomain ([2804:14d:5c5a:802e:bdc9:ded9:cc08:a4e9])
        by smtp.gmail.com with ESMTPSA id d68sm16446012qkf.93.2021.03.30.10.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:53:06 -0700 (PDT)
Date:   Tue, 30 Mar 2021 14:53:02 -0300
From:   Jonas Malaco <jonas@protocubo.io>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nzxt-kraken2) mark and order concurrent accesses
Message-ID: <20210330175302.ihsmijnidxjhmcqa@calvin.localdomain>
References: <20210329082211.86716-1-jonas@protocubo.io>
 <20210329215339.GH220164@roeck-us.net>
 <20210330002131.s2qz3dr6bwr6jz25@calvin.localdomain>
 <56ebbf0f-cdcb-d5af-e1ad-c7604597566e@roeck-us.net>
 <20210330031652.zhhxft4trli6zqtw@calvin.localdomain>
 <37e5b3d3-8868-c70e-4c01-2d3d777df4de@roeck-us.net>
 <20210330062749.tcscp2kzxqugbtiv@calvin.localdomain>
 <38c76eb1-808a-1c9a-2494-208270a66e14@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38c76eb1-808a-1c9a-2494-208270a66e14@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:51:21AM -0700, Guenter Roeck wrote:
> [ ... ]
> 
> Then please explain why _this_ use of time_after() is wrong but all
> others in the kernel are not. Also, please note that we are not
> concerned with code generation by the compiler as long as the
> generated code is correct (and I don't see any indication that
> it isn't).

The accesses to priv->temp_input[], ->fan_input[] and ->updated (where
this relates to your question about time_after()) are not wrong, but
undefined.

But if we are not concerned with code that is currently generated
correctly, which indeed is the case in the five arch x compiler
combinations I tested, then there simply is no point to this patch.

Thanks for going through this with me,
Jonas

P.S. Admittedly from a sample way too small, but in the kernel
time_after(jiffies, x) calls do not generally appear to involve an
expression x with a data race.  And there are a few calls where
READ_ONCE() is indeed used in x.
