Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB27639888A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFBLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhFBLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:46:43 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 04:45:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 65so520673qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c7B5VYXb1hXtkVcmsAu7YE6fWHrPkvp7djNJpQjD+rs=;
        b=BmaSnXy652DnCLCEJF2G/suHHDbSWIFut2HaKZ1zEHXvfKqDuhcu9Jh4Uns2kYVXaT
         Y8RQDVfQ7Z0tH9hDxpziy7OaTdQivkbuhxXFsrcWPV5yeUX9Dp3lsHpGy0EAV/pewSgN
         jjvzx8ZVlVxwj2qknWzzSYbPVoCNPzrqngSx+jfT0XIa2iRhoFta1p/xfK4c6+OKhmqr
         InhlBsRkJfN9mqFkRr5ovnDbVk2PIz2m7YE5uQzLbTg5PzH23P34iKvQDRg+UEqFqNET
         Wu0lLP6BNRLbX7k3tBderTuuRbjZEXHYgBwCJ6/egPM9TQa8rsDd2SFoAvvxElGKf39v
         UbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c7B5VYXb1hXtkVcmsAu7YE6fWHrPkvp7djNJpQjD+rs=;
        b=PCcT5Ci62Xr3+sra9txJm2SFm0hSPnnNrrmRZKSyitu+Q/3p8aeukhydjAFj/tXQZH
         qndEIHc/z662a2esETSCccw3yYjhxXELdWVCrcAa6ohbDbpiD9ejUYOfDX+L+iFnD3hJ
         6zjlPyMwnnGOj09Zxx8iCKi/DaGrjWjrCm8kxZqTEgef5Ftk9qwHUYfM8bJn8VgPtG9L
         7Zz2gkNzmZ0DTrXIxpMHiZVODzNqeL7BeeK77qRBjwniiZECl35RQ+E4hPTUD6ae/1NZ
         l6kkzaUI5yUQfQx5SfksbU9ZtjTixcKbdSmfQP1ypfl+ZDdGMOePz88N3T5hvukAORq0
         aesQ==
X-Gm-Message-State: AOAM533cWw6TUAMPgkR+HtpHNiwlku9BykPZOWIM531cbZMSfmIhpg4R
        yjyuFeG3xqHyYkZ0rzi5Iv9l69j5v/U=
X-Google-Smtp-Source: ABdhPJzPWKYZSEVv1uxrhRoBGEXuC+r96UHXUE5SDSp4iC5LR31tYYuU+Ckg7gTga8yxoE85Tn4kSg==
X-Received: by 2002:a37:86c3:: with SMTP id i186mr19154779qkd.151.1622634299539;
        Wed, 02 Jun 2021 04:44:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6sm13207713qkh.117.2021.06.02.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:44:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 04:44:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc4
Message-ID: <20210602114457.GA2899409@roeck-us.net>
References: <CAHk-=wjKJ5Mw7P=U0AyhFJbGB+4TT=SE=tmf=md0cqEn527HFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKJ5Mw7P=U0AyhFJbGB+4TT=SE=tmf=md0cqEn527HFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 12:19:14PM -1000, Linus Torvalds wrote:
> So after two small rc releases, the other show finally dropped, and
> rc4 is fairly sizable.
> 
> It's not the biggest rc4 we've ever had, but it's certainly up there,
> believably competing for the title.
> 
> That said, exactly because of the calm rc2 and rc3, the size of rc4
> doesn't worry me, and I think the 5.13 release looks fairly normal.
> This bump is just because we had some stable work finally hit my tree.
> Notably the networking tree, but there's a lot of driver tree fixes
> too.
> 
> The fixes are fairly spread out, and mostly small. Some of the bigger
> chunks are for new self tests (both bpf and kvm), and outside of those
> new tests the diffstat looks nice and flat (ie lots of smaller changes
> rather than big peaks). Networking (both core and drivers) does stand
> out, but there are filesystem fixes too (xfs, nfs, cifs), various
> random driver subsystems (sound, i2c, tty, usb, iio, scsi, spi..). And
> some arch updates (mostly kvm-related, but small arm64, s390, MIPS
> fixes - and some powerpc perf event descriptions too).
> 
> Please do go test, and let's make sure 5.13 is solid.
> 
Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
