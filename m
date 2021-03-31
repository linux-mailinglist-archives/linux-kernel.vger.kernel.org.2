Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9422350115
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbhCaNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235630AbhCaNSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617196720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3QlNgUSfvr+/PpIlu1o+sRHvXrLP4b4ywJIkeHRotY=;
        b=g+/6XEGauG6AfkBL5X/qquvu9NlirX3KaeVJFVr9pBtxHelsdQaa4yoyjKEFLMBjlUy3Ng
        KvJOKoHm/C9s6HGbrvYnZVpFgvn7XjuvB3vNLcPj8MvXvm3m9+bkiz4VFSX+hqqrBY+jrF
        x+KrECbETDAc/aJpiBpswyCgyk/Cbq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-FQq3UjclNSeViSGtS0T6pA-1; Wed, 31 Mar 2021 09:18:36 -0400
X-MC-Unique: FQq3UjclNSeViSGtS0T6pA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48CBF189CD01;
        Wed, 31 Mar 2021 13:18:35 +0000 (UTC)
Received: from ovpn-115-15.ams2.redhat.com (ovpn-115-15.ams2.redhat.com [10.36.115.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC63C100164A;
        Wed, 31 Mar 2021 13:18:33 +0000 (UTC)
Message-ID: <2007f97354178599db29b71b3e359168606847f9.camel@redhat.com>
Subject: Re: [PATCH] udp: Add support for getsockopt(..., ..., UDP_GRO, ...,
 ...)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Norman Maurer <norman.maurer@googlemail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dsahern@kernel.org, davem@davemloft.net
Date:   Wed, 31 Mar 2021 15:18:32 +0200
In-Reply-To: <71BBD1B0-FA0A-493D-A1D2-40E7304B0A35@googlemail.com>
References: <20210325195614.800687-1-norman_maurer@apple.com>
         <8eadc07055ac1c99bbc55ea10c7b98acc36dde55.camel@redhat.com>
         <CF78DCAD-6F2C-46C4-9FF1-61DF66183C76@apple.com>
         <2e667826f183fbef101a62f0ad8ccb4ed253cb75.camel@redhat.com>
         <71BBD1B0-FA0A-493D-A1D2-40E7304B0A35@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-31 at 15:10 +0200, Norman Maurer wrote:
> As this missing change was most likely an oversight in the original
> commit I do think it should go into 5.12 and subsequently stable as
> well. That’s also the reason why I didn’t send a v2 and changed the
> commit message / subject for the patch. For me it clearly is a bug
> and not a new feature.

I have no strong opinion against that (sorry, I hoped that was clear in
my reply).

Please go ahead.

Thanks,

Paolo

