Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05D40BFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhIOGfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhIOGfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631687629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syP9u21I0X13+NfaoXP/B0PHgpOt46v9RYaImlgDpiM=;
        b=crQnyZXy48areDFvC/CHzOq49P4MGB4vzEPSLh/Xlh6zC3oLcQ2XaNRM+bTYrY097f1ff9
        2Ho+2An6hNMnr66PuuNrOzngyfyR0PC5OPev4r3OUJhK5C9uOv/e3WkqQ5ZjhKAat+LkLF
        MGI4ehlSsmFOEm+sbwR6mt9o+Lrr1UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-A7VfICycPX-ZylX37M_ICg-1; Wed, 15 Sep 2021 02:33:48 -0400
X-MC-Unique: A7VfICycPX-ZylX37M_ICg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D18771B18BC6;
        Wed, 15 Sep 2021 06:33:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8843E10016F5;
        Wed, 15 Sep 2021 06:33:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0F6A518003BF; Wed, 15 Sep 2021 08:33:45 +0200 (CEST)
Date:   Wed, 15 Sep 2021 08:33:45 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     bibo mao <maobibo@loongson.cn>
Cc:     Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/qxl: User page size macro for qxl release bo
Message-ID: <20210915063345.yvzulffu6ekycz6p@sirius.home.kraxel.org>
References: <20210914062352.6102-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914062352.6102-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:23:51AM -0400, bibo mao wrote:
> Some architectures have different default page size, this patch
> replaces hardcoded 4096 with PAGE_SIZE macro, since cmd bo size
> is page aligned.
> 
> Signed-off-by: bibo mao <maobibo@loongson.cn>

Pushed to drm-misc-next.

thanks,
  Gerd

