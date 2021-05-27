Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7726F392512
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhE0CvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhE0CvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:51:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0927DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:49:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s22so5603833ejv.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/4i184jXy1OBDzC5M5sM7ZE0FH48QiQ0WkdXQcHjrb0=;
        b=FQzoA8zgGl0OEzPjrbtkMdwvPp0rz7maqXQVyr2mPLwmqfAJW0gOSf8mazCmzA8cL9
         S9bphEgXoymAfaVsLRQxcTVMmwNPiKdoXkCTzLAQe2KgjkSi3gutCzbSUAgb5NS8bscp
         kTZbZXgnkZSpOg4ckjmAO/FPDKNGgw2d/sGHa5TYgENfGCkZTwxWy9H5+q8hef1np8zk
         eaHe9egTU4z24ZHYZSbIISC24eDb4vZo60rAnNHPX/EW5ipdua6s0I2DprWdd0eu603+
         HQXDEi7KHZ6w83BOs14ukAi9GC24gz5QMND3VD7pE4sLxJn2BQ3yu0NIwUBGL/RaufoV
         aaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/4i184jXy1OBDzC5M5sM7ZE0FH48QiQ0WkdXQcHjrb0=;
        b=VO1dnx8g0pQl3EHqs4oIohfK1rtQzuClU0NsjcqG2KK7huVSnXaKjVZpZS2HaLBySR
         92dMy3bmmwXbryQKJck0TXsDblwzPhgVOVbYb3AxaOEBYgui9UdiXYOHmqDWpPn5z7Zv
         hbmbiivZtCv1ZJUTfFVGrqOjuZ84egJQOz1CHdmbvy/nL+H2zTxh7stVKhF/w/IPIp+z
         OrgX8BeDWPkeDKKq2E9k3gtSSTtz6ELR+4BPL/bkvEKwsNgM6h/Lo0JamJ8CjR/fhi3g
         KEAevfh84ePQLuJY0XGT/3xkkjNCWalqUStJW5uXgrFNyeWdlhfzYk8wo9aPUkRdevmR
         8OSA==
X-Gm-Message-State: AOAM531AutKda3ZE3+ZNRVxNCPvyi/hDABIFu9/VIfMVfLuRa3Lzz9JS
        WsItrwknkihbNGrrouBm6uboSt+gUn4/dxoGGhzNHDTHFL9tjdkk
X-Google-Smtp-Source: ABdhPJwWURSrplknm9YzGZEqSH55B956Pj4Al2Mg34/ZUgSNuw7zaXhwiT8LlOZa035yLf64KZ+Geo1ioOlYIhW2K9g=
X-Received: by 2002:a17:906:73d7:: with SMTP id n23mr1440220ejl.135.1622083788593;
 Wed, 26 May 2021 19:49:48 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 27 May 2021 10:49:22 +0800
Message-ID: <CAD-N9QWYOE5vW=Q4wP74vV-TkrZUDFZxLn5OACX4jUC2ysEACQ@mail.gmail.com>
Subject: Suggestion on how to fix "memory leak in snd_ctl_led_register"
To:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel developers,

The root cause of "memory leak in snd_ctl_led_register" [1] is
unbalanced refcount operations in the device_add function [2]. This
refcount issue causes struct device_private allocated in
device_private_init unable to be deallocated, leading to memory leak.
The details are as follows:

First, the get_device and put_device are balanced to keep the refcount
unchanged. And there seem no other refcount operations in the
following code. However, in my debugging, the klist_add_tail would
increase the refcount of dev with the get_device in the
klist_chldren_get. This is kind of surprising. Let's go deeper.

int device_add(struct device *dev)
{
......
dev = get_device(dev);
if (!dev)
goto done;

if (!dev->p) {
error = device_private_init(dev);
if (error)
goto done;
}
......
if (parent)
klist_add_tail(&dev->p->knode_parent,
       &parent->p->klist_children);
......
done:
put_device(dev);
return error;
......
}

In the klist_add_tail [3], n is &dev->p->knode_parent, k is
&parent->p->klist_children. Then it goes to klist_node_init. Here, in
my debugging, k->get is klist_children_get. In this function, it calls
get_device to increase the refcount.

void klist_add_tail(struct klist_node *n, struct klist *k)
{
klist_node_init(k, n);
add_tail(k, n);
}

static void klist_node_init(struct klist *k, struct klist_node *n)
{
INIT_LIST_HEAD(&n->n_node);
kref_init(&n->n_ref);
knode_set_klist(n, k);
if (k->get)
k->get(n);
}

static void klist_children_get(struct klist_node *n)
{
struct device_private *p = to_device_private_parent(n);
struct device *dev = p->device;

get_device(dev);
}

It seems that klist_children_get is initialized in device_private_init function.

Finally, I tried some patches, but they are not working. Now I have no
idea how to fix this bug. I will really appreciate if anyone can give
some suggestion on how to fix this bug.

BTW, if there are any issues in the root cause analysis, please let me know.

[1] https://syzkaller.appspot.com/bug?id=6d9e1e89003c894e7a1855c92dfa558ebcb8f218
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c?id=e48661230cc35b3d0f4367eddfc19f86463ab917#n3198
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/klist.c?id=e48661230cc35b3d0f4367eddfc19f86463ab917#n134
--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
