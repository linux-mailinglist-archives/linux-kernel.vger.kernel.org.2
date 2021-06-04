Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2739BB48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFDO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:58:16 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:39749 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:58:15 -0400
Received: by mail-qk1-f176.google.com with SMTP id j184so9584101qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZdoOu2cM63XQhit/3MNjVZ2hoUNthUBSt/vXkoxJ8s=;
        b=IoT1AxgXQBxpW64NSmD6GgVVFaMy05Bd/vysDCgTJGwdCQZpioErrpUgK/HtQlLVYS
         EgjdNpTlcVcfctZjmdrBJnxW3FfdtC6jjawjd+K6trFY3e9deO3rCjw6HQao21Ar7Q4R
         MI8EU5QCgwvOsJayzY6Vul075zuhE4tzaj+cnw6iIufnq0uNqgSjYa+n1OLVtH3qHDvt
         qus36n9FuToDjL1SYk5LsZ3m5cI+T4Rjx7QhfPRgzHX1QZiNAsKYhITMVfUK3bJHhuc5
         6u7DMz8CAHX2hBIMkgRY/RP+q+fnkOz4H2bJa2QpBBAtRdFE6DtURXbAt6jc5Vtspv8N
         scRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tZdoOu2cM63XQhit/3MNjVZ2hoUNthUBSt/vXkoxJ8s=;
        b=s2cvOurC6LcqFhqMYS2/YF3LkICac2fCJjAmdRkC5iRmb6rUuLH0shd5qdtyTo5B0m
         YcnxEATClQCgfcEOgMAqJQEdKJ/hAqfzr4kyEyRiwl2ZsT3IS+SoRJXsks6EzXCuVgDd
         axi3YjEa1WROscS0tU9gesftGSKcJBI46peLIdw0NjZFXY1BnNi51bx7IFllAFhqnRnl
         m1AQw3esNLGtMZ/PjUdbEHUUWOwaK9IIGu6HgC6EQgeQygM7oQWZip++TECt++g0D1df
         L+1eyI4OwnWo9zaqqTX/bjyYZyshZHOcgXc4m5vyZrVHZWpSdYXSeDZkQcQf5TlVTZ8v
         Aaxg==
X-Gm-Message-State: AOAM530+uyaOQblsFeTAoKYSWj8yy3TSCJV9YI+RNsojns/meNC/wduj
        JWyGlhrQdMZMCNZW8FTloLM=
X-Google-Smtp-Source: ABdhPJxcNJYxqQ3fSBUk4GpGQ3C1zc65P2mcKdho1AgA8Y8owTf9UYnU3ASYPi3FFBkUNRyqT1bx+w==
X-Received: by 2002:a37:a115:: with SMTP id k21mr1188449qke.255.1622818517612;
        Fri, 04 Jun 2021 07:55:17 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id q23sm3728086qtn.49.2021.06.04.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:55:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 10:55:16 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Add back __printf format validation
Message-ID: <YLo+1JZdknqHAPf7@slm.duckdns.org>
References: <8e60e269d4fe74af767baee1b3048dda6ac17e05.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e60e269d4fe74af767baee1b3048dda6ac17e05.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 08:11:48PM -0700, Joe Perches wrote:
> commit 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for
> workqueues") indirectly removed the printf validation for alloc_workqueue.
> 
> Add it back.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to wq/for-5.14.

Thanks.

-- 
tejun
