Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE9428BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhJKLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235971AbhJKLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633950435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OYW9/l76zllNwbIVo2AXv5AVz/8E4gYo8/702/khx+8=;
        b=DFctyrV+OCZ2izxL34tqRUT0zU+66n/65fag74b/3Z7v6NS98gVmA1slMbyZ/PE7lV1s9e
        KOPt03FtJYISVwBifxSwo4pi1QycgUWoXnNqO14BTRluMWp80uqSGqV+iuoAH+qHsY1PIV
        q7+VWI8GGq8QiQS2Bcl/Ikz0aYB3bCo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-GZlvzyPgPGieZmbPPXxseg-1; Mon, 11 Oct 2021 07:07:14 -0400
X-MC-Unique: GZlvzyPgPGieZmbPPXxseg-1
Received: by mail-ed1-f72.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so1308293edv.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OYW9/l76zllNwbIVo2AXv5AVz/8E4gYo8/702/khx+8=;
        b=B0+dX7fvX7oQU/uqKpDtfauOZ62esO6ZYQTbin33Z5ITYm8v6a72E/yiOWaLirOWVi
         aImXQwABNoqrv6ZMPBmrb0khc0Z+7eE+eCirK6OK+gmZLm4KuGdUJJIQ2A2KWJOglqRY
         VmdGqLsrXYRG2jEUiuyjVv8F6e5+fgYIaPZkDsTL3N/JUpfV2Jc6CD1yzpQW5R4Sw2av
         viEaceLfC4tWwE5a+xDr3TWTRLM7IjKbppuLqjKK0E2DDyORzqAe/S/07wle+M51VddZ
         x5f92i7ZVFnP98kyJEMH77Xpc4mP/E2yoczO3Gq5BTi6tvme/xn9rD7Ma+epzMKRQpk0
         Q7TA==
X-Gm-Message-State: AOAM5314h0y71ozgkLy6m9BoC93NuLNOjyGSTcjXuj/JIru0SSWxpTiD
        NE+vGBRYCDGHee7XYLskJpP3O626xod7EggoY//kc/w6wX7vGU4XZnqkbgg9jEsnjqYDqeJtJj2
        Wk8L5eU19tyv2qoIu5wO6I/c/llz82A2cbCQeIyL5dLqJmeLknYsl9ViyibA8maSNpjCftg==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr24754353ejb.139.1633950432885;
        Mon, 11 Oct 2021 04:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRd7ybl6R+Wz3o2aR7ydHhBFdbsDoO0HZkCsfRjWAJ2v0hjYASUSC5SoLdNQbGsN7kfSxR7A==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr24754326ejb.139.1633950432619;
        Mon, 11 Oct 2021 04:07:12 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id u4sm3332690ejc.19.2021.10.11.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 04:07:12 -0700 (PDT)
Date:   Mon, 11 Oct 2021 07:07:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: data dependency naming inconsistency
Message-ID: <20211011064233-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul, all!
I've been reading with interest Paul's posts about Rust interactions with LKMM
https://paulmck.livejournal.com/63316.html
and in particular it states:
		A data dependency involves a load whose return value directly or
	indirectly determine the value stored by a later store, which results in
	the load being ordered before the store.

This matches the perf book:
	A data dependency occurs when the value returned by
	a load instruction is used to compute the data stored by
	a later store instruction.

however, memory-barriers.txt states:

     A data dependency barrier is a partial ordering on interdependent loads
     only; it is not required to have any effect on stores, independent loads
     or overlapping loads.

It also says:
	A data-dependency barrier is not required to order dependent writes
	because the CPUs that the Linux kernel supports don't do writes
	until they are certain (1) that the write will actually happen, (2)
	of the location of the write, and (3) of the value to be written.

so the result it the same: writes are ordered without a barrier,
reads are ordered by a barrier.

However, it would seem that a bit more consistency in naming won't
hurt.

Thanks,

-- 
MST

