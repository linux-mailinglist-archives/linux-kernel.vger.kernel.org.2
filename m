Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F663B4563
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFYOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFYOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:20:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A7FC061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:18:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg14so15333766ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7odR4aMn5lHoU/Eflc4EvN4jyzHUqkEXilkSBCcXS0=;
        b=tNNV+jdgQMXQTyxqq4B42g/wE2Zvlyw8LJRd8d8glsVfoOHx1vNtoUWaZgR01f7FU0
         XVbQ1JdTiK0YF93GtIND56AxTsmLdzwXp2hlSTnW4dlPl94/Oo3LJgv83hs7xA/SFlaG
         rwC0KxO84uz14hsi5lMmoiOgI0BKKAQu+o/u+yCaa/cFYeWiBE+7RlVLhkhzZMfgCn0M
         +QrF07NpMqJbwdcHvjBc7VtEoxBt+tS+vfRrRZGF2F/TPlOUWl9l7IwYw3hcDL+eUqvb
         dIyMp7DOD5F/LcEtPLppzc88ejmr4bRyiqYccDwFn7ko+XzGWd7fMKGzVX7un4khSDeR
         jEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7odR4aMn5lHoU/Eflc4EvN4jyzHUqkEXilkSBCcXS0=;
        b=OhBk7arf2wkrPLtjcjYuAS/iD12WboIryO6T7DuUD3PunMyMU5j9nEla+t+vu2dFra
         lkB3rtSPsa+akUVMss9hcSVISYyVHnoM0/KU+9VIpBpwC0Dy52fpSMyfAAi7uF4I+iH4
         3pZxDI0RZvH+aa/drx6GUoYp8oTgrxgfC4ZO6/51eA/6vcXjT0CsWWjaiDW+h3Lxv4AF
         hYXrsrIEk/ZrRAnzmbEaLvWug2jx4itCZJTAHeACBV3ipAJ5WsROmGCxo/7hYljsMdSd
         38TX+knH7iJyUSGV+kJXqnUF4PPIPw70rHYYQbZhGlMKSyr8V9prnq9xNHXA0JjBfxWI
         xQqA==
X-Gm-Message-State: AOAM532uJ5NLA5QoIG/FWyoxQkpVCmtt2nNrD6EoSEHY9OGkp69Tc/c7
        k5wUi8uEcs6C36jAOwUdOXS9nXv1r2sOf/WdXH0=
X-Google-Smtp-Source: ABdhPJxYzkQQM5eSqsayekfeaI3QKu0VxAN0Yv/9gIIBoVNwKStbQCtKVVWGpGQIcIejqm+weh+e8pAJg9dE1VRMXJs=
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr10939369ejb.139.1624630698528;
 Fri, 25 Jun 2021 07:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210625042150.46964-1-gshan@redhat.com>
In-Reply-To: <20210625042150.46964-1-gshan@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 25 Jun 2021 07:18:07 -0700
Message-ID: <CAKgT0UdVjW_kfeARo3Vsf6fZGPv4r_DEN7+NVp8PN4figkrJmA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mm/page_reporting: Make page reporting work on
 arm64 with 64KB page size
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 7:20 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The page reporting threshold is currently equal to @pageblock_order, which
> is 13 and 512MB on arm64 with 64KB base page size selected. The page
> reporting won't be triggered if the freeing page can't come up with a free
> area like that huge. The condition is hard to be met, especially when the
> system memory becomes fragmented.
>
> This series intends to solve the issue by having page reporting threshold
> as 5 (2MB) on arm64 with 64KB base page size. The patches are organized as:
>
>    PATCH[1/4] Fix some coding style in __page_reporting_request().
>    PATCH[2/4] Represents page reporting order with variable so that it can
>               be exported as module parameter.
>    PATCH[3/4] Allows the device driver (e.g. virtio_balloon) to specify
>               the page reporting order when the device info is registered.
>    PATCH[4/4] Specifies the page reporting order to 5, corresponding to
>               2MB in size on ARM64 when 64KB base page size is used.
>
> Changelog
> =========
> v5:
>    * Restore @page_reporting_order to @pageblock_order when
>      device is registered in PATCH[2/4] to keep "git bisect"
>      friendly at least.                                           (Alex)

These latest changes address the concerns I had.

Thanks.

- Alex
