Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9045744E693
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhKLMrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234881AbhKLMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636721049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cn6bbn2ANAWza2u9K/aJt1naUeSawS3Xl4pis3JzZmU=;
        b=XCWH7Aw1oe4LfQCMFIZoCv2Iu9hxjpX3nd6W+0Fv3h7hzaqwSk9aBOYB/UgT7SEve1hL1c
        MH5lxKmjdqOb0Yi2ExG8URgj3Lhv1f0QCV+xksIhnYYo0LHuYiovScJS58Sb2i9HmAhP8E
        skrNJwAt+dit3z/U32NvoVq8c00Ly7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-t60lokJMNhy7smgbNlnJJg-1; Fri, 12 Nov 2021 07:44:06 -0500
X-MC-Unique: t60lokJMNhy7smgbNlnJJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CF2B804143;
        Fri, 12 Nov 2021 12:44:04 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D9AB5D6D7;
        Fri, 12 Nov 2021 12:44:04 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 691D84380F03; Fri, 12 Nov 2021 09:43:37 -0300 (-03)
Date:   Fri, 12 Nov 2021 09:43:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v6 00/10] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <20211112124337.GA80444@fuller.cnet>
References: <20211112121642.693790927@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112121642.693790927@fedora.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 09:16:42AM -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:

quilt mail corrupted the patch changelogs, resending -v7.

