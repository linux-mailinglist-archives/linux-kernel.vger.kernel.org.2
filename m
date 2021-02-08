Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E555F313236
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhBHMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhBHMF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612785868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Qs++Eyz+FNoD/j1mZztLeb+tABoZMU/k2xT8BiHAls=;
        b=HhY0QJ7N9zEd4zLSxN9Q6q6GVUPPKsd17rC+WM3HvemTvnb0NddCshroZlyg4Yodoe/8lg
        0uJTVU6ee7379QqEsiiA2lvrBx7kfe7KKs6yNVPWRAIBpMu9tqrw2QFJNtrKPLDylX8wr7
        mb7SkDz8Ll2ZQeeoqwNLmEhNC4MyIsg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-cjkgz-2yM5q0xh_QNXTvmQ-1; Mon, 08 Feb 2021 07:04:26 -0500
X-MC-Unique: cjkgz-2yM5q0xh_QNXTvmQ-1
Received: by mail-ej1-f69.google.com with SMTP id gv53so4075867ejc.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3Qs++Eyz+FNoD/j1mZztLeb+tABoZMU/k2xT8BiHAls=;
        b=qSVQCBa8eogLj3ZwQX73ODYfQcWIaplulA6rtj/iaRJTFlnjPT6obL6FLpNti57VGZ
         ikjgzovclANJK4u3hOXZpsnsH5VUCtw+B/v0dd7GDB8hixLbp5G3PtRW7kwwd4qlkr/Q
         MjDu21e2CNp6cD0EXsMYb0G1iEMjDHNxeILYashDeqM99ZRGr9l9aaWmadnjMs2bL1wb
         u/9TrZr52cMMXzZ9QtdZH9ZGth2tamZu3QleqTtWS9zm5g3dfl9F0L3y7KGdIc0LMNBV
         EvsTJ/wW99Q0zWWrctCseR4GcagyQYj+jXsi9wFDAkHIyAo9PNcF6Dr8De+nTz0qXEsY
         Ea/w==
X-Gm-Message-State: AOAM530Va4Pxjl2A+axBgdVj4PWB+ksAilnRQKwTyJ/5HxbRetN8nJQg
        gOUCH8mIKi3wVUUKroDX6NFewDEEDkmAVRkvwIoHX+0qitN8B53PLhiFTYLqQ4njz8rnyvWe8XA
        YyDL/Shiw0VFtJ3e3Iu2XoTks
X-Received: by 2002:a05:6402:2053:: with SMTP id bc19mr16399264edb.230.1612785864895;
        Mon, 08 Feb 2021 04:04:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYh81U7rVWWzDv0BWgV8P8Ma0koPf4ZMd7UjCWGCkcVoSWZ76oz/S0Urwra0A/6eX0YuanFA==
X-Received: by 2002:a05:6402:2053:: with SMTP id bc19mr16399251edb.230.1612785864712;
        Mon, 08 Feb 2021 04:04:24 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id b2sm9191594edk.11.2021.02.08.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 04:04:24 -0800 (PST)
Date:   Mon, 8 Feb 2021 07:04:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210208070253-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210205103214-mutt-send-email-mst@kernel.org>
 <24cb3ebe-1248-3e31-0716-cf498cf1d728@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24cb3ebe-1248-3e31-0716-cf498cf1d728@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 01:42:27PM +0800, Jason Wang wrote:
> 
> On 2021/2/5 下午11:34, Michael S. Tsirkin wrote:
> > On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > I don't exactly get why we need to split the modern driver out,
> > and it can confuse people who are used to be seeing virtio-pci.
> 
> 
> The virtio-pci module still there. No user visible changes. Just some codes
> that could be shared with other driver were split out.
> 

What I am saying is this: we can have virtio-vdpa depend on
virtio-pci without splitting the common code out to an
extra module.

> > 
> > The vdpa thing so far looks like a development tool, why do
> > we care that it depends on a bit of extra code?
> 
> 
> If I'm not misunderstanding, trying to share codes is proposed by you here:
> 
> https://lkml.org/lkml/2020/6/10/232
> 
> We also had the plan to convert IFCVF to use this library.
> 
> Thanks

If that happens then an extra module might become useful.

-- 
MST

