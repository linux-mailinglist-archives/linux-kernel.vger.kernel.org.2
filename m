Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36640834A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhIMD7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbhIMD7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:59:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:57:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so11520063otq.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HyPY+ZXbFnSHwqSRftRZgDfDeMOBd9jSeFzI0yKw0YQ=;
        b=gi7trm+NMxxcJ6PFTiy/JahmZxmrqllur5rJtXLNG9b6D4cKSkaucPJadQrO91O6SO
         Qj8zUR0MkOq8BCWC7k4yHbiO24lU6723aLObxlL2CbKcAs5b/VhanYflYV8XCVTA/adm
         fBnqNhsHhmFagWqps8IAFr5VruPb6D4XKnDFuzaB+ZAzUfhxPG1dYw1OLPG9a06noVZ9
         9pCYkz/WKknUIyJHt/UQ+bnF6f4bJAkaZG3QJ7hkNbvbKy7F/lfeR+Ytjs7I2KTNisY+
         tBMh80/AFIwXqAeddibn97L6YaHekWpwTGvOr/9G1rxMyQGBjrBeHEuaxRKx6YpAOXfy
         wCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HyPY+ZXbFnSHwqSRftRZgDfDeMOBd9jSeFzI0yKw0YQ=;
        b=FzkAdQ5FuqwenQi4my/fZRQPl2ZUgwlT6daK081YB9EnT5nY8K9bpDfwJU8D+wxHXG
         ZDGC+0geT5T6EhxQGJx+HMzEsN2rX8ezkbGsAeKQ9QuSCPdGoETktYtQurcmo+3tQaq+
         eEYVSx/sicLMR4+5apk4Uw40kxizyPh727LPz/SE9q6Jayr1RhNR90XECwzq+Vhq96r3
         565lsblpkXQ6cX0MWg288Wx5ED31I1WnVauadaKscSms/DC8A4Khbb+9OQ3Y+yEa0oAf
         TKudiO7jpsSRef6bw1+koZbRnNNbN736YkXQidFJ/gAYs/CINlYWK+TpcfUozjLPF+eF
         jHlw==
X-Gm-Message-State: AOAM532/RXvS0vsT4/ZKhbWIy4w04uKns6D1WpCSPmAWR3xI4k/aasX8
        0QUsnRASU5Yrc55+uaDlUzDiRz85hB4=
X-Google-Smtp-Source: ABdhPJy4cqFVTBTmFOR1FsURtwduN2+yE06jsoG7EwYJ9Pg0w8jSnsLz9yI3nJZctZ6lxmcOKpm5lg==
X-Received: by 2002:a05:6830:70c:: with SMTP id y12mr8133885ots.19.1631505472315;
        Sun, 12 Sep 2021 20:57:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2sm1555798ooh.40.2021.09.12.20.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:57:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Sep 2021 20:57:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210913035750.GA1196001@roeck-us.net>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 04:58:27PM -0700, Linus Torvalds wrote:
[ ... ]
> 
> And in order to get those fixes going, please go out and test this.
> 

Build results:
	total: 153 pass: 143 fail: 10
Failed builds:
	alpha:allmodconfig (15)
	arm:allmodconfig (1)
	m68k:allmodconfig (47)
	mips:allmodconfig (2)
	parisc:allmodconfig (8)
	riscv32:allmodconfig (1)
	riscv:allmodconfig (1)
	s390:allmodconfig (6)
	sparc64:allmodconfig (1)
	xtensa:allmodconfig (53)
Qemu test results:
	total: 479 pass: 478 fail: 1
Failed tests:
	sparc64:sun4u:nodebug:smp:virtio-pci:net,i82559er:hd

The allmodconfig build failures are mostly if not all the result of
enabling -Werror on test builds. The individual errors are too many
to list; the number of errors is listed in () after the build above.
Anyone interested can find build logs at https://kerneltests.org/builders.
I am not entirely sure what to do about that - if history teaches a
lesson, new build failures may pile up faster than existing ones get
fixed, but then I am aware that several fixes are queued already. We'll
see how it goes. I'll monitor the situation until maybe -rc4 or -rc5 and
then decide if I disable -Werror in my test builds to catch any new "real"
problems.

The qemu runtime failure bisects to commit 694a1116b405 ("virtio: Bind
virtio device to device-tree node"), and reverting that commit fixes the
problem.  With that patch applied, the virtio block device does not
instantiate on sparc64. This results in a crash since that is where the
test is trying to boot from.

Good news is that I don't see any new runtime warnings.

Guenter
