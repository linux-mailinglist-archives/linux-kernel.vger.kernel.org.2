Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CCF3BE693
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhGGKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhGGKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625654824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7edPdrNHVPqSqyOroMx7vyShL9GDo0V28Fe/j1ECYZ0=;
        b=bQCKPbe8fwQSH0UsVCFUJrPQUpno+q2x3CUmgnYiojZXiHsV9QyDh42o3vzvWecL6F9OMS
        f5gUVIYMhoZtekN8c1Cg2HponabJw/NtBPMzv2Y+Xroo0sZ8AAzSHwR5kAeRZjPG5Kg/8F
        hX1eBtEiTmalMd+9McZEqZ8Zhtd2q0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Un2q_0ZHNdClOuGrQQ3S0A-1; Wed, 07 Jul 2021 06:47:01 -0400
X-MC-Unique: Un2q_0ZHNdClOuGrQQ3S0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 096A310C1ADC;
        Wed,  7 Jul 2021 10:47:00 +0000 (UTC)
Received: from T590 (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29BFD51C48;
        Wed,  7 Jul 2021 10:46:53 +0000 (UTC)
Date:   Wed, 7 Jul 2021 18:46:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: fix the problem of io_ticks becoming smaller
Message-ID: <YOWGGsaKqmLnIiVt@T590>
References: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 05:47:26AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> On the IO submission path, blk_account_io_start() may interrupt
> the system interruption. When the interruption returns, the value
> of part->stamp may have been updated by other cores, so the time
> value collected before the interruption may be less than part->
> stamp. So when this happens, we should do nothing to make io_ticks
> more accurate? For kernels less than 5.0, this may cause io_ticks
> to become smaller, which in turn may cause abnormal ioutil values.

Just be curious, is there any user visible difference with this change?

It can only be one issue if the stamp update crosses two jiffies, but
this event should be very unlikely, right?

Thanks, 
Ming

