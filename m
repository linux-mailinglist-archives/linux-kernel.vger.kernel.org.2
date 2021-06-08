Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27E39FB33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhFHPyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231287AbhFHPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623167536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIv0KDh8QZknF2yfsLZ50La/P4vovfT4FqAjAjtKP6A=;
        b=PEIAJNDyuotSI9MsU+RxzTbrcsN18Su/2ZHvET8NwgcVw6k3ddPXvGlN/RbgBsr3NDrgO7
        uPce/n9UuREZjgsnc2WJVSEvGgapUAWCdpieTRUL/8+B4q5MCMMAfFPUFb7j15ueboeneR
        4m4vobpvn+9k36whNPShI55qCs3lJO8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-4XiF_hpYPa6mNLB4RKifqQ-1; Tue, 08 Jun 2021 11:52:15 -0400
X-MC-Unique: 4XiF_hpYPa6mNLB4RKifqQ-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020a0560001614b02901115c8f2d89so9548274wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bIv0KDh8QZknF2yfsLZ50La/P4vovfT4FqAjAjtKP6A=;
        b=oaDQFhqWwez2FV84ICw+X4PdiVi1LQh71J68C3DelGskjowK6xJ4aeB6o2WHkyse0A
         0aY3kXkac6v8imzeBQIhRyRJRY/QqAIkvQjNwYBrANuczXrLjYLZPCtAxCV1pJMo+/fF
         6V0nshoM4l8uXQMXnymmeO2h5R/SAPVoz69i9FA+R5bCpR8a3/vJuJDyAq4UFGtpQ3FU
         vu8/QnjQlUARruF+Ic+06tr1RpNiDBf8weOFW9+7iDWByEPx35QzuaCAMGar1slXWZLj
         3z4z8SxGsT6sDFTyiweJ/C81yw4fU8o6yc1UkBXwg4Cy/mj9gAK8GcKW1ZokX7yqW7cK
         cfOA==
X-Gm-Message-State: AOAM531T6sWuJSORrdsb+yyCGAx6ak4SLaGP5XgIpChjvLbZF6tJruVQ
        W2TIj7odRN1C7LNwBPKtzCO5IMZNqQhisFs9MQbE0e60lepIv/6+I7JPYej6EhsI7WCmarZONrV
        /lfsx3you0I+b9rJ4TG+nb0YD
X-Received: by 2002:adf:ee52:: with SMTP id w18mr23400897wro.37.1623167534092;
        Tue, 08 Jun 2021 08:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGhGVn3Cb2eW4Zqx5PDCp746zo6zuoS+wcLV8789c53txINGASFiQvsKhgYVWv1VFD2wW9LA==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr23400884wro.37.1623167533992;
        Tue, 08 Jun 2021 08:52:13 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id n20sm17865769wmk.12.2021.06.08.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:52:13 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] fuse: Some fixes for submounts
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <c3d49438-6ee1-32b1-1be4-41be78cec2ce@redhat.com>
Date:   Tue, 8 Jun 2021 17:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604161156.408496-1-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.21 18:11, Greg Kurz wrote:
> v2:
>
> - add an extra fix (patch 2) : mount is now added to the list before
>    unlocking sb->s_umount
> - set SB_BORN just before unlocking sb->s_umount, just like it would
>    happen when using fc_mount() (Max)
> - don't allocate a FUSE context for the submounts (Max)
> - introduce a dedicated context ops for submounts
> - add a extra cleanup : simplify the code even more with fc_mount()
>
> v1:
>
> While working on adding syncfs() support in FUSE, I've hit some severe
> bugs with submounts (a crash and an infinite loop). The fix for the
> crash is straightforward (patch 1), but the fix for the infinite loop
> is more invasive : as suggested by Miklos, a simple bug fix is applied
> first (patch 2) and the final fix (patch 3) is applied on top.

Thanks a lot for these patches. I’ve had a style nit on patch 6, but 
other than that, looks nice to me.

Max

