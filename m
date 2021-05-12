Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97D837D138
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349290AbhELRud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236708AbhELQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620836340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eXgmmM3U8BNR0qHLEtVzxEaCYV9vF5/0DUg+7Z1mLsg=;
        b=IWALeyDk8Wp9Ztydk9nFCiqbPLbelr5iBcX6Dfjxl8rTvA4xGxPd67fL/lYy2Yo0r3LWcQ
        OBfbpXcgc7Nxfj31MFt7T8ZjmRFs5scDc44tsoN/KCYhAS/S+oyqF50Kgr94z2zS+dP+Aa
        jlz7NE+qG8auAQrVK848XR35LNv6kO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ga1jgivFPei-qFjXhqkaJg-1; Wed, 12 May 2021 12:18:56 -0400
X-MC-Unique: ga1jgivFPei-qFjXhqkaJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D48801817;
        Wed, 12 May 2021 16:18:55 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-114-114.ams2.redhat.com [10.36.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99EFB6D8C1;
        Wed, 12 May 2021 16:18:50 +0000 (UTC)
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com, synarete@gmail.com
Subject: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Date:   Wed, 12 May 2021 17:18:47 +0100
Message-Id: <20210512161848.3513818-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:

 - Cleans up the commit message.

 - As the patch itself is unchanged from v3, I did not retest it.


