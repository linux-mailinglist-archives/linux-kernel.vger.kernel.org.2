Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D7340E13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhCRTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232799AbhCRTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616095191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h/AQCJes2OhjQj1vBXqxm+lLmXZx1n8jlvmzyQwRixg=;
        b=Gp1KiFHoQvEAkyoqmCYt81C/6qQrtSjcf8DdTFgY6gTHZg2Xia+YCXv/MuknPJm6NNdQPX
        5IRHWeK9flan14RvVnJT2PWOMi3HzsYgPpe0eyfT1D9HnICwIrcUtW0xrbjrXmywADpR4Q
        fPgBeNo+zPp+5MbitkKOM29p+VI3njE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-m_J0dhtXM3i35UHSgeHI_g-1; Thu, 18 Mar 2021 15:19:49 -0400
X-MC-Unique: m_J0dhtXM3i35UHSgeHI_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0687B18C8C00;
        Thu, 18 Mar 2021 19:19:48 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 923405C3E6;
        Thu, 18 Mar 2021 19:19:37 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v3 0/2] audit: add documentation for /proc/PID/stable interfaces
Date:   Thu, 18 Mar 2021 15:19:09 -0400
Message-Id: <cover.1616095045.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

