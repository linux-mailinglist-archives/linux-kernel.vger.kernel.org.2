Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F44411AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 01:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhKAAeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 20:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229982AbhKAAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 20:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635726704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9SQXApe41CIAZ3ih9wcWp+4OzSeZnwb2LUmrVkWeZ14=;
        b=ZMR0N5dcB8Pd9S8BIEEjyHZwbf7oqzbXHrWQM5hcRnELog8ZtErzpG829OokUU3Hpy1u0E
        Fgeh9RfhgoqZE5quM1i9mJzMXppD8Fa0k12AlyTLob12WLWA/KdcI9PJTHvBmnyffZDDXo
        Y4nbigIJH6cTmoHMjnlZ3o7fm7ewlOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-yuBqfpSeOb2aRhLcfq3I1g-1; Sun, 31 Oct 2021 20:31:42 -0400
X-MC-Unique: yuBqfpSeOb2aRhLcfq3I1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F53136301;
        Mon,  1 Nov 2021 00:31:41 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11C3C5C1C5;
        Mon,  1 Nov 2021 00:31:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] livepatch: cleanup kpl_patch kobject release
Date:   Mon,  1 Nov 2021 08:31:29 +0800
Message-Id: <20211101003132.3336497-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The 1st patch moves module_put() to release handler of klp_patch
kobject.

The 2nd patch changes to free klp_patch and other kobjects without
klp_mutex.

The 3rd patch switches to synchronous kobject release for klp_patch.


V2:
	- remove enabled attribute before deleting this klp_patch kobject,
	for avoiding deadlock in deleting me


Ming Lei (3):
  livepatch: remove 'struct completion finish' from klp_patch
  livepatch: free klp_patch object without holding klp_mutex
  livepatch: free klp_patch object synchronously

 include/linux/livepatch.h     |  2 --
 kernel/livepatch/core.c       | 67 ++++++++++++++++-------------------
 kernel/livepatch/core.h       |  3 +-
 kernel/livepatch/transition.c | 23 ++++++++----
 kernel/livepatch/transition.h |  2 +-
 5 files changed, 50 insertions(+), 47 deletions(-)

-- 
2.31.1

