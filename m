Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C293BDADD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGFQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhGFQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625587466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHH/oZBSEYzJ5dyIC9S2CdtpksJma2DfofpQno8gxZk=;
        b=WbpPyt9CM5u5oO/zTUy41V1TxOPqmn/7QgyMHmDhhE12JCUrXHavGNjOP8KDPpknqRm+S1
        rPuEfAdS+vabKnVpvXgAoamAwR+bfXbImJ2QVFuaNXosdIKJYcz8pFhqwiBzG9dfPSqIzf
        CjscRVrL4RGD7+CoBp6+lvTwWn0/DCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399--MJiH0E0MAOlwYN5LIgkVA-1; Tue, 06 Jul 2021 12:04:25 -0400
X-MC-Unique: -MJiH0E0MAOlwYN5LIgkVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F4688018A7;
        Tue,  6 Jul 2021 16:04:23 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0C3360583;
        Tue,  6 Jul 2021 16:04:22 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] s390/ccwgroup: Drop if with an always false
 condition
In-Reply-To: <20210706154803.1631813-3-u.kleine-koenig@pengutronix.de>
Organization: Red Hat GmbH
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-3-u.kleine-koenig@pengutronix.de>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 06 Jul 2021 18:04:21 +0200
Message-ID: <87wnq3fmyi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06 2021, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 wrote:

> The driver core only calls a bus remove callback when there is a driver.
> So dev->driver is never NULL and the check can safely be removed.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/s390/cio/ccwgroup.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

