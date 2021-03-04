Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C732D3BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhCDM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233695AbhCDM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614862537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s0kXbQg2wgR1vQBkU7ppKhdyoHWgrq2jtnZhL0jn5Os=;
        b=WrF+0F4/jWp7EC0RxWsCES5/KvU5yVyJgJNO1q7khW0Z9mX/Nu0qqJpO36igev/z6I2TuB
        dpsAfRXy6lCIDjbGWeAoUn7Ayu569oqsTUAefXzEhvVYIngQWIpC7S4Md+EigUg9TJkiyS
        6D5i+RC1ITqilpM6WEGSst1CZ2c+hyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-jXDSx_5WNwyJ9muHwiblSQ-1; Thu, 04 Mar 2021 07:55:35 -0500
X-MC-Unique: jXDSx_5WNwyJ9muHwiblSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 116641009E29;
        Thu,  4 Mar 2021 12:55:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-129.ams2.redhat.com [10.36.115.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53CAD16922;
        Thu,  4 Mar 2021 12:55:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 89DCC18000A7; Thu,  4 Mar 2021 13:55:31 +0100 (CET)
Date:   Thu, 4 Mar 2021 13:55:31 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: drm/ttm: ttm_bo_release called without lock
Message-ID: <20210304125531.r4bf36gt32rxtm3k@sirius.home.kraxel.org>
References: <YD+eYcMMcdlXB8PY@alley>
 <YD+mGFJ5KYWwrJHH@alley>
 <a53377ae-9b33-9030-f9a6-0b620a9cc71f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53377ae-9b33-9030-f9a6-0b620a9cc71f@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 08:42:55AM +0100, Thomas Zimmermann wrote:
> (cc'ing Gerd)
> 
> This might be related to the recent clean-up patches for the BO handling in
> qxl.

Yes, it is.  Fixed in drm-misc-next, cherry-picked into drm-misc-fixes,
hopefully lands in -rc2.

take care,
  Gerd

