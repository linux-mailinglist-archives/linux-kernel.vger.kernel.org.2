Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEC30DCB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhBCO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhBCO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612362326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxfTFr0q8Tf9h3gAFIf04FpqXe2AG8QXR8Ik/VWm3BI=;
        b=AvDsFtacvPgvxY/rJaw2d/pWPvXc9h2yvn01FZGLJjN5IpaIeKzcUMoKX4/6qx59AsUkty
        5duuKoa8qLaNU9je0mtqoN/wkhxJSnS4GtF4SoXHaN00SMNdGKKjKekjnz/VaC7iUx1ncj
        Q1qGnknuFlooj4AttIgLYawn50BqieE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-o1In-4mkPJKDqZcQ64ryKg-1; Wed, 03 Feb 2021 09:25:22 -0500
X-MC-Unique: o1In-4mkPJKDqZcQ64ryKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C661196632D;
        Wed,  3 Feb 2021 14:25:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com [10.36.113.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7FE95B692;
        Wed,  3 Feb 2021 14:25:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0A44A1800853; Wed,  3 Feb 2021 15:25:16 +0100 (CET)
Date:   Wed, 3 Feb 2021 15:25:16 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Colin Xu <colin.xu@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] virtio_input: Prevent EV_MSC/MSC_TIMESTAMP loop storm
 for MT.
Message-ID: <20210203142516.uzinnnkngahqfhdn@sirius.home.kraxel.org>
References: <20210202001923.6227-1-colin.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202001923.6227-1-colin.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> +	/*
> +	 * Since 29cc309d8bf1 (HID: hid-multitouch: forward MSC_TIMESTAMP),
> +	 * EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event.
> +	 * EV_MSC is configured as INPUT_PASS_TO_ALL.
> +	 * In case of touch device:
> +	 *   BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
> +	 *   FE pass EV_MSC/MSC_TIMESTAMP back to BE.
> +	 *   BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
> +	 *   BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
> +	 *   >>> Each new frame becomes larger and larger.
> +	 * Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.
> +	 */
> +	if (vi->idev->mt && type == EV_MSC && code == MSC_TIMESTAMP)
> +		return 0;
> +

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

