Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9534CCD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhC2JRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235556AbhC2JQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617009417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NsTc/rI6/f3S2ghXI9Jzm7PWhr+5ThOqryu9f5h0Vn4=;
        b=MqebJ3RnmgaAkkrqb1AtHrAvFbHH/1NeTZgDSwRkv9HST6EYL59z91zKgZglqHeAZ84C+Q
        IErHLrrDQD13wyxgfSFhKfxZuCWRKW1mCptqdyAwiHSWUpvHqF6R6O2bsUiIhnBAet37GN
        MryhLW5V5jMvJfv2i8JkWB8hRqqn2Ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-yjKmxqHONWOAaE4qGGHfHg-1; Mon, 29 Mar 2021 05:16:53 -0400
X-MC-Unique: yjKmxqHONWOAaE4qGGHfHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08744801814;
        Mon, 29 Mar 2021 09:16:52 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D94496E707;
        Mon, 29 Mar 2021 09:16:49 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:16:48 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an
 error when TAI has not been configured
Message-ID: <YGGbAIoCKDbZLQQ0@localhost>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
 <20210327032859.GA3168@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327032859.GA3168@hoboy.vegasvil.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 08:28:59PM -0700, Richard Cochran wrote:
> Using ntpd on Debian, the service will set the offset, but only after
> synchronization with the upstream server has been established, and
> this takes about five minutes, IIRC.

With the iburst option it shouldn't take more than 10 seconds. There
might be an issue wrt stepping the clock when the initial offset is
large. In Fedora and derived distros using chrony by default the
TAI-UTC offset should be set right on the first update of the clock as
expected.

> Getting back to the original point of the kernel returning an error,
> I don't see a need for this.  Applications that require correct leap
> seconds can simply call adjtimex() and wait until the initial zero
> value is changed by ntpd/etc to the correct offset.  That isn't
> fundamentally harder than calling clock_gettime() and waiting until
> the error would go away.

There are at least two issues with handling a zero offset as a special
value. One is that zero could potentially be a valid value in distant
future. The other is that the kernel updates the offset when a leap
second is inserted/deleted even if the original offset is zero, so
checking for zero (in the kernel or an application) works only until
the first leap second after boot.

The kernel would need to set a flag that the offset was set. Returning
an error in clock_gettime() until the offset is set sounds reasonable
to me, but I have no idea how many of the existing applications it
would break.

-- 
Miroslav Lichvar

