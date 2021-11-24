Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E431745B713
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhKXJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:06:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhKXJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637744576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xj+SVTomCLBOOrboUFjfohYcMlXl1QtzQCGEYpEgCf8=;
        b=EyvhRPbnXPicpkVMuZqnWT5hefdCQ/b2NAErKHd+b59R6bYJS8g9fAdMaM4mV8FKBSV0nd
        dobF9TDldMaAlLQIrOGlhETpyAlkg7ptwWAfGk9gSjDsjaY1oIvsSHFk2Yap3AdzSSwE5Q
        zz9nAe4EINoJjdNxjQwRocP7vK1ktjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-40VEyjX4OJyQltk55285Zw-1; Wed, 24 Nov 2021 04:02:53 -0500
X-MC-Unique: 40VEyjX4OJyQltk55285Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81AC100F955;
        Wed, 24 Nov 2021 09:02:50 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 225F872434;
        Wed, 24 Nov 2021 09:02:29 +0000 (UTC)
Date:   Wed, 24 Nov 2021 17:02:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Message-ID: <20211124090227.GA8026@MiWiFi-R3L-srv>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/18/21 at 12:49pm, Eric DeVolder wrote:
......
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, which reflects the current CPUs and memory regions, into a
> buffer. Since purgatory also does an integrity check via hash digests
> of the loaded segments, purgatory must also be updated with the new

When I tried to address this with a draft patch, I started with a
different way in which udev rule triggers reloading and only elfcorehdr
segment is updated. The update should be less time consuming. Seems
internal notifier is better in your way. But I didn't update purgatory
since I just skipped the elfcorehdr part when calculate the digest of
segments. The reason from my mind is kernel text, initrd must contribute
most part of the digest, elfcorehdr is much less, and it will simplify
code change more. Doing so let us have no need to touch purgatory at
all. What do you think?

Still reviewing.

> digests. The arch handler also generates a new purgatory into a
> buffer, performs the hash digests of the new memory segments, and then
> patches purgatory with the new digests.  If all succeeds, then the
> elfcorehdr and purgatory buffers over write the existing buffers and
> the new kdump image is live and ready to go. No involvement with
> userspace at all.

