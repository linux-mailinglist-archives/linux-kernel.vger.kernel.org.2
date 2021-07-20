Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB23D024F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhGTTIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 15:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhGTTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626810475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U272znx2AfMZKI+Uhn1CK8uwYCSuVHYdjjqWpT9zrL4=;
        b=LdxPKiqkbUYtaXuaZohWVvkK1DXxHIzngZevudGamjcIO9z2zcAXasJReTT0Isfb/nGbgn
        0PNF4WWz0H+zbVm4xyi+vSqBdlHpoluDdF33T/hMY1lrXoS27gju/2RtXXFIyFtYjQpuTr
        ZSzcbnq0cFc96YVzjVOmmFSjGbKa09E=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-6DsWH5CKMUmhzDXA1JtXIA-1; Tue, 20 Jul 2021 15:47:54 -0400
X-MC-Unique: 6DsWH5CKMUmhzDXA1JtXIA-1
Received: by mail-oi1-f198.google.com with SMTP id 64-20020aca06430000b0290240ce72dd5eso241778oig.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U272znx2AfMZKI+Uhn1CK8uwYCSuVHYdjjqWpT9zrL4=;
        b=ZQzDdPVqOlEiQwWtF6cYFvJ6ovIFrsq6+w7AWZe4rPRoUR+18CtUKW1Pt3AiItba95
         HA2l8/8zp8jwYWTc2qe0MAC3/ouR1iP+6qmiSnlZwvMDivMvlEWE0u+8MW8BRVeVdZWP
         hpFE8JLmOmx/0jGiduVaPM/hX2kA03vguFL/tSIDMB8Uik3bm1wPrHLKoWueNa5vdUt0
         SOhifIWqmn/8nihKjOb3Zm9Gmu/YqaWDbOrKBlQrJ2PfDY/IGvRoQ5YJA1Kd6zx9UQfG
         Qy6F3WApHrmpdiAGE23L2JZozAF9AGjXv2JsSwAExEySfLOOcUZSvmHc35HgWkLTYrbb
         H9+A==
X-Gm-Message-State: AOAM530CaxgzOTf2TPFKJtZtJsDr6Jsmm9uecIvvclBzIJNLmaHr/M47
        eDaC5soDjm6h7aS/AFrMPsXkVdnDPLZILsiVQIMTKW4SiixT0cuTWqMvXP0qAjhkLMPUh41Cpgh
        qlqBx5Gsf3GvZ8nz1tqbvb3sALg/Zl8pn4Q3zwVodok0CtOvvPp0dR6Up2kZkh+kxDUJlj3w=
X-Received: by 2002:a9d:190:: with SMTP id e16mr21172684ote.137.1626810473881;
        Tue, 20 Jul 2021 12:47:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7HSO7FKjrPvQVrYMWCgiQ6o3xJ04g/3KtAN5rcdjFx2z98r20sgKQO/TtU2hqy+4fJj+6qg==
X-Received: by 2002:a9d:190:: with SMTP id e16mr21172666ote.137.1626810473659;
        Tue, 20 Jul 2021 12:47:53 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v4sm4164937ooa.2.2021.07.20.12.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 12:47:53 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] fpga: fpga-mgr: move compat_id from fpga_mgr to
 dfl
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210709134229.2510349-1-trix@redhat.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f0ffd1b2-43a6-5b69-7d67-229b3d68b5a2@redhat.com>
Date:   Tue, 20 Jul 2021 12:47:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709134229.2510349-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/21 6:42 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> A followup to
> https://lore.kernel.org/linux-fpga/aa06a7ca-eff3-5c0d-f3b0-f1d9ddb74526@redhat.com/
> The current storing of compat_id in fpga_manager is dfl specific.
> This makes the refactoring of the release()'s complicated because there
> is a dfl specific flavor of register().
>
> Keeping the compat_id sysfs abi, each implementation through the new
> compat_id_show() fpga_region op can print out whatever value they need
> to the sysfs.  Currently only dfl does.
>
> Since there are now two ops for fpga_region, give fpga_region its
> own ops table.  Add a wrapper for get_bridges().
>
> Changes from
> v1
>    Completely written to keep sysfs abi

Moritz and Hao,

Can you comment on v2 ?

The compat_id abi is unchanged, so dfl's opae userspace access will not 
change.

For ever other board, the nonuse error is the same.

Otherwise, the new region ops is consistent with manger ops.

I can split this first patch out if the refactor of compat_id is 
contentious .

Tom

>
> Tom Rix (4):
>    fpga: region: introduce fpga_region_ops
>    fpga: region: introduce compat_id_show op
>    fpga: dfl: implement the compat_id_show region op
>    fpga: remove compat_id from fpga_manager and fpga_region
>
>   Documentation/driver-api/fpga/fpga-region.rst |  6 ++-
>   drivers/fpga/dfl-fme-mgr.c                    | 23 ++++++-----
>   drivers/fpga/dfl-fme-pr.c                     |  2 +-
>   drivers/fpga/dfl-fme-region.c                 | 21 +++++++++-
>   drivers/fpga/dfl.h                            | 14 +++++++
>   drivers/fpga/fpga-region.c                    | 40 ++++++++++---------
>   drivers/fpga/of-fpga-region.c                 |  6 ++-
>   include/linux/fpga/fpga-mgr.h                 | 13 ------
>   include/linux/fpga/fpga-region.h              | 26 +++++++++---
>   9 files changed, 99 insertions(+), 52 deletions(-)
>

