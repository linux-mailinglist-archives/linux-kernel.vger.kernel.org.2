Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719023D4052
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhGWRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 13:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhGWRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627065226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDfl7lnPQWkblwQK8pYBwCbgesEBTz4liDN9cx6q6Ac=;
        b=M0OS1FsH1bJ2B0/vVTb1P8LwAoID5LWnV7AqgCsqw7B2jM9Kh4vtzPs6SIuBEqrdwC1UyZ
        errxLVFA1NqDigAbJN7qxwDnm3Q+QOh3uN2QRp2FL0lNERDQgfv1jMat/y96ePP799mN85
        ZMenDyxEnn9oeNQPLJv2SfsaoCdh1ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-EAAxFMj5MoChXwhbfNV9ug-1; Fri, 23 Jul 2021 14:33:44 -0400
X-MC-Unique: EAAxFMj5MoChXwhbfNV9ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA71DC73B6;
        Fri, 23 Jul 2021 18:33:43 +0000 (UTC)
Received: from xps13k.happyassassin.net (ovpn-112-93.phx2.redhat.com [10.3.112.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 985F45F705;
        Fri, 23 Jul 2021 18:33:43 +0000 (UTC)
From:   Adam Williamson <awilliam@redhat.com>
To:     guro@fb.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback, cgroup: remove wb from offline list before releasing refcnt
Date:   Fri, 23 Jul 2021 11:33:43 -0700
Message-Id: <20210723183343.10017-1-awilliam@redhat.com>
In-Reply-To: <20210716201039.3762203-1-guro@fb.com>
References: <20210716201039.3762203-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks! I'm not subscribed to the list and am trying to send this
using git-send-email, apologies for any weirdness related to that.

Just wanted to confirm the issue that this patch attempts to address,
and ask if it can be reviewed/moved along. I look after Fedora's
openQA automated test instance, and in tests of recent Fedora Rawhide
composes, we're seeing at least one failure per compose that's caused
by this crash (it usually prevents the system shutting down or
rebooting correctly in a test which requires that to happen).

I can't actually confirm the fix as I can't really easily change our
tests to run on a non-official kernel build, and our kernel maintainer
(reasonably) says he won't backport the patch until it's at least got
some review. But I'm definitely seeing the problem!

Thanks folks.
-- 
Adam Williamson
Fedora QA
IRC: adamw | Twitter: adamw_ha
https://www.happyassassin.net

