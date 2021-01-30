Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388F3092ED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhA3EVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 23:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhA3Dsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:48:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3477C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 17:59:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id by1so15681889ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 17:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWo4KjlIrzjbnoyurSSBVNGq8JCtPRxkHzDKnUW80j0=;
        b=P858ojYjTMLet0tza2ROjVLugxIkJKWKScHcI99wlUNAmdxT/q0A+8k3B4mv69C6zW
         pZ3i9rKjIGm6RktXcFu6kGETkt4+Jprl742+JAq4QxjvLpmTtFhN3miGluA4/V/VKeJv
         9nZml1zipllmwJKOv8oSAuBaFNUHz9Rl4zI9JcuPjIHxoW3Bl2UIz3T7v/Mhw5V6YC6F
         XVFOnWy13TgIeKZ9JZEcevyMlunFbyxb2gWPKmVAZuGq6Nh186yBr2KUEe4zNweU597Q
         J2WEvdpkdziTYPjCr6ZlwS9Ei/JRG+DNDI+wOaCr7qodi4DudmJQBCv2t/yAQ5R6U3fT
         df+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWo4KjlIrzjbnoyurSSBVNGq8JCtPRxkHzDKnUW80j0=;
        b=bd5X+C7jUOV74a+fExcmzlsEd8C3liZQZWkap8Yx3thk5SolLDwOezoDLteQQSgLAP
         u1xK37eKanpUyMmaFHAtD5tzzjO4B9bWdMc7nQOHvxB7NL1OxwhJ2ab5rV1PijnD1vmV
         LDdHEgnCvyg8GkvL/e7/ephb+90A+Rb7adHbgkcouERJvtH8M8UxBUrgshlzIfoP/QJW
         fRCX4XXfXx58BcmUf0wx7KpjBC0pFaIsdeX6U7RV56yg0PSbgOLSTpVsXiyrdEFiqZzj
         G5bzlgfoPOGwlYB+/ldPwcfjuNH4s2PqSbB8jMA7z2o9b0vu6AQETsNX8u1LhCFYHiOb
         gNvA==
X-Gm-Message-State: AOAM531ovdq8tqgBg02K1SfqOqJgH6cP2d6xyGM4CRaFuDUN1HJYx/Oj
        unQElZtPWAoMyVHdYIsX2rhB9RqveTBaE2mRwkrXUA==
X-Google-Smtp-Source: ABdhPJyteHUAK6EjHEtc9xneY7O6pvnG4P0dUDapv2YrqKHQ9TTcKg3Asw/O8AVJSbRScvPOSKnGqXrPFZiktJtSdM8=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr7315521ejb.323.1611971966715;
 Fri, 29 Jan 2021 17:59:26 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Jan 2021 17:59:24 -0800
Message-ID: <CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com>
Subject: Re: [PATCH 0/3] cdev: Generic shutdown handling
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:38 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> After reviewing driver submissions with new cdev + ioctl usages one
> common stumbling block is coordinating the shutdown of the ioctl path,
> or other file operations, at driver ->remove() time. While cdev_del()
> guarantees that no new file descriptors will be established, operations
> on existing file descriptors can proceed indefinitely.
>
> Given the observation that the kernel spends the resources for a percpu_ref
> per request_queue shared with all block_devices on a gendisk, do the
> same for all the cdev instances that share the same
> cdev_add()-to-cdev_del() lifetime.
>
> With this in place cdev_del() not only guarantees 'no new opens', but it
> also guarantees 'no new operations invocations' and 'all threads running
> in an operation handler have exited that handler'.

Prompted by the reaction I realized that this is pushing an incomplete
story about why this is needed, and the "queued" concept is way off
base. The problem this is trying to solve is situations like this:

long xyz_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
        xyz_ioctl_dev = file->private_data;
        xyz_driver_context = xyz_ioctl_dev->context;
        ...
}

int xyz_probe(struct device *dev)
{
        xyz_driver_context = devm_kzalloc(...);
        ...
        xyz_ioctl_dev = kmalloc(...);
        device_initialize(&xyz_ioctl_dev->dev);
        xyz_ioctl_dev->context = xyz_driver_context;
      ...
        cdev_device_add(&xyz_ioctl_dev->cdev, xyz_ioctl_dev->dev);
}

...where a parent driver allocates context tied to the lifetime of the
parent device driver-bind-lifetime, and that context ends up getting
used in the ioctl path. I interpret Greg's assertion "if you do this
right you don't have this problem" as "don't reference anything with a
lifetime shorter than the xyz_ioctl_dev lifetime in your ioctl
handler". That is true, but it can be awkward to constraint
xyz_driver_context to a sub-device, and it constrains some of the
convenience of devm. So the goal is to have a cdev api that accounts
for all the common lifetimes when devm is in use. So I'm now thinking
of an api like:

    devm_cdev_device_add(struct device *host, struct cdev *cdev,
struct device *dev)

...where @host bounds the lifetime of data used by the cdev
file_operations, and @dev is the typical containing structure for
@cdev. Internally I would refactor the debugfs mechanism for flushing
in-flight file_operations so that is shared by the cdev
implementation. Either adopt the debugfs method for file_operations
syncing, or switch debugfs to percpu_ref (leaning towards the former).

Does this clarify the raised concerns?
