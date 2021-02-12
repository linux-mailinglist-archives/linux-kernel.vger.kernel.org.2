Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5366F31A26F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhBLQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhBLQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613146399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5Nb2hpHuSmEncyB7k8Kpd8+QlfZitjO1fAJZA9q6Ek=;
        b=c04pVCzCWxuAj4I8knnl2Fc94M4gxl+vhFqM+4N8r4Cm0A/BpGqOXwXqNEVxtHAYhVZb7T
        OobeeyS2WarBEiKts6MoyUTrSQytJ2ObQDHpnw+Uua1ooCDVEHs1vrNFB5V3bvaw97KC3R
        EYk0c8+lQt+x/A/VxwJcUl0fttwz2rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-2ly9sgg-M8a8-Mt3Amhy4g-1; Fri, 12 Feb 2021 11:13:14 -0500
X-MC-Unique: 2ly9sgg-M8a8-Mt3Amhy4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 271E51934100;
        Fri, 12 Feb 2021 16:13:12 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0204360BF1;
        Fri, 12 Feb 2021 16:13:05 +0000 (UTC)
Date:   Fri, 12 Feb 2021 11:13:05 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien.LeMoal@wdc.com, hare@suse.de, ming.lei@redhat.com,
        agk@redhat.com, corbet@lwn.net, axboe@kernel.dk, jack@suse.cz,
        johannes.thumshirn@wdc.com, gregkh@linuxfoundation.org,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH v5 4/6] dm: new ioctl DM_DEV_REMAP_CMD
Message-ID: <20210212161305.GB19424@redhat.com>
References: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
 <1612881028-7878-5-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612881028-7878-5-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09 2021 at  9:30am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> New ioctl DM_DEV_REMAP_CMD allow to remap bio requests
> from regular block device to dm device.

I really dislike the (ab)use of "REMAP" for this. DM is and always has
been about remapping IO.  Would prefer DM_DEV_INTERPOSE_CMD

Similarly, all places documenting "remap" or variables with "remap"
changed to "interpose".

Also, any chance you'd be open to putting all these interposer specific
changes in dm-interposer.[ch] ?
(the various internal structs for DM core _should_ be available via dm-core.h)

Mike

