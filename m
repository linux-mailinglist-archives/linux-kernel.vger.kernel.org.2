Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667C03379B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCKQlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhCKQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h/AQCJes2OhjQj1vBXqxm+lLmXZx1n8jlvmzyQwRixg=;
        b=hlj1ayZwV4bMO/29b1KImWDSm9DCxZoxQhEC8yKzaCnyZ83bD7b4YiEW9I7NZ6abtf4tgj
        NmtrPpDJUxDD6WoQIW+w2A9pooDu0a30XPCiE8JZtfXjwzz3dywfou8AqpCP3MnY0JK7J+
        bNKPUd2laspwqwGWmtme3ovAtRy1yeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-J9duph3xN9uEi0b5uAjhhA-1; Thu, 11 Mar 2021 11:41:22 -0500
X-MC-Unique: J9duph3xN9uEi0b5uAjhhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C68D18D6A2A;
        Thu, 11 Mar 2021 16:41:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0228B10013D6;
        Thu, 11 Mar 2021 16:41:19 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH 0/2] audit: add documentation for /proc/PID/stable interfaces
Date:   Thu, 11 Mar 2021 11:40:49 -0500
Message-Id: <cover.1615414262.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation/ABI entries for audit interfaces in /proc/PID/ that have
been stable for more than a decade.

Richard Guy Briggs (2):
  audit: document /proc/PID/loginuid
  audit: document /proc/PID/sessionid

 .../ABI/stable/procfs-audit_loginuid          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid

-- 
2.27.0

